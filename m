Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00C388891
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934368; cv=none; b=FS/WZlkMx+VnPl3gN0llBR/QpyzPsdFt39qpx5RtUWUqEWrBQIMqXuzNG7nD0+4A/v3hqAGMtsthZg6E4c84C7bsR/5eSG1YgYjcVPTtrDvDOoU9SzDbSXiHSpHn/MlaWK54nGyyxujs67p5OXOP9bLxik84ZhN6DvWTjEXCh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934368; c=relaxed/simple;
	bh=Sk2J6KuMqrEC54wXJzOQQo5vuletwOAu0o8nL5wSogc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV/6nwfIThnoWWpdfRlBG1WD+JjDT9z9pAC9tujRk1OPknssmF8Zuvu14YJ6Zzl89C0Ej3hud5KPM7qRA6roHaJ5LV70u4i1xwVPQyXv5zdRZuFxzwn0yqmVEPV0cmDk3OrplFKNHbv5ZQvg5qkT9SOyIXmWjuduqnk377b+dTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTDmOuy6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTDmOuy6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1250172a91.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784934366; x=1785539166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4HzP5T/bb9vCcchtoI3sk5UhcPvmVAetGanQAVZDHE=;
        b=VTDmOuy67MofZF/2hrkpsyKz+lc+Suj/njuv+GUCKuE5PEOwW0HE9dIvBcNEM4WGJz
         TzvUCUPj9z35w410HyjrR7EGbtl2bnQxmk6/se8kVd4eAzRqZLN05vyFE3jVN8sBdlCg
         dBecPsQAzxXWkyfvFg1eB6YMW2WijWMCgb3lt6r7k2wE4ALPqopHl0GdO1lpj/oOL92t
         3z0JwR+1iFeaqusyNOhfr1s/5FOycgHMJR8rLH9wWTKw+/DgiAWUkA+bp7lFkkBiQe8P
         cmj97UZPnHH+pY3DDJO+7TjR+y+fGVaE3U+0Q0bw+9a7r1uzSQrgZMCimRUm66qPlTu7
         e4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784934366; x=1785539166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4HzP5T/bb9vCcchtoI3sk5UhcPvmVAetGanQAVZDHE=;
        b=TdStczRlvNRt8OBGvfWDI1Ayw/UdaQkQs06hUUjvsfPFrRb5gRCYHnLAppXVQ2Ctnj
         pBz79Qh6J5qvSHCNdnDsICojUynr4IiqQfl4sBu1NrDDgkOsYAC1pU1qAUhVqmrHRZBF
         OJIT3sN9LX7zi19pGosRy69IM7leMwyMVNwl7PHm3qHnRHdonMaasKu6LnGx8yDUBzyi
         RDb0Ey+NATdIch0kIfZr2HjhYSndo2WBF7SS758OTAcI/AdPz+tvENkTsT6l91fs2fW3
         9+36q/+ZGnAny3dHsFO+o/ZGgXucaGs4na/DRLcjDVTVcevMpghNf2Gl4oOo10xdcc1/
         fKUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAKW9yDuNFs8sPXGvXKw+GTe4VtITwiWx3Hso4cm0qAsmp5JxFJfqMOjRs6A8PmkIE+nydI4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJL7MRnExT1JwHrlpkGTjo7R2j+cbLdIGPU3jZc3TNxaN3dSO
	DICPQw47bCEGoccJTxkWLlwAayyiJpuUIizVKvHA4FPu5Wl4HLU8dfYz
X-Gm-Gg: AR+sD1114720YuRl7u4UXCFnKbB7YFHWn9V9Nt7qH8dK3XdjN0IpAXHAG3w+PdS+EAn
	VPhDykDJqZTAhaUdThMRCClk3ybSmCezw6o8EKSeTGVH2CnJviUuUUNK0ZPnxpDir5eKdLlmNh6
	JEZvPztk3AKO9jc+6U8nKCIGM5s8Cez0+KecY+4/+1NMi3jTJoc7gVheiLHqAhIHHKOMTDi8dNb
	Fef73dlYjrmxJxTfX4UpNsMrWARB8zkI3x3oO0O1OIneoEEfhdZ22pAVjKcgXCPZPI7U1ebc2ho
	qyfg5Rw+RC7W79HkJWTg0BX4ZH1PkbwOXHk6fW47vTKXRWWxt9nR0YYUBsRre6cz4y5GgyNAGxI
	9JxL+ZAkO8F34trhjPlm2HgIcfzOivuUBmBzASoT+zR+tBVmbNx+7CGXa3Wqx6mhAOR/xogf3Nq
	z2
X-Received: by 2002:a17:90b:2604:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38f297802c7mr303421a91.30.1784934366563;
        Fri, 24 Jul 2026 16:06:06 -0700 (PDT)
Received: from john-p8 ([98.97.42.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951e62fsm121717a91.14.2026.07.24.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:06:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:06:03 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] bpf, sockmap: Fix sk_redir use-after-free in send verdict
Message-ID: <amPvZHwUL5HlY0t0@john-p8>
References: <20260719152207.2892156-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260719152207.2892156-1-nicoyip.dev@gmail.com>

On Sun, Jul 19, 2026 at 11:22:07PM +0800, Chengfeng Ye wrote:
>sk_psock_msg_verdict() takes a socket reference for psock->sk_redir.
>tcp_bpf_send_verdict() copies that pointer while holding the source socket
>lock, but does not take a reference for the local copy before dropping the
>lock around tcp_bpf_sendmsg_redir().
>
>When apply_bytes keeps the cached verdict active, another sendmsg() on the
>same source socket can consume the remaining bytes and release the cached
>reference while the first thread still holds only the raw local pointer:
>
>  CPU 0                                  CPU 1
>  sk_redir = psock->sk_redir
>  apply_bytes remains nonzero
>  release_sock(sk)
>                                         lock_sock(sk)
>                                         apply_bytes reaches zero
>                                         psock->sk_redir = NULL
>                                         release_sock(sk)
>                                         tcp_bpf_sendmsg_redir(sk_redir)
>                                         sock_put(sk_redir)
>  tcp_bpf_sendmsg_redir(sk_redir)
>
>The final sock_put() can free sk_redir before CPU 0 dereferences it.
>
>KASAN reported:
>
>  BUG: KASAN: slab-use-after-free in tcp_bpf_sendmsg_redir+0xf39/0x1020
>  Read of size 8 at addr ffff888108537090 by task poc/87
>  Call Trace:
>   tcp_bpf_sendmsg_redir+0xf39/0x1020
>   tcp_bpf_sendmsg+0x977/0x1a50
>   __sys_sendto+0x32c/0x3a0
>   __x64_sys_sendto+0xdb/0x1b0
>  Allocated by task 85:
>   sk_prot_alloc+0x56/0x210
>   sk_clone+0x6f/0x14b0
>   inet_csk_clone_lock+0x24/0x740
>   tcp_create_openreq_child+0x25/0x2710
>   tcp_v4_syn_recv_sock+0x10a/0xe00
>  Freed by task 0:
>   __kasan_slab_free+0x43/0x70
>   slab_free_after_rcu_debug+0xa6/0x1e0
>   rcu_core+0x50a/0x1850
>  Last potentially related work creation:
>   __sk_destruct+0x3da/0x540
>   sk_psock_destroy+0x81e/0xab0
>   process_one_work+0x63a/0x1070
>
>Take a temporary socket reference while the source socket lock still
>protects psock->sk_redir, and drop it after tcp_bpf_sendmsg_redir()
>returns.  This keeps each unlocked use independent of cached-verdict
>ownership.
>
>Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>---

Nice catch.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
