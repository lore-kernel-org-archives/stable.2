Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733044B5CC0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445455; cv=none; b=hoLpAH7lpsmWPdEPY2UkzCW6nMk6LUE2fgoV0ldNRWg7767uyatWKAdynaT5duVZccg5oG9VC5QFHZRM4xQGdYZwCOuS4hzKJTMJyvW8ooZHziTlih4zOrcUro8dtfCFIZzpSevkhhz4+ahtT9+4vax0w7KLHpzl749+ZQbKcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445455; c=relaxed/simple;
	bh=9kW8gvCaHnHeQYdbgIbhe5LeiA6I9sN+gnOSsXrhTew=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ONzOmvOYtGG27dMI88wM3v1z/ZwwzxJ0SUPgfgG/Am9veihwJWUBXGjfiUnz6KSXs5S1pHoQ5KvdjKb6Wfl+VI/WZ1yT4QM0YLPQozz9pCv5kCTpR50g706Is2nhrpq04fS/vVpUTLQGbAts03K7h5mHt/UAVukuYjF6zqud4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tIjSxQj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tIjSxQj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3DB1F00A3A;
	Thu,  3 Sep 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445447;
	bh=Dyvyn9GqBGjPpYMjnYrso2G4t3NnEmK1ShWtjTKfTa8=;
	h=Subject:To:Cc:From:Date;
	b=tIjSxQj7EiBTM/oHsFV/6/KLGlb6PIb0yBZAtuYLjsO0Az6I+Ne9Np3OpERwmM8YD
	 MXKDeBetpbCzR77ebIDwPt02o5NU2yNYArJPnnt58HVwz9s0DVEPtriY84RyI7cOtP
	 HZ9rPJazWSva086HboPH3JVPRXOtFMS9PlZGL+Jg=
Subject: FAILED: patch "[PATCH] kho: fix size calculation in kho_preserved_memory_reserve()" failed to apply to 6.18-stable tree
To: pratyush@kernel.org,rppt@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:07 +0200
Message-ID: <2026090307-agreement-travesty-c6c9@gregkh>
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
git cherry-pick -x 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090307-agreement-travesty-c6c9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded Mon Sep 17 00:00:00 2001
From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Date: Mon, 27 Jul 2026 17:02:39 +0200
Subject: [PATCH] kho: fix size calculation in kho_preserved_memory_reserve()

kho_preserved_memory_reserve() calculates the size of a preservation by
doing 1 << (order + PAGE_SHIFT). Since the '1' is a 32-bit integer, it
can only be shifted by 31. That is, it will only work for preservations
up to 2 GiB. Larger preservations will trigger undefined behaviour.

While preservations larger than 2 GiB can't be obtained via folios
currently, they can be obtained via kho_preserve_pages().

For example, memblock reserve_mem uses kho_preserve_pages().
Reservations larger than 2 GiB are valid and will trigger this bug if
properly aligned.

Fix it by using 1UL for shifting.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Link: https://patch.msgid.link/20260727150240.889555-1-pratyush@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..6fad9152387a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	struct page *page;
 	u64 sz;
 
-	sz = 1 << (order + PAGE_SHIFT);
+	sz = 1UL << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */

