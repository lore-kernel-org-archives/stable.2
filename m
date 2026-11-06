Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969168;
	b=yD1lvrCQrLwM80FtyWMnohzVbFXsvj9Ev/A8AUzmasfPtTf0s9+7lXpA7eJZNMi/pdba
	 Dl/SEgvIHQDifwzqZRJ/s4xIgNQ3n4i76ZR58z4TnRqTC15LmvChvjOo31eVj1ZY5y1CB
	 gWKgogJe0M+7ivHOAj8wmgsNebjwwVC4evVB1ciEqJ09xrZv/fqcRU1E61eXIoyWNJ6M7
	 j42PDPzo6Ck6gfyXces2jh9TDOzI+2bfRPBkHmtRwYFvvkvs02Q4mf8ONgOuQlNj9lHEg
	 fjuW9JBEaUDM3gJJL3KH3OM6y1trg38HRZaF3u5QJPf434OlwHqVHD9Y8fCVwbC4FUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
	b=G6fRomPdnwDbnlFJ4ALRAaYQvHrV4LPQwcwmlj0wsC2mW/meEa3lhOiI8WhKpVEeM4fA
	 7WEylJ4fCgy35SkJ+URRLWOpjuZ1KGWegjd+qknarc8GjzBKLqCnGOHlB0klKAsAD052W
	 Sm7X5hlG4/f+orkqUGJL1FdMmCtDHrrGzTyp4kEvQV/fQMLzx0BHcCU4Czhhtf9p7E6d1
	 p3J10phRnggdzvJsmKrD0bSgUL1KdSnIee3iSMgwZBIp5AEqgVYM4rphrsvr8CV4zSuX9
	 if46BS/mNQt7FmoXhIZ9ZZz3gclMZaqH4Iihwd9yDe8gYXy5nCfJUD+WwaYAA1SH36w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKMrIy2t;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857E606D807
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C857E606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKMrIy2t
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3704d30b84fso225787eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969167; x=1794573967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=ZKMrIy2tc7o01+01zW+B6xXvNtwD1DjIQVLY++gLeXaXPOpnhp7nOsCBvxXiWojgv+
         3HJmPEJpyHZARyLx+czkHayTQEvNs6rWHsm5SnG2M+t+2v0HEhp73a+71EOUB9EGSuR6
         NmffL8RA+Wy9xrdBvjdecpWgYBSsD/ahJ79dsS3a35olzO5mvoPjx5VThkn4IU3x17hQ
         1Xl0r9INRI6M7qYJ9UFfR5jyGgggFADXIHOnpRCuU0T29LGF3M7hq/L2+wguPA0HvqIt
         hVemwfnh9vy+XRjDaHkj6vXjSQpRC1W+eaSCmDkU3dcwf2Q+iq4/c0U75rPQQye7Yf52
         +Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969167; x=1794573967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=v1UDYpAC9/0BzFAH8B1bXip7EI3BK87m9/iIJoOuVMMzMFgamkYqKgm5cECZTz+8lV
         wuGqRJHd03piJylJ5+n7dxSOi/g8f4t60SC8j0KZ2BDFQFc6nkRy7xrfgR2sg9ziuQDA
         fg0Oxcq01ftaFXH+m6TwSOrphkQ59twM15ncML7UfD6cVOatoATSKO4CzDnPVUP8aWRZ
         i+OhA3xqm9E5k82ZR2fBHZHWrQBevvAW4mRl3MX0HngURN/woX79xMrdq5nVguNGh1qS
         jIrAHsfzY8LbE08i+sAq4SSH2g2tLOx7iP26rnLMX0mSnM2vIsIWmx6814ucPoO69zST
         TUFA==
X-Forwarded-Encrypted: i=1; AL+hErExYZjHi3Qrc+Yk/GZ+riG8GgECyL3D31Qo62ChS1iZWFlkkxDwpPYN0mD6OA01eejad1kGmfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YgbSQmixHggFiWePf2xpobUqmUTD8V64U34b9/w8zhSX/YGpM
	W8ceY1/AQo7GipojT7OsSekzRTuZRu98KPGbSR4NjLYeylLQoVBakgIKQL6GhXyziEXr/A==
