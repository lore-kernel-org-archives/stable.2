Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072668;
	b=H6LUvmbdb/iKX+QfiYYiIn6oGavnhgrm93sP1WVi3phwpDzJ1dsGdgQdgGk66P3lNN9X
	 f9Q3Fy+SSq87vtnXbAwU1mcb5XCfRf4M79K7ZAkT+RCXbhS1cFfpjVA4n1gDCUIJsa438
	 yD3tv7OkN2+btIOF7b2lMpltRf284mwnbGyRZDNcCAme9MuxsIvhFJtKOR46S9wpQV50V
	 kfH6MJdfmzluhK94JQtVj4i1tt83OSGRxwjRJhSmFkm1pSB9g6D2qtkIOVgxaXOo2hccN
	 DGyFtGpuzQ46uYwEItNHm8GA6p7FTYZh9DTgNpgjaSd0i/nCOMnTn2hKcPBwRPHT22A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
	b=kQ3q3pYE0hTHo3dQpEE6AQnbgUS3LR1Ww4H/vsWNMR3E/6XP04i9sraCiOSTTOkEB85h
	 hk9IvKTIoN4ekCuXlo8IDZEU4985nSu5AjcPbRWAhUrSUW4tqup3MorzImN/2913TtWxz
	 AMpG6aSy/05cZDoKWL8K+pX4u1+/nJyMpE5RwqQy0++xgouuPGp2KSvOGtd8Vk8NTOLS6
	 4uSfTuf11lJ+kyptA4+Hka7v75hH3+rub/re/Urv/IgnOJJmODG7LSNPkOUyqSQ3IAE0z
	 g5GbU0W51NEDdg+Nt3ueXc9v9LRAwjCNrf/jquD8JacrrKBhFNamTTk24tE6NjTWFAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/Sf+wEg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245B606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9245B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/Sf+wEg
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-92123971d1bso6250716d6.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072667; cv=none;
        d=google.com; s=arc-20260327;
        b=AIfVEN0Tq0agE8nETY9OE0eNp25PCEpLXe5omzlebGHAEyjsG/TKPWG7k1lmKcAIBb
         Ul0b8S2PXkzQJ9RgKsUs76HbMCReZDBYPNd3Cw6NENgxibUKQFsWn/wtYOsURW3kRh58
         VTss915UP9YGdLTk450VHzUcd2uGijCAlFmCyLFVqR1i6CQqZ7ZS6P4QUarpmufFzuW4
         cVJfGkqVRc4PhLoZ9p05nuD7S69xrCs4Z8pp7ZGaZO5UVRmr1nhm75yZ73QvM+318Io8
         mAWBxPumA9uh8lduED80bAHEZQFVId3Sl0v+KKR/hHZiur+ZeLEcbPlHuB+WyEX5wmRx
         kPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        fh=5WxRDWRKBKfjkC01uAoPNcT4sYojCHCvybD6psnps30=;
        b=fmja+k92HyyWc6iMIGyCXxIi5PbNskDjNthB5zVnQkt/CSHc+kBu+yzTUysXNID/Po
         5pIpNpjMhWZCKlfFjEG1P4rAtf+zTCgjM5NqcLnjSQSUBHqy5kGn0NHtj3H8Z0uYsWE6
         KTK6GBkI4Aw3BB3KbuMueFJkOFlkGPXjqPykyyJ+taSVHFuj8PZSgxfjKfSHGbbf6w5p
         giZHKblI93wvkbS3GPiChJ69qkbITMK6IhZeDBaBhWTaLvQyRw1B2jEyFwtpt59xOZ5h
         vorRwFSMHfX++SdToe1VMBP4d8LjZd6WH2B5PCvUCaB39wSUIo7tyyJ+jbCQmKcVVa/S
         /2eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072667; x=1795677467; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        b=n/Sf+wEgPISNbMrvTHzlMkwOHpTsjKvZ5pVZsnHdhvqOpu+Kw8ri0ePdTxuNmahNGP
         GJ24w2u8q5mVk6eVwBqHEYNxabqXk2r6Ey7zKqD4qBUGgFeMcM7DqWQEw46WTP2rLUDM
         fqfZ/x0bHOOA0xUf5/fgPfymVRjnKtfZ8Bg+563oVN4ckDSDF0SDCf6wLU1AQd8FbYst
         E8JP9vE3sL/B7XnqU2oEPR5z/0UlHARmli7WvqAQOBfxzi9kmp8VegZhshYNxMKa+pgH
         oarBJeqJgUQIX/1Vg6SAnW7pNGcpgKqkl9lKluAURWLtgMjSpbtP2ZXvM04nwoKmtIE+
         ZVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072667; x=1795677467;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        b=aroBh7WUJgojAQeFSBD4CAgLrTomgWLh0F/qw4Dn2reYBKiLSmA0z9xl6EqT27aRJ9
         LpJ39NNz6BsJVDDD1HvJDy+j4KgTECf9CbjT4iqlvtDK7x5IOumCBQsIqkIZ8OpCFu35
         F/gPuRSIi/GGZei0y3gU3bmxd85MjRav4/1VeQoX2qPUzZHpfNcFpllpmLHBeumPWMbn
         bH9CVZ8oe6vZccMJh7kW+6hkSXFbHKRu8c3I7YpVgWJtPY5o5YC+0AwIdRd5Ymo7kzsj
         Isc5ieDonG/vofP6ZhnXnjvANITYt9dtdndcYsSnQ/UALpllEBXxq+gxciaBGdurAJ8V
         oLgg==
