Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627136;
	b=xlb4LV6NFQyOBTXs8Dnxek1tPopVpFL5EpAPjAvxlP2XskOrbvHOELA9Gm9od6AalBze
	 x5DTH66vaRa+x2Qkj3ToxrSMyy9qVH5w1o8MHDV86QoRAjgBlDE9APxRAY/jkiba/OHCR
	 TTfEibQNxBN4uOp35iyssRFGBPPVq7p2w2m9fDPw6OXFadshG62A1ewcRYK4MV6v1Dc0/
	 h/vSuoZsmpk5hye8rjVBfLBNFW6p63lTwDypJrU5aBt4kzHSsZIlFPDuqK44icRyO76Pz
	 AJqdg5JrdNkkGH/ObfaipxxkYTdEPkGEqQcY5mM93lHbMJPY2oH6y93To2xqW2sZhfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627136;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pVXNoWjABdU5RPs5u+4FyGSTCEAB3njAGPbzu/Xpj+o=;
	b=Es9DC1u7zfjmkQcDrIlZozekjsAXKh0shw8WAwguL2gI+VJgKJzopde9iT/vRHXEPfHw
	 4zEIyixPo45Bwl/xMocbw6gklHLMdbq0NKlNCtkjRdejlMB3JD7lTcfpR5buTW3lmCDkR
	 vJ08nTsRRU7WLbjbqSXnLLRMcGCkSUMGGgvgXeXogaAoOYjXoYp1TVJ0Mg/UvAyA8CI62
	 5VPeH9c3zdCNsfd01mczSbLSAhlA0GSkRKAWrZPOecWUWUjG0hef1eFNDJyje7O5kDtBr
	 22vq3TaSeWrBsZBHYNIFwOY8pAljLvakNI3x//e+AMfdeE5dpZqyX7HRyGbBKelofzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A7606A327;
	Mon,  2 Nov 2026 13:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62A7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJCdS11NSz8XrrJ;
	Mon, 02 Nov 2026 21:45:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A2DjS7c084264;
	Mon, 2 Nov 2026 21:45:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:45:31 +0800 (CST)
X-Zmail-TransId: 2af96ae893fbe0f-10c10
X-Mailer: Zmail v1.0
Message-ID: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
Date: Mon, 2 Nov 2026 21:45:31 +0800 (CST)
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
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gdWJpZnM6IGhhcmRlbiB2YWxpZGF0aW9uIG9mIG9uLWRpc2sgaW5vZGUgYW5kIG5vZGUgbWV0YWRhdGE=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2DjS7c084264
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 21:45:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE893FC.000/4jJCdS11NSz8XrrJ

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

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
