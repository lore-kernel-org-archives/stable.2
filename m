Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169311;
	b=KmgKFdpXIcMjAix2oAu3N8A9+Ci4rqW1liZAyfbsg0mhlNhmetGiEvbfCr8NbOv8KhHF
	 p4CBIvch33TDnS0DUrDnnJefZOFHBYK9K8Ff2LYc1suQo92FoAMCa0j1fLhsRgcNwg+yk
	 n6E+SMSZm8Ai3tdzsvPoKL0ezgn98/xKsPM6qsg3HSE4+cDpISmu3bxGxmFRdkYeRpZJp
	 LUDzvalIpcNxX56UKR9mJjhAa4B6myTO0ovcfN6FYEBibrHRJaLb30S8Qh7TAYmAo0q8n
	 d478A9YvIefsQA+9yrhSkG9399QM4/8VqAI506MWpgAJupefLzl3YNHneCNfqMVDUeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IJ3DlpOU/rMKKraE49XwNCskWUFX3fET/XBrktPpB8A=;
	b=5CjqKmKMAyn4CwiqDxX0N3gl/cUrQGP1OD7fDGfxFXObmkUoLrGI6WGBzKKHc89GfUYU
	 Oytf7rSlm5Znxk+tPDMAJyUnKlZF7VWawmoLvdd3Ohb1g0lpa+LCLc8P3vO3s5TKQzYNL
	 VEVZdkxwj2hdK2EKT7Hkc6yuoA37fWTB15WhJLddET4XT0Xe9OtRg1gWa6IqPuGGjKYt4
	 ZdK/c6q3auadutuF6hOtFsO2MWgb3DeaHZvEhq9jms5osrclQs6SDNfPTRls0QbG8KufU
	 ptffYIn30FcT1hsydO+kyfhwsxcyTq+O2OSocD8ly/j2XISJP59So1rLTgFIEOV6O2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9e0v5lD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F88606A334;
	Sun,  8 Nov 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9e0v5lD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A481F008A3;
	Sun,  8 Nov 2026 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169310;
	bh=IJ3DlpOU/rMKKraE49XwNCskWUFX3fET/XBrktPpB8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9e0v5lD796HQirWWZeeh22grTZ1SMiZNn+Ig/LWK+LgEt2Ct9aHQM0U5V3UAmSP+
	 nBS45sj3AGwn1f1HZoKnTs6/vS3Td+WiIoeNEM2gP7O1r9krxPdJnACwyJ9n1CfAWv
	 vkWH8Lb0RHcrrMSBrounkkgJA1DH/iZ0+fKOL2QolLOnlVgi2vgvxe6VJoAanlbhLf
	 mZCqq19gMDxw/P7dZkzCjcmuxZPJWCTAj2MZ3e6maA+iiPEVVB84aKkPMJh44vDF3r
	 9cGKX4s36ix2QtCMrKMWd6Cya2sku6S4Jrblglgm/DH6mFe+d9S5ca/khyFbOvHFdr
	 1N2mVdmszmPqQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: Fix use-after-free of work items on unbind
Date: Sun,  8 Nov 2026 14:19:10 -0600
Message-ID: <179416929536.628393.16734740753688451624.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102-pmic-glink-altmode-teardown-uaf-v1-1-377d92e3b5e2@oss.qualcomm.com>
References: <20261102-pmic-glink-altmode-teardown-uaf-v1-1-377d92e3b5e2@oss.qualcomm.com>
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


On Mon, 02 Nov 2026 13:07:19 +0200, Abel Vesa wrote:
> The altmode context, including the enable_work and the per-port work
> items, is devm-allocated, but nothing cancels the work items on unbind.
> A PDR or GLINK notification can queue them on the system workqueues, so
> if the device gets unbound while one is pending or running, devres frees
> the context, the typec handles and the pmic_glink client under it, and
> the worker then dereferences freed memory.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink_altmode: Fix use-after-free of work items on unbind
      commit: dc95951a6ceb6982eb357bac6a503aacf1e7d105

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
