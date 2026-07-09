Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9844343E0
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613955; cv=pass; b=GGC0LSc3W2c0r3ZZqLdta6rfw3iNxLxuhcycVXU0MPhIUedcU7RXRlEQ7+N0Qbs37A/R7jvohXTgE+QnmhhDVBb1kDKjYDa8IMar5icqS0egciCroRdvj1GojVdHALu6GVyvYGEZ8lWnVp6vkXqYVcr9nnO3ITxU+JuSz10O3Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613955; c=relaxed/simple;
	bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcewEn2PrYNTgnvTTezYhjAkGonBJ5/9h4Xdvh9grgiBrUONytARHKgEjY4cwlXxrevEYqnzuQB4kTwaJxc/QYi/vPifw7Zd93fLt/1tTFxFlly/g51IPTcNGlZPMagBTG2Sx3c0b2fqBeHdegexOwXarIPYe+uPrzVMgxWalpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnB6nh1Q; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnB6nh1Q"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484a0b998fso2255189b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783613951; cv=none;
        d=google.com; s=arc-20260327;
        b=F8qaZBf+v4BKtaBhm3wRFLllIIMGtjs32o4DLoKZBe2oTnV9e7Fgfh8fylRzr9gBht
         2VIPydwPIbp0y0RZhUykGUpJjoMtwqS+coY8wPCIuFzilDnvg1/L3Mwu1oZE+OaO2c3l
         vKyu0YB5GPdOpX9oEJp5RU22fJYKz4uL569RqLwoeB60dlRlB/jvGGqDzIA1CSPFknZt
         taKIxTXs7htFSXUEJiEYCbNleP0qa8ja9JiRkkrJd08gEsDo09ZrKL/5SFMouzMZ2HBQ
         w8oUUJ/ST2JceESDTGyu6pgLXFlJy0TxpWqqktIuaIsFQPmN54p8xoWNqWjmqVJ1zaOO
         1VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        fh=L6Uc7U8zcjl6FG7DToUUgn4C77sI26ZxgsNgZ6JnKSg=;
        b=sptStNthoWTJ0SYJHKqn6NL9urgSj/TUp5GAEhbUQ/jUfRkjud49oqlWkk/HWWyjIC
         DKM3xEkOT9VWewv7EYZo9rHVQqrwaR4dxvQjufDdFsT61bAfsYULosPrbr/Ss0BHB/G0
         OYaJfcJBaeE0uH0rI5CeUpsChw5qh9Ets4vZKBiZUgpYDVhX5WGb5uwTl8hiDeopKepS
         NYlkW3AA5pJ0eekCazYBEUWdtvU4rMXYQOOjEgjuF9lVusYg8Mr4rTtIkU/8Vq3aTlvY
         eDlokexaEIMcWU/ekDv96XOAI0AHeRBWdZpONAuZbGEMPU7LnlqA9K65DdnooeVE98Ap
         odHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783613951; x=1784218751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        b=wnB6nh1Qh8DREGyiH/uQvoaatPVZf6PA+eqqcViY5Gb0PYpjxcjZZ9+Jry7Z0DugGD
         muEgATZXsFapR6LhJR+cn7mjd7jNzCoDi/liIbSLSWFV6qaKFByHC9wOeHml5WY3vJOZ
         6KG3O2uaJ9l114O/kDeDivyQDekIVjyDPhmQn4Slt50XNL+TkmnAKzqlcvNxUpnj2yMF
         OVuiXoK8dCnZGmYS1dlKiyae+k6paxDlNs7JMXOoeVgbHqmB+cb4hV6OPpF5l/O9xjYv
         4ky63tQ3LRvEQMOIiw+mIEAro/KtcbZS2QGLDzhEJ3sjR0FafoO8xmuuyCiEUIIu2v+3
         SDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613951; x=1784218751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        b=nzJlLKXIxhIYeOvxFH68sz7+E+ASHgXgqEwFtjwrGJV5xOW+toDhCJJNx+zpi1uZDX
         H06HUGAYfRNJdiWI5jl65ccDxR4wEpHlAFAhVBBAoYF12HY2rm7vKZPTE9hYLMHxQCS/
         P8ILjEGhsDfzbnFXMG76a/R7K+UqOnJ4TE85iI52EQBCgUDv7rOIeRuQwZJDWXVManen
         9yB5pBjwlcr0JkKPjQyN1zDDlPhSKo1owDWE2+AIEGp+mYg5kNM6FJrNHvIl2QIoQStd
         C8d2INAkru6qrLu4s3nfKSd+OFxCOpdBjedfqYWPjZ/r5vvWiF9BLNR5Yyh3JSZlTRCG
         53Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrCKc9vAOtP/r26lU1KOxBf3iz8BYWD/N6zlJ1vd4jpTK0TXL9H/p00yng1vEHldQK6QuRIr+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAk8HPc/7Mi8PIWfKL3bhrtULLGxmZSRtIHyX6sCiKgb9tLCgO
	K5WLvuOCTVBq75Uu5AAfH0XGln+fk/5FUdjpwO4GSbVOTHCndffYFiTI+WfUaSq8yqCqM6I1WmL
	dRbmUzIXlz1bAXn+I6zlYjeO7ikviAT0x+U1VaHg6
