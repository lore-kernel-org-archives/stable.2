Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE811E9B1A
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786335777; cv=none; b=hYL7lCZKR4uCzU6I3/EeGe/bGeVBF3icGgHhqHKIFgV3KM6t6uZkTWVa4QU4sMTgfnZjq8NhyZSby9szi6xZCHtUKkCBIlDBo1lwV+cwtFCyDOiOjwzYb3J7qj378ecrA5FUtoth0ZvZ3ESDj4fEaZ2fnkVX/W6lBUOToa/6bUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786335777; c=relaxed/simple;
	bh=rzLI5bmQLWiguYEuxV33UrYL5J9ILDzKOofDQeMLgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Koy++VXe2pC+S4w/QgxbpN6r3ipoNY0HAwE6okxNcaUlRZAky87y/x/bLv8wvOsNEenTrbKT52XlY6fbJBfpnxTVbT7gUZWQ2o2jWwYV2ZXxAksK2YMAcoF8s+bgoyZwyayFJwrpG66K56UpCTBerggqY9T+DuVjUxBMLZ65YNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuQYbesZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuQYbesZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso23482475ad.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786335774; x=1786940574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNPV0iDYsHJ2K+Dc8fNjssgXtCm9NmJrEJ6oWZgdd94=;
        b=GuQYbesZlTh+OCOyt6afM6jOmAYX6Z88M2fge/w2G7t9QNx0NoeXQOm5BWrZ4MTAAk
         9jnDmzc+IH27w049RgCt/eApSAeeJFnt10bJn9HoF3ViIH72pBf48MQqAvtSpJno6MpC
         049sy+kGGqR0+3hAPeNnHGTz4JHvqJcadq1usNxKyN1Cf/fhWyqU3GLbjvUn16CP5R/z
         9Fhs/OqeKjTeU+TGkhcx6hGmuv0zJfwS8rajYZZcfR+mawjqrJrssZJ1RD6NsHgrENWR
         w+FLfbRckIvalq2V1XGe7dpDvjH7tXLJ9x/HnJy+3zNdZX5mTvuJlmmr4qBh3IpKYjjE
         zDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786335774; x=1786940574;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNPV0iDYsHJ2K+Dc8fNjssgXtCm9NmJrEJ6oWZgdd94=;
        b=e3JVXEyXNwXPvqPwOvcJO+9AOvVUjr8a0TIia2HIdrDKAFaPwDNBxUQhWid9w+QRC1
         ALlwa5q8j0uOX3EyY36ReQsfrS+akE+su5yQd98RGNp/0BZCInm2QzjG0fTDbbYJ7vXl
         I3KWMmugEYyYqNBKEULlsGuEND+EqSNxBHLgMLhjC5VpjxQ5vBo0FZEsP+zALzdebNAU
         iFz+nQfc/AnlhhzQwevt4Fq87EK1eWKPHAHMGPP/bhvLr7DY/tBy4z7v/+pfxMg6oQ7Q
         I/AV6m5VIiCGoTJ4sKZu9Oz6anWPKCFvVZkgQKibJ8aAY/yRVcVLYNCGPgzytcN/Su7m
         Ka6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpbP9GjMaN3g+zibcm62E/RhI0gY8TV+0Kqf1fgnVdYVf06twjqLdznS5b2crhIN8GOGV9t2dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK89NO2wmxfZgL1scmVBJsBKql/PXSR/BBTaIgS0Fpc0LvQbr
	9dcsa9VZAgdHvGEMqp5cHxccVrPqIWXsHF1hQNd4Nb0Eh8lIh96xCjFu
X-Gm-Gg: AR+sD11jm2ODzF/RiM/dgUeLi+mWxKCusmZT478ECUWlww+F9RmbaUCLQYIcILvfdLV
	6uog+oVZmNzOLHsr1loirfh4Vhk/f0LMeDQ9IQRKCQqThvKjz1WWsSuDPBYbf0SO9p0PBhS8Oom
	Tvg0NVIQaD6egm/z1FERBquinrzxghNyPTXlaZErpMDzK0j+VSEt9oXxdTptzjzd+oNLq/riCxu
	1pCNYkw+y+QBOJemq5f0Wdb02D8zR0oSYtFVZrprY35O4hDCrySjby2+v0pZ0byrX9tdr+HXYmV
	PhNpJ019AcYPf1x66+/lkFWF0c5XHA6wQYv9Qi5HpLqfxaRqEAmL2t4LEnGTl9SkPq4medXSlph
	kwOxtcYbW8e+2cxT1vQV6MTP00r0pcz9GKM3Blrdbe3SQdnBKiF0cHzAsWumqkVXbAq90dL48Zz
	z6VxSfVIvTQCoCGucBmreAb6V1I6mss5RWkileJUIL8vrYfKqaMjpRbtWX5CzeVK2jpjM=
X-Received: by 2002:a17:902:d4c3:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d0ca76a3aemr417523135ad.14.1786335773580;
        Sun, 09 Aug 2026 21:22:53 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac19esm28595905ad.9.2026.08.09.21.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 21:22:52 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 0/4] ntfs: serialize attribute-list access
