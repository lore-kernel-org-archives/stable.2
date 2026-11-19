Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069247;
	b=I08TrbYuCZdbmpBqrCzO9rN6ocFczGrcrSlgdGOYHSt7D6gaCWt2bYgf1mbOB9cX6xot
	 vzoH55+bbhf7nR7VO/vgXyIY1lIuuVXiVbmHv12esryGJJYkULzGMASTJxUt20UdDZIaP
	 8vODw+bAEV6rR7kPWhe5ZcHEwXm2KiZ++YDU6OxelI1u5TknctgB0VSwMGFaJuJMhB1Q0
	 kTg+0cMASSS5g1K0YBzPvr+1AilVJlDwo1Yk2mhBJHDhsPPlPRKtH6QCTBRzBbZd4Hclx
	 Rj076osjszceI7Eb3YFXtjeuqYLO/3WZ75NoWen8A9dtky+RukezEEF6eJFRIe4z4Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
	b=NCEKNq2wpEXKSVE3lOoUbotQPI3Gbd2845+w3iSJOseyPimlevIMjhC70frQvTxJ/y77
	 nGamoOFZ95edgp5AjjhDJPoGYxI+c+ya0gcwFXh433Z2B9W695JeZflHyzCRMkXMPL1Qr
	 v6tEnRS3z1A0fVULVFlCOkdXzYaZQGvodPTOP0UgjJjhhW61VkTeFLVAUq4fETNdBPbAy
	 AEt0C+QrnxE1P43RoJkQbLb51d4LoBkljA/hRxmAB7H8mMw5T0LyGrijOucHfY8TepUHP
	 BEeYPCFQFm2IzqLBbWzRWe73o2R/pEnwMtfQy9jEr91NbEmJeitlfoFxHZc/XF8+ohg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3oxpHUL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182A606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B182A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3oxpHUL
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ea0c05c92so18505516d6.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069246; cv=none;
        d=google.com; s=arc-20260327;
        b=NVeJL/4gkhPjPPel0ozgB5Q1gL0qbDD4EGFfWxQcPKaJNrU/S1WKQNtLwTaG6DedTv
         tLLm/cUDhZG9EcFKRiHgbStYOkO0TZdlmtDr6g6yERxgBkRJ2p9L5alHXBM/8rcbGN9d
         OFnmuftF8BJLQw2dDj8YwQ1CFAY3PENYB8KAdSP5rG1EZXgYptXQOfY4zoCfTS64t8gt
         MqjAJtpxTDZDJKji2Zsmwxj1jTIFlcknnJdVA6KIHseQ3MSP4WzqPoZzgSAsbTNnE1kI
         Nv/EWeMXPpHl23XFB3mfdLbH9mMHr/6Adz5O4T+igYcOsmiy3VIQLZhyUxrLN55wsQj8
         nmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        fh=2OTr/MhwV3BNFclTrB9x0I5AMSunYDWO/Uhl9SpHoms=;
        b=sdgL9Sq8Cso/+6mvWQDAHrM+Ij0mRSB/mu1EszazCnZGb/l23/jFg1my8Ru4jMFxiU
         jsNtmo+d19QjGYvaOn3xdJv1to8WvI72G/rjonhXdU7+DBm4bJZZMeBmQNiw3CXQlTM6
         vSm3SkgBFpIlhncjL0aaWhFQb4Ii9sRSk4zt32U9IybTb+5/cW/VqYT06Nyxn96dfLba
         po1UPlreuyPULxyXK/56xk9dxoVri/xN2n4pTPGqMjcsPImIAtCu2mvn3ay7pkwo+Y3a
         PBm1Ui/EjcIUQrMrkiVcZhiqwmlKrYo1JWCauD3SX96xWa0PFLRrlKSAY6cfYmCdQLV9
         OtWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069246; x=1795674046; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        b=K3oxpHULF4L+vV1q+0GdTBv3uOvLHlttlMr7OApOglNWVl+Zu9hnmsfBh8ArpL5nos
         0Cp5+2skbP0ZCKEDEDLtPxweHy1c/1NSt6N68MGuiUtoCU/ddPCHUsx5Pcx+AJ5lx3l/
         4f7UJPrMJgYaPHi3y5ZzjqrX8tNmwRvhBoc5WTpy4NoLLVMEo0FHTyqgMPrqR/R0J9XI
         fJRVS6H1aLtMQwDm4aahimGeHRiCYiipcu0FD0Ll6DtrvUvcqhq9gim+3Y0YzSNYYenN
         Xh0uaI5/fA8UB01kXzaOOTmXD9Bc97UfjMZ5RrjNmn9ReLJHBkhF4ykhtWf4pNu6tD6c
         MtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069246; x=1795674046;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        b=S6GAzTKk4jtTDdhveQT6btGUNn+Z9XAX8KYkNt5KellDFXOnQ7gF8cASlhyP46v7O1
         eUApPOR4BrcQo0/sdIFJc7En9K+EgsLtlevK3RMenmO2sWXNguV5pnbBv8Y+bHGngpGW
         bJNxqzHyzAj16CVZqHXNzhlWme3CmcRSW23NX8yUO6bRNHblfavuPtkf/GDZVYQwpI2V
         yrZQ9tnEtcSVKrimDexA6EVy7J2+T+Dv5ArQtExTZphutcDHfvC7xXhzhnNfX6yveC7d
         4/obhcG2nFiwwp3V+ntGX+ZkYXmK7MMHwwkKXR7NZhiMcDkH0TxeYCjaGt6Il/ztS9TB
         hxmA==
