Received: from mail-vs2-f26.google.com (mail-vs2-f26.google.com [74.125.227.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCA4BEE27
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164727; cv=none; b=dQc2tlSmsU8CtZRemKQ1qhktHbywhDsu8RUK4KMCm8r19NG/Rkxldsf4ydX0oatQXQh1HmA4TqTaGpzHh474hBKOa/+qSstobPLfombNxsvVvuNSfFVW9K7SUBRng9js+GbzuDkTrt91Rif9rnUDQ8yo4qH4Y/kURTnsWi0IF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164727; c=relaxed/simple;
	bh=g1HCBr8bsZcnUx3gO40OyrqGIOY7LwAa+VsmFs5/+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfWil0gLTxs1ztZarMo1/HZNrBFePdscwNs88sQbd3bmkscgmrs5iUAcNEgGafrVXPrhwKRYv0i9xeiIsEzYLDltUdObigJ+aPODB0c8EchRgLkxbUhL4I3DlZE8v/OmhiX7citN3TheDmWz08abGlw7g34y0eJr7jF+/0qCkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/DD0KnQ; arc=none smtp.client-ip=74.125.227.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/DD0KnQ"
Received: by mail-vs2-f26.google.com with SMTP id 71dfb90a1353d-5c67e529da9so332172e0c.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164718; x=1790769518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lN2b/UwZ6UTOnQoQGsvb5dcfV+ZMY1X8+RCUQeVLWRk=;
        b=h/DD0KnQOc2oGXVJR2/COVNTGXNVlfKXHWxIUF5spcvkjpAYkYW7oLUdPeVzz4rdkF
         n/NdqC5ze33Y7o/hEZ8R8qTuPFjpYRhhLr/1YI/VePA0qLDSDHQVIJFtSG4DwoF1AVif
         IkdXgFhI9EvyUyq1a4/M3qFkNUAE9KpWnGbysAVHsC/g/kaziU1+Z4vapZ7R5BWv917v
         /PsEqWf6V2ZXndXr42HcoaM1ybOi8BBiOUM7oENIp00GQXzFrZYh9Mvdk5GBsf/v6f0B
         8li/nd/lc89m/PKKSQvGnsVWj1F1VHb9ppdmQ88s039MxNiOME9XKL6xlWanU/VJobNj
         sltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164718; x=1790769518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lN2b/UwZ6UTOnQoQGsvb5dcfV+ZMY1X8+RCUQeVLWRk=;
        b=VCDrbhKYFF9iWELgTXUpEapcWOv5pp+T81LVgEWpOtDt07uMqfLhpuDpI9I3YgOfpL
         PzHMucn1mGr4+FQqH8kj5pZNAgVVrUneb1jiKP9t3pMFuuhJQrB+nt2XrYBqO2vyWqAt
         h2UWCO43QgUzzABISOI6XxTREG6ECqsC+zZLmocsVKvOrD4hmyuKhEv+avBLLludZBFg
         w37UpY0WZQIUuhE1bM9VM8mMJDtyNnjoqDgWexChiGvcZopSkg8rPSlj9xrq50PQlila
         6OsjhEJl3hqIkx471wWNAeS2RaiYmyXKmXo9/RIFB5Js050plv25dhKKUSwWppPGFIrq
         3ACg==
X-Forwarded-Encrypted: i=1; AKwUvBy7GUznLn/+s8g79VBhi2kcY8GQsKhtzlJ+plW8GiEMnP2PP2Gh2Cx2RPjwXANCgtMw02ppLs0=@vger.kernel.org
X-Gm-Message-State: AFuF++mUQypNpdLSIG2zV61f9quNKQki/w4dPThkmb5vYlRnCYzKyapo
	EsWyj+/4UPlGdw6kAuYYGXVXHm2mYgltHtZzx8Y2Cn2F7L6liLeAFLAF
X-Gm-Gg: AYBFou1EJnItl3quRiXalPhl12jUUfM0QSG86CjLWkodN2Dn+It6u1J67jZTng44FsI
	4y/qLcXbDn9Xg+1luE4CgaNsH2whCW2EY/FrR6xDq3KCzHqlQRTdQ8I1HifXU50oi6jFp6dqT4E
	CxWA/LqYVtQHNe/3GmUW/s+EUhvPppcYrNFHx5yWfyx6vM5EiHDUffSehdhdHxmzgxQBi8tF1ow
	pvREgASVDYHu5RxsfBmeXFM/63/y43cn8eDU0SROfSokOA8PPytD6sS62sZxOK05g5QfoINFgYI
	gjn9MPsY3Xn5ugcVJwY41B+8VSTo7ld+vOVjvq/2IVhzxpz0QbGODL6U2sa/ep8UF9fzikYFq7G
	BRukN1LjPf3hcXE3Q/4jOlhns255CtGjeS9zTd7+ahg7YYqy//of0hc8z8hSU+EQ3U5i3W9pwmN
	uiM1D6XHqmC92jt4b9m0eh10OFXg+lZIpnUhLTNn9GG3lASWsD+YKYmdWhF/o/cLA=
X-Received: by 2002:a05:6102:94b:b0:7a6:a24e:8140 with SMTP id ada2fe7eead31-7ac1bd45308mr2260190137.14.1790164718584;
        Wed, 23 Sep 2026 04:58:38 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-985167e6fcfsm3257250241.0.2026.09.23.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:58:38 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND 2/2] xfs: reject remote xattr entries with an out-of-range value length
Date: Wed, 23 Sep 2026 08:58:23 -0300
Message-ID: <20260923115823.3305596-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923115823.3305596-1-qwe.aldo@gmail.com>
References: <20260923115823.3305596-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_attr3_leaf_verify_entry() validates a remote attribute entry's name
but never bounds its on-disk value length (xfs_attr_leaf_name_remote.
valuelen, a __be32). A crafted leaf with valuelen = 0x80000000 passes
the verifier and the CRC.

That length is later assigned into the signed int args->rmtvaluelen
(xfs_attr3_leaf_getvalue), becoming negative, which slips past the signed
-ERANGE check in xfs_attr_copy_value(); a getxattr() with a small buffer
then memcpy()s a full remote block into the small kvalue buffer
(xfs_attr_rmtval_copyout) -- a heap out-of-bounds write with
attacker-controlled content, from an unprivileged getxattr(2) on a
mounted crafted image.

Reject remote entries whose value length exceeds XFS_XATTR_SIZE_MAX in
the leaf verifier, so the malicious block is rejected at read time.

Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: cc stable (per Darrick).  Now 2/2 of a series: 1/2 fixes the signed
    value-length check in xfs_attr_copy_value(); this read-time verifier
    fix is otherwise unchanged from v1.

 fs/xfs/libxfs/xfs_attr_leaf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index d0f7753659c9..948dc8b26fe6 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -339,6 +339,8 @@ xfs_attr3_leaf_verify_entry(
 		if (!(ent->flags & XFS_ATTR_INCOMPLETE) &&
 		    rentry->valueblk == 0)
 			return __this_address;
+		if (be32_to_cpu(rentry->valuelen) > XFS_XATTR_SIZE_MAX)
+			return __this_address;
 	}
 
 	if (name_end > buf_end)
-- 
2.53.0

