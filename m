Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049988;
	b=pwyeh5h5cqZF5pxaGVFaK8jL56cZkPjYJpBDnXWRxa0eTbn4OyAk7nm5tJAqPZdlOloW
	 GeusaNr3Tq8fMC54lNGPfQhH3iK6JA82h4iaZ2z4FecR7zZuPZomOWokIqn/piPCvZ2+f
	 TZp40NzyPNqLlloHpZBesFlWexCA8qc2NDtmXaCY8iPQvjdFm/ugL11f4l+WalwWz+lc8
	 AV6tEXFO5c/o8ILbVDauwzhD6f94oaf3D5oxfav/Fkfq6idodGJTMlXo79irNjXKjkFXu
	 mky0rPW6VKDAJ6AcnSJeF6j+eEboXJas8aD1uDfrDox7sIw8wz7YRF78OO6YDgCV/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
	b=pTSqkmpSTuasa3lWUMcrZhcwpWFQThBViihA3Jq0U50JzbXuJf90I9UpZv8/JccNaiLJ
	 TIKwgtpGTpJ9EYzXoe2Cf0qIMc/VTiBfPYGtP6DS0GJwYWDhqiDoHSIuXPWTNVWoY+ozk
	 lahfMKMRVAnkShYwkSrjWoDJCFg7QUp9Ds7YotYLoFxIeokFG6ds4NaxSbbtWjXBU4yyZ
	 Lyf3jUy1pEa692BjMFy0d8IX33u2hO27dW38fwah2wBcOO4S2BmJXyt9B64G+FQzKfy/7
	 IIvHPlOR9vBogpwoi9cHm5R+/CGPUIqxjrBkdCqew+oy7hpTeLXpAAYtNwtwmi1zvrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEwZFSAt;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF5606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82EF5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEwZFSAt
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3712b6d9843so1871754eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049988; x=1795654788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
        b=XEwZFSAtpYwzY2QDMsdsmtR8zrBBmdbYxbZdis5H/XDLh9XZ1XBi/2Q0yV6+MVfvLt
         LjMw6uDlf0Vb2ZarbvaWJeP87th5v87qUMICMrXYZ3x1NpFq7R6fcBmo335gCeP8Uyhm
         8N9m9jc5l75PVuqM/bx2Ftz3zkbfiuFvfKW3RFcVrosJk7Yk3ULcb9PNMg2yH42bccb/
         2y52/qSbeZa9He8I0JwsFaJjpsWnah1Zv/mMQsGi5G/zd0gnHJP2YpAdMu7yYLJqm5Ym
         DYm0hnW+9eZmLwaA9h7UnanCRiCdJLJAgI7ugxz+rgXMzNJnp+2l3tjBv3YvHrTKP51X
         miJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049988; x=1795654788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
        b=EYoqBWQAmZF9YgE3MtMUz011DRz6RpFxwKZovgsJSFux3jPOC7HJm7vcFoNnJbPGX0
         sTGEW1yvxL6Vttg4xe2tZnKasyJwbXP92rSCP7p6d5Ab8GKAvd4h6yyqt1g+M3HSWULp
         fyig+584dz8lswCMjf89gNeFdKVuZ6YzvPXDR3BsftftpI+lhvVOHYxmr31lOSwk94O6
         u2T8eiRWCbnUTUpcqaiugipbMJo7z2m2vCIPSmgq5BQ/ut+jCaDiCuWnxbjt3rxbyC26
         wtd7nyKHEMIl1TZv5ZpAkh/GAR9NXL9G2dzQURHEvMgx+mdsIPJvB6b/q4CgAkcA2kfb
         mI4w==
X-Forwarded-Encrypted: i=1; AL+hErE1eFUDDaV1QBhr2DJU+zmpJJqaSBwnU/wOtz8upInvf1xTM+z+dT5jaqqD85QLja6Ct9NMeBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GxJxgEWOns8jIsmaw5bxnHldJNVBXdQ1D/OTfB2iP7Xg84LUb
	v/HhSujVw9R6pzjaIvh4N+pTpyjfH1DzUa6A9Bxk0PWOLBhZF6ZcZiRH
