Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750565;
	b=K3rGemOSIM9XstMqgnKLD59KE7Qv6nM+G22z4rspgT2ji4HUjaEaRtr3UbhW1shFjCsi
	 nw1qKlQB8Z0ccYM9gXc8pnnNrIFk08l092X6MxQqWMFu7ruqWi5RYPs+wmXXky4weB5a0
	 YO/i1sCBUOXmR07PFKOAm51LTBoCTFohDF7Mc0SJYMjplTvzwC/atnUv/Cr+dY1AKlgVg
	 kp5d0ENkZ+aPn72myAtyu5GihcKVc6IXZ7+CqhtsGJRltyNDIb9Wj87idMVgXEBLdIh9w
	 ltT3p7Y1KrvUEAIGjwtudbpdBsLJnEDVFRIMcYLFvGSCfC7XcbX5fC6opq86wZS2Xew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kowKGEG8GhEeYbc52I9hqfYuIffCT+VKLMki4zsClrQ=;
	b=KZsOdQ91NeGqwPTrcVeDYxH6dZobTAdRe7ize97HujgGpJsrhZAmnJWV5dW9TcmAW4rH
	 wE/dMfQP4gu3+uEmM7/qcjiUkcTxlojBOxrO8JSki7aHwMaF1kPSui42GohKHNn/MvIoX
	 cfYFANwbfwdUkgca9hXH6lgINt3TlP3Fl7GJ2Dx8Lo/Y67AglvJTPnJRjxyjaOgpaIYBu
	 YrHch5FQRro/ffOJKPppI24ZykT+n8gneW2/KELCqmv+qPrrVRYmGTvJsGPR5r+OZmvqd
	 g9EnLEjVF6dN4uAzSgam+EMGrwnmiHVjwD/5pj0Aulvc30bR71hp+/379O3WZ0jvljA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S3Vw1Nu/";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427E606A324
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 00:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1427E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3Vw1Nu/
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48fbe12cfdcso67641f8f.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793750563; x=1794355363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kowKGEG8GhEeYbc52I9hqfYuIffCT+VKLMki4zsClrQ=;
        b=S3Vw1Nu/FppcBaS3Qvw6U5JmHn0zhK/FM0VrI/JSwsDkFBT/vvY3vheYtkNv817LbK
         ciWppLK/mw4aILC1gksjwqYF7piGXHNWXbdiFg87w+YuoZrfWQmR0YbrXJYC5SO6RG/d
         4WjcNz+T4Z9V6J7edlkrnuU7fMqHMoca+sQdPW9d7oxfK8Ze6qyQeWPb2d7fVrLW6wfI
         sXe4Tgxo7ueuLhUE9izZ9XRvLIglpccZw3xXy8cbA886T+8ylxyN2/xmegLJEmBribBS
         j7Tr2BVnkiqAUd4vSeneRBOxv095k5O+XJRWCsWCjQTYhz0TzEMZvyXYNCWDYdvPbPpm
         anxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793750563; x=1794355363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kowKGEG8GhEeYbc52I9hqfYuIffCT+VKLMki4zsClrQ=;
        b=WP/+wP0VQ2K9PdF0guQJBZ8kjw1qOVrxa5oyBCSYoUQ8ZqtN6sZrlLNRkcFTcidaPE
         NFWY5Jg/JQasKVc3IewWFP3Mp4RpojorbUtCyyDsKXeiTTHM2UO5AFE3mKllHUNI62Gn
         YirIx50IMItOEhq2YvBqBitv6xAI1QTkOUlqvLWFsNrFDh7vddkl6bHMvqSzyPe0GsxH
         b3h+59+M2FEX+E1wp/nd4YwNXoRTPAXJuk0lIJWOGddTrE4lCjJa+WUku6B10TdgcYCG
         Es9oWlcoPtGEz8ZoG48LWdB/rUcKHYB+yuVO0AQEx+94JPGNiNinrJ47XMiVet/Yy1SF
         bQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBwOeEuCKsQ1O6KZl1RqCxJhWUuScmmWSSTfk+qCg8nck8fdcXcTNWLR7CXiQqxIkDzTyJ+ro3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jf3q9ebBnBjnE7RQeONxXTwqY3uhUee0lCHtov4J8UIe+6rCy
	rgSs1/vQP255BqR2zaUy1v959Eanm/qVgoAgaOj/HWk1a3gpgDBvMT8=
X-Gm-Gg: AYBFou1tYvXyMEO+WLRW1bkCvjS7Q8P+5ZWqmTeBa5+SQ04B8PmIWcZkeSsGZQx0lLa
	NTQpBwKn3SKLhnWtswVRM5NU0GHOkBZzyAUIMKIPTrkYmHDiBmbAyPTIRuYuv55ZRCO9eXTJ+bF
	SFZ0nb7Rd1TGxvcuqv5pCuoKpmqiB/7C+ZSXCeCsH/lg1J22LTpfJQOFdVmp3UfzbVW+KabFK09
	YVUlHpWlXQh9xDBoT4+H/suLxbOac29xhyfoYdQi2HZuE4cWVxBcXrsSDs0/arYZXOJEMRcOqpX
	hFdDviXDk2N1UEmhzOrkfozGBIN++MvbnC1lpmeibYaRqm4v0jmQ2bw+BEP6yrmBebUYen2GWD7
	ALQs7/HDQSzM+XINPByD/Kbgo39X7zkPo78p+++YJCgqcfsV4I1Y05Y/cWdbDwx5pw8slmGAbMO
	iiJDAp9crxjDZMdy/vx5Z7sh+sNq1RQ19HkDt4WRESMGZNM130GVzeCPNQUBdyzwiCNNJeSPhpt
	Mki4CsxDjRkFA2tCM6eTj8r7roIpxTFrip7hBkEQwJHWJYL6d9FHlpxpvEJcG/xTR6sl7KfVaUv
	BV9YezmntA1QSoCk8sQ=
X-Received: by 2002:a05:6000:2410:b0:48e:6674:3b2f with SMTP id ffacd0b85a97d-48e6e5005c5mr34358784f8f.51.1793750563327;
        Tue, 03 Nov 2026 16:02:43 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm714193f8f.19.2026.11.03.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:02:41 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] usb: gadget: f_uac1_legacy: cancel playback_work before freeing audio
Date: Wed,  4 Nov 2026 00:02:39 +0000
Message-ID: <20261104000239.2798131-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

f_audio_free() frees the f_audio struct without first cancelling
playback_work. If the work function is still running or pending at the
time of the free, it will access freed memory via container_of.

Add cancel_work_sync() before cleanup and deallocation.

Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c7e87d1..a9807697265c5 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -943,6 +943,7 @@ static void f_audio_free(struct usb_function *f)
 	struct f_audio *audio = func_to_audio(f);
 	struct f_uac1_legacy_opts *opts;
 
+	cancel_work_sync(&audio->playback_work);
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	kfree(audio);
-- 
2.47.3