X-Forwarded-Encrypted: i=1; AL+hErGuZhJ+U11hZ2WF47/WTQjbIGD4LGs/TN6AsTnJrVSb6cMFxBYZNGSqAU8VSiz83YRnsZCXYNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WaHqIwkW2jQf5QTaKOvEHXymkdLaS4cLpP5qjuh61Yzo2plOW
	tc4XwYxPSg9ceNVdPUEp3+EUZ+A8ImAizeJEmfkygECmRFhBBjL+8F1Xofg86XlMbg6BvYfPwjd
	HHjLOFP5YqRp4IwuivmhdSIr6565qt98=
X-Gm-Gg: AZFdTZfxGVxGfoChNOV5r4/H/VVXoF9bEx9GPbIWrzbnOurpbV5zNqAl1gxF/r0LD4m
	Jd+jbv3earYeFtw72RFhIEYXtTXw44XUpuE/Cd2G6sZANi8TW3Veuga1QL1ewI8ssUhcuiJ6dis
	sWdyW2Xkh8nbo93Agm09Zot63Fq8T5ietBqWaZZd8k3Yj9eA4sQqld1JDCVx6HqUO4Lec9+E/9i
	3sdHhj9+CpnGehIGDzg22Eu1DI7zNIACF2WCElH9CSll/s+evWHIXd6GDyYMZHrNQjLxr/spXD9
	v/oQrQCx4Fq7huyjVg0wGqyinYXzlKf3M6LB7rA0WBcynaMlLdYwYbx5XRn8FI7e33ALjS8RnoA
	OhPr6AkgdX8dMobm0RysFrKpz76xM++nH1AV04HBENctQHn9JJEpRtPTW0eU952jtTvclYFWNMl
	I+DeOgoZKMvjOGU6z9Lw==
X-Received: by 2002:a05:6214:2e4a:b0:91f:30f8:73a1 with SMTP id
 6a1803df08f44-92114eaa8cfmr76540806d6.14.1795072667347; Wed, 18 Nov 2026
 23:17:47 -0800 (PST)
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
Date: Thu, 19 Nov 2026 02:17:35 -0500
X-Gm-Features: Aa3M54ph_TyDcI-889pWLXWFWWHzO94gu2mhuyfToJ4jckzhN230oQX7LcZtCYU
Message-ID: <CAMcAce-i6XG9vterM-Y9+hwnbGYwPgLNLvDZXsMkW2Kit5j88w@mail.gmail.com>
Subject: [PATCH bpf v2] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
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
line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 468e63d..c7d683e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -368,7 +368,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_path_truncate)
 #endif
 BTF_ID(func, bpf_lsm_read_file)
-BTF_ID(func, bpf_lsm_release_secctx)
 #ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
-- 
2.43.0
