Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8853783AE
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804577; cv=none; b=QRsaoh9oe6LgVU8f2Agcmlp9O5wSOGWLFImzYTw0X01Y9Ih+2uZmaJWhZh4YAGaFn9oDWkpOL7UrQjt1/6w02p8mjN9ZZAg5dBKiV2XNpjZyEEIyKLq4F0thmDhL2ZA41MbSBVGlCnIk1K19vFdnpjgksA7nWf67uxcV+cONY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804577; c=relaxed/simple;
	bh=i5j4N3jc9IGaXr4Y8SA04YnztwfrViAVW8ve5zNs9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xt2PuJR8ysvXThs86HxLGchji3WwSWrekzP1NlVUhhhBmmK6hlpvH5wKdGuAeMjRYog8HnulgjqcGpUhpWyxrZxoT23WDd7mCvautw5xsY8acaZBrgq6ozm1HSCqS4v0gb7/AlVkQjcdUT4tUFPtSuAKXd8HSKR8Ju1OOBWzduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPEiYx8t; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPEiYx8t"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so1737671a91.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787804575; x=1788409375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7U1BnFeXoGQfM9V4KkXP+ZPWf072nK5WtXag0RShRII=;
        b=JPEiYx8t50DXnUk7PJlui5zwWPbxoKKJbKF9HnYBMEJWch61cnAHjw9A9F6R59ODle
         /6ycmoQ7IxQr/JvIGoSYL0B/rY2dOjFJRLrrFehQYpxA9zFPJw8YohJ20lkJMojeK1v8
         M/gBa+NsGH99tbOIUdQgpibMw1LPhEGaqFfovYo+VKp/X6kv1+deCcmf4hIJYHV5AMlj
         RGN6iS9s5bF2sPpeEzGsakGoPgtzxNMPJhOskQhJXzUpl4/4oyjuYutUD/6lwf7s7EHh
         0QA55NjCeGenkUYiQvB5P8vgE8YgCbo59QYohSirur3vkdbAhRq4Iz6vyFtI+yB9QlKT
         Qq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804575; x=1788409375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7U1BnFeXoGQfM9V4KkXP+ZPWf072nK5WtXag0RShRII=;
        b=Zj5Qm1IJ8TFhsgjQAEZgRkV1kmxPObZUjiPGG6vgGIbe7LKtFnyh/ob/WP8wE+NGk5
         FBjlRoSJkcrBxmb86WKeqxkw2i4hdCeZZdfQv1EUOr+S8Jf910AVD/BFEGC2rJXCsIj6
         RM5M5le+1ziYq736B2pwW2wvFefYoJYwDtiqgVX+q2FO0FO0tM0qBNV6lMhcrkXuyq3m
         dmNM+03/UWAdiA5mvQhBp+3JvtPDwtpFFGm9lkWsCTTPZJ1AiLrdzudtgQsik3KOV3aW
         4s5otHMrRGVnShuxZbsgk30BGOo3HW+J6xx/EzQnBfebxaiU2mUaM6vVrck9rdhp+CVZ
         hNKw==
X-Forwarded-Encrypted: i=1; AHgh+RqOQhOsMGiFj0kP6GTrjDruH37KNuIU7ujvY3nfiR2oD3ydagK2l1OpzBoHp0cec1GE7X4jCSY=@vger.kernel.org
X-Gm-Message-State: AFuF++lB/lAFBm8W1mGAOCg99QCtZjyuFcvQoZcH8MMCGGZJVHux2IB0
	FkO3je9eRZcDrOeLmCah54iEQh4uthiBOqOHtpo7pffWBXpYoch2VYiej80JyA==
X-Gm-Gg: AR+sD12pTnR9Amr/Ckksp3rhZp/X7355brCfOGKVv1tt+vwlfjPptvuYg2CG2FLgp19
	ST43M/1e9mKYzIoj47ieBDydO5qlqUhZdKMLpI9zEYbBQ/0xGNzaOVLONUa8rDItEh8PNwms3bY
	ulVcMKnWUwRskj1eJ1EVQizVyyeGQ5yFGH5eQOK3ZOqxgvQmnhnZF/yAthJ4hoYYv1KsJQMcR7U
	8aGszXPRN8U789ddJkefAWV+AfKd9sqfp36XhwiCt/vhO/onHvvS0wDX7e3vFyrUdqpqNtQMkXq
	N6lufavzyUvJaNvNYwt6zsXMkLIMe0da1HQW+jdZoTO8KN9aqjVr0yM6IykPyv+Ksygg4PDcfSv
	WVijayh2fT2VdVkqo7FMLG8Zt3rNGXGdz4vXQZqggyGHxrE0td8tVICRjryDJJriFyHl9boFyjT
	aw7qjM0lGaIuxZcyyGrQtwRiBSoVvJTJjS941Tue4MbVRT3ijAQhb4RGJwcqvRO2iS7A==
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3966d4587b7mr25543337a91.12.1787804573880;
        Wed, 26 Aug 2026 21:22:53 -0700 (PDT)
Received: from Default ([2409:40f4:1012:4330:756d:2890:a615:2db9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm19697942c88.12.2026.08.26.21.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:22:53 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: dwlsalmeida@gmail.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [RFC PATCH] media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail
Date: Thu, 27 Aug 2026 09:52:29 +0530
Message-ID: <20260827042229.12561-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to unbind a dvbdevice that is in the process of feeding
data causes a UAF as we free the underlying device without
stopping the feed first. Fix this by stopping the stream first using
vidtv_stop_streaming(). However, our codepath in the reproducer
(mentioned in the below reply) does not decrement our users
(dmxdev->dvr_dvbdev->users) to 1 after it has been incremented to 2
by our read() in the reproducer, that is only possible on .release.
This can cause a task hang as dvb_dmxdev_release() uses wait_event()
in the wait_queue unless we use a close(fd)(in the reproducer).
Is this a problem? Please advise.

Reported-by: syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c7fc4794e59786f5b4dc
Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index fd69b4ee16f4..98d918c7f0ff 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -550,6 +550,8 @@ static void vidtv_bridge_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dvb->feed_lock);
 
+	vidtv_stop_streaming(dvb);
+
 	for (i = 0; i < NUM_FE; ++i) {
 		dvb_unregister_frontend(dvb->fe[i]);
 		dvb_module_release(dvb->i2c_client_tuner[i]);
-- 
2.55.0

