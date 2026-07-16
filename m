Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3438887E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188806; cv=none; b=Lp/lMF+p6ifFdw+DZUgjXtuk9koBaKekdokHkoIMHNUd1mDfe/SYj5cvjyT9Be8SeIGR1X7Rj/zAyVBP4A0gFedeX+GhZfts+rIBoiR5O+YJMLqiM3P2OqYX7PBX2gFEY+W8DljPZrXCgQI5JMli2TCd8rQezkz8cx7IZvyX32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188806; c=relaxed/simple;
	bh=vCaa/+brm9nxFb9QmYyqngjktvrjQldWrK0O3DhoCUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGQOlGSL6d54xnxSVE+ep3kH1uORzRuOU8LpW6YGE7qtEKp09s9NAzHIkDg801/FXYty5wp8lwNcdbdSU+2zI91zsmbrunU5KZdSKm5ptU8bThKKBhmUlNMc+FRSqBeFV1pQ2IiMi5H7zK3daY9M2QnVN7zd7HW0quZhm/BobYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gp4dioGY; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gp4dioGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784188779;
	bh=Cq8fFIl2lQzacn/G2pBBMSNBXyqKtY2wVLGTY84/sG0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gp4dioGYZ23tHnArLAdTHAg7xzezZm3fYQvAHFCAt0r57SCKzcgDC8GuTZ0bMXcwW
	 h1a0dCq3kGL5njbeZEMXmRtZAfRYJhX5tMxnyhXi5EIMGyB4t5JB7AdXBcx49wPOXq
	 Grp7NC4rNvK5v9QtkTk4GPglIegmTNCaDT1b/zzM=
X-QQ-mid: zesmtpsz8t1784188761t0613201d
X-QQ-Originating-IP: ttFcjJ9QUkOZJJax/mcixSG1MK1fXBp77uqorM5hWrc=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:59:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8310817960823921516
EX-QQ-RecipientCnt: 5
From: Yichong Chen <chenyichong@uniontech.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 6.1.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 15:59:17 +0800
Message-Id: <20260716075917.1165360-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026071425-unhearing-deviator-ae0d@gregkh>
References: <2026071425-unhearing-deviator-ae0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NKYc+ElofZ+sKEAHsWkPbtF6YDZdnt5Dc5j7bMbiGACTggbQTfJ3aRDv
	quhkt3HJ32Lym/E7upmYYD0jp8zyf0kUZCk6ESQ6Dk6CWExgNgEMjp73KCasgx18au73h3m
	mRFWELTS2niVCjH+nDuZCtb+TK/uXGJz3ihAVRFN8vRAYUkBRc/RlLLCIU4E50WM/pq6FD5
	SCRWWHUd9M7dmTrYW9soYpRHhLj83HLOWaknJA7bcq/g1zN8mcyaZHPn66Lz/2gWC2nAda9
	rddnbPwOCxr9VhEs8e2q+z5qITTe6MLM5s2BY8EtITAK8vpJbl8QhNKrFSUmK2rSPnQougD
	Ka+kv1N2NVaWGO9ynJnPGJCzGVNUXt7HMK8T8YFNZ9EQTYoXFTIWAENSqiGmQwg0uKg19i8
	tgRN4uQUv9MCWzrxXFZdjzmYP3GbOgp4U0l/nKLkg1+2XlPfqap3psEmIBGKJk9V2MiLeba
	bMQGxCOjxzw/yeiQrKSRqsFeze7TQBe5lYF4t4awBMH/g1CfIGLn05+L3+Zf+hQ1VlnD36B
	SKhfwMmYEcDccZ10HqRwypCUJX4JfCRZgMCtYeIalFTtpOGA12tQg1hPhTNFvxV9KsGixYC
	QtHEiFJrqUqHjMn5aNwFzRz5yooQWWyipGbhQLeR0QO+Bgc+X/0I0zwyALpuIv3ZEGzQrWm
	ulSGD6UKElYZpc2gvTlxCQPWyEoNjNBXAXxgp9WQTAcKUoBDW7J04OeAx7UHaME+GFdru4W
	OPC46D6FwEtn5+2eDNHMVquI++1oOXtAz8cbngvwnNPVNnez9viMR7KgMTGOOUpCZah6w6U
	nUW9TuFdiGxpHHpXm+YRML7pT3JjjM/bKR0guhU1kftZlzIVxHxPUJpK3YK6AUHkQntwBZi
	IiXdLR0Jltzl2xFNRwAIs0AJ+Ne8IuI0bI8asbnujPWlpyBShEIe733aZGHn4Z7nhezdqJ9
	mBtQZknz7CGzAazPetRPyYYJCnJ/2kcNQpP0ovknOvwsfap3p+ZLW2egy+19mDbodpu1jzb
	ht305BrtwgMpY3LbGizQMxQs4IJk77VcmZhdxvFNQd7MmA5DMl+4o42H5yR64=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
objects_total. As a result, the lookup fails and the field remains zero.

Use the correct attribute name and rename the corresponding structure
member to match.

Fixes: 205ab99dd103 ("slub: Update statistics handling for variable order slabs")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Link: https://patch.msgid.link/96556748872BB47E+20260612071359.649946-1-chenyichong@uniontech.com
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
(cherry picked from commit 892a7864730775c3dbee2a39e9ead4fa8d4256e7)
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 0fffaeedee76..d26a44e3e684 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -33,7 +33,7 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
-	unsigned long partial, objects, slabs, objects_partial, objects_total;
+	unsigned long partial, objects, slabs, objects_partial, total_objects;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
 	unsigned long free_frozen, free_add_partial, free_remove_partial;
@@ -1254,7 +1254,7 @@ static void read_slab_dir(void)
 			slab->object_size = get_obj("object_size");
 			slab->objects = get_obj("objects");
 			slab->objects_partial = get_obj("objects_partial");
-			slab->objects_total = get_obj("objects_total");
+			slab->total_objects = get_obj("total_objects");
 			slab->objs_per_slab = get_obj("objs_per_slab");
 			slab->order = get_obj("order");
 			slab->partial = get_obj("partial");
-- 
2.20.1


