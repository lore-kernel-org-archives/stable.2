Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196919;
	b=rEfhpX0VnjXrrsH3uC3WdGKTVR+n8Lvg9prmHh9qIJN6vxkeGzO8aL6O4gdtyr4G9AHZ
	 mMXONPHgWoA4k7QnGo4m3MQ7W8tnzwC0WjehmawV4Z11Cu8KZqrwcGS/qlEW70aLRMOHN
	 axMffQtQPshMMmJsHclcmk/y0/sEFfFKyRxls02zGbJ5mLXbasYtVlHq+fNjjU3d35N1Y
	 gxFLNdYlhVQ/qSDSpDnjt3Jy1yOxRlWqwHVBLB9OC77xrhvU9z/+WFsuWAPajAq2dNVLx
	 X0Yoc2svfi977hVMfQIeV/FaHgmtWNNxNzC67G4QwwaBZ8Kq/DIihEhy8iAsGwkcpvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=wsbggd7FVuUIcji1gpPFNhxZ64Ua/0KjzwIsAaYXXTg=;
	b=TQ5K/xVE/RFXsz1FfnikK+W46by5wYxNWATrS60dWk328kf2YjvV6dWI+p/p9XlAvImj
	 MpmL/bqbCgQcjfE2ZwMqvPPn/xMXDXdsXeWuwpvk2ROJ9m2U8Z9rRhkLIVlgRmlynot7v
	 PNjHst9EM9lb1B0v0D2hHOEUQvUaClLs+GwmoMR9RuAiLGK9nukJQORSkR8GbNVbR75pZ
	 4Bz00Po8pgYEf8VzYStI3RelpKcbYQmn75TLotpuu48gYV/eDhAira8bLQoIJr/9S1lvG
	 onNXgNsJKL2rdH4V5/+YkMRuloup9Ca7A6nMyhc8wRJQ/XSdl+aMY8QsWc2a/BoyHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=jdHLAlRZ;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DF60A2613
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27DF60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=jdHLAlRZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795196915; x=1826732915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsbggd7FVuUIcji1gpPFNhxZ64Ua/0KjzwIsAaYXXTg=;
  b=jdHLAlRZGSAMc+uQgeRIAQ2n9258iygBlkt9CWxKVk0NGKYE1bDf6Zw6
   VqAWVz34VzYLV8ygU4sr4IKsUU0IEDlp4ImrwxmUTlJN/qzOPHaCLq4BB
   SCyy0By+/8KvB9cNJ0ZRmcqm1lNBq2OBUlBflhelxnsuScCIw9VeEOXFn
   4+qeCcNlcCW5flhUhwzJ9JeQo12iQHanvgyE4cG4Jpug9dgNzgj9mtHmT
   tjkceDiEXJuTM8jF1WODJuuuXOTooyYRiesWWVJ4eXFzTjzlaK9m7dMKE
   VgL4J2dti6qlDlBJDFxjN40YWnMuD1kdPrdFD9syGocAblot56v19g0Lp
   A==;
X-CSE-ConnectionGUID: g8WOWWiNQ42Qc0P4cGAa/A==
X-CSE-MsgGUID: +0RKad1ERYiq6lA4Dwx1xg==
X-IronPort-AV: E=Sophos;i="6.27,223,1787011200"; 
   d="scan'208";a="34665757"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:48:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:14677]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.48:2525] with esmtp (Farcaster)
 id 9997a763-e53b-4569-9299-9fda4c6f95d3; Fri, 20 Nov 2026 17:48:32 +0000 (UTC)
X-Farcaster-Flow-ID: 9997a763-e53b-4569-9299-9fda4c6f95d3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 20 Nov 2026 17:48:32 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 20 Nov 2026
 17:48:31 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
	<linux-mm@kvack.org>, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Luis Chamberalin <mcgrof@kernel.org>
Subject: [PATCH 7.3.y 1/2] mm/execmem: handle potential allocation errors in the maple tree
Date: Fri, 20 Nov 2026 17:47:44 +0000
Message-ID: <20261120174745.3785179-2-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261120174745.3785179-1-gyokhan@amazon.de>
References: <20261120174745.3785179-1-gyokhan@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
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
[ 7.3: 4c4b2ed5b783 ("mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
  allocations") is not in 7.3.y, so execmem_cache_clean() still calls
  execmem_set_direct_map_valid(). Keep the call and move it after the new
  mas_preallocate() check, so a failed preallocation leaves the chunk
  unchanged. ]
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 mm/execmem.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 33e4e68f655f..3857955e701b 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -173,8 +173,16 @@ static void execmem_cache_clean(struct work_struct *work)
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
@@ -244,30 +252,34 @@ static void *execmem_cache_alloc_locked(struct execmem_range *range, size_t size
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

