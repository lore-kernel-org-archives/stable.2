Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169513;
	b=4c/lqSkrLu0/nRJ2kqk8o5nJG6aZes0PO1iwTP2HJNjY69pB8EZW2JkIwBxhI8bqUpU8
	 bs7DRZQBKTmaoFB8vUqGTpQJDwrOdLDTHYmNI/Nk68FtPA+pMoheTr/W1BgpxY5p7Rlz3
	 gy7s+6BVhYLUSiXOoFI2w/atpfT/q7Wq9hLw98LCKYPImnDgk3bYI4Q0C5xZdxXzHiB/A
	 c8D5j8kDK2kT6KgWiVKJMCm1G2yzosHGE4hxkrGbveKtlK2PUJrZSgRRpJw3OQcbmvyru
	 tr+th1mdxYTNiPE3XTyJOj0wGytKykauJrlsUROL6W8qoSLkDYvvzqfBgO5qWb0WYjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FelJQnYKaqsep/uETiRc3VxfJwVekzolCHDYtCVv/JU=;
	b=rRBKfuUL2CDx3N707jM8e0VNAS/uB8MI8NGzYlgH3f5J/ZZkmxam107BNr9rJuXP2rYb
	 eVbU1T0pEgJeFVNicWVWkAHNMoQCzQFTxO3+TWESxPBZXPhlLg3PaS2P8h8Uc7adOb8/0
	 QQ3Xi0Kxxp6/mMrYvbPMLF2wUDzsq9Rr7g6l42C0Ll1I4uDFwjiuzDVO9PrsuVvJLqf1B
	 FHj0nU3nXAYeEZ8XMjoaRpNnTsfD8TVu+vdoPzHeU1xHy8jfIt5kc/dTRsH2hR12p6b/8
	 AmfdkVOIYYRx9PciVGrufJl6S8R6fAmCTYQw42kM43DTyPFdaIjYM6U/y7PGmXHU/CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YI0m+i67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFB60826D8;
	Sun,  8 Nov 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YI0m+i67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FF61F008A3;
	Sun,  8 Nov 2026 20:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169513;
	bh=FelJQnYKaqsep/uETiRc3VxfJwVekzolCHDYtCVv/JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YI0m+i673f8Tb68VNKLQYGt18MXkq2px5OD1kX9blYA08HnEWRolFoM0soCMZAcM8
	 D+28aX/B2/8b6VuWrKvGJxir8qVJjwtMx9F6XyGZh91kaCVMAbKp/JID8tkujyLKJe
	 qHCCdVR5iluhXr87oh9kg+IcOkAaRv3yAtRSsjC16ziVwB+8FxyVf7d02HRQ/jwmUw
	 gcA2N9wqyQK0owWaCSddMwgRmdnnS8ZoFc7z7RSVMM5Cg4eemdi5ZEmAoiBvWHw5JC
	 siPefcsFtqRCjb5OfZt1GA8mOdl4KyNjPVRLPTEi5YCSQN+JfUnMGHuTQ9yiioLsev
	 ZsOzapvJqGTKA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladlen Grachev <webholt@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-oneplus-common: Drop LVS2 voltage constraints
Date: Sun,  8 Nov 2026 14:21:34 -0600
Message-ID: <179416929516.628393.15139951526312242199.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029-op3t-lvs2-fix-v1-1-42ca9d992c20@gmail.com>
References: <20261029-op3t-lvs2-fix-v1-1-42ca9d992c20@gmail.com>
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
Content-Transfer-Encoding: 8bit


On Thu, 29 Oct 2026 18:12:17 +0000, Vladlen Grachev wrote:
> Since commit 27880745470a ("arm64: dts: qcom: msm8996-oneplus: Add SLPI
> VDD_PX"), OnePlus 3T no longer boots: the PM8994 RPM regulator device
> fails to probe, so UFS, USB and the display never come up and the phone
> hangs on the bootloader splash screen:
> 
>   lvs2: failed to get the current voltage: -EINVAL
>   qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
>     lvs2: devm_regulator_register() failed, ret=-22
>   qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
>     probe with driver qcom_rpm_smd_regulator failed with error -22
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-oneplus-common: Drop LVS2 voltage constraints
      commit: 22acabeb506e7007b416719f336c8bf276017178

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
