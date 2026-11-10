Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317601;
	b=I8HPP2+vDT5OTD8M69et8/0Y7XQJ5slKPVYTI0z4N8/WrHroqs6T18h9y5DsRPvLjdZr
	 t9k1IKKY55HG9/3QNMVkvRTwL0TW8jdUn1IPngTKHhAR05+Mdl5FydlTqdA+3vM/uxu7J
	 nXba5vn0RHK46IB5UzHU4TWmO7KUbQAioLDMWv3HWMSzKTkcSXah2Otd37CELTXQGiQm4
	 uLLCw7hxR2R0YW8eMsw8Lffb555yZiUS+e0tKlchIq9u+Qj3Gfe0HfqyA4gm8MUB+2EQ4
	 MqwAz6MOBv6VcKp3E7Ql7X2hJBwAaAMJj31zIqp/wuOCElLFNuspFQLArukeZpWmg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jbJmJhhs3hDTQplnkrpNPgf1NwZxggA9qptuyW59owU=;
	b=saZVQdNVmbFV93PLpt49cT+2yCI6JUaPG9sic7tDLdD/HYXC3wQDWMvso3Yp4YeAksYn
	 x2isX5ogDKdwsmRt8cinQCCriI52ihcjioc5U56ZqgM2sT64KwTRTU52M9X4zCjr9VWhO
	 ipUNcd6ghCqBeF6fMk3u4EHMZlZyZWCmaUbkWsMiarpGBJrO0tXZDckve9EDnSjrfIrqD
	 pPPmg0dcBlnWuJJcV2novCuU0nDljqzWNC9jOeTPmj3En+ZMOK3vYFGHqQ3dz6euIQDNr
	 RSnrSdHkQ8vKkkep8qnPRbQP/TJ6oTNqTUW0XATXSVY0K5JmKcTmaTBf1fImTBIX8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eP6iqGw3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F22606A75E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eP6iqGw3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28781F008A1;
	Tue, 10 Nov 2026 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317600;
	bh=jbJmJhhs3hDTQplnkrpNPgf1NwZxggA9qptuyW59owU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eP6iqGw3AYQyJ2IXeT8bS2lzImugEfcr/EcwN/MWLH3KmOwIkQl4uVPDttG+eu4if
	 PLPXdzVPMD8iGiO0+X4a7K3MBFYm92ZpoCBxowNyoU8AWuoFCZWInpmtPGgddrfm09
	 D1o+IpGlHMLvnijGjnmOubpEQ4rohXXrNMZ4oaogniC1sNcA6MuQFDlgcJCoikPa5e
	 +Nlxo/nFfu3E6vOHxg6Q5kCLEZjUtCJKYG2ISY9lc6S1Pnl4wF+a5ASKcmuQdyRaQ5
	 19GQIbDDkY3qj2XSM26p4e85Eu5OZQdnmTNZBY4U42F8ORHaEFXIba0P0dXE6eES6t
	 cHYV4Vowydz8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xen/gntdev: prevent private mappings from becoming writable
Date: Tue, 10 Nov 2026 08:33:18 -0500
Message-ID: <20261110133303.1730910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060330-failed-5.15-2176dea8d8c1@kernel.org>
References: <20261107060330-failed-5.15-2176dea8d8c1@kernel.org>
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
[ sashal: Replaced vm_flags_clear() with direct vma->vm_flags bit clearing because the helper is unavailable. ]
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

