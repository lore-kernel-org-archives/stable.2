Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5D2D8DBB;
	Sat, 25 Jul 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784959754; cv=none; b=EhaVPWKkeMxMjp8w8H65RkCqAaFqxm09708/rSxe6cfd5gvsIlFEIbsqWqq1et+LeJ4vSA9XyBzh1+Ln5AhypB94+TzrOaY5MXGKXPg2GZ9Xh3q+vWzUpgTjCQ56N9WjPNetDRbRoNWyknADnpujje8HVhkiJLf1ksqOtliBq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784959754; c=relaxed/simple;
	bh=C0cYxrITXcn/H448tLJH7tlW63Htb/xQhKKBpitRExU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sceobz7kGOi+qh0bn2SPLB710l6DZW625wwSQ3wZcTKu8Bxz6kPUy1yKSnZTTO4ZFG6DYD875L/CutFVlGn0xEl0mJyncEtuk5FxplbmQfCh920O13BqDJE3hsiJLpqBbc1XkcEXgcLffwCMXzP/MnhdYxcen9J/XdSiO1IQnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhCWfux0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhCWfux0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB31F000E9;
	Sat, 25 Jul 2026 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784959752;
	bh=vl9av0su70QDbnSyvpjOuNyucyKSdvo8XYRSG+4fbSg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BhCWfux07qWs+GRyYGHTSjdj1psv4QW+pesi8eLe8vWEnGpt52sV3iPdMo+RYVMse
	 PtTokGMcZJ3sz8nBSEgMBl+6icrsRU71F56jXujKjTtxvtyECWu8ZMgIEa5wyH+Qbx
	 3BxcmvKwBCBlysRS17Z4R6NHXUYRizndAyTzjp0A24n1K27nQnQ33nbcbiyWFzau0I
	 vTQ832TCUuBh13ifOmno+obmU8Mw9AF1KaVla39gvsQ4h4qychNVyzZZ2VZWXsmgDY
	 It5yCQiIgo743KhKNnMWThuBoIn9cVXHH3n5hay/vjAmzRLGtwI1CQXLN8/0lVhGUB
	 Kqe+i7OWbAtEg==
Content-Type: multipart/mixed; boundary="===============0332709161616845450=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6bf45c1a019d55ff4558d946fd4ab478536f670d804ff9e1b3613556dc441f0a@mail.kernel.org>
In-Reply-To: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
References: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
From: bot+bpf-ci@kernel.org
To: nicoyip.dev@gmail.com,emil@etsalapatis.com,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,nicoyip.dev@gmail.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 25 Jul 2026 06:09:10 +0000 (UTC)

--===============0332709161616845450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..fcf535b7a754 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -401,7 +401,9 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  }
>
>  static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> -				struct sk_msg *msg, int *copied, int flags)
> +				struct sk_msg *msg, int *copied,
> +				u32 msg_copied, bool *corked,
> +				int flags)
>  {
>  	bool cork = false, enospc = sk_msg_full(msg), redir_ingress;
>  	struct sock *sk_redir;
> @@ -428,12 +430,18 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			psock->cork = kzalloc_obj(*psock->cork,
>  						  GFP_ATOMIC | __GFP_NOWARN);
>  			if (!psock->cork) {
> -				sk_msg_free(sk, msg);
> -				*copied = 0;
> +				int free;
> +
> +				psock->cork_bytes = 0;
> +				free = sk_msg_free(sk, msg);
> +				*copied -= min_t(u32, msg_copied, free);
>  				return -ENOMEM;
>  			}
>  		}
> -		memcpy(psock->cork, msg, sizeof(*msg));
> +		if (psock->cork != msg) {
> +			sk_msg_xfer_full(psock->cork, msg);
> +			*corked = true;
> +		}
>  		return 0;
>  	}
>
> @@ -480,14 +488,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  		if (unlikely(ret < 0)) {
>  			int free = sk_msg_free(sk, msg);
>
> -			if (!cork)
> +			if (cork)
> +				*copied -= min_t(u32, msg_copied, free);
> +			else
>  				*copied -= free;
>  		}
>  		if (cork) {
>  			sk_msg_free(sk, msg);
>  			kfree(msg);
>  			msg = NULL;
> -			ret = 0;
>  		}
>  		break;
>  	case __SK_DROP:
> @@ -519,6 +528,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	struct sk_msg tmp, *msg_tx = NULL;
>  	int copied = 0, err = 0, ret = 0;
>  	struct sk_psock *psock;
> +	u32 msg_copied = 0;
>  	long timeo;
>  	int flags;
>
> @@ -545,9 +555,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  		if (!sk_stream_memory_free(sk))
>  			goto wait_for_sndbuf;
>  		if (psock->cork) {
> +			if (msg_tx != psock->cork)
> +				msg_copied = 0;
>  			msg_tx = psock->cork;
>  		} else {
>  			msg_tx = &tmp;
> +			msg_copied = 0;
>  			sk_msg_init(msg_tx);
>  		}
>
> @@ -580,21 +595,23 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			psock->cork_bytes = 0;
>  		}
>
> -		err = tcp_bpf_send_verdict(sk, psock, msg_tx, &copied, flags);
> +		err = tcp_bpf_send_verdict(sk, psock, msg_tx, &copied,
> +					   msg_copied, &corked, flags);
>  		if (unlikely(err < 0))
>  			goto out_err;
> +		if (corked)
> +			msg_tx = psock->cork;
>  		continue;

This patch folds several distinct changes into one: the stale-cork
use-after-free fix at the common exit, a cork_bytes reset on the cork
allocation failure path, the new msg_copied accounting for the failure
paths, the switch from memcpy() to sk_msg_xfer_full() for the cork
transfer, and iterator error propagation via err = ret.

The upstream discussion suggested fixing one issue at a time rather than
combining several fixes in a single patch:

  https://lore.kernel.org/bpf/87ldb0lo8t.fsf@cloudflare.com/

Would it be clearer to split these into separate patches?  A minimal
single-fix version addressing just the use-after-free was posted afterwards
and was the form that landed (commit 2d66a033864e).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30145850605
--===============0332709161616845450==--
