Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854643FD09
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243546; cv=pass; b=NravF5MOmEatzLN/una2fTqTYYrskBs4KPDvu5Kczo19pCs6UVsB8pf2psas5lJtUANAjVO8Y9w6MInMkB6R4b8RnEq7EZBKq2QIel9/QhySfqF089vHdhi9TgSvpd6cZ32sF8HV3poUmmNUoQ6UDQ1JG/U0NEGaJpM0Tx8xUf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243546; c=relaxed/simple;
	bh=PW1zCvq/ozVI53ru/7Q/LImJLODk/Q/cpy7eifbxXfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i55nqMfDdlzjMFCuC8sQ5sTNqNRxbbQHx4yIKkD814LGtGIs4KcCABRpwZbCXNCepDzlf6gu7LY+UZhjGvTzk4GNw213Rx0vbqaSYuhbmdwK/TJYUM7TkLYAPHYwyaMb+/1Cv8VvZdVtZjLOShEeLTWCqL4e/UTJYB2t4bxjZJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rruectjT; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rruectjT"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-859023466e0so1562007b3.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243530; cv=none;
        d=google.com; s=arc-20260327;
        b=Xnq6E3oqPRPzZLRN2QTmJzFcH6mSuiW5042u4DTF9AJVTH9NlFtA0Lg8Ljq2MZFYLa
         25hBz15aZGPEuOoItDexZZ84U2yUvyVdNAXvReP7QFIXvjZW+WhcbGIqTPPPocMDSsBs
         jseRpVWdpR+7hxt0G1RbxaKlv4ZPdLxmcSnbeJ9ybRo4F/e6c3rqEXJiNwT4KUtKNxqL
         wXr77HJmlIIpsaAuQL3jppXC/oJoORmrLuxthHL5jxyVCHDqk5A4B2KaLCRd6iUtvGRi
         OcB23+x0CziKVdSKDrMe40ERRCxhsaGnNQEwdbq6f5NFPqGfOEURizQ0aXnryx99u/bA
         tzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2s7BUiFW3srljLC0aZ+G0xvX1DREGg6wj6UTgtwrW4=;
        fh=pe4yxGTPlUiLcYP9wTlceFSN0RYaFDhuS0pEtGXtc4w=;
        b=a0fX6TmSzGf7xMtp1PAYklbYzqvbHiuJ9xd1qJboH4lfll6EIi2cIEEfJ/K2Yzxtua
         dlF1SgjmPG4WI4184KVGQ60KxBwk53qIN9PxfuLleSoF0BXwctO9c8EXQtyyDN2Yd7Cb
         B6j6tqPlbacSRMYi55Pc+uYIZBPw0BsNeKvxrDjWDskJom7FVp5Y/8UsKys2L5JCibAG
         YRzxCBAGCWk1OD9CmrSwEfhBw5X/UwHCdoDa/T/mlHzYKAnuFld6pP4iCENOomkbhBCz
         xaCPezjSk3gwtG5eJleKC4zoFP5gZpwFf/V+9wSE6kWpOH+ROdSDLPw//rjEFg8d8TYM
         bjxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243530; x=1790848330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N2s7BUiFW3srljLC0aZ+G0xvX1DREGg6wj6UTgtwrW4=;
        b=rruectjToVCx8lTL3jZI9PEFjCwIWPMdP6uWR0sbOTo96j2MACHPLkko5QFRDvD4Dt
         2oO+sC7wbD6/GuQC6k9vo1l40ZFb8MloB5j1jYlSf27yxhUigm/xzVnaUumfSubt/+ne
         nRwBZMqsjv5llQlAZ6qsI3LVrZVhbqBGszxPwr0NU50w9k/f+3EKrW1VC51746hdwNPq
         wSecZNEKsA7igTfxCqyHJQFDGRBFOxxWt/sp0ZhXOSso5z3bj7ty4deUsly0bhO+kypj
         aRZxxeYeiwm9VD7/6e9+xRQB5+br78iG/1hwhV2m7og5dlh1gcF0S1vKH3Ztd89W036a
         T2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243530; x=1790848330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2s7BUiFW3srljLC0aZ+G0xvX1DREGg6wj6UTgtwrW4=;
        b=bhdF9OgGTvNAgHOcWX9QLISzT5CXQV2/SierROy6p27iKZLLpjafKt8PpHUPyKJGgN
         R4CXGWjacFX/unjsjMAV+scis3qeNi4nB+ZxnEWhsIQkB7cft7qMyvJ9Ih9n1W7jiCLx
         OtxnixSYCqj2Ug6TLAkSfDWaLS9fGPg2oWrso6xJ0un9aw8gqIYYyG+VjSAwBxj+sYVg
         DqJ3lBS5DHarnS3PGxAqVTb47rvx7dHwoJuI3/3LVuS1XNXRaT2zgVJpPnK5XxGD0ZDi
         6iVFk9ovYzzOvtxBn7ZCm1JjoDmLI4jKBe//U3fJouLlLEgC7dmQwnTm6juYWAIdl6jP
         2kaQ==
