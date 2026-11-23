Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451597;
	b=J6he/xzTYrTashb0GkgrRV3JtVISznAJrM7kSW1iwYJB+FR/AvtfYFSmaCbRNawF4vfU
	 H81txPN/Aqbrld7BtiQtJbog6tp0RBrKzfr731d8dlDZwRe11Fh9AKowhW5j5dMC1UqJ8
	 vLXjx64exHUsMdZBH5yUL5ljjIdXTFOcOhpZiMgbavotO+EYlgaNk8n5GqxUXtho/Smn2
	 b/VIZ0fN5edqs/Rz6gsm/zgqBkcCpb5Gp6z3t50F6vRaTiaUkfNzHCGbvxk+/njNNJfoh
	 mfStbI06wEnggL0iilrNBh1Ggj/AHxIoPdzYjN68s5BRMIhWRSrcdre7HH+FfpnCaVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451597;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DhQbaSa0CfJ0wCyRhCBz64gdWankS2u2hv2CXXOomHI=;
	b=M7Y0JqlERfoACtPoQG570KVmHwASVbucoLxvTcXMQPtrdm3YFrsmb9aA+eahH4MFkC3c
	 IckP+ePEXk8o7+HsTIgVmRoe4LFIr2x8yrx/VRtDRsFWbEmIATnI2NLv3kTu7CJM8lIkV
	 /+9n11ko+5FREdZfeAaQEr67KphR7Wtbyyx6ZyO7IY8+IPCNFGOx9VcDrdFWs8qct9pdY
	 fVYkG2OCkYT0Glp3B2IsNy8LPFAnH8+AB3Zu6KJvFvaMwYeYc9tgZ0PX+XzQTrrNxaEUS
	 nFfaQwvjIl41H1Lx50OQrzUKh1WVQ2i3lB14mpBvB4jlA/L5cCTQHz7zahZvb5eeV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gH1aRZct;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED935606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED935606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gH1aRZct
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=st7VKYLVy6A9Ld9OVqz5qlImi+UrV4Mo/my8tn0Ta8c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451594; v=1; x=1796056394;
 b=gH1aRZcthwWczpHGDLSIGLIEZ46YNc5kHsOggWrOPKYqDwNY8zkGF1CF1LTKLhPzHxFFlfj9
 pI/fHM/b+Xvck/0HtodsKm2FudE3TTDqOnJoPb3zIrIJLdcrJup+W/QqWssjpY8CLvWrep4dr9i
 4MkF2vSkSqbaLXqiOmVBA/vE=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8a75eed899b12e5e;
	Mon, 23 Nov 2026 16:33:14 +0000
X-Mizu-Trace-ID: 8a75eed899b12e5e
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] mm: don't PTE-batch a swap-in of a folio with a hardware-poisoned page
Date: Mon, 23 Nov 2026 08:32:08 -0800
Message-ID: <20261123163301.1568240-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
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

do_swap_page() checks PageHWPoison() on the faulting page, but the
large-folio batching path then maps the rest of the folio without
looking at its other pages. A poisoned page that is not the one being
faulted gets mapped anyway, and the fault that would have reported it
never happens.

Skip batching for such an anon folio and let each page take its own
fault, where the existing check catches it. do_set_pmd() already backs
off the same way.

Leave a freshly read folio alone: it is not anon yet and can only be
mapped as a whole, and falling back would free it with the poisoned
page still in it, which the retried fault can then get back from the
page allocator.

Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 282266dd5e5dfa..d7b200e00bce17 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5194,6 +5194,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_t *folio_ptep;
 		pte_t folio_pte;
 
+		/* A poisoned page in the folio must take its own fault. */
+		if (folio_test_anon(folio) &&
+		    folio_contain_hwpoisoned_page(folio))
+			goto check_folio;
+
 		folio_pte_range(folio, vma, address, idx, &folio_start,
 				&folio_end);
 		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
-- 
2.53.1-Meta

