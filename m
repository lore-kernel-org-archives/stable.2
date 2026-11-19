Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069282;
	b=ggU5TlgVkV9ulvKY6IfXXRVwioetGLd3u++/61Ph3XSSY01Ua6vnRgHJMP1wfZf/ToLq
	 RUrpBgBsGDMYub+/hPHG2QpsAD78mPFL/N2fyRkjuIa0nFNKLKWCsyk7KzsRKyCJxSBsd
	 LFtvzm9goa5Guvg9qTX3QfG181tWBWJ+Jwf6aJ8Z9ObYUDTE64WJ/WmpDWGe3JimUZdxX
	 a79xvdcbiD8+g+U4Ieze3GvgcpXR1YGq4SgkmphEMFbo/n7zcPBUHAhoJtfP/mNoeLyKz
	 sYVVZApHwAdW5wl0JUdkEJpCaGYwLwIyzOCCFlMwMHF4XuDaHuwLmkwDhj09dYYFJwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
	b=Scuvln2BErOYfE02jLNqyRSrhaaOJtZN4ObwaFIp7ESHArolsFOyp4cfNHcGaEMYnS6k
	 Kqv+D3nCGmTDeVVDZxurBhLiDRHaD1jkL4vKgr+4YO5EO3gTwYiputAXZwYjQ407bJF84
	 5vMKefrnwS7177WcURZPR41K7Gmj1W9qoHjmGiM+OhW0D4Y8Vq8k0Xcu42vMM4nGfRI99
	 E8IoHRVUOXzyk0lQRNinLq7VTkPpNDxfSQlAz3nmnnLY0PRcXWGmTfW/L4+f1hN73mqtF
	 HGNouHJqAQoMdauJci4Hf7+8IfZNyuMdzBJij80f4YyPiy88FnFqSxaQiUQAM6wjlHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20995606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20995606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-92107df3f13so17019776d6.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069281; cv=none;
        d=google.com; s=arc-20260327;
        b=c7FmKDDSjooZBamvj0gOxmrcPwaGnYfcmPRcJv9iBUU1YYx7rCOinQ5zScpTLBwvSA
         b4Ms3AuO/1QbhTgarc77p/wCUO+zgJkqqW3C65lZAJYaA3/cqEEtEL8FZICnonpm2dXc
         DgEtjQ6yv63YNN7QjgsIx8ZBZFUtcq8i73VgAx839pzVxBzcKqhgkITjwZMCRXP5p/no
         n890Ipf7QJWKN90dY46T89ZU845P7ucuLnbfUGz2U+o4q5CFJII2i3tm4MU/qBqDuiRd
         13btuQZrjDBiICSgd2xPmLbBCORtB7NQt8BHuHj/wvjPr5qP3xbahKK7q7y2x6zFL3uO
         22YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        fh=O00bqr/78iYHGN+O/HuApbQVTI643CZqtN2V10Db9+U=;
        b=cNa9xdb+4PozISB0IjkT7mBJ1OcEgULe8QZ85alArXrYH3dezc4fnYD2bko/T0WNu3
         MXpZetalm8psmTAo3cMo8Sm/kw0YNNOWREf2AX7ZeGI9aR5ee1PEaErvy8vrbV0L/y9m
         prCMSGNuAZ7v/5222JkWPnHOaZLWzVxxFcKy2SSZUm8dUE6BiBbXKRZ8d6c2lanyshXP
         xt5PMQtkJ2BkWHuHB0Zz5L38H/71ax0fc9om7nDMtyUvIGzOvyOwpPlPfsRqjyL9NzJj
         fM2cxUZZGhgh306k4ZlAjYcgE+nwC6HJY2TCRFJhIQPUXNH5RgWlLAXk8FU9pq7rOMi5
         eIjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069281; x=1795674081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=Lc2q2E6aq/619ivYO6N3rLuPF4GGpBYfUThFCLnXePbxSRg8VO6GmEpvXmwK3IB1H0
         EdQBzDmWmk0W+i06F7oQcBQUc6Nb9R6sf9NyPovrLi7PJpo59YUGRLnVoEiFmfDJE1eD
         znQZ94clOnQt09sBYjkAIKoibCtHSbm8FORWqeiPBdy7b2aYJ4rtVxT38BnMiZTJyE61
         ECcuTdghI2R9+T9DjSqp7TJwiuyy7cZECFRYrX3L0CEXZ80DgSCd0Da9i5dezHKbAK9m
         Sy9he5BQ5mpF68GITpvRHpHeQ3NJKgQhdy8iqXgtKdaGScMFryzv0jux06v6A8AfLEW7
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069281; x=1795674081;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=Esw6wX7JGei+MGlEEIwI1r/+rNXjiyRR4hqd7ic3pIBiWSL6YOxakQnjD13IuAbAi+
         hj06XCaCRt89vM6l78xTWfp43H4JZI0Yv1cl7W432f5eb2f0fGAJbuDlVdSQiLGcErSX
         LYwCa47XIpOxDXCpwBU1ORfGxPtNTgjzH4MqL8KprTeLIvOOzE6rlBKBH3FIgLuxrvT3
         6OnoJD3tOUQ2Us5ioXNA503j8Wwa8v1uyO9hIyFCiflEVTpBWeg5KM8+HM8R04MiAj6I
         AY3CBbwh8SiMJfmfwsFwnHumpKBP7QStTjXRKzD741Wl2SzhZc1cUYNV/v1LORpc1ZPb
         /ZuQ==
