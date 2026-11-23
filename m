Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454522;
	b=jokv//j0Ty9E5APbCeubYA8GTyztiUCTQ0uFQr1wYsBqFZmF5n7VsnbJxkp/Ssn+HAqY
	 fflEL91tksRs0GN9gMacS+OJd+c6hQauVFQ7r2XWOi/UcXMLP/1TL5UeUgvjfZc1Vrr+U
	 fCKvdUfIf+dkIqNakToN63YWoTO3XjbEqdNMNr+QZuQLAhB4B1RqittdcPdRLY8mJczRJ
	 aVYtf3EHT2tKs3UVQCNn7eHrGq2yXSKtsHc6AShWOfyWxeGCqX6DCgBxihelmXri0oa+1
	 3C7TExlCnQExLGm6mxrOdnTvSBY5YsRamL17dUskJlHh/Ys+eD03JlbWdwYty2VGRkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454522;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CpzgX7fQBROhXokd+OyG36JBaqz9+pDsBVTA28ytu9c=;
	b=GJIGXJ6A5REHE+SfalyFQhKVSvI4psKhjG6Epd7+zureGUMind7+5/rOL1ZV9j5TdHwd
	 +3538XwI1odIWU8qDyl5+oAF0W5rvMXmLUEBN0GxicA4njEnX4rADw8I8ZB5KhcPlC6v7
	 ngX/e/lT6zlDjcy3VOQ3uGaLTwLprKZoLVh8rjTjAOYYWtQu9O8R0engq+WpjJMDJpg6S
	 lPuXEJ72XUXODXjr0bfud2B0U2hwKotZwL79Y1GzCKu48Tup8PXwuh/HJAtgvcGQYA/Pt
	 mofSX8sg3xo3cYKefkRs2PISrVjVCEox4oLIrnEM1JxfE4uAHchnSn51X4ilXw89jmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UodLaDXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635F606A31E;
	Mon, 23 Nov 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UodLaDXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409241F000D1;
	Mon, 23 Nov 2026 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454522;
	bh=CpzgX7fQBROhXokd+OyG36JBaqz9+pDsBVTA28ytu9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UodLaDXlYWspKMkWHQcypTvkwPt3DVyWB/FV2bC4N0yXUKoy8gsmim7yV4WkYcyGE
	 6Emow6r/bojNreSH8LrcHqKLeqDQj6kkgCT57RtlTQmxDxVen2C6CFTKVMMfeO1RQ8
	 IDOcgq3rdchA7shs24phStiiuHw9pyFL1n5SOQ1n0diuKd0tP9u+BIrViEFgOw40/r
	 C7aw5xYwvyjg2SwJgTCehF0IZQ7VuCJzeffXq/2iDJKjeG9AJZvOTuc/n/NepSB73h
	 GLOXTJ2mvC+deFEqPTvlblw00/QaPNYQsboKPxaYeJbM1AkOfcFyV4UXrIJFR3NFJP
	 PgIjP74J0E0Zw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Suman Anna <s-anna@ti.com>,
	Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] remoteproc: k3: Fix integer overflow in k3_rproc_da_to_va()
Date: Mon, 23 Nov 2026 17:20:46 +0000
Message-ID: <20261123172140.3547896-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

k3_rproc_da_to_va() validates memory regions using (da + len) <=
(base + size) and stores da - base in a 32-bit unsigned offset variable.
Because da is u64 and len is size_t, a malformed firmware segment or
resource entry with a large da value causes da + len to wrap around 64
bits and pass the upper bound check.  Subsequent assignment to the u32
offset variable truncates the 64-bit difference, returning an
out-of-bounds kernel virtual address to callers such as the ELF segment
loader.

Widen offset to u64 and rewrite the range checks across all three memory
loops using overflow-safe subtraction.

Fixes: 9179f8bfa98d ("remoteproc: k3: Refactor .da_to_va rproc ops into common driver")
Closes: https://sashiko.dev/#/bug/linux-36b3e1ce-919c-4ea8-b7de-b8a5a191c8b4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/ti_k3_common.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
index f79ccb57a372..1d06f46b75c6 100644
--- a/drivers/remoteproc/ti_k3_common.c
+++ b/drivers/remoteproc/ti_k3_common.c
@@ -356,7 +356,8 @@ void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 	struct k3_rproc *kproc = rproc->priv;
 	void __iomem *va = NULL;
 	phys_addr_t bus_addr;
-	u32 dev_addr, offset;
+	u32 dev_addr;
+	u64 offset;
 	size_t size;
 	int i;
 
@@ -369,17 +370,21 @@ void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 		size = kproc->mem[i].size;
 
 		/* handle rproc-view addresses */
-		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+		if (da >= dev_addr) {
 			offset = da - dev_addr;
-			va = kproc->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			if (offset <= size && len <= size - offset) {
+				va = kproc->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
 		}
 
 		/* handle SoC-view addresses */
-		if (da >= bus_addr && (da + len) <= (bus_addr + size)) {
+		if (da >= bus_addr) {
 			offset = da - bus_addr;
-			va = kproc->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			if (offset <= size && len <= size - offset) {
+				va = kproc->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
 		}
 	}
 
@@ -388,10 +393,12 @@ void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 		dev_addr = kproc->rmem[i].dev_addr;
 		size = kproc->rmem[i].size;
 
-		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+		if (da >= dev_addr) {
 			offset = da - dev_addr;
-			va = kproc->rmem[i].cpu_addr + offset;
-			return (__force void *)va;
+			if (offset <= size && len <= size - offset) {
+				va = kproc->rmem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
 		}
 	}
 
-- 
2.56.1.750.gf70dc682cf-goog

