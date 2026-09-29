Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969B472F7A;
	Tue, 29 Sep 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651801; cv=none; b=naNDhM4Z1rgkQhAKee5o1Hpvh0rI65G780JadIpjLzR6kBCHoVyCV5FvY1j4+nx9xixqeByHay6GueTt7PDlFiUxqqVBMuG9g1IOvlwAaQ7xxU/dEes9qCmnZzjntzeJNI3cnN2bswKaYFIpU86fyx2rgOD+yVdDXKSDarVwi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651801; c=relaxed/simple;
	bh=+Sy762ArzdYPpVB/9Usk1aTPJ99xlQG2cRpdOu7Zun4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAzewdT5CHnuTRQDT6XxfMBFjYyuecoydfxIf+ly201WShNpd+4qbZaEIgpRR95UYOhZ2jd4QxUqSjcWGdp0duULeF42hZ6PG1cIjgCeALs7QjCqehPkCL1zTSgpC4SPxlVUtYANOIEzueutb15eHyqCWgFDjZNHDDcSoNjlpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmmflLva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmmflLva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B211F0089F;
	Tue, 29 Sep 2026 03:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651789;
	bh=Jx7cJUtCKHd+gsRXKp+EB+fK/jtgdjvkLh+CXfe582c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QmmflLvaK5m+gCLWohAtMtVzR3oj5orby/sWNWvpNnVhoC60X3OGTD6A3ujPUIMuC
	 OVKrgZ8emnMfZY159Beo5ziMo77+vEeiE9PCLK8FJX8EkpZkBaH8zWZ6bmJaXt8w0B
	 HQ7wDY7lEqwxdfvwcGRrmiQe7YtjT3gr3PYwfb5GjJiWJHJkOV1YK9UO+Lk6j60jrx
	 J3SoSmsIthDy70JbENJqsTO1dlTUlksqW9a+upQRBJC+RpGVeBtpHW0kpSEaFpXbTL
	 /Umjhf0bQAdE7KiIJNu0gz4sLyoGqxKBpTKOc1EvRafLSm+q+QrMjkqd7huaQ+o/FC
	 qWI9Ozkkgfv3Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anton Bambura <jenneron@protonmail.com>,
	Stefan Hansson <newbie13xd@gmail.com>,
	Paul Sajna <sajattack@postmarketos.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes
Date: Mon, 28 Sep 2026 22:15:17 -0500
Message-ID: <179065170925.2673486.16411597539666647229.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802-judyln-sdcard-fix-v1-1-b3477cfc42cc@postmarketos.org>
References: <20260802-judyln-sdcard-fix-v1-1-b3477cfc42cc@postmarketos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Aug 2026 12:06:42 -0700, Paul Sajna wrote:
> sdcard was previously rather unreliable during boot on sdm845-lg-judyln
> 
> Identified and applied correct settings from downstream lineageos kernel.
> 
> Verified card was properly detected over 5 reboots with rootfs on sdcard.
> 
> Refer to downstream: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/efa8458f79dffeb380d43b38b9403407f87d9f05/arch/arm64/boot/dts/qcom/sdm845-pinctrl.dtsi#L148-L303
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes
      commit: e57d572ed779eb53e7eb5b8f9546731eff21bc93

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
