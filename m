Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175984;
	b=JHUh+AW6Lr3htnwMe7VTqIBOGVcQVsrOa3eR9Wl2Eygv1DGk47cCh+Xnq1KkTTGGdwct
	 UIL5UQEfhJEil9jLomefRd1XxfMuWq5hPWOiB+PqDOxGaiqMvuGFW6wHbQGtCreuYGlHP
	 I4iwn63jJ3dlDzXr6H7H6gVPEjA+zdmLjpsiLtX/WrI8e0/Rrn4W0WOgxbvKLTALf+ivR
	 lFqovP0r6ZmXIXmc5bsaw+f1slEmNk8EVkASqIXbd0aNkFQpCT+x/s7YGTL/Dt5futLNI
	 exik+/GIVhkbjRUKWrlexMnV6aKRBsCumz2LWEhwWsZgGdz0WXHyAVYRHGE2j5fkSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175984;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WTa184/D+dpYU0m9TvKEDuuAyqsQWzsiGfAwCYduL4U=;
	b=s83S3hFQMVi2iK0aBvi4QDqM4LsDuLlby3YCaRSCkxu7nDv4cj1bEqMEw/f7fELL8C7/
	 xTYL69qYtqaSnU1YIiChdTCgc07SnWAJM01qzj9Xf9p7aBTuHWKnLyWpFvCT54lobhTEw
	 xa0bIQ7AjOGxJkFFU37u/sDEyZaRLizjWyMmjs2PE6BF1mi/gsCdO1AjmQzcmKM7mNiC3
	 H7XjCxuX/pF/PB1gAlh1XN6fzPtjDlDcPXkrZ8ACHrCocpTcR7d/E+f22Dn3WnmgY2Yy9
	 iW9ozDaJi7SCve2QB70JGCK3cBizsiLx4MOuiXOEv7d/97JhGHgEdYadK+rzHkjL3qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcIElR1k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D18606A32A;
	Fri, 20 Nov 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcIElR1k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E122F1F000C6;
	Fri, 20 Nov 2026 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175983;
	bh=WTa184/D+dpYU0m9TvKEDuuAyqsQWzsiGfAwCYduL4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hcIElR1kgyYjVB711wffRIUQb9bbkM02G76Ur5QJ2EHX6DiUZGqKDFuTPOFok1kvj
	 yyrx1HcKf+58DBr2s9za6z3ahRBbpBQTRw8Pm0Gt6PkdXcyhMPH6+B+kc0SdF0D4so
	 vjA2Oigh/DPlsh0oqzoG/12BrFVWek7VYJl6q+xvY7Bt7ekXK72Tes4PAoIn3akgzq
	 VPuNqF9Zs2WMgGIVhQwTUNR0rlSwxnXfUKqU2lXmAAMyzB+yBtaToYTheyY7qTolad
	 eFr3AORa4Oukc42ljcSMR3NpwhGzTuxTR/caYmM9Wlfx/lPBKy+Q3/vB+VQqN9Fz+u
	 5u3o1H1IoOXnA==
From: Mark Brown <broonie@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20261119-regmap-mmio-attach-clk-v1-1-91291802ac53@gmail.com>
References: <20261119-regmap-mmio-attach-clk-v1-1-91291802ac53@gmail.com>
Subject: Re: [PATCH] regmap: mmio: Don't attach the clock if clk_prepare()
 fails
Message-Id: <179512899892.116416.13230762331536934249.b4-ty@b4>
Date: Thu, 19 Nov 2026 22:56:38 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DPK3QJShF5aA+PmtmBOiISahQ7qwKlUH6H6y5QEkFWo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZzHT49K89LapSiN7WybEt8/arMC/bxA1LVkgbic83O
 VSy5MbZjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExk6yOG/8Vq9uvz3j2ss+3Q
 3JLHmdfa9bPq+NNo9gnJh9KV9y0VyGH475u6oFIpPnr/Fpblifp5S1f29PQuv2olG3/06uYJEtu
 d+AE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Nov 2026 16:50:01 +0000, Arun Iyengar wrote:
> regmap: mmio: Don't attach the clock if clk_prepare() fails

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-7.4

Thanks!

[1/1] regmap: mmio: Don't attach the clock if clk_prepare() fails
      https://git.kernel.org/broonie/regmap/c/21f72877037e

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

