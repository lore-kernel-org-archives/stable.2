Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D62E22B5
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783148305; cv=none; b=Ya8SWzfJClpwXFr5NDtvv+g5SjCMHcEPR5CFUnkdMe4CaLOfuAy/8UiZVrcqWUCqLwkShQoWubX5utCu3dYjjMMoKYW/EPcUOixU6eDx2/0E6DZIGTbi7saHnaxdDpvb8GLr4Gu++Jr7bxL4T1s19WJa4ES8ZTY2G7wNpqGhojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783148305; c=relaxed/simple;
	bh=cBcc7ErXfRFr+J/7vYzLtp7sZi7PCKZ7EKoS2iHzJC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzXMkr1pmQ1Sj33f+I+7zPaHNLmtZKVoeb889pdYerKElSZjXQ3n2Ht0LkkVgcv41Rmav97TXfxmyRHLT99+WNYszr9jWIHWibNCiv29A9UGKml16JR1koy6zRYN25aAmlNKrvR37A809FSgIzYq9jH6Wu4J/3XMQzHXay2cGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMLSudnU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMLSudnU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so10169225ad.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783148303; x=1783753103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzYCbb8eQnCwKeqzpjwTQYnkWDJ8B7MI97un1VYHv7c=;
        b=jMLSudnUoDZAh1D6kx5LUJcKYHBE1TSiTmUxKXB5sMMvcIHuzZuC9CDUOCyFzx7sPo
         k21XLofKK1KT8W9qh+NOyPPB+rssbc8MLa/bWq5Z1akociMW5mGxiSFLZM3dfYxFP5Vf
         wlFpwpfHsSv032A6Gu+LX5Uz/lNM57LKxOL+Bfs9f2D6cZ/mWgMIwpOel2h0Srd1JUpw
         VcQtxCT1qnHetc6+hMvrRdA+ZR7A6z3iqF3A9sM7HddgEtmJYeu5zB404vbdhM745L89
         oaZE30t8spIUfjLRtWCi9oTfQpdxABX67s/+bBFXqkjXr1NNmF2zIj/ZJkisA6zQ/Ltc
         Sl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783148303; x=1783753103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzYCbb8eQnCwKeqzpjwTQYnkWDJ8B7MI97un1VYHv7c=;
        b=nZZ9eB0wi3uoq3s56IpKEt9lLrHrV9pqJ6XHNIHSDa3bKyKc97RiFNY825PPWtho9q
         kudzCQIbJFEhzOy2COy/WUVzAJD2BachmcbQClxhJ/WyZ+YV48XJTr+JMucqZEiqKui3
         RBSG6AzoZZ5/AbeFF9g5ilQ5gw19S6oKZmIoS0E0xBTSRSpznRQNldVea3b6ieX1H5Yc
         i5jbbS/yDfdfBdZnmwQeemXdKvHwvUlMHqg1akBqzKYXIiurBHRoUivxaOU6kDVUUVFT
         it0A8bE4oHD2ZOjRy1nAmAjtqZKDSoY+8/D28ne+OY/xNtpxX6yHEdfwh+hmugKdWiCW
         +BMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPaqTmFII78uVzDs1/gJJVwo4T7JEhCMBy7dTyk3QspxhcIR1jClNanbnawbYaVJ4gQS4jrQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCbIXjEhA9g+JROANxLvV96LLVaRht7MwCXlhz81oHoAM+qQp
	IrB4ilSxXeDxMdkABpms0h3t3ZrUvstBffCY2O4mvI4YYQGgPLciswlB
X-Gm-Gg: AfdE7ckCM+mu7LvOrtT5osNq6kOpLV5NZ+bANlvIprmapU8nqvIbQ2tMxq/AIBbixqF
	R9xYHB0E2q0zvx7fPBsllwuVrpit6vzLksR8G6s5KyHCHc3JoyQ1+yq0R2iLtpptoDcAsABqIlH
	C8U70otJH39lFTUicQRxSOUJ1NqBBdyo/MEqFCGGNRzx9CWRHYSsyf/AzJNnLg6ZpA0Adh5NIfv
	ZhS9F0firLj5VEwrr03lAzYJjQeAcwHYDz01xceSM6a84mzMwO+L72kmHIm62uschgOecVwQI2y
	ve8edIcBj/sytIdxI14Ma8kipoYBX2J0Gh7DASqdIw0QnQ88MBI0jAbtTiMu5YK5Lvx2tf+MV5O
	0IPiblpGdTkLUHfWzu+wg+q5IHABUE8BcffAn/EKTi0yWlvsiwsZdq+02q53QuJ5qhkgpDsF1m+
	ft77F7OGpEVJsN0bO07LPhjORPlmoJtnWNExNTiqL3nsiJ
X-Received: by 2002:a17:903:46c6:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2cbb201b667mr21145145ad.3.1783148303405;
        Fri, 03 Jul 2026 23:58:23 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([101.12.233.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad712ca17sm19526275ad.28.2026.07.03.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:58:23 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nadzeya Hutsko <nadzya.info@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	stable@vger.kernel.org,
	Martyn Welch <martyn@welchs.me.uk>
Subject: [PATCH 1/2] staging: vme_user: fix location monitor leak in fake bridge
Date: Sat,  4 Jul 2026 14:58:15 +0800
Message-ID: <20260704065817.403111-1-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fake_init() allocates a location monitor resource and links it into
fake_bridge->lm_resources. The init error path frees this list, but
fake_exit() only frees the slave and master resource lists. Loading
and unloading the module therefore triggers a kmemleak warning:

  unreferenced object 0xffff8b8b82aebe40 (size 64):
    comm "init", pid 1, jiffies 4294894572
    backtrace (crc c1e013ef):
      kmemleak_alloc+0x4e/0x90
      __kmalloc_cache_noprof+0x338/0x430
      0xffffffffc0602246
      do_one_initcall+0x4f/0x320
      do_init_module+0x68/0x270
      load_module+0x2a3b/0x2d90

Free the lm_resources list in fake_exit() as well, before fake_bridge
is freed.

Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Martyn Welch <martyn@welchs.me.uk>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 8abaa3165fbb..434cf760ade6 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1239,6 +1239,7 @@ static void __exit fake_exit(void)
 {
 	struct list_head *pos = NULL;
 	struct list_head *tmplist;
+	struct vme_lm_resource *lm;
 	struct vme_master_resource *master_image;
 	struct vme_slave_resource *slave_image;
 	int i;
@@ -1268,6 +1269,13 @@ static void __exit fake_exit(void)
 	vme_unregister_bridge(fake_bridge);
 
 	fake_crcsr_exit(fake_bridge);
+	/* resources are stored in link list */
+	list_for_each_safe(pos, tmplist, &fake_bridge->lm_resources) {
+		lm = list_entry(pos, struct vme_lm_resource, list);
+		list_del(pos);
+		kfree(lm);
+	}
+
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &fake_bridge->slave_resources) {
 		slave_image = list_entry(pos, struct vme_slave_resource, list);
