Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E543537F8;
	Mon,  3 Aug 2026 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727457; cv=none; b=qRYPDiIDMbkclmQAHSEzJtonTufvFT/RTrkX0CJ6YcwKp4ipJlaOFUStTRxDYIGtj/pRqm7qqKdAhlrHqXW6NZzHYCZWfN+yuOm68c/z/buPw+QJYtpOJBlDeEk4IOXPniXA/ZsmSSs3KgLbOeUCDz0xmaDwIgQ6VOFf2Ln3YGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727457; c=relaxed/simple;
	bh=bBMhxr+sPePCxahAqQloiwjP6yxgToNs8c8yHtUfqOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/6gmy8yTlGitMP1N3Dlus2d3ikOnKqKuTH1LTxEgRquGr6ZePFcQ4OEzNG054kh+MDD7ccH6zfU7Wkn1Y+0Ljzy3B/JrQi5IZ+jgZGmPB1y7Up/TNB7UiYNRI/rpv8xZO8H98ZKJqjWtP3JCbF8jU7ByNaVTOBtudklQgWoIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwKYUOm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwKYUOm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE0D1F000E9;
	Mon,  3 Aug 2026 03:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727456;
	bh=SL9ZjfMH4BygnrK/Yjhu312zzbvW+JWVlJEz8Y2ncto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwKYUOm9f3OHGSc3Oqq85nDRsT7IvUtif8bhcBFaTZ289AzW0WJCXKCXVPAAI0+i7
	 +osPHNWEMAEdUnvwDqm1M3OkpWFQwrqvqrrnKAfsGyFMKdsVOXmZ8fqoNZvFMA+A/n
	 tXSecfyzKEfpausdfnvUtFjf99SGClM+dQTRwsZik5rwD2N22dde7b48OjYkmA/E+9
	 vfiEWYmbSWlF0A3YHkM9pTzd6g99UYaV8mGFhvASLAix9IFK520CWXJ9sIOtkdIKM3
	 LQSbp+qp04yYFnVaiOaoZojrOERJls8Cr/B3gdJ8qYWtM4agzhFJj+yLxxTCMLQZoE
	 FnCfuieAXfBJw==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Iskren Chernev <me@iskren.info>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
Date: Sun,  2 Aug 2026 22:23:55 -0500
Message-ID: <178572744538.408250.642681486908453950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com>
References: <20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Jul 2026 20:53:47 +0530, Imran Shaik wrote:
> CLK_ALPHA_PLL_TYPE_DEFAULT_EVO type PLLs do not have the PLL_TEST_CTL_U1
> register, so clk_alpha_pll_configure() does not program test_ctl_hi1_val
> for this PLL type.
> 
> The GCC PLL configurations for QCM2290, Shikra and SM6115 wrongly use
> test_ctl_hi1_val instead of test_ctl_hi_val, deviating from the hardware
> recommended settings. Fix them to use test_ctl_hi_val.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
      commit: 830ead322c39c99bf972425b3c35323ec56c29de

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
