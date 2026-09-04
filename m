Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D73932EA
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504886; cv=none; b=liRcGCukqkaehLpD0eiyskWIIyrks4cO+lHdnL0QBf6zCmMmE/eH+TpqbEz7tlNw3JsNdrZ3+8hyHd069ISJCYRhOsQMWtCUxjPU6C4lFbkKijRl/1Z1L5B3EsQXmCsD3qC4ozMq822KW/OpSzqj0sAttJ98ad18oxmHzup8yYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504886; c=relaxed/simple;
	bh=No/tqeKhj5vhBbZ9eGGNy9XM2YinBvrbqfjqRNEzjNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFiMruWSRGsF/Qz3tGKcA6CQ979LzZFRy1BSX5du6D5KxT8+7ep/odwS0hE/m0MhgEifugNhk04fPLq1whPNjx1pWahA1NL0NYJHDwliLsTnO0l3rmWJfKNdF2sVEc+xwAxTMyBB2dUQAvr1MlBbF1hk5oJI5f3FLvZWqlp/HCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfBLQ1Og; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfBLQ1Og"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d6d28aa26cso4116795ad.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788504884; x=1789109684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B1Y9JGeTBz9J0cSMx8uNBI7PYHW5JuoK9tu5YHKCsSU=;
        b=SfBLQ1OgGtc+LYy38BvsioUolH4Na3nqajObY3F/1oPD8OE0mz2J29wEb5SkQ9WlDk
         7lEsyw0XKbxB81RDAYc3Dh5v1f5m5KAhPSILNWTuoRU2Z0NdcSBDXhh4JPIeo2iJnv1Y
         lfA/NQmsF9NswRJgWCgsgPclqOJPT4ZFJGL7HxXWjod2rcETybbkWf1cJ4mGwlFFmYxu
         6Ta4WgJibRcmmRIg8c2PdKSqXCqif72ytmOrUgMvbQAWxVPH0RkOO0D2rJohT3zM5wwS
         t6JlJbJPnXk89vzSnRM1Iqun59x2e5Iz0DJBEF569szsfz3Ua3E1R/RX96QogP9rMbf9
         hYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788504884; x=1789109684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1Y9JGeTBz9J0cSMx8uNBI7PYHW5JuoK9tu5YHKCsSU=;
        b=leYXcyvqYq6I5CeD8+LlWLS+HZw0ENvXzANDFLel/YbYzgeYEwi2iM5+qbOVByYo3S
         czRxj05vtQac7NZqPuDguVDuknYZvk3ALXcLvKwytEPLqaq8uAxr55dA4MCxXns5Ur2l
         XruZQs0u5V7flCtDD1jLHj9F96gt/cJOYh1+2jFEOU9Oy4+xq/BAbzibE67zXbFCZwxd
         PgOjanZ9iEThbM1xGd3Hr5JEQbw3QE1HPK1dOv9MSW7NiClxesc6Hgwmndy9XtfMnlHU
         b3elLwdNQiUT3JB6X6maaI7yIM9a3Z9PfH1FYz6SLriSv4mHg05J/YhBGG5iGjdgio7Q
         bvnA==
X-Forwarded-Encrypted: i=1; AKwUvBwkElsNGxF16ChcYXK1Z8v+/zpst9reeODIXK71GbCkS+yk0JcOMPSdzA+/p3r9g/0E4DuOq74=@vger.kernel.org
X-Gm-Message-State: AFuF++kr4xijbjOBXm7SZCsrmOX7P2iYOJ63n/EZL4sXKzPwqZSNeJWO
	7zBZnasTAen8N0YeTlbtvx4MGngTOJcabqYZxUfyD8xlgI96e4TdrjCY
X-Gm-Gg: AYBFou1Be/fNNxg4iL3mMJLHOpFiOfaUqctErB42dXYQYRRhL90gBst7I54CbDOWWqP
	K9PJsMzRwl+kf8mDje25z+mTmcNcyIZvT0T2Lh07S6MlYqZNyuuyc32IoXkB/TbkE58KM75ePSB
	2wIiNnwUF3ekf/PYpT0hOc9a24NK5zWqdVWvEIMQrGGNKTLtFMFw1e92zrjnhGV3+xiptmKBUzf
	/VAiPE2k7ksBQbYRIZfysdfoS9gppt9SFg1fat+/CPwYusfwqNdxnx+s0UsgZOXVxaUB7l3TzCb
	dbdw/YTjDB0wXpvZyoKXsyGBjMRAABBk4ToP2tANbJgrf7cwn6mjXBO2WAaIm9xZXoYRBF+dnQa
	bRL6vVgDjMQKDVzQLGDFH5Nr6w4HOl3SEZfLOmjGMQorfex0jDtaPzpF57CAzOL3qLZHYH/oP6R
	f8/q6l9ikOpRp8Zp3S67GBS6dPqC/zkrwI+Tq3dHkbkDMT4Rde1ErCqWhUdAM/rngis3CQcC/zK
	Ynaf7FQKgI=
X-Received: by 2002:a17:90a:c10e:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39b2622b3afmr6273154a91.18.1788504884500;
        Thu, 03 Sep 2026 23:54:44 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm2845086a91.13.2026.09.03.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:54:43 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: bound asize by SIZEOF_NONRESIDENT in check_attr()
Date: Fri,  4 Sep 2026 14:54:37 +0800
Message-ID: <20260904065437.957677-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_attr() validates a file record attribute during log replay.  Its
non-resident branch reads through attr->nres.valid_size, which ends
SIZEOF_NONRESIDENT bytes into the attribute, but only checks that the
attribute fits the record, not that it is long enough to hold those
fields.  check_file_record() admits an attribute starting as late as
record_size - SIZEOF_RESIDENT, so one placed there with non_res set reads
up to 40 bytes past mi->mrec, a kmalloc(record_size) buffer.  The later
"run_off >= asize" rejection is too late: data_size, svcn, evcn and
valid_size have already been read.  Nothing earlier covers it, mi_read()
checks only rec->total, and do_action() gets here for the ordinary
record-modifying operations, so a crafted volume reaches it through
normal replay.

Reject an attribute that leaves fewer than SIZEOF_NONRESIDENT bytes in the
record, as mi_enum_attr() already does outside the log path.  A real
non-resident attribute cannot be smaller than its own header, so nothing
that mounts today is rejected.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Reproduced with ASAN in a userspace replica of the layout and of
check_attr()'s bounds: an attribute at record_size - SIZEOF_RESIDENT
gives "READ of size 8 ... located 24 bytes after 1024-byte region",
and is rejected once the guard is added.

I did not craft a volume, so there is no mount-level reproducer and no
KASAN splat from a real replay; the reachability above comes from
reading do_action(), mi_read() and ntfs_fix_post_read().

 fs/ntfs3/fslog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index ed50c1d0c23e..034d72929ac0 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2772,6 +2772,9 @@ static inline bool check_attr(const struct MFT_REC *rec,
 		break;
 
 	case 1:
+		if (asize < SIZEOF_NONRESIDENT)
+			return false;
+
 		dsize = le64_to_cpu(attr->nres.data_size);
 		svcn = le64_to_cpu(attr->nres.svcn);
 		evcn = le64_to_cpu(attr->nres.evcn);

base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.43.0

