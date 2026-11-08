Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168533;
	b=0LZc8z6qZDp8xYz63T/p1ttXnFvCQUM1X+9IliANhXTE01Vye1BmDc0CkCvJPX4tJU15
	 epS1aYp6QE3DYmROL6/fDQMtH7MmhEURPV3RNdEM28G4t3itYycdlaqJkYyduZNNQZnLi
	 1bLBMAPo83oYU85YErEAFWiAk/J5zME8IwjPGjugFWO1sHtHj8jR0V9lKeuqSptHpRUzZ
	 20m/kxNbbqEUZrv6EuafApasohvYrWJZRRRvpnDtFa5Y5tr4UhJHDwGgxUsBGUVZpprzh
	 4gZJWLBIFG8frnC1r3E0zPdXce7ugvsbprvllwqtW1V41D0L1mIVp35wy9vxu4Kmh1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gTjYsVRJGmlfWZW7Qvv44Jg40ecXv+9woQo+/ukc2Es=;
	b=SIbDnR2iPTwileWTLXBH4f26ap2EIPB5uyQpH6sIbJ+s4B55kpgMZUVFo9k9a+Pmq/bv
	 8211pjX+4Lcnazn6SuBdiMnUurraSi1B5h50Q2qHHMNbiRRQI0jyF1agmMYDtimb+B56P
	 QRLgO2ZCGSlSGrl2uRIXFRm2ztSbAZ5vRgMk0ExxCuD+vGRfhXHhveyJhp/Es/M0VHl7O
	 A5mrfJg4evVkSnP5BX5UUvsXn6CDIP/K9BPMTsfRxnZaWTOvR4BswqLNHX33T65sONKGF
	 jVcS3p+wthbezYrkCtM1HrgzEkV0uYw2+NK17usUWSUCATLrrrEihNeAt+setx63dsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c99UmWQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A327606A337;
	Sun,  8 Nov 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c99UmWQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5FF1F008A6;
	Sun,  8 Nov 2026 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168533;
	bh=gTjYsVRJGmlfWZW7Qvv44Jg40ecXv+9woQo+/ukc2Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c99UmWQ/DQNu84WrjkGdV3KUo5LJQ+ksXQeLvJ8Ud/IIYYFPT1Tb9WQWK1Ni4G7nl
	 8fX1WCWHPeK20JPIj6dgwBvXK8YYws6ACmg3bOERovW5mt/2oJuRgwjELVSesMmDUs
	 G/sRFlkPszxaak9+RY9pMziVkYxgzjLjHrKIVp60toyRCK3Vwtv699BF0oa4+2f5hc
	 3JMjkWpratydoxIH2PD6ZKfk6/ck3yvVU2T9CBSU8ILdA3eP0eKwTDf9DJF7Mfo83B
	 o6oDichQ/FzW4G/Pq8Im5kFv8dPN2cW3cz4gHCmAjc95TclRjgvutSWFBjSdJ1i8pS
	 5t+bd2QZjeYRg==
From: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Luca Weiss <luca@lucaweiss.eu>,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix proxy regulator array overflow
Date: Sun,  8 Nov 2026 14:08:39 -0600
Message-ID: <179416851788.24425.8337410554392369363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027-b4-q6v5_mss_proxy_regs-v1-1-6c5557e42462@oss.qualcomm.com>
References: <20261027-b4-q6v5_mss_proxy_regs-v1-1-6c5557e42462@oss.qualcomm.com>
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


On Tue, 27 Oct 2026 17:31:22 +0530, Anup Vishwakarma wrote:
> The proxy supply tables of msm8974, msm8226 and msm8926 list two
> regulators (pll and mx), but proxy_regs[] has room for one. The second
> entry written by q6v5_regulator_init() lands in fallback_proxy_regs[0].
> 
> On msm8974 with a device tree that has no cx power domain, the
> fallback table then overwrites that entry with cx, so mx is never
> enabled and cx is enabled twice.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom_q6v5_mss: Fix proxy regulator array overflow
      commit: ec1f9ba57b02fe12a6fa5f141206d439ba3d044e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
