Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919853;
	b=MYFfgZmBE5DraID0thUhSXHzyR4WVTMj+uOjoePzHqZUKwnl3wwH19RqGm1yvcEqxwO6
	 Z+YUQfm8kmczCTttKsJt9BGYlzRKpLBTSYMD7+/qRiMi1Paqckuq+Yrj5mjysQkR4tU9Q
	 vXr7dbZlOPvIlNXTAC7tpY4iwait2ah1617B89O7aIWgMxbOA2hCLbc6MU8vd30CLzhym
	 10ykAugLiIz7ttGng8zO29V0JVYUSPXq7E7CC73wgNWJ30SkE7+4R4dfCrLMD9G1/ICkd
	 7LCqM9j/MZbUYYtkO63mt6+mRqQLe/3p8GPObM3P9n+4SNoNGM9B6GZcpRII5rpdFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919853;
	h=Received:From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Zf3MsUipeIoo9Uty4dGky+vBJxZHkD7wRzAVDmgbAyE=;
	b=oItz3DJo9jrILkXce2CqMQJ8U65MS4ACecTTym16PoWgpyCgcO0KJs2NNJWdqrG91+Kg
	 iuYBLC0zGqj/02SpzvoQhF1BrcATkwIZhYdJKMfQpEi2Fa5eBjUAIXVJIi/+XmUzNSUIW
	 jOaHMtiM3xfbc5Jw6SbmrSeEYKjSB4FkugO4sE6FDmFT19M1Jx4OyNm0UoHnJtuJj9JAB
	 tw6CeD4vJAVsUG3Y+iAB2BIfrteSWGYWK6TIAzmh1gX0PYprNeXolTQuVQXJZmLaXHmFD
	 RGGLVShrg+ON06N4bh4GPcBLLQGPOs2tjCbVVwgdWyFXdeJZw3VS+MXKwgCHHAlPQlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF05606A89E;
	Tue, 17 Nov 2026 12:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF501F00933;
	Tue, 17 Nov 2026 12:50:52 +0000 (UTC)
From: Thierry Reding <treding@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
References: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
Subject: Re: [PATCH 0/2] Fix NVDEC boot on Tegra210
Message-Id: <179491984070.1887007.9922722264589294895.b4-ty@b4>
Date: Tue, 17 Nov 2026 13:50:40 +0100
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=treding@nvidia.com;
 h=from:subject:message-id; bh=Xs++ydyvFmALhs3iMzQiWYDo+bq5LKMLDLtvJYzWnTc=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBq/E2qY0svl5l3VmkOwUR0Oy9YiATSgZD2sr234
 TFdBZ4vWnmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCavxNqgAKCRDdI6zXfz6z
 obrbD/0US+rXfMPpd+ydrKWerCxMSEIrUL3hF8pXAReMKKiJXNV7J7kqejcBET6235rGdaUYhVu
 lpY1GJ3XH4j9xm8BIsPk/DbOl0mufeHKqYbf81VruIDbdljwtIGbyHLN11iteuqih++oA1l4DUY
 W8DgPYbxSkNcR0Vi/74SU2CO7c17jnWB6A6c7HQU2Xxo20bdKKtfClMoVhu1QaILI6T6gYrlHMp
 SJm3GY/68y76Sn0v0f2wBaFGpperPrNwrxnkannzCyHimvO8maHEEzZgeE1ZtXcSmsFXuZ3EJHo
 bAXnWpZdzLKLwIhs5nhAkpyLrkLaPCxzMN5ZfLNsHp3Dr2uqJGs1qYXm90H6i6IdW54qJvWYtzr
 dA0VeaLxUc9qQDzOsQJoYgiG1iGHWnWURFASQcbofGRrtvLwJ9COJTelvzcrhoDfIfY4QHiSZaW
 7bYs+Gv/gMup0LF2PM5qEV43sv1F3t25MnyYByFmipMZopmUw0ST31Uro77BRkTKI+asDPu/abZ
 ipZeL8MwOf29xlqBI0hbBHrlGH7ulzafYc0sk/vnHkF8g1AfxI2vdRJxS5Qx+VpnqM8IIELQ98k
 J6kzK90rnT/EupspuPHAXywEyrxOTekbKv+b46rlbOSc8lncjQDvT8XEnBQWQKj+EbmLR4p0Tg/
 TYf5jr9qgAKgZaA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1


On Thu, 15 Oct 2026 18:58:01 +0900, Mikko Perttunen wrote:
> Fix NVDEC boot on Tegra210
> 
> On Tegra210, parts of the NVDEC hardware unit are in the NVJPG power
> domain. According to the TRM, the NVJPG power domains must always be
> ungated while the NVDEC power domain is ungated. Model the dependency in
> device tree.
> 
> [...]

Applied, thanks!

[1/2] soc/tegra: pmc: Support nested PMC power domains
      commit: c6935858d13498f24b305aff53bd1123da6a8671
[2/2] arm64: tegra: Make the NVDEC power domain a subdomain of NVJPG on Tegra210
      commit: d4e7a00646df735b915273cca544db11f6dc8854

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

