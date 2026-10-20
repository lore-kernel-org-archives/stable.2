Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503064;
	b=wDsgasoMFmm1hhYlufF+/ElDdLGeO7+FCVTXpbrjL1bg27boq4p60NfAxhVirSJbIzIw
	 Zmeu+3AF4jXtFM8RSoXa9mtnNs8q8cBdLIKpkocUJ0A7790LHkrvuoRbt4276bemenCgR
	 Ckdb5rx1m1nLZmOaS+pRYgNGFDFQliWCrwdqA2sW+R2CoZ1tLgCrY57BpyNvvsSUcAgVM
	 B02i2PezrxXtxpyr+BlO1p7TlSmrMDsM2YoOZvkPCDlvx87e8V4T7prQdqVCuOc5Fw4X9
	 xvkOV88ue+cTGRPWZhLn+Xyd8ddQ5tpQYdB+M4Q370NVAYBnaozfih9amF3gsvmtxDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503064;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=fgA/Zhp68dHEavBmIayWw25ZtfdqSPSrDKUimhdzG9U=;
	b=iV4a65Am0WzAhUvuTfwrXaNQZ6dMmkHSBdg5HDzJvZ02FiRama3aUWw39kW4I11FCyfG
	 ASBYkc5c/VndPeJ8SeJDV6QcMNaweC5MPKlcKXASxyeJ7cZzeJ09WcBFKdk7nB8hsH6kL
	 DmlrYxi5mApjDqxW2ZxJWRKLU+SSqnJ3Knr40ew1u4d4Ta2CoIV7vaRdo45+8zIpV2C2R
	 ltCz1jleMxpkQDaKYzXkBa9dw7J8KYiPDg+0O1Px/eOD0ClAK/MLbwBeIhz0hy9iIoZeY
	 vaFPnmhPWqs2nYrAbovRB0+mpV9gqvVwnF7dUc7d2aj355OB8mRtJvywNeiSq1ltvyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPlXry69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292460A4AF5
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPlXry69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250691F0180D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503064;
	bh=fgA/Zhp68dHEavBmIayWw25ZtfdqSPSrDKUimhdzG9U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=XPlXry69G9PQ7JreqGMjCzfXo64H9ICYp6PlqLMX0ix32KcTuDYm2tuMdXcm5Qjyi
	 zYoriCeI0+5/z1j+sKSkuvAjOfgF8XeRblPHFUEO/CdCInOwcerSMJ/qsnWeGQFnDc
	 GQxTf5z2YtpsvOg1M8lIQxy75AHfYysuQs9Sa6PYHm331QEwgrU61uzytC4nyr8TCE
	 LWpIjQGGGGqBjcg9ns5JxToqxheR2rcwME2ZspJuYEntTA2J3wnArW8Q95tN/oTbqZ
	 T8tMxvuGj3DHuw1aLTLncnomdJyqybOYENU+iPec7w9Tt7vu5GJAtlJMuKHrDVQaiN
	 iZ8yN98+El6sw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a75f960be3so34721731fa.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:31:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcnizMVZa5bdSc83GMdTEp2qqv+FLbfBZ1HHIU0OGtYYvTj5KTp4uLssnngfr25jN2rR+1Gy8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ1Ez7D2pnTD+oUAL5JSnhIrGPlgW6pXZhWHps427xv46Vm8XX
	GSSOs8FRpdtPdB5reZrOBPtcZLZ3dsFRAykPl5KjRKdAhzusO+Pdl9RCOqPlguaMfo0lvVCM8AC
	N9JwBPfF24RylfpFqgpNxtRBmEouSeJbnYDM39wbYVQ==
X-Received: by 2002:a05:651c:2111:b0:3ac:41ca:1104 with SMTP id
 38308e7fff4ca-3ac41ca13e1mr919641fa.0.1792503062833; Tue, 20 Oct 2026
 06:31:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 06:31:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 06:31:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 06:31:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md+y1SRft0+qWpy2Pj=ZK6TL1hmBWCq0jnVBxYDmQnu_w@mail.gmail.com>
X-Gm-Features: AclHuK8JpK4nWSYDUH42Iv3zGzmNhtB0xqKaw0hDbR_OOIMnU3XpnrmRoofeLP8
Message-ID: <CAMRc=Md+y1SRft0+qWpy2Pj=ZK6TL1hmBWCq0jnVBxYDmQnu_w@mail.gmail.com>
Subject: Re: [PATCH v12 0/3] crypto - qce: fix self-test issues in aead
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eneas U de Queiroz <cotequeiroz@gmail.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Abel Vesa <abelvesa@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 14:47:00 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> As requested by Herbert: this is the aead part of the QCE fixes sent
> separately for easier review.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Ok, looks like there are no more sashiko comments on this one as well. Could we
get the three separate series with fixes upstream before v7.4-rc1 to enable
further rework of the driver? Once in linux-next, I'll also resend the driver
adding the new module parameter and removing the BROKEN label.

Bart
