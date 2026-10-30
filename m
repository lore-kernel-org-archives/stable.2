Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385549;
	b=KoHZCz9XiJx1Qqo691+ksECZXY7psqEULJmcSh8Nku2GI6F3mwnpqLImSN+x1USd0t6k
	 hxOKcJwEgiBlL/qjdHfi4ox8adSncE16E9+qUJW9uFXR21+OG8NLTmpPR4PZSuT1iI+/Q
	 cAcVAy4OAITbLADR3TbuA8mNjMKkrKqxrhU5YLi7ovFI+eRMlIFzLVgO6rX3q6jhdSSgS
	 yJroovQzMnWtbbfzfP+zroFXvvhfwbdKc2N3SddT1Bdkg3IUod7zSA0GF/0/hTq/jR7Lw
	 jEWpjHa3my65RzJpM/fOhXyqx5UnyOc2Lq/hQdhFKEcaeCG90nPSqwnpysLtlg28BrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p/g4K4FmtPtb1dRwFi9A+STto81LNLv+WliespFcyzg=;
	b=PXFTPLGxyNmCptchK05Av8AK8jK0bFSh7WTK9PilVIE+n/TdxhiQ0o3t+nOvbqTC3pik
	 Lzgib4D6IwPAwE8XTXMNifOlqTUvDeVixmFyOgwmoIWKWVUki19TKEXVaTcc27sDIXVcG
	 yNPisDYGfMo9CXm/qwsDB/jqRYS3cubqInZ2SeKuymo54kj6R3GAmiyHjECggmC0tekEx
	 rXhk5Ur2UV6onvpG3bpzXxtVCTp6XpN5xVMySGAyXiFbuEoTbYIKKe46Uqwux8DyE5xMW
	 6yYWcAUV0zPx1QBJ5p5DHC54ONCWj3Mtv9S3LNS9szXCHuX3GtSvg1QRHGmdoaYLKjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LSdL35Ul;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095E606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6095E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LSdL35Ul
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so12331505e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385547; cv=none;
        d=google.com; s=arc-20260327;
        b=I8WUfrY2xcu3XIjDIA2UJEShO5UtsExLVYKFS35dQeHHednLdnOp8KzgiubE+paRRp
         woU6a2Uio7B8rPKFkFurNKEv7qMGchq5XKDNIRMIx4+14EJEIGYyKz9wtok+VhAgvoU7
         debp8oL0Jlsu2hOQ4bQl3sVL++Tvp/MdL+oFF6oXiFcCNWAlmNrxHBb9JY9QMNb9zNYn
         aqReuHGfSAZG2+37VvpDD0KcrsrimpwD8auPFSemfLJJJKH8n6huUyocs84LmudiwSMU
         mthbTP9xxKWMKAP2aqk615kLAGY044KseAIB/Jz2NoAHTq7QvvDML3plzNgVXfLIobhb
         F5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p/g4K4FmtPtb1dRwFi9A+STto81LNLv+WliespFcyzg=;
        fh=LW4mAfFA1GVXe0fNUcnEFhtnInzpQZMmZHdB4F8beXI=;
        b=hz0hyIvVdKBmTwvVLJDd+JgNQQQ4s986hi24oYnFR5JZWJeeXT+xp5qWE+mk/MhJMP
         Y61eZczkzYwNVn7M3cJL/x7TXgKSJnwOPwT7GA7Wo0xNZO8dGNaFIudyNv1V/uYuANkm
         bQ+n4FXrDBRByfvFiRgHTWVQzxnOlTMVFkNLZfM6aq5LX4YhKzpWk+qngnb0cu1Wri9U
         2Ha0PLrVPs+2d7qCFVrFXE0hpuM3yKiikgnG/8HdWkrpYVaih8/QsN/DFSAW6J+SoKQp
         ZZruhdI+B99p9A21hLNyMpoGvtqDS3fTho/KJ/942fqEFxOI4G5HjaEMuHH/uBj8yOP+
         vaXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793385547; x=1793990347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p/g4K4FmtPtb1dRwFi9A+STto81LNLv+WliespFcyzg=;
        b=LSdL35Ulq9xfjDQ6H+dQkccbZ0x/jdESebThG8XZE9+T2w6HWh9YQY1lJVKBTSIO35
         34IKIbaYw3l+bpwtxs0d8oWKwHJu17cNHabalfv1Vmg0ud/84n77g6apO3MavsUPDw3R
         vhks0PReE6AAtVbjTv1Q5GdKdCktjluJjbkmMhONTew55gjTZS1S1Ys5qYiuRe3vYOUU
         UC/pMGjsjowrL5r4o0VZtFmiNWELPbWJ2VF4NQeF3/CFgeutZjp8x4Ef4qoS7h0WZqWZ
         crdV92/djZvDWI5o9Vzsf5D9sT7I5zKrusMW4zd570veSJcYDXZthbD0jZS7jEzxeLSH
         7Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385547; x=1793990347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/g4K4FmtPtb1dRwFi9A+STto81LNLv+WliespFcyzg=;
        b=pPC8RV1v8b3EV1tCF50Z5q7w+uW9QSxGagn73jYbiJvhfQZWmGaxvRaxJq0MB6EDMI
         ZNy000KMINPZA+8ya+ryv1wmXyabBH2xlZqnmGCg6WGQFtu3c4W1+s1WaTR6i8JGABqo
         f3Hq+knxgnroYTnMeNXbgKwKZkQvqLxjEw7uyTUP1yJ33LVdMxzVYsVyz34YmPPT5g7u
         yJEMJQ0m4svfJqbdlkLma+BILR1OcsCbeH30P5axL9FUsj1wEeLD1QCsqTY/ResNytyo
         E3lpbmv7awN+3qy5LN7kkFW91Rp9o6W95Ix7f6OUxS0zqRlRMwqa5Qct7h+IucGiNNCm
         qlIw==
