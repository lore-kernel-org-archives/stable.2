Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622897;
	b=FHa7xZHhT+WGaRcg/Eq71XrwBwvDC2TzunNgAjO38W76o9wkduAjVT782FEnDM05CzVR
	 DRj1LJrKvakHEfC/a8KTutrMaBGsLg8OBQ9A0m0QYVyA2FU6iezDemofZPyWXZmUJ8UiZ
	 R3V1cMqyq54tSee4+shGzFUQ9cbJscqPK2EntKYCgJG7J5tycFUSFErUk+a/DEuKZRpGK
	 nlviKbi9vEn5vcFiZ3HzVpgJIJ3R0/GtnbQO2dPw1QhHKFcQ9SRDPG6Mwhl07IwglUAMl
	 5FouRpO9H/joDP4bGpr5G/5C78RtZE4fYWqVeUj/NJ+oi1OeaZwkTOKrP+/WrsOCXkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=RzVoRzg9xe4PHgIpm+qEezcjZDbm/lhClesTNi1L61Q=;
	b=b3QhXnll90J+4DRb4z5Ak8TluB9PeFc2hPJZfyFm2Oztwj51cS/wPq/Ty1LuRydgGQsD
	 K3eKH02h13J8FQUua26Dh2FNfkI4WOSobMiKn6tm54+bNZPpHn79+MM223GrI0e9iyzdy
	 ESLjVtMK3Tt39n1V/OSiMk0aw5Hq9zxcGzdeqvsy551w2dySOT3GW5vFpgifmBmWDXaEm
	 Wn/18AOw0IiM8GVxSbv9EMk952yUKpacpdUGL6yOcX1e+kslTNHMS583hnquJwc5DFVkF
	 tkZPt3FLw6hjS3jLsxeDLIFj4F8fwIPeUhpbxSaRZjyqXSx03JzZVnXhPJECtITMmUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yg28mQrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7260A2626;
	Mon,  2 Nov 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yg28mQrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2A31F00A17;
	Mon,  2 Nov 2026 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622896;
	bh=RzVoRzg9xe4PHgIpm+qEezcjZDbm/lhClesTNi1L61Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yg28mQrpwDmuTMuJ+UgdYXOZ+dvc8Ebni/8dbFPNPslIaBxVdejVKto8c+TPsWCDe
	 hvS/GxsNJSluYIryH69FWRSv0ShsB+egJeQLn1/HlpApu4Gj//s+3rmmOZgUvZdoBH
	 Cbm4SuiDPcty9IN6wl+7e/icJD46sf9rjhgOwQ2XXeSFqho35T+z0mZHfqNpJ0xkKF
	 /Tn74maVWVZFTMCHEL6zZ6hyh+ShYNqlILevG60Tfz05Uv5pfY+Lcn0BB73BvAcKtX
	 eOqK0C+jwh5gysfprcKFc9putRFr2fvzDTRWKRPFqUE0ksXwFDQxjUtTG+jZUArQ10
	 Yoil6Md2cv3Cw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Artem Utkin <thesame.personal@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4412-p4note: allow powering off the wifi card
Date: Mon,  2 Nov 2026 13:34:12 +0100
Message-ID: <179362278567.150793.8365404184056648906.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026-exynos4412-p4note-brcmfmac-v2-1-14b372972163@gmail.com>
References: <20261026-exynos4412-p4note-brcmfmac-v2-1-14b372972163@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=krzk@kernel.org; h=from:subject:message-id; bh=etaCVO/+UgYS7WSwutu5o7cRUm5LN13s38rYuQKONgE=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6INES3aj/pbzo71zEV6fwLpMh5E6nbYpHinso OZsrqDuuAKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauiDRAAKCRDBN2bmhouD 12HID/9lN6oLnGgySgl9mJeJssysWKx24Jq0f5lwe5NUKNe4At4gIJRrjFQkyCCm/ifblAyWhaV JAYy/NAr2K5MB29iS0HX9n2TL3Q+gqAxcqSOEvp2axGrCno/IWYuYb0dwJpIraXPk0XbUB69Hhn vojCCoMlhTHgpVJIOVSsGpmSIG/4+Xv1aIvdMPCuRk2GYgX1n1f1XFY7NKBX2A3Tz3/xfEx6uTt lRZn+c036BfGvDKLwl/N7ueQh+fISnnfPuUxsnmcO71mExrq+RBEcX881rl/C6YK3eYq5dQi2S7 3IzbbHoiR4NvftY6wVmPO6w6SHHKvwneJNd3EVQstmOAHBrsvftsiusgYJBctcEB8r6r8WnEKVn V6W4kL5luk2nzkmMw69cU5S2pMVl4CNfHS36ZOGuTH4Wl7U1JNIIpaKSk9ApGQ7QF0pUsTnyKEf ym1y0Hdbu34vJjL/GDEyatn+c6g5ONHJiBx+zn8e/P2CQThRjptfixD+d1O5Afw5xGtPXL6S1p9 Ky3iePsCFEtI51mn/ka8SFVE8LcvJqukHBoTxxN95Y6cJMs3B2dBFcYXSgTtZVRTnjzArrni5vy 4oCeTQkrRYoCCPgK0a1FLa6o52/E/JQvZKaYoKeSVmEvdkIiTPWgnXkgCFpxmK54lFi0mMCWEz/ rjzgsFOUBnLMJu
 g==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit


On Mon, 26 Oct 2026 17:09:14 +0100, Artem Utkin wrote:
> sdhci_3 serving BCM4334 was missing cap-power-off-card.
> On my N8000 this resulted in the following messages after sleeping:
> [305.759883] PM: suspend entry (deep)
> [306.514698] brcmfmac: brcmf_ops_sdio_suspend: Failed to set pm_flags 1
> [306.671504] brcmfmac: brcmf_sdio_htclk: HT Avail request error: -110
> [307.127267] PM: suspend exit
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: samsung: exynos4412-p4note: allow powering off the wifi card
      https://git.kernel.org/krzk/linux/c/41fb0e8f340f5b883b67786549a48ff60bcecca0

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
