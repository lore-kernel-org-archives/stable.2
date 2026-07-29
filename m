Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C683B05A7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337710; cv=pass; b=eB453+Hqmo0iX7YgtRARkxu3Qur5WsugY5DX90f3H/ldTZ8gi9vvmYvU01gWTKwudLsK+/OrZAwf1wZOZOI9EA/6aGcgbikAbm/SpSDnyxfoYyxbye8DTs/vXIuZma/MvDcbhYbutPXoGXN4Na6x+vuZRwJ2AlfgPZU93srulG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337710; c=relaxed/simple;
	bh=C1hDEqmnAa3TDi8gjx1zqfyVR/iLfuR2KeKJu77rxU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn0dPDrXxnYt0j9xCd/+CGy+WmtGNWXw46R2XXv6LC6daNPx2ra3KSaW7khVw39GSUQ5eM4fOb1jS7k6PQkw3aNAbwn4D+waYpX/ZtzXXHYjuRmDf2JOYRS0gDXILBr9ZAxQEHmnDOHKB4RDfGYPV4On4X4WCskqSFIF5Ib57W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5rJwYmZ; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5rJwYmZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84847482584so898903b3a.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785337708; cv=none;
        d=google.com; s=arc-20260327;
        b=XciQJy9kglxUu35v1DhVyenYeXKdF7gcrveuNFJUdG46YKeSlA0EO8qJJq+HH+BLqr
         JyEV5MfYUT6L3TgLLsUDllO1V0JO+PSD/HQCuJCmrWbP5opJLoUoaP+xv1gADcfqg8QT
         13IYMqfoyIs008zcyGuWhBJNGN7o8qg/yOAam0Zk2j9Au9K57lMEY4Irvc7YSVxrH5nW
         fuhiRUG5W+yoG9xoMd4Pgd3IS5eGrH+yFpckXDg7oG9jMexg4sBWGWIYEwUWHCDgk69l
         2OaGZKtULlhW0PHopBFquURJld2K/Mg6XgosderSmXynDdLoBT+Lju7/EHkhUh4HhO9P
         uERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        fh=cWRjusw6EfJBr683ZpYUNSASoZq6VApijzB5HJIqQ+E=;
        b=a+C884suVko40a9wHTwRIQHAv35fBRrtad36GbGoLxjqkNSy+JYfYf16caoVF77psA
         HlFRbf93D6fa1zPcfRK15Ha+vOCKhrsWPaf6UvW/1L2A6OSwF7fmwRF+bQpSCK4AzbDz
         VsKf5dQLc2MB0hvL2TJiy0/48vtIgA8TtAlXec40VDG7PW6GJ9ecgUbX8J9EJT9PevdB
         vRF1s7cig5IEMd9HwjW+uBxQ1WuIojitoRLqrnMfZM5/YMN4O2V0KZ6PreocL4FdhVYg
         0hsBVg3qr60HvUXe9rgmFj37pi8JZlRRnuzdYlmzkc3Tt/8KMu4iu1/mzvtj/UgzCwj0
         HIRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337708; x=1785942508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        b=M5rJwYmZIAtlq2ZrXWae5DyVp354Bdhjn+v8XphW1gScMIbXvLwDFkRLCUBBgMqowp
         u25PREYtIQY4zXbqPGZYRcH9UiWZcSW5cG5J8Ih2etgIARHnoRdnv0VBKWmpQZ4fyatz
         v+AhHsriMbdRHCgCuedHZj/GXbRfjMRKZjXG2NzBJPp2tk29qMfvGwss8Fk9pbOvJeLr
         imfUc0eNOr9EEmjc9joTMa+eWQJFoRecb3d2TFqrkn3BtR8k2oARWcg7FhWtV7XZYndt
         h1NMJkkBhXxhs4Nj6gZp4/iqT7FrEEvG18k+0YIYONZoPFmbyWPLsz301B2E1WEXXnvP
         JVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337708; x=1785942508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        b=WTlvJDTMbnZwgGcRPm3YG0G4aaVCvxe2XeEFJGOgr6Py5vCfQ9IWxKAZ0cHwM7WMGe
         pCQX9hmUuNIpmcMnZYtSRHrX717kMOFmLpEL/GxA2W2O7TLyNpeyy65kfy0ZnuTZDaDF
         PE4v2njpLgJSpIvC9GuS3aUSnenIuU/naqDxA06J+KPlFFqUVtzTutyDoTMRGGc26K1y
         FC/A8R2W0G/4dXUOchJge3/yfjbdDtQXTCawqsisfJ82GvTi8H0WAukscbcZDc0jaLeL
         jJjdUBYOeuD3w6e4ET2C/S6+GUMHz17D3W6CytJzkE0fNkpWMAd1xPOCNLw+G+1EMaoz
         wb2w==
