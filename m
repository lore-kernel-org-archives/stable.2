Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1F400963;
	Tue, 29 Sep 2026 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651758; cv=none; b=CEPcfRtYP316GD1Z/Ul8KeFI661k42fnu1VwNrg2ZenpuY4fW1Oqu6RdlUXFbMRbGqhXVkKsRHqSRM91KWm3znU38HsrfoJ3B28p1xlqwZXutr/YoSV51Ik4rLKAN7r6Pcg4gh4d2tWuVY/IRzbPA0eBbs2LJ4AOyaVVLfVNyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651758; c=relaxed/simple;
	bh=rMMywrQPVotdTJXKWnA7fA/jIw8kTH4deSYUGjACCn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIiJYJNKD7Op72WQMBWd7w486OP4Wsl0ACLeeKZvbPpOShu+RKECKY8ABIACiIBeQ0G6NXrutzvbHHkBLv552plYFOiAptOmHiRWNoQV7AqPe3pB3ZqWb8OCEU0oFLO+bCNqXEY4Qg7lSbJRORqUSIQmnN91TPdKWiZgxbfs62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjyA4a1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjyA4a1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A11F000FF;
	Tue, 29 Sep 2026 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651753;
	bh=78W0xyGmzjQhvYh02lpflQkqZHnBUWP9h5Jo9BRQgZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjyA4a1soY/+vRkBGB5ZhY8ksduABoq+kHh4nco17xL0Su00mJbnnZNkN9OL4Vle+
	 yAFCimwT8Pnm9UfN/PEeHYWir5fH4/WHm3q2Dqj7iFnhKbwAzLelxnvtBJFN8II/6G
	 dnHGeOTddqalSGT3BTv0qM5afuOKTasv1kkgPbcU68I1mgB9NQmbsWBmowJmeGEIot
	 mSNZ0F/9Q3lMwAHrtf0oceHEqz6boQPZPbtTHg8jS/4IkBnPLrBN/DE2VZbjh5kJcd
	 5lw3jAPWnFWBe2kDvrdYJjG+pIC7Qw3NNb/OAMQW4TrHu9PdtbnhF9E1t/UUXHyj+Q
	 86n3XElhzIYsg==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Kathiravan T <quic_kathirav@quicinc.com>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 00/11] Add a few minor enhancements to the Qualcomm IPQ GCC drivers.
Date: Mon, 28 Sep 2026 22:14:49 -0500
Message-ID: <179065171028.2673486.10540547681271836423.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 21 Sep 2026 11:49:33 +0530, Kathiravan Thirumoorthy wrote:
> This series adds USB, NSS, and clock-related updates for several
> Qualcomm IPQ SoCs, including:
> 
>   - Configure the USB UTMI reference clock to 24 MHz on IPQ5018,
>     IPQ5210, and IPQ5332 to fix USB enumeration issues.
>   - Wire the USB3 PHY PIPE clocks to GCC on IPQ5424 and IPQ9574.
>   - Add NSS MEMNOC clocks and corresponding clock and ICC IDs for
>     IPQ5424.
>   - Connect the IPQ5424 PPE clock to GCC and document the required
>     clock input ordering.
>   - Add UNIPHY XPCS reset definitions required for NSS support on
>     IPQ5210.
>   - Fix IPA-related typos in the IPQ5424 APSS clock driver.
> 
> [...]

Applied, thanks!

[01/11] clk: qcom: ipq5018: add 24MHz rate for USB UTMI clock
        commit: 0fe2995196a5973e226f506c9ec705f0dccec82f
[02/11] clk: qcom: ipq5332: add 24MHz rate for USB UTMI clock
        commit: 33e6a4864ddc4824f8a9505a97232b7879eb5528
[03/11] clk: qcom: ipq5210: add 24MHz rate for USB UTMI clock
        commit: 0336b65aef4721edbc01073dffdf9bc12673f0e5
[04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC
        commit: 117d8d40be1ded4f35f3252efa83607a7134d5e0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
