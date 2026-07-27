Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051713D564A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148873; cv=none; b=BTgtPeqRnCRBHdV/1DDucKf7jiu/RjBjgkbDKsOMjZzfSo+9ZVIKyLQvrOtmULTl1uQRH1gONi02NDRwuTDc8C4aqoywMMwFA6qY7zZ1vN8kBYn7Rga0GidCbPiJy+j03u2+pPTrXjSZ0Hl5n5SDO0qs4ozZ9IAOyjokEi681dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148873; c=relaxed/simple;
	bh=TJn2JwOWmnMJdsvB3Ml+tVO7F1bpXcZCz4SN80OG2bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WN3HuLEdX4B7HOwmAJ282IOLDtzbucK4SZeLrBZz3Dm5ESJ7SRKSTS5b6dvNJcYFw2+hE4kKbdpjbSczfRn1cMakGmxSo1QDfDAiKVjsJutvNVG3MKHR4Ru8m9VCsSdIU2x6TxG52QYBxQXP8Wc6MsYA2N1jnwE37cw8PBP8iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct36AGQn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct36AGQn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2319623a91.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148871; x=1785753671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkqx4nE94LNudhI5+qXIvn8wfCUZ/BJzUN7nEjdkHY0=;
        b=Ct36AGQnhuWCuZ5uZ9olSSb6BWcA/kEYZt5p9SItRwA5RVJDg/PtjFUHElWbPuH7Uv
         3a+kFFUVnkpIy8KitslpPaVuWVzTEGmuGuhB9cnYGUOej29NE9oeTobxEY8YU08GoA8c
         GhD08ubC33K0N+XrVKhYRC2E6mMp0q/W2eBWVFc8tscaw3Y6Tdr5P3wmkguPCYrtfum6
         MtzMewb3Q56tBknkowtA2st7spccIWvo0YGAuevrYzUMMI9GekAkjJJIz5LQSTXByi9j
         C0EyQ7/Z1f25pcgbe85OU2wnS/W1axglNPIjmK4qyxmVQDyLx0mDCUtS4+MqdunIX3ml
         KIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148871; x=1785753671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkqx4nE94LNudhI5+qXIvn8wfCUZ/BJzUN7nEjdkHY0=;
        b=ZzO+EHDvfSPyGlbkGzgVK3Qq3r1tbFElZZojK/xV8BMeXis0tYVViTNpiACFWzBrrb
         jvvtuhQWErFITH8VY1TeEOOYTsKEP8bGtTcPuBrTSwHnvq3Wjf50PKp/UZXhfTfqt/0d
         MuUMxoEbxwLEgxkrumBJgU5IjCljmX87uLVjHScQxlqgPQqE/SW26+l3sk10o3aWYCn0
         wB60DytUpy4h1g5ofXBs4G4++kBGsK2+TvUlvaBFckbyQZ+LwYc+IQA6uoY7r0NWSUYd
         KYy+ye3QA9ob4wjqP1k4PXYpYP7EesbDl5wrqCbzJfnCq4ywt8T/w1t36iH9XdAgQhdu
         tbUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWMC8fxvSdigCQYpqtDhESKxBpWVQi0YadHNv153ncYAZcUQWwxb+wqw0h9kWPYS+pNTu+dZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXhzmKjIX1JIOrNcLsOIzaFVLvzzbG9phRWFBHgFYn/Nq19PC
	eQcVzeCl31um0Jvc8of0ak9hg1qywNJQtxbahzgykgGdkvzs/Dshjyk3
X-Gm-Gg: AR+sD11hT3efHlEFRkJb4hSRonKlm8afcZIFCSfOzojaJUAP8tf2AcBjrQxhPLneMa1
	CsWkc1l2EzEmTPlebqVBTIGoPgn5NaBBKuWetdAjFTfu/bB7TjVDaEp4AqgoarggQ59ng0KFqOA
	Vp2ElY07x2q8ng+HAkDrhQ5lnYFsZvJA0gzVLkifjA0c/SDUo5CrI/u0TJ+EIUwB7JRoRROH1RO
	WKcE/pl7/2fV/tZb6aDmSZFHNy9ItNURRNchoVnhxy1OPls8ayvBdrm4kar28R7mHisrV24Wzb/
	kPXZvxnD5H+LvkJLAIWevU52HHMuTBccrTmEPs6n2yK1VL6qGswUr1eYjREEjGdHnlmCP4ss65R
	9YtL3/ETWixZXt4EFcj5cwRyGRNsxEobfoqP6jeuroGUYg2zBbrQhM+rNTKZOg5KQqnpMsoLEIS
	SlHRnZXSP8xoNCUO3jtChECh0Aq/LFQYCGDhjnxL+ysIMVVrtGIyy2Nsr10dchGS3NHczT5WQwo
	dsjheH5UOy8nR+ks9I=
X-Received: by 2002:a17:90a:d607:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38f294ea129mr7808326a91.14.1785148871248;
        Mon, 27 Jul 2026 03:41:11 -0700 (PDT)
Received: from 7cf34ddc0813.ant.amazon.com ([54.222.46.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951f0afsm2901041a91.16.2026.07.27.03.41.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 03:41:10 -0700 (PDT)
From: Jiazi Liu <jiazi.liu1984@gmail.com>
X-Google-Original-From: Jiazi Liu <liujiazi@amazon.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jiazi Liu <liujiazi@amazon.com>
Subject: [PATCH 1/1] ext4: fix incorrect function call when initializing s_resgid
Date: Mon, 27 Jul 2026 18:41:03 +0800
Message-ID: <20260727104103.28916-1-liujiazi@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __ext4_fill_super(), s_resgid is initialized by calling
ext4_get_resuid() instead of ext4_get_resgid(), resulting in the
reserved GID being set to the same value as the reserved UID rather
than the value stored in the superblock.

Fixes: 12c84dd4d308 ("ext4: add support for 32-bit default reserved uid and gid values")
Cc: stable@vger.kernel.org
Signed-off-by: Jiazi Liu <liujiazi@amazon.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6c18b5adffca..a187112cafaf 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5380,7 +5380,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_set_def_opts(sb, es);
 
 	sbi->s_resuid = make_kuid(&init_user_ns, ext4_get_resuid(es));
-	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resuid(es));
+	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resgid(es));
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
-- 
2.50.1 (Apple Git-155)

