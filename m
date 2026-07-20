Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460D3C3F5C;
	Mon, 20 Jul 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589139; cv=none; b=rK7sMelN3DIHHFr3/0cTlQ4ROUmAp/uLHyNg4nfhqlw6daUYVEFsZCGvqt1PCiwPO5HGg5frsnph1uME4MM3/CRZH/otM0xgRB5WupO1eTaagXla0AnLLlsjDqzsturlkPgRDnYJAUXamG/z6oKHC8H4bnvVEF+kserMjrrnj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589139; c=relaxed/simple;
	bh=L1RCcc6Mp2q7xn3uHuJY7q1TaNchYMtskGU1epRl82c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vko6wg/I89brnYlhUB3jHTAHFli3PXQSN8K8COKyF1paXaIz/iedBfzjd3ScKRSV+9urloEN4v7mGGjtF9Kqip3hSExs0fPyXFTo+mfF4uRit9+kzfjlKOQVCHqdOhjUPb6m7fHkgV6kBVHcXq2dHn9Sgge3ZlOyF4HMHaTNGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A41F000E9;
	Mon, 20 Jul 2026 23:12:17 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 40CE118081D; Tue, 21 Jul 2026 01:12:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Peisach <jpeisach@ubuntu.com>, stable@vger.kernel.org
In-Reply-To: <20260712-gate-power-v4-1-aa59c6583247@chaosmail.tech>
References: <20260712-gate-power-v4-1-aa59c6583247@chaosmail.tech>
Subject: Re: [PATCH v4] power: supply: macsmc: Support macOS 27 SMC
 firmware
Message-Id: <178458913624.374847.13868321140299746497.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 01:12:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 12 Jul 2026 00:48:56 +0200, Sasha Finkelstein wrote:
> The SMC firmware included in macOS 27 changed the size of BCF0 key from
> 4 to 1 bytes. This key is used for indicating that battery state is
> critically low. In addition, B0RM key has changed endianness.
> 
> 

Applied, thanks!

[1/1] power: supply: macsmc: Support macOS 27 SMC firmware
      commit: f7b253a6e217f71d754d70c525e9b4c1dcbd4414

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

