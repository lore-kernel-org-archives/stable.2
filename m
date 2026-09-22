Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A872236F2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106946; cv=none; b=VWc6fXem1lwEDHLL+bKbDUZOZYEb90Ic5M2+ACrOONlHsD/X4peWYmMO4S0v4Mmn9f2WL/JcPtwJWH72tZBK+DFlZFe6RSPuIEt9G06boV3uswhQi2X0bunUhMEQcRKjwvxJWDU8Yf/lObEvpDAowlT5fQJz/2Rj5Y9+1DhTB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106946; c=relaxed/simple;
	bh=IQCPqAcKfTSMbnbhBNrVI2Xy4poxRTksS098B2Eb/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/T5Lp/34Q89JdN0dgEHgSRhyU8Klq84Z/oRSilqwQzMHjTikAvVfDIPTbgyDE/wG71+Imdg4NPoYBP4Xo20desBG/ogc8UEVATezlfTa7XNuZ10fRFTPPkKltq5xu1N1u+44z0ZukaMl68uDhH5Qc8v/RcSIIPFFrdHf3bWmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=e5edXr/8; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="e5edXr/8"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so215234eec.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106944; x=1790711744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQ9k2LdyZWOUW3xTJYRrKh41LbCR8tTkAlidpFMhPxM=;
        b=e5edXr/8g8bsauAvJp+ATgEwJt/10Of850dEU/nvIEjD/gRCt/QPyHB5kuWGZScQZp
         p7lN8k9Gsf9ZM4N0PX7TatChfYCnjIpqhQcmffRgXHDKbAyp11CLwLwsUCI/1K5CAeAB
         jvf6yAVd3T/ZfvvsxWcXztH1zfffZlUiYPJG2Ukt9ssEvSLyxBuZ5KkkQsuez23gOVlO
         MiZNu80UyVTZB6ZjjsEskq9tpvCUmTHg3H74qrLlAf6IONdV0DvqSxKosSH/KFaGRvkk
         7jDCS8qUc4gk9Q5ljgG00Q6bBASNtzv9ScC+gIoZlJjhvrtAzxaXxZgfXAYAyhE4tP0D
         XO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106944; x=1790711744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQ9k2LdyZWOUW3xTJYRrKh41LbCR8tTkAlidpFMhPxM=;
        b=hWOUXhIsS5dzoNa5ynUQpw+SWkL+tirUz+Rw0bt2ziirrNDlJFS0em1WnT0IE9OfY5
         o/zAVRmVp6L4jLan2dosQLg0WJKUv75hx7SbwjNAkAq4wDXEbCg7vUmnm7h9O01kymi5
         6xPU601xwtWECyBngz2HuFaCfmiJxNfxJ+8f8R+/Hp1VAiEgNXiKgxdg9VYg6VzRvHBr
         DUqmHc5ljjRDTUKrHGlk+zsQ27+VKAYoxWo/utKBCdmxM36pOytr6jfMDD/Hn2ecEphP
         XqkhkJqoWFxznzCo+5Ttxc7y0pqqOdhgkt2L/dTpDyg7bTAQrCpwXAaZh8UWdMap5lXB
         l49g==
X-Gm-Message-State: AFuF++m2lkcvxvWaTwvhjON6DthGYMVFHCHjtp65+0pf58IUpO+SE/D7
	vbUxF+KHL5o0x/xsB+5zufO8skM4hHCji1HIIsvhMpJJlyZ4evaaVG+1pxKq4tvUJ6EzrWbzg4i
	eDeWLfiQ=