X-Forwarded-Encrypted: i=1; AL+hErGhUfAFqymocbmbZj/yuuTTEjnGFrR/5VrL6PJ0I3p9pfmk/OPMiDPOE5jG1Pes7px4L7o6g4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B4F7FykC1lqfrgFXMjHCGLePn2Cujkvn/36p703ClM+PztPrD
	l+QnQ1ea4lhdGMQsjuW7P9v2ib7wxgr/QspFXZrWlhQgN/Ur8UR++Y4OwVwIJ/UYRodjGkVsxFP
	YkH+WuaIt0Yl8M3st+AdJgYlUx41Sy/I=
X-Gm-Gg: AZFdTZcpClay4sEl8eHUAAgXv4K/IsujNis4aaXPo/qaG9fzqALW9lFDNSNqBy2Jeyf
	QMXfI7OUiVk0TLwDngfV6KqP5npffmUtxQc+ry9gHlOtXoESBrwRjHdh4k8FsNsWN2k3b31rJru
	AxGSs97MLwvR+ExGw8EOBLbR/1XK9l2L4OIgVCYttP1rA8Z61c7BUUIIUuRulMjGJn11rSuekJl
	NuTfij9NiwDYLUzRng+Vhf/b1GBu4SVsmc1ytlmsP1JemMw/yaKMjUMCir8nACa+PCLoUfbHpKw
	bVYJquLD/EnSRVilC1H7cWsAVrRW/K/S+4LZvm07YWdaGzeuYVHH103EwxqKB1nhmL4vWajoa7q
	soVEf1LnFSZAvtfaIoCDaLMNvmyb0ePIG4VOqpawMnXh6tKGJJo12P+A4cxSpZwyjrja/zSXtGx
	GS+41yz1FxszQyv7ZoxVE=
X-Received: by 2002:a05:6214:8602:b0:921:117d:2e88 with SMTP id
 6a1803df08f44-92114f1258fmr78619116d6.28.1795069280925; Wed, 18 Nov 2026
 22:21:20 -0800 (PST)
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
Date: Thu, 19 Nov 2026 01:21:09 -0500
X-Gm-Features: Aa3M54rKctNstj-xAw2aIWk4fNeHbccByvy8aMtrRliTYHyg6gQPWk7NFTjZLmk
Message-ID: <CAMcAce918POMDvZtF6QbhZMzmf+m49jKGdBEKV2pUi_Y3nn-Ug@mail.gmail.com>
Subject: [PATCH bpf 3/3] bpf: Add missing raw_tp_null_args[] entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: dsterba@suse.com, dhowells@redhat.com, pc@manguebit.org, 
	idryomov@gmail.com, linux-btrfs@vger.kernel.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Four built-in filesystem tracepoints pass NULL pointer arguments without
corresponding PTR_MAYBE_NULL masks in raw_tp_null_args[]:

  1. btrfs_prelim_ref_insert (include/trace/events/btrfs.h:2878):
     fs/btrfs/backref.c:328 passes literal NULL for arg 2 (newref),
     and TP_fast_assign (:2856) checks newref ? newref->count : 0.
     Add { "btrfs_prelim_ref_insert", 0x100 }. (Also affects 6.12.y.)

  2. cachefiles_no_space (include/trace/events/cachefiles.h:718):
     fs/cachefiles/namei.c:122 passes literal NULL for arg 0 (obj),
     and TP_fast_assign (:729) checks obj ? obj->debug_id : 0.
     Add { "cachefiles_no_space", 0x1 }.

  3. netfs_failure (include/trace/events/netfs.h:413):
     raw_tp_null_args[] currently lists 0x10 (arg 1, sreq only), while
     fs/netfs/buffered_read.c:790 calls trace_netfs_failure(NULL, NULL,
     ret, netfs_fail_check_write_begin), passing literal NULL for arg 0
     (rreq) as well. Update mask to 0x11. (Also affects 6.12.y.)

  4. ceph_mdsc_suspend_request (include/trace/events/ceph.h:89):
     fs/ceph/mds_client.c:3691,3726,3749 invoke
     trace_ceph_mdsc_suspend_request(mdsc, session, req, ...) with
     session == NULL (arg 1), and TP_fast_assign (:107) checks
     session ? session->s_mds : -1. Add { "ceph_mdsc_suspend_request", 0x10 }.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84, all 4 tracepoints
flip LOADED -> REJECTED) and 6.12.118 (btrfs_prelim_ref_insert and
netfs_failure flip LOADED -> REJECTED; cachefiles_no_space and
ceph_mdsc_suspend_request are post-6.12 tracepoints).

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef10af2..30be05b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7274,6 +7274,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "afs_make_fs_call2", 0x10 },
  { "afs_protocol_error", 0x1 },
  { "afs_flock_ev", 0x10 },
+ /* btrfs */
+ { "btrfs_prelim_ref_insert", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  { "cachefiles_unlink", 0x1 },
@@ -7284,6 +7286,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "cachefiles_mark_inactive", 0x1 },
  { "cachefiles_vfs_error", 0x1 },
  { "cachefiles_io_error", 0x1 },
+ { "cachefiles_no_space", 0x1 },
  /* ext4, from ext4__mballoc event class */
  { "ext4_mballoc_discard", 0x10 },
  { "ext4_mballoc_free", 0x10 },
@@ -7314,7 +7317,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* .. from mm_page event class */
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
- { "netfs_failure", 0x10 },
+ { "netfs_failure", 0x11 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
@@ -7416,6 +7419,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
  { "pnfs_mds_fallback_write_pagelist", 0x10000 },
+ /* ceph */
+ { "ceph_mdsc_suspend_request", 0x10 },
  /* coda */
  { "coda_dec_pic_run", 0x10 },
  { "coda_dec_pic_done", 0x10 },
