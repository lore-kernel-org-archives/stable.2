Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6642E013
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730632; cv=pass; b=Dek+UfaM6XVqoLjtak7Q5iuWadoQhhO/t7E0g3H5VJneK49Q8piOkTbm51wjjp12KrQk2/AET1nj1SmJojaQDOgvdBAPNOeS2YPe+BAeeslJwhRq8CQoKRtaA1Ae+OygrJRmYX5/riB60/nJzJ4eJLuRykUaIyiXFqaMzlvv+u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730632; c=relaxed/simple;
	bh=7a8cSShZ/qMj+tJyNWKjrBEs8maoUp4p4bZ9r6GxGyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA46YPMYuILwM2wcrglg4F2XL2x7yctLsgq6gyLKCkESAEqRQJf0rJDIl5b6uBaHIi4IPdyXDduMUHR9vfLBB99w4WDlrsn7ML6uZ7qnn+SwGK9QdKRCdp/iHq4yfbhqq/RkydNCmDeK7qfkfqxkxt1KhLuRULn99O/CWXx+kZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0xJpInk; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0xJpInk"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c315729ad50so205418966b.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791730629; cv=none;
        d=google.com; s=arc-20260327;
        b=VQJTW7pBpCwPmWQmHIam7buXyGmitOpjCmkwpLyAiq8gYQkdERGb0JQx66Dewv28u/
         BmXIFmuoGYyKp3IryfaiVeqcihhAV2gYE/Jul7k20H8CQqr97AMC2Ot5wV0sp5oyQ2EN
         UcT0SH0rUqwRC+DLSXFIWAnQ2DIjqb/vq7ZJHs1mkfb0zm0qpkv0G1ZlkFHRhxklSEGF
         KNn1nbUwPhlSu2ZqYJseTqssGbnnpVQ+FUo6HUziu99DItiZewaSHtMwPh3xORAM/d7I
         R/kqEJ1cegR5TkUqNf79JnQCkvtL5gtasmn4LHzQ7FKe14FcvhGsxwSqAz1vAtBEEqNM
         1CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7a8cSShZ/qMj+tJyNWKjrBEs8maoUp4p4bZ9r6GxGyI=;
        fh=ajeoTBRkIR/3EmbV6o4P8QI3/E3zlW7r6hbff0BR/es=;
        b=Y9ZnwfOpfhrRiTrcyv2p5eNKAVFO3IO8TRvADbhme2tkcsYbSFsFW3sjsKzJZr7MMm
         aHKh33D5riRycRkPIcvB7KSZJNyh51rG07oPV0hF+XIBPI6aKlOARo/hkvfYYrgCl0OU
         m4kLKfNsYGk+ylaEGA7dPaUVKxewz+BxThisDFqhMVrvElno/zVnJYtk4bippO5n4bjq
         PAXFX7T/xYEU6b5rr5RCJdnD5AAIVDb9aiXiecDdVwLDRJ1FYTfpXL5YdcvPAGn6xGGM
         EcyQFWMthbEMdSGeUXOde1gFoBjwNbbHEbDfXUUPCqRMfz+t10EY3RNREZLZJsV6M/w4
         Ew0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791730629; x=1792335429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7a8cSShZ/qMj+tJyNWKjrBEs8maoUp4p4bZ9r6GxGyI=;
        b=T0xJpInk527P5Uc+kfKw9g1/+JuinmdKqKRLOSMytoInRtojBvFdDpsoO347ZbpSth
         hvht1KCrikk6yKfX5/3vgRYcaU+cbAo3AJWTKZdH8RuwgWpGvhT+lAw9F4hp9OWEfq1R
         USneKZoGAgTh45Aa4pfCLGDAHju3f2uEFHHcyqo7CBZ8m6pJJgF4+TNEokUx4KMiudoS
         ezIzflUGTgeDBKu5XQRtQTira9RgARSlsN2x5wLSdIRu7x3biO9EF7/d0yG2X/jkZczP
         vIEHkjo3Z69iuYLpxg/sPi2V7wDo44se+n1UD2Yq7y6npJjRZ2yqSE4Ei6MiQMp26MYw
         8EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730629; x=1792335429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7a8cSShZ/qMj+tJyNWKjrBEs8maoUp4p4bZ9r6GxGyI=;
        b=AvgJUbK5foVRmJIHJoH4t3rKtP9rIuuvzmNc7lGWvz9+BFmGO4sC/MyVTWvZdPuOXn
         kYJJ49SdVscEhhTZuDByQyKsQgk72evi6Q0GjmqFmbSxdn1VlOzSbFhnymFDPO+P3epb
         w4LQMy7TfDfQqMqPrgK6A4yDPCmTYQeuTZL01DCoFGRrT2OMyQK92b25w7BgchH/T5iT
         0WeKLPkwwl4xFObVJLCtaIGHFZ997bmNCK2Y/17bRN7zNlA9wPuBw7Fm8adFtATa5sFb
         bjdc74x9ycsgrRxIWSqQITAEIAi2ymZRhRTESAc/7zEAMCkrsGxGYakqIBBqy8iDrDwx
         JK5g==
