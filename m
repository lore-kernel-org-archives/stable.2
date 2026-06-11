Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297D4D2ECB
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203318; cv=none; b=HX6qjjRs+p052Yediv7ekBfBAaulOZD1z8Cw9pvL27YA0oaKTeViKpdmy7pCZgg5hJ7uoUjHJ1XQMlP8UudpQ43iRfsE/kVIwbr96e8I02+HAyKI2U+wvrE5dqlFAT2CGlcfciCuSZkJ6u1i32KL9TboZRkaueHV9zrARgikwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203318; c=relaxed/simple;
	bh=IkEHZPSDtCkUJmB9jlcPSk6gUtKj+1tZjpR+VAgd3ss=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BfB06EcfUJLZQYp4Q3a81RRA+FWAV/y+tOcqgn6uzPRbtMB4Yx0wwOOdy1zlIYDZJ52YDTB8S+/wMaN3FqvqpZguOChIen7GDSj5doczVvZ56RpCAI1wvY2X/R/s/PzVTCY2BUDdQX0Vz1l1o8sunNK5j+whv8YVW8IxbpOjAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=p9yJaWXM; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="p9yJaWXM"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30749947917so579694eec.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781203316; x=1781808116; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7QM0qmxmtR/YrFr0aJ+thth8ELg/lCSgHx9ugycN6k=;
        b=p9yJaWXMDd3WP1Cb4U5SZU9NgtNRsl/G/EZ0l8KOhMuETmjCdg0olBowjrDxmpNkXi
         fvxENa5uPfRyidx/Fm3oFDnsZWQqB7IBY1sneQ4na2v9H4592QND9C7z3ofI2W3zvTlZ
         /MzaC9QaGzs6LKjKblop0m7lFXI/l3hZvl5+aqL8pXzmSv2hD7bt9vxwQRnsCfs52+dB
         RAyw1ggrftHM/lmA4qLft4PVabqLXUjYB0PVHig7QIk36U6mAeYQP/KuDJAvLfpyP3tP
         KOL/SoLmd7jzeTkBZ9dAez0sxCvC/3qTfTL994vV3ypcsZOQdLKlerugSAWF9aOt/6EG
         aJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203316; x=1781808116;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7QM0qmxmtR/YrFr0aJ+thth8ELg/lCSgHx9ugycN6k=;
        b=ANf4qH5TxirrpxmozIZma8H32My4g+ToZAo3M1dWNWYNRAU4E8QvHpp7kUl9k8+6zt
         sYEagsdIjAuCj2JbLHVE02akRWkshBOJRJrREhdQ1CF7FCTMbKG8+hdUQOgi0KezC69t
         SahqOzKys4BvEWe/C+hlReSCHYnCst/ySTtTpjgj7e3J+gjXVMwr98ILXsgEJ9GKWX7Z
         960jsWup0Sma/zAww6LUpja1Eg+Z1oZYFqWhM5kVvPRXshicxiU+iQ+Lgzv7Vd24Oz0w
         p99tfb8jIEfY8f0LLiRPnOr/C6R/gfbT5JasKvsEmgy6Uw5lOSH9jS5jDG5ifbqHv0d5
         MwrA==
X-Forwarded-Encrypted: i=1; AFNElJ/LEDCW0dyh7hMh6X7XPwwY1UefnPRWnJyN3DP67zlFn2rC8zLjE63Bibqo1hUNqn2MjQj3c74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56j2wkReq2f8u5uQxLV4yzLv+RJUzgmO5z90S73n6hoCe5IJ8
	M2v0SinZw9Me07P2cFyMRdlaSzs0BWW9myHs191eqYSSTs3Frh3v7M3536F32l2VKuw=
