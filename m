Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47C3CF1F1
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549071; cv=pass; b=Vo6molv02eXJ1yujAd+WYhvPTJWRu3t0OMcpVivWc4xlk4t4VmNgb6pf4z+tloehmDIvINrK7trMlpWtDi5D+q/sUlK+5PK2pR1E1DzeWTNMu2HSRq57BnXwcMyncFmdcO9flRU4lxzxn+Nheqglfo9RExEyjxIeJ3zTyXamLHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549071; c=relaxed/simple;
	bh=67Ku8tFH0+Ws1D/iHURGK4jc/Djx1tSgxDkwhxzxT3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScKviyggjhBwosne209FZxPSg7jhmPMJ0Db50Jqdkm8/xeAn/24j4KGDTXH4tDXhmknXBgA2C6m5h7JiWytIJP02egvCb5rSGaL84o+Jjnoh0QHO8AXZIl3D7UzHb24/pkSPpzD9rNIdQruQbeISyBOWs6b9tupkC613VJsUaVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idxeZmKr; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idxeZmKr"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6abc27842b6so1529903a12.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790549068; cv=none;
        d=google.com; s=arc-20260327;
        b=pAw6+EbbiZASfNjyOGLurk9dRc1cGH840FHkYi7EAmveC7UXELvZ0RvIHywMKFakGl
         Rip/QFCwqusVHsUAJvHByIJBqKhVx1JXwu2OO7yKBlQVvcFJMkOWH9ZUEJeRJgUw8sgR
         jrQAnGhs6FV0Cqg7MieYlwQKDVbDS6+WYkORh4/+OWjekH8W6kkpst2LgsX7qY8ezYsW
         m4WapXrnfVnb9rUn6GQkLuZZ4QtoGJAjGBVbVxMc8uKXUqVjWaeMf+UmrLGL1doI0x7n
         v44/ZgIozYSVkXXAYu3agaHIm2uNm90HzAtTfQjUSKgpkkbiBlKo5b0Bh9GM5sqMgbt6
         Hu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        fh=u2wf9KgFoV029q0IMz4sP0ln8+WtbgU7cy6/4zKVFWg=;
        b=JxjQC+0iq3SLGDahybWH9iY508/Wu2EGiWJcWN6fkF078pOgDeZja9aTirTWolXinW
         G06oErBklH5nxmmNhIUM3QYaKEaTenV9herFV7Oe/R3/D6m2IeYT6E29Qh1zjEATu7VR
         ZT3m6n0HRNun35qBBJxTHEfUVKjFYuLuSTi4yDK/3zDs7fDFSBi/wdWd0N6b8rhuPLxz
         70CvUeGkI4Icof8B8SJQl+ZJwzP3ZgyHpbHgTl6Tgi3lAs05zBrPbmuvF+gWUkkPM+W2
         Nik7HZ0u8duErpoPYrA5zK7aRKdy/alqP+KO6/RAh6yfBjgtnQJf8s2zpWSwZWzN9RDO
         Hz5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549068; x=1791153868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        b=idxeZmKrIuYKrd/YfxWT/URZFew2m6CV9Ae1fBK3rIb4TBy60O45Wt7MP3Rba5Et8h
         EHXII1gaCEXGLF+rTKLe4YWW/3tVI23rK8ss/nL6IcCichX6kkgvCupdYYM0Lo2hTbZQ
         f0U79XjYcNsAJEvVx+O2lJggX9CGh6wNdQAQNGwsNA6J3LAujcLeSLQ2lQIobRK+25Ew
         sXepR1I4DIeQw5FbGgu/a1qTECPSkgDLSVgBVCy/HAvMOezvRP6KCzD1p6Urw3Dxd5Ap
         UxBXf9+4Srb8VHQ5Z0EjaEb39BLal2BDXByZD82Njnh0Al0JT31a+ZmPeTK+VnlWIOXv
         bMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549068; x=1791153868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        b=P4X4pGT0ECjtDeJX6+osq7mJ9NwvjlMcgKua4hIelqHx0eSd9y185gutLwsnDwLRMu
         lu2PqOUfm967LtuB345YPe7w2/361oNrldclld1mONRBQhvGNolrGjYcfHuAIsj/i5FJ
         1AT7lyMWcBQYHfemsLVh53y4aCICeCwP7ukXKlX44GjQnu4s4KhrFV94+3WZF6CgaPW5
         b7M8Zs+ScaGMFegb2rgorSALPRYR/7M0cpatH5JZuBA/FXd8x1hY4pvCOY+wTDj/NqAd
         8Omk2jZvNwY6iFw6pyj+8Bzm3krQ2nNKLsZhCBrRpx2AW8e2QTzpjCpN5Q5orQpKObhh
         z/ww==
X-Forwarded-Encrypted: i=1; AKwUvByQhKGPTQac5tLLA/HBkkfZZ3uReVPXfjqVPa5B0MPnoqQprjibK3kd2j22E0+dVIdrIUGn3uI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYR9mM5mNcHsVVtDykCpFwIf4HjUk75ZRXpItasLvuQMum0BxA
	6mEWZNqZ1muAs+Kw0rc98TILn8JqCITNecj5JZOjFbaYlPenguOXd88peGxx863YkmgrV0zpBDf
	iQjhfszfNtlRbzSiG8KuPPQdjc62dwWKw8hZ6