X-Gm-Gg: AfdE7cnNjidyciQr5zC0RBLY9EeIEMlfSMcV3uU4//QggNyRFGjWarW5LyZ5kquPoUI
	2VdsuGxqmOM/vVPPpt+XADe1FBZp16VY3iMgnX3S/uPv6rH5yqE4b18UE4AZATS1PavZCzUXNUx
	mcxPtspJSckf6NEvdEJ2/TQqbloyrU9OGzE8FXaDTIGApJF9OkCRVi04MbPr3pV6Jk9OKkUTosb
	NdkkU3jGH98F3TLll7RfRxll6HMjQoEqGxI1EQa/nMVqUbefiTgJKocXIyMeOzAEKosWufc9fjL
	qTHRqy34kFI2nY75DGg4eo/CVTdg+PwFmdBpVb2sUeeTcPmC/V3yqsC7aswhpnNuUFjbhkCxtYT
	J9unEXXQDrV+dI07aj6CGs6Sye9O+wZnlJ6rMarKvEA==
X-Received: by 2002:a05:6a21:681:b0:3c0:9c1b:d0bb with SMTP id
 adf61e73a8af0-3c0bd31f12amr9478849637.70.1783613950892; Thu, 09 Jul 2026
 09:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709025316.999913-1-mattbobrowski@google.com> <e30f1c25-bc81-4a2a-a997-9b7007890b03@iogearbox.net>
In-Reply-To: <e30f1c25-bc81-4a2a-a997-9b7007890b03@iogearbox.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Jul 2026 09:18:59 -0700
X-Gm-Features: AVVi8Cdf2N_xKO2DUBcyOo5bx6SqShDIF7paay7Ksht1saLiq2ja-PfJ_1i66nU
Message-ID: <CAAVpQUDh7bNkLyQWzXmu-=V4KEV_t9-9ubaj3AjjYwJFivbNLA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, jannh@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:53=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> [ +Kuniyuki ]
>
> On 7/9/26 4:53 AM, Matt Bobrowski wrote:
> > Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
> > before bailouts that access it"), sk_clone() performs an initial
> > shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
> > the cloned socket newsk.
> >
> > If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
> > to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
> > to the parent socket's BPF local storage. When newsk is subsequently
> > freed via sk_free(), the deallocation path (__sk_destruct() ->
> > bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
> > leading to a use-after-free (UAF) on the parent socket.
> >
> > Fix this by resetting newsk->sk_bpf_storage to NULL immediately after
> > sock_copy() in sk_clone(), and remove the now redundant initialization
> > from bpf_sk_storage_clone().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> > Fixes: f12dd75959b0 ("bpf: net: Set sk_bpf_storage back to NULL for clo=
ned sk")
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>
> LGTM, thanks!
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