X-Gm-Gg: Acq92OH8wcrU8uAmQWbxNggS2OQTcLyk4OT+2czTdK+oKLXzPssGi7VkHmY1uoDebQV
	f+YBMGPn0Fu+wGjzVLXxobUl7meGKu4hXIdnIkZ8Iko4CxSjkBnfDj0vwvfwKVIxxSPS62d4hG5
	3C2pGPuLETeUlYKOlg7wqUGf+2ek+PdlPwIxNI2DMJXrXcqODodz0hOoLwhCf/UxZsA3B7drezP
	hooG75sgT5anIF3DEe/ocz4nhQ0srQu1tk4qompNESSvj+AGsA9pSQZlBFiJPSTvoRb27hBZW6f
	hx7XGJBwIgbBdsw6q2vst9hdXwSY+0NpqDNFGdO6DlRr4wsUZrQyZfWVl2BMyA6M/DuNmeoZs8Z
	EnZ6oBIuscid7cb1iT9nwK3ZsSGS+A4NaBT+43PnM3MAKm5URXX6ulHJJBL3MllC+6GMK4LOwbz
	5Rdgax
X-Received: by 2002:a05:7300:2146:b0:307:26a3:75e4 with SMTP id 5a478bee46e88-3080461f82cmr3319194eec.4.1781203315661;
        Thu, 11 Jun 2026 11:41:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c2f420sm2775011eec.6.2026.06.11.11.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 11:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 14:41:52 -0400
Message-Id: <DJ6FVL7EYA5O.2ZU3PP948P777@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Zhang Cen" <rollkingzzc@gmail.com>, <stable@vger.kernel.org>, "Han
 Guidong" <2045gemini@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>, "Shuah
 Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Sechang Lim" <rhkrqnwk98@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 4/7] bpf, sockmap: keep sk_msg copy state in sync
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-5-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Zhang Cen <rollkingzzc@gmail.com>
>
> SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> with this bit set are copied before data/data_end are exposed to SK_MSG
> BPF programs for direct packet access.
>
> bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
> rewrite the sk_msg scatterlist ring by collapsing, splitting, and
> shifting entries. These operations move msg->sg.data[] entries, but the
> parallel copy bitmap can be left behind on the old slot. A copied entry
> can then return to msg->sg.start with its copy bit clear and be exposed
> as directly writable packet data.
>
> This corruption path requires an attached SK_MSG BPF program that calls
> the mutating helpers; ordinary sockmap/TLS traffic that never runs
> push/pop/pull helper sequences is not affected.
>
> Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
> the copy bit when an entry is split, clear it when a helper replaces an
> entry with a private page, and clear slots vacated by pull-data
> compaction.
>
> Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Cc: stable@vger.kernel.org
> Co-developed-by: Han Guidong <2045gemini@gmail.com>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

There's a bunch of nits here in terms of complexity but the fix is correct
and considering how many reports are flying around for the same helpers
it's iom better to just get them fixed asap.

