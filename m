Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197060;
	b=3TM6XjEgU6fhvOTJ7N1Dc8GH4figy97ZlJtww2QD5+YrvBZiSiglmb/nvWQLpAGBZD4S
	 7pm/SJ2b1fsY7HEh74evM+oQalm8GvRJWQL1vt6YHWnYOQ/xjc+TK+03Ja7CPrF2g0hTw
	 +z4mmE8y/epqQmm9V2UXt8k1P75AJi3cI7jsAoq08MpDqZfyxYGkwstrnBiXJecqsKTRV
	 AS5ltqNbixtfpp3wK/vbMY58GmwFZpwBXn5cYOifF+LXVTcUKnAAgWt07OOB0mrAvJuWR
	 2kRx9hCetxNzlHr/+1uuxOIRlmfKFOp6V0WapAtV/ict8/YXt6p7jgcL9xihSKeQUig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197060;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DipSljPk/gQluW89D0glgdMIVdUQm+YSJmTIvt1HTjM=;
	b=JucbW7Ij8kEyd2lnkUE2H10GQ5dSUHL6pMAw24ZHSaMM2HgWN25vS77DSGDh35ReOsQ0
	 5z7RZnigmXEWb059nNfSdc+ni8A1RpCbS8741F3ZKC2aI+d19RQ+jYjWnR8DlfXcvUEFd
	 TrDzhBPuPkDEVuSzDKpe7XZSxv45i1u185aWC04IjOxlnJY+ZvjR1skhT27vTshoBRBXn
	 cIY18t4INUSyXKeKUjACoTOTr+f3dOab9zznap5JrJLo3OF4XLj90iIzfviLQ81T12KZe
	 gBV7nfKEl2Ld5h7eRTSb5bI6l8HwtWERjJNfTGd/8W0ys3F9GUZgcD0xL9lsYiAjGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=OpM+z7Et;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F9606A33F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94F9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=OpM+z7Et
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795197059; x=1826733059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DipSljPk/gQluW89D0glgdMIVdUQm+YSJmTIvt1HTjM=;
  b=OpM+z7EtYJVbtRQlpkO8yysHQgqUYUkrX8nSwTCJ77wccna/+jjJvVT4
   mKJzKh4JfM9XVIO6wuFDSnv7QBG6oxk/Gk/1ppGCeTsBrkK3IDPAoFFWz
   4hggtezyIfXrLbQeoopZdwVBdgXjFXyCqev+QqvghP5u8TElo/jrPRGB0
   LKJXRcbPigoFvX42eUuLX5lkEgNjOxMQyYFXNhSQdVGnk9do/QkQBSYe4
   /EFHJcGBy+ZIxeISpl6Pu/Wnvt7eOb8YcyKhBr++LGurx9UpyU9jMTh8n
   GiIiZJl1DDK2Gap42f+kGGhzs92szgS+Ep5hiq8qC4pOTKycwvvMjjHeL
   w==;
X-CSE-ConnectionGUID: utKHMAkDR7ilWWev9EyxSw==
X-CSE-MsgGUID: Acm2LsZLQN29gS7KlBtfQQ==
X-IronPort-AV: E=Sophos;i="6.27,223,1787011200"; 
   d="scan'208";a="34627976"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:50:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:31812]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.86:2525] with esmtp (Farcaster)
 id c5d25898-83e4-45fb-8bf3-a6a1885d150f; Fri, 20 Nov 2026 17:50:56 +0000 (UTC)
X-Farcaster-Flow-ID: c5d25898-83e4-45fb-8bf3-a6a1885d150f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 20 Nov 2026 17:50:56 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 20 Nov 2026
 17:50:55 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
	<linux-mm@kvack.org>, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Luis Chamberalin <mcgrof@kernel.org>
Subject: [PATCH 6.18.y 1/2] mm/execmem: handle potential allocation errors in the maple tree
Date: Fri, 20 Nov 2026 17:49:18 +0000
Message-ID: <20261120174919.3789837-2-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261120174919.3789837-1-gyokhan@amazon.de>
References: <20261120174919.3789837-1-gyokhan@amazon.de>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

commit d80773cedde2eb66e5702d383b5eff0190e7693d upstream.

execmem_cache_clean() and execmem_cache_alloc_locked() ignore potential
allocation failures in mas_store_gfp().

While in practice they are unlikely to happen, it's better to handle those
errors and ensure the integrity of the ROX cache.

Preallocate the maple tree nodes for the stores that must not fail and
order the maple tree updates so that there won't be any failures once a
tree has been modified.

Link: https://lore.kernel.org/20260903-execmem-rox-cache-pmd-v1-v1-2-11beb2a3d249@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: copilot:claude-opus-5
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
[ 6.18: 6.18.y still restores the direct map with execmem_set_direct_map_valid()
  in execmem_cache_clean() because 4c4b2ed5b783 ("mm/execmem: use
  VM_FLUSH_RESET_PERMS for ROX cache allocations") is absent. Keep that call
  and move it after the new mas_preallocate() check, so a preallocation
  failure leaves the chunk in the cache unchanged. ]
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 mm/execmem.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 9560441e57ab..cce6a2ac66b4 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -172,8 +172,16 @@ static void execmem_cache_clean(struct work_struct *work)
 		    IS_ALIGNED(mas.index, PMD_SIZE)) {
 			struct vm_struct *vm = find_vm_area(area);
 
+			/*
+			 * Preallocate to ensure mas_store does not fail
+			 * If there is no memory for the tree update, bail out,
+			 * next execmem_free() might be more lucky
+			 */
+			if (mas_preallocate(&mas, NULL, GFP_KERNEL))
+				break;
+
 			execmem_set_direct_map_valid(vm, true);
-			mas_store_gfp(&mas, NULL, GFP_KERNEL);
+			mas_store_prealloc(&mas, NULL);
 			vfree(area);
 		}
 	}
@@ -243,30 +251,34 @@ static void *execmem_cache_alloc_locked(struct execmem_range *range, size_t size
 	addr = mas_free.index;
 	last = mas_free.last;
 
+	mas_set_range(&mas_free, addr, addr + size - 1);
+	if (mas_preallocate(&mas_free, NULL, GFP_KERNEL))
+		return NULL;
+
 	/* insert allocated size to busy_areas at range [addr, addr + size) */
 	mas_set_range(&mas_busy, addr, addr + size - 1);
 	err = mas_store_gfp(&mas_busy, (void *)addr, GFP_KERNEL);
 	if (err)
-		return NULL;
+		goto err_destroy_mas_free;
 
-	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas_free, NULL);
 	if (area_size > size) {
-		void *ptr = (void *)(addr + size);
-
 		/*
 		 * re-insert remaining free size to free_areas at range
 		 * [addr + size, last]
+		 * the range matches an existing entry, so this cannot allocate
 		 */
+		ptr = (void *)(addr + size);
 		mas_set_range(&mas_free, addr + size, last);
-		err = mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
-		if (err) {
-			mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
-			return NULL;
-		}
+		mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
 	}
 	ptr = (void *)addr;
 
 	return ptr;
+
+err_destroy_mas_free:
+	mas_destroy(&mas_free);
+	return NULL;
 }
 
 static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
-- 
2.50.1

