Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866069;
	b=kBk2sfP1ETKhCV2/GYdtT9J2JmmWApZLpGEIT9rQI+Gd1HFx87iIKzqrqY/Rl31hqEw9
	 1OkhJEK+OCosLDKsFqigHV36ZOi+K+6p9SDlDPfgY6QAaBuPgejL43k84IcbYmphGJbCE
	 HTTo4BeUohiph2OwSJYF4dQUZZIRYuvFJH03GQcMIcQ0nJqL5ouHCoWFDfododxQ7s2KJ
	 1U/+bEbqWlvgimQJdc8GQaVMzom1H2/9YdkdvxSW64dDQD6AiKZXNCMr3E7gkgB2IFuls
	 JGC4QIplK/p5DxkEUEvp3Z8nTzPhfq70K0EZ4Xt37nVqjW5sq/Lbkx8sK5qZROsRu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866069;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oWw6g0jthWHcK00OlOBDH8ZErsDVIEACI1zXshUCIAE=;
	b=y1NHdqmD0Y9Bs3p8Hso8pylSTEyq/KztAJex6U1s5luV0hJECIxvNXjmacobMi+9GxU4
	 21lqXFR5qC3qt9TZ8MNGOu/k24d0/yCiwLGY65o6BcNUUFt0IMPByQcyUb369DFJq/0D1
	 dYlGqHIfvRD6/aBC7YD8fqw49/nwJgdlM76Md/fWUbplLul4NE9/JYkvgQLVTNfMoR+AM
	 PgZxWWcQCJwWedRqWRws0Snr5ioNOJ6Y5wb2b0KTHcDbGgpen4wBtOpA/FdOhud7AOvmt
	 fez4YR3cQ6SIx5VAg4MzuJHUyQ+bpekPE3a3l721RkJs0T1p08CXEw0qAs1HAI35Usg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/ndCYbh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5969606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/ndCYbh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911FE1F00A17
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793866068;
	bh=oWw6g0jthWHcK00OlOBDH8ZErsDVIEACI1zXshUCIAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P/ndCYbhdbtqEun79Vph2rce3/JXPYFPOBFypmgdRmbCszIrnzkMWkiw3a2VNF0Nd
	 cPXdWft+WQKKbBHb7+OmRC3nFUZkwE97wqAGLD49/FUoJz/1cEGl47H+LnJWkjinli
	 VK1Q/y73ecKB7dkc7xuvdfKYO4zs5nERoEL1sH+5PpSjkus1YHrIYqTosGrm7b/gmm
	 ZlH3TDYZFtkAP8tCHwsx1JjYBFAGx2bUrc7V0Te7RfMhfiEZ+/7xf8M0aZkJ6qJh1S
	 i0YQ9haF1bM3TUOOZwAhqttK0EsRnL19gfHV3rljq1yuwsvS2KLG1N17kZ4AYSPwqW
	 new6XlGg+GP0Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bff8fc7cf2so733299e87.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:07:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzxxd0HdfUzMamC2e/enf3FvPQzlkBMVaGOIKbSERbQ/rj858N8NjIUydSUTK8etSX0uLiChE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xjINbKdlN0qBZ08Yx6+rNpaltdaxPdTt3m6MjqwdZHCCwcqhK
	lQLEyWAZMPztrvy2Hcon9YuP/cVjzn9TtyVjEaahJAqit/4P2pZu3yZtmhb1txZd084CUvxJDKm
	ojU3FBSNoY6b2tMUGZQvr2eEaiBFKijg=
X-Received: by 2002:a05:6512:3d16:b0:5bf:c12b:b2a4 with SMTP id
 2adb3069b0e04-5bfd9576cc4mr6718239e87.42.1793866067307; Thu, 05 Nov 2026
 00:07:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
In-Reply-To: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:07:34 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Tf=DJxVG15=83iM3912rPXX5Jc3vxVL3fEH2vBPMrxA@mail.gmail.com>
X-Gm-Features: AclHuK_M9jjzg90MLmcasn5lZzRt4G7YZKrjtv0uopGRfNmYQDYOv9JvKa_9M2w
Message-ID: <CAD++jL=Tf=DJxVG15=83iM3912rPXX5Jc3vxVL3fEH2vBPMrxA@mail.gmail.com>
Subject: Re: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
To: Li Youhong <dayou5941@163.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nayden Kanchev <nayden.kanchev@arm.com>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:08=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> The interrupt is currently freed on every runtime suspend and requested
> again on runtime resume. Apart from tying interrupt ownership to the
> power state rather than to the driver lifetime, this leaves remove to
> guess whether an action is installed for the IRQ.
>
> Request the interrupt once during probe and free it during remove.
>
> Disable and synchronize the IRQ before powering the ISP off, and enable
> it only after a successful power-on.
>
> Hold a runtime PM reference during probe until the IRQ is installed,
> and stop runtime PM and drain the IRQ before unregistering the media
> entities during remove.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linusw@kernel.org>

The PW bot replies:

Thanks for your patches! Unfortunately the Media CI robot detected some
issues:

# Test virtme64:test-virtme
Error running test. Final Summary not found

I take it that the PW bot has issues with itself (don't we all).
So not my problem?

Jacopo, do you think we can apply this?

Yours,
Linus Walleij
