Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EC175A84
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566709; cv=none; b=bxM7vV8TkKjnFWL7Bo3hIUyGVV5IgLzEC/E1pCctU5TXgrRhKGRrLHAQXCvDwqIwhYZ7DVPxuatjngsWlz1rf/KGfXSIB4GGHqdMVYORu5VKmYA74B8mpIq3e58MZFmfxUgWLOmFQubLcBtNdECm6h4xhjMIQ02bO/hzUogAW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566709; c=relaxed/simple;
	bh=iql7e91vygTXtijKqfYc0bTrgV3mIdwj0o/yny6LERc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbkVuZgICpPiYmz15pA7dHFaD0VHxbQHKuJKBGdESN4mxl/xgpn/xxAXkmCyIMlp7BQHOi3g4XLPcQ10sABX0/1yo+iDTyC2a5vClSJQ/9+MkN7SBslyoP6TcgKc2URowpoUDIT17PgTXlIAYMU2+YzcoHnrh+6WBUCfpgfApAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzydNyNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzydNyNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30861F00AC4;
	Sat,  5 Sep 2026 00:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566707;
	bh=qGvnh+EbFY5iKMbRebGx1KlC7XqAkxncm6U5cnfTeg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WzydNyNLiBTzrZ0R944gAlYlEmfSx2aMC3mAQo5qjr5nwmZV/3baWRqOEWHu0YMu2
	 U+deLvYdSbNhXg6KPMt06gS5r92vlt8qC+U7bJ/P/0TMiwzQw6hfHzE9sO4XIGUYVr
	 UPKpVJV6j1d4xfT6eSi/7HzYKeTe9pSfg30qRKOFeZO4haqd6vQXRbkBh9mWAvbMjR
	 c3P6laKhFuyXrgXfCtFQHHQepYSf4W5iwOd2u1B+rt5hd+uezUygd5mSKRo7YLJ22p
	 kYW35jFvpIDCwhlVuulFGf29VLzM1llVsJ+LKiQmelkvR9NYmfv1Swfv38yA8mZ9S9
	 L2KBeAqpYG53g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Wei <huangwei@kylinos.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Fri,  4 Sep 2026 20:05:04 -0400
Message-ID: <20260905000504.1657915-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905000504.1657915-1-sashal@kernel.org>
References: <2026090309-kelp-viewer-b3c3@gregkh>
 <20260905000504.1657915-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huang Wei <huangwei@kylinos.cn>

[ Upstream commit eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb ]

The synchronous command completion path in ucsi_sync_control_common()
hardcodes a 5 second (5 * HZ) timeout when waiting for the PPM to signal
command completion via ACPI notification. This value matched
UCSI_TIMEOUT_MS when it was still 5000 ms, but it was not updated when
that macro was later raised to 10000 ms to fix PPM reset timeouts.

As a result, the two PPM communication paths are now inconsistent: the
polling path in ucsi_reset_ppm() respects the 10 second timeout, while
the event-driven completion path still uses 5 seconds. On machines where
the firmware is slow to respond during boot (e.g. some Lenovo ThinkPad
models such as the E14 Gen 7), commands sent after the PPM reset, such
as SET_NOTIFICATION_ENABLE and GET_CAPABILITY, can exceed 5 seconds and
cause UCSI initialization to fail with:

    ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Once UCSI init aborts, USB-C PD negotiation never completes, which in
turn blocks USB-C dock enumeration since the dock depends on a successful
PD contract.

Replace the hardcoded 5 * HZ with msecs_to_jiffies(UCSI_TIMEOUT_MS) so
that both communication paths share a single, consistent timeout value,
and future adjustments to UCSI_TIMEOUT_MS are picked up automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221740
Link: https://bugzilla.kernel.org/show_bug.cgi?id=2183790
Fixes: bf4f9ae1cb08c ("usb: typec: ucsi: increase timeout for PPM reset operations")
Cc: stable@vger.kernel.org
Signed-off-by: Huang Wei <huangwei@kylinos.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Fedor Pchelkin <boddah8794@gmail.com>
Link: https://patch.msgid.link/20260805085725.389761-1-huangwei@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5d601112fb0c5..a17cdeca6a9bb 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -66,7 +66,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ucsi->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-- 
2.53.0