X-Forwarded-Encrypted: i=1; AHgh+RooK+8kTTffQXLm6ymGzNHLsstBfFL1jDsDvfaRx/se+4BThRwxtpZ8pf2v/9XHP5XdW1ib8ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5D5VRtPcE+c+PuP9G9nHQXfAqOiPJJlhfszXdlEmYRFYvY7D
	tEZIQ2i6JKqgZbINSp8YsijC2jes5abasW96Seedwa9p0oxAVqF3pVQTzSTXtwOB7ty6EW+grh/
	qzcYkJ8j6sQb8ErkXf+Y3oji2BNZkCQxB1B4F
X-Gm-Gg: AR+sD10Cf6HxV7bkxag+3FgjpFvprwYUqkWJt98si3BtRY+H79JFWPQ0V+Zk0kk5ek/
	Uo/LMjPXi/GKZ7VJ2AmNoZja5+L2QlLP5w5CCC3DUuSfAETS+BtgYHS9KFVC0+Y3b1DFH/t4Sle
	po/NSP+9uwXnMhUb/wsm/WY1suPMfM+bLmlc0vNuGhiXkGy4AniZHIB4OLkOegytFFbsRbog2nA
	sHlC07dffsnccPIYRpgVfkj4QUuDzyGiZdLb5lKzC+bCH1bC/TSvLoz+5O8niMK0rVJisaO4SK/
	dVis28LWVI1s2BGHzbKoxZRdt0hUaisgelw8Uc0BGu4o/3omMJ6gdlJLqzyDHPKZaj31zMq76Hi
	mCoiyHJ+9o+wafAaP9U30vzNUpcaY/JRHiglXXzJ2vqo=
X-Received: by 2002:a05:6a00:bd86:b0:84a:46ec:3b9c with SMTP id
 d2e1a72fcca58-84ea7aa3469mr2826245b3a.31.1785337708243; Wed, 29 Jul 2026
 08:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-sctp-cookie-preservative-length-v1-1-1ade32e42668@gmail.com>
In-Reply-To: <20260729-sctp-cookie-preservative-length-v1-1-1ade32e42668@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 11:08:16 -0400
X-Gm-Features: AUfX_mypXq3HMlzPwWFUdF9XmRRShPhdnIHIc7-DAFADR9LIdIHSrIzgJYlIUYQ
Message-ID: <CADvbK_ds_4sNnVTxXEooHkkA6JjV35ByCx+BWXiihiAo2cX8gQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate Cookie Preservative parameter length
To: trilobyte777@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:54=E2=80=AFAM Charles Vosburgh via B4 Relay
<devnull+trilobyte777.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <trilobyte777@gmail.com>
>
> The Cookie Preservative parameter contains a fixed 32-bit Suggested
> Cookie Life-span Increment after its parameter header. However,
> sctp_verify_param() accepts a header-only parameter because the generic
> parameter walker only requires the header to be present.
>
> sctp_process_param() then reads lifespan_increment beyond the declared
> parameter and adds the value to asoc->cookie_life. When the malformed
> parameter is last in an INIT, the read starts at the receive skb tail,
> and the resulting value changes the expiration in the State Cookie
> returned in the INIT ACK.
>
> Require the declared parameter length to match the fixed structure size
> and abort the association through the existing invalid parameter length
> path otherwise.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Charles Vosburgh <trilobyte777@gmail.com>
> ---
> This follows Xin Long's review of "[PATCH net] sctp: validate Adaptation
> Indication parameter length", which noted that
> SCTP_PARAM_COOKIE_PRESERVATIVE has the same fixed-format validation issue=
.
>
> Runtime-tested in KVM/QEMU. The unchanged reproducer accepts header-only
> and overlong Cookie Preservative parameters on the unpatched kernel. With
> this patch applied to net.git base 51b093a7ba27, both malformed forms are
> rejected while the baseline and valid eight-byte controls still pass.
>
> The patch passes checkpatch --strict, builds net/sctp/sm_make_chunk.o,
> and completes a full x86-64 bzImage build.
> ---
>  net/sctp/sm_make_chunk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index a1c0334a1038..eb9cff77759b 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2165,7 +2165,14 @@ static enum sctp_ierror sctp_verify_param(struct n=
et *net,
>         switch (param.p->type) {
>         case SCTP_PARAM_IPV4_ADDRESS:
>         case SCTP_PARAM_IPV6_ADDRESS:
> +               break;
>         case SCTP_PARAM_COOKIE_PRESERVATIVE:
> +               if (ntohs(param.p->length) !=3D sizeof(*param.life)) {
> +                       sctp_process_inv_paramlength(asoc, param.p,
> +                                                    chunk, err_chunk);
> +                       retval =3D SCTP_IERROR_ABORT;
> +               }
> +               break;
Why not move 'case SCTP_PARAM_COOKIE_PRESERVATIVE' down
to after 'case SCTP_PARAM_ECN_CAPABLE'? it will save a 'break;'.

Thanks.

>         case SCTP_PARAM_SUPPORTED_ADDRESS_TYPES:
>         case SCTP_PARAM_STATE_COOKIE:
>         case SCTP_PARAM_HEARTBEAT_INFO:
>
> ---
> base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
> change-id: 20260729-sctp-cookie-preservative-length-ffa4472272fb
>
> Best regards,
> --
> Charles Vosburgh <trilobyte777@gmail.com>
>
>
