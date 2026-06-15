Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521C1EF39E;
	Mon, 15 Jun 2026 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503318; cv=none; b=Y3WakZ3pZxOYgS0+3i4BtH73kt0FHsq1f/M0l5wh2bk2No04HaPo5XSxqo3NyZLKyOecosEnp6fJyqBGd0vfBB1Xw19wZx6KQiBDyl/M7NfstM0W3sE4JeNAt8HXL6iK+rDhDyKZhhWL0cRIDnrNpOyRKwV+fw/Kc4PL1WjO1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503318; c=relaxed/simple;
	bh=K3S/o5+3HAZtlOghGAkYz3SEwKaNJo3soPBjf3FLC8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+CCIw9o1FiDJ3QvS9yu2SWapkrsC+hzoZdOqhvBWgdIZh1Y22ZF964Iu1VkaLbPZAB+VIYGeE+fLFnUloNvY3c3WSGB06Uz9b2PGimRkk02dfgbKtzHKixxOqEPXzYUbzejBz6sAiB9ujpCXg48Z20iinC2qtdxHlKPjZ3QJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWRWXahb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWRWXahb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65061F000E9;
	Mon, 15 Jun 2026 06:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781503317;
	bh=Z4mQuAeDa3x65OGYjnjrERBHQho7AziCHYq10wuT1DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWRWXahb5P0sO+kXkhOyj1JCe+dR/vqRNdVb+hHuEPyRQerFltAovN7trOXNuMtps
	 htzKI4zkttQ80vRN/f/7I/M5JthrYIr6mPZysbJqNze3GM0mxiclYp85GsUaoR5a5Y
	 kcMF/xoK8NETY/dQ+ZjN402IvokWs4ICpWNyle/bCY/q8yRKNX+0Wq3HgxB+xzrLjl
	 kZoWiIuuFFeRFJ3Xd4roSDXOHivlILiFbpTTwnR0D/+K4svDKUIchKMkZRTO+zpmhP
	 RKz87S+n1EFGGVK181ip8M/hhy7sRSjzzqvtv9YFxD53wMEv/eNixRTz8LrZIE74WE
	 0U4Yo7S4xUF9A==
Date: Mon, 15 Jun 2026 08:01:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: media: qcom,sm8550-iris: Allow IOVA
 reservation memory-region
Message-ID: <20260615-new-peridot-vicugna-cbcb61@quoll>
References: <20260614145113.84243-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614145113.84243-1-daniel@quora.org>

On Sun, Jun 14, 2026 at 10:51:11PM +0800, Daniel J Blueman wrote:
> In addition to the firmware-loaded codec carveout, some Iris platforms
> need to declare an IOMMU IOVA reservation (a reserved-memory node with
> iommu-addresses) to keep DMA away from IOVA ranges that earlier
> firmware stages have already mapped through the SMMU.
> 
> Permit a second memory-region phandle for this purpose, and describe
> the meaning of each entry so the ordering is unambiguous.
> 
> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

