Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382451;
	b=jWJGgnWGy+Z6gfoi1hH3nnGYh6scHVRgmDPL8Y6iRZb4I5hN3gTwuauCpppFS65mOhBM
	 x12yonVVZ2g+lMbUz9LZ+/FsiSo0B+CL9PP/UG58fuDt1ibLEfKGoqur+lIkWvPFt6D6K
	 JlCV9SVMYcxKV6BnARpOoT1HEDUo4ZewZ5MDmPHzQ6WYWgIgHdfxPghlNB/pW6OVeEQH7
	 sw6A0ror0iFI1L9GUHsRDOYZEQFgu8y/UWyfEj+/S8LqV09L7QecWcj++8/HatEjpy2V2
	 KbMtWOcBKROysZSvld1dySsleeFachP1Kd+dnx4neUjDQVK+GyGQrmtH4ExIAyfoIKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
	b=1+gg4ZZYz8eBPMpS9YPdDVAY9XGB4+4B/QwKrIX9UcOTqqtmlr4rbOjpepOZ71aObPev
	 ZT1szpKlGHrbAiUAmyDM5y3pt4VSHAtc/9LkXeuzw8DJgr8MBEzK1ECsd9LIyX48b0SOq
	 1X7IJ94YUaA3c/paBfDaQll5iH+Ad+KVD7XZx0O8+Q77GHWuWD04kkzi2aaA2Sb4B3DKy
	 3f4FJgqaXRiF2gbTk78D9+isWRW2OFVSxcb+ZFdAKAtcQPn3TO4kJAZt8U+6WIs2YzI9K
	 6Os68jhXtzQQvNTobcJW3S0ScUCBbclstu2OlabXPMjW+U+CQa44ML8Iw9horCq8s/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiJOZf2q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C00606A331
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C00606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiJOZf2q
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so456055a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793382450; cv=none;
        d=google.com; s=arc-20260327;
        b=oso6MJaNQBw/+bzFfORxiBfoi5iMNoSv4gwofx0jJKx627Ij5GvNDFL0qgGgYKA7OW
         zrG+sr3ldRDa36TB/BYS2BZ9JFrrnBsVVxnIC7ejR7qg7j09etWxUKg8os9bCCOjohR0
         FZ5qCsN9NDA/RiEhW0p2SNfw6jnKCqK+hbQ4kJXcmYeoGLIVrSU3ugBIS7VN2sDKHiks
         FYCZbKVLf+KyUuFNvhUK7rfnX0unUKlX71PRBNxm99xwNBgQ5Ti4rNxQ0owoOsgnj439
         Wucjp/uYRxWSm74S2uYQpI8Xa5pJnA+GakjzdU35FBV2Ix5kE/BDjmGhb+Snl0OPnC7h
         pyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        fh=MJWiyQ00CjJv7DZQu4CK62hcVzIOuYYddAq7hoXyFn8=;
        b=cCplliFR1bUFzhb55xPBagK7jEUOAVFaGxWfFbPp+HjUpamSvzXjK6s8q9BWrqGh05
         vg+6pFB+OxLULX1bldThIuKWXQ3lPbaNco/yNHDtM1MLsL5z0KigQQaSdHMsO6XobzZt
         cBXCZC/aC3bK3jWV7+hFYzYd15An7iPIOGCYKDla2jJ/byip4IVmTzrsWWuefJ9quvRL
         uJyOSfcRn/bknYnZS/VZVBtxWqajNXWshtQGNNwEnxDgwMoz+C9cVKrzzTu4M5n1xdC7
         r16xR+OaTFfZ39sAi1HaW3AeDQXPJOn1VJ7FUeKeoMySyE6OWTKuDtKCbkQfd6eLCrxx
         ArIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382450; x=1793987250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        b=XiJOZf2qGnVvMOKzdKKgRpWoyWi7lo7RmWu0V8WqgQ1k3lzoL0/Dv5fQACqCRG6kM1
         PDsgKhCrs4wpWVvAYSFUP4vK7JaU/AJH9EGqZzKU82dbSRjoTp4O90spiuLfMo+YIHHM
         HaSLbVBL77GBIbulXUBDdFNIUrME8XK6DSOB1WKKJD3EZtLWKCPWxXTl7lZ+/+6tyYv5
         lVX69+D53vs8zH6azIL0M12NDNgxtlMKZXOtIaFgeKUewfILzXlkRBiV9y65ySTvgRak
         QVcOFQipiM98Snkj9OKCPpgX0q7tQgblxQkMG73TN6DbZaMN/diAXX0h4MtTjo7hF/xT
         DP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382450; x=1793987250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        b=zk5qndIgz5oQmfaGgCr4hF+YTBM6fdK09akRDFXSHIeDuUpKR7zjlyu8qnISpjLJJw
         Kt60d5M1mLnZJF9SiYCg5qhCMbfBk/gdxpIPYkpEOtInL7VJtBYAR1v3BjkpKttvijtw
         pyz9SIItShlAKsBPicOdVBHDQhlIvB7j6fCgcwTQO0ruYLoBOGuqLukoPQMCpkEK3F9p
         iON4sXoTL+4RSFjSKabssqfPvcFXZMI28eIZp1RefuHH4NmezMO5YhL5ED/hizCYM0vR
         6LLTBbfFS+3f8eyDrBz17yL4xszlLxtv2V6xM2rFIStH4ZoO6gpkTj+MxHghzSq0sUzP
         2/VA==