> ---
>  net/core/filter.c | 88 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6e345ca65ca14..e35e681a15dca 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2654,6 +2654,38 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
>  	}
>  }
> =20
> +static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
> +{
> +	return test_bit(i, msg->sg.copy);
> +}
> +
> +static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i)
> +{
> +	__clear_bit(i, msg->sg.copy);
> +}
> +
> +static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i)
> +{
> +	__set_bit(i, msg->sg.copy);
> +}
> +
> +static void sk_msg_clear_copy_range(struct sk_msg *msg, u32 start, u32 e=
nd)
> +{
> +	while (start !=3D end) {
> +		sk_msg_clear_elem_copy(msg, start);
> +		sk_msg_iter_var_next(start);
> +	}
> +}
> +
> +static void sk_msg_sg_move(struct sk_msg *msg, u32 dst, u32 src)
> +{
> +	msg->sg.data[dst] =3D msg->sg.data[src];
> +	if (sk_msg_elem_is_copy(msg, src))
> +		sk_msg_set_elem_copy(msg, dst);
> +	else
> +		sk_msg_clear_elem_copy(msg, dst);
> +}
> +
>  static const struct bpf_func_proto bpf_msg_cork_bytes_proto =3D {
>  	.func           =3D bpf_msg_cork_bytes,
>  	.gpl_only       =3D false,
> @@ -2692,7 +2724,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg,=
 u32, start,
>  	 * account for the headroom.
>  	 */
>  	bytes_sg_total =3D start - offset + bytes;
> -	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <=3D len)
> +	if (!sk_msg_elem_is_copy(msg, i) && bytes_sg_total <=3D len)
>  		goto out;
> =20
>  	/* At this point we need to linearize multiple scatterlist
> @@ -2738,6 +2770,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg,=
 u32, start,
>  	} while (i !=3D last_sge);
> =20
>  	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
> +	sk_msg_clear_elem_copy(msg, first_sge);
> =20
>  	/* To repair sg ring we need to shift entries. If we only
>  	 * had a single entry though we can just replace it and
> @@ -2747,8 +2780,14 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg=
, u32, start,
>  	shift =3D last_sge > first_sge ?
>  		last_sge - first_sge - 1 :
>  		NR_MSG_FRAG_IDS - first_sge + last_sge - 1;
> -	if (!shift)
> +	if (!shift) {
> +		sk_msg_clear_elem_copy(msg, msg->sg.end);
>  		goto out;
> +	}
> +
> +	i =3D first_sge;
> +	sk_msg_iter_var_next(i);
> +	sk_msg_clear_copy_range(msg, i, last_sge);
> =20
>  	i =3D first_sge;
>  	sk_msg_iter_var_next(i);
> @@ -2762,16 +2801,18 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, ms=
g, u32, start,
>  		if (move_from =3D=3D msg->sg.end)
>  			break;
> =20
> -		msg->sg.data[i] =3D msg->sg.data[move_from];
> +		sk_msg_sg_move(msg, i, move_from);
>  		msg->sg.data[move_from].length =3D 0;
>  		msg->sg.data[move_from].page_link =3D 0;
>  		msg->sg.data[move_from].offset =3D 0;
> +		sk_msg_clear_elem_copy(msg, move_from);
>  		sk_msg_iter_var_next(i);
>  	} while (1);
> =20
>  	msg->sg.end =3D msg->sg.end - shift > msg->sg.end ?
>  		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
>  		      msg->sg.end - shift;
> +	sk_msg_clear_elem_copy(msg, msg->sg.end);
>  out:
>  	sk_msg_reset_curr(msg);
>  	msg->data =3D sg_virt(&msg->sg.data[first_sge]) + start - offset;
> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge =3D {0}, *psge;
>  	u32 new, i =3D 0, l =3D 0, space, copy =3D 0, offset =3D 0;
> +	bool sge_copy =3D false, nsge_copy =3D false, nnsge_copy =3D false;
> +	bool rsge_copy =3D false;
>  	u8 *raw, *to, *from;
>  	struct page *page;
> =20
> @@ -2869,6 +2912,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  			sk_msg_iter_var_prev(i);
>  		psge =3D sk_msg_elem(msg, i);
>  		rsge =3D sk_msg_elem_cpy(msg, i);
> +		rsge_copy =3D sk_msg_elem_is_copy(msg, i);
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> @@ -2894,23 +2938,34 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, ms=
g, u32, start,
>  	/* Shift one or two slots as needed */
>  	sge =3D sk_msg_elem_cpy(msg, new);
>  	sg_unmark_end(&sge);
> +	sge_copy =3D sk_msg_elem_is_copy(msg, new);
> =20
>  	nsge =3D sk_msg_elem_cpy(msg, i);
> +	nsge_copy =3D sk_msg_elem_is_copy(msg, i);
>  	if (rsge.length) {
>  		sk_msg_iter_var_next(i);
>  		nnsge =3D sk_msg_elem_cpy(msg, i);
> +		nnsge_copy =3D sk_msg_elem_is_copy(msg, i);
>  		sk_msg_iter_next(msg, end);
>  	}
> =20
>  	while (i !=3D msg->sg.end) {
>  		msg->sg.data[i] =3D sge;
> +		if (sge_copy)
> +			sk_msg_set_elem_copy(msg, i);
> +		else
> +			sk_msg_clear_elem_copy(msg, i);
>  		sge =3D nsge;
> +		sge_copy =3D nsge_copy;
>  		sk_msg_iter_var_next(i);
>  		if (rsge.length) {
>  			nsge =3D nnsge;
> +			nsge_copy =3D nnsge_copy;
>  			nnsge =3D sk_msg_elem_cpy(msg, i);
> +			nnsge_copy =3D sk_msg_elem_is_copy(msg, i);
>  		} else {
>  			nsge =3D sk_msg_elem_cpy(msg, i);
> +			nsge_copy =3D sk_msg_elem_is_copy(msg, i);
>  		}
>  	}
> =20
> @@ -2918,13 +2973,18 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, ms=
g, u32, start,
>  	/* Place newly allocated data buffer */
>  	sk_mem_charge(msg->sk, len);
>  	msg->sg.size +=3D len;
> -	__clear_bit(new, msg->sg.copy);
> +	sk_msg_clear_elem_copy(msg, new);
>  	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
>  	if (rsge.length) {
>  		get_page(sg_page(&rsge));
>  		sk_msg_iter_var_next(new);
>  		msg->sg.data[new] =3D rsge;
> +		if (rsge_copy)
> +			sk_msg_set_elem_copy(msg, new);
> +		else
> +			sk_msg_clear_elem_copy(msg, new);
>  	}
> +	sk_msg_clear_elem_copy(msg, msg->sg.end);
> =20
>  	sk_msg_reset_curr(msg);
>  	sk_msg_compute_data_pointers(msg);
> @@ -2950,27 +3010,38 @@ static void sk_msg_shift_left(struct sk_msg *msg,=
 int i)
