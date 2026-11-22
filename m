Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795350979;
	b=om3uj2vc0JIaRTNnJ7KO3nwaiNDm3Hvd1vTKb7B7DDfssrIjg4ocPNswSIYPcrTs7je1
	 EfWcaw14xjNjaawVLOJkgCfyng99hYhcwIOQAuyx9Mwaz1rubaiGVBIHXl/CmZ0PTgsDV
	 IG24IH82BE+XXGJVLreuE7+BF70P2F7QkD5JkSvqTvwaEOwC3bZx8rg5jToZw1IQSAdfW
	 T7sDJqCW5SKa/xcM/oES+apCumBIwcXJs8F4te3Y4HCH22YfYrSe3hRDnZZcBVwX12g7O
	 G3z7PTUm6sN3flNx6PGrmohj5nT7EXRXiT4udHWNripgCf9l30rkPjHwhZS6ipvE/gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350979;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	b=AxDS5cwZrRe8ZNcnTX9vJucjiD1OMnPoYm/SdxpeJSHPuG161OclDECbbXo/mPCKDaqf
	 7Mv3BLRI1vEK/78Q5nTgUr1hVVRJrH4wBx5UsFs4m5OaIF1fTaA5AIRegSuSBhgiAKl2u
	 MxyMeVBfryJ4d3ItMkUvGbOEbcHWvOuRlBBLgfeAAKMTQbW9Ax5aVxLMB/evLWPSI4Zpc
	 8ol9984jimO4w+p73Sq1BpeJmE/zTK74WJqc0DeKFmnYiSSJ1LUHCvOv9YBH0hjJEbaym
	 UKAVDw2cBNfPzKxF/5y6QKccEATEWAUA81BjZ5vsQdkQ5XcLtILPzDsDL1DpE9oES2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cQpMD/YI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A5606A335;
	Sun, 22 Nov 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQpMD/YI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795350979;
	b=miekTAsB90M7PvTA/NQ54JMKFQOFR1QDcNqhIYNmYZQkA3Bgt335prvKoap+/ehZrX8F
	 6RilfhUSAWqBlqGpRTM0Zk2OXBysYBN2VwtnFfrXTcqs6euY+D8FmDsTvRjmkG4xlUVZr
	 NF05lf8FP8MyKxQH23xqZf6ju/Th1XCpGroTL2481BLl0g5ALJaglaPxMdT6ppsYHVy+T
	 3X3zv2eOgq5U+3HOk/11GvCIphKqxcj32u9ODUoIAAtPYz5WKLF0+5fMbtu/IAp5036U6
	 pvRFKOnCiaxo09FhxSCbPfAPFz0rSlqQXn3TNNduAb910MgZIYyd6iCbXwTPSAzz7bA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795350979;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	b=TrAWAZien0NgSUNbV42CPMKMZfb+DJJHiR4b7LIYSiljko1Pxz1dVOYbvMvxoy4546ZO
	 s2zdfFrdRku28oDVcfI6ymdiw/GvFu0KMQkeL0tdKs+4BHZ4xfKy9QOIo8WdKAE6RS7t+
	 HRe1Fu/RiII6DR7w5PTdE5+c0X7fJqEM+VrG0gOxvkSnK4owdmo1MEIkvMFkYdg3OLSxc
	 8jqjaObUFIz6bqZn+EH47rw50cebnWCXYhzZtzznn9MKT9Qyy7no6TK+FxXmVC7FB3l6Q
	 6qAKILV9mw2cxx+LzMVl7hFXcddjoYp5HwL+14eYGeTegHDfn/z/BiMRHQ6fsF7mtaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8EF7E1F000CF;
	Sun, 22 Nov 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795350979;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cQpMD/YIpItzmUcUcii8EFmqUNHM4IMKZ5eqpjsU6uydU4HHCrtjMe5oOhxG5/mLf
	 FvtOFDXseycqXyUFtcDX81w1wuhPTEj32l+0gEsRp7BO+TiTxJGfhs3FxX0YkAkeO6
	 vVt5zqXdyqlYq1tc2hkW3OLZ1VLlKy658d+MRnBN5v+8GHXRef/5U94enTc22T8Fqg
	 6/LWW81hdegJVfHKrRYjA3IjAyh5H/i0TO+N0WPBoaDVhjwP39ZIFVzDRFD2Jg1Gj9
	 qyeADsutrOUXysHpQQq53x3wK0yaIey36s3n6t0nDarzjV45ACgIFEXcpqdl9sz8QA
	 o96hFG0xX5G8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0CF974C02B;
	Sun, 22 Nov 2026 12:36:12 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 20:35:36 +0800
