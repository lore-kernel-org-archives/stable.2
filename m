Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795684771;
	b=glUETP8fi3MEx1zu5ckWcVA1ZLO5NF1dlKNB/AsRv5BYyFGfJY98mXVpiuwlPfdB0q6l
	 JtWWvAVOc5GUH0vEWfcCQdW0FTWIN6a6r6CUAW+eAxSa3ZFB9yO9dQ2wXUm7KY9umbnuD
	 SdVR2l9NlG7qAy5XiCt9b8uYZIUnR7anV81LvIjZA9azVXVAuJStiQ7mEeak5hvJh981c
	 2e/byumHEzZQ9awHN+0GZ0LXtU14+fLW9kfWIrq98prJyYFOWYWTqkgtUFvyoo9yseRBe
	 ChQt6Yuw7juLREdzcVFDMF98m0dg9OAQEdcxre5VD8G4DJR0xHd3+SObX1mwvMgevNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684771;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NAzHHL0UhEEN4C/38/am72G8TgnWEWzCBdt0PpC/bV4=;
	b=vZsx13xeK7g0MgyOXC5JpkwtscWaF4TRwE5v3ii4Rc9xyXe/A+PZOJDtD8d1LS2UdkaL
	 B0KmnW3Vd8qlbXjVFgmYvoqKKf3QzBE1ifJhtDgQWqv/7qcYkS9IRgMBYM0ZExZGBsxhS
	 Glh7RJP4uhY3/9f+/6/C6cfQCq7iuK1m6cZfmFlmWaxChd6RZ/NeYDW2jthg1/mW/4mf6
	 rrve5UxVU23D6S4sp9KUOb7WZNgMBuHKebnPgoBWAsWIxHL2V4HcHPNXuLV3BwXWW334E
	 z7XtLfPK1EYG1XvfvQHraIMARfb6pT/IRIZMcCznvTX7ySneiOp0qNM5qvqnpZZGlUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMxQHLNQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC7606A688;
	Thu, 26 Nov 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMxQHLNQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795684771;
	b=0gVkefn67me/d93uiYjkpW/78M3XHNTlecD7twsx4ScyPpuWHT0G8K5MSH1Uye50otKJ
	 hspTcuj0tCYlZ9eJjHylgZV8jdiYcSqY2msFHAOYvm84m9UBCI4pJWxgQK2w5H4SafJJs
	 K3ToZAoJS9xW+HXo2Ai1bilcNWvBlwUonzZPPtpWIxQKKtLu8Pc/8lmzFVXvv5kWKj6ji
	 BHlqheDCkVmWAYJb9+zF4dqxP+KCFx9JxP7gIAlSIqTvNNR5WN46FLH8kqSNyVB9ONIcL
	 pkzftmeGfQDNSIvQhr4yAb6PKHwhlScYkYjfpRRLcIdqiKFSeQxU+g2ED9kX7w8tQdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684771;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NAzHHL0UhEEN4C/38/am72G8TgnWEWzCBdt0PpC/bV4=;
	b=LsrOU+isVtkEqTI7abZuemFjSOqIblrdI8Ii7qtetrZBpiKtcnbcakF8zNNrrvK5exOj
	 UCycGQTgN12+MKZPKgfZwd4lH1o6S9yCb5A3u8iLlt+VMoJDmMkdXMirVJqmIboAc8eID
	 SgzotHkoKchtYWTd1EAyA00l5gA+IQ1IukIsVx2B5CdVI5q7PExrFMrvgF4CZF23F0h7K
	 WWRnAKtVSWTIK5+ESfbsgUniAsoytqMhyXF+PMfHSs9wrHW6dFb25/G4730OsBDXR3H0W
	 lsbXlAF0etFOrBv3Z+Az6zVUcpOCi2QhdO7DNNWDt/7PxMMoIqeZinwoeWyC0dmz6jg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FFE71F000CF;
	Thu, 26 Nov 2026 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684771;
	bh=NAzHHL0UhEEN4C/38/am72G8TgnWEWzCBdt0PpC/bV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EMxQHLNQxci8EQbv7G1xUMCaFbWF5mOMx4EtP/vEfnvLVWWqTSQi0aMVNX71R3A/J
	 8KOq+5hvYhR1Yciv0XLIrz57sQ4G8K+r0mW1PokMehgWfnI8EVCDDLbsxr4A8Yc737
	 scdXYQ7eNeG/yM4TJwZHTH0IpppA2xCNg2OUAJRW+3MT0wRIdvkzFS+sSnC9nm+sEZ
	 ClFuDd2uDd7Yv7P5t56U0XzQ6GP8Cj7WqKsJshmlxTrURh+B1yAqNwI/tiQAayBJ92
	 2MFP+4U5WRSZSUzyytywyV8bUbis/qFlH8GEsfmc8avAzVt/5HmKQfqrHuI/6QEyk6
	 8eoGKNMK2noUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EDE0F4D342;
	Thu, 26 Nov 2026 09:19:20 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:19:22 +0000