X-Forwarded-Encrypted: i=1; AL+hErFTd7vp++ju4X9qHr/PG0UQcWr6uH0k9jsXydTeZpK62ZDvfqqn3u+YBseCEeKVtVGPDS+2BKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YvkcByZGaVIaV7UImLbXjiZZpWUYB348rhyEgiu1oU8SXnNgf
	Q/cLJUWF/ArT86Ouq1hh98ldDNmq/+Hu489BinrvFYf/t7eHBgU0FkXTFfkz4RbXgZy+CgoGxqw
	jShR9R1TFtIuWlly/EPe4RLR5VH6eD8w=
X-Gm-Gg: AZFdTZfXGeV43p46NJXTQaBaMjVqrpKOVrLARoDAfvHqyxSZBcN1GjT2n4v1c0ZIMgE
	BPn6AqOojdX6WDANhDc9vbAgN6nxeWNYGfM98b59JZhd6LE0CqI5Q5fGNuTZtgvTKYPLDUvczvY
	cK/IauQ+Fap7S/hmSuvsFOb5yzc96DGqK4bo6yS7CL222cnTOqkCRK1qU7z9etGxltZ01fhMYBt
	UH85UEfIf2g1rVmBKNoIM4EN9IKPBOTFGcZdd7DlF/Yig5EJUuDrfxNR53FcNxsOOUG2VYOtzHr
	NbOFzKEkoGz4B/avFUXdV4Zxp2cAdGYZ8mXDKxg6Frqafb5IclmtGjRYstGyZ2VKT3nnIwyLSZS
	Wm4HV/grb0octt43HN3Hk7f0+3TZlU7AeLJdakxBGLKZDl2cF8Ig7DH/s3gwN63m9gTcwqqOGeU
	BvBi6GvhBXSZxcMcthzg==
X-Received: by 2002:a05:6214:8010:b0:921:18e2:4b8 with SMTP id
 6a1803df08f44-92118e205f4mr59170016d6.12.1795069245648; Wed, 18 Nov 2026
 22:20:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:20:34 -0500
