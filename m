Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83740D599;
	Fri, 19 Jun 2026 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842041; cv=none; b=iqLa7BNV/m5H4P5Ry+/Z96OGElERNvtUm5Z2WlpY+6FpY74gcHdTkO4IQCy/pBtXM/VVRpf2S2zkAraZyvnMHzQPx/ZYbhAGa2zsO6ta2s/AWpmlOCCyhXMQQIM+ZArg9bf7dObZHt/idSB1Cx+PkirkF2U12dL6lhPgYczHsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842041; c=relaxed/simple;
	bh=ZwgnbpDklsxwXA4ry9F/yu1NZqxf2MAnor86NXv1fJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmq1mqhF04I1ky8mxEZssWV3AWmNFoltKc201TDh2MkGz4EHPB5aqGNAHu/BP1A8ftOrbEP5oSNhu7xCVAx2vtdFbKUkhKnOPUjzQsDxd4ngrKvEcqkVdRh51f+IrN31L83Rhg8ocYTLScDBrMdep3Vf9Q5zHP7vw7xAhVcP/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szn3v5TQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szn3v5TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC01F00A3D;
	Fri, 19 Jun 2026 04:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842040;
	bh=VtPuNPA/UJihW+srZRi7+Fjr3nYVhEg97FUVJPDe72E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Szn3v5TQaYV+73mevsEBm3cLp6xY/HOROP58m+9fjCMAUqRdhzjmteKjUINVu11ok
	 ti0p2YN04VSIaQbo+tXX/HaonBLu66zQlLTRpYwmNt3/AR/FbPalc+0JySLndV7EAC
	 dYjkDTBcgYhTlu6M3RKpPv9bxYMdGZz2EOvJgTdL/IXh+dyfEvJteClCu8ogn6PSCH
	 8ITsoYi1AzY6scYPIHzOf8LHlTItEaaikdKhabOR8R2eXiD4/WCbTrmC4DtROfHOWi
	 qwN4UwKuhfetJZ1T/9LHQMt3SSkSNVfl6lAQBp8Hf5zObqnNvLDsgIr3rV1Tj1MIfH
	 bSRn4y48kksgA==
From: Sasha Levin <sashal@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	stable@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Subject: Re: [PATCH 6.12.y 0/3] gpiolib: backport 16fdabe143fc
Date: Fri, 19 Jun 2026 00:07:02 -0400
Message-ID: <20260618-reply-item017-gpiolib@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618-6-12-cve-2026-31732-v1-0-7ca0d0b906b0@cherry.de>
References: <20260618-6-12-cve-2026-31732-v1-0-7ca0d0b906b0@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 6.12.y 0/3] gpiolib: backport 16fdabe143fc (gpio: Fix resource
>  leaks on errors in gpiochip_add_data_with_key()) - CVE-2026-31732

Queued the series for 6.12, thanks.

--
Thanks,
Sasha