X-Gm-Gg: AYBFou3y6SQML70LP2XwBXO8VGP4jKbcfWYeYU6m1sjIjyRwXbvyeYGPWSjAf3Ae6+F
	Yq+kFux9xpjC4/CYAJMlIE/i8W9T/yeo27+ixaMAUeEVPVzPSCdCUQ67Do+D0sAHHSNC7/m8WRz
	yN3+a7PaVbqLnn+gnGmWVkmb2U31fN34C4CuC15E64FA21dPN2FjWb/sMwmkzQQxqGUtUXf3Zzu
	shGl8ppq3IwPSx5HFE37jhLH+aIifOzCVkVZ6XgKup2SxSqguLj7/8A4MfdkcERW5buZCnvOt7G
	h2ohbKmjZjfFS2xfJnpMn3O8ypvUGR/ufJjoo3W3S9XnqxzQnUV6R1R0jtVBnBZyZVfSQFL0hfk
	/E3hJp4Xce1sjM27AM9Xatj3ol+NIteNSpe8P8gzQNbREDjPHIsKLGyVorq2HaAmrucE7KR8BdA
	wDdWugNRgeyVJUTF2WfO5ceTbQGfiCDijnQqIXJriejNenMA/3j4o4vb6iP3A2Ibf5IqwRSadOy
	VqY6FNsxw/511IcbQap3+OSRYH9O7m7scowmP7iREcn2JjzGxYPVoRXvgvb3hprbRq/U9McyBiM
	uaECUQ==
X-Received: by 2002:a05:7022:fa9:b0:143:2719:a501 with SMTP id a92af1059eb24-144f9173969mr664924c88.40.1790106943509;
        Tue, 22 Sep 2026 12:55:43 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f949e51asm578264c88.1.2026.09.22.12.55.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:55:43 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.1.y] bpf: bpf_sk_storage: Fix invalid wait context lockdep report
Date: Tue, 22 Sep 2026 15:55:38 -0400
Message-ID: <20260922195539.26679-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit a96a44aba556c42b432929d37d60158aca21ad4c ]

'./test_progs -t test_local_storage' reported a splat:

[   27.137569] =============================
[   27.138122] [ BUG: Invalid wait context ]
[   27.138650] 6.5.0-03980-gd11ae1b16b0a #247 Tainted: G           O
[   27.139542] -----------------------------
[   27.140106] test_progs/1729 is trying to lock:
[   27.140713] ffff8883ef047b88 (stock_lock){-.-.}-{3:3}, at: local_lock_acquire+0x9/0x130
[   27.141834] other info that might help us debug this:
[   27.142437] context-{5:5}
[   27.142856] 2 locks held by test_progs/1729:
[   27.143352]  #0: ffffffff84bcd9c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x40
[   27.144492]  #1: ffff888107deb2c0 (&storage->lock){..-.}-{2:2}, at: bpf_local_storage_update+0x39e/0x8e0
[   27.145855] stack backtrace:
[   27.146274] CPU: 0 PID: 1729 Comm: test_progs Tainted: G           O       6.5.0-03980-gd11ae1b16b0a #247
[   27.147550] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   27.149127] Call Trace:
[   27.149490]  <TASK>
[   27.149867]  dump_stack_lvl+0x130/0x1d0
[   27.152609]  dump_stack+0x14/0x20
[   27.153131]  __lock_acquire+0x1657/0x2220
[   27.153677]  lock_acquire+0x1b8/0x510
[   27.157908]  local_lock_acquire+0x29/0x130
[   27.159048]  obj_cgroup_charge+0xf4/0x3c0
[   27.160794]  slab_pre_alloc_hook+0x28e/0x2b0
[   27.161931]  __kmem_cache_alloc_node+0x51/0x210
[   27.163557]  __kmalloc+0xaa/0x210
[   27.164593]  bpf_map_kzalloc+0xbc/0x170
[   27.165147]  bpf_selem_alloc+0x130/0x510
[   27.166295]  bpf_local_storage_update+0x5aa/0x8e0
[   27.167042]  bpf_fd_sk_storage_update_elem+0xdb/0x1a0
[   27.169199]  bpf_map_update_value+0x415/0x4f0
[   27.169871]  map_update_elem+0x413/0x550
[   27.170330]  __sys_bpf+0x5e9/0x640
[   27.174065]  __x64_sys_bpf+0x80/0x90
[   27.174568]  do_syscall_64+0x48/0xa0
[   27.175201]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   27.175932] RIP: 0033:0x7effb40e41ad
[   27.176357] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d8
[   27.179028] RSP: 002b:00007ffe64c21fc8 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[   27.180088] RAX: ffffffffffffffda RBX: 00007ffe64c22768 RCX: 00007effb40e41ad
[   27.181082] RDX: 0000000000000020 RSI: 00007ffe64c22008 RDI: 0000000000000002
[   27.182030] RBP: 00007ffe64c21ff0 R08: 0000000000000000 R09: 00007ffe64c22788
[   27.183038] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[   27.184006] R13: 00007ffe64c22788 R14: 00007effb42a1000 R15: 0000000000000000
[   27.184958]  </TASK>

