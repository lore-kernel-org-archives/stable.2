Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484447;
	b=Gm/OZGpq7xBv89eSh41RyiFFIlB971adhUW6Bfqre7c7wraqoFUQqnPHBEV4OlN7UEP5
	 KeXYdWPpoJ0hpBMfAaYQK3GsKQSpYgpJglL/hwwRk3rjANpvNCs3RpTah/lIyDD2rmlF7
	 WI1vQIYU0j1/3LhLmYRF0eo0qSEgNr+QiEAXiLJr22TOEXbNZrqpIeUJoUsV5p2AJuaJ5
	 wBIHtX6PdcXxuJTEJSCXeDjBW2qQv/dyMLj+HIpSSIXTq3iPs7jgHTFmbOurxO5v8QfDU
	 Ung20DbPsoh1QyZFEqWp49RA/+fhfyo6k+nc/CZn+96Js7GtCNINZH+/4Q+SkXETgUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484447;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=kKIkBo5KGbrigOoOGFBrL+Ie2szW3g61E8oJn61TwLY=;
	b=axOW3sSrwXj35YidrPW5LcDOekcip88E5fZ6mbIvAFMAck1Lqm0CKvGcSvyv9nNZlGmR
	 MJZ9Nnou69NcLVZU1OsF99/6lNCDd8T9fDVxrQXMhm+dmzoLpZRlBw6Lv5nxAzjEm/bek
	 E8KmzLFNdefqY53FR3xw9zy4Tv2b8IR1tj2mLqFF/AWnUDhvQH85oYO4EmCNz/4AUOSEa
	 LUqzzW2A2Sd5KSaOEWqaFeBqnGm2OwtorQtU2s1tyhdcpTuPY9l+gASO+m12yXuylvDB3
	 Xsi+aXd5ZZ8vHnTULhuHhRgCWwSoisD/Q2qrV9S/9iKBNHkCJqSeJsLAq3ti2zEljzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6lBqTfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8A606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6lBqTfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635831F000C8
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484446;
	bh=kKIkBo5KGbrigOoOGFBrL+Ie2szW3g61E8oJn61TwLY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=c6lBqTfGQbD7J9aWnxvxHxkgCZR19XPuTqOlwDbH8HHDJf4kSl9xPUNYTR+4iJCvv
	 8bcCgI706nA8r9oK5fxcR9AuJ+cY4LU0yMxXpSGnqyQPoRGxj7s7IUbIoQhYuMEOxI
	 EPR/i0BT8ufguhN8ZeClkIxcrKYB15+10TisgEj9n/0QJsKBfbRFbSmESJTU5UdI3p
	 L/j08Ql9+HbWnGssufKXYQS00X8LrwWFxOCzcziz0WNo9pvHfEcvzoFKHVEgTZxQFE
	 T2WKZASEuL4q/H4L0gDri7fbe5CrSkBwgQ2cDA7lXANWpm9ua/IHNeDRdMe2W8R5EG
	 yrlsdZb1mjeKQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so2075313e87.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:20:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzGumifI4xQkghLygKWbMnjKLrw7vj3Mykq0qkYNu9BbZDjQtHyVBAmVy0MYvExaALLUcu6gYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/qGI7hr249c/TxTHDfeQWkfSHjNURr0Na7rjSOY2BbyaHDCty
	8ZNo0TDLlKrzyQfwQ2+GeHMucvRUwCkXyqcta0goxufZTdZUt0difpFQvVyEqB/vVw7O0qHUCKx
	HNykxf54jQHyVxOngVX6jG+Ee+KLgK0R5wzbWCCrV9Q==
X-Received: by 2002:a05:6512:31d5:b0:5be:55b6:7a92 with SMTP id
 2adb3069b0e04-5be55b67a9fmr2509119e87.30.1792484445158; Tue, 20 Oct 2026
 01:20:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 03:20:43 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 03:20:43 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261019-qce-fixes-skcipher-v12-0-046e6be9bd83@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-qce-fixes-skcipher-v12-0-046e6be9bd83@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 03:20:43 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mfw+gy4wiQNH9wCY3UeyHa37ZWf2FPHi=30dccfenqY2Q@mail.gmail.com>
X-Gm-Features: AclHuK_I405DPm3BS8wwZk1JHxnrPGnEzBl9zhK4ySt7lFNe8JQMTPDxLEmJBRU
Message-ID: <CAMRc=Mfw+gy4wiQNH9wCY3UeyHa37ZWf2FPHi=30dccfenqY2Q@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] crypto: qce - fix self-test issues in skcipher
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eneas U de Queiroz <cotequeiroz@gmail.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 16:46:04 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> This iteration will hopefully fix the final remaining comment from
> sashiko.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Phew, no comments from sashiko finally.

Bart
