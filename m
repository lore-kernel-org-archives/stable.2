Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106770;
	b=jgCJ5eUHW1B/adPIkcrwPnDmfLzTVL1EHF/2s0u8sNxQeOdXkEWGaJmz6lzIynmAaFic
	 bVaNGnT2ChVqUBvPWY68O6ifJcu+3124kL0xzmq7+ucjVz3COBAmHZOUbrrlJKqhRRQ46
	 RImsdQhidsJbTOUvUcxjc/I+UR9Xs+TFPe4V/wpsMKMH/Uih2UpR0jAVzhVUI+Aaymr9r
	 Cb6c48gV42aSCiXPVWJefzNMuKE3WtjhJ2qEKh86yEqI8xO/qRyMczVFSltfb/YCr7G4I
	 O0kphpjHOVar9Eq9tgkr2LtjbwfNtea5X1KuWFDaeCTSTjOwU0TYmlf5kirU646Qyfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
	b=hUYWW1HomGFpZBthw9Hp+uJkGjWVJwnE8InB7RDDEtVy3EprQLcbZArY+JNXMujuGlyN
	 wbQJ/G9nYMm3QJCd72pa0P5jDmWvhmicrfoVJY9cWErQq/vQwPDco1cGzouHGs4MvGa72
	 qQqHOZKR8sol8CBkSAfXNbbq0pGjfG7Nz2aE1nly7ie5SziKe7xC7pttobTpsVMddL04H
	 5hIisHHrqrhJzlvon3YfO9HWJTlfvmUYavJh8ljUozHaJBJsBNm3luBSuKk6j5L6FsTbM
	 URKn2jmd2kja6DCAh2Ce8O2shxNzI/4+VW1RZC8s25/xY1FPNsVi8HU7VhBS/vRzlpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaBHuDmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C2606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 851C2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaBHuDmd
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-92106d5371dso14723416d6.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795106769; cv=none;
        d=google.com; s=arc-20260327;
        b=ZD+AO2LAicA6Neyk7Mb3vcYSemsRB8Jk34n++iQZ2LBRyAcdW9yXRQ72FqG0Lv8x0o
         xRNDdQQ0bOmUj6iovVouMC0Al8xSEmFaqnaXGxtDc1PnIbPEvV7EN+YkxRJ6juN58n+O
         hzEiZHQol0tBE1lGLx9eYqG4KHWx2yLj9564Zv3JQFkZVCDAgS3tVlVVGs8yIiQ/FZ8U
         oo/9J2CWjt+yyLLzqKwLigxv6FzwLfwbDU7CR1Pe/5WXfmKKHbIDRRntLaU6SQVtlHt0
         qBn0FPfy9J/sampVGXVMaD4E4NRx3fQ5CTbtIUiqfHkyv+1vw5MU6ymEH/WVa6dtsKLl
         TPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        fh=XMCbGw9rgcQ3w6LyqDABhswCAcowgPCXUGmkOlO9wGk=;
        b=Fzl5QMb2CXU8Wcba403XDE+3h+2YpWoiU5NW2xYZ0b9EDecdM72300oe2exXtZsdfl
         EIooE2PxTXFLsVftztO1u/1bxXOgchcfQgrD23qzYogIe18TXqWdS4eh6/Re0cvBeKH/
         WZXV6XFeV1PpV48q7PfpiEkg+RnjdoR7VxjehBfPrpB5+nt9UFQr7+6aUiwLyfGyBO2J
         kO6/4oZM5ZlfASCLMa6sjcQ3RU9Wym7U1/YMp/sP83VRNl5EHKsFy+ZlZH2WjKZpikl8
         MlUzWGWTQ48nFv1PM63IZ+tOS9YupMSWnCheAmDwQccL+QE6PdwFeQDjxoCmuE106jY9
         czyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795106769; x=1795711569; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        b=VaBHuDmdUUoqfJOAQoTQR7FMy8cWXNQy4bPOMeuHmEtAkQgtoskPx9t2bS/f/Tn/xP
         KO6wZUKkWOIyieKEHBN0nNhZkEJL7qCpavnzBBtSPGMSxWHPU08rj0AIvcX4FntmCILN
         R6ls9KGCcOirlwaG5x9kduwfrWawyGx3wA0Eo0hWsgK2ayy8XwQ9dqFa0BALo5rkShnv
         hN4o3KyRHyFpn4KoNEEplIPC+n1LcmQPN4FNeTCutEEPpQBrx+qAR2hJlISMCpniS2P7
         u5mHWk6sBvqrNYgfZTTGtxAq0Cq607z3vofO1Nnb1OhFtS1LLzniyQks9KlmxZeaWN5X
         ik1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106769; x=1795711569;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        b=aKZdHmwuBYYRmaM93oagaRPs+AKEhnJ/TB8X3l6mZ7bJNlzzEgJQ/MmojuDPA1CBqv
         IzYnPLR9EnFMWTMbsEOt1Svij5YfCilKXBMViDDb7QbN+Rlow7MbzSa3y2L4ubf3dQgp
         J2mM7pOPs4y+s63p8a+inqhxR37BRMJmJJLax/tcXY9y87pyVfvDd3LdqMcmdyQGyh5X
         TIWWVggJS/dxiO/4wkQSr2r+fxSxwnrZTviUGJXUzTRQcY/BWFUuthH1NFkYHQMj6Eyf
         Dq4peuiV0NMkjprZdmQf8rsr/4y0YAZtzji9huAOAz2Fs+H537zyCtMTe8aWbBvUrvGP
         Elsw==