It complains about acquiring a local_lock while holding a raw_spin_lock.
It means it should not allocate memory while holding a raw_spin_lock
since it is not safe for RT.

raw_spin_lock is needed because bpf_local_storage supports tracing
context. In particular for task local storage, it is easy to
get a "current" task PTR_TO_BTF_ID in tracing bpf prog.
However, task (and cgroup) local storage has already been moved to
bpf mem allocator which can be used after raw_spin_lock.

The splat is for the sk storage. For sk (and inode) storage,
it has not been moved to bpf mem allocator. Using raw_spin_lock or not,
kzalloc(GFP_ATOMIC) could theoretically be unsafe in tracing context.
However, the local storage helper requires a verifier accepted
sk pointer (PTR_TO_BTF_ID), it is hypothetical if that (mean running
a bpf prog in a kzalloc unsafe context and also able to hold a verifier
accepted sk pointer) could happen.

This patch avoids kzalloc after raw_spin_lock to silent the splat.
There is an existing kzalloc before the raw_spin_lock. At that point,
a kzalloc is very likely required because a lookup has just been done
before. Thus, this patch always does the kzalloc before acquiring
the raw_spin_lock and remove the later kzalloc usage after the
raw_spin_lock. After this change, it will have a charge and then
uncharge during the syscall bpf_map_update_elem() code path.
This patch opts for simplicity and not continue the old
optimization to save one charge and uncharge.

This issue is dated back to the very first commit of bpf_sk_storage
which had been refactored multiple times to create task, inode, and
cgroup storage. This patch uses a Fixes tag with a more recent
commit that should be easier to do backport.

Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230901231129.578493-2-martin.lau@linux.dev

[ Backport to 6.1.y: retain the pre-reuse_now unlink/free API while
  moving the charged element allocation outside local_storage->lock. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and BPF maintainers,

I am continuing backporting CVE fixes still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53857

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 kernel/bpf/bpf_local_storage.c | 47 ++++++++++------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 51a9f024c18298..23cbd7b1b810d7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -373,7 +373,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
-	struct bpf_local_storage_elem *selem = NULL;
+	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
 	unsigned long flags;
 	int err;
@@ -427,11 +427,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		}
 	}
 
-	if (gfp_flags == GFP_KERNEL) {
-		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
-		if (!selem)
-			return ERR_PTR(-ENOMEM);
-	}
+	/* A lookup has just been done before and concluded a new selem is
+	 * needed. The chance of an unnecessary alloc is unlikely.
+	 */
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
+	if (!alloc_selem)
+		return ERR_PTR(-ENOMEM);
 
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 
@@ -443,13 +444,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		 * simple.
 		 */
 		err = -EAGAIN;
-		goto unlock_err;
+		goto unlock;
 	}
 
 	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
-		goto unlock_err;
+		goto unlock;
 
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
@@ -458,23 +459,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
-	if (gfp_flags != GFP_KERNEL) {
-		/* local_storage->lock is held.  Hence, we are sure
-		 * we can unlink and uncharge the old_sdata successfully
-		 * later.  Hence, instead of charging the new selem now
-		 * and then uncharge the old selem later (which may cause
-		 * a potential but unnecessary charge failure),  avoid taking
-		 * a charge at all here (the "!old_sdata" check) and the
-		 * old_sdata will not be uncharged later during
-		 * bpf_selem_unlink_storage_nolock().
-		 */
-		selem = bpf_selem_alloc(smap, owner, value, !old_sdata, gfp_flags);
-		if (!selem) {
-			err = -ENOMEM;
-			goto unlock_err;
-		}
-	}
-
+	alloc_selem = NULL;
 	/* First, link the new selem to the map */
 	bpf_selem_link_map(smap, selem);
 
@@ -485,20 +470,16 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						false, true);
+						true, true);
 	}
 
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-	return SDATA(selem);
-
-unlock_err:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-	if (selem) {
+	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		kfree(selem);
+		kfree(alloc_selem);
 	}
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : SDATA(selem);
 }
 
 static u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
-- 
2.39.5

