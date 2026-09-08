Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFF52ED4A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872286; cv=none; b=pD2NrMOkSF1w/j3x8OYbgZ/dSlDS8GQP18mJwNwG8oFyOG5JuObOB0T3yUvHBv3xuPZlul+Z6s5nKy5v58OsSLsiZVd27TrT044BOkA6VMr7d7IUatMBCBX5ANuMWERwzrdA1lkPUHgbmk5AFsaAA54YpPXJO86Qrwio4bpmMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872286; c=relaxed/simple;
	bh=xqWiG85/iAyePqvb8FlfR0dcpwMYWtpTR/YhxKo8nro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cr+50YrEscI7uZ/+C2x4z078/FtAuxosqUMYyhAEXwd3i+A3NIL3ksNE3MgHoWS08194px8iNx9hPeHd6lyqHQ0uKRaxpdsPJiBMUUMLKaAvjDraHREuejkn58SdkSuuDgxmssCHjTJUPpLObxV/tk898xzW/mXReSGl+hZfC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3SszAP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3SszAP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170091F00A3A;
	Tue,  8 Sep 2026 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872284;
	bh=+nszfxaZOd2TIn+QfznAvUtkpJlGhhnXElqL30zB41s=;
	h=Subject:To:Cc:From:Date;
	b=m3SszAP5qozsh6CGwGlYZYJJjKzhnspQg5iaBs2IG1rIiXcV+kpk/lcHNyVEdPSL6
	 veU2TedVtZnIJDjJGQlyFy8Iecl4gFa9w3w3KqMmmRhPfde6Dqm1aXZfhUKQNJP/cW
	 jTJL0ZPrOa3JKmjWCGbYCGVM5tWCaV3kt3piawDg=
Subject: FAILED: patch "[PATCH] mm/damon/paddr: drop last same folio access check reuse" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:52 +0200
Message-ID: <2026090852-ought-makeover-4182@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f23f0aa62b2f32c2b12f95959fc4603ef81678b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090852-ought-makeover-4182@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f23f0aa62b2f32c2b12f95959fc4603ef81678b2 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 14 Jul 2026 20:09:59 -0700
Subject: [PATCH] mm/damon/paddr: drop last same folio access check reuse
 optimization

It can race when multiple kdamonds are being used.  The problem from the
race is doubtful, but the gain from the optimization is also doubtful.
Simply drop the optimization in favor of code simplicity.

The user impact is doubtfully trivial.  After all, this kind of
interference can happen only by intentional user setup.  Even if it
happens, it will be rare, and the consequence is degradation of the
best-effort monitoring results.  No critical consequences like kernel
panic or memory corruption happen.

The race was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
Fixes: a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b85f88a7a38f..e4f98d67461f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -65,7 +65,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -74,7 +74,6 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 		return false;
 
 	accessed = damon_folio_young(folio);
-	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
 }
@@ -82,23 +81,12 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 static void __damon_pa_check_access(struct damon_region *r,
 		unsigned long addr_unit)
 {
-	static phys_addr_t last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
+	bool accessed;
 	phys_addr_t sampling_addr = damon_pa_phys_addr(
 			r->sampling_addr, addr_unit);
 
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
-		damon_update_region_access_rate(r, last_accessed);
-		return;
-	}
-
-	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed);
-
-	last_addr = sampling_addr;
+	accessed = damon_pa_young(sampling_addr);
+	damon_update_region_access_rate(r, accessed);
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)

