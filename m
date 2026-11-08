Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C5D606AD5A;
	Sun,  8 Nov 2026 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUY/NsYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070A81F0089F;
	Sun,  8 Nov 2026 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169500;
	bh=nvWk1PiyXpaqcMFTVxrKzLQiCOZWKcB8X830n01hguU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUY/NsYgH2D4mRnoL3rHqAtBb8Vx2eMWrWD34PMr1JACxeYQAuqZqn38EJgc7bBVZ
	 0z/0npP9OGi2VnKXNCVjKf5RYcnIkiV1ZNSojwMDZr7pyNzNlbSPG9H/HgAfa6StY5
	 vj0aLGLQLssWpD1Im6s/06xkQBX8gw/BBgoNwWJpmtgt0YURpy8Wf1gD9K/zbOrz+Y
	 m53waUsarS8kucMVsbVkKanmzOeEauBIJZ6+1ZXadsqbY99iB8r+H4WpeZ/1kcF1fX
	 qapExYImG/7y7oMZgWDNYv1RDfmISkM2chSV9u3flrGCKL8p6FEhQJCfhSky+gxgyk
	 85+q55uTO3P8Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/4] clk: qcom: Add Nord DPRX clock controller support
Date: Sun,  8 Nov 2026 14:21:25 -0600
Message-ID: <179416929494.628393.10153371199936746026.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
References: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
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


On Tue, 27 Oct 2026 23:38:25 +0530, Taniya Das wrote:
> Add support for the DisplayPort Receiver (DPRX) clock controllers found
> on Qualcomm Nord devices. There are two identical DPRX clock controller
> instances (DPRX0 and DPRX1), each providing clocks for the DPRX core,
> audio, AHB and video memory paths, along with their core PLLs.
> 
> The DPRX PLLs are ZONDA_OLE instances whose PLL_ALPHA_VAL register has
> been widened to 28 bits to carry the fractional word at a finer
> resolution. The alpha-PLL core must support that width for the DPRX PLLs
> to lock to and report the correct rate.
> 
> [...]

Applied, thanks!

[4/4] clk: qcom: dprxcc: Add Nord DPRX clock controller support
      commit: 8f95d9bf51467db9009a79c552caa9b58e726551

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
