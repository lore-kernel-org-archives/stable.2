Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA038D401;
	Fri, 12 Jun 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267178; cv=none; b=gmPObTLss2dbziU4dNUxRKU237W96n0CIW5mJS2G4C4ivswV6FpU1GXsZsA+bK6e/A7hPa4BAc8DKxkvSj8a39VNYkQMr3OGjJa8B2pmgXil1C2qmNtk3xWl+i3zJ8OAUU3GXrp4njm5QQQN5eKPC16KgnQlyeccC1hEb/8h3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267178; c=relaxed/simple;
	bh=hgtOZ8lYZtFq+NHOsMNMTyTdOQVZUSuvYG0eSd+mVb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OS/45ymLxxPJTMJ2/K/xXrsORQLWAdm50CE0EtvxJ3//cXwTri50OS2w00uDUbTE9glCKbH3Qv23fpK5HfPwpmGzvCix2fK+hq0sixKppTAGq6Xhf/uf4j+SNqOkc1+A2SCxTIgRlQ+jlT9GpBhY6lo0hxew6Wz01YRGWdA4orQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=M6QcHuzF; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="M6QcHuzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me;
	s=protonmail; t=1781267165; x=1781526365;
	bh=5CkDE/i7eq2wBiCJ3Txx9dUxykLNkoLdpbgIzBTZve8=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M6QcHuzFDXVFVyUL8aZ77j/hVhkJyFDM5zS1S4SKi8iPzsaxRGzdMC+jjhyrOEIHu
	 oH3n7e8KJKgKS2KpnCLj7UxmgwRTiORpt9zrcDwsO+AHpPwkSdUgrOEMTaDIWTjbrQ
	 49N6mcBN50S9jzI5L2gvHm4xwaO6f/nrlhGvv6dBxNe1vczSC7wgcXqvQu9i0kd/Fu
	 lnV09+eJdzYPWhttIFGgxAu3CDwczx0CsvjFawDEw0WH/DNcNWgQ2TomJYhYk/KUGO
	 Jh+XRTS1+wbbhziAD6uNYUgfWzfnHbZIh5sImpGwpacjtZRQHReldCFzpPvg6mMc80
	 9qcKFCmxNrK4A==
X-Pm-Submission-Id: 4gcJdk4VgVz1DDrT
From: Rafael Beims <rafael@beims.me>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy scans after multiple roam iterations
Date: Fri, 12 Jun 2026 09:25:46 -0300
Message-ID: <20260612122547.1586872-2-rafael@beims.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Beims <rafael.beims@toradex.com>

In order for the firmware to sleep, the driver has to confirm a
previously received sleep request. The normal sequence of evets goes
like this:
EVENT_SLEEP -> adapter->ps_state = PS_STATE_PRE_SLEEP -> sleep-confirm
-> SLEEP -> EVENT_AWAKE -> AWAKE.
Before sending the sleep-confirm command, the driver must make sure
there are no commands either running or waiting to be completed.

mwifiex_ret_802_11_associate() unconditionally sets
ps_state = PS_STATE_AWAKE when it processes the association command
response, outside of the normal powersave management flow. If
EVENT_SLEEP arrives while the association command is in flight,
ps_state is PRE_SLEEP when the association command response is parsed,
and the forced AWAKE overwrites it. The deferred sleep-confirm is
never sent.

A subsequent scan_start command is correctly acknowledged, but the
firmware doesn't generate scan_result events. The scan request never
finishes, and additional requests from userspace fail with -EBUSY.

After testing on both IW412 and W8997, I could only trigger the bug on
the IW412 and observed the firmwares behave differently. On the IW412
the firmware still sends EVENT_SLEEP while the authentication /
association process is ongoing. A W8997 under the same
conditions seems to suppress power-save for the duration of the
association, so PRE_SLEEP never coincided with the association response
even after extended periods of testing using the loops
described below (>12hours).

On the IW412, the delay between commands that triggers an EVENT_SLEEP
was empirically determined to be ~20ms. This delay can naturally occur
when the driver is outputting debugging information
(debug_mask = 0x00000037), in which situation the busy scans issue is
repeatable while running "test 1)" as described below. If the delay
between commands is less than ~20ms, the firmware stays awake and
the issue was not reproducible running the same test.

The host_mlme=false path also behaves differently. In this case, the
entire authentication / association transaction is executed by one
command (HostCmd_CMD_802_11_ASSOCIATE), and the firmware doesn't emit
EVENT_SLEEP while the command is running.

Remove the assignment so the ps_state is only manipulated in the paths
that are related to powersave event handling and on the main workqueue
for correct sleep confirmation.

The following loop tests were performed (with debugging output enabled):
1) force roaming between two AP's, one 5GHz and one 2.4GHz, same
SSID. Use wpa_cli to trigger the roaming behavior, sleep 2s
between iterations.
2) force a disconnection to AP 1 and a connection to AP 2, test
scan. Use wpa_cli to trigger the connection changes, sleep 2s
between iterations.

Each test ran in each device for at least 3 hours.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
 drivers/net/wireless/marvell/mwifiex/join.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 5a1a0287c1d5..b48f7febaf03 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -736,7 +736,6 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 	/* Send a Media Connected event, according to the Spec */
 	priv->media_connected = true;
 
-	priv->adapter->ps_state = PS_STATE_AWAKE;
 	priv->adapter->pps_uapsd_mode = false;
 	priv->adapter->tx_lock_flag = false;
 
-- 
2.53.0

