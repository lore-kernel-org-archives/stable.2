Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73617A2EA
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198687; cv=none; b=XpRLC2XIiqjsqBeEMvXeYgia6J9UIzEbD2UrH9F1+CvGi2GGYypGl/uEyNcHASd0dy2nFLZyeotZJYhnKjafpiO5GxDryCUcwGkFTXDIja+tifV2NhOf4x0tI+LUFc0psEB39T+hqtsJtoylCso4WjjfOmXdCUdArWiBfX1gCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198687; c=relaxed/simple;
	bh=GgTU21qN++8DM2K21UhUVj8HwU4X7FIJo6RBILPuIIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPTYsSFHDX8ylRKXv8teTyFYoSNtRchSMfsOQ2lIupbDbeWxz8qy+6PDbHgzCGVDL4KaDxhSSbjGApUu0VNTvtVrUeJVac/mVnjRdxtqKxz78fiIgjcQiDDVAI9SWodJqQDLFSAyBwFT5fU27ejHBuSouRPLApARj+KbjBhV1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxCs/MY2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxCs/MY2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e0688b859so2006766b3a.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785198684; x=1785803484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8vktFk+O2srUQXaV6c5+4o7E3AyQIIhp5JyQmL1l6U=;
        b=ZxCs/MY2oBKI+BxYxFLQkQgg3te/ZLaLXOfZBjo3Ez0YAgImviIRrcNbpPh1TtElJ4
         jSSD/UpQhxhHe4WPP7UrrE/RCYY7RaSY23/12t5xNR6I24EiazOSw1EB4TrYCinQ8n8b
         8ER6ryVCLJxkc/BSb4eh3jn+i5j/xsX0JLrzP7Vl/1nHJUyS/ejAuZb3/xeA2L1Ht9qm
         1Jb/nENyGlLEGZu5QMWLFJ0aCfk2JZ9pd+yZLTucvQJA/L8xWwGsVzGoldQMggSihDzD
         65bpw1O6tX38xUj3B/WI3hvrMmqY5Jf4GnYX4mUJ5DMnM7u8ZFtSnxpgcChQ09nTEENy
         3n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198684; x=1785803484;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8vktFk+O2srUQXaV6c5+4o7E3AyQIIhp5JyQmL1l6U=;
        b=AZ+iMgf6HMMBfklEIommov3m6qIk45s3y70z0JX1tWI9N8QooAJNmHTuV5fJm09TrF
         5HGbGKSwGJIAXpFfpsXmg9IzRwZMG8JTE9vLlMO1yb3vxDIrHO8nlYOaS/XaJ6CZMT7/
         K2ap1iJPowOZeGGUSwzYbR36ZyCQKTzGXky9d82h/xULfC1JYs1WBMNEQPwVjlEyEBgv
         JkcifDylDcDRegBexj5MGRz5lHD3oFiXtT3dtkwnbElSAHI+qCEGMNZrJE37D6X6xp7z
         MipClVTgGoWWzQfhaQwp0gP3DCgy1covC/fJYmXDespjEqDMBMOk6YXg5cg4yJVzv0QM
         hjsA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4JvHE5G/EjCUnG2RjXfc45m8lZhcjV3fTi2tFAFnEcITTgjQ+4KK6udHc+WnTj42PzCyB5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagB+0852H5LsZCthCahFZAtPt6uyjldVvyXIpi3aFfUvJRVcX
	xMvKHPYrkTGhomSD+jupgwZZf69ly59snPD0++wIIZRcJX+kTg2i6sWs
X-Gm-Gg: AR+sD1289K6cylL9jBNHIA0CwBHWL85bOtjMyHc0ExBRQEjg2tkH0sD7L2SDUKOT8YI
	E2uO2hiqp6J46G+11SWtCo0V9F9lf30DYXc7FbYmzmAn4daOQRY94Qd3yENHOnjmvqNlHd7u5Dy
	4RgUxaN4vleAddZKnOKcZ8FVP971Q/CnVVLU73Ibw2IKenytlv64bFRXdSZx5/TN6OWxmzWFcEM
	ldy/EQItErCTD95V9ZMa27/aXY70GgH7ReOyz1yh3BANn/Yy8AYgalNGVI+WCORlCr6kIJnNBjs
	h2gG754Ke0sDzRkdq9G9oqN7sfn3Rp5WIS8YANIA5WO90R3WC4LzCi1GwUOfcepdro7jzcEEURC
	JZnjfbksREwkC5+rUHIpcEiBY/E03JNrpApasdzbkKAhsWlrGPpSdb3m7aOtRoNVyq3sJyQorqr
	a3ZfAtQjvs71PUcDGc8PLIucWv2A3vuX7Mt/okFSsS5V4FlXkMmPzOyqX3QM2/LMFfnb5E2Byn0
	mIG8WjEMm75