X-Gm-Features: Aa3M54peGcZ3HW3rbZ6EtpU-sE3Eis0PWV29zDNE9SCTxw0n7cbFv5MbYn1qN6c
Message-ID: <CAMcAce9pi3BwKUAdsfx8GFwMMFx-=-UkkUkqsCDOqbwaL9eSxA@mail.gmail.com>
Subject: [PATCH bpf 2/3] bpf: Fix missing raw_tp_null_args masks for NFS and pNFS
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Audit of NFS/pNFS tracepoint callers against raw_tp_null_args[] reveals
several missing or incomplete argument masks:

  1. pnfs_update_layout (fs/nfs/nfs4trace.h:1990): raw_tp_null_args[]
     currently sets only 0x10000 (arg 4, lo), omitting arg 5 (lseg).
     fs/nfs/pnfs.c passes both literal NULL (:2166, :2177, :2337) and
     ERR_PTR(...) (:2205-2206, :2300-2301) for lseg. Set 0x200000
     (0x2ULL << (5 * 4)) alongside 0x10000 so btf_ctx_access() marks
     ctx[5] as SCALAR_VALUE, preventing both NULL and ERR_PTR
     dereferences even behind a NULL check.

  2. pnfs_mds_fallback_pg_{init_read,init_write,get_mirror_count}:
     raw_tp_null_args[] sets only 0x10000 (arg 4, lo). In
     fs/nfs/flexfilelayout/flexfilelayout.c:1225-1231,
     ff_layout_pg_get_mirror_count_write() returns early whenever
     pgio->pg_lseg != NULL, so trace_pnfs_mds_fallback_pg_get_mirror_count()
     (:1228) unconditionally receives arg 5 (lseg) == NULL.
     pg_init_read (:1128) and pg_init_write (:1201) are likewise
     reached when pgio->pg_lseg == NULL. Update all three to 0x110000.

  3. nfs4_cb_layoutrecall_file (fs/nfs/nfs4trace.h:1520): absent from
     raw_tp_null_args[]. fs/nfs/callback_proc.c:262-267,320 passes
     ino = ERR_PTR(-ENOENT) / ERR_PTR(-EAGAIN) as arg 2 (inode) on the
     out_noput path; TP_fast_assign (:1546) checks !IS_ERR_OR_NULL(inode).
     Add { "nfs4_cb_layoutrecall_file", 0x200 }.

  4. nfs4_test_delegation_stateid and nfs4_test_open_stateid
     (fs/nfs/nfs4trace.h:1119-1120): absent from raw_tp_null_args[]
     while fs/nfs/nfs4proc.c:2910 and :3003 pass literal NULL for arg 1
     (const struct nfs4_lock_state *lsp). Add both with mask 0x10.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84) and 6.12.118
when CONFIG_NFS_FS=y and CONFIG_NFS_V4=y (all reproducers flip from
LOADED pre-patch to REJECTED post-patch, including pnfs_update_layout
and nfs4_cb_layoutrecall_file under if (!ptr) scalar enforcement).

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0044156..ef10af2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7402,13 +7402,16 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "nfsd_file_cons_err", 0x1 },
  /* nfs4 */
  { "nfs4_setup_sequence", 0x1 },
- { "pnfs_update_layout", 0x10000 },
+ { "pnfs_update_layout", 0x10000 | 0x200000 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
+ { "nfs4_cb_layoutrecall_file", 0x200 },
+ { "nfs4_test_delegation_stateid", 0x10 },
+ { "nfs4_test_open_stateid", 0x10 },
  /* nfs from pnfs_layout_event */
- { "pnfs_mds_fallback_pg_init_read", 0x10000 },
- { "pnfs_mds_fallback_pg_init_write", 0x10000 },
- { "pnfs_mds_fallback_pg_get_mirror_count", 0x10000 },
+ { "pnfs_mds_fallback_pg_init_read", 0x110000 },
+ { "pnfs_mds_fallback_pg_init_write", 0x110000 },
+ { "pnfs_mds_fallback_pg_get_mirror_count", 0x110000 },
  { "pnfs_mds_fallback_read_done", 0x10000 },
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