Date: Mon, 10 Aug 2026 13:22:01 +0900
Message-ID: <20260810-topic-attr-list-lock-v6-v5-0-93f823a6ba05@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=rzLI5bmQLWiguYEuxV33UrYL5J9ILDzKOofDQeMLgb0=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqeVEFKn5XTo+aLsTtRI8cuLYnvcNf8MPPMFxwy
 PXoUOIfo2SJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCanlRBQAKCRA08jD6945I
 0xGcEACDHY3nLMg00x77GvcP1/dtGHFPE0+fN7TAGDiUk6Co+DXwCnDsdSZelUMRuLbPweVQJqW
 IYC5SSda0dmKFUmm/ZgyeisCkJ7xrEGjqvYpzR5+55FQBMiCmwsU0DwbYXXfAoF4HUXlk+NbzZD
 oQVnRk0nhYZNF2z+6u2eNhNu9aNhBUgSCRhEHQ7b18IhwX38AS1j8z2MyjpDcW9jyEoAGuLw0/s
 Vx+EnWnybeIs8UJLkgnJhhAV1BskjLBFDgDEt/chKrNZE36VOKhKjLHcYVTiwtC3z439JFiMQ1c
 nVNUlmNun6/bs1+LMWJGq8ZWxWN/dZ17UKokS9geg8gQizyOwBd+naUGTfYEFtpfLuoJlgYBzxL
 9OOY9y9nh36fFtAq5XJ0rvEV9ysY4w1rsiWVtoSdBExzD8EKDmx9RItONzHnkAGfkkhwp1mCwKM
 xq+uO3OAaAdVg//gTdk2Px7ckaQleVLCGuILZkVyX4K/pOso5a4WWBa3DBWp9NcsvWnYxh19eLI
 a6UR99phpZaCQJsCMQiAs3rWnZzJqYmwa42C7EamCLk63eCGFPSgC1okjyTDsEfQcymBfgOArji
 Xc3FYJukhlqTKr5xuRiTQHzPGuK/22zjmG/5KbyaS09MKkvFhS8YlEkeW/maeTzL1GYM3gK/HUC d+7PHE/gI52b4dg==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

ntfs_external_attr_find() walks base_ni->attr_list using raw
attr_list_entry pointers stored in ctx->al_entry. Because other paths
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

The inode gains attr_list_lock, an rwsem that protects the live buffer,
its size and generation, and in-place ALE changes. Readers hold it
only while dereferencing the buffer; writers hold it while replacing the
buffer or changing an ALE, then increment the generation. Pointers into
the buffer never survive an unlock, and the rwsem is dropped before
persistence or an operation that can take runlist.lock or extent_lock.

attr_list_persist_lock is a non-recursive mutex that serializes a
mutation through persistence and rollback, including list creation and
teardown. ntfs_attrlist_update_locked() writes the live buffer without
attr_list_lock, so the caller holds this mutex from mutation through the
write. It also stabilizes the buffer while attaching extents. When both
locks are needed, take attr_list_persist_lock first. Creation owns the
mutex itself, so callers must create first and then restart; re-entrant
teardown uses persist_locked instead of recursively acquiring it.

---
* Changes in v5:
  * Patch 3: keep each in-place ALE update and its persist in one
    transaction. This fixes the Patch 2 review: a record move could
    update an ALE while persistence copied the same buffer.
  * Patch 3: serialize attribute-list creation, teardown, and extent
    attachment.
  * Patch 4: acquire the mutex unconditionally for mapping-pairs updates to
    close the attribute-list creation TOCTOU; drop it before creating a
    missing list and restart afterward to avoid self-deadlock.
* Changes in v4:
  * Patch 1: fix attr-list lock/unlock and uninitialized locator on
    the AT_END path
  * Patch 2: hold attr_list_persist_lock around all
    ntfs_attrlist_update() callers and recheck the attribute-list
    state after locking
  * Patch 4: avoid self-deadlock rebuilding $ATTRIBUTE_LIST's own
    mapping pairs
* Changes in v3:
  * Patch 1: fix $ATTRIBUTE_LIST extent double-delivery during
    mapping-pairs rebuild (xfstests generic/040)
  * Patch 3: fix self-deadlock on attr_list_persist_lock during
    attr-list rebuild (xfstests generic/040)
* Changes in v2:
  * add Fixes tags
  * add Reported-by and Tested-by tags

---
Hyunchul Lee (4):
      ntfs: replace raw ctx->al_entry with restartable attr-list locators
      ntfs: protect attribute-list buffer replacement with attr_list_persist_lock
      ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
      ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock

 fs/ntfs/attrib.c   | 567 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrib.h   |  48 ++++-
 fs/ntfs/attrlist.c | 179 +++++++++++++----
 fs/ntfs/attrlist.h |   3 +-
 fs/ntfs/index.c    |  26 ++-
 fs/ntfs/inode.c    | 110 +++++++++--
 fs/ntfs/inode.h    |  10 +
 fs/ntfs/namei.c    |   2 +-
 fs/ntfs/super.c    |   2 +-
 9 files changed, 792 insertions(+), 155 deletions(-)
---
base-commit: 5c244a0e9ca95468f4c2087b2c9269825429a13f
change-id: 20260727-topic-attr-list-lock-v6-f1a909e3c859

Best regards,
-- 
Thanks,
Hyunchul

