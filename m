Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317045;
	b=oXvb8xGWOp3SExMIDj28IITs09iswyFAituiby6l4yU2mq7J8Sl7Dh1pAHTbvWaXAk+y
	 ZZ0SW2kLQ6+dmPoNOX6xz/WqjxokVTES12izfemVqJcao9Gq081L2iXy2qKRm5J5HPXCP
	 BDN8HotscRjhlxk8fGs2zXEK39OL0EduReVeJFXFiISlvuVVNMPUA5cVHprU85+f/MGq+
	 Spb5VOKXDl7Lum00duo/nDN2P+KngXQF4cBv+qR6pvYCfzQimBBZSrIY/dGnnbMn3QANv
	 DVDymaCjnG9Cgl3BecxOY4ZBVfkyfNQOTMZRPxX0DTOfPize3/S5O5ZuI2u4E7DTPhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317045;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=DiArSuxRSivacURgYK5MkN1Yt77C4B03HaAp7xcytKE=;
	b=hn585IOBeiScqaCbZepWoJS96sedReLPtVpbjv0V/sfzfTKhFwllCyO+lOoyj+X0o+f3
	 hpeR2pTYFTiTWzIGkM85Gtwud3das2CCqsjyJgnVPgN4fR4IUD/Z8NT96RMeYhq8SSyiA
	 8tdVmG2KdRzdebDUQ41p9+rKrbmFCjRqj1lYdTyjBrCriXRpRu2utK3A4yB31kNn8xW+3
	 jZGMeT1rheKzWmv1h1dlUmToDgQQgEwFF4j+OzNpZYuOavkDfxq8jcABvDzNirnEbfLd3
	 TcOzRMgerqPKniXxjsL2Ikq6nKWyKymiTk4eHDQA8aroiedHR1ctZvdCSJowKZ9/9MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=E27uGIe3;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB4606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FCB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=E27uGIe3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795317042; x=1795576242;
	bh=DiArSuxRSivacURgYK5MkN1Yt77C4B03HaAp7xcytKE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=E27uGIe3Tf4/dpVCuB48b39mRE1bzSqpSvFSrsKvj0IJ5eQ/UJ+uRpXUSnqiWMC35
	 DPW1RISdPcf4dVV0PYe5rqCcLRfF7d6e/xyqSZ06FmbgQVQeNwkrywCsexyzUSlqJt
	 cQHJIc+efQS1AiGSc0gnYR9nqtyxbDlWoK+vLoCtcPQxyB7EnOMsSIy/2jBx9Sip6P
	 OPdHM6FswO95GXmEZyGp6/l9asMn2HOhH+k7R3kCpibu1dEIYzWinXNW9Zk9TscO+6
	 x/f5IPTrnkj/gSLc2ptRxfB01DGm8D0AbQX8ovNnHqOnCVczdHLrASRWeX5ZPolnb1
	 BZA5UWBBJtJlQ==
Date: Sun, 22 Nov 2026 03:10:35 +0000
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
From: YanXin Li <fadouse@pm.me>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH bpf] bpf: bound arena allocations to the user VMA
Message-ID: <20261122031025.9771-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: 2e36b302af08c03e0e2b4c68ce61bb904147f183
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------1492baab12ff4501d634dbfa736361d7a3b2c06d5052aea3d963a85e09afe94f"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1492baab12ff4501d634dbfa736361d7a3b2c06d5052aea3d963a85e09afe94f
Content-Type: multipart/mixed;
 boundary=656e3c67ab831e1680d881cd91b1e9d6f848d20c836203c4d510f971e408
