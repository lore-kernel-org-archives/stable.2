Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077845;
	b=TU55nwPMS/iGbEHsvZKPCz4VtQpWQwgc4YaeXxno7HzalBuNn/LTwJAH3o4PzcQ97KyD
	 /MrTW1xvfLPV1Crcvduub7F8kI4FfaKzw8VgB7ZaTklpVXBJ8HKvVGrQ3+Kr2G6b23dIo
	 IGvpnDnLiSVED7tpy5boJ/F/g+Mdks/IboTLwQK3UwQcKOoBEssG9Q5SsZFi9p2+GbEU+
	 inQjzuZB2L8PqS3QCLXNU+eljdS+VZhYnzKF2TvPivMmmCCy3CeyAYBPSeQiYxYLdO0HB
	 5tfLVRrSCCoGtAHiZerTI1pd8yXH81FDpOKPCvnkWwRM0mx89FG90FXb8Nd1TMAK3rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
	b=m8QfOFjzaPUD3ylA2VrnuT9eAl6hfDwBMO5H0frgipUE0nmOHs8qzm29lB9RKkZq38Oe
	 YcL19boo5rZYmxyZEzI9n1ASDUZNzkhuJZjYaZNlzWQjhu0qWacNFQxWCGlKDTja9QgD7
	 Ya6c8/TBG4Gpf3Y3NUr3AnbreXmei8rCJasihOBH2do84n+g6lNri5AjSFFNC5F0b5cXc
	 5yqwRiwFnd0rLoEMrWjIf0SXvvm7UPDSCxxtmsn9xCzkbtJZtJZi+8TK8i1FR4Fcb/6iq
	 LJU618cFjn2Wz2DumK/0YO3D0dUuRW+xJY6zI2OiiMef14y6puKfEm1CbHZcdLDLBEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZSekRxy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371D606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E371D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZSekRxy
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92116a3ef3cso8783866d6.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795077844; cv=none;
        d=google.com; s=arc-20260327;
        b=ScK+i9Yt/WS1iJ6e4eK38kCU2djxeCetSEq9JNdzGsChUzKNjg1LZcyG4QLFKSYIJJ
         U8BM9mV2k7+rV4+AfGesnaP12YVSdg+/oal8HD4yCR+OnHNIAA6mQnjeC3xehJpcYprW
         BUKi0doIGrHrO+Rud4eRRWohqYoT8y9Pp2zEQ/BLPgjpONYSCHuIZqFOgWgkslYCntPX
         ksAW5RYhLJQQqMIJ+nGRa/hLWqsv5uXyHXM7qsqODIWBQmDgM1mx5omXTZYHx/QsUX/6
         sOVMMkbbaMzi7y5CsCKlRx/TrMOBUQNCZkHOprN/9RWnUvEEpGl1nY1wRdUAweYmAzdd
         lNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        fh=cquyLZL7nkUo5uwm5W6tgFPGklo0x5NeIJHnPHZTda8=;
        b=nHpHAL1x4VBN0CITywVNcdBcjNAoUY+z8ZYSzulsTu8s/ofbS84hx6/OzS+wLAEsPH
         YYFTyHLI4JJJy8m315eL5liQ0nlZu0X7LctMaHcowwEEvTnGzqFx0sR9fTHoy6rxfRNW
         Il1kHC8j100xNInGyZkE4QcBT0QBKtN12HYNGLMOOHzPPBdZKiqjptoY6Govm6mwsqn0
         +GhUcQQ6g0Tk+igRvULV2XWmKjy/+YE1gBT0d9mYD5QslDdnmVAJMKUqzbmYW54/skfV
         hx4wtTT4FdO80G9NOcIztfVMusntLDbg2Q8A5GlGnAseI9Pmpp56KIrTIyuxYF+CDC0v
         Bktw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077844; x=1795682644; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        b=qZSekRxyGBWd9lIKqlMrhoek70YU55c2xT98Splbsv3LHovlnKXPggtQCo1YYVmJre
         kDLf2gkIOLxy2W1nro6L3L/8BdrrpMJvvJYSOzJDkwQmTjnRF43/+D83UyTTSMVM847R
         YY9y7yxGI+KMPKKNN5QFaSK05Rfi2IhtXnL+tDwVEDGRSjZUqb0uWow1vqUXn5XoL8Ru
         lvw3QBYejXH8ODZMSf+sRuSLjPSmJCptKgL8Jsq97/SX6IXW97jyYITU832HZvobEcT7
         OxnSaU3fXDp1CAY6X+wGDhESegyJAPAbB/9r8jjceZnL0nBn9leg1MjPKVacNdyEfBaS
         askw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077844; x=1795682644;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        b=0EA2wUE1KlOqnYXOt3X/Bm6ey3aE8vWMVe0R5kKg5JslLPOxvpauZJW2XRXy1g+UQx
         ju7WhqIT0fFCTegkOvmcKaBXxdN2KiIK9NBhl8p0nhlyORb9POxeI+pasthnk2Nlc3mw
         TYpK+nNHfWJqg3oPjkj3mpDzddCcjhzejRRG5dawSOJH8lZ2/+eJFa+E10NS2OJGsK7t
         CAAt+lRSOsagV7reefNXv0MzW+J2K4wxGWQktaDyWcqLxVEBCHZulZ1ZNYwAzUV9Kl80
         +d8jmY5gzF1JlVBN0zDbq0zNeWiHNMn1oHaPtkD6FyCMLwy8ltOuni1wYfci2+lTdiXe
         OTBg==
