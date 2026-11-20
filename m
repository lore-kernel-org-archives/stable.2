Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212266;
	b=CF2QEIqOtbu4cftW2PMyPwwtFheEq2MW63lXi585JdqihE0ZgrezwYrJq2wb/+uCzWGe
	 HGhveiBTNzC7Ko8sRfRHN8ppI8sGBysM7qxeYuIl0CbPTShfhe7dqQlonJIkw/H+Q5GSL
	 GVx7kYTu3GEXtnXN6SVlD3gSuwbKnWIZhW6alliWU5uXj17aGZ1Hyo+IxERtD272Ehci0
	 YmsXSaJgNYDIVD5CqIQArWUqItupVUSmDsSvrkUYZD4VuxvwEbQxDgutblEePezDa9EcJ
	 OqBmq4+7Eph9LdQDyAWzXHLguJaTFa2FrgoPV+00kWQMTsLzM9nAr77WC7uMISgwr2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
	b=WjDMHN2qCtSxTIeXstwHsaYkC8rDVWDpXdINlLumRVnKM+0KqdCZ7xfxtWJ/CjbhSOk4
	 d0MmJVYNB2CLrQOf3B5XMcFNyFnJ0T6UB1mbO9TBBs+njsFQfWmNHukTCnsqz6HewDpFr
	 468hIPh8F2WZzoFZSTlGEZSCtz8S/gAqMCE4jYh+d2e7lGbUI9t85U09u33CdEAvsMTcg
	 HB7Yk97kouU94FT92i5O5hpz3v1rXTXkQA0iJrRYeV5NYYcRFZvtiTdkcc6eCIAAnDK8g
	 dLMhUCJooAA5ONlFKEmtbNAPxQrGVCf51ojbAKxLyzjO2UPfKk9G6zOCIyC9uqVwKtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cg+8Bhwg;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45318606A68F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45318606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cg+8Bhwg
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a9be758734so889696f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212263; x=1795817063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
        b=cg+8BhwgWbN2VZWtTAwg5us6kIYKWVDH3XaOE5L7EweTD2fWI4FPIVM5Gpk3DZ0Dz5
         uAQOwVFUx4wAO6fS+ImuvU1Irf84hJ9Wdd1qy0HBJx/JKpLVUNXbFEuU8Pdfmyfgg2W1
         ecX0vZQo/hmo2KrLnsd/kHP3Ub3QbLLYxraLlMQGCxaC/ZT/TtIpmS7blfidlkF7/OY2
         GX9R2t2F//APRQXoeZYDiFg1I3q/LXrsZxOeoiyISxjt/ybh6IwjY70Li7N3j9GcnN8i
         7LmDxTrITawHLsTvrgwpVe+FMaea4NuPEuXt8D+rDQ4Bi5GzfuKFRr47kpGG/sTWmmeH
         6mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212263; x=1795817063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aa7qEaxeOlG6UrT9v6iaZAnn/jfDxPey+mYNfYgCTvs=;
        b=yELgDlJUcr3ZkL9q0LExJK9W8sXtQo5L8aM4CQWI/WBEIEoFwdWbhOXcQaBpHXfuLh
         ow2nYonjWQEGHnOUBCyc3xMcE5eMo2S/Q8wWKI1E16ro6UyUSOCa5cdXrFMYlg5pjeKK
         WLBsZxN2H1y0RWkUzk4XsHd2x/GgSB+efSH2/mIq8KzGknvVuZA55VydNwJbPSAsyHi4
         BTr2FUX277KB1T/TJqxyxuZsWhFp5UCGXg2xJHC3+4ESEK2ZNYanevJ2gQ4RWUkBDEJ9
         B7zpmhXsFEWDUpDvrotxpDddK62IjnCu1kvD5MYhpvyK3CDvFK7xJGbv4WOydf1XCL8a
         4LCw==
X-Forwarded-Encrypted: i=1; AL+hErGpK8K7uqdkuOidssVjVH29yVI4LcGRoOkoBUBN/Nxa3lXRL/4NDDyh6lkKZGQad7Pqq8qi5Kg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9070turuMuMHU+Vzx0mYvbbNct6t/fm18VxwI21WI7gEXJr+ZI
	BeNiJhpic+FaPsiI06MPZaz6sj5xqLwGiEFCJbqZLpZGh52kUkG5017O
