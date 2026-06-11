Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD726ACC;
	Thu, 11 Jun 2026 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=cUsU0Cr3pcL7nnX8M1fcrmdfWPZl0h0qWga2v7ou5EyqjHzN/GAz8QYEqd+ZVAHKJFXMHaLQ1FvTvySag4sNHIbXZkCUDjbfrZu3q73TexAK6UnfYfPfCzLi+uwQ5uvj8tMPKs6YoisebDM4GIXw0CCh4NZ4gSwD1+Y3A35BWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=9uZbnvCSonpXGXR9vVuWodMYLgOTp+M2HsRiZcKEBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EISaCz4/LOSmzGjH4E8R1R7ToFsarQ6UEbYre5IbEZgR9XhfeSggWLN1dm4vUDGxa73jW0r+CvBrEczM0osGhqUzClHpS3AH0n04dvNtu72gWSm4q0JmVrMnw0zpvj3UmCKi/WSiFhKd1ESLbfrpNEec4okBoLpBh9Du29tuY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvnQoi7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvnQoi7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805811F00893;
	Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138743;
	bh=9uZbnvCSonpXGXR9vVuWodMYLgOTp+M2HsRiZcKEBSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvnQoi7XFldjN2BdBn0zt4ODPTH0Rziyc+P/OqBnV5fubj/PIn/MW96wZ1XZ+33iq
	 UJABwOpTLlgPcAux0C319hfvOJEhVks0l+CoOxSRnfhEIIoipa8ABb7DGQ3lHDrk5X
	 52wsqSD1JeyRcRk5WRFB5HIrvYCkkd0Xk87q5ph5KCuduNCe8NwvKsRvxZQtShLl0t
	 mX8yXPS1yZhl/bCm7Q5SfpEAUY1YBBNBDKTN7gEMXQYo3tNrvult/UVwwCfNgmxPqh
	 W13hzPkgteSo2H25Q8iZ2oSmRqbdJ/1/4AyyTIkujL7MfmMoUfpO/YADyWSoySokOu
	 vCgvknRSsOrXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Mark Brown <broonie@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dongliang Mu <mudongliangabcd@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	lvc-project@linuxtesting.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 5.10] spi: meson-spicc: Fix double-put in remove path
Date: Wed, 10 Jun 2026 20:45:24 -0400
Message-ID: <20260610-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610161129.7612-1-apanov@astralinux.ru>
References: <20260610161129.7612-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 10, 2026 at 07:11:29PM +0300, Alexey Panov wrote:
> [PATCH 5.10] spi: meson-spicc: Fix double-put in remove path

Queued for 5.10, thanks.

--
Thanks,
Sasha
