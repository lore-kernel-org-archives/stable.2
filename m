Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118752;
	b=IBho1sbzUqycCjepN+MmBOeShLdIY/2/9/c6iPZ4EfXX+ATyvmYQp28jxv47aNTb1pl6
	 wcMm3g2NZkC96SgFAP3H4mfUxvdQSJJcwWX1MF0waIbFCkY2sh00Ddn5AWtKdMSVD7Vmi
	 k7/uE1e4RsCUrmWUZU801O9rhgH4KS1lrY9JKo7SkJU+PTTT5YnSLF1lBiVa8XgPazKXH
	 +YRdwHZAycSf9L8a5gPlbELeJRVMXRsG5p+E/R6URZaliAgg7GPoT+ZBiqucQEOPH4kox
	 1hEQ94yZw8F6mXJNGv0nipxDQDm8o4II26A59FvNXM7nH3JQ8uuONnfuYOoMJ2v61Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
	b=GXdAuaqUYlKjwbB2PefBxOGJyIOv5zpkEOo/mVpcDdEZsSl1Dhv6JZj9j92QenJLbH4X
	 PeiGAbHtxnGSLmDwF6SO3eW0z4UOca6NT/GkjRla6U7hc2zL6ZLJyGSqHTQu09Kx0iG4G
	 cup0fefXVp+e5LZqQeSkr+3XAtxsk1fsCCZxZpHnLqO86aeKpzMxPdYNJFQlJjWrcGbLb
	 gvkThmv0OWA2k6R5cjxs20AeIiAZvkY6ReCI6hx9ft69J+R7F/CstJmmIwketHzZCgJdl
	 Q9PzMsI6Gj0GXmuUvFYtE5Jo0vPM9K7ny/kyDeMEd9rGTdP6AeZQaYqBBARNoQsJI5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8kap+ui;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118F606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9118F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8kap+ui
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso1234675e9.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795118750; x=1795723550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
        b=U8kap+uiMZ33ZZ7fx3ualzidBqymKwK1L+aYTWKFPrQdqccOtZLLGbr5/LBFP6Ry83
         7Y93SNsln6Fbf+K8GJHPn8iYNAK8PAbHPbrZkhp3bbpPul7MXXJNjDuEVyL0s7Xdm9KB
         ugPt9d6PP/fSws8kfJLYG3bZtDhSD+aFVZ7t6e4C1XvkRKD962qnZeQEJo36cqsBkZBx
         QaWqBC5VHKG/iDQWqlOgIXeb+4SsDudqOTBkYTqqJV9IkCf02pnu+xW1b1Mte4OO1qfQ
         +OzXdUMRH31yEHgOBDXoiu/H57ArVbXCbnNv58mZE9PQKYtD8lS/VBC0aNTSWRCn8pUl
         pGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118750; x=1795723550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
        b=AjKmfZkDfa1VMfl11e8CJnT8VfSP4M1rIXqhJ6Yl50Q4F9jX4mhzBvtOVSfUu5tnfb
         wjkHDnwqTvs6xzEi+6N65UqQwRMY0yzhmhCp7oRtlIrKHHm1Zy80Rt9ZypOf9jpYiVuP
         IE2qEEoBOa2ySI6quKSmsOGZ2DC+PWLowqm8eVpj3tM3OyggLyjClRoUK4X1HcC4YQaz
         5FpzufFwwZpzjB21YGr7DdD2P6xI4QesT247JRpbGxFsvvw6OCAFZq9UcjQ6nAHz0vHE
         7kKQlQ8swFGh7dE3xejRwlyixR+7DusyGqeCzGjyX1COvRa23Gpo4Cp62yVC8LXFX/Ou
         im4g==
X-Forwarded-Encrypted: i=1; AL+hErF3mwCm+Fue5BKwZAtjMlBi8bKyCfDRs1E8yya741ilPRu6vuw/qOvQ3jZRGOYgcUZlCKr8hDM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xqjfYr/S6iHjthBOqq2ZESRvr9wCXjidx/d2ss39txCikXGT7
	S+eRbCiKYzya6YfB/p4ZzL6aRavJ4JUZv7yQCblmBRSYNlnnhutl+9CL