From: YanXin Li <fadouse@pm.me>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: bound arena allocations to the user VMA
Date: Sun, 22 Nov 2026 11:10:25 +0800
Message-ID: <20261122031025.9771-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--656e3c67ab831e1680d881cd91b1e9d6f848d20c836203c4d510f971e408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_arena_alloc_pages() hands out page ranges from the arena's range
tree, which is initialized to max_entries pages, while the kernel
mapping of those pages is built at kern_vm_start + (u32)user_addr.
The fixed-address path and bpf_arena_free_pages() both assume that a
returned range stays inside the user VMA, so that its lower 32 bits
do not wrap past the end of the arena's 4 GiB kernel vm area:

    long page_cnt_max = (user_vm_end - user_vm_start) >> PAGE_SHIFT;
    ...
    if (uaddr) {
            ...
            if (pgoff > page_cnt_max - page_cnt)
                    return 0;   /* bound only on the fixed-address path */
    }
    ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
    ...
    uaddr32 = (u32)(user_vm_start + pgoff * PAGE_SIZE);

When map_extra is not given, arena_map_alloc() does not know the user
address and accepts any mmap() length up to max_entries pages, and
arena_get_unmapped_area() only requires that the mapping does not cross
a 
4 GiB boundary.  A process can therefore mmap() a VMA that ends
exactly at a 4 GiB boundary while max_entries is much larger: for
max_entries = 2^20 and a 288-page VMA at 0xffee0000, the range tree
still holds free pages past the VMA, and arena_adjust_tree() hands
them out on the uaddr == 0 path with no bound on pgoff + page_cnt
against page_cnt_max.  A program that first allocates 287 pages and
then asks for 288 more receives pgoff = 287, uaddr32 = 0xfffff000,
and arena_alloc_pages() maps 288 pages at kern_vm_start + 0xfffff000:
one page inside the VMA, then the arena's upper guard pages, and then
258 pages into the vmalloc area past the end of the arena's own
vmap area - installing PTEs into address space the arena does not own
and returning a "success" pointer to the caller.

The damage cannot be undone: arena_free_pages() clips every free to
the VMA, so the pages mapped past kern_vm_start + 4 GiB are never
freed, arena_map_free() only walks the arena's own area, and 
the stale
PTEs and leaked pages survive the destruction of the map.  A second
arena whose kernel area happens to follow the first one receives
PTEs for pages it does not own; its user-visible arena_vm_fault()
finds them with vmalloc_to_page() and maps another map's pages into
its own user VMA.  When the walk instead reaches an already-mapped
foreign PTE, apply_range_set_cb() reports

    WARNING: kernel/bpf/arena.c:190 at apply_range_set_cb+0x4d9/0x830

after failing to install into the neighbour's page.  Any program that
may use an arena map (CAP_BPF, or an arena delegated through a BPF
token from a user namespace) can reach this; no race is needed.

Fix this on both sides.  On the first mmap() of a map created without
map_extra, mark [vma_pages, max_entries) as allocated in the range
tree, because nothing outside the VMA can ever be freed or mapped
without wrapping; no program can allocate before user_vm_start is
set, and the same mmap() path already serializes on a
rena->lock.  And
reject pgoff ranges past the VMA in arena_adjust_tree() with -ERANGE,
mirroring the existing page_cnt_max check of the fixed-address path,
so that even a stale tree entry cannot hand out an unwrappable range.

After the change, the wrapped 288-page allocation described above is
rejected and returns NULL to the program, while allocations inside the
VMA keep working.  Z3 SMT checking over all VMA sizes, max_entries and
page counts confirms the mapped range cannot pass the end of the
kernel vm area anymore.  A test case and full validation logs are
available on request.

The vulnerable code is present in upstream mainline v7.4-rc3.  Runtime
verification and fix validation were performed in an x86-64 QEMU/KVM
guest running v7.4-rc3 with Generic KASAN, UBSAN, lockdep, and
DEBUG_OBJECTS.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
 kernel/bpf/arena.c | 44 +++++++++++++++++++++
+++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index ec2bda1a6eb..8adc2d589c7 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -694,6 +694,34 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	if (remember_vma(arena, vma))
 		return -ENOMEM;
 
