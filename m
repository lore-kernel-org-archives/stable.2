Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5024E80D6;
	Thu,  3 Sep 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450615; cv=none; b=qglkP4VsF2iVroTjQbbxxFcBQ2ok6WX4Uib0QcJeyBxU89ghJHwJzdPFSjO9pmbrX9ZfwtHCPgPSaPuSWRjnMgqs9T1OHLG0+r7xElpHxdKKivYOYLi9XwwGn0dKgZxw0YMw99XkOciBLispITozYj/GJT52C1wgsJ8orwQTkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450615; c=relaxed/simple;
	bh=wirvMfzcnmt9OrC6uut7rdUyKpHqT+LtpfZGnNovN+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLNScfSls8bZG2niouWH/lWxfaBppd2nmKT2HjFxPVOwklhImstN6eWsEC/FvyFVmKj4ZGNZHINqsykWQ9Ap+ywmLSgJYRestgi2VL5pwf/gBpE5Cn0kBO6j0+SXDHuHFnaxfqAiTuNIm2vl80ScqnNqTdzGYZI4K5usTTg+HOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixu35zh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixu35zh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E674F1F00A3F;
	Thu,  3 Sep 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450612;
	bh=mPNWvkEDUAJw+M0V5DscJNLnjX28HgRup/o43yOuiB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ixu35zh7QD27Tqvzurmn7hUrdPhUWY2Jj5GPigjtjTOoZHCey3Nrj30X5NcP33ffM
	 6LQBnpbqCxGxH/K3do4zpDhcOz0HNl9Ve6VTX6mH/wHuhgc0LVlx2nFke7S5OX0mGi
	 bUFWVixLPLPPLt/euGwch+HPkxuwsaXIPfGXPjhAmdEtUqeY+fyfpU4NHdIVrbKbBw
	 K62EcK20bSg4RwctzOXE034YpwjdG0eoW3ze4+eopgXxKdO3OH1sbDHGeXzA0JLsRg
	 TCOCZV4zawrC7y+UVeGSUjFwC//xyLvOFJxiKYOSaHeLSXF8ZKSvUGJ37yAnjjBJX1
	 /zNR9364P95Ww==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 18:49:58 +0300
Subject: [PATCH 1/5] mm/execmem: free ROX cache chunks only when they span
 an entire vm area
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-rox-cache-pmd-v1-v1-1-11beb2a3d249@kernel.org>
References: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
In-Reply-To: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

When execmem refills the ROX cache, it vmalloc()s multiples of PMD_SIZE
aligned to PMD_SIZE. For every such allocation vmalloc creates a
vm area.

The first part of the vmalloc()ed chunk is returned to the allocation
that triggered the cache refill and the remaining part is added to the
cache and handed out for subsequent allocations with execmem_alloc().

When only the first part is freed, the entire vm area remains in the ROX
cache and can be handed out again.

In the case when the first allocation is larger than PMD_SIZE and the
second allocation from the freed first part of the chunk is exactly
PMD_SIZE, execmem_cache_clean() will free the entire chunk while part of
it is still in use.

For example:

	/*
	 * vmalloc(4M), return p0 to the caller
	 * add [p0 + 3M, p0 + 4M) to the cache
	 */
	p0 = execmem_alloc(3M);

	/* return p0 + 3M from the cache to the caller */
	p1 = execmem_alloc(1M);

	/* put [p0, p0 + 3M) back into the cache */
	execmem_free(p0);

	/* return p0 from the cache to the caller */
	p2 = execmem_alloc(2M);

	/* return p0 + 2M from the cache to the caller */
	p3 = execmem_alloc(1M);

	/* bah! execmem_cache_clean() frees the entire 4M chunk */
	execmem_free(p2);

Make sure that the ranges that execmem_cache_clean() frees cover the
entire vm area.

Fixes: 2e45474ab14f ("execmem: add support for cache of large ROX pages")
Assisted-by: copilot:claude-opus-5
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: stable@vger.kernel.org
---
 mm/execmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index ad07cae9ed585..ba277790e3132 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -143,9 +143,11 @@ static void execmem_cache_clean(struct work_struct *work)
 
 	mutex_lock(mutex);
 	mas_for_each(&mas, area, ULONG_MAX) {
+		struct vm_struct *vm = find_vm_area(area);
 		size_t size = mas_range_len(&mas);
 
-		if (IS_ALIGNED(size, PMD_SIZE) &&
+		if (vm && get_vm_area_size(vm) == size &&
+		    IS_ALIGNED(size, PMD_SIZE) &&
 		    IS_ALIGNED(mas.index, PMD_SIZE)) {
 			mas_store_gfp(&mas, NULL, GFP_KERNEL);
 			vfree(area);

-- 
2.53.0

