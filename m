Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118768;
	b=SJGaBl70xsukdIGv4XpfOCtQ6dydtx1+lTr70ztm83g1+pOURyI4Hj8CaDCsDjKOis10
	 OgC1xLvYDUfsW2UDo2ChcETmI2cHIG5nV+bEjrEnxNWQGoRxGrHf8VVBjC522H5ieJnOO
	 cnWy/IqWkinDWNDci+nDCK2WHQXVybH0lX6iixWiTWI6xodrHCeKO3k6U/cMI6prDWg7k
	 vkUuIqczNWgIf/NHmoAxQPlr4OyNvJPzILLX9EqDcXXl5uyK3UXhmZ0rfcsMXdWjpjLuE
	 3A6+SUTJ3Bapg1FbE/Z6H12pG/FpH9q4q9Rm3wr53zgphseT2RLPEyg0ji1x3VRIWSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
	b=KiuKJcO6cUMpnXPaxbXI8YebbywD185ycC8yAyy9rZfKe+4zHwF9zqcVrH2kzsq6HOOp
	 9A57wuy02P3yTUjQFzfFyjuHXcRl5zBQEdqnXxf6ckM7XHOqcq4PsHGD3djkOlE37duPD
	 r7u9K0VXA98i+THJyFY2wV/hofn12q04kCsb9TjEISVI9zmzYfH4DplxlOotoIBeJXiRf
	 BPco8Z892QJDazRL8iA0l3vaTs/Y+bhiIJ4vMbYyZshtyPvEiUJG8W9NeSG5JwYA6GwpW
	 GhT9ItYhAUJ3qhAp8/Oz0VYSRJfuHi1ugTuF1Wtw6x5aG4cqnGEqYsePWFOfAyAk8LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i5FKy7D9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E542606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E542606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i5FKy7D9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d05d51553so645265e9.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795118767; x=1795723567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
        b=i5FKy7D964BfjAdJgIebywXm3KuFBLrbOHdcrg67FFdQMxJr6LCXKWohX2mIVC4nUx
         NDokibE7OyCW96aRrOjMVTQ4nEbY8iviGJE0cjNn+De1uokrRlY1EDvzEfdmHGooJL+t
         +Bfi8Le3ffx1KGDa2Uf7d0yiavIQSbctbzI3Je6/uceNyTCFhf2LcB38l4LMuOk2gsa+
         Ih1P1y1LbBwRk4Wm60SYup6yRcULhFzL1av1HmlsOg4CQ5W1loVNOlCZ+16QxCQe3J+D
         MpPHZ3lVWUbK7BjLL5muOEUxihI9eHkwK+tg8x9vuEfoU/yO21op8Fpn+n5AAPS9i/1U
         eDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118767; x=1795723567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
        b=Nj7+6dx/7I6WW58TVIVGFxFZ/y6WD1MeXtmUNJr/F+qqZq8vj39Do5GPjULd5USivm
         /UiRiWldaYCZN+wlRlOCQbAJ8f64DJaLP4fcl9MbANlcSz9baxh35nYI/Tr6lby36Yv1
         nHHywkA9Sq7bo9RWFHBEnIS47kgkgDHLBr499j7Kug0W/IfH7AENcAx7xCkCyjmRag/r
         UCpa9e6IGHPd8WFPjIHg2E9SOv1aD7OA9xQebVnTybWdHczOr6laFUYdHWeacyMQtIp0
         O35GBP9ZR2wCbbJL3XxhvFFhty5Di1Q3oxx07EObuYlWCYubwaiyrQJTPKhTlS0LFF81
         mHGw==
X-Forwarded-Encrypted: i=1; AL+hErFSMIKdesIs8XaYjqJFq4r+5G1AEbWv72TkC3J0wN6wyricMipG5mWe28RtLWK4Bl+J6ywvaZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jqKWnQz2v0V4ARL3DgF3FjDII1iwQ/RQMMMHd1lYP/uC5ugnw
	MeMHNH9hpv432gBu+l///7c0AnSBleJvmwyJTu8UXkiCflQtqU8mDIQD