X-Forwarded-Encrypted: i=1; AKwUvBwNui0hPNYxgzpRaJEjNyiNyLibqBM/s0rMMEUhgmwJdazOmGC74jsuUknyqspypuCDivcd1IA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtK1eJZOtJZQb6OS0gt+fxgOYh6AxlBKWRHtInTscFYlXXKfWu
	lMi74rlmYhSeJPa5uE/5E+/OEg7enyba8YKF8I73G8Gywc9OVKIQANnXIY9hTAMhDc+2+PUqTI4
	S9nQrtEmSknmU2lI6Az+ZeCrBsih1kH0=
X-Gm-Gg: AYBFou1EB/luS5IkUx8PgAGG5RokP1CpJfb0KdiIcRqo2JYKAjuuZC/N2c3fEZgk6dy
	GSewysdA+lGpX9jC4KH1ZhPYZycZzqplw4O2icx6Ef2YcDWD79wfo6u7/w7xmi5xl3RKQT4whH7
	GkMelrtqayajGUHwor5JGBXSUvxq2VNryvAnPwIuymFfAKQoznZUfeNoqbdjBVaD8ZtJVIfrIpg
	bekYD2a1WXYCzKH+uasR/iUB5vc/1kUGWgtD6Xq0HTNnm4jxQeB51+K2MWPXlS3oWJsDqeCH3wG
	+Ehk86bhF1RKej1Ewn+C7lfkiTPzBtnlUHae/QKFNGSKOQT3r4EFqHzwDX7EBEVJDtMRJUlVk5e
	I3TSSENc3tlmxnP/LqauSw8aXW7jVktNpZEqgWIOgqCdyaiYmhM+8tAj16gJAVTRWJXT+BCavtN
	SsgnawSL8XBxBLFhbkigeo2VHkXMYM2hOKunlf
X-Received: by 2002:a05:6a21:3b45:b0:3e2:325f:576b with SMTP id
 adf61e73a8af0-3e928a71e94mr2185777637.65.1793382449721; Fri, 30 Oct 2026
 10:47:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082405.1297-1-shengshilingmu97@gmail.com>
In-Reply-To: <20261027082405.1297-1-shengshilingmu97@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 30 Oct 2026 13:47:18 -0400
X-Gm-Features: AclHuK_iwRZMverILPQ6aqdRr0bJylTP3g7Evr_UNs3S8h82CvZ8DH_nxsbSAhw
Message-ID: <CADvbK_eGiwO13sCNqpqHeiTLkQgTU_6Dt+Q+EVZ-CQ6WvRB9mg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
To: Masafumi Suzuki <shengshilingmu97@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:32=E2=80=AFAM Masafumi Suzuki
<shengshilingmu97@gmail.com> wrote:
>
> sctp_init_cause() accepts a chunk when skb_tailroom() can hold the
> cause header and the payload. sctp_addto_chunk() then writes 0-3
> bytes of padding before that header so the chunk stays 4-byte
> aligned. The check does not include the padding, and the following
> skb_put() calls skb_over_panic() from softirq.
>
> Count the padding sctp_addto_chunk() is about to write. The cause
> length on the wire stays the header plus the payload.
>
> Fixes: 8914f4bace3f ("sctp: add sctp_make_op_error_limited and reuse inne=
r functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masafumi Suzuki <shengshilingmu97@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 84a4c97d0f75..8933caadcdb6 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -133,20 +133,27 @@ static const struct sctp_paramhdr prsctp_param =3D =
{
>   * cause codes will be embedded inside an abort chunk.
>   */
>  int sctp_init_cause(struct sctp_chunk *chunk, __be16 cause_code,
>                     size_t paylen)
>  {
>         struct sctp_errhdr err;
> +       int chunklen, padlen;
>         __u16 len;
>
>         /* Cause code constants are now defined in network order.  */
>         err.cause =3D cause_code;
>         len =3D sizeof(err) + paylen;
>         err.length =3D htons(len);
>
> -       if (skb_tailroom(chunk->skb) < len)
> +       /* sctp_addto_chunk() pads the chunk up to a 4-byte boundary befo=
re
> +        * appending the cause, so account for that padding here as well.
> +        */
> +       chunklen =3D ntohs(chunk->chunk_hdr->length);
> +       padlen =3D SCTP_PAD4(chunklen) - chunklen;
> +
> +       if (skb_tailroom(chunk->skb) < padlen + len)
>                 return -ENOSPC;
>
>         chunk->subh.err_hdr =3D sctp_addto_chunk(chunk, sizeof(err), &err=
);
>
>         return 0;
>  }
> --
> 2.47.0

Acked-by: Xin Long <lucien.xin@gmail.com>
