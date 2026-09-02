Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD9384CCD;
	Wed,  2 Sep 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372501; cv=none; b=EGN0OFLyMJPbpucslYRCtMGzg5WLwGi7OeQGV8shFcCFja7rczZ+3pRjH1oUYbWgFhm4veDUK0rc1g39Pb9wsJ2cDW3dWrgSs04qUMQB0nKHoQIQyCNWccUykZAp9MtcXD1/aa77bE4D5vr7O7deFQ2Yo8khLjC0DlJUtsGRczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372501; c=relaxed/simple;
	bh=Ugek0cCv5pYCXE3BNFAh4JNoRgqA2ID5EXm/A9YDk/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BVs1zCv6+qHusrXNliSOrKt/zYztZk3xWNkxR77iRSa4tYjNsZYDrQ8CmDADnFsC33fF7SXg1srepjPWqdknO8I2bTlGKy3GeeUKCr6+jghjSry9fDYf7P0bt8Qs/t4Smjf2FPHC3cj1g2e80jJukfAxR0xVQj8lOHI7BJMYZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lug92wra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lug92wra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEB91F000E9;
	Wed,  2 Sep 2026 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372499;
	bh=nvGaPSWtkLzLgWlLesnGbGngcPbb0sSWCIqegrOKGcc=;
	h=From:Date:Subject:To:Cc;
	b=lug92wrauFUoadUDfedDcu8ti+QVzBhMs1SeM82948yNlzKcVoUOmHlQMhEPKHvEj
	 /W/HD79ZXs/TYe9SBkeJNNIiX+X3Z2+JXyoXC8ospedxxuOlWvflr4xmDWLy5Cs1wf
	 tjL/YC4Ys8t0GVdDqSRUy8YH1+mHNEquEWt18JUl/9JvfggIzcl8VyrB7yUz5Mf5TF
	 msUeWm4fRYV9x57Xy5DV1Goqk5LR8W/wbtxkiEMqcMdtbkGTnjuUcztfegHLQQmqPD
	 hOAztvdjXHeYmNoShziHCruKSzn1/n5yNVsopKaBEsXbku51EPrOI2QNI9mo5VtXPo
	 d0m65nsg/wZpw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 02 Sep 2026 19:08:08 +0100
Subject: [PATCH] mm/vma: correctly unaccount on mmap_prepare() failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fix-unaccount-mmap_prepare-v1-1-ea070189fdfb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMAwAvyI5G6h1ddGviEhoo5uDtbQqgvh3w
 x5nGOaGzEk4Q1/ckPiULFtQqMoC3I/CwiheGayxremMxVkuPAI5tx1hx3WlOMXEkRKj8URd7Zt
 2/n5AB+q1/s+H8Xles7TijGwAAAA=
X-Change-ID: 20260902-fix-unaccount-mmap_prepare-0daa93d56f74
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ugek0cCv5pYCXE3BNFAh4JNoRgqA2ID5EXm/A9YDk/0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpAke0GAKFlzns+z+tE1Lp+81e5eTFXVL1Wa91WzFC
 8dOayct6ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEQhcz/LNIKn1ZYM4w/XjT
 18nVnZwqEkv5JWWnyN0NnX4l3ed53FaGv7IJ2psOTxdZJS5t1ld8wWZ/36aX8iaiuvZXnj7d6mH
 pxAIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

__mmap_setup() accounts memory for relevant mappings via:

security_vm_enough_memory_mm()
  -> __vm_enough_memory()
    -> vm_acct_memory()

If __mmap_setup() fails, this indicates that this accounting did not take
place, and thus it's appropriate for __mmap_region() to jump to
abort_munmap.

However if call_mmap_prepare() fails, it also jumps there and any accounted
memory is not correctly unaccounted.

Fix this by handling each error separately.

Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 35e7a64855fa..f29abb30956b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2859,10 +2859,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
 	error = __mmap_setup(&map, &desc, uf);
-	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map, &desc);
 	if (error)
 		goto abort_munmap;
+	if (have_mmap_prepare)
+		error = call_mmap_prepare(&map, &desc);
+	if (error)
+		goto unacct_error;
 
 	if (map.check_ksm_early)
 		update_ksm_flags(&map);

---
base-commit: e3b5239afe1b8f0194db7436b17c33e94c1988c4
change-id: 20260902-fix-unaccount-mmap_prepare-0daa93d56f74

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