Subject: [PATCH v3 2/2] usb: typec: fusb302: Toggle with the default Rp
 current
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-tcpm-attach-reboot-v3-2-1c97dfa5024a@gmail.com>
References: <20261126-tcpm-attach-reboot-v3-0-1c97dfa5024a@gmail.com>
In-Reply-To: <20261126-tcpm-attach-reboot-v3-0-1c97dfa5024a@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795684760; l=1959;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=FMswpD7V3DPAN3VSP6u/NBb3U0lujecrXjPnwM/C3ww=;
 b=IkegyDSSVxo1YrjdpWsl/T4MeCRH2GmVL0WbsdLAscAQUIppgLhut10FHxllTrHU0NTalXkjo
 fNHD/lY9irXD+lYlJE95huL9zqmw1bKc3kjbW/Jcqtw9+2tM0ycNw9g
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The FUSB302 does not detect some sinks while toggling with Rp 3.0A.
Toggle with the default current and set the requested one on attach.

Fixes: c034a43e72dd ("staging: typec: Fairchild FUSB302 Type-c chip driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 83bd287dadc7..64d02cc0ecae 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -97,6 +97,7 @@ struct fusb302_chip {
 	/* chip status */
 	enum toggling_mode toggling_mode;
 	enum src_current_status src_current_status;
+	enum src_current_status toggling_src_current;
 	bool intr_togdone;
 	bool intr_bc_lvl;
 	bool intr_comp_chng;
@@ -942,10 +943,11 @@ static int tcpm_start_toggling(struct tcpc_dev *dev,
 	}
 
 	mutex_lock(&chip->lock);
-	ret = fusb302_set_src_current(chip, cc_src_current[cc]);
+	chip->toggling_src_current = cc_src_current[cc];
+	ret = fusb302_set_src_current(chip, SRC_CURRENT_DEFAULT);
 	if (ret < 0) {
 		fusb302_log(chip, "unable to set src current %s, ret=%d",
-			    typec_cc_status_name[cc], ret);
+			    typec_cc_status_name[TYPEC_CC_RP_DEF], ret);
 		goto done;
 	}
 	ret = fusb302_set_toggling(chip, mode);
@@ -1357,6 +1359,12 @@ static int fusb302_handle_togdone_src(struct fusb302_chip *chip,
 			    typec_cc_status_name[cc2]);
 		return fusb302_set_toggling(chip, toggling_mode);
 	}
+	ret = fusb302_set_src_current(chip, chip->toggling_src_current);
+	if (ret < 0) {
+		fusb302_log(chip, "cannot set src current, ret=%d", ret);
+		return ret;
+	}
+	rd_mda = rd_mda_value[chip->src_current_status];
 	/* set polarity and pull_up, pull_down */
 	ret = fusb302_set_cc_polarity_and_pull(chip, cc_polarity, true, false);
 	if (ret < 0) {

-- 
2.55.0


