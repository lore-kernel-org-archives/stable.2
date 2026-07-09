Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16737335BA;
	Thu,  9 Jul 2026 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573840; cv=none; b=hH4tRaNg8rgVEc4R0JaluteB9CQDt9OmA6o52qdga1EecWz4gr1txF6oty8Lgy9ckhKQkg2Va2QHadXji7AuVG2nBzHL14NT10RO4j33Fc0qmqYWBiIOt0BwwXvMAzAOhs14XQOVUd+moiQvQ6iRLXi5WgfiRlFd8YVOWoeYgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573840; c=relaxed/simple;
	bh=bArJglugTDLUlyd3Jz+IwTeXArCFn6FuYJvM3Mnzbw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSfMUoSv4yldz0b+YFXXWBWyOp15tLwULqXVLcmh7/i0ohiPCsTuYKJvjlJVNsm7eKmzCaNlHvYHYIkuYZXrHpD0l8VPgOFk0B78Fe+vbT2ipqyVdK3OaDvRY7ikhg9JX9JcrafmMIkSRXiALN6ZFeTss0EIut81h8ekAp13zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=rAleO5IA; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="rAleO5IA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783573766;
	bh=b28BuLuWzZmVa3dZHeQAGfeKAnuThtv1IUJ4ATrUWZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rAleO5IAF6tZ4gLZQlcdVjenXRWm9zNUEzymH+6rb7kljWNtoqFYq6Fnzh007UQrD
	 WOTBoiYVeEeGV8Jq1bsGbhneP2mtfj0S527mumecUdoDxT1//V4dRBMC/mf/fjQ/hw
	 OEOM0bGCG5nkj/xD1dyfLq3hFLPEGuvP01cNON6M=
X-QQ-mid: zesmtpsz9t1783573764te49ad84c
X-QQ-Originating-IP: Z8/nptW7vbCW2LYigMLkSc4KBAdczReFyJFdB950gjY=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jul 2026 13:09:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4659233235440531068
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	stable@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommufd: Reject DMABUF pages from the access pin path
Date: Thu,  9 Jul 2026 13:08:00 +0800
Message-ID: <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MC1aAhoHww3U1Oo0dThj6QvC7Pgx/yty65IzW1uSnl0RGl99PdDy/hIb
	ChF4UKlGfaudeiwO36o77ZX3NMDbR0kG7hJlsbdMeSOxRUwJFox8u/nGU/LFpJ1mjS3pucM
	O8H7U1zh2MOf7pgfCvdqr4tRi6MEl+5k6+FExSpJyUoSVctQDVhGbWPmDkmHvd0OyFNRlZ4
	nKmKb7Sp6cdYOLAD1nuOX4Zj/HVBgqh0rWTnpVnBEwlaEznhnd5GPtmnFERWQXclMx2eBU9
	C4ufGN+67HI/dWlzrbUetlkh6PgjaY8Cl8TBcitJtiV7gSmOrgu0I4chb5ABpm1Zkle3IWF
	PYB7mScebjGTi/5fLcN7LaZqxo3bOFu1O7yyaycBY7u4Bg9dttQFcUdUphmwZJVMxTaTw0o
	KxwWoYZRyjLdRfgSodXab/hwigl6Kvlhr6DYmmM30ovwAocpYz1PyQ6UEac5asCv6NQFZBO
	QDMJKqWbZX1k95A9vEWzI8HsmWoY5E472wkUBv6cr0NJGhJdTFKTPiIQHc/iVPQezuKHEOW
	gktNj+oDx+07oXQ6O3f2PsMhS7eDC+YF8L2mDTnxJ2Qf8ER5/eJVJyce46Zi4URidufQL1z
	LP0k/sR8+Hj/RvLzzhcBWE3eMw8Pbn7qhIlTj3kE0fNeLXxhoFL8B82FkRAi1aAAM6PcoFQ
	VV1azxxdgRc7eMy/UkWCAYVfXkAUYY7SrGVJQj28CoxbzKuSXwLM5kGBVE8drztG+4IY8op
	PteDGBiPuJAG/EDOM9WZPjYmy2dApnb2Uai7BtrZSx9lVwZwteyttu/Nc61Pdv/2tgS06WZ
	EH1j7B+1QkLeomBjKheTw1RZunB5az7o4jfNqwf+ccvc8ajtWtCGAbP6w8v0ZTk/kpTnDLU
	q51J+tfatj0UtF3yLywK30IsBX7KF2BO67kD7EbciK/ppRiT6JRdwxjRdc9J1SAWKVDfzqR
	cbsFFkwm9Ocft5hzVdinwjNad+AKQIUMuTjVU9VIDvu/PF3u75eSugerZb3qWgypHVxi9IY
	e4BH+3xPEvXq0ZX6faWWulCliqZVvjURHOkEsH2YzqyIsxRaLl+z+yrvS3qEeVcKXeiF1nJ
	mreXEShLtWDZBtNa7a73RA=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

DMABUF pages are not supported for iommufd access pinning.
iommufd_access_pin_pages() returns struct page pointers for
in-kernel CPU access, but DMABUF-backed iopt_pages do not carry
a userspace address that can be passed to the GUP path.

iopt_pages_rw_access() already rejects IOPT_ADDRESS_DMABUF before doing
CPU access. Apply the same rejection to iopt_area_add_access() before it
takes pages->mutex and calls iopt_pages_fill_xarray().
Otherwise a DMABUF-backed iopt_pages can reach the hole-fill path, where
pfn_reader_user_pin() interprets the union as uptr and
calls pin_user_pages_fast()/pin_user_pages_remote().

This fix also avoids the lockdep warning reported from that path, where
pages_dmabuf_mutex_key is held while gup_fast_fallback() may acquire
mmap_lock.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn/
Fixes: 71db84a092c3 ("iommufd: Add DMABUF to iopt_pages")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/iommufd/pages.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 03c8379bbc34..404f31d8f729 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -2451,6 +2451,9 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
+	if (iopt_is_dmabuf(pages))
+		return -EINVAL;
+
 	mutex_lock(&pages->mutex);
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

