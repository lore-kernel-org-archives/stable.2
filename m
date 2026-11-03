Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686757;
	b=n0UcovNvcdxMluBA5t9+z9xwOKo6MKcKIJvDLgdHA0XmECVssF2y2f6IqDybw8mWGrHn
	 fYSWGXbu2XQgpUahCcukSJVDBzUQXDy3kxvz98bq4u08UloQggxbZEXjqw80LydVW9/NO
	 MYVJbfKkpfaZ5zSLNpPcaufjNiYBRMWZPqQDsi3kJqRGOJvDL4n02Ikhi1TODF6aJgB2h
	 Ch1RFGeHcEg6czS4j97cr9y80eqvT7GpcQ16kvIyenXW/qlp9sLA+tvjqnyEBEqLhDwZg
	 3BTHiPe1L+HVBlOuiED0CY/7n89coUfp60y0uyrtxcO2lOGsMBEtnFoPRL4jf08yK/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686757;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=62+kkbXDG+AlT7/ygH/+TVd/CeeemyqgXM3LMKwYxB8=;
	b=eCLacYtMjqb96UFGprAGg4qs/CPhUpBQD4kT7agvwijiQVyQGRd0B4lsNv0ygyz9NGWN
	 OeREJI3i6v8vIm+UWm8wJHRLf85liOmcECHXhO2r2gSNUeFHduaClpH0CpYYHL3ltRu65
	 ELonk71KxcH1ZkD4aZqFXHvhJGNWYLNFsMrZ1Q5oA9gvPVOI4sfG9Q8EWt3QGbYFFBP6A
	 IZT923Q3cvcWx1EuRT75kknmWThyhimn4BlH3YvKGyb1KFqBei7O5L5FvFgJ52MCCjtBJ
	 19vrAPr0J4RDBg8/0aqGQdycEdl8PYi2oQtUtiLYaIW4i28duJT0oSWahH22WbAyRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7037606A324;
	Tue,  3 Nov 2026 06:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7037606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJdgw0z9Bz57HS3;
	Tue, 03 Nov 2026 14:19:08 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A36J0Ho001244;
	Tue, 3 Nov 2026 14:19:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:19:01 +0800 (CST)
X-Zmail-TransId: 2af96ae97cd634f-c4c9f
X-Mailer: Zmail v1.0
Message-ID: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
Date: Tue, 3 Nov 2026 14:19:01 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>
Cc: <linux-mtd@lists.infradead.org>, <chengzhihao1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNV0gdWJpZnM6IGhhcmRlbiB2YWxpZGF0aW9uIG9mIG9uLWRpc2sgaW5vZGUgYW5kIG5vZGUgbWV0YWRhdGE=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A36J0Ho001244
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 03 Nov 2026 14:19:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97CDC.000/4jJdgw0z9Bz57HS3

This series tightens the checks ubifs performs on the metadata it reads
from flash.  All five patches are about size and accounting fields that
are taken from the image and later used without a range check; an image
whose CRCs and node tags are intact can therefore drive the code into
state it never expects.

Patch 1 rejects inodes whose size does not fit the signed loff_t the size
is stored in.  A 64-bit value with the top bit set becomes negative and
passes the max_inode_sz check, and the read paths then do size arithmetic
with it, for example (i_size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT
in do_readpage() and (i_size - 1) >> PAGE_SHIFT in populate_page().

Patch 2 rejects xattr inodes whose i_size does not match data_len.  ubifs
keeps the two equal for attribute inodes, and ubifs_xattr_get() and
remove_xattr() assert on the invariant; with assert=read-only or
assert=panic a plain getxattr() or removexattr() turns the file system
read-only or panics the kernel.

Patch 3 checks the lower bound of the master node's highest_inum.  Today
only the upper bound is validated, so a value below UBIFS_FIRST_INO is
accepted and ubifs_new_inode() allocates numbers from the range reserved
for special inodes.  With highest_inum == 0 the first new inode gets
number 1, which is UBIFS_ROOT_INO and already in use, and the index ends
up with two inodes sharing a number.

Patch 4 validates inode and data node sizes during replay.  replay_bud()
trusts them, and ubifs_recover_size() may then extend an inode to a bogus
size.  The normal read paths already reject such nodes, and truncation
nodes are checked in replay_bud() as well; do the same here.  The data
node end offset is also computed in 64 bits so that a large block number
cannot wrap.

Patch 5 refuses xattr accounting that cannot be decremented.  On an image
whose counters are already zero or smaller than the entry being removed,
the unsigned counters wrap and ubifs_jnl_delete_xattr() writes the bogus
values back to flash; the next mount then rejects the inode because
xattr_names + xattr_cnt exceeds XATTR_LIST_MAX, so a single removexattr()
makes the image unmountable.

To keep the severity claims honest: mounting such an image needs
CAP_SYS_ADMIN in the mounting namespace (or access to the flash), so none
of these is a non-root attack.  Patch 2 only turns into read-only or panic
with the assert= option; the default action is to report.  Patch 5 is the
one with a persistent effect.  Patches 1-3 are mount-time validation,
patch 4 is in replay, patch 5 is runtime accounting.

The patches are independent, have no inter-patch dependencies and can be
applied in any order or as a subset.  All five carry Fixes: and
Cc: stable.

Testing: each patch applies to next-20261030, passes checkpatch.pl
--strict with 0 errors/0 warnings/0 checks, and fs/ubifs/ builds with
CONFIG_UBIFS_FS_AUTHENTICATION, CONFIG_UBIFS_FS_XATTR and
CONFIG_UBIFS_FS_SECURITY enabled and W=1 without new warnings.  I did not
mount crafted images: this machine has no mkfs.ubifs/ubi tools and no
mtdram or nandsim setup.  I can put together an image for any of the five
if a runtime check would help the review.

Changes in v2:
- Patch 2: fold the size check into the existing ui->xattr block, as
  suggested by Zhihao Cheng.
- Patch 3: merge the lower bound into the highest_inum check; both bounds
  now report error 3, as suggested by Zhihao Cheng.
- Patches 1, 4 and 5 are unchanged from v1.

v1: https://lore.kernel.org/all/20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn/

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
