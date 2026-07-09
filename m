Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7049276049;
	Thu,  9 Jul 2026 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571636; cv=none; b=aqn7ljjUparEYbi/WPn6JqPXS8VDZl9iQTpIQDQthWNOilCQBgjQMkNce5FUEo9iijz5IETNJK3dPKBUXzRQb+8feC3gPYwMP8aojaPilsm5Vqsbv3ATJkNMJ0stNkz3uDIc21DTrcBRRQXPs4bqryLq327+RIcSHIz3SNZguAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571636; c=relaxed/simple;
	bh=eNqPIs12EdriTq4almq2Yg+Aa3TgvUL56esI9T5WPAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWuNO+dzWPsgwNeRl4ntXQ71WPpkMyAnoloKAmD1zXDIoUuN/JAPpMRcqE9skZcTFlmqMh9DQTrkxjZg7aebCQF+ZFkvMCm6CqQh/P7JwtYeX9GvldiYKla0mGnN68B6yiedNtCPdXQ1fRM0xsjQxsOoT5sLq5tRz9UpLirCJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8zVwvpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8zVwvpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F521F00A3D;
	Thu,  9 Jul 2026 04:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571635;
	bh=Js3NGQVx1KADZnJZvetknE5nLYp1IGOPnigBp3atZ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f8zVwvptMpk9i+/Dpd7J4bpmuwVNaIB7EwG573FjQCYLYi/johTd67PCKp8/ElV3S
	 ze03u6735P/PvuBKLQv83KIjvJhfMx3BqjIa25LkytYEZ/QC3O64Z6aeHTveLdb/gc
	 vkRfhsBVUpOHwVANZ6jacEaPemss2ryZEMFBlODLPnDlAzDUp6nUAzF6O8ghErbBib
	 EJ9RzoZD1bCItXBZpYGOswfa6BGAc+J0sykYfJurHD3esf/u/p4Y1I4us7cou6MEdB
	 9lCf8VbuTYIm2m+tD2R6hcxmYZpegeJNHFEMACjSCYSwQcjYpXB/IoKoFuCxNSqCpW
	 fsf0sJ5fquFsQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 4/4] slab: recognize @GFP parameter as optional in kernel-doc
Date: Thu,  9 Jul 2026 00:33:01 -0400
Message-ID: <20260709043301.142931-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

commit 7b5f5865fb11e60edd03c5e063e2d228b7062317 upstream.

Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
the kernel-doc to indicate that it is optional. This avoids kernel-doc
warnings:

WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'

Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Link: https://patch.msgid.link/20260617163125.2716279-1-rdunlap@infradead.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/slab.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 976c781a7842..22daf3f34a76 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1006,7 +1006,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
@@ -1018,7 +1018,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * kmalloc_objs - Allocate an array of the given type
  * @VAR_OR_TYPE: Variable or type to allocate an array of.
  * @COUNT: How many elements in the array.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
@@ -1031,7 +1031,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
  * @FAM: The name of the flexible array member of the structure.
  * @COUNT: How many flexible array member elements are desired.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
  * failure. If @FAM has been annotated with __counted_by(), the allocation
-- 
2.55.0

