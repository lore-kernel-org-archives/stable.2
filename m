Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B3410D13;
	Wed, 23 Sep 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202012; cv=none; b=SdOn7rV6oaRzc2UI0cHqBSwPPeuaRurwdpx+EfGPs4oMelRVF/PkJCsPecWaCYRVItV0660etzYhNsWKQAeU0J41KSGAo6Z+1sWyvZf09jG9vaO3kgTEviRSohVfuhVQ9/W5PFuQ4fZ+mjLa/K9Wq8pLJa4tYp3rbTlY7KiVD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202012; c=relaxed/simple;
	bh=Aix1h5GVe02BNFD/evtsPrkI6c8ciBplqAPLCPOKo4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk6QcIzhJ5OcuEe1bPpfE8v0LaZQNGBGBVbZKZ1ErBmjHx+OPaYR45XICGODkWFkkZ1XspakVYLNTy0a2zHa8Va5E9Y391LB0x/8Fgx4O4IclYsXjBNkRIjVnOBWcRiRow9hLH7hSWZxNY8aaO1mKxM1JCmb8jCmpEiSS30ZzV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg0xYVh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg0xYVh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71001F000FF;
	Wed, 23 Sep 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790202011;
	bh=UFurUP/7tBcWJ6BuQKkhtfaUDQI2vVJIWiX2LolacdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xg0xYVh1teFvZx6juHlGy6gbfgCJl0L1w6pxTplm/DWiqvWp7MZU0Wy+8jwYMHFdV
	 1sHA0BsVEnNvx2fNJOD1gE9r+mhuEHlQN+1Zqml6dCZ79utC8zrUi+VFnvtzOMedeV
	 OEt7iyRVN0ICln06y5aknpAUflzhqFpqvVucVEvTJHyRc0vqIhMibvzRYMmIhVzjKV
	 u8vIMIL2m/9OBBzTvV7ibmVVr6CLainZbxwipC8EvLYqwUBcz5rvSBznQQX/g4NMRb
	 EsVyOwJ9L3q4nTrOXJsHABcs9DNkoufQkEFdouEyvee9OrZyC3jytlq+4tkHPqT+m6
	 HAl8ard7SXWtw==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: Stanislaw Pal <kuncy7@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Jie Luo <jie.luo@oss.qualcomm.com>,
	Georg Seema <georgseema@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical
Date: Wed, 23 Sep 2026 17:19:58 -0500
Message-ID: <179020199807.520949.653061101070414631.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918-ipq5018-mark-gpll0_main-critical-v1-1-fbe8f27a0106@gmail.com>
References: <20260918-ipq5018-mark-gpll0_main-critical-v1-1-fbe8f27a0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 18 Sep 2026 11:27:49 +0200, Gabor Juhos wrote:
> On IPQ5018, the APCS core clock feeds the CPUs. It can use
> different clocks as its parent, but during system boot it
> utilizes GPLL0.
> 
> Under some cicumstances, the 'gpll0_main' clock is getting
> disabled during kernel start which results in a system hang
> then the hardware watchdog restarts the board after a while.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical
      commit: 00c90797607cf10f23ec5cf5aa4d2ef74366a2f2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
