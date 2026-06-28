Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E71F03DE
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639949; cv=none; b=XcXGpcp4XQqtDivhh99xaHm8IJVkVXtMNAWYiLNRWlNacEfbHbO1DmmiX0JO6EI20/LeHzGXwaCAK7A981hsbXo92TepLymziRIeUNAP1xcS7NfnkP3o2LuhCBqFHyrD82XI0Um8SNUOvvV2qQllC92rWRTr+Zw3bpRNkSrL2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639949; c=relaxed/simple;
	bh=O2B0uMKqHoOD4mY58Xsxi7bJvPfPy0Z+UX2l8MD+dOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEfzO0EPm4VS2MWy1ev96VjTaMwmAvleoFwtQTNXYq427ZhUyadGJ16k6MTm9jFIR5swPzVcoXRvkW+9w04WkbGpHtcNVTKW/mS9Jn3dakZLwQGs2f7kQ1Mc8gZR9uEEMG2FxKgFFB5BrLIieWRv+J2SKhF3YkzT4jobl8MPcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ3oglRM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ3oglRM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46cdc80779bso2159006f8f.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639945; x=1783244745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUuAzQn+5JDiJk1q5e76fbese7WA+ir/L5EhW8ClE0Q=;
        b=LJ3oglRMuFWgnV6Nwf2hwROxVcBHOSvgnPHvqtGsyyTLyOcISTItSuqW48CXqMLJ8q
         IHpjX8TkcRQIcpOsRaKRDlaLhuW9gWKVg+lsHQtmEr33hUKxw1w/+CNTVe3uIO3uF5hk
         15FbbXMIkfvwI9sCsPLm1wUz88hbL48Vu3IEeqv7G3ijeAFKOMaFbQDGb2jNbbDXIbn8
         xCorzJAOzfQW3psZt020v6Vuhb2kJzA+/VdiNijRt1OiVEN4EYPxFGMIPiylKzGt/Jkb
         m0J0vi8nRxiSKah0Qg5wUIG5N1TXiS4+RYNb+M4dPI4Po7JO4FGIWzhyY+KP9r1t7I95
         XXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639945; x=1783244745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUuAzQn+5JDiJk1q5e76fbese7WA+ir/L5EhW8ClE0Q=;
        b=tZQI+yH4X8CXvDJkvgXw3XF/2jCbnh+0GSv0lDZTnPrg3piD9QXN2LzIGvClZzi8wE
         CzbCrMvVwewGOX2CEXNiWgWgd1QK1LceACVIJMWaC18Uey5ib2uwLUJ6iyo3u8X2WDn6
         7sEwkM4D78Nzh3gaPq2N3SuRp4+Q2Pehue/LjwdC2RcS47UpQUFsgDOmTETSOOp9TOfA
         dKvDkK3x8htZnM5L+Brja8AAtK+QNpG0F3KyzQW27ybaMi8TmkVbRQD8fS040Adsl9S6
         N6n2dLroc+1qIXqnBGoa7ojPe5gYfD81iaj4qKW/kBW4er5ZLRkpnMkh1yQ90sRv976A
         t+Jg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0IMGJcPOJ8bDOcHIkbU1CokHudLjDm6YVMRiXIvfzksNJw+jhRZ04Rk+lK5R+wupecIuj4Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdMxn0EgHMF4YA74F/uBET960cUL3BzvlnNydwPPqzrF8G3I2
	eV1RDmy8Ej5d/Q7nMF5pwbh+mrql6aFDXEp2UEDZHDG5fPryXEy6ZO/Q
X-Gm-Gg: AfdE7ckigqGC6RoFpj5o06WqZjhkGKJ9O1fwGM7tPXwsop/S1ldINO1cqKrgAK3iZyB
	y18aMMwgOJze+ObsTtC4a0Sbg4oLYVglUP17kdBmn905YTM6E4JlJWhYlNN75s/WuLwvlgEK47v
	5Ae9YD494p4gjSlxqtJj/9BaoeD5O96eTyrOfPohuBLOpcLVm8lFRg32FLrTgmktcMjIgQsaM1j
	c4lMX62yQXv38kSxk/8eA3xOGUFT04t0T1oeYhTk2p0O+oe8q4pvKww1fIg/thGXhY+K1jqcpH0
	lNFnzrq3JAD+q1mIC44M8biePcPa/b90zxMQ+J7Xpaff6yykhIwsmevbPWKI84MOlskQWS4rYSM
	ORIOYfPIm2oT7ba8VNS0AnULBV5du0a5Zd8TrXhdYuuDWG379ZM3JlCXC6kdabDlaImUw3GVJ3i
	dLtNpKdoR8SVbnv3enVmQ4OFtSSZJXmUKiTDta
X-Received: by 2002:a05:6000:2483:b0:472:79bc:3919 with SMTP id ffacd0b85a97d-47279bc3aa5mr3463612f8f.39.1782639944961;
        Sun, 28 Jun 2026 02:45:44 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472c7bec9c2sm5129507f8f.12.2026.06.28.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:45:44 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+01d4620886bee3db0e74@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] media: dvb-core: initialize TS feed cleanup fields
Date: Sun, 28 Jun 2026 11:44:53 +0200
Message-ID: <20260628094453.45766-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmx_ts_feed_set() validates the requested PID and decoder type before it
assigns feed->ts_type and feed->pes_type. If validation fails, dmxdev
releases the newly allocated feed, and dvbdmx_release_ts_feed() reads both
uninitialized fields. A random TS_DECODER bit can also make cleanup use an
uninitialized PES type as an array index.

Initialize new feeds as non-decoder, DMX_PES_OTHER feeds so release is
safe before the set operation succeeds.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+01d4620886bee3db0e74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=01d4620886bee3db0e74
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/media/dvb-core/dvb_demux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 290fc7961647..ed77e0bfb8e2 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -810,6 +810,8 @@ static int dvbdmx_allocate_ts_feed(struct dmx_demux *dmx,
 	feed->pid = 0xffff;
 	feed->peslen = 0xfffa;
 	feed->buffer_flags = 0;
+	feed->ts_type = 0;
+	feed->pes_type = DMX_PES_OTHER;
 
 	(*ts_feed) = &feed->feed.ts;
 	(*ts_feed)->parent = dmx;
-- 
2.54.0

