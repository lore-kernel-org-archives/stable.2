Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7562F39C2;
	Thu, 13 Aug 2026 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612810; cv=none; b=byEJOnWy1GpzIiyU8euFSLAjxZx17mc4hVt3c6RVvShCp8O7hYS4h/Pfyu7WEnm+4Zsr359mLofttGi19AYNXotYyOrOEHPRCu5cNaAYNDQ4WOSFpfFNppt9xh9p9QJ88PtNW9oWVpgzWHMVPwjQxxdM6gQDVokWWQxaj6G4S1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612810; c=relaxed/simple;
	bh=WD/K1Kwybt/UTK1xr9nUogPjHmDRSaMpQ7xP3IPbXzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYZFv1JrkaNLInFt7nRZVCTh8m1p6zgfsWt9RhgS4W8jUXfhdE7NYhqeD503F6F9cAJvolQ6flmnlyyPpwzrQ+MsJNaR19lFGJnRD9bmP2FnaijOXJoTh5AkNq2UvtnkgpT3SX+j352DN8q9+TqBoxHH1VUGQQLtdr0RxW9jfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXCzyror; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXCzyror"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DBF1F000E9;
	Thu, 13 Aug 2026 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612809;
	bh=OHSkRs4KEkrny8lhy3H/h6oqzqJD/Yof8MZF9vXzETk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VXCzyrorL/HF4vkf5etfraIqCKEqrG5eDQA/tL2XvRHFG8rPZUu+xM2KO6AMx61Wv
	 U0evXa1L0PY7akrWh5fwddRmOoQPGds2sx0JVCzZ2g/MZKiynbM/DCf5JKRBQr1JJY
	 PejhchhDP75eFsWyfjg8RqLW99etO/1Kh2JzDhu56dlGETSjuITerG2S4LLuXPcB4+
	 HEcr2TYaasFohqW/TJX4ONyiOCs9KIxWPbk7VB0MoG0+/HDZedVKSFVRfhU8x5bRS4
	 UrwTMrhUN0YQ8kyKXz1JIrpk7HDnSvjj6fjck6b1v3nqGAlpOjMWuXKMNZ86gXTTkJ
	 cxZXTREatdgeQ==
Date: Thu, 13 Aug 2026 11:19:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Mansur Alisha Shaik <mansur@codeaurora.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
Message-ID: <20260813-frisky-augmented-crow-fd5d3d@quoll>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>

On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
> While testing with some higher resolution clips, the venus hardware
> triggers a fault due to wrong input data being received. Corruption
> was also observed in the captured output when the client dumped it
> to a file.
> 
> On debugging, this was traced to the venus node not declaring
> dma-coherent. As a result, DMA buffers shared between the CPU and the
> venus video hardware/controller are not guaranteed to be I/O coherent:
> CPU writes to an input buffer can remain in CPU caches without being
> visible to the video hardware when it reads the same buffer, so the
> hardware receives input data that does not match what the CPU wrote.
> Likewise, on the capture path, data written by the video hardware to
> the output buffer may not be visible to the CPU, so the client reads
> stale or partial data, resulting in corruption.
> 
> Add the dma-coherent property to the venus node so that DMA buffers
> shared between the CPU and the video hardware and controller remain
> coherent.
> 
> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")

Really does not look like a fix. How skipping a cache sync can fix
anything exactly?

Best regards,
Krzysztof