X-Gm-Message-State: AFuF++k0gBBEXBwew6rl+f2VhTUzIHSM/8Or6aEshGvuu8QvQk4TapfD
	11VmFTS3XNIMiRuvHZAO6/b4J7led9qdDgoc/Bugp4y+4sVe6xZnhPYCIGcLvSLiY3GC0mS2ivd
	8s7x6ZYQ4BsUlRqHxMnOmS9kXM6RKWY9F5dPY
X-Gm-Gg: AYBFou3dMXPTStbTOddg6yOCZwGxzOHDMPJKHJ0OCRwOVaJu/xYvEE64xCFRQymRfdb
	KDtxSjKuIQt3jKbtZ9k0+oVJmBq949jWV8SyXVYJFXF/Psyhgds0lwuqD5CbL2ZIVffkrCQuUvJ
	6VhosJN/lC29LDCb1KyjGjLhAFK0K/bkWeHlzgKIKWwM5QK8+4diU3BPfZ+h42DUOko0lYjl98m
	Kx2F9QYnh/np1fe2PjFhBQ+pzML2GxjTVa71r4ubQNhjP0WXBTvwbmrg3eHAyFGFQZXSkpB4jrM
	a98i3UctfyekY1mPkiCPZPi8Sk7VWO6tTJKdNAtYmk83qsUedALa4IfEMkA9ofiiD54=
X-Received: by 2002:a05:690c:4a09:b0:841:dd38:a734 with SMTP id
 00721157ae682-8a64403f287mr18562517b3.0.1790243530155; Thu, 24 Sep 2026
 02:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922140318.668429-1-itai.handler@gmail.com> <2026-09-23-daily-reply-0008-re-spi-zynqmp-gqspi-shutdown-5-10@kernel.org>
In-Reply-To: <2026-09-23-daily-reply-0008-re-spi-zynqmp-gqspi-shutdown-5-10@kernel.org>
From: Itai Handler <itai.handler@gmail.com>
Date: Thu, 24 Sep 2026 12:51:57 +0300
X-Gm-Features: AclHuK9FhNdAh4A60RkaACsXXPA-TomQibdwScmPR5kKOszFUTgb8gHglFMTNsQ
Message-ID: <CAFpOueS2DVM-8JT+tZTtrJtWZ0ddz5ehuOHR1YKPK81P5NU_3g@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:21=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > +     ret =3D pm_runtime_get_if_in_use(&pdev->dev);
> > +     if (!ret)
> > +             return;
> > +
> > +     zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
>
> On 5.10 with CONFIG_PM=3Dy this check always returns early, so GQSPI_EN i=
s
> never cleared and the kexec DMA corruption is not fixed there.
>
> 5.10 picked up 58eaa7b2d07d ("spi: spi-zynqmp-gqspi: Fix runtime PM imbal=
ance
> in zynqmp_qspi_probe") and then reverted it in 5.10.199 with 1ceaf0d3a883
> ("Revert "spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
> zynqmp_qspi_probe""). Probe therefore ends with a pm_runtime_put_autosusp=
end()
> that has no matching get, leaving usage_count at -1. device_shutdown()'s
> pm_runtime_get_noresume() brings it back to 0, and pm_runtime_get_if_in_u=
se()
> then returns 0 whether the controller is active or runtime suspended.
>
> Could you send a 5.10 v2 that clears GQSPI_EN unconditionally, as 5.10's
> zynqmp_qspi_remove() and zynqmp_qspi_suspend() already do?

Thanks for looking into this.

I agree with your analysis of the 5.10 runtime-PM state: because of the
probe-time runtime-PM imbalance, pm_runtime_get_if_in_use() cannot be
used reliably in this path on 5.10.

However, I don't think we should change the backport to unconditionally
write GQSPI_EN. The upstream patch intentionally avoids accessing the
GQSPI registers when the controller is runtime-suspended, since its
clocks are then disabled.

I'd also prefer not to introduce different runtime-PM/MMIO logic in the
5.10 backport just to work around the 5.10-specific usage_count issue.

I suggest dropping this backport for now and first fixing the runtime-PM
logic in the 5.10 tree. Once that is fixed, we can revisit the GQSPI
shutdown patch and backport it with the same runtime-PM logic as
upstream.

This also avoids potentially accessing the GQSPI register block while
the controller is runtime-suspended.

If that sounds reasonable, let's drop the 5.10 backport for now.

Thanks,
Itai