X-Gm-Message-State: APuU4Z/F99wUfgT2VOk3dFXS/WI2Ae1v994So7yOGf7KXdMb9Or0epir
	0DYmLfCuWLV6Vc64VmfKNvl3Orrn4ZqCYGsIztN5m7l2/YqFmM6sWaBgUykkuSjesR3Ch5eFgM0
	CCxQXjq5dLysYhv3/rVa0A0tBorVPEAfvPV+iSTi2BYxK
X-Gm-Gg: AZFdTZdcabB8fG1/9SK3Dc6uzDaibGYxwOKKr2+q1RK/fiTeSzrVr2Mwd7u9JmRSi+B
	Q0kQ33iz08JyVxbEms8TFI3p5H2FOGsx4fEnlBJCOcj+lpJm16U2Km5i9HfltgKWUfPPrZJRNVh
	n3utVVW337YWMrh9cTiyXjmhQD1WfAw/3bUbBXhoE19/0SDLkKqmAXM7VWmgCKApp608R1dMOem
	3gebx9EYIiN9wN2koOA7GPJgmuH5yGSIdzooucRWM0MWj6mKTu4Ij/FRItK1YKPUQUciApfxoWO
	BUxT1tu5BlGMeQeG/3o+97ijiGI7Y+X8BiaeDBFLrBL9SxX/DJHyFN5xkcisyLcXamh+6xmEioT
	mBepaCqiBly0jFYLeHQlhWdOu36wxSmvtE39TA8RWHDMDIzSqAFaV36+tFzfHHriTetBn/0TGka
	RfaxlRPMklLu6bZTj3qjg=
X-Received: by 2002:ad4:5d6f:0:b0:91b:9582:d91e with SMTP id
 6a1803df08f44-92134aa0592mr2182256d6.9.1795106769270; Thu, 19 Nov 2026
 08:46:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 11:45:56 -0500
X-Gm-Features: Aa3M54rJ4NzvBHM56xW7TojSAPs0qqh8iAh_CvhoCd_Zj5g0_53qw97QbIYyhi0
Message-ID: <CAMcAce-4MeO8rpx2rvDu77r-OpbFd9k0geOs8wZBoaMbYVkpDw@mail.gmail.com>
Subject: [PATCH 6.12.y] bpf: Add tracepoints with null-able arguments (CVE-2024-56702)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, memxor@gmail.com, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit c83e2d970bae ("bpf: Add tracepoints with null-able
arguments") ]

In v6.12.118, raw_tp_null_args[] in kernel/bpf/btf.c lacks nullable argument
masks for nfsd, nfs4, and bcachefs tracepoints introduced by upstream commit
c83e2d970bae (CVE-2024-56702).

Because the verifier treats raw tracepoint arguments as trusted non-NULL
pointers by default, explicit NULL checks written in BPF programs can be
optimized away, triggering kernel null pointer dereferences when tracepoints
receive NULL arguments.

Add the missing raw_tp_null_args[] entries from upstream commit c83e2d970bae
to kernel/bpf/btf.c on linux-6.12.y:
  - nfsd_file_acquire (0x1001)
  - nfsd_file_insert_err (0x1)
  - nfsd_file_cons_err (0x1)
  - nfs4_setup_sequence (0x1)
  - btree_path_free (0x100)

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e2fa364..55018cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6498,6 +6498,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "sched_swap_numa", 0x100 },
  /* afs */
  { "afs_make_fs_call", 0x10 },
+ /* bcachefs */
+ { "btree_path_free", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  /* netfs */
@@ -6551,6 +6553,13 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
  { "netfs_failure", 0x10 },
+ /* nfsd */
+ { "nfsd_file_acquire", 0x1001 },
+ { "nfsd_file_insert_err", 0x1 },
+ { "nfsd_file_cons_err", 0x1 },
+ /* nfs4 */
+ { "nfs4_setup_sequence", 0x1 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
-- 
2.56.1
