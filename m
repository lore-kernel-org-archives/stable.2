Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56F3546FD
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047118; cv=none; b=Ci5EyBMsyI+ez4rnvgjhRKDZpThzeVadgUvadag9M+Y8Frs66AkO0Vl1XIFPrgH7v7Bqd/DTyoUrFPsaQqWlW+EJkxmBqshc+bpOKICuTfkl3Mj3wMoFogk/H2htnaqy/PCjUZOoBa0biWJrQucLOnewYyUL0bOe0VGT8ywH6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047118; c=relaxed/simple;
	bh=e8mr+b9UCttxj8RlTQotrcq2qgO7pGQftDu5+Avcths=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDY8iCUx9WxZ3Ilxic0BH7PyOrguJC96K0M+2s0JsllFQLH68qjtv7JiBx7K/d/iA0s4Gw2eoiT3sexIErj8Kx3O5oK8LiODfnbMaXRu/W/Pah3xbhnJyFFhBhRZZnqlb8K6oZEJ6kCUsji6VEb0eZlbUeAi71Fe17iNb8nZsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=UiAqw8wo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="UiAqw8wo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848d21bbaffso1786517b3a.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047116; x=1785651916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tIHL9LfqgPlg0723np5xF3/v3AzqALnVrCAzcfCqCNU=;
        b=UiAqw8woPubp0TggGEHWMjK9gESI2qNeIeCceiqgI4tv3LJOC2FhlRZU15zbAHI/FL
         5zyljdMEHCFjG6kpcINWZ79POoAIhLF5iB9MRJow0QsIiuh3NQiuwoU/NfLx+YRFid8B
         CspZtWOMZAsgHu0ELgPAUC45KsyiUqFa81rlDtaX+GYOaaUXv58YqJJWZDwqSfS1pFwD
         D6+3+KskoESOXgEcLOw/BOjzXcTNbGfuCW9SnUwI2jsaKcsAlZ5Buz83t+FMBNjlnYAC
         3kfNEfvnUqL2KKKbhCSnsTdcMf0XljcRRk4IPV/9Q8U7xCWghq34ycf2Yyo5uQIny8Vu
         OTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047116; x=1785651916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tIHL9LfqgPlg0723np5xF3/v3AzqALnVrCAzcfCqCNU=;
        b=pzNioiI9zI0onIgid8BX1OQpnSDxUukDvyDWUjGzDAmJNJeXEk/b1/jATH5uEIDv7R
         4BLmAmw0NhO7r1INcCPXjsd/RbgYzAaboYl8MWHxh1pvehV6l+SwMReQ9dorVqBwzvrr
         YbzeFX4Ngcz8Tga8mlYGr2SA3JV454MH4hUqq4KJO4GytfaAWWJXyPYPKfkGEuwh1tfy
         VLIPMjpCnPv6IzZDOV/cchagSvreyH/kPVOy5CExP8TPB+XX8Z4M2Bgb/bMH9GRPCaHg
         z0jVzOhsirt/HKJfoKRZ2La59jw6SOOjFwK9Eu6MXanG9HzumIIHCUjT+rxui4COcLkr
         Yd9w==
X-Forwarded-Encrypted: i=1; AHgh+RriWYc+4XFnhZ4nrfM/CXEfg43PPAYfl0m5eMEjuq4PXYyW2/Z1KrMNIHsY6peLCiaF0ey3k3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qO6jDm8gXoMOjug5Z69MxyT4A+1qOz/1yxr2lS6Vkjsv3vNS
	RdWHvNIDHqUzXJWz26MarhEBIVepTMSIaj8IX9x7NKHJx9a3DwJZdRnw7mjOiZlYavg=
X-Gm-Gg: AR+sD12m0Vl96735hoZMArIn5MFiFaQek6WsEmRFAO+/CaWxL+AqDK6Im2fDSax3c5q
	9/OPwfPS/o7O2CWhMEh9v+KhnRRPfJ9h4Rbr3iJwEhJVT9GHv8rVrZDDrulQEZhljo2zXoEmiBH
	/34hCYvuAD93P2nbDpcR/v4fNDyO/HvSvl4PFth3dc3GJNluwYhSkJuC07fO9CVPdiZTSsQ2dw8
	you8DWiMPPEzgTigwBNN/vHyPiQFBZucNLsDVNobEShTuYobLnuhHGZlOBecUl73abQxV1Gdpud
	rk09+8oHoSdNSxLqig5/dVI8tSk5QvEW4SfRGSmu5GEbzLlFAJu8Y10RiibL5tfshBCFMguHBzh
	etUmsnBHzkoOWMVm5KKyIazX6KFXfNYW3InCVn8kGQoM98m9Tk2ZZKDVgpSxTp10z8Plbe1Bna8
	xCQuJEEGat6T1OcJuYSWwdXDsVfyjFo688rQY5f4F1PscTiF6J3eMzgTeyx84fx4PV0BtbYwY=
X-Received: by 2002:a05:6a00:a207:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84e59435c72mr3295803b3a.21.1785047115931;
        Sat, 25 Jul 2026 23:25:15 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53253d7dsm1611692b3a.5.2026.07.25.23.25.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:14 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.com,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] udf: fix OOB read for a crafted unallocSpaceEntry
Date: Sun, 26 Jul 2026 15:25:09 +0900
Message-ID: <20260726062509.43738-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_read_inode() sanity-checks the on-disk allocation-descriptor length
before it is used:

	if (iinfo->i_lenEAttr > bs || iinfo->i_lenAlloc > bs)
		goto out;
	/* Now do exact checks */
	if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
		goto out;

but the TAG_IDENT_USE branch sets i_lenAlloc from the on-disk
lengthAllocDescs and returns before ever reaching them.  A USE inode
therefore keeps a completely unvalidated le32 there, while i_data is
allocated at only bs - sizeof(struct unallocSpaceEntry) bytes.

udf_current_aext() computes, in its in-ICB branch,

	alen = udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc;

with no clamp and passes alen to udf_get_fileshortad() as maxoffset.
That helper only checks (*offset + sizeof(struct short_ad)) > maxoffset,
so an inflated i_lenAlloc lets the walk step past the end of i_data and
dereference sa->extLength in adjacent slab memory.

A Type-1 partition whose unallocSpaceTable extent is non-zero loads the
USE table inode at mount and sets UDF_PART_FLAG_UNALLOC_TABLE.  An
unprivileged statfs(2) then reaches udf_count_free_table() ->
udf_next_aext() -> udf_current_aext(), and KASAN reports a
slab-out-of-bounds read just past the 472-byte i_data allocation.

Apply the same exact check on the USE path, before i_data is allocated
and walked.  ret is still -EIO there, so the offending inode fails to
load.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 23b133bdc452 ("udf: Check length of extended attributes and allocation descriptors")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 fs/udf/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c97914aa8d8b..8a0c9ea31a11 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1475,6 +1475,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		iinfo->i_lenAlloc = le32_to_cpu(
 				((struct unallocSpaceEntry *)bh->b_data)->
 				 lengthAllocDescs);
+		if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
+			goto out;
 		ret = udf_alloc_i_data(inode, bs -
 					sizeof(struct unallocSpaceEntry));
 		if (ret)
-- 
2.50.1 (Apple Git-155)

