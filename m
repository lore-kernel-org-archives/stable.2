Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169424;
	b=3xx08ahQivnLn8sPB9m01rs1OZWJnxmTF9XQUYtyAxghVSdn0/9BT4Fjv3RZn05igIeh
	 JHDxf1HzOB0nuPhfvD35MD1xc5O3yljTaviVlgGHQYOfncO57rTPtcdIjrLqH68KquiK3
	 dCLwFTKCfJPg3bGzH0NVMlv5ow/7Xk6sOZb4YDW2JRlKOOOcSz3mL60R+7vtj1yuLwliX
	 Asq5jvQoqeDyVYyEhocI8RJZoIU9v/t/oenMC3JmpXh5h9Xn5T7JEsJq7OwxCgseb+CsN
	 tG6vIFEAMJbnija6WwcGr91iZ7wzHWbmi8O/HYq6SmmggR9PgJ0b/Gk3AwAlzMge39g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fB2eRbBGnXG4j5Aw7yiLVnjpzdeK1AjXze6Zrl8eOYw=;
	b=PwiZ+zpORB5d8cW8yf8JObYUioAwKlZ/UsUWJCaWzysonmrBgnFKzo3gXSu3/JNc+VU1
	 pJ/CUakqWkOaIHMnK6CvyFZV7p/WB1oxo9KsgXftKd1Og4d/a2fmM2EuESLo+uB+FgojT
	 d+A25wA6DJyOrDlgt9O1N8YBN/c27ToufiE255vvAgiaO4ctgMlD3rHZX5CbAsrfgtmiu
	 4mSzB16jlBUGIhwum7PnvKjb3TBTvzm3iO0iDhzuPehQemrxCTGEpnlrjZIFgPWXI5f8r
	 fon0IFtW+mXzxEouiPi7Ovks1ZpP+UK+1EgntbWX3rQoDDKW1tGWzo59Ub9OPRjeULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy+GKQB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D66073CD5;
	Sun,  8 Nov 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy+GKQB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86DF1F008A4;
	Sun,  8 Nov 2026 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169423;
	bh=fB2eRbBGnXG4j5Aw7yiLVnjpzdeK1AjXze6Zrl8eOYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cy+GKQB4v1JnDQdBI9G648OXBDZbE58f3nlSiOo4lQJVeNcemEd99hrBaSnwu2wob
	 eBsnOt48eURYfw0hCKUXKVd5WoBkApki33Qv7LpAgOcR8sCNtW0oq0TOukdSv0QGPk
	 9eb0QNL49+ejfWzklioxcARMZNdhaG3eIrsyM7IG/U5y6fGg1Y0K2fMHasFdntn2PS
	 E+she3RySRMpQiaK6cQh0JMfh99MTkGaD3dbZW5FMJuqXwyIrUZflG3oE5Kp2ofFdL
	 OBASmtHysVbiLd+pvdL2tMkHA5Fn+Ap1+HCEsG6Nrqf31LuM43dpKdK3T/sCUPyj4/
	 g/DYJ5UpVzZyw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Chris Lew <chris.lew@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] soc: qcom: smp2p: Fix use-after-free of irq domain on removal
Date: Sun,  8 Nov 2026 14:20:26 -0600
Message-ID: <179416929543.628393.9198898842378865126.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
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


On Mon, 02 Nov 2026 14:35:32 +0100, Krzysztof Kozlowski wrote:
> The SMP2P interrupt is requested with devm_request_threaded_irq(), so it
> is freed only after qcom_smp2p_remove() returns or, in the probe error
> path, after probe returns.   Both paths, however, explicitly remove the
> inbound irq domains, unregister outbound SMEM states and free the
> mailbox channel before that.
> 
> If the interrupt is triggered in this window, the interrupt handler
> would use previously freed data.  Mixing manual probe() cleanup
> and resource-managed devm leads to such races, thus just convert
> as much as possible to devm to fix the issue and make code simpler.
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: smp2p: Fix use-after-free of irq domain on removal
      commit: 357af2197e419ff4918e1581b958f4832b94c699
[2/3] soc: qcom: smp2p: Fix out-of-bounds with incorrect DTB of too many outbound entries
      commit: be72e07d039377d1b4e07b54ec32908a4f63d3e4
[3/3] soc: qcom: smp2p: Fix possible out-of-bounds read with too many inbound entries
      commit: 72525c6d8cda880fce80d453493878c4dc12fe15

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
