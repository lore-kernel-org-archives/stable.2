Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318175;
	b=5mN2IkzjWGInwnuEbtYQf86OM6VqPC91YkzeDlrFTZE81ZqZVr1cAhL0HSIUM4hsZDhu
	 Z5S4BjTtwhEsmGOvtUjr0MOBhTIRJZf6atPT0crG8MtJvKjfHP8rWj8vfDUtaZHacU6mw
	 ETMwcnXlV1wsUK7UAfPHsp7Pr5GeaL+QHzEteGBjDCoXMRWYFJ4oSXzktn35boX18Jti6
	 nxXv6Uh2tGrnkuy3+amoSTkFJzHOIXiF8assT3eb8txFFh0Cdjex7MG+YxdNWPxCM6m4I
	 sUmjYDSXmIQkMGpHPPx68OvXDmw0EIJVlpw7d2cZHef/c90YzCFT99G9bLI4i2V+IlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cegQ1B36SRGNswGq2aaJJvWVsTsz+N1PSENk04DxN7I=;
	b=pefQNnygENVyg++JdMYXAYcjEpTeo81eQlvsXS4/HIXLDMA//UiMm4TL+aEzdg24Di+I
	 XhRNNGFdIR0Aw84TkNyLQ5OX1GBJVpCIRTFq3IYsD94tsDydgy3OuD9UmUCNH+AOyIXel
	 h1yy+pm0p3VesxPcq1qcb1Cpt0jw+gYqDmsizlgaXs0HyWWG6mlMmHBz3EEAwjaeFK8ts
	 ig/V33YkkUYOUYo1Tm9hof8RW2Cqvc+CeAJIOBsfcLN2tIxqo2zW7dtnDM8LGqzW9PINx
	 3zdp+livB0reMTL5xKq4460usGcAKpw3/zVFvnzIXeln4Kn4vFiVgBydVAFV6eYvXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gehbi1U7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBE606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gehbi1U7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62D51F0089F;
	Tue, 10 Nov 2026 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318175;
	bh=cegQ1B36SRGNswGq2aaJJvWVsTsz+N1PSENk04DxN7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gehbi1U7+ZjAJoVwnNikm/yVOsvpTwc0kKJ3SoWmnPQ7HN7MRzhadbWEj1HOhonTy
	 k7K6vjvpEWJH2KCOSwv8XEl8dVbmn5A4cVX0t1t5MllAzp6EwUITvLqisEgpa1dxnp
	 7b4cBx/g/CvJFM6/Vwe3AevJ34d7rc2faBIyZLehFExyU0hoUVdQ7/Un/28pWTx5zZ
	 sIy5ygaQDpnwzT/wZ+DGikjXI/5D0ih77WiwbEUIULgw6BkutJipEREJP15KS94GES
	 KAP9DoV75yR42F+46JbkM8ikSocjXFXpn49ArQ9Vp4+sAZHGGvy4104lDxD2vXpptq
	 cy8fSv/4Cyr7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xen/gntdev: prevent private mappings from becoming writable
Date: Tue, 10 Nov 2026 08:42:53 -0500
Message-ID: <20261110134238.1758836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062010-failed-5.10-2176dea8d8c1@kernel.org>
References: <20261107062010-failed-5.10-2176dea8d8c1@kernel.org>
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

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit 2176dea8d8c19cb43a9b3651bfa1cb21eab1b31a ]

gntdev_mmap() rejects writable private (non-shared) mappings of foreign
grant pages, because a private writable mapping takes the COW path on
pages that have no proper struct-page backing.  However, VM_MAYWRITE is
left set, so userspace can map the grant read-only and then upgrade the
mapping to writable with mprotect(), hitting the same COW path the
check was written to prevent.

Clear VM_MAYWRITE for private mappings, as i915 does for its read-only
objects and as fixed in drm/vc4 (CVE-2026-68445) and drm/panthor
(CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: ab31523c2fcac ("xen/gntdev: allow usermode to map granted pages")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>

Message-ID: <20260819084217.1577-1-suruurism@gmail.com>
[ sashal: Replaced unavailable vm_flags_clear(vma, VM_MAYWRITE) with vma->vm_flags &= ~VM_MAYWRITE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 06511e67fa520..8af9c86e0fd99 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1064,6 +1064,13 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
+	/*
+	 * Private mappings of foreign grant pages must never become
+	 * writable: they would take the COW path on granted pages.
+	 */
+	if (!(vma->vm_flags & VM_SHARED))
+		vma->vm_flags &= ~VM_MAYWRITE;
+
 	pr_debug("map %d+%d at %lx (pgoff %lx)\n",
 		 index, count, vma->vm_start, vma->vm_pgoff);
 
-- 
2.53.0