X-Gm-Gg: AZFdTZdjQGzyYuj6PY4SFnxpXzuD47I6IpldjLZ3lrG+RmiGhEHBRPi3h+yC7AKd2iy
	22b7mTRsY9FNl0HCVtAii9q/rt68YLXajn+1WzA8zRPArspOaAgoCS9ZunOFvMQ7758fGQUNkRZ
	mRqgKfV0l2fqztmcR/2lNJhqZVzvtMaQt9t5/zl7AqdLzGdjeruP04N+AeHaK6Px6cSZOAC1y11
	/oi8rOxYsiu0YMCPPdmfUJDhY8DkZdLiminN06i767al8gafhT6m3Ft0p0WkO825dVM8WKomeah
	nthUmMPTC/WTpZB4akHAJkbv66QindFOvCWeaQgQhn7BvMXoofoYLkrIzOR2RCpbocJDudvPkc6
	G3rhz/WRzERfPJp+/pF53I1Lca6V0+5IfQg1XfIOsIJxXz/DGi/6DjFThqzrH/HtlmwodLY701A
	XjAqoI7TA1LpBaxY21dBJiGlA6xDjPjYo5/W+geiWTZLkgCxZ96ZqaZTvFRVbwTTFDbH7KOjhG+
	sF4VUOqBjWry7jx2dVi5Vz8GtmoW96XAcRkhnZyDOOsDpK0K7C4oGDNH49G+vLfswSXG0GkEm0i
	0Q2z/kBnKKpWx09uH5bQxZu25cWfq5hMLHJ5fkeUTj6I5atSxKT3KDXTaDuiXKLmmBYOJ+zqcF1
	F6wUIA1l2ReodncAEZAdF+z/lfZk=
X-Received: by 2002:a05:7301:f27:b0:36e:a179:85f2 with SMTP id 5a478bee46e88-38281023d0bmr4364437eec.23.1795049987441;
        Wed, 18 Nov 2026 16:59:47 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:47 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 0/3] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Wed, 18 Nov 2026 16:59:40 -0800
Message-ID: <20261119005943.37851-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118013337.67813-1-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() checks the on-disk key length against the size of
the key union, but the buffers from hfs_find_init() are only
max_key_len + 2 bytes each. A crafted extents leaf key overflows them.

Changes since v2, following Viacheslav's review:
- The literal 14 (node descriptor size) is replaced with
  HFS_BNODE_DESC_SIZE, sizeof(struct hfs_bnode_desc), in a new patch
  1/3 with no functional change.
- "max_key_len * 2 + 4" is written with named constants:
  HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE) for hfsplus,
  where HFSPLUS_KEY_LEN_SIZE is the size of the __be16 key_len field,
  and HFS_KEY_LEN_MAX_SIZE for hfs. The allocation size is unchanged.
- struct hfs_find_data has a comment before it and one on every field.
- The new field is in the "filled by caller" section, next to
  search_key and key.
- key_size is renamed to key_buf_size.

Tested on 7.4-rc3 with KASAN in QEMU: the crafted images are refused
with "Invalid key length: 516" and there is no KASAN report. An image
made by mkfs.hfsplus survives create, rename, delete, xattrs, appends
and remount, and fsck.hfsplus reports it clean. hfs is compile-tested
only. The series applies to mainline and to hfs.git for-next.

v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

ozgun kultekin (3):
  hfs/hfsplus: add HFS_BNODE_DESC_SIZE for the node descriptor size
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()

 fs/hfs/bfind.c             |  5 +++--
 fs/hfs/bnode.c             |  7 ++++---
 fs/hfs/brec.c              | 36 ++++++++++++++++++++++++------------
 fs/hfs/btree.c             |  4 ++--
 fs/hfs/btree.h             | 31 +++++++++++++++++++++++--------
 fs/hfsplus/bfind.c         |  5 +++--
 fs/hfsplus/bnode.c         |  7 ++++---
 fs/hfsplus/brec.c          | 35 +++++++++++++++++++++++------------
 fs/hfsplus/btree.c         |  4 ++--
 fs/hfsplus/hfsplus_fs.h    | 28 ++++++++++++++++++++--------
 include/linux/hfs_common.h |  3 +++
 11 files changed, 111 insertions(+), 54 deletions(-)

-- 
2.39.5

