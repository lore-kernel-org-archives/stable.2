Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6E42A781
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281940; cv=none; b=p3Cl1Jt/bSRZFKZkSa91t0YpmQpeiaQq+LEjem9Vu/KlE6JfXZCBwXHe/qahxm+W1+Lbh4oBAwZvzsLUhkb0fU7RmFhXKWW7w3Q+Q19qjo88TvOBTWgApBwp6yDEAGSgcPoh2O36AcN7yftH7niVCanNzDJ6qdxb6Mr7Lk5hBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281940; c=relaxed/simple;
	bh=WPEOve98zSPFKALc0U8uTJAw6doJI7AzhMl0oaRe+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lzrMQkA2ev0Dvafjurap+Z8s+TMK3DG1Y8JeqOeXRWoC0ICH4c5P8q+mZx7Q4QsrgejwqGq3GHnLIERW7++oyXAu7+ySB+QY/fn+n/jBp5TArkFdKHO0ajBKHfB5GwFk2UwP7s9yri5WYQ4kc6kVZInHxHRXmIL6WwYEPsGeQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIP9QMXj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIP9QMXj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a652535dcso257061b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281935; x=1785886735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWJC88QbGUqvs94HK7HMhX4k1/Fwvx3AJKdOIrTSpV4=;
        b=BIP9QMXjWUX36XvmztzVDEpSR6+a4IPk7zF8WI+FTlENAai424gLjaPkw3a0MBa3BI
         IkYicD9B1TkqjB8gNxPrQBHrEXCSzhgD0qy6Tt1s7+3d+9FBwSn+dlj8Oa/J2PseL6rf
         5LH0JtKesxH4yrw63jUFS7hgGD+laE2nlmb5eqF+8V3s6iXa5EeE8DenIjBpqHnkGSL6
         9okPdAaCLZB35sMDAkpvAqMkJAJ6CIu1Es0BMWZXz2ekWY1ulSij5zzKrTRJacMqWEEb
         MTeEryyn5LtDv/vIqepGUlfzu2qazL3WtR6yMEnjzlHeLeZ2OG7ij9HUR42wxINzsm3D
         kz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281935; x=1785886735;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWJC88QbGUqvs94HK7HMhX4k1/Fwvx3AJKdOIrTSpV4=;
        b=Leb4QX+ojzgoUJZH6e+7YevEB3qkmZ5RIh/DD6I9h/eqzEdVfQfLlZAx6qvEXcn6nL
         8BLlQGatu86W32Brn8i9z/2gEuZk1zBxJ6NPcBeC7P934lyPaesFlx2wwd4qbQ86GCD4
         Wnl9EMYaRw1rAJA/zhicK5k1a8qAVKIZB3CL1iVnA3DmhlPI4n8z36KYhYs/JuD+rTAq
         7l3Q6pjvqIGBHYVhMCtGFcmpF6iKIVdkanjlMqOllbJGdp775sKBzIMfoWrRErTQXe/U
         lJrQDwd0uRvT9dut2hMLh9STpKwhT7fBU/hJo2WRH7r3dw6nIihpvqRYGZrUVelwivPt
         RwhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkV5KEXBIC/NnmWqOKZ0SDRRWnhk5knjz5HZukyD6F7vIdew20PYBD2wmZ5KK/liROxTDQu+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzngNEMrEmWaLDGNzLpNaXquzYG0EBjkL1DTXrSjVlejhNqSV0
	O8gLUDhAJF7g9mzHZ6mY6p9tUAjw52ehPYZDCK9kiyRFhhTy/PJf6unJSxLEZg==
X-Gm-Gg: AR+sD12kTmvxnr82RNMpSeQM1cdv/yYcYu3y7NogV7A/Cr+OfiBcRQj+gqf0KTao49q
	BdIExSMGUMmsMcuWfV6D1zEYrECfcCIvoDgennniQ0TeKAGwZFmr1tngoZ3wAvkukxgvcVHaRrd
	uBOlUHoxpg9w+t57AFTU8z5HWsrjKK7lMHlvXeD1s9nedGYz4fhQCq+5S/SOawPH5Vm4bo7p5WG
	XaZhVeHV/SUUACbjGMylXlKU6Q2kTrZYEgTvfv1CHD1uqR/OS48DkoHRzZFZJqOgPuG5FUk4yTe
	Q6cw5Vwd55rUlyeotAh2SHlIR8kGEXKd1FW77VkWzhCbW/n9fSaChup9YqhMfoEZ5OkFRp3ZEET
	QdAiZWNchUf9n7KkCdyEiQ0yZk5Dlz3lMoss+4Wg2EH+igxuV0mctOctkOtPT2rcG7XO/UfiTu+
	djXZyfV+KnLP1F7YSPOrF2JXBsMELwGdorkPpXMfWbADBJELlhJkI6AgJqBcyMENTBdiASzbg2o
	QlKTNGjNjue
X-Received: by 2002:a05:6a00:1da3:b0:847:8504:9946 with SMTP id d2e1a72fcca58-84e931f4e9emr4779689b3a.25.1785281935070;
        Tue, 28 Jul 2026 16:38:55 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm496896b3a.35.2026.07.28.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:38:54 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 0/4] ntfs: serialize attribute-list access
Date: Wed, 29 Jul 2026 08:38:28 +0900
Message-ID: <20260729-topic-attr-list-lock-v6-v3-0-7f690b9b98ad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281796; l=3566; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=WPEOve98zSPFKALc0U8uTJAw6doJI7AzhMl0oaRe+GI=; b=TYAmf48+It+UDjLG1QNSd+Ntgba/M5WlLx9Glwc3RCMX9T62ehriiLqyTcjtRAUTnDnldw8x/ 23lAnL2MZJ7C90v3HR33tXalcJsDmX/woVEhmC4RDITkZgF2wUnFFt8
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

 fs/ntfs/attrib.c   | 446 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrib.h   |  48 +++++-
 fs/ntfs/attrlist.c | 139 +++++++++++++----
 fs/ntfs/index.c    |   3 +-
 fs/ntfs/inode.c    |  71 +++++++--
 fs/ntfs/inode.h    |   9 ++
 fs/ntfs/namei.c    |   2 +-
 fs/ntfs/super.c    |   2 +-
 8 files changed, 594 insertions(+), 126 deletions(-)
---
base-commit: 985e0ded13bc51da8d5eba3a3bad1cb3ffb4870f
change-id: 20260727-topic-attr-list-lock-v6-f1a909e3c859

Best regards,
-- 
Hyunchul Lee <hyc.lee@gmail.com>