X-Gm-Gg: AYBFou3/BtetGlnSQaoo7othzkXMoP+oBjpTRolkFCIRo9M024p4z78tnYfw7/VLu74
	TEL/T1zOy8IFgRsSTc0zFfHtPNdfAULnOtfyuiMEVt0LWPEp4kCK6OMyyAiQz4PGVEtinM2RoDh
	fB8JdsbAcXfpsDIjChlXsAs41Woro/abPJvKuTTov0ZqLbMvhvn9EznzAI93DKLdY8OfVFj/VGS
	HRqyUvcNDTD4QLftzQeixaozKAK8hMXBCGvr6K880nN+/1ri+ns7V0hs8axUrGtiNI5erzZRObg
	1HKhawb8u7fbk4dgU79fbiEB5RpeLYF+unJ3GadqmJ00dka4E+KSjDVUWTMeLpYy7feRXktDV1i
	7XDDqKHVt3txoQu7cG+f+aQm+/GAXOIzFLW4Bc0nTaQ==
X-Received: by 2002:a05:6402:3604:b0:6aa:f630:f83b with SMTP id
 4fb4d7f45d1cf-6aaf63104edmr4907482a12.34.1790549067897; Sun, 27 Sep 2026
 15:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005726.8274-1-kaloz@kernel.org>
In-Reply-To: <20260927005726.8274-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 28 Sep 2026 00:44:16 +0200
X-Gm-Features: AclHuK_ocZcXs9sywIUtTayi9j3iPPsLoAkkR2Bcc_gGJtZsVc-FFNs2BXG8wLA
Message-ID: <CA+=Fv5SRtS=dZQP_773p+zdgRYYOwWJpBBNcs36fCmNhwOQHvw@mail.gmail.com>
Subject: Re: [PATCH] sparc32: order sun4m and sun4d cross-call flag resets
 before sending the IPI
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:58=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> sun4m_cross_call() and sun4d_cross_call() clear processors_in[]/
> processors_out[] for each target and then raise the cross-call
> interrupt. sun4m sends it through sbus_writel(), a volatile C store,
> which orders it only against other volatile accesses; sun4d sends it
> through cc_set_igen(), an asm volatile with no "memory" clobber.
> ccall_info is not volatile, so in both paths the compiler may sink the
> two resets below the send; gcc 14 does it for sun4m. A target that
> takes the interrupt and runs smp4m_cross_call_irq() or
> smp4d_cross_call_irq() before the resets land has its flags cleared
> behind it, and the sender spins forever on processors_in[] with
> cross_call_lock held.
>
> Add a wmb() before sending the IPI in both cross-call paths.
>
> sun4m has raised the IPI inline since the commit below; before it,
> set_cpu_int() was an out-of-line call. sun4d has had the same gap since
> 2.1.97.
>
> Fixes: 4ba22b16bbf3 ("sparc32: move smp ipi to method ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>

You have gcc 14 sinking them for sun4m; the other end of the range, for the
record: gcc 9.5.0 (crosstool-NG, sparc-linux-gnu) does not. Adding your wmb=
()
at exactly this spot leaves sun4m_smp.o byte-identical, and wmb() is barrie=
r()
on sparc32, so that compiler was already keeping the resets ahead of the se=
nd.

Might be worth a line in the changelog for the stable side: older toolchain=
s
build correct code today and the patch is a no-op for them. Still obviously
right to add the barrier.

Magnus

> Notes:
>     - gcc 14 moves the resets past the send in sun4m_cross_call() and
>       keeps them ahead of it in sun4d_cross_call(); the barrier is missin=
g
>       in both.
>     - leon_cross_call() needs no change: leon_store_reg() already carries
>       a "memory" clobber.
>
>  arch/sparc/kernel/sun4d_smp.c | 6 ++++++
>  arch/sparc/kernel/sun4m_smp.c | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.=
c
> index 9a62a5cf3337..11ce613e2682 100644
> --- a/arch/sparc/kernel/sun4d_smp.c
> +++ b/arch/sparc/kernel/sun4d_smp.c
> @@ -321,6 +321,12 @@ static void sun4d_cross_call(void *func, cpumask_t m=
ask, unsigned long arg1,
>                                 if (cpumask_test_cpu(i, &mask)) {
>                                         ccall_info.processors_in[i] =3D 0=
;
>                                         ccall_info.processors_out[i] =3D =
0;
> +                                       /*
> +                                        * The target may run the handler=
 as soon
> +                                        * as the IPI lands, so the reset=
s must be
> +                                        * visible before it is sent.
> +                                        */
> +                                       wmb();
>                                         sun4d_send_ipi(i, IRQ_CROSS_CALL)=
;
>                                 }
>                         }
> diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.=
c
> index 056df034e79e..6ee65c05d089 100644
> --- a/arch/sparc/kernel/sun4m_smp.c
> +++ b/arch/sparc/kernel/sun4m_smp.c
> @@ -197,6 +197,12 @@ static void sun4m_cross_call(void *func, cpumask_t m=
ask, unsigned long arg1,
>                                 if (cpumask_test_cpu(i, &mask)) {
>                                         ccall_info.processors_in[i] =3D 0=
;
>                                         ccall_info.processors_out[i] =3D =
0;
> +                                       /*
> +                                        * The target may run the handler=
 as soon
> +                                        * as the IPI lands, so the reset=
s must be
> +                                        * visible before it is sent.
> +                                        */
> +                                       wmb();
>                                         sun4m_send_ipi(i, IRQ_CROSS_CALL)=
;
>                                 } else {
>                                         ccall_info.processors_in[i] =3D 1=
;
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>
