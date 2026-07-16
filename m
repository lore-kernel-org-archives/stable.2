Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DED2F290B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189560; cv=none; b=QUdIzkqlm2lHKbBDwvKt7qC0wFeDcQvNmrgfz2LcUsv8ZJQYAmPQ9+8WSgkNroZTFHutWUQ/kpS2K66xx2stBUatKmasZwjfVlON3oGX+gfwDRazB8Q1Z8+xzOTICgWkxorRaeM+SnQzHXaCSQHWerSP1FhGgr9P8R7q4tRFHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189560; c=relaxed/simple;
	bh=vCaa/+brm9nxFb9QmYyqngjktvrjQldWrK0O3DhoCUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLXX2hIZ7tYvzqAHLg9h7YvPLOjQYCZroBAVuS6DcF524W0a0gE32L6NVVTc+hmdoWDfYH1t+K0W2FJ1jvHI8q7CkBCsanifsASwxLKyAByWbWCu5S8dDSZ6Klt3vm4XqT6kKXQrafPW2L5E0a8bvUZuQ6WBD1tlQJCdgmojt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JfhDT8/Q; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JfhDT8/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784189528;
	bh=Cq8fFIl2lQzacn/G2pBBMSNBXyqKtY2wVLGTY84/sG0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JfhDT8/Q3ThpEkCmKEbnq4p7a9NpOCnHIyPU1O3K/vLCboEEFGMcfKZ1S4ugej6rx
	 kJ3JvCwpM21NSpuZZpt7WteENhFwnJKbwNArbc3YNbCt0aZ9F9xkOfQ5z9Ap1vEnyf
	 sIZJSHJRp76wCv8u01WG9KqmHbQTZaaLPSqdUPkI=
X-QQ-mid: esmtpsz20t1784189513t5076c8b7
X-QQ-Originating-IP: jwxEsdzVob9XTCUqIMDQdjZF/NRqf2fpM6UPdA4yjMg=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 16:11:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5447161302165561467
EX-QQ-RecipientCnt: 5
From: Yichong Chen <chenyichong@uniontech.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 5.15.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 16:11:50 +0800
Message-Id: <20260716081150.1166017-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026071426-segment-spirits-4788@gregkh>
References: <2026071426-segment-spirits-4788@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MaIH2qpkHSlA8ioAGzFGNpEAnHIO3yaXvsAFgoth5OWiY4QoYP6KJw67
	8ufhEyHEzA3S1QoS8fK5eT7TanuFqdug6weWIawn9YF+wi2hs93x+wWfRIkyRnKzaV+XxNK
	z62+W2GyPqAId30jS1ixoczHu1NfgSora6y543Qj49cslG6YSB3mCTUDQTyxGkT9+Cm4yOB
	g5RxeM4AjR7vhCqueWOZNhwebtnoxxZsj2vtelbZ+Qo9TD0DLI0aQVd344Bd9zBRbUrUtmj
	bLVeOpKc8OT9k59ThvJQtvK0+tYL4f+1/5/MWKLJyZgeYEM1Ri2vuecJUnf/OBSXv5WGd+m
	oXY1ySXcqQ2iCmM1DopzqTNyP3w/08q8JEAFv3zqjjSMP1aSX3KcXqCSh0uUMWwtu6pfYsQ
	FhFFNGCUTi+dd7f/zHp9Rng80bZAD64SOyK/cHmp0IWK+HZN9+R2BFV+487qgs32XS6lmbo
	BalyTA0IjM6txXrZhmKQyTvF7dFqpoW0iSi+as9YCwX0yGeKxaVqFsP/WIrdIgrkYYgeD46
	un6xe9UDGlKrJLetCiDCwwiEnhfx8a4E3AHXBO2cxpOR0MNJ1dXySnuMXcaEYFFQuDnqwce
	//5RUx+IXT+4Jo2P8TSfnhOC5NWjbZbklIhO+4gT7l0Acuf/eAl84LO1SMVCLG3Lb5thBrX
	0Cp3b3sevQyDcIUS8ok9ph20blBAvtDx520qrw+iyb3by1yNXom9iFF8tdFkDhZdrnpYyhL
	mlwcZb5o/FSGn8EtBwynh8aqLjjJIy9fIqKrg513PgToOQ8lJhaX97EStv/Q3OgZU/WfC3k
	t7MENKHfA9X0FzVScte3ulL6sTU/GDe536oY4xROT4XWSIRdOoTgcc0FbQTl72YQUMdYnli
	3hGreiZ//uQ7vd4IlhjnlHbb+K1R8Lu7v60j4J3crX+usds+I8jW6shLRBb8LJQtlCewGex
	ac/BHNIrFP07eGQrYp8qG1ZctzxNIZFiq0Sp9lu3GUcd7IUJiEiePArJ7B2lpSKpVGndX/e
	m0AD+e5g3imW2lh4w+HLpcbVnIe7DRuBM/oMpRWaopsaR1Gfmi357YmyOOMFA0V4BmMtM51
	VAGFsLAFU+VKA8SyruHQnUhkz2/OGZBydhh7AQJ8GyNQn1UDfS8dMtnewmfPlSTkg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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