+	if (!arena->user_vm_start && vma_pages(vma) < map->max_entries) {
+		/*
+		 * The range tree spans max_entries pages, but the user VMA
+		 * set below is smaller and its lower 32 bits do not wrap
+		 * past the 32-bit boundary.  Mark the pages past the VMA as
+		 * allocated so that bpf_arena_alloc_pages() can never hand
+		 * out a range that would be mapped past the end of the
+		 * arena's kernel vm area and could never be freed.
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
@@ -743,7 +771,8 @@ static u64 clear_lo32(u64 val)
 	return val & ~(u64)~0U;
 }
 
-static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt, long *pgoff)
+static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt,
+			     long page_cnt_max, long *pgoff)
 {
 	int ret;
 
@@ -759,6 +788,17 @@ static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * The range tree spans max_entries pages, but when map_extra was
+	 * not given at arena creation time the user VMA, and he
nce the
+	 * range whose lower 32 bits do not wrap past the 32-bit boundary,
+	 * can be smaller.  A pgoff past the VMA would wrap uaddr32 past
+	 * the 32-bit boundary, be mapped past the end of the arena's
+	 * kernel vm area, and could never be freed, so reject it.
+	 */
+	if (ret > page_cnt_max - page_cnt)
+		return -ERANGE;
+
 	*pgoff = ret;
 
 	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
@@ -812,7 +852,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
 
-	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
+	ret = arena_adjust_tree(arena, uaddr, page_cnt, page_cnt_max, &pgoff);
 	if (ret) {
 		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 		goto out_free_pages;
-- 
2.43.0


--656e3c67ab831e1680d881cd91b1e9d6f848d20c836203c4d510f971e408
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFVdU9NUllKS3dZQkJBSGFS
dzhCQVFkQXRuWWxTekhUTEhBMkl6dU5FMUF5OEpyS1VDeDZoUCsvdGM0TApEWENucmV6TkhXWmha
RzkxYzJWQWNHMHViV1VnUEdaaFpHOTFjMlZBY0cwdWJXVSt3c0FSQkJNV0NnQ0RCWUpwClM0NHhB
d3NKQndrUXVaMWd0K1htMlhSRkZBQUFBQUFBSEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJu
Qm4KY0dwekxtOXlaem0wQnAzZUVYUldrbklnQ2xXd3ZkeFptbzFYblZiNkZrYWpYVFZNMUIvakF4
VUtDQVFXQUFJQgpBaGtCQXBzREFoNEJGaUVFbVVoYW8zWi9BbkJJNExCWXVaMWd0K1htMlhRQUFM
cTJBUUQ3OEs2cGVkU1gzbGROCnlxZDNPSDF1TWpPM3Y3TFlNaE8rbDdjblNMV3JFQUQrT0NTcTEx
U2VhS29ic1ZHckxlalRNc21Nc1BCOGpueGYKaWQzaENOK3Bld1RPT0FScFM0NHhFZ29yQmdFRUFa
ZFZBUVVCQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRgpiRW02WXFYWDJqMnYyaUtEc1FNREFR
Z0h3cjRFR0JZS0FIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBCkFCd0FJSE5oYkhSQWJt
OTBZWFJwYjI1ekxtOXdaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnMKeW43OU5G
cE5xa0h6K2l6cElMQm5VZ0tiREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6UWdE
LwpjSUowODlKa25vZ1RzNnZ2UVorSjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNTOGFo
NWRCWVphOUwrCkhxamJEbWVTZ0RvNTh1U3graVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0t
--656e3c67ab831e1680d881cd91b1e9d6f848d20c836203c4d510f971e408--

--------1492baab12ff4501d634dbfa736361d7a3b2c06d5052aea3d963a85e09afe94f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0FgmsCXSgJELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdXARVfR3IxIbvoorGXW6J4FiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAADmcAQCoKhG7tW75E3QfLn1oKUDXQutQjGtuOEWB9KAG
YFULowEAr+079WJWHq2lIASOrIvyhBNVPkU4XLlGbefhFVo4wQw=
=n1VV
-----END PGP SIGNATURE-----


--------1492baab12ff4501d634dbfa736361d7a3b2c06d5052aea3d963a85e09afe94f--

