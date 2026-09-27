Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D7547068
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790484356; cv=none; b=Ea7juiVFUi/QglH6mAXGfKY54BSn6M1Fpgi5C9Y7TCwhvkdt4XmzAwLrZIKQf4RqoCeiXYMpjmLap92RfvXYoSrXsJSGn+3erye2M6AnzTWbfMPd5Erjf/jh1R9Zv6veLcgZc9q4b6Bbm8YjPwOVsrWfqVZU9yWxZX5o4Xlwtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790484356; c=relaxed/simple;
	bh=lwbuO94m1Y7nNgaCvIakrp+Jlj/Ls07Kcmk7d5tERa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZJjl9VhozZll1vtlzOna3CYvqoX/1n1BtffMNFnh8fJ9ceY8DuzuOncDtcdXzMpKzJ39gY9Xx4G7buLVf4yY2xDZZtsX47Lq94QLRIEe2Za+ujXO9qDe3EYs5b/m1340xRBRDP7B7yQTQ6OcoTVv0mGdvJ720vGY1p6G45bTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXFRQ4JV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXFRQ4JV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso9551895ad.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790484353; x=1791089153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILSKS40563v3cg9jd/GJ4zISgLCLK1UIjjAKEYNJvaw=;
        b=nXFRQ4JV4vIkc+BBIZ0Qz8+T9fNbi/b3nFYdqeYNasbq9grXxnsliYgd17j+vxpE4V
         gmomqKxIOZX1bptZBPJPWiQi4yJJl/UFnbQjhVWJJNqcI/JCOJ8bt5xRLWqziQNtUfgn
         /p0Za51WPxJELYhk99i8OGCBGcrzS3ACywXTPMjvKylMOmxZWn+fphCUdVWCJwyNZbWz
         3I6XiFe4FfYojHyQHslkk0N/s4gRR9vvvqQvN2PgoooYNEcejac4KqprW3Jej4P+wEe5
         tcqJWiOwsflWNcwLrIeY66Gvx9yqP29fwjux6JXnKKiI/5m9f/B6JfYMehSOJU2VsvBp
         4U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790484353; x=1791089153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILSKS40563v3cg9jd/GJ4zISgLCLK1UIjjAKEYNJvaw=;
        b=ByPcXVEU25XfYztCnqcmJdOhM9acHUqd4ngRwdhNCUqeYlrkEyxSsOSFYi4w5JGfw2
         HXVzqsLMba6R/GNXbAk4jgwA+FOv1D8lZGvcb09h8IZagx728z6Z9oKQY1cNl2GOncxt
         np6I0FX62mEuO5LGqVpZAsg7/QynBNSkteVqgnU7K0xptYYIVpHHYWnxay2RdpxgFL3M
         Ntb+T7NnZR/eGCf8XUa/tkaQLuqlt9f93t8XK+YIE1kin+wWuxT6E2NDt72UksXU+DiT
         yEiP+Bf/jAPVSPabhFYeVpeBpNhoKcvtnbYwOQvOjeBLJhCuYOyaUj7VuLWmPGSbZiyx
         EHYw==
X-Forwarded-Encrypted: i=1; AKwUvByL7iZKH8WuziB/OERuwba5wDR+xVs+lcZNWREMR3S7A+xZRcVfGxXBPSQOI3BJDA8uFHh6TyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzspSMBIjJJOToZfoP7sCW0YUlZK2e+LpTQN31M+3D6hcx+djl
	bRFpm1wxkDyu79bxFg/yXSHJIE5IECNl/VipGZl0TahWJsqKO/9u5kUx
X-Gm-Gg: AYBFou2OYNB3ua5Qwzr28vgtQEsuiDfUgZE20d+YHqp44loB9azg2bO7wvaqf/92QLs
	ybqVDv/8Qd7Omcbywwk1ofPxEmM97nFnYiBtrSgYCKXzjMWBP7f7ljdgOsZpqZ0bw41M6PSClhS
	+tLQueJcX+qRsgxatJm6nKUVVFZX8wy7Emi+VhFQWnkH+8wHQsik/Q6khcWmhTgE0vgtSb9bVjd
	vgoYnwZNzV+zubap/ixgYfI1mLDSXQOs2qjNOEbqWTh8HcxgKFchgPOFwYozvYsoayWKqTdzJek
	X7o9/2hFHfX6RjYJhKDnK+0J4AgyvWXG2RneSkuD3qpwlmmPlf+R/Ap4hO2ZJsc47ECLc10w3QI
	XIHs367qL16OXHzPnLIvUm3aKmUxUwQLKph46ZFt96IBc2YEWKajERurdpjnXSF1HwWyZ/DVMiy
	tKJ8bqVvyclbwd/cnGt6jp6XXVa1o9858yakyf78pOh5gcpYLoEOv0DYKu5ddJYaF+0qv3Iiv7H
	Sr4mumckRieuOFgdg==
X-Received: by 2002:a17:90a:dfcd:b0:3a0:631a:ba6b with SMTP id 98e67ed59e1d1-3a098db9593mr7472762a91.33.1790484353317;
        Sat, 26 Sep 2026 21:45:53 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm10628448a91.7.2026.09.26.21.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:45:53 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Antti Palosaari <crope@iki.fi>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+c35815bad054e6ad396e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-usb-v2: set active_fe before the demux goes live
Date: Sun, 27 Sep 2026 11:45:47 +0700
Message-ID: <20260927044547.26979-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_usbv2_adapter_dvb_init() registers the demux devices before
dvb_usbv2_adapter_frontend_init() runs. Only the latter set
adap->active_fe to -1, so until then it holds the kzalloc'ed 0 while
adap->fe[0] is still NULL.

A process that opens the demux and starts a filter in that window, which
lasts as long as frontend_attach() takes, gets past the active_fe == -1
check in dvb_usb_start_feed() and passes the NULL adap->fe[0] to
streaming_ctrl() (or get_stream_config()). mxl111sf_ep6_streaming_ctrl()
then dereferences it:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000061
  KASAN: null-ptr-deref in range [0x0000000000000308-0x000000000000030f]
  RIP: 0010:mxl111sf_ep6_streaming_ctrl+0x2e/0x2e0
   dvb_usb_start_feed+0x57a/0xc70
   dmx_ts_feed_start_filtering+0x129/0x220
   dvb_dmxdev_filter_start+0x434/0x10d0
   dvb_demux_do_ioctl+0x48b/0x540

Initialise active_fe to -1 before the demux is registered so early
feeds fail with -EINVAL.

Reported-by: syzbot+c35815bad054e6ad396e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c35815bad054e6ad396e
Fixes: ad6b9e517b39 ("[media] dvb_usb_v2: move from dvb-usb to dvb-usb-v2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index bd86d250433d..557451b541e6 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -637,7 +637,6 @@ static int dvb_usbv2_adapter_frontend_init(struct dvb_usb_adapter *adap)
 	dev_dbg(&d->udev->dev, "%s: adap=%d\n", __func__, adap->id);
 
 	memset(adap->fe, 0, sizeof(adap->fe));
-	adap->active_fe = -1;
 
 	if (d->props->frontend_attach) {
 		ret = d->props->frontend_attach(adap);
@@ -795,6 +794,9 @@ static int dvb_usbv2_adapter_init(struct dvb_usb_device *d)
 			adap->max_feed_count = adap->props->pid_filter_count;
 		}
 
+		/* demux is live before frontends attach: no feed until then */
+		adap->active_fe = -1;
+
 		ret = dvb_usbv2_adapter_stream_init(adap);
 		if (ret)
 			goto err;
-- 
2.43.0