X-Gm-Gg: AZFdTZf88o8oGfio1i8d4LEInH5oC2xGkFJh1kAmk21qPu81rAiRmK+kF8SKicv/S1K
	4q+Fj0ol7QcfDgBBg8SRRjJmr5m9wOhqQSvj6GxyvtmrCFHn6J+0zssqndkvVY7MZUnVSlT2x4T
	/Ag5rapfQ9vM+Gwmoz+kcFnm4lyzOzyEdt1keQiSgbKFTRpIqiwcNP+7aTQm+20KJabw5wh4vZE
	Q2w96Kyz1rJpUsXcY4qsTx1/erLtRmvfXPkGUrOV1jtKvmpxWoTMd+mHoiXj1oQ0kKAz9kqa7gm
	/ePsWX8mAW/gYTpdUBOQKVILVxkoFlb/TWEjTE7J6gY9M4xUhSZqR7Lnoq4a1Rg1IAMy25YT+u+
	phCHlC4Nnt48g8vAWThi2zv+36Qj9zvipDHGiqnd1Fuu7A48Grakxox48F4bGBk64C3xn3ODSOZ
	y4iHw0ehTHxJdLqAdJKCzI37DpzMNKz1u3BQ9VVwxXH36gaJvbUr6JANX2l+glXL6FDr/MSauVE
	ryBtv3EpJ/msEUsBUZ1Zn/OeDm9tT4tMDEzzAJ5oqGXoR5Nn4fE3F0U8yIs5k2BFZC9MgImXN7H
	kaKlvYmoS8sMQLgpf5HpCXHYe5oZjX4aR7wPYZ6CKDQNFx4UdgX/0T2A5g==
X-Received: by 2002:a5d:588b:0:b0:48e:66d0:664c with SMTP id ffacd0b85a97d-4abaf64be12mr10171630f8f.15.1795212262648;
        Fri, 20 Nov 2026 14:04:22 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm7156629f8f.23.2026.11.20.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:04:22 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] qnx6: fix divide-by-zero and silent magic check in qnx6_mmi_fill_super()
Date: Sat, 21 Nov 2026 03:03:54 +0500
Message-ID: <20261120220355.137600-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

syzbot reported a divide error in qnx6_mmi_fill_super() when mounting an
all-zero block device with MS_SILENT and the "mmi_fs" mount option:

  Oops: divide error: 0000 [#1] SMP KASAN PTI
  RIP: 0010:qnx6_mmi_fill_super+0x228/0x870 fs/qnx6/super_mmi.c:68

Two issues combine to trigger this crash:

1. When sb1->sb_magic does not match QNX6_SUPER_MAGIC, "goto out;" is
   nested inside "if (!silent)", so mounting with MS_SILENT falls
   through instead of aborting. An all-zero superblock then passes the
   crc32_be() check because crc32_be(0, zeros, 504) == 0.

2. The second superblock offset divides QNX6_SUPERBLOCK_AREA by
   fs32_to_cpu(sbi, sb1->sb_blocksize) before sb_set_blocksize()
   validates the blocksize, causing a divide-by-zero when
   sb_blocksize is 0.

Fix both by moving "goto out;" outside "if (!silent)" (matching the sb2
magic check) and validating sb1->sb_blocksize against
QNX6_SUPERBLOCK_AREA and sb_set_blocksize() before computing the second
superblock offset using a 64-bit addition and s->s_blocksize_bits,
matching qnx6_fill_super().

Reported-by: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/qnx6/super_mmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f38..bb4243872 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 	sbi = QNX6_SB(s);
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
-		if (!silent) {
+		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
-			goto out;
-		}
+		goto out;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
@@ -64,12 +63,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
-	/* calculate second superblock blocknumber */
-	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
-
 	/* set new blocksize */
-	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
+	if (fs32_to_cpu(sbi, sb1->sb_blocksize) > QNX6_SUPERBLOCK_AREA ||
+	    !sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
 		pr_err("unable to set blocksize\n");
 		goto out;
 	}
@@ -80,6 +76,10 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 
+	/* calculate second superblock blocknumber */
+	offset = (u64)fs32_to_cpu(sbi, sb1->sb_num_blocks) +
+		(QNX6_SUPERBLOCK_AREA >> s->s_blocksize_bits);
+
 	/* read second superblock */
 	bh2 = sb_bread(s, offset);
 	if (!bh2) {
-- 
2.53.0

