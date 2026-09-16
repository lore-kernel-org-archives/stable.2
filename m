Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BD4DAF98
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580125; cv=none; b=nJLEqf0ZFI4EKBqgs4lnui4AT8/eMiIBhry9U+OpykRAJbWFcPyIHWjZmt7N5w2+jLxcY6W+mCoI9q/r/cbFhFzJ6G3cDYSGrWAU033s/f9jUtgsveW1kU7zdOTG8iYacAqOnenOYUVeXkdBio8O+NU0j88naRtphpsOD5rkH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580125; c=relaxed/simple;
	bh=N7/VEIjgndUyqBDVO40aU7cqvnPepfWlnv91dKj0m/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihVC3r3oph2/Fp42jgUzCYHyZZFm/MheqnfhJyeueEk2HVYRyLzl9Fx6puqF4Swt25PMRCcaWsYNdjJi8pARvOobAiSDpUkQqYN58orzppfxkQSifbwRIWFEfvl77MKBj1Wg3WvqYfzvjwOTYJPyNQtcHCJXnRfOcGQ5QEIIpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDriWnEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDriWnEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9219B1F0089B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580110;
	bh=N7/VEIjgndUyqBDVO40aU7cqvnPepfWlnv91dKj0m/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kDriWnEqD6+yfiIJi0v4uFjHkwdoBRJ6Ap9TZn1rQkG1VYFbeG3BbxA0UDfD33UVj
	 XeaH3d4rOniVOrXxh7d9xVgcW29o3Zrhgok+rF3/h4M/K6/bDoo+trz0rZisQHvfn5
	 bbbW6tmJN21l7vhj36rNXb40f61ipkg4MrV/WnwFBxQiO7Esf8BDtDS3JVvLYQGuz6
	 U4Iy6VXIvLmxqjezvLc+XQQGwyVcqXvwTUrekY23/JWg8aOF5V553eJDkSk3RyDDVj
	 zbABjTvueMjPsPHrc0HVbrWHZ7dpzchkFKQ8XCTzv47D9w4xFsBJnhc2im9JfLWejn
	 ogIk0c9BeyYNw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b79784a6edso1391477e87.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcL1tf9/TSYL5TN3qaB6cASXqDVmGsTkFVjhlLqei9N7NEFjk+C24AyK1cyP/t/at//0CIjJw=@vger.kernel.org
X-Gm-Message-State: AFuF++kYNvSP1+m5jp7smI3sjz+B5ABJ4S91IKuanAGEX6BMkQITAWcv
	tcTEqRAJ/kMiO24pTKvJDbWmf7mZHwDRKKsKJbJ8XwKXROaKvnKNDrkC4j2tpUrZ860fauC6ucS
	IVvldC+fU1dtJylsg3HGeI65AkbL07YA=
X-Received: by 2002:a05:6512:1089:b0:5b6:186e:b79d with SMTP id
 2adb3069b0e04-5b8b6664ed4mr983208e87.57.1789580109346; Wed, 16 Sep 2026
 10:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916163646.2084234-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916163646.2084234-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:34:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
X-Gm-Features: AcwNN1WWyvCAlUuXsylbp30V6rpjRIwZU0ilKLYM1MPAZf8OJdK-TPSZPz3xV6A
Message-ID: <CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix runtime PM leak in gp2ap002_read_raw()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	xc-racer2@live.ca, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:37=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> pm_runtime_get_sync() increments the usage counter even on failure,
> so every successful call must be paired with a put. A failure of
> gp2ap002_get_lux() returned early and skipped the paired
> pm_runtime_put_autosuspend(), permanently preventing runtime
> suspend. Jump to the common exit that releases the reference.
>
> Fixes: f6dbf83c17cb ("iio: light: gp2ap002: Take runtime PM reference on =
light read")
> Cc: stable@vger.kernel.org

IMO not stable material.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
