Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF894A92FA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164710; cv=none; b=oN3rejh90x3yr5jPLfO36qC7P6yEILlucHp001jBWSCJ8Pt7IUdw7xQc9cLnqpNxEHrDmVYB4U2jvzUWsz5SmPOGDFr1VGKnYGC7FOXOREePcS9X1oVRoBrDwdSdWkFDjXLTcY6PQWzOA79MWfpu7Ll1t9rHcTlpnwByT2BQhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164710; c=relaxed/simple;
	bh=ifTmuhdYEfA8S+Ti9vBnBv8jVJkTFG9fKTW/c6hx1FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPaNIYQqDWmfvMHsqjZmj0jdxQEDV7dh44owvN3spm574Xp/n3915lA0mNrLetV9k9zxN48DO0TLj8AexKQ5wYOCWNmRCt/WWKk0C5nI22ds5A/O0KDzuH0TZZx6M9Cl2AFMeqyhld5A2+82N3ltdP1JGfLgvzdq9UHCrVeHSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/nsXj3H; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/nsXj3H"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155fdso257612241.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164703; x=1790769503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibl0MHrnxFzM837MpKxLVego5yHxJdHEFJ+77R4ZX9E=;
        b=i/nsXj3HBjJwaFiK/WvcUoe4E0BCWdtNaiOYTgdmylvpOiqzO5zCoWqYW9DZOBvZzQ
         /TgnxS2Ii2BE9zExDNiwpW4bhRvMf7q+bP5kiZ7nEtX7xZWe3kTqlqFA1ZRcEPUp5I2u
         uX6J7M0+7HHmpe7+rJJnzqz41PoSVqeFdbmctI9Q2uUgwoQ7ZaCWcbgkf1hcktGz2Z0o
         lMKXA5E8u7xMW4SHvc87aORe4hSZVyZNTn2G8byfOqcY3uvcFaJtxNAiN+EHNvpBD09m
         eNzorVOgqBsSGo5JfTLE/NOs0HDpssXfelWQs3G4RGzv+7tx8nqDQLBLIIQOkxjRBMnT
         UbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164703; x=1790769503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibl0MHrnxFzM837MpKxLVego5yHxJdHEFJ+77R4ZX9E=;
        b=Iuqsfw3ShOgV7Ii/5mWVmcX/Y8BAHuvTleoRz67Ve9eGQlOMQbSV9WMmAZ/zJ87BSt
         21D6UOz37j6yK98Fg0XWvOJn/RZyF0KRS7bKo3ZGCJVa5uwGoh05GIUqqdh3DEM062CU
         CiMZN+ZdM5xJRhl05xhVoZY2FhtBgeUZo3wR0scwwrjcy6QVAv3LxPD2I2PO56Oo0ew3
         WPQohJY2vYOzt41yhaw13d27U6LGZsHisWJ/MdtbVP6nK/5cucRbYXGiAwfeu06X9De4
         Z52lmEYxdC5MGA+rhDJW2n3Z06V3QjnG+gMOhZheclTFq0AfobIZE4L3nddFq9LuifuB
         4m0w==
X-Forwarded-Encrypted: i=1; AKwUvBy1YzlM3kDT4tKusgbqKdORmZ7823MKaGsmLK2TGoWhTZxja2Vp3az2w7l4VkEfqBiD9EltnFU=@vger.kernel.org
X-Gm-Message-State: AFuF++kgyV+iquvC8dKZ2JJ6TNGsWhCq0HhyBrAGA/oUMGXW3AawnL/7
	Pl1FdgatilDKQAdokbYMaYhyzE825gvkbdXGaUJg+TfwIY7j0C1ZrazvF2qEOA==
X-Gm-Gg: AYBFou0FdJv8Tnrzq8Gsv9Hw7pcsLu/Z01M7Aa/L3Vu/bES9DL5d1he89SCupOHMrBy
	gdQ0XO/AAl7wVfrLoZ1DqJuP6as6gDg9229bzgSlTr5IvurekHr0UqFBRu9k7mD9Dl7+UzEci+h
	wHObl2O4cUpyeSRndpDk+SDrQO9XvKBOcoJIBq/CcLb04GZyacs3PT36nGF5njdAv81A+Zm++Dc
	h4GGOF5TQ4uox93YUkBDhCbfZVGUN3auX6XXnnHM1BQ7WSygwqSS+Zz1P6RRwJbvZeHEkR176IG
	rtsdWVjbAUurhiMxhhXZX5d6CqAP6f7mcZcKOfNfd2ywy5nXS3nh1WbiDMKK8kMVGEHBFGOKwNM
	bd7ujJolzGLucQgLvQXhMCnarjHFSiJSNIF+b6T7m0CYnKItAsokym02aqdN0ovCNxlKEPmeTgc
	pRsZC7NixsB23wump2l3O9dtiOJjzI78XrpiOAm6EKibXIvWkdQ/fOi01Jl7gSsjc=
X-Received: by 2002:a05:6102:f12:b0:79f:45dc:118e with SMTP id ada2fe7eead31-7ac1acd5debmr2043519137.5.1790164702882;
        Wed, 23 Sep 2026 04:58:22 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ca2876229dsm1091399e0c.3.2026.09.23.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:58:22 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] xfs: bound da-node entry count against the correct geometry
Date: Wed, 23 Sep 2026 08:57:54 -0300
Message-ID: <20260923115754.3196232-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_da3_node_verify() bounds the node entry count against the larger of
the directory and attribute geometries because, as a buffer verifier, it
cannot tell whether the block belongs to the directory or the attribute
tree. When the directory block size exceeds the fs block size (e.g.
mkfs.xfs -n size=64k -b size=4k), an attribute node buffer is a single fs
block that holds only m_attr_geo->node_ents entries, yet a crafted attr
node may claim a count up to m_dir_geo->node_ents and still pass the
verifier.

xfs_da3_node_lookup_int() then indexes btree[] up to that count during
its binary search -- an out-of-bounds read via getxattr/listxattr on a
mounted crafted image.

The buffer verifier is the wrong place to tighten this: it has no fork
context, and the transaction-less read path used by getxattr does not run
xfs_da3_node_set_type() either. xfs_da3_node_lookup_int(), on the other
hand, always runs on that path and holds args->geo, the geometry of the
fork actually being searched. Bound the entry count against
args->geo->node_ents there, before walking the entries.

Fixes: 7ab610f9e0f1 ("xfs: move node entry counts to xfs_da_geometry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: reworked per Darrick's review.  Do not infer dir-vs-attr from the
    buffer size in the verifier; instead bound the entry count in
    xfs_da3_node_lookup_int() against args->geo->node_ents, the
    geometry of the fork being searched.  cc stable.

 fs/xfs/libxfs/xfs_da_btree.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 9debb95d86fa..95ea3737eb33 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1787,6 +1787,20 @@ xfs_da3_node_lookup_int(
 		} else
 			expected_level--;
 
+		/*
+		 * The node verifier cannot tell whether this block belongs to
+		 * the directory or the attribute tree, so it only bounds the
+		 * entry count against the larger of the two geometries.  Here
+		 * args->geo is the geometry of the fork we are actually
+		 * searching, so reject a count that would walk btree[] off the
+		 * end of this node buffer.
+		 */
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			xfs_da_mark_sick(args);
+			return -EFSCORRUPTED;
+		}
+
 		max = nodehdr.count;
 		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
 
-- 
2.53.0