X-Forwarded-Encrypted: i=1; AKwUvBzSUPqdfwhF+B5AuPctFOcIANuUpzRFwf4D5WMpxkOWacoFu4U9rdeX7Bfbs7K8Qpwv+Hj5/uc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4Yc2IsvTHt+M2J/uCVTC1UlcdY2L/4EReiefpMN9oXC+1OwSX
	5oJYO8Hgc8vbgBdFQgFU3TPAhHIRZWT1XsQYpvAaBx0dehzGLMe8LUoKOvLOGv1ETRQ02qcvgAZ
	pLPvGRHa/GHkvoTPI3TvYL2rlDn6sa84EDpJqUJs=
X-Gm-Gg: AYBFou0njIBgV9odsCzGOulXyZcLbYCVZm5raN8K24f9DwoD5gK9gwU681iSInGA51X
	Ur4zzTx4+Tff3wkC9UaFP8X30cnonH1KQyartvdYJmYTdJ5TF1eNiks/hvmQk63k+ctO5VtJfQY
	4G8jMpNoQY1D5XBGqvt3T6/iv/F8EzmRWcq4/V8WfMV5zt1SrYvpJUi0l1DiMhFkrP1enrLxxCq
	ANqryubDTNC6t2EHliDlYo1YKlR+kDrd2Jz4GzDbRU8eIvmXFQS2H4c7s0u5pjqw8UQ8oBIUvbZ
	PuCvxFHy+CMKz85gMbZL2tJNETpw2dROzyomkR8H43AW1+QRo/ComwvvgmsdW7O+kaCON2OxvVy
	/E3kYZG7YawwbFscJIgksr0tHBTUQlTDaXTq3fnbZUoUN8sOOjaCRJSOt/vJnh4SLPC/SkWhGIi
	+vL9mo6Co+zv6fyq3M/hL2OCF0zQwPll+qhtntqPxlEwCFgi0Mv/6YIYDVetelBhO3J7y5jgeHe
	PfKfOXYIyF3HCwNoHIjGSa4
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr75097525e9.13.1793385546303; Fri, 30 Oct 2026
 11:39:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030054227.35453-1-dennylin0707@gmail.com> <20261030054227.35453-2-dennylin0707@gmail.com>
In-Reply-To: <20261030054227.35453-2-dennylin0707@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 30 Oct 2026 11:38:54 -0700
X-Gm-Features: AclHuK9S7RaThJXRkKbXDXL0g5Mew_YdBPQsGToRc1UW-4Fiv2yGxauXCnLy0jM
Message-ID: <CANDhNCpUkqNDZL6A5KD+SMRaFtWu=2k+9V99zBe2hnOEV8iL3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] timekeeping: Read getboottime64() offsets under
 the sequence counter
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: tglx@kernel.org, sboyd@kernel.org, mlichvar@redhat.com, 
	akpm@linux-foundation.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:42=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
>
> getboottime64() computes the wall-clock boot timestamp from offs_real
> minus offs_boot without checking tk_core.seq. A concurrent timekeeping
> update can leave the reader with an inconsistent pair of offsets or,
> on 32-bit systems, a torn 64-bit offset, producing an incorrect boot
> timestamp.
>
> Read both offsets under tk_core.seq and retry if an update overlaps
> the sample. Convert the resulting local value to a timespec64 afterward.
>
> Fixes: 7c3f1a573237 ("Introduce boot based time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> New prerequisite in v2, addressing Andrew Morton's review.
>
>  kernel/time/timekeeping.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index dcf47f1ffdcf..7d7a7372f3c8 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2700,7 +2700,13 @@ void update_wall_time(void)
>  void getboottime64(struct timespec64 *ts)
>  {
>         struct timekeeper *tk =3D &tk_core.timekeeper;
> -       ktime_t t =3D ktime_sub(tk->offs_real, tk->offs_boot);
> +       unsigned int seq;
> +       ktime_t t;
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               t =3D ktime_sub(tk->offs_real, tk->offs_boot);
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
>
>         *ts =3D ktime_to_timespec64(t);
>  }

Seems reasonable to me. Thanks for sending this out!

Acked-by: John Stultz <jstultz@google.com>
