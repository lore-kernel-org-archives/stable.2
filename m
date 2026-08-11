Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6D44471A;
	Tue, 11 Aug 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456271; cv=none; b=AO29SftDuPO8Gm/M0FYyy5xIHWgO2AYVKRB0mB0R0yyf9WpJWOxwtNm4Xw7N7bOpF2ELTnuSnDxCxsVkK+QAaG3/ODYuPX6sTsUSYzN4SekN+nhlU0zZzFpAgjOthyHbEhYJouEsJRE6TG42EfPPxpWKWHoUdday+cT8wNtfjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456271; c=relaxed/simple;
	bh=5iL4OIqPlnJLrumaa43NF/fSPoVB00e4dXiibyZACiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECFny9MznZNbAK56QAUD8JDahfwZ5noCw3PEp+I7dlYKpmoCDHofRDgmWXJWRrjpsjZ3lXE2rtroQgnhs47q6yOtyJ+kDjOV5X/3CIlBguVr3I9KvFbEPxdX6AWQeyEayRdAvu+Fqa22w3uah2rGV4TcGUflhxLyviRQUIJxXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr/jdJwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr/jdJwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFB21F000E9;
	Tue, 11 Aug 2026 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456264;
	bh=UBILun7qPRptwdmu9LCu16xBfULu1xWnFXYbEEW192A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pr/jdJwVl2BAIFet6tFrv/tq2Rj7SBciCOYgZ+pQTaB0TW69p+af7SQJOW4ct4cWu
	 CtZq5jvp2qrSimo9emVQFv73rhPiyzSsI5XREB3fHFdItgbfRidweEym2Am5+TDtNq
	 sng4oguvcHWVLkroXjBEq1O6uyG5+hsYYxePMbIxFOI2fQSDKadHR5w7U+EgetN7AQ
	 vWo/Q7w0/LNrDPMI1cA41gGXw7ag03xDOoqsFEB3srkfA9U8DvslxV0eYYv+fp+EJc
	 SjUSlnuX7p4Xs9Ju23Hw78yXl+JEHbivn0YOo7qFX2YQQtMl+prt5tD6NaAE75d3QA
	 XxZR+FhSpHsZQ==
Date: Tue, 11 Aug 2026 08:51:03 -0500
From: Rob Herring <robh@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Mansur Alisha Shaik <mansur@codeaurora.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Hans Verkuil <hverkuil@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property
Message-ID: <20260811135103.GA2063083-robh@kernel.org>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>

On Sat, Aug 01, 2026 at 01:07:27PM +0530, Vishnu Reddy wrote:
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

The only side effect of 'dma-coherent' not being present should be doing 
unnecessary cache flushes. It should still work. Maybe you are missing 
some DMA API sync functions?

Rob
