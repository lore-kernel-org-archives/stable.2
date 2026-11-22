Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795346952;
	b=VE/p/BIujkUEc9e/y2ldDyHl9iuRliHQfJVj3740h6Tp9F7phaO6q2UGxo8dpfT9UUN1
	 Plb8w3qtOMe/q/MJiUJIeAD+yW6Z0ANP5L9oFvAVqnDfkUqVlrZk6unvPb24oFWwmzEJS
	 i9jVXIQudHSg/2GUVflewi1xDwZaGbW4nAE0MV90dlWqqLH4mMFaEjr0mc/vO0NDeDOgJ
	 hxe6vinTFz+3mshkp/ZRT65k0Y9mxJEi4EOjESdWg08wxoxZsVyN8GVHljb3Zk1TGsE9h
	 zGkhhTdcSrHyzrhDgPyLhq1OsKmnLhsxhnvZ+CF5XalAsUFswoEWRTGttmOnGtU6LPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795346952;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	b=FSZBR9GMuZgfxmiUsdILm/YIdySfAMwTUfRMl+y89N2CPvZxrdd3//j6qy5b8yicZk1j
	 lprL3QSFit0RubKPQysLow34Vysl/eMsXtLIRSAAmrQb+ar22OwQRLMvqAMCdPZxvqJkH
	 iR1UjY09ooYdbRtfpDdd/D67Xg/dV/9K4gN6HEDLugF7muCkqy7cyGwDiIs2J31xtMyzn
	 J5ATWn/BCw6a1+lQnk8WAw1aBnt35BkFanFNSGrEF3hs74YqL8YfxJ5C4+7zxIht47o6c
	 wac7U4cSzJxYl11e3b7HBxyBvk/bzK2T3Lg2kPxaOx4zJzFy6qeajsHFJs1mTShW38w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnkyH8XR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF1606A333;
	Sun, 22 Nov 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnkyH8XR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795346952;
	b=GWFcjJ1gF9KJnKJVkdNRDMZfYYHep4mQpG9lDZrVhrGStFpTiVM/OGF0N4x2q23fGeBs
	 zenvg3kH+Khq+Aqe7ujf3QWiHhbQWFSMSD41BpZqArldKOL8iYWnJUXfiF+BG2oO9fpuD
	 UbmLTilPTAju5rTN9bKk855u9XZXUkwbGfvZD/UzW6NLOc5UgyaVrp+1fTs2j9F5qtGZJ
	 H/lU7x5eUL6KY7fWEtuzatPezjG68iQkWg1suBczZEE3PrtePOKoIiCx1EHfihUppsMdT
	 h3eU0UsVxxE397bkoetVRpgaoEoxppIdhMer+Me1cBBOoLCycq6332CC2mz5ZptJAgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795346952;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	b=a5QCVWVSwekQLhOv9fLp2GeazQcNtoaOymdSH0EIQmTljDmm2raTKtmZNc386FqVlvIQ
	 CBmaPBGK2LJ8ImCjdIz7+W8xDCJx32Dpy4mIbmGyy/fuTcZYrO49EsGSRu02qsd7UvdOy
	 hpRd+3L0nVJ1SC5ixSjtMDmcyQVzBWDasG0rrxxCcZNlWvMYTVYht9Cjocw+E9ouFPls/
	 wvTxiI+J+qnyBqvhxiq11HSdTHkR8c1N5TxBrttGBDpxstir6cOd/xWeDHeh51gOmdq1l
	 DhloLnYQd6zXmzp5zS4fdy7J8mqtfGe7f4Keqohu3/+HvUIUz2vW0ENuMH8IAL5Dw4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 881061F000C4;
	Sun, 22 Nov 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795346952;
	bh=H8i5YVhr8pMD+/XAphh5neD9o3f3Uxu0RhXm2n+uogo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NnkyH8XRfn0DDSUQpDeVIKUzM8V6GI1awSsnvdX1HKN8IMCVKADR/2GTJ3WhwzrV8
	 5Ya90+kdS8GV+ie1tYrnceQX4any2rwmLQ40h850XQjYy1q+RF8j63j3YcnX6+GH1H
	 Ln6AB6b1jcV0sPsd9o2VyskhQ4b+k5SLd86KOmTyNWI7aoSbEZw0CB+37n3qsf8+72
	 guWBzlZe3X9Gl9SDBY7YaFDgiYpklr1eFrNl0ykplDMD2uX3MX9RaApzQKbtEWSP//
	 dmd+Cwl3Bsx2rjf29tf6rMhY71rsGAeau3Eyhr6lAjvgS+NC80fTDbQyNR8L6wkO2u
	 JdxyN0b2Q3Fzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0640D4BFF8;
	Sun, 22 Nov 2026 11:29:11 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 19:28:35 +0800
Subject: [PATCH bpf v3 1/2] bpf: bound arena allocations to the user VMA
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
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-1-1f94ae9a884a@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795346949; l=3854;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=NydRQKFXTXjxJi7zfPj1uOAvJMlBbK7Axhfoiyd0aNI=;
 b=ICvOVnTu+6PlSvU1tj91ffU42/BhMVeXtS6aucqm6B/gDO/IrNG5ohBfrABi/Pc1Mw8ZFS9re
 WpIgiwWwludBTBuA9GZLIOAt+0hx2W2cXPEjlrYIqVQbsNebKWWwC6h
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


