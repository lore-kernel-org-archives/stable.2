Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEC35C19D;
	Tue,  9 Jun 2026 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974035; cv=none; b=VaPZKIgja3GsSfUO3lX5hijqMzoTAomnioVmg/ixITiTevuKtakjB//YwArS6A50npD4r2h+jEMeplo2I+wOd+cWUbLgjWDAU55knBsIIimK+RhGLlvjR1fgKaaUh5JCWEXRGdrlBFxkVHaUR4mA29Y7QRja0wjGgKWTm4jMddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974035; c=relaxed/simple;
	bh=w2IONcZz6GFVawr6IJKBO6g4w1I6f6O99KDEPG18iwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPRWEhwdZFB1K5OYKed3oAaFWaEwENDUmxNDJwPU4NvIMxLoaUGcmt3xxgdyf6qtxbL+NihEgTa4u6IjGy69vIJlQ3uqW0uYecr22Q5UhKJT4DEVZd9ni9eXYl+Go7zMZXf9mVVabGzq/qeI1BdgpJoJD6unpjHIlpRoVjfBfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3XTeKCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3XTeKCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D41F00893;
	Tue,  9 Jun 2026 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780974033;
	bh=kqwNYo+45Cub0sZIpNMFbKfZt255D44xOYeenrcLOTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m3XTeKCsAIPpgmTtMkIYkCPqqLxE3ex/RbqkA1p0E42VR6veGci7+B1t0qtM15gfN
	 VrpCvpjvtYsB0j/cULwJOJsWmNi2B6GsCp9LVrwS19dgIP6BlOFaf4dSXHBFWOSSIW
	 BVpKB2glK629fcZjPgo3bgBmYhlEiTH71ueqKNSzDc7Nd86bpiRMMMr+Nfvns+wDAs
	 Ydm6BRjGM7iqQ88Ynp6sTW06Wj3p8RA20YCDycayA4q5YrEZ2XzVIujkZl7bFxtVkV
	 N9KTC0SAb/XatWTu7oy1tq843JbaJSX9YTUG+mKc+Mxu2GLtKby+wM0KD2CeKGcNWQ
	 L8x5kZKNf6Syg==
Date: Mon, 8 Jun 2026 20:00:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yiming Qian <yimingqian591@gmail.com>
Cc: security@kernel.org, John Fastabend <john.fastabend@gmail.com>, Jakub
 Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, keenanat2000@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/tls: preserve sk_msg sg.copy when splitting
 records
Message-ID: <20260608200032.77aebf5c@kernel.org>
In-Reply-To: <20260604134019.39161-1-yimingqian591@gmail.com>
References: <20260604134019.39161-1-yimingqian591@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 13:40:11 +0000 Yiming Qian wrote:
> tls_split_open_record() copies scatterlist entries from the current
> plaintext sk_msg into a newly allocated plaintext sk_msg when an open
> record is split.
> 
> The scatterlist entry and the corresponding msg->sg.copy bit are one
> ownership record. Splice-backed entries are created by sk_msg_page_add()
> with the copy bit set so sk_msg_compute_data_pointers() does not expose
> them as writable BPF msg->data.
> 
> The split path used memcpy() to copy both partial and whole tail entries
> but left the new sk_msg copy bitmap clear. A subsequent SK_MSG verdict on
> the split tail could therefore receive a writable data pointer to a page
> that was only supposed to be copied, allowing BPF to overwrite externally
> owned page cache.
> 
> Add a helper for copying one sg.copy bit and use it for the partial tmp
> entry and for each copied tail entry.
> 
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
> ---
>  include/linux/skmsg.h | 9 +++++++++
>  net/tls/tls_sw.c      | 7 +++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 19f4f253b4f90..f3988ce2219db 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -283,6 +283,15 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
>  	} while (1);
>  }
>  
> +static inline void sk_msg_sg_copy_one(struct sk_msg *dst, u32 dst_i,
> +				      const struct sk_msg *src, u32 src_i)
> +{
> +	if (test_bit(src_i, src->sg.copy))
> +		__set_bit(dst_i, dst->sg.copy);
> +	else
> +		__clear_bit(dst_i, dst->sg.copy);

__assign_bit()?

Also _assign() may be a better suffix for the helper than _one 

> +}
> +
>  static inline void sk_msg_sg_copy_set(struct sk_msg *msg, u32 start)
>  {
>  	sk_msg_sg_copy(msg, start, true);
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 964ebc268ee46..434753de8aadd 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
>  	struct scatterlist *sge, *osge, *nsge;
>  	u32 orig_size = msg_opl->sg.size;
>  	struct scatterlist tmp = { };
> +	u32 tmp_i = NR_MSG_FRAG_IDS;
>  	struct sk_msg *msg_npl;
>  	struct tls_rec *new;
>  	int ret;
> @@ -644,6 +645,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
>  		if (sge->length > apply) {
>  			u32 len = sge->length - apply;
>  
> +			tmp_i = i;
>  			get_page(sg_page(sge));
>  			sg_set_page(&tmp, sg_page(sge), len,
>  				    sge->offset + apply);
> @@ -675,6 +677,10 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
>  	nsge = sk_msg_elem(msg_npl, j);
>  	if (tmp.length) {
>  		memcpy(nsge, &tmp, sizeof(*nsge));
> +		if (WARN_ON_ONCE(tmp_i == NR_MSG_FRAG_IDS))
> +			__clear_bit(j, msg_npl->sg.copy);
> +		else
> +			sk_msg_sg_copy_one(msg_npl, j, msg_opl, tmp_i);

Not immediately obvious from the diff or commit message why this
special handling is needed.

>  		sk_msg_iter_var_next(j);
>  		nsge = sk_msg_elem(msg_npl, j);
>  	}
> @@ -682,6 +688,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
>  	osge = sk_msg_elem(msg_opl, i);
>  	while (osge->length) {
>  		memcpy(nsge, osge, sizeof(*nsge));
> +		sk_msg_sg_copy_one(msg_npl, j, msg_opl, i);
>  		sg_unmark_end(nsge);
>  		sk_msg_iter_var_next(i);
>  		sk_msg_iter_var_next(j);

This patch looks a little short. I have a recollection of trying to fix
this and giving up after realizing how big the diff would be just to fix
all the cases within skmsg. Could you look harder for places that
shuffle skmsg entries around, not just the ones in TLS? Maybe I'm
misremembering but I thought there was a lot more of them...
