Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966555;
	b=0Kh6cD5q0SiU77V9YsvDIIM/5vIAFq/wM4zfcxgknMqAikytgOBoE0ebx0993rBacnLY
	 gf8wT3foNFhzPqNA4w8oTPtowZl/6NisYXevu397G5keVkhbeQzy2IFDVgHiMhc+FhpS4
	 bvW48JwS6l2mfSPhnk5K21ZzSGkuABt3fM3DRxWJpVGo1NVHfaJBHBSDhRTxOdJRKsKpi
	 c8bLke8/djM1V4b1Nf4MpYt+nCst1xAPFyNwcaQZn9HPMAna4TTO1il2dAn5tBuEX+c+y
	 1VHwpL7butDqGCeVAOYZE8Mupz/CnH/FjSjZPxC7k8eszHO2JP2TpgUCDwR/3CQPAJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966555;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b32C5Yk9u4T7M0pDjYb1nHa0EfPn+C/TBJuye6XXKRU=;
	b=1LM0WKPtsNK77V/F2u9QTyhg9MS0OL7qxjlcoosCq5cdw+4X2jIDsXHwmW/tePIjHH38
	 /YyFq+VXpSaTaK+Bj5d/fj33JkB5pBO85q5dhRE/2HIiMso9p+7In83ygLDfJHZIKsZNk
	 MfrYE6YVToAcsLEKEu6AJnf8OQ+nD+fUMjRnKNWtlpYJzhK4r7y2ye0B1rK3dADdAizBk
	 96I2QpoUNuvVH4ADrPMhLxOH6sAW3nPK3+fhJH4M4nimcUi2BmmxTAya23AqispFE6BSy
	 7P6KRB6nTQP/iczowOEbEt4A1qw5RwXt3Ha0injJmMW6yfBFny7ZBWmPpFj5xRbUcHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XIW4+VP5;
	arc=none smtp.remote-ip=95.215.58.241
Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CA606A33A
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505CA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XIW4+VP5
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q3JqZ19Rhc6bQOGntufhM8h8GdVro+mBU1Hah1TvlB4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793966552; v=1; x=1794571352;
 b=XIW4+VP5VgX2Y4/JM5ow8B05ruRJMttgx7KgFpzCoF+yEJUG3wxEpRAolZbw9cbTcV8l0Bl9
 HKRH/tDQeSiOA2Y1WDTB4jCHrl0E6Dr8OWisb/GWEcgYhfuCJunYczH/ScytjjxCPg9OeHzLgf9
 8ARBFuoz/+nHasXcZA/WQs3k=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5ec145303592f44;
	Fri, 06 Nov 2026 12:02:32 +0000
X-Mizu-Trace-ID: a5ec145303592f44
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: maz@kernel.org,
	tglx@kernel.org
Cc: radu@rendec.net,
	lpieralisi@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	tabba@google.com,
	stable@vger.kernel.org
Subject: [PATCH 1/3] irqchip/gic-v3-its: Zero ITS pages before sharing them with the host
Date: Fri,  6 Nov 2026 12:02:19 +0000
Message-ID: <20261106120221.347309-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106120221.347309-1-fuad.tabba@linux.dev>
References: <20261106120221.347309-1-fuad.tabba@linux.dev>
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

In a pKVM protected guest, the ITS driver shares every page it
allocates for the GIC with the host, through set_memory_decrypted() in
its_alloc_pages_node(). its_allocate_prop_table() is the only caller
that doesn't pass __GFP_ZERO. It fills the table after the call
returns, so until then the host can read the page's previous contents,
at least 64KiB of guest memory.

Zero every page in its_alloc_pages_node() before it is shared. Every
caller except the property table already passes __GFP_ZERO.

Fixes: b08e2f42e86b5 ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 282e4bafb084f..de1f1b1f26623 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -218,7 +218,8 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
+	/* Zeroed, as set_memory_decrypted() may share the page with the host */
+	page = alloc_pages_node(node, gfp | gfp_flags_quirk | __GFP_ZERO, order);
 
 	if (!page)
 		return NULL;
-- 
2.47.3

