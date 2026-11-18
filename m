Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096364;
	b=1LTd0mPgT1vEgNUigu+BCJQwRd9/p+pPYk+HyvwJGfWEv0zIArCgd4u3Qw2iJkc4IxOG
	 WehxPn7dzwGXE+U2do/sidvldg/f2p9oEs87x6KZlw3uPJAJakhYd1rsMuWAqUoO0y6yg
	 z8nk0jucHOf13MLr5WD2GoZ7F/WV8pyYycQmoqsnqI/VNR1N2wwmAv+z2eks9Fjrzrulm
	 2Jq8JtkGyRM/9bSvPNDtYkvJQquuUZNJpyHiOvOSHLBgdHUq0wdvfly5ttzY6YKWXNqT9
	 1jVTyo0EGh2xNdkEq9aOAcSz9uO1x14mcpHBaiZEIlnBXIk8J4XB49onXkC7UCJ/3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096364;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1v+GQzZBBpe+D+JaaeUD+TTuTBjrxr3SvBnBix+qMDA=;
	b=zMZnng0IO4RSCzKhW9ZpT9BevpqWqy7jY+caEoSIvZOgMc7lf+zQCl/khDwcW+Cd+v5J
	 L/QNxfJ1HSuHtv+erMFDfb3CcvbNOCgeHkxLalksSMMAiLicfqwAi9MRHS3SV5SIi8gWd
	 YSdib0hZejCsplBETLlfgGyvYgxjKEKxlaS9wxSvzLVT+FXiCNmYym8CWhozLQxeC8UYs
	 0Ulo/IH/yNuPQf45/9rmEyTeIy2kdUSXkY/yjo+gIJUkU0XJW1IJlkas8xAkZOR+bOl67
	 VYOsSf1rUEZVJiusFmsCx/AI0e50jkVrr8pxkysoFSX4kdsM24SfzEgyq/LUK4wjmMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StApwT8g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA7606A33B;
	Thu, 19 Nov 2026 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StApwT8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8741F000C6;
	Thu, 19 Nov 2026 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096364;
	bh=1v+GQzZBBpe+D+JaaeUD+TTuTBjrxr3SvBnBix+qMDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=StApwT8gS9h4KHXEBoSfFOAEIO3phFzwFCfKHw0qTHseCh6otpDeUGLM3Y01CKMCH
	 5/FenZDSqZX+PBuJ2tFrdI7Q3QAn7omygD+Di4VyvqEgpb7YxFVtKxeRrQC3I+URvl
	 MBfJ/yHR5zjBwb52Hcd5IAcreO5SsH4MZH8jGCjfsq3NWuwnsmaoQlvCjq5ALT4uHB
	 LUg5BlNd3kp7n2+v9Bik1HvA6vInW/gevjRBAmEA0YOGiCWzjSYhgTMb3sumWKGBdR
	 auNnTkbb3TIdqIGbhTohTwRbTpVoozpLPaGsf/THf+3ZkJSzn9revGAWOiIqgAswur
	 eaJwa0kTixIEQ==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261118014051.75468-1-mhun512@gmail.com>
References: <20261118014051.75468-1-mhun512@gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5663: Stop jack work on probe failure and
 unbind
Message-Id: <179501032459.349622.3483721498990164229.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:58:44 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zQ6CEuGqYxjIKoqS/jaygijZeCEmZEO9DicDe4ml1hw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+/desee8RWiEcrnFJRPRnqae0TkHo4oKfD2OuihuzG
 BfJOL/qKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwEROlzL8TxfYJNUrei2CT3jG
 KV5Tk2BR496/UivC1qTwTBR32DpnDSPDolLXJKn2EJfmJa+/3L7sf2HatcnpwgYfX+V8zFi8l7e
 cCwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 17 Nov 2026 20:40:51 -0500, Myeonghun Pak wrote:
> ASoC: rt5663: Stop jack work on probe failure and unbind

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5663: Stop jack work on probe failure and unbind
      https://git.kernel.org/broonie/sound/c/8a20b9963c66

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