X-Gm-Gg: AYBFou0mm+JGSuBBO+bmuFCoBE9RsjwHUIb4/8amWKm1eP3kucQOQJq6QQxUk4qLaoJ
	0MdWDrKW6NuL3OddpQO0hns8RwxYLTdHTTnpAZH9q9ev4kWYwFFF5HvyZDi04Hs/7IufcKvEntU
	aImnXS+BaaTiQBQliAGs/L1Km/5YjRK1TLwjAH9CA4OF6SrWZsjDduOLwHyF7cPKu4hb5sUDVZI
	NO/RHQTSDLdr7FutgoUFSjLDZ6oL8bHgl7EoNfIsTuk+Em2kQX1C/wGZdlW3OnviD/w22iWahEq
	NeI1lcETj/oiXhJGM7qfen/+cn9NesJBXvxfevPqJcvII3j4vESWlCcGtxCAHKKl4rp4AFrXIor
	2DZ6WNTn14VavQyR+zsHotS3pSvquyJjeM1andgwIT/7DUmR40fWGsFMvY1/ASJr2iZRP8H6YjB
	y7VZabKephUoPUBS0xCRpOX/33WjTsnWnmyzEbggjlTkMpa/PGGS5zpz7J/rkeRf5yL8YQpZJw8
	+AV28ads3fGhCR2UHWQfXHf03qsuVtMcDWcAvl/knSfwJkWNRwlaQKEI8sfjBzdSSYNjNPZMOsa
	VneFdI808HygAsnSvbIF176hRrQEICaJ6sdsXwK8RDq15ZYnX9cBAxPFKPHFZ8Bc7w==
X-Received: by 2002:a05:7301:9a81:b0:369:38e3:5363 with SMTP id 5a478bee46e88-36f7494cfb5mr3376030eec.7.1793969166328;
        Fri, 06 Nov 2026 04:46:06 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:05 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] ntfs: do not read an index block outside $INDEX_ALLOCATION
Date: Fri,  6 Nov 2026 18:15:51 +0530
Message-ID: <20261106124553.2617026-2-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106124553.2617026-1-wahidzk0091@gmail.com>
References: <20261106124553.2617026-1-wahidzk0091@gmail.com>
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

A directory whose $INDEX_ROOT has a child node but whose
$INDEX_ALLOCATION is missing or damaged gets an empty index inode from
ntfs_read_locked_index_inode(): size 0 and not non-resident.
ntfs_lookup_inode_by_name() still follows the child node and reads a
folio from that inode while it holds the mft record lock of the
directory.

Since the resident iomap read started to take base_ni->mrec_lock, that
read waits for a lock the caller already holds:

  INFO: task init:1 is blocked on a mutex likely owned by task init:1.
   __mutex_lock
   __ntfs_read_iomap_begin
   ntfs_read_iomap_next
   iomap_read_folio
   ntfs_read_folio
   ntfs_lookup_inode_by_name
   ntfs_lookup

The task never returns, and neither does anything else that needs the
directory's mft record.

It takes one corrupted byte on an image from mkntfs: change the first
byte of the type of the $INDEX_ALLOCATION attribute header of a
directory with index blocks from 0xa0 to 0x00. The first lookup in that
directory hangs.

Check that the index inode is non-resident and that the vcn lies inside
it before every index block read, and fail with -EIO otherwise. This
also rejects a negative vcn, which was only checked on later descents.

Fixes: d9e00c457d4a ("ntfs: serialize resident iomap reads with mrec_lock")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index fce10baa2..9fb5bb3d3 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -308,6 +308,20 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 
 	ia_mapping = ia_vi->i_mapping;
 descend_into_child_node:
+	/*
+	 * The child node has to be inside $INDEX_ALLOCATION. A directory that
+	 * lacks the attribute gets an empty index inode that is not
+	 * non-resident, and reading a folio from it locks the mft record that
+	 * is already locked here.
+	 */
+	if (!NInoNonResident(NTFS_I(ia_vi)) || vcn < 0 ||
+	    (u64)vcn >= (u64)i_size_read(ia_vi) >> dir_ni->itype.index.vcn_size_bits) {
+		ntfs_error(sb,
+			"Child node vcn %lld is outside $INDEX_ALLOCATION in directory inode 0x%llx.",
+			vcn, dir_ni->mft_no);
+		err = -EIO;
+		goto err_out;
+	}
 	/*
 	 * Convert vcn to index into the index allocation attribute in units
 	 * of PAGE_SIZE and map the page cache page, reading it from
-- 
2.53.0