X-Gm-Gg: AYBFou01u4dw6oIYVUgJn284OSsuTDg2lwQ75gd0t6jIQzH28Cbbu6hBmnMAOM0g9eE
	8syMmgXYx/9MgJa0fPc5ivSUehIfsSOXU3p/A6XbEwPiplRr8jct0k0Zf0xQZESHFv2zeCPtSWA
	+gfvwIDmHrGW7l9whUIBLjHJIjnC4ie6tI31vywLQYyqmmfHP3BDkUMPMzBCuCsZpWNwrtxqOQI
	y6QzV9RMB6q7y5YJLzYIyuF7wywnIeF7Fk32YwyEPXHMy1rI+jE/wJELDu3EhBkfqy7NS8lBw+N
	6hzPP7768uUKy/Oco2w2czvqKsEkmICChQCGWbYDu+eOX4xXu8DyGuyuIsBilCBZm648b2VjrmA
	hnE1MjL+ZfAN+uuxOL0VD5PaGGpZxrwEy9hervM1zeEbCn+1kbHFscSBR3qD4rJzMD9J84KesbL
	lpgw1hkVMDZ1SD1omMAx3h94IfbqcmaNwxmCNy6pu2btoP5SiRe8tg4e/knoymIw7gpwondO1i4
	B9wkVZ3YW0PgyUq6uNvtkCrez0dXd0hQm4HUlsEPq5X8C75qjXoLQ/+PBrRNwhXpw5vyAsBMW0H
	+MLafkbbkSYUpD1YerHF4dwAJCmgyNV16Zo1pGg=
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr9548745e9.26.1795118766499;
        Thu, 19 Nov 2026 12:06:06 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm58151335e9.5.2026.11.19.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:06:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 21:06:04 +0100
To: Yingke Xiao <inkxiao12@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	anna@kernel.org, linux-nfs@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/3] bpf: Fix missing raw_tp_null_args masks for
 NFS and pNFS
Message-ID: <av9WrAhA4skgo5JQ@krava>
References: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>

On Thu, Nov 19, 2026 at 02:20:29AM -0500, Yingke Xiao wrote:
> Several NFS client and pNFS layout driver tracepoints pass literal NULL
> or conditionally NULL pointers for struct inode, rpc_task, or struct
> pnfs_layout_hdr:
> 
>   1. nfs4_xdr_badoperation (fs/nfs/nfs4xdr.c:981) passes NULL for arg 2
>      (const struct rpc_task *task) when decoding compound replies outside
>      RPC task context.
>   2. nfs4_set_delegation (fs/nfs/delegation.c:380) passes NULL for arg 1
>      (const struct inode *inode) when stateid refers to an unlinked file.
>   3. pnfs_update_layout (fs/nfs/pnfs.c:1980) passes NULL for arg 4
>      (const struct pnfs_layout_hdr *lo) during first-time allocation.
> 
> Add mask entries to raw_tp_null_args[] so the verifier marks these
> arguments as PTR_MAYBE_NULL instead of assuming non-null pointers.
> Verified on x86_64 7.4.0-rc3 and 6.12.118 LTS.
> 
> Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> Cc: stable@vger.kernel.org # 6.12+
> Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>

besides being mangled patches 2 and 3 do not make sense

  ▎ Patches 2 and 3 are wrong: nfs4_xdr_badoperation, fsnotify_destroy_event
  ▎ and vfs_open are not tracepoints (the closest real one is
  ▎ nfs4_xdr_bad_operation, with no pointer arg 2), nfs4_set_delegation's
  ▎ arg 1 is fmode_t and the inode is never NULL there, and
  ▎ pnfs_update_layout is already listed with 0x10000 for 'lo', while the
  ▎ new 0x1000 marks the iomode enum. The cited source lines don't match
  ▎ the descriptions either. Please drop 2 and 3.

jirka

> ---
> v1 -> v2:
>   - Correct sender identity and Signed-off-by with real legal name per DCO.
>   - Remove drafting notes.
>   - No functional code changes.
> 
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b234567..c345678 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6607,6 +6607,9 @@ static const struct bpf_raw_tp_null_args
> raw_tp_null_args[] = {
>   { "fsnotify_bump_event_seq", 0x20 },
>   { "nfs4_cb_getattr", 0x200 },
>   { "nfs4_cb_recall", 0x200 },
> + { "nfs4_xdr_badoperation", 0x200 },
> + { "nfs4_set_delegation", 0x20 },
> + { "pnfs_update_layout", 0x1000 },
>   { "nilfs2_transaction_entry", 0x4 },
>   { "iptfs_first_dequeue", 0x1000 },
>   { "iptfs_first_fragmenting", 0x1000 },
> -- 
> 2.43.0
> 
