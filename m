Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030342DFEB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557901; cv=none; b=lOLSpgjs0pRfxCNGBxDEYFuOro0+RsG1+meJy0IjNXNbHPssdeP2G/7M1y3RdzEJEBF7UfW8zScwh7Cbc5ODDX9V1ZyF4lC54N8QJ8a1gI0egcZJNrfzi6NI1k6e1MFAhHOX+miFeycBjGX7NbCFWY3qtdQ4vogUQTSlouMBV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557901; c=relaxed/simple;
	bh=q0zfFfHdoK6eOtAJuf36IfsmkTl9jlmvNrQoaOgdzKQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WvG5oBcGPwg+Gpl0dLuBIkh2S2Hnac2/Dr+0TMXTIE7OtulvUFy2tvwGSpK+yB4rzfQ8myqAE7m4tAKUWaF6uzyyxgduQbGPqdoQk6vPU1bTwWa81mPlJ5E7vtEPMnkAZbvmgVsDRoJeuqx5nKr3Rb5X8LO8+G/jrTuqTkf+YsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rhM01wdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rhM01wdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFE21F000E9;
	Mon, 20 Jul 2026 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557900;
	bh=Ft/iRC79dm2wxeY6Gen/niWIBlgyNm1nIdMsXbPYlec=;
	h=Subject:To:Cc:From:Date;
	b=rhM01wdE8c7/sSJ4DqzRiNHUn/9/yl2pZm9zzpW+0PEX2nuuXfiayaHAl5um39Zcs
	 PIcZp576jzMIpbbYlzr+JOeT8p6+/N/zxFeWSiqpXqhNh+4fIrS8M+Ayvy8vR6UKFK
	 0ebHu2sNjKvvryBf4eqM1oIDT+rUfaPouP4LjPOA=
Subject: FAILED: patch "[PATCH] kho: make sure scratch size is always aligned by" failed to apply to 6.18-stable tree
To: pratyush@kernel.org,pasha.tatashin@soleen.com,rppt@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:31:31 +0200
Message-ID: <2026072031-lapping-tubby-5b19@gregkh>
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
git cherry-pick -x 0e39380a7316122e1b00012b3f3cd3e318b3e7d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072031-lapping-tubby-5b19@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e39380a7316122e1b00012b3f3cd3e318b3e7d3 Mon Sep 17 00:00:00 2001
From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Date: Tue, 19 May 2026 18:05:49 +0200
Subject: [PATCH] kho: make sure scratch size is always aligned by
 CMA_MIN_ALIGNMENT_BYTES

When using scratch_scale, the scratch sizes are rounded up to
CMA_MIN_ALIGNMENT_BYTES since they will be released as MIGRATE_CMA. This
is not done when using fixed scratch sizes via command line. This can
result in user specifying a size which is not aligned, and thus kernel
releasing a pageblock that is only partially scratch.

Do the rounding up for both cases in scratch_size_update().

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Link: https://patch.msgid.link/20260519160554.2713361-1-pratyush@kernel.org
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index eb8abd04e7ff..4834a809985a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -618,20 +618,30 @@ early_param("kho_scratch", kho_parse_scratch_size);
 
 static void __init scratch_size_update(void)
 {
-	phys_addr_t size;
+	/*
+	 * If fixed sizes are not provided via command line, calculate them
+	 * now.
+	 */
+	if (scratch_scale) {
+		phys_addr_t size;
 
-	if (!scratch_scale)
-		return;
+		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100;
+		scratch_size_lowmem = size;
 
-	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100;
-	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100 - scratch_size_lowmem;
+		scratch_size_global = size;
+	}
 
-	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100 - scratch_size_lowmem;
-	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+	/*
+	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
+	 * size.
+	 */
+	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
+	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
 }
 
 static phys_addr_t __init scratch_size_node(int nid)

