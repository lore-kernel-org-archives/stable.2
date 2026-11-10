Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316804;
	b=wq2YBwgIipyWqDUopfAlDSyOreokjBU04qsP3XVLJs02eIn2sH7tzCWc1gyMcrJcye2U
	 AxWOuhDRSvg5wN1ZLHRb9VdcEg11ieRzZuJI2XZmEl+rQynXnQFwSj2Xyu2XhCJYcbyhc
	 3U/FuV8qlBsv+5/XCKyv6n2OzJSHovZFJ48wColSgb6G9G9yYAgX3W34PRTCY3hSkp1Xj
	 8mmPcKAj9UEa1O73pbs3ArbRJMjBF6tQfdEAS0Nml3KTNLPYEyRC8jcThuyQdJHiMs7VK
	 wRZYwgMcusLpTkj6fzi1qc5hUI5wL6HEYX5AlKfAvu+/rvLJ3j2kXD1F2hXcIa4Hg2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XW3HaFW+KxQ4EUs/FZKhZS7Vrsdu1B7wqYSzyyqVaPU=;
	b=Tj68M0UZVhediug4ahG1lbMF8rU1AEZtN2DdFfXu5QPaaTG5pYNw0Q86nH7qzCyaj5YT
	 fRjOfA3ZYb/QKTHVIsXm8YtMY1fhd4Za9bkQx/5uTrl5u/MfuuEAw+B8Ouq/JH9uSiEGf
	 CiPVHIy+ahrQVHZpKZjnwyOxITXiIE6aHoZ26IMl9cVrA2pnemaOTZwhZfsgg3HAIB6QG
	 VUGNqnWGyd3H5G0cQBL7takRy80n+nvc99HYwPl3xocsH1DGcTUP4FvVdKQr22dgrOc8G
	 H9IpMf//4SBvtj7HitNjBk2VnrlYWMjrj3OyFNC3Qkgl6sEH+85fKZ8AZJ28VmUSIWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2XNHv6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D893606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2XNHv6x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FDA1F0089F;
	Tue, 10 Nov 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316803;
	bh=XW3HaFW+KxQ4EUs/FZKhZS7Vrsdu1B7wqYSzyyqVaPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2XNHv6xdeyvM3la0dke3kvk6ArAV55ktarxvPzBx9x9tz5XpSaP5sFUNPbH27IAv
	 dfMQa7cCAr+tqYKIqKEzpHYpVVnnack2bx3uf2IEILFXcs83EGh/2d6s09+MRgDvTC
	 bA1Kihyp9F0bvvYeiSUYOESu+Z8rv33eziiRpbGD4uEO7TXQslSgRsYi2ZTVqU5mTt
	 k4RqdAzNM9qJjNHTxVYO6zhKRRpcIImXNXr1fGyZOxSODaZ4WbYrtrTLKrBkTLPfn0
	 k2El5l74iGHT5xWzhlTuT3AwSD0M/OU238WkzKyw82Ng9tn3ows368QPcSRXsSifvU
	 aszFtQ/qoVgCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xen/gntdev: prevent private mappings from becoming writable
Date: Tue, 10 Nov 2026 08:20:01 -0500
Message-ID: <20261110131945.1665445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054602-failed-6.1-2176dea8d8c1@kernel.org>
References: <20261107054602-failed-6.1-2176dea8d8c1@kernel.org>
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
[ sashal: Replaced unavailable vm_flags_clear() with direct bitwise clearing of VM_MAYWRITE in vma->vm_flags. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 6c6e264c6f11d..6b538c3c7bab7 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1074,6 +1074,13 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
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

