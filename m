Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9C43E071;
	Tue,  4 Aug 2026 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878353; cv=none; b=CmROw1kZws2Ik12Upe3/EMRkJIco1/NVynlHRWdEg1UbC/JsIk/AOVV9lNRr7YDp5NYNuBhwWHXAPERl19XYI8SdipHBpp5rYkPxbJMvXhtdAiPXlDB4EvY9i35v/HxT/YjaYZOgfoxiaIy7WSzQ1c4Y0bc7RYIF+ovWQ+WZb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878353; c=relaxed/simple;
	bh=254rLJZg1P/Ua+ZJxcWr1cD5IIiB1V2uB7r340A/S5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q/FNfz2FdoisUiemlHyPe4PD7fgxZbylHLKAAxPuFBaxdJeLkALmQSFdDGlCHsU6JyRUHKAAh1oJGw0lMAPACgAW31rQp3qmCdWfot2iMIbjFGGmbFAZpSxNJfG6Bt+pl082SB8lOO16Iqe20WXsbUC7Tdc0cnHFuA8YZz/4j0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImCai4fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImCai4fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9DA1F000E9;
	Tue,  4 Aug 2026 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878352;
	bh=+G1U0PM3mhdF8K/wC5MdMG8ZWLjf/C6FGfsv064MMeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ImCai4fcMYua8UoJ7OZmIu8CbYAMIMmh8NW19pwuQVjcSLmZ/zIW9pl96K/7sxT+M
	 LlmX27RUQtw4o1q870ggMkLtLXtJK3aVNF/4BxaqXdGb3cV2fgDm76PaEt9dOISrvC
	 lPvgY4iYcFvXIFVJd6InLm1twscrQ2EuzA/j+PsktztX9v6lZWSLfdhBPVmg75Cdi+
	 pZVZsVbVmUtvSakJgur38onXol4xffGn6tChHDFi114+sjdGEf0UPKGq1Xijyx4zcS
	 lIJZJ8Kgh1IlWyC+yIwn4pRkEAlt0oVHhts+lU4J7O8r0DoEETlldkuhFdd4Pun4nU
	 yvcO97EruQEOA==
From: Mark Brown <broonie@kernel.org>
To: jonas.gorski@gmail.com, william.zhang@broadcom.com, 
 kursad.oney@broadcom.com, anand.gore@broadcom.com, 
 florian.fainelli@broadcom.com, rafal@milecki.pl, 
 Can Peng <pengcan@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260804071904.860842-1-pengcan@kylinos.cn>
References: <20260804071904.860842-1-pengcan@kylinos.cn>
Subject: Re: [PATCH] spi: bcmbca-hsspi: disable clocks on resume failure
Message-Id: <178587386677.111355.14222455977856705143.b4-ty@b4>
Date: Tue, 04 Aug 2026 21:04:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=254rLJZg1P/Ua+ZJxcWr1cD5IIiB1V2uB7r340A/S5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcldNbOCyfs8Ffux8R0kxAlYvvdk9+HdCFWrtF
 Iw/pLZ9skaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanJXTQAKCRAk1otyXVSH
 0HwxB/9S4fNDNkldFXrjX8TrdFfLPHFvHMEepS5ewziq7GkXNm3EjSui8salsd59LWTqJGGjxzN
 OWfbl5XFU7KYQ0OnsUU+VL9o4OPQ51dRFAYJIa2awNGQEMCdOAFOcbeG311oiPFVy4kZHbbu9cF
 Uml2cLji24wqJod+FpUkYrNOYigiXWDMadQIckkS/ShlXNoZLBYGZPTsRwXo+/n3xCyMkhcnEUl
 oc8IDc8+Ony8NTKUWmd/3cD1UPUj9l5mhm/hZUCKhhdBYschLNxi7+0svwtLlUdqUvHKfigTjZc
 C5ZV23WLDHjaBjT8hulFzUBXSj7eJ2pyywBI+a+3q+qXoJSt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 04 Aug 2026 15:19:04 +0800, Can Peng wrote:
> spi: bcmbca-hsspi: disable clocks on resume failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: bcmbca-hsspi: disable clocks on resume failure
      https://git.kernel.org/broonie/spi/c/d2f5a606710a

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