X-Forwarded-Encrypted: i=1; AKwUvByQzZwHtZfVUxlYRaXD20KQeo/Yr0ApylNUTjeDCdrYig3LBU2vCIfac3AmZW0E6nQxybLaLuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdyo4JZGlNXFneAOlSBRQUEEezX7qWYo1wT/ITtl9t+1JFUWOl
	0fWLGEBCciC8tEXI/oYr7jmduGQBFmMlqnQfMbS4UH0xGKeCBUI0hJerdy3+LpDTadPygBZOvsm
	ej4x+9qEX96APiFfgPHMjUS9e6geTzqQ=
X-Gm-Gg: AYBFou1r9UOIlmv83ev+PkaB/4k+N8AWH4SgjcsEr+z7xvINDNayCInnqXobYr8D6pZ
	PAb8jhSCbCIBvK2HWfNF/yckE5Fsf6WqeEBPPrbv8vWpajokZqYQ8wbu0AOaApHraJykVgrX2Mm
	2iULA1pO3LX94z0wA9Hl7tleU8R3GXelXqX17XEXB18bkQyVCboaeJ0gmCpBCjlCIElKVBrNZOr
	T5woLQ+GZ7PR6zVM8Z4nZeZDTDKN5IFnWnkUKLQXJ+dvF4aHhexeybCNnlq2fZCEkFQiAIfWNue
	ihUZPJgK/i6So1Z/b4DyDhoQllG4f21p3S9kAN4fupIk2H30F6jih/VGcWY78GgLi58GxzHz3Pk
	TOi4pdI3kunn4tGxAd3pqXZIK8UBcNQG9kE+YKDPTpg==
X-Received: by 2002:a17:907:9801:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c31a9fcedffmr817973166b.13.1791730628876; Sun, 11 Oct 2026
 07:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142533.974797-1-linmag7@gmail.com> <20261010142533.974797-3-linmag7@gmail.com>
 <CAEdQ38Ep+cu5ssTGtb5OQwHGRB5wz+crTfbV9GM6wVDdoZqfmQ@mail.gmail.com>
In-Reply-To: <CAEdQ38Ep+cu5ssTGtb5OQwHGRB5wz+crTfbV9GM6wVDdoZqfmQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 16:56:56 +0200
X-Gm-Features: AclHuK_oI4gPnyqjertogQ4m97YiIbt4SsFZC0bAfaR7XMCYgwEy5pWfnhxRf0Q
Message-ID: <CA+=Fv5Tpq1i+YbkqPUZBTxv-m9=q3iFPNGfmAKwpiwF2FdkZvg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
To: Matt Turner <mattst88@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 11, 2026 at 1:32=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Sat, Oct 10, 2026 at 04:24:28PM +0200, Magnus Lindholm wrote:
> > code following alpha_switch_to(). New kernel threads take the same
> > path through schedule_tail().
> >
> > asn_lock is left set on that CPU, so the new task can run with
>
> I missed this in v4. New kernel threads do take that path, but
> context_switch() does not call switch_mm() for a task without an mm, so
> they never set asn_lock in the first place. Only a new user task leaves
> it set. As written, the two paragraphs read as if both do.
>
> Changelog only, and not worth a v6. My Reviewed-by stands.

Thanks, fixed the changelog in for-next to make clear that only new user
tasks leave asn_lock set. New kernel threads reach schedule_tail(), but
skip switch_mm() and therefore do not set asn_lock.

No code changes; your Reviewed-by is retained.

Thanks,
Magnus
