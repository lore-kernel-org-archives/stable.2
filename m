Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C376395AE2
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217523; cv=none; b=Wv33iTxB+/cTl7kyQJob9h7DzH4u8uSeOx7E2/L5opQkS+RQK8lsxbGRNdGZa5iSpPbT6q9aN9vkagkV+xKt439flgMTlof5FMKKZX0SzFZD2HGy5Eb1EmRSI4sZkVGE3G0eMB+HJZb1IVle9d1h3fNbby5mKQPMcMrIwbrMgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217523; c=relaxed/simple;
	bh=KCziG7//heAzsttLRr5AYtatuxq8sxDYWfLJu21jOCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBK3mgVnwFHeGl/iIdhojxy3KOJl0Czabcbwl3/U+J2DwZgfrbbwPCgamnACK1LSxaF3smYjMmOidMfIYbzguxlRv46iyiVgYglraDujqCGxz3pM1jcFvlr22qgZrNDDyEaUu2iliPILu/ctgaZGUAcs9hjV04DJwjjg3s4KKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=I+u110QE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="I+u110QE"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df31840so3347306d6.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781217520; x=1781822320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDN0JercPfVAWdK5kAF+f2W7AxWUT356/ZuCxrJL7Hk=;
        b=I+u110QErD2AJ64+fk8BbuBsihaAS14YopSOfpQpIvoZqQrtYJZsA2tAwdLddusTV9
         whNTeepYLa6fEe6HNxeRUcSZC5AH8i+YLXF/YesA1tvGb6S0hLMj2Cfvz2GiVJJBdmma
         3opnXQWk8tK6r2+R2GpKIVHJTNYrmxVgR1mXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217520; x=1781822320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDN0JercPfVAWdK5kAF+f2W7AxWUT356/ZuCxrJL7Hk=;
        b=KCCV9Ib9JBXWBcKpyUCcbg75c4+9JwKfxOiL6nehqr8e33YdGIuZ1mY8e/Wybz5Wb+
         +OheQ83Em6wAG1sc3BFbMJjnkveHQPqRmrLn3TUtvHUzfbrT4/dZLO9X3HfNgK/ALboW
         J1q4qFRV43P+Cf9Xp4WCbvBVW8iElNaOLVZwzsjbXiBAWxqvSmpa/jwpJsUDl/wqoikw
         nPKP6gYR2u1fdqXDQ4aACFActkziT18LmRcqnQY7NBxUjTm9AUkBoJJHBZIFrrZxmGQO
         ngQh/PNXlREGsZcHAUq01Br2jFaRvpmOPE3BPQo6o/IrY54HXh93C3LBH4oJYFhj8IEs
         mo6w==
X-Gm-Message-State: AOJu0Ywz70mryChZl4q4+pZDNgOHyP+R1BCNB/hDjd1zRVf6OehmUBBU
	FNwn4SvdNSBx4NUXlMg1quLhWhNwv459zetF0+dGbBa/leqYrdVE1zF0LUILkcoCVqQMlPsyxgh
	iB3oE7T0=
X-Gm-Gg: Acq92OF4NNkugFuewPgoMK50yIh+3lTTcfE6To0kJ/GG9OlXITF/4lJYAP58D4iOGfq
	D81sgzGuRwXAI+TUJktESxeopBy+OiP85HkWQDyRkB1wXXOjk11A6eRKal70DV5EdyvHKpfTF8i
	X6/IVK8hxG01WG0G2B99axxAE6FijCIQtVuIJprLVVUCzqQQzLD5D1xfg1K0+yyWsMlTmIs3+yo
	MXox6hL665MR7Vi4rjeoJP08RJGYRuSHv8WZplrXcv4CcpJ3bfnEWwTr48jhsJn8TOd/6V7aXL3
	ByF0ye4iELDijeqrO/B5Bv4TOPrzCd6BOOl+osPqltCT6tU6pyTfoCcAAXop6uJZpfzwKWduSYf
	unqsST6MAqgnFyHlyha40wJ+S/hhlYJIqItZPUtZd6Am2on46Ffzg7KammweiUqCvMNoIYKFUJr
	12DH4a0H4O2AzhmHX21rWtkeQtM5WPiUP4ATFB5mEWEBcrOMso9hOfjMWfdegiPYmemPkUkDIWN
	pu1jevqE0jxsIwbxvvctRk4kwpmbTkTpeY=
X-Received: by 2002:a05:6214:1d07:b0:8ce:cc34:e604 with SMTP id 6a1803df08f44-8d32e4fc533mr7675926d6.35.1781217520166;
        Thu, 11 Jun 2026 15:38:40 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302211f20sm6295696d6.21.2026.06.11.15.38.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 15:38:39 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: stable@vger.kernel.org
Cc: outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH 6.12.y] bcachefs: validate disk group parent chains
Date: Thu, 11 Jun 2026 15:38:35 -0700
Message-ID: <20260611223835.73757-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disk-group parent IDs are imported from the superblock and later
followed by bch2_sb_disk_groups_to_cpu() while it propagates live
devices to their parent groups. The superblock validator currently
checks member group IDs and duplicate labels, but it does not validate
the parent field of each non-deleted group.

Reject parent IDs outside the disk-group table, parents that reference
deleted groups, and cyclic parent chains before the groups are imported.
This prevents crafted superblocks from making the CPU conversion walk
past cpu_g->entries.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/bcachefs/disk_groups.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index cde842a..52a0f44 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -26,6 +26,7 @@ static int bch2_sb_disk_groups_validate(struct bch_sb *sb, struct bch_sb_field *
 	struct bch_disk_group *g, *sorted = NULL;
 	unsigned nr_groups = disk_groups_nr(groups);
 	unsigned i, len;
+	unsigned int parent, depth;
 	int ret = 0;
 
 	for (i = 0; i < sb->nr_devices; i++) {
@@ -63,6 +64,34 @@ static int bch2_sb_disk_groups_validate(struct bch_sb *sb, struct bch_sb_field *
 			prt_printf(err, "label %u empty", i);
 			return -BCH_ERR_invalid_sb_disk_groups;
 		}
+
+		for (parent = BCH_GROUP_PARENT(g), depth = 0;
+		     parent;
+		     depth++) {
+			unsigned int parent_id = parent - 1;
+			struct bch_disk_group *parent_g;
+
+			if (depth == nr_groups) {
+				prt_printf(err, "label %u has cyclic parent chain", i);
+				return -BCH_ERR_invalid_sb_disk_groups;
+			}
+
+			if (parent_id >= nr_groups) {
+				prt_printf(err,
+					   "label %u has invalid parent %u (have %u)",
+					   i, parent_id, nr_groups);
+				return -BCH_ERR_invalid_sb_disk_groups;
+			}
+
+			parent_g = groups->entries + parent_id;
+			if (BCH_GROUP_DELETED(parent_g)) {
+				prt_printf(err, "label %u has deleted parent %u",
+					   i, parent_id);
+				return -BCH_ERR_invalid_sb_disk_groups;
+			}
+
+			parent = BCH_GROUP_PARENT(parent_g);
+		}
 	}
 
 	sorted = kmalloc_array(nr_groups, sizeof(*sorted), GFP_KERNEL);
-- 
2.54.0