Subject: [PATCH bpf v4 1/2] bpf: bound arena allocations to the user VMA
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-1-d542d1233623@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-0-d542d1233623@pm.me>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-0-d542d1233623@pm.me>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795350970; l=3854;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=NydRQKFXTXjxJi7zfPj1uOAvJMlBbK7Axhfoiyd0aNI=;
 b=bZgyB0O70KqrBqCTyh4nuOAUMlqdRdmQqJMTbqIhaKz7NM3HzkWae3OT3hSYll3PKjH9dHnFi
 A6opsC1BliVBVdg4BwChZYsjBbbTQVwgY/VHtG4mf02mErpSPOyoM3o
X-Developer-Key: i=fadouse@pm.me; a=ed25519;
 pk=b4DyzHJDRd8853IHUSKPA5wwzChj8eF4MTnZuyPz1PQ=
X-Endpoint-Received: by B4 Relay for fadouse@pm.me/b4-relay-20261122 with
 auth_id=1597
X-Original-From: YanXin Li <fadouse@pm.me>
Reply-To: fadouse@pm.me
Content-Transfer-Encoding: 7bit

From: YanXin Li <fadouse@pm.me>

An arena map initializes its free range tree to max_entries pages. When
map_extra is zero, the first mmap() may cover fewer pages. Fixed-address
allocations are bounded by the VMA size, but automatic allocations use
range_tree_find() across the whole tree and can select a range beyond
the VMA. arena_free_pages() clips frees to the VMA, so these pages
cannot be released through the arena kfunc.

With 4 KiB pages, set max_entries to 1 << 20 and mmap() a 288-page VMA
at 0xffee0000, ending at the next 4 GiB boundary. A 287-page
automatic allocation takes offsets [0, 287). A subsequent 288-page
allocation starts at offset 287, so its kernel mapping starts at
kern_vm_start + 0xfffff000. One page lies within the 4 GiB data band,
eight lie in the arena's upper half-guard, and 279 lie beyond its
requested vmalloc area. The first of those 279 is the vmalloc guard
page. The remaining 278 lie beyond the full reservation. The current
apply_to_page_range() path can install PTEs there. An unpatched local
test returned a non-NULL pointer for this allocation. Another run
triggered a WARNING in apply_range_set_cb() on a non-scratch PTE.

Out-of-VMA offsets need not wrap the low 32 bits. For example, when
the user VMA starts at a 4 GiB aligned address, they can still map
inside the arena's kernel area. They remain invalid because the VMA
does not cover them. The range-tree conversion replaced the bounded
mtree_alloc_range() search with range_tree_find() over max_entries.
The later switch from vm_area_map_pages() to apply_to_page_range()
removed the vm_struct bounds check, allowing these selections to
reach beyond the arena's vmalloc reservation.

On the first mmap() without map_extra, remove [vma_pages, max_entries)
from the free range tree before publishing the VMA bounds. The VMA
size is fixed after this mmap(), and the fault, reserve and free paths
do not add offsets outside it. Automatic allocations consequently
stay inside the VMA.

This issue was found through LLM-assisted code audit and manual code
inspection of kernel/bpf/arena.c, then checked with a Z3 SMT model and
a custom BPF test in an x86-64 QEMU/KVM guest. The test kernel
identified itself as 7.4.0-rc3-84074-gc44104f3642d. KASAN, UBSAN,
lockdep and DEBUG_OBJECTS were enabled. After the patch, the
288-page request returns NULL, the 287-page in-VMA request succeeds,
and the test reports no kernel warnings.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
 kernel/bpf/arena.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index ec2bda1a6eb..94321dec638 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -694,6 +694,31 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	if (remember_vma(arena, vma))
 		return -ENOMEM;
 
+	if (!arena->user_vm_start && vma_pages(vma) < map->max_entries) {
+		/*
+		 * Without map_extra, the first mmap() can be shorter than
+		 * max_entries.  Remove offsets outside the VMA from the free
+		 * range tree so automatic allocations stay within the VMA.
+		 */
+		unsigned long flags;
+		int ret = -EBUSY;
+
+		if (!raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+			ret = range_tree_clear(&arena->rt, vma_pages(vma),
+					       map->max_entries - vma_pages(vma));
+			raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+			WARN_ON_ONCE(ret);
+		}
+		if (ret) {
+			struct vma_list *vml = vma->vm_private_data;
+
+			list_del(&vml->head);
+			vma->vm_private_data = NULL;
+			kfree(vml);
+			return ret;
+		}
+	}
+
 	arena->user_vm_start = vma->vm_start;
 	arena->user_vm_end = vma->vm_end;
 	/*

-- 
Git-157)