X-Forwarded-Encrypted: i=1; AL+hErHnJ4rBuO0qPlgubKggor64ZWAdV2jqKGsajK3WJL7QGQBq/CgeeU0sHaqYNvkRsWjNn1AKVNw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j9tBP9nhc+4N4YRz8pYv90lPArLKmBpC/FejQ2uqNg5v9O5oa
	NIiO6sj6DprgTj/6tGAySW1BwKFL93ebehsAAkaZq/APq/lyxfTiU8CBTN9MfEECsTuNdPmndXI
	AJ2ct9ywkH+fIw+fsihUol+J5MY8weWs=
X-Gm-Gg: AZFdTZfLmeenwAsbEWbaiJRb/OrBQtidzmB9ASMGWAMBgxMTxRGNDso2YZWpsuDOmbt
	wvvrKG5yWxeLeflIa1WGjhORAlY1WSsbtD2/HiAansV1907xQ04JjdQL+LDsF1LsFAZRsuZdg4I
	e3Q2UADmguuUYYNyEFQT0eT6I/byEhx2NFY2Q7pCNy//IlZJ0Ne3kYXlZI+3HqGXQEMdX0+KzPD
	RzpYo3l7gGLhBsBBxWXRnFjIl/yFSTd07Xb/w+KOySisXBqOq8Tha8s5pTKwvxGWsCTIRfGv/5p
	pT6EZGbVGpLyG0Fc31Ctg3WDTCg1J2PMU4b1l315pUMguXUJQiq64MkY3c/s10O49/5ZVsQULFr
	mW2Gjsg3nPC4PNNQXgctW2fX3B/SOlW4OxiQ+HbzgATzSe82/AzWRKXXMyrQ0ggD3aISlEbePdK
	of/kMa4J3xs2fJPeUoMg==
X-Received: by 2002:a05:6214:27ed:b0:921:d0e:3980 with SMTP id
 6a1803df08f44-9212e09d4c6mr6709196d6.13.1795077843795; Thu, 19 Nov 2026
 00:44:03 -0800 (PST)
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
Date: Thu, 19 Nov 2026 03:43:52 -0500
X-Gm-Features: Aa3M54pzdVub43aRWcLLt_mpg_U50pT-PxWG6mqH_aYeoBXAOv6oz8O-dCuo7qY
Message-ID: <CAMcAce9MNLam=t_48M0jQDg36GghfAGs=jX7oAejKdUmdCqj4g@mail.gmail.com>
Subject: [PATCH bpf v3] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: bpf@vger.kernel.org
Cc: security@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

security_release_secctx() invokes release_secctx LSM callbacks
(selinux_release_secctx() and apparmor_release_secctx()), which only
kfree(cp->context) and never sleep. Because the hook is non-blocking,
Netfilter callers legitimately invoke security_release_secctx() under
atomic, RCU, or softirq context:

  1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
     rcu_read_lock() and holds it across ct_seq_show() ->
     ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop().
  2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
     rcu_read_lock() in packet RX softirq and calls
     nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
     calls security_release_secctx(&ctx).
  3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
     allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
     security_release_secctx(&ctx).

Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softirq
context, causing BUG: scheduling while atomic or RCU stalls.

Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
line inspection and live QEMU BPF verifier runs on x86_64 7.4.0-rc3
and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch -> REJECTED post-patch
with -EINVAL, "bpf_lsm_release_secctx is not sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v2 -> v3:
  - Rebase onto current bpf tree (4b4eb7f44ee0) to resolve merge conflict in CI.
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f39a3766f..791dcad12 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -368,7 +368,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)
-BTF_ID(func, bpf_lsm_release_secctx)
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
 BTF_ID(func, bpf_lsm_sb_kern_mount)
-- 
2.43.0