X-Received: by 2002:a05:6a00:1d26:b0:848:40d0:1a57 with SMTP id d2e1a72fcca58-84e9339e9d2mr119949b3a.71.1785198684254;
        Mon, 27 Jul 2026 17:31:24 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f54esm3571094b3a.20.2026.07.27.17.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:31:23 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] ntfs: serialize attribute-list access
Date: Tue, 28 Jul 2026 09:30:47 +0900
Message-ID: <20260728-topic-attr-list-lock-v6-v2-0-270ad764d0a4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785198351; l=3264; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=GgTU21qN++8DM2K21UhUVj8HwU4X7FIJo6RBILPuIIk=; b=js23YXmN2PJoaXyVCIMgYk2riY0CiCb9c32EYr9ATppoZK6HE+z6Ae3SvVeDADC6mau0K2SWb EB0KIszfbIOBByTQhmWmwL/xVhWmcPCoVYI037xSWdbwZJZ22O+/nPd
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
Content-Transfer-Encoding: 8bit

ntfs_external_attr_find() walks base_ni->attr_list using raw
attr_list_entry pointers stored in ctx->al_entry.  Because other paths
can replace base_ni->attr_list and free the old buffer while a lookup
still holds one of those cursors, a concurrent attribute-list mutation
can turn a saved cursor into a stale or freed pointer.

Reported in:
  https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/

This series fixes that hazard by replacing the raw ctx->al_entry
pointer with restartable, generation-checked locators, and by adding
locks that serialize attribute-list buffer replacement and on-disk
persistence so concurrent mutations cannot corrupt state or double-free
memory.

The four patches are:

  1. ntfs: replace raw ctx->al_entry with restartable attr-list locators
  2. ntfs: protect attribute-list buffer replacement with
     attr_list_persist_lock
  3. ntfs: protect attribute-list creation/teardown with
     attr_list_persist_lock
  4. ntfs: protect mapping-pairs attr-list updates with
     attr_list_persist_lock

What changes
------------

Instead of a raw struct attr_list_entry *, the search context now
carries three value-only locators:

  - al_cursor  -- where ntfs_external_attr_find() resumes enumeration;
                  invalidated on generation mismatch.
  - al_insert  -- insertion point captured on -ENOENT lookups.
  - al_exact   -- immutable identity snapshot (type, lowest_vcn,
                  mft_reference, instance, name length) used by writers
                  to re-locate the same ALE after a buffer replacement.

The inode gains an rw_semaphore, attr_list_lock, and a 64-bit
attr_list_gen counter.  The lock protects attr_list, attr_list_size,
and attr_list_gen; the counter is bumped on every buffer replacement
so a stale locator is detected before it is dereferenced.

Because ntfs_attrlist_update() can sleep and recurse back into
attribute lookups, attr_list_lock cannot be held across persistence.
A separate mutex, attr_list_persist_lock, serializes the whole
publish-buffer -> persist-to-disk -> rollback-on-failure transaction
for each mutator.

Lock ordering is:

    mrec_lock -> attr_list_persist_lock -> attr_list_lock

attr_list_lock is never held across anything that can take runlist.lock
or extent_lock.

---
* Changes in v2:
  * add Fixes tags
  * add Reported-by and Tested-by tags

---
Hyunchul Lee (4):
      ntfs: replace raw ctx->al_entry with restartable attr-list locators
      ntfs: protect attribute-list buffer replacement with attr_list_persist_lock
      ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
      ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock

 fs/ntfs/attrib.c   | 411 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrib.h   |  46 +++++-
 fs/ntfs/attrlist.c | 139 ++++++++++++++----
 fs/ntfs/index.c    |   3 +-
 fs/ntfs/inode.c    |  69 +++++++--
 fs/ntfs/inode.h    |   9 ++
 6 files changed, 561 insertions(+), 116 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-topic-attr-list-lock-v6-f1a909e3c859

Best regards,
-- 
Hyunchul Lee <hyc.lee@gmail.com>

