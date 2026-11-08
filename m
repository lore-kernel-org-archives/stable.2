Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169420;
	b=i2f/koE2UvC82O4fOW9A8M2uWIzj/8WnJ77rrY2ARiL0P6DIkmHgSotrA0OFKbDoc/2F
	 6jYjcb748m+hqPbKRvjPD0K7j9SxTSHLvVdI1m0Ds85eaFORCWMljZMHdLF/JidIr2Vu4
	 7+wH8fphQmpRNnT3ay/GlCr1YMf0QAGKTBTO6NIo9v0qyzLDDJ5DCzJUg3rj+AchRsywP
	 ktdN0e6rVWxi/FJCciyD4BilOsNk0Kzm5FS4wLYkq4NsE4l90oZJ36KD9styMcarUP0ry
	 oJWS6vk+9fm0iJtWDvhL8SQpjcEsH/ryucKemPKx5JjJlCpx9+Hevp+faig5nGmpuPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TwU2Y+hzki95ysuTi4JjEIpttEYFac5IFIOZYIJ7PSY=;
	b=MuFKKdXyrmIL341ZlxlGuCTuFERJkZoHG0Md0tg1Pmm00Wv0CKqHApCZZnfcBp91zugk
	 PJC+QfCTfUNQoNY+vR8FKDjNQlscNIpDVI3hAYI644tkBCEqlblnoPsyuIADWFk7Mcd+7
	 FkSsIeGkVwd13bqDK/a6+ylarR9B5Mb0afCYmNtLSi53v/XWGpd6EZZj6nKJIjPLg4NZ9
	 xBc9Oe0YOKig0F/ZevHwsfN8G4EVS7inDawRmG7tkXachbMP4GjYfrLdVQUkY6H64J+Ox
	 pde6klhgvI3AtwsAERQONi2OBa5J9hhiGzwS4Ivgo7PmxC8caFpI2SOZ9lo3eHss0fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSbBSaA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FA6073428;
	Sun,  8 Nov 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSbBSaA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FD51F008A1;
	Sun,  8 Nov 2026 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169420;
	bh=TwU2Y+hzki95ysuTi4JjEIpttEYFac5IFIOZYIJ7PSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TSbBSaA7M+42dFwaLKzfWP9F8130BkSFKN1tMfHZXpi/CDrncvPqBo3mppUXXEWvG
	 TVg4St4L3QOwguIPaFmc8TZYYCFuh2uquRv4jLHGQwyyPaq9zPW19XJCmSDFiG2ku4
	 LWy1IGsxtjGjFqYpU0SXZY59aE/kosbj1+nNRfFzQhyz7wLxBJ9cCqAr/wDEz4JwXk
	 7xh9WuDEtGNUv0u0OMV9kN39mRNRc+vBfxOkmFaut5+Rkd8W21mkHz75/wqA6c0Oei
	 OXNnLQHNQkrtUOk0aRpv7DN5YspAN9/PzfSMcCO//T3eP7l/468SFKmdXhegk22Ghf
	 3ig6HL7tucffA==
From: Bjorn Andersson <andersson@kernel.org>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] firmware: qcom: pas-tee: Always initialize resource table output size
Date: Sun,  8 Nov 2026 14:20:23 -0600
Message-ID: <179416929546.628393.8375115262933948163.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
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


On Mon, 02 Nov 2026 16:01:11 +0100, Krzysztof Kozlowski wrote:
> qcom_pas_tee_get_rsc_table() sets the "output_rt_size" only when the first
> TEE invocation reports a size smaller than the input table, or when the
> second invocation returns a non-zero size.  If the TEE reports a size
> bigger or equal to the input size on the first call, but then returns
> size of 0 on the second call, the function returns NULL (no table) and
> leaves "output_rt_size" output parameter untouched.
> 
> [...]

Applied, thanks!

[2/2] firmware: qcom: pas-tee: Fix purely theoretical out-of-bounds read of resource table
      commit: 203dd5eb5b223cc10f674c1b9e5be507fbd06a59

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
