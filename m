Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050412;
	b=QqDro0DbyYwMNWmkoc9S5M6WlLcDU0cSgRut39ZbBTyH0EIZBeh1SSYs/NTQCnb3G7hS
	 pO+MgvH6FRgj7z1slo+/YapPaAj89CskhGZ0QJd/vqUoSP/+lYQKky/31gR3+25JkYVeu
	 2heDYyA2q/kEeiyiS1IxViqI4XckQ/BXx94I8qq/wNEYMSELfGl0EuDcb+b3HyQYWMCfU
	 9FSNta/WfLfPTK0nb3Q6OzuCMN69IBGGaEzv39mXoXL5Xcbe6YoMU9Z0Yg0vPOvMu9tFu
	 cJxhTemqR9LxCNP64hQns/GKDsESnJjQx0wzl8+vqf9vpCnL8u00liigRmXi1xe8v2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EmTMpbLIgA9pFspy6tQ15CvHuoRwtKKGIiujLote7FI=;
	b=XAcbS+yHIPVGaZulUlccqBqSFJCFGJFly0y4k8Ra3mb3zBcIpddbm2ZcMVt9TLArIekp
	 poxkszKf0P4WHqW7RzoSFHXzhsZV9NqcNurgA04u6bqJXJAxfR6gmYyPZpXxqYNz76X0p
	 BdfWh/QzwXQBdepiSyqMzT30jg9QvxCMDrFlfM9w6QKRDxRwrSH3QMgPdHWFf0i7zMbKD
	 83LaP9hNpaRsUBKDtY57+MvUY4p7OOvVBWuaSF1ROgiMS+KZ+J9rW/WkUjPzPjs8srIZt
	 PkBkKELxRuZgyJxeTYf6QrrA4GWZ8rubk1pm212XuYOlGXdTsxlaE3DSUqtLrExllUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJrlJlpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53878606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJrlJlpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24FE1F0089F;
	Sat,  7 Nov 2026 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050412;
	bh=EmTMpbLIgA9pFspy6tQ15CvHuoRwtKKGIiujLote7FI=;
	h=From:To:Cc:Subject:Date;
	b=LJrlJlpw/RbFHL2cQg3QJvmV0MXaPCpm8E0054eKd/msPKPM74gYSxrtlUVkHGBf1
	 tkBk5g+WISHHSzFdKe1ExfpfV2lFLBPFRcu4xbEdd3alOYgRzf9N8vu3Hv0Qi0NIEq
	 HMDt0LKYLm8a9g//A/qjw1BD/KhL9DPcqOjW1b27UkM3m4uM3lMDI1+CwirE5ESXm/
	 48qcPhalzQ01w9jSAC3SpzZXxfj+QHTC0bZpVNqn7HzX8ijp1/Ln6B2f8TBDCtLbc3
	 l9U8VBavDgy2Jzid6v3jHonI5sakK1EhfLWsEoLE/2f1NoowaikLLxCmLEJrtzK/Is
	 bOwaF5ZeDUvXA==
From: Sasha Levin <sashal@kernel.org>
To: suruurism@gmail.com,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: prevent private mappings from becoming writable" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:10 -0500
Message-ID: <20261107062010-failed-5.10-2176dea8d8c1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2176dea8d8c19cb43a9b3651bfa1cb21eab1b31a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062010-failed-5.10-2176dea8d8c1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2176dea8d8c19cb43a9b3651bfa1cb21eab1b31a Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Wed, 19 Aug 2026 11:42:17 +0300
Subject: [PATCH] xen/gntdev: prevent private mappings from becoming writable

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
---
 drivers/xen/gntdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 1dcc4675580ed..b71f5bae25b63 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1066,6 +1066,13 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
+	/*
+	 * Private mappings of foreign grant pages must never become
+	 * writable: they would take the COW path on granted pages.
+	 */
+	if (!(vma->vm_flags & VM_SHARED))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	pr_debug("map %d+%d at %lx (pgoff %lx)\n",
 		 index, count, vma->vm_start, vma->vm_pgoff);
 
-- 
2.53.0




