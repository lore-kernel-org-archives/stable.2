Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048364;
	b=snSW+SOcuhu9wACvKGFQfTffE0a3+V2B9Kngxvhst6pAwa9n0FJrkWT1qXScm6ynTR86
	 x7EhIokkauhTMSaau8ca4FKcbdVp/IUth+IRug0PtSLc5eheI3F1QjK+4RbNZcC+Rse21
	 4jd48/9Ux3sVtt5gCEpu0lW0+6N/C1WR0FFua6tcnY5i4nqPuUALS4OSVNAcMRUeIuHUn
	 /CwXTagoeWoaQYNhANLKTIa6tYuMwKNATKtYtpnIOchRDgatgTvg5eZOKJ5XtLjAeeV4W
	 RHmpR5eYHMt6Gn5DndKvZsC/1scSVPn98GH2RCTJx2W+QdedqhVW+REf7Fgi9oVZoLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gxKkkiTxsgtc22sLvLrZUDhDfKePcyDNnaF+0Vc1NAc=;
	b=KjBoruXiyq7eRFn6pkcdI0YZe14U3YAnk+6HtcHY8n1j883mDUSqcFNriviic+2ttR2O
	 CWDN+U7KcQ3kLQLSkJ3E5jaeIKm0eIyeDAsKB9lhKeuKv2QrSfHMgpn5UVu0DUQN/fC7+
	 acJdIqVrRYDG2xAX0qcxpVyBHzxrrGgyUvQuaKDwXSeyOw5t5ktz57Zm3edc3HQmx7/M3
	 AkZqHVFp0VGeNPkBQbuDXEGdjXRkXfeHhJZlnRx7z2vS0GlRzToakxSU+9bs9rXcuMgsS
	 TqqSgr83DAXXP+CcTUmm7M2Tqeps/2f7fc0mtO+IcPmE9lVl/IsARDW/qk9esg4pMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koAVWdI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71800606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koAVWdI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A51F0089F;
	Sat,  7 Nov 2026 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048364;
	bh=gxKkkiTxsgtc22sLvLrZUDhDfKePcyDNnaF+0Vc1NAc=;
	h=From:To:Cc:Subject:Date;
	b=koAVWdI3vbnURxVx0Pr7X9eERr3Hm8wj85BmxwnisgJBoXncXws/DTCNUo39qw1tO
	 bk61TnmqsAWUo1GXX1znGexAmEFNlOGaTSbdxpo9pA1DFfhqXMjal3XKxsW36fNmeY
	 mAHlROH9yzaZpmjXn5SE9gRo77KZ4MZiVBMmqTRqXGaKRSaMVRJm9VTegyHyA3dG/o
	 f4RkRQqWq2PnDp4lusQMYxc/BA9HveF9qxUqeLsFB/KNrJ9CnwUX3lfvBVULiPfRL6
	 RYaLtfWWQpw+RYJ2Ea8Ubt/WCG5NYvKMro0zn5BJW++i+h3UT4Dx4ZVGcuF8NeNe2y
	 3ZGW5bddJW2dA==
From: Sasha Levin <sashal@kernel.org>
To: suruurism@gmail.com,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: prevent private mappings from becoming writable" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:02 -0500
Message-ID: <20261107054602-failed-6.1-2176dea8d8c1@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2176dea8d8c19cb43a9b3651bfa1cb21eab1b31a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054602-failed-6.1-2176dea8d8c1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




