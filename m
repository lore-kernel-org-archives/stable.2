Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340839CD12
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876826; cv=none; b=kzxrTjGPMC3cONGIiEad5dxFhvwQ0fuVtlSnt7RckgyAhCmYcB8VF6HDuPBggY2N+fiXBtl+biHwFihl1Mlw9rm6uWb6/NIewLvQonrLo+n26L9uKpJtLufQUhoOJ4AyHZpZ79XNeT/gMBY4KuRTDyGwaCZPEZfVn1UK0XYtUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876826; c=relaxed/simple;
	bh=yKooLcN7CHgsaZDkbyO505c2en4X/luvbmOSMQrltvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CauwEdq5VTOHAr7sFzmmrDD2ubSfyWg5mEAJiJ9E1U8n1lO//HZ4nJl1MRAGZ8SF5znLN6ArY1R4thRPNmjYYFZytYWPVOAiXP9aQvUYgPmnAAy90YFWFK7bN7ihd4FEwCSU6XuvcFP/kreuFbdvyxtlnV56FR/oMESeZ6qBLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=qJxWhSZi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="qJxWhSZi"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so982034a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791876825; x=1792481625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwgbOTwZS+Wdyws/KBJ7MPJ9pBsymYg2xZOg5DiPzmg=;
        b=qJxWhSZiO+8phAUlyAKagE3JV3yDtbaW6oDzkWBGcpkwC5/0Us9sq6+ITm7OZVdoqx
         Q2eGdJn57hMEy/RqMqszT7uXS80Likex/j4xbxDiX7k6OR45mFN3hrM6Vic6r5hxDvjv
         6Ywp7Q55W64ArZNZw43k5xb3GGgqEPeYc7v9e1L2N2Dj77yQLxCHtXCcnqwXAK48F3fJ
         Pe5g2CtLwVW7f4O0tqi9fZ2LmSgwzNSMWmuHUycfHy18Vv+tR31bvcHsWP2ObI7WQ+o9
         nJwsqick/lnyFB+Qq33sU2Q3rAC3I6PRXyqzgFzJWlJRU2nHbToo5nUjLY0RS6H8kv3k
         u2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876825; x=1792481625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwgbOTwZS+Wdyws/KBJ7MPJ9pBsymYg2xZOg5DiPzmg=;
        b=xjyKfeq1s9BUalxdOHw44pMjbP10X3hTUIuclHIJ0hdmyAIDnnwU8tEqO8iIPkP3Hc
         6ARgovGBRFSDVrSm9YwODo0OWsd2VpCywue8JSC9VGFge5HD18p0OwIGhhsQAp18tdec
         CQwlBcq7cW+QWEbQuoKlsdeDP4Ni/gPoom9vvfB0VNN7KSfC4UhM/dUNura5IMOV996z
         RQ75TABHeAyUa3tKw3MLwO0o+fsy/+UBOs5GeieBdTktcSWyv0oOlGFmxnttwuLuV53y
         mG3CxGp7IUqPApbmmtUvE4i6RujN3n69ZJUHwlGwiU8si5/FCWL+VTxUtEdce7s8HkUZ
         JWng==
X-Forwarded-Encrypted: i=1; AKwUvBwq5lpmW7c9s0fDbsnPYZYDbgcCw6TzMkRMCyjiuB7vst0nJcB3M6RVJ8DaOG2HzVnitKTweKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPTmvfA68JOsyxOdk9hiKJr40LNFbSFvBzXss16MxvXY1+J3iR
	sqAULo/nV2E00zXYNsuygcw/GptTwuDiNQHjZBajH7+gbIk3O7uBKWd/yABu4HZ2eMc=
X-Gm-Gg: AYBFou0zjr2JKxW5oUG1kTVhc9HTkixR5Lgko/1Yv1AX6sQNnYfnPDrrTgZANGCqoTP
	hX6I6arRJCDxtzOQQyYi/XtZb00h2n7NhaWjcr48cil0ecJDDWKaeclHU6k42coyBMm0DN+B+OZ
	Ii47rz0u5j3j+HOkGKVHfFIRZW/ZIntFXDfvfEcFNWMiPlQtGclNVtPXlXP+Utp+JG3pBYPy5Gu
	YG1prMK+128KMm2+C9IlO1TNmX+M/MXMp6b74nfvXoz6V96m3NR8zvqliOKF/MJynkbsEpfaIzY
	zRLGsSDANuiSmUwQu7qcbO/1cen5qCdqDR/sWhFaOUT6wm+zPWLp29DqW5bUGKwfynXI8y58DLe
	fS9EuEqs4CJTHF6Bj3xpxQ7xNU3wZG2c+JH8C2JfLPgk23PhRB8DaSyyqHjWHLaV8fwk2KBHsh1
	2/9LJ7M+Idh/qRAWRvcJsNiX++ofkn1/q2hMcyCg4YO2Dq8gWLVkfz7IE9CseXvsAB0fuLtwWEX
	j3RQg==
X-Received: by 2002:a17:90b:390d:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3ab3a7a42bamr10025027a91.48.1791876824559;
        Tue, 13 Oct 2026 00:33:44 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm19973923a91.5.2026.10.13.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:33:44 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 1/3] usb: gadget: f_tcm: queue the BOT status requests with GFP_ATOMIC
Date: Tue, 13 Oct 2026 16:33:26 +0900
Message-ID: <20261013073328.2936318-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
References: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bot_send_bad_status() and bot_send_status() run from endpoint completion
callbacks - bot_send_bad_status() via usbg_data_write_cmpl()'s cleanup
path, and both of them via bot_read_compl() after a BOT read.  Those
callbacks are called with interrupts disabled and must not sleep, but both
functions queue the status or drain request with GFP_KERNEL, which can.

Queue with GFP_ATOMIC, like the other usb_ep_queue() calls reached from the
same callbacks (bot_enqueue_sense_code() and bot_err_compl()).

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/usb/gadget/function/f_tcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 9e6d4f39900a2..12e2b20e33b92 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -139,7 +139,7 @@ static void bot_send_bad_status(struct usbg_cmd *cmd)
 		req->complete = bot_err_compl;
 		req->context = cmd;
 		req->buf = fu->cmd[0].buf;
-		usb_ep_queue(ep, req, GFP_KERNEL);
+		usb_ep_queue(ep, req, GFP_ATOMIC);
 	} else {
 		bot_enqueue_sense_code(fu, cmd);
 	}
@@ -167,7 +167,7 @@ static int bot_send_status(struct usbg_cmd *cmd, bool moved_data)
 		csw->Status = US_BULK_STAT_OK;
 		fu->bot_status.req->context = cmd;
 
-		ret = usb_ep_queue(fu->ep_in, fu->bot_status.req, GFP_KERNEL);
+		ret = usb_ep_queue(fu->ep_in, fu->bot_status.req, GFP_ATOMIC);
 		if (ret)
 			pr_err("%s(%d) ERR: %d\n", __func__, __LINE__, ret);
 	} else {
-- 
2.43.0