X-Gm-Gg: AYBFou3XYLnh7RM0syPYkpxnXYdFtMNwyT33H3Nwj/7gSrtKxL0Fuh9+hxEvrLo45a8
	UY5OykZsx2Sck4oAJ8czYJvSTDO1wQ7XFKAdwhtQVghmB/WhG+cB2J94exWXN9Z8oGkq/vDx4cN
	t8JA36GKVU349DmNTd4jJ8LXWi4gEBJAwGZNT6Vu9qptNLz51uutpnmzTExX1dEq1JMyIjFf81S
	l4YtNsxOR28tHwHxtWpwJK60fLUdXOR6ikmTCt+LQiZRfi0JIxV398oTpZafIB+KykxjCDwyk9I
	ZRVujaDIOkySwcTW/0Z6hgYU4hQiMZ8Gdd17N3HyEkd8zJZNDSg0Bc1o8PTQz9/7FdW2NmX3y+a
	peWcDHQu5ixTsqjh2+miufX0m0QEFYXJBP6nQc2ofYMwawg4tqv5r21G6QCjPAMuhBvdJygUVDX
	dwaGzWLAHLtjDGmKLdOikljVuLgWfPlGIr/KaUe2m9u6izW3SbrFc6dJP9yAsomNgcZFcqIPUcm
	yAdPz1Oh/uojc8nzl+gAedh0H+EwiejDnZCqijU4HFx/YoPaQPMG2VUC42y0KVYs4ACzCCYrqZ8
	OMXiBWTxgavaefmm
X-Received: by 2002:a05:600c:3f0a:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb8880cde7mr12400535e9.22.1795118749858;
        Thu, 19 Nov 2026 12:05:49 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm20190405e9.8.2026.11.19.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:05:49 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 21:05:47 +0100
To: Yingke Xiao <inkxiao12@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	anna@kernel.org, linux-nfs@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in
 raw_tp_null_args[]
Message-ID: <av9Wm6HQ-DIgFhfw@krava>
References: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
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
In-Reply-To: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>

On Thu, Nov 19, 2026 at 02:18:29AM -0500, Yingke Xiao wrote:
> btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
> and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
> each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
> rather than its DECLARE_EVENT_CLASS() template, three existing entries
> in raw_tp_null_args[] never match any program:
> 
>   1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event"
>      are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
>      DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
>      nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
>      NULL for arg 2 (const struct inode *inode), and TP_fast_assign
>      (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
>      (0x2ULL << (2 * 4)) sets ptr_err_raw_tp = true so btf_ctx_access()
>      assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
>      even under if (inode) and matching existing raw_tp_null_args[]
>      0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).
> 
>   2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
>      net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
>      are iptfs_first_dequeue, iptfs_first_fragmenting,
>      iptfs_first_final_fragment, and iptfs_first_toobig.
>      net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
>      (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).
> 
> Replace these dead template names with their DEFINE_EVENT tracepoints.
> Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
> final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
> REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
> REJECTED; iptfs_first_* absent in 6.12).
> 
> Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
> Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
> ---
> v1 -> v2:
>   - Correct sender identity and Signed-off-by with real legal name per DCO.
>   - Remove drafting notes.
>   - No functional code changes.
> 
>  kernel/bpf/btf.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

patch is mangled/broken, can't apply it (check Documentation/process/email-clients.rst)

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a123456..b234567 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
> raw_tp_null_args[] = {
>   { "bcache_journal_entry_close", 0x20 },
>   { "bch2_journal_entry_close", 0x20 },
>   { "fsnotify_bump_event_seq", 0x20 },
> - { "nfs4_inode_callback_event", 0x200 },
> - { "nfs4_inode_stateid_callback_event", 0x200 },
> + { "nfs4_cb_getattr", 0x200 },
> + { "nfs4_cb_recall", 0x200 },

seems correct

>   { "nilfs2_transaction_entry", 0x4 },
> - { "iptfs_ingress_postq_event", 0x1000 },
> + { "iptfs_first_dequeue", 0x1000 },
> + { "iptfs_first_fragmenting", 0x1000 },
> + { "iptfs_first_final_fragment", 0x1000 },
> + { "iptfs_first_toobig", 0x1000 },

llm says:

  ▎ Only iptfs_first_fragmenting and iptfs_first_final_fragment pass NULL
  ▎ for iph (net/xfrm/xfrm_iptfs.c:2024, :2050). iptfs_first_dequeue and
  ▎ iptfs_first_toobig always pass ip_hdr(skb). Since the old class entry
  ▎ never matched, adding those two would start rejecting existing
  ▎ programs that use iph without a NULL check, even though it can't be
  ▎ NULL there. Should we add only the two NULL-passing events?

jirka

>  };
> 
>  static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entry,
> -- 
> 2.43.0
> 
