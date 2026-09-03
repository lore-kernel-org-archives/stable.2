Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9439FCE;
	Thu,  3 Sep 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442426; cv=none; b=s2lnL9BpDo5MXw1UE/6h2jxhiS7RAD3rqwPKWa/idrnqPRQT5KgP7a/tSE1mSa2syboqb13HULQ4+t+bpBMNkQvHLOAinAOCgKNYTwOkgphHdZko8H+CqB+OXMNNKBtC1pYBQpl5hHnqgK9ihKYsfg7du/lmInT9gyvHM5M0ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442426; c=relaxed/simple;
	bh=vUplqmmBl8DDu0WsRE+E6Yosb7enN7XGEu8R8AG2S1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qvDpjWcQjGjfHwGhlzI0Oc0ntWwTqu2TnpxkjtdK/w8Px3MvLHe0/bSpEN70s9Nc44JLda2NZQZrav+AaCrmtICdh8NU83cB+fCrSLDCgm0zsA/+MIFSqai7z1RhOCBCKAN5cw1JL+YNZrzw2J7OfNjTIZHgR9ciyLLj4bn7YZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy4qdFNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy4qdFNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4CA1F000E9;
	Thu,  3 Sep 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442405;
	bh=MACAtVctW5iZm8XXwPgIOFDVMcJxiwLDfYCcCLd5nLU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dy4qdFNudPT0hbVj3b2iMmDQ0w9szmPe8IpLFubyDg2BA9DcXZVxxAOZ7G5d222xC
	 xOElZBOExrsTswu2VJE9YwIpqFLcFEXQ/oqv/NisCqMa0/bvbmT3Dj1zLTfACwEebO
	 1a6LZKlTcBh/xHnNykpaWdgyf+tj2+EnceM29OSO7dhPFbDM6WgY9YP/A8bU+bn5dX
	 TzE6gQ4/FpEtVhhe5OtOEiC5heYhH4i2nd4JL0lAvu1Ij7AuDCACQDiK8PIl/5O02R
	 IgZEXejX63Y0/jqTfcfHR33tyj7TMVVLjoCbgOnEyo/ny8ypKBF+J2A/R0y1o2eaIF
	 S77KiBjPyZljQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260827-deps-reg-max77705-v1-1-c83a74d3d428@ixit.cz>
References: <20260827-deps-reg-max77705-v1-1-c83a74d3d428@ixit.cz>
Subject: Re: (subset) [PATCH] mfd: Fix MAX77705 dependency on regmap
Message-Id: <178844240388.2660845.15478416914610328412.b4-ty@b4>
Date: Thu, 03 Sep 2026 14:33:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 27 Aug 2026 16:27:41 +0200, David Heidelberg wrote:
> The max77705 uses devm_regmap_add_irq_chip(), so add REGMAP_IRQ
> and REGMAP_I2C to what the core driver selects in order to provide
> thise APIs.
> This fixes a build error:
> 
> drivers/mfd/max77705.o: in function `max77705_i2c_probe':
> max77705.c:(.text+0x250): undefined reference to `devm_regmap_add_irq_chip'
> 
> [...]

Applied, thanks!

[1/1] mfd: Fix MAX77705 dependency on regmap
      commit: b07adc1a304c7ca9ac25a01051561538757363c9

--
Lee Jones [李琼斯]

