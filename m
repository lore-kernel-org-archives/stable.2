Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5E3B6370
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547145; cv=none; b=HeAc7GEg/wePlcHrJENm1MZIn8JlwZQJvdJ26OniTI9g9GeUptNDOCqlojRd9nTxTzsbkDWNhqd0TuM4CbJgVtRz8La5pvT9JqObOUvSdUmvijTbhrEv3VDco0iR7L57uejoTKHR5V2Qxzcv8xF6uikIWznjDDE0ybAiKXxIS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547145; c=relaxed/simple;
	bh=q17hzmGJa7asagj01Wj+Lil19t6BY3cAjNvlDBdL+sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8oaSK4cJU1ZYh4Ahqy72WeOOichkCJzIguh4Dr3SjOpfk/j7heP13VKudkY7bDq6oN02BKDAMv2hJI3bU0dZxF8RWF07Ui/qKpx/bpOeFwi6Cs9EZWeaw8XVkEaQwMa0aNgTexTtXoZr9FiUEGTIONrQdn2kt9yoccY4a2O3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx6ip7s3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx6ip7s3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954dff6536so16524235e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784547142; x=1785151942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dqbsg26ABj7eOdNonxG5QwFjKanK0ihJjv+Ud/fidP8=;
        b=Hx6ip7s3K686fHfzH/mNZlYpMSDXLIgR6o6oQVqJK/fROikuX1/j7tP/4lMYf5avVM
         JYcEc/wqp2t0RqJULDaf7jpeRS8IhcqIDAg6O+S8WJH5mK9RVQtk7Sl6/9vdit9eFHb4
         jifF7vLNuAA06PjN6vIX2x+Hm1mG1SVW/IXndB8eJUwDuzby4qQ5i0CjQR+c6OxDujD+
         3xUfiy814Pt8yIGAy93eZm0lQhFZDHIFvrgQYnCDsj3mD6w5OA7kwM4jccAounceHX8I
         WDBrHa5ueQ4eCvozJMztLyWSjSJmDFM6U/i4Jc0SsEJnMnPABWmdzZGC30Q3L9uoOQHr
         K0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547142; x=1785151942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqbsg26ABj7eOdNonxG5QwFjKanK0ihJjv+Ud/fidP8=;
        b=Z3kkGLC0wANSn0qmCsijYLVfNFxMtN/wwGP1KAKQlOpG7/cuWxuzo0+08k9sibZBHy
         5AsheWeeFaETdB+PwqFGF15O4smpU7Ugka4Z6E0FKQy+vP3CJibBgg9KHA2yjlalwSkc
         RzKsldnNzlihQ05iow1Y0tR4fldb7fAwVqLLJ/B+9ikk+weD70CYscxkXjIaTIHmq4KP
         Y9i9YX9zhn1oVzK1iFadLN/ZRQ0fAe/nLanDTjx/y6CiaeURMjKBVd/3O6kggmb75EjI
         9Sju/7oZqeh6KgC+IHd6y8PPXq6PteBDU/DN0JUNAwdeqnNfWjrtbn1JkY4nOsB4O4Sz
         ZLrg==
X-Forwarded-Encrypted: i=1; AHgh+RqW+2bZV3h9mMvIKEQMfVtcnxIipgqrvqaA8hu46yOhu/V1W2RtySwrImdWF3+7Btyd0A/1eGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHQtXPF7PIQn7P4Ocwp2l9Y27o8Jxqi4JOWKYL2rgU8XhPtHY
	UMd9vYA06vTFx/oWRAEqieDOf3uBLl7Y0vNN1QEEwIb6+i/YW30qfN9q
X-Gm-Gg: AfdE7ckDtXdRpIX7Xi2E8tn4dxSmJRwE1kBpHKkoQQjh78inYE0jdx/G3+sJvBznO9b
	Xm03J888hkVsqVAHt7skN9kjilkPr+TCB9WEGrMEMpjgcXglDbsNg0ZWQ64RpIGdE/Qd7oWAZWq
	1EG1N5dgX8+60p131nvUydyQPZsBKZeqN4Pce95lqwbQw4yYIAS8DZDasHR9Qfi+y48q+a2m6o2
	KIFp0A92WswGo+pBVzl5NWRBU+B4KzJw9G7x0nev7l5byAh2Rc55W03IKZMcR69xl5rIKKImX0C
	5WXeaE5NF0RUMLw9Dv/DO9Aac27YxDg/3bxHOk/kzcFfEkJMsSYzLNGbGrek4uNM0I+d1amYmzh
	ppJT1cAX9ZMDfRWXfX/AQlFG0dgKyU6+giFgRaSqhE/0umbPWSFE+4xtVcCkIifEJVZv3RQ2hut
	LDj7gsQgJVjkEuiPMHQ9koTFk1JS/s+Uspo3G3oA==
X-Received: by 2002:a05:600c:630e:b0:495:4856:2659 with SMTP id 5b1f17b1804b1-4954a3db6b0mr153568145e9.9.1784547141812;
        Mon, 20 Jul 2026 04:32:21 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6980582csm21957014f8f.13.2026.07.20.04.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:32:21 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: harden firmware build-info bounds checks
Date: Mon, 20 Jul 2026 13:32:11 +0200
Message-ID: <20260720113212.11981-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_fw_read_build_info() checks whether the metadata range fits in the
firmware image with hdr.meta_start + hdr.meta_size. Both fields are u32, so
the addition can wrap and let an out-of-bounds range pass validation.

The function also reads the "git_sha: " prefix without first checking that
the metadata is long enough, and meta_size == 0 can underflow the NULL
terminator index.

Use subtraction-based bounds checking and reject metadata that is too short
to contain the expected prefix and trailing NULL byte.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 6335893d3f16..9d0e1fafdce2 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -709,7 +709,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 		return ret;
 
 	if (hdr.meta_start > fw->size ||
-	    hdr.meta_start + hdr.meta_size > fw->size) {
+	    hdr.meta_size > fw->size - hdr.meta_start ||
+	    hdr.meta_size <= header_len) {
 		drm_err(&ptdev->base, "Firmware build info corrupt\n");
 		/* We don't need the build info, so continue */
 		return 0;
-- 
2.43.0

