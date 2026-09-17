Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9B3033D8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613428; cv=none; b=JXWF+ZrNzgME9Ua+g0cb48Ye40jVZLfOlCUwAMcjI3eVT6CefH/mKf1O7mTbTF9+rVFoFzlgXHgBhqoMzGYUP5NnjF6RGvgM2ycWdp+p3vmitJYm2RzKtPJwb/PXgGh+XJDe4/V4FPaP8v3UKcl/yHXsjiGJxyRuYLWp29npYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613428; c=relaxed/simple;
	bh=oO96/ULOIt+EcYu2vrTFW3QxP0gTV3JuVpxEyRIalNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjkSeKbHGmM4j4fFikVHl7JR7xZ4DvuDBXBt5rub03RqQt5HKlTkHgVTrllb+mJJ3BieiYaWKHrx/SLVDRCabZ+o1eNntmwP5+YX9Kpfyun1BlE1tFTLvzG+jwgCcvGFG3A+h9St2TWfgNaisSDE1tHI20sQZ20AOoeEMzPStag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMxFvoYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMxFvoYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732B21F00893;
	Thu, 17 Sep 2026 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613414;
	bh=ZPJCILfokgAI+duzthxbq2cMhC3Bfd00WKY0DWIr+EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMxFvoYTnhkzfCCB4fsikj2ypLmiIxzf9x7sD7FG7fNRvi49ZaCQvRlGngRqG5kRO
	 R5SsfPzwg32MUyIwN6YqJ7djh44KWouoq6LVle6TrWP2QSYMrX9AEKXuAk8At6S4mZ
	 E8+l4H624p8rUX6BCbEdoFcJ9/y8neSU4VEii67t/shgt8dqxGz33rYsUItxKPxM3Y
	 ar+qJAwj2p78RpXf3ZGLAFcwOn7tRf7ppdHBTm7LXB5etCdY8Syx1f8sK0J6Yko9U6
	 dJc3GogkCsTHeXvbQsC2+Adv7/TeFueq5ep4uCIcOfoc6FYmlhmgF77luZTQTFGIul
	 LRffpOCAYcJbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] netmem: add a couple of page helper wrappers
Date: Wed, 16 Sep 2026 22:50:08 -0400
Message-ID: <20260917025012.3917055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091638-excretory-liquid-7149@gregkh>
References: <2026091638-excretory-liquid-7149@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

[ Upstream commit 9bd9f72a74344b54cfb6fcabf1173e6c6e5c6952 ]

Add the following netmem counterparts:

* virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
* netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
			    netmems, false otherwise;

and the following "unsafe" versions:

* __netmem_to_page()
* __netmem_get_pp()
* __netmem_address()

They do the same as their non-underscored buddies, but assume the netmem
is always page-backed. When working with header &page_pools, you don't
need to check whether netmem belongs to the host memory and you can
never get NULL instead of &page. Checks for the LSB, clearing the LSB,
branches take cycles and increase object code size, sometimes
significantly. When you're sure your PP is always host, you can avoid
this by using the underscored counterparts.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://patch.msgid.link/20241203173733.3181246-8-aleksander.lobakin@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b814dfbfeb0a ("bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netmem.h | 78 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d3..1b58faa4f20f9 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -72,6 +72,22 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
 	return (__force unsigned long)netmem & NET_IOV;
 }
 
+/**
+ * __netmem_to_page - unsafely get pointer to the &page backing @netmem
+ * @netmem: netmem reference to convert
+ *
+ * Unsafe version of netmem_to_page(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (no check for the LSB, no WARN). When @netmem points to IOV,
+ * provokes undefined behaviour.
+ *
+ * Return: pointer to the &page (garbage if @netmem is not page-backed).
+ */
+static inline struct page *__netmem_to_page(netmem_ref netmem)
+{
+	return (__force struct page *)netmem;
+}
+
 /* This conversion fails (returns NULL) if the netmem_ref is not struct page
  * backed.
  */
@@ -80,7 +96,7 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
 		return NULL;
 
-	return (__force struct page *)netmem;
+	return __netmem_to_page(netmem);
 }
 
 static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
@@ -103,6 +119,17 @@ static inline netmem_ref page_to_netmem(struct page *page)
 	return (__force netmem_ref)page;
 }
 
+/**
+ * virt_to_netmem - convert virtual memory pointer to a netmem reference
+ * @data: host memory pointer to convert
+ *
+ * Return: netmem reference to the &page backing this virtual address.
+ */
+static inline netmem_ref virt_to_netmem(const void *data)
+{
+	return page_to_netmem(virt_to_page(data));
+}
+
 static inline int netmem_ref_count(netmem_ref netmem)
 {
 	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
@@ -127,6 +154,22 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+/**
+ * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
+ * @netmem: netmem reference to get the pointer from
+ *
+ * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (avoids clearing the LSB). When @netmem points to IOV,
+ * provokes invalid memory access.
+ *
+ * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
+ */
+static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
+{
+	return __netmem_to_page(netmem)->pp;
+}
+
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
@@ -158,12 +201,43 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+/**
+ * __netmem_address - unsafely get pointer to the memory backing @netmem
+ * @netmem: netmem reference to get the pointer for
+ *
+ * Unsafe version of netmem_address(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (no check for the LSB). When @netmem points to IOV, provokes
+ * undefined behaviour.
+ *
+ * Return: pointer to the memory (garbage if @netmem is not page-backed).
+ */
+static inline void *__netmem_address(netmem_ref netmem)
+{
+	return page_address(__netmem_to_page(netmem));
+}
+
 static inline void *netmem_address(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
 		return NULL;
 
-	return page_address(netmem_to_page(netmem));
+	return __netmem_address(netmem);
+}
+
+/**
+ * netmem_is_pfmemalloc - check if @netmem was allocated under memory pressure
+ * @netmem: netmem reference to check
+ *
+ * Return: true if @netmem is page-backed and the page was allocated under
+ * memory pressure, false otherwise.
+ */
+static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return false;
+
+	return page_is_pfmemalloc(netmem_to_page(netmem));
 }
 
 static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
-- 
2.53.0