>  	do {
>  		prev =3D i;
>  		sk_msg_iter_var_next(i);
> -		msg->sg.data[prev] =3D msg->sg.data[i];
> +		sk_msg_sg_move(msg, prev, i);
>  	} while (i !=3D msg->sg.end);
> =20
>  	sk_msg_iter_prev(msg, end);
> +	sk_msg_clear_elem_copy(msg, msg->sg.end);
>  }
> =20
>  static void sk_msg_shift_right(struct sk_msg *msg, int i)
>  {
>  	struct scatterlist tmp, sge;
> +	bool tmp_copy, sge_copy;
> =20
>  	sk_msg_iter_next(msg, end);
>  	sge =3D sk_msg_elem_cpy(msg, i);
> +	sge_copy =3D sk_msg_elem_is_copy(msg, i);
>  	sk_msg_iter_var_next(i);
>  	tmp =3D sk_msg_elem_cpy(msg, i);
> +	tmp_copy =3D sk_msg_elem_is_copy(msg, i);
> =20
>  	while (i !=3D msg->sg.end) {
>  		msg->sg.data[i] =3D sge;
> +		if (sge_copy)
> +			sk_msg_set_elem_copy(msg, i);
> +		else
> +			sk_msg_clear_elem_copy(msg, i);
>  		sk_msg_iter_var_next(i);
>  		sge =3D tmp;
> +		sge_copy =3D tmp_copy;
>  		tmp =3D sk_msg_elem_cpy(msg, i);
> +		tmp_copy =3D sk_msg_elem_is_copy(msg, i);
>  	}
> +	sk_msg_clear_elem_copy(msg, msg->sg.end);
>  }
> =20
>  BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> @@ -3027,8 +3098,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg,=
 u32, start,
>  	 */
>  	if (start !=3D offset) {
>  		struct scatterlist *nsge, *sge =3D sk_msg_elem(msg, i);
> +		u32 sge_idx =3D i;
>  		int a =3D start - offset;
>  		int b =3D sge->length - pop - a;
> +		bool sge_copy =3D sk_msg_elem_is_copy(msg, sge_idx);
> =20
>  		sk_msg_iter_var_next(i);
> =20
> @@ -3041,6 +3114,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg,=
 u32, start,
>  				sg_set_page(nsge,
>  					    sg_page(sge),
>  					    b, sge->offset + pop + a);
> +				if (sge_copy)
> +					sk_msg_set_elem_copy(msg, i);
> +				else
> +					sk_msg_clear_elem_copy(msg, i);
>  			} else {
>  				struct page *page, *orig;
>  				u8 *to, *from;
> @@ -3057,6 +3134,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  				memcpy(to, from, a);
>  				memcpy(to + a, from + a + pop, b);
>  				sg_set_page(sge, page, a + b, 0);
> +				sk_msg_clear_elem_copy(msg, sge_idx);
>  				put_page(orig);
>  			}
>  			pop =3D 0;

