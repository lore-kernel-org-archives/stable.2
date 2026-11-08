Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169509;
	b=CK6f+g7WBKl7aoDfNzDB8FK7gb1y506FK7bPGzIzCqk7uKXz85tf84ww7iSRi8i/SD04
	 T8Sy8biviJQXiUadKowvI3wxEZ+4xSpr/EUCEtWPBLbf5ZVSi9WX3WHbvGJ50wOK6HOo4
	 lcdt8lPTi8ZjO3+grgVJGxsM2O6YQ6WtQ5EciJXJzOoqJCF2RraL10ZufJEAkwbGlHJwz
	 Uv+yPoo2rIQI5tRb62DFo8XxJGa/Q6+IwWoDdQhbC2eXzlxHcNqpUwVLxgCbFRhCX0YnO
	 jqRiviRud6ePhfUzfhvVEGOoOCIkRdvnNoXLUx7pK98hu7GSBRLe78385yfCUUFvF3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169509;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aTg+BcIijMbI1Tm0Fb4oV5T85hmX5vQ1Q0bXYVwtLoM=;
	b=Eiv4p3ts63qZrHkhSKiomrS073ckbTII25giAOAiQbf+84FMpW6UvAQPrn72Vc0UaBHp
	 NkWu1BmoBquFqtNhcQtxidOxtEFuwrjjXfe6EGuaPkpVAAYgaWDcURZUjv+9pvjbdA+V8
	 IJjRK+lR2o5NnHojoxtLHyynrmKpr5c/3c5QqtTXjsj9PPl/EG3kAo/WTYYSBxfI18pEX
	 jL8rQNFE2W3hXqdZPhgxvOozloWwVbLcyLb/aXzRMC91oJsObYdPwXtRsX19mlFCRGPE9
	 bFpkSMEmBHH+D0A7aDYvEe51polUVh6Y0P7xCEAC4nwt2AN0J2tZwmYMUXwigZ0lfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5aA0lB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8346081EF3;
	Sun,  8 Nov 2026 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5aA0lB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C81F008A6;
	Sun,  8 Nov 2026 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169508;
	bh=aTg+BcIijMbI1Tm0Fb4oV5T85hmX5vQ1Q0bXYVwtLoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5aA0lB0Bdob9zl3oOrj0L8396begvPJt5v5xgVo3eXP7qTx6WjxbTLojgSRvlQ3A
	 d4NiUArFyBK1GvSnKOT6THd2bMA3smp1sXqFHTeS08hp2jgzLb/5zievsDfpRSikeE
	 CsxAy0CYHJlGnxEG+Xf6qWt1WAow/9B9abCnRkcnqSlOJaY8y9SN7okQpMi+1y9eht
	 MKyvjgELioNquEFEdHJ7uLIyGydDrZFVmd0gDoXOnPKtAMBSGo4+n3C/jdF1X46t57
	 G3vR5pUAZj7HqWc7kdmGYUnS66pgeEPz2sykzi+33Q1sAiaGGzJFlgYeWCtV84iUns
	 9KhXXmqI143mg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
	Chenna Kesava Raju <chennak@qti.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Fix iommu stream ID masks for CDSP compute CBs
Date: Sun,  8 Nov 2026 14:21:30 -0600
Message-ID: <179416929514.628393.4064137862863987691.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
References: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
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


On Thu, 29 Oct 2026 20:11:45 +0530, Vinayak Katoch wrote:
> The stream ID masks of compute-cb@12 and compute-cb@14 are wrong, so
> these two context banks fail to probe.
> 
> Fix the masks:
>  - compute-cb@12: SID 0x0c2c, mask 0x20 -> 0x0
>  - compute-cb@14: SID 0x0c0e, mask 0x20 -> 0x40
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8750: Fix iommu stream ID masks for CDSP compute CBs
      commit: afe52f52d645c31c201e1e575e781ccb50aa2848

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
