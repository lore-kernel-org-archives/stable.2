Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CA4B0C82
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872509; cv=none; b=YgAbSrjtjRaGj9+hFOTW1kh13A09+fDgVe4a3/VrsYW4rmp5K9viaMnig6cTDqrqESIw7peK9GZzXcvJ2c1xK75KgH1IsuPNEi9bS20wEbw49zzhevaUCc5LfKcJSU4NbEpkyGsldN5fXdTyan43W1ofs3x6jm9SZbzqkoTSokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872509; c=relaxed/simple;
	bh=yKooLcN7CHgsaZDkbyO505c2en4X/luvbmOSMQrltvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X67kk2AAFOpAfXFBZRS2L1yS74JG2U91kfLZdCxqlj7Skm/VX0EtrZMwF5aDj/bzD/58HJ2EaqYvjTiW8QJzpsyZWR3gvjsX4KBM7o4XssIQs0Kr9Rjihme5dOwkFEfQVIeUFkAsrzNc0dC/B4IP+e9L9OWFP+MyncywLCQckGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=QJ1kEgx8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="QJ1kEgx8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so1281868a91.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791872508; x=1792477308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwgbOTwZS+Wdyws/KBJ7MPJ9pBsymYg2xZOg5DiPzmg=;
        b=QJ1kEgx8z5465tqjVNSNRin25Dx7PonvzJRGqMcfEU+2TfvhEqn53+CCvAVQBGmNsa
         nKZhPERxK5QFcDZIBMDzRNAidFYuop/ABZRdGMNzxX4Wvx8bhn2acu3xciVxp1lkFZe9
         VILlzqWvSDlUHLv+hbg3GRXF9HKs83WOII1LFUB2LjXlIVvWBTyyOm/4rD72Zj3VnKBF
         xnZGPqfFkN5LmWE559jUYfuqpg+RieZKgNl/O8f9eSUiIe8wrssk0tGDJg/5nWs+4p8g
         gQ48K0EzR/H5j5phqdo1UxJyGk8XbSu6R57ieAethjJzUgLTfhOQzA/b+06NRViTDAJy
         mptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872508; x=1792477308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwgbOTwZS+Wdyws/KBJ7MPJ9pBsymYg2xZOg5DiPzmg=;
        b=a0/jO5rfhSy0+c6ghn2kZGM0wUGICHAINnBUKG4AK1edaeML8ftNYB39tlYP2//2Fm
         Cwe/sw9CAA84Wt1Js+jvoP0hOH6HQ1hAey5SgIxYqLf3em8azxJYGe+aBu1DZpUVMzBf
         eo7rCJpsCyy0797hDsaP2Lvo2mSxE2t0vDkFeRudIzvnAUCJ69mhbvsKYoNm7RqsH4+G
         sQGTVj6NkHtFSI6Ao7US8/mIKd/3jOy+xFuZIoV5T17DimVGpfoQQuhxXExoeog3QWhx
         moPVNP5Fwwxqo06y48I4M+tquiNuDt9HaUhPtIjnTow3rO1wtzCgYCtv4z/05Qbh8jfp
         z84Q==
X-Forwarded-Encrypted: i=1; AKwUvByJeRJGefR/2vodJ2Wp2Zrwu5NmSQWiETpOMHNOjXFIcNl1uRjGKODxAswIH0/XHxta8X1Ur7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSPP57u8/eADwPLo2xEllXCHXh0W3AehonYcP/E4VUYZ+2cyUY
	wOFHj7eoZGeZ2vxC3IxFZ6i8HajRZn+lN618cy1dZBi8cL1qIZJ88uQmCXzQ3NfSN1k=
X-Gm-Gg: AYBFou1Xz6+MPS5PhS3sxkc2iqXdrw+1a407fTt2e/iJe4ihwp6rCb9hUWXy4VatSdU
	fBh3zaLazIodOQq2v7dxywDVzFSRTYmZbGFV0bzZyCAdNBxCiWIkVGwsuy5shbsxDf1SEd48GqB
	0Ux+0oSj9qe/mgaHL7TuHnJEA7VkWBCxGxEnlVeJbmtV7cg9nSRS2LpZhuRKIXjke27Cn0YtySX
	fF5wx62rfAehlpkMWcpMILLLu3Jwb6ZqD7RAICfYwDRRQM6XNPQro32PVQtcjw2ieBoJ8hBaHWx
	LbG2Fv7vanpp+VwFEUqOPAVMqYLgoeodJ8CfXk3/Ylwo7ZuU7c7K+uTDRIR5gfnXGxEc7qicZlU
	7TmTsKywHj+gKu4Cwh34pSE3Iu7KVkuyytJZduk2vhfbqEOIRXdIg+/GdL3hy+ZeqxugftyMSDV
	R67RCpdPU9bZXM/EzK5O8GFXnWGb2arHxfS/xeqDWUpCMU6fcw40MO040hDw0ybFmeX0ZGuujPs
	yl0oA==
X-Received: by 2002:a17:90a:d450:b0:3ab:364a:951f with SMTP id 98e67ed59e1d1-3ab3a3593dbmr7775494a91.6.1791872507175;
        Mon, 12 Oct 2026 23:21:47 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32d3b4f7sm9253553a91.0.2026.10.12.23.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:21:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 1/2] usb: gadget: f_tcm: queue the BOT status requests with GFP_ATOMIC
Date: Tue, 13 Oct 2026 15:21:28 +0900
Message-ID: <20261013062129.2568405-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013062129.2568405-1-yhlee@isslab.korea.ac.kr>
References: <20261013062129.2568405-1-yhlee@isslab.korea.ac.kr>
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

