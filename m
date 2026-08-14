Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57359477E31;
	Fri, 14 Aug 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729749; cv=none; b=V5Sm/52AVDlZquqTO2nhH+xo2QBn38Naxvnr+D8Em8/EVYCPl4uOhi58NFCo313DDelK5b47ENnYFmFgH6MqSQn2Wl1jyiAF7+30cv+6Mh3l8nr4BgF3e8h0EcBnHzwY8qvJUYZfn+z+JgLvF2dDcXrKa3PpZgu3mB3zh+dmuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729749; c=relaxed/simple;
	bh=WiMdb59+b31lr74VpZ1vPRs0h/z5NpcPddg6oaeJ/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzg2KptjuEl3sXnug1xZtkNb5Fq0kdUEbxasc4yvzQBK+1vdf32pfyyIw3WAKjssEGl2L3smjRPl/HebcxRA/i2k44it7/IrzgWjNAuOqPOCtzfjsMHTS6CCppSkj9ZlNfYOetwdqExOKV8FZhxnG73OMGif0KBea0zWRL2cU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiO5de/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiO5de/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D011F000E9;
	Fri, 14 Aug 2026 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729747;
	bh=vUScZQaDO9LOJUAA7/eGGTWqCSli6iZ/EX6QJoxuS+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WiO5de/2thRArGyJ9iBATrXsY/4ttOOkENioAGX2qsM7Xe1dCzIpn+CYG85tfRK08
	 ZftIPiRzngAPGPQMlFzLfadtoZrEFjALLk7BCrPk+eogNNwaNEZXRzwXJO5fdBtvLi
	 uPlNbAMvuGvBowQ7aPEa3+5i6tvNxawjZhsbFjbFuDsmXWwQHF3AVKrXoA59ZYxVEd
	 fckTnIMKzNKBP3YG4vMUC+OVDmam2Ib69kZytKUEHKSan1Bbl24ks9s2gJ0v3DmQ6Y
	 sFvWfIjE2keRNpjUUIPIBTllUsS5/03U1tIEe9bOecO55CP0Cw2MeoLiCgaZ7M/mW4
	 6fc6h9/mJRxHQ==
Date: Fri, 14 Aug 2026 12:49:07 -0500
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
Message-ID: <20260814174907.GD1981719-robh@kernel.org>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>
 <20260811135103.GA2063083-robh@kernel.org>
 <46af20c8-1182-2db3-0099-63e27903a6f5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46af20c8-1182-2db3-0099-63e27903a6f5@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 10:58:47AM +0530, Vishnu Reddy wrote:
> 
> On 8/11/2026 7:21 PM, Rob Herring wrote:
> > On Sat, Aug 01, 2026 at 01:07:27PM +0530, Vishnu Reddy wrote:
> >> While testing with some higher resolution clips, the venus hardware
> >> triggers a fault due to wrong input data being received. Corruption
> >> was also observed in the captured output when the client dumped it
> >> to a file.
> >>
> >> On debugging, this was traced to the venus node not declaring
> >> dma-coherent. As a result, DMA buffers shared between the CPU and the
> >> venus video hardware/controller are not guaranteed to be I/O coherent:
> >> CPU writes to an input buffer can remain in CPU caches without being
> >> visible to the video hardware when it reads the same buffer, so the
> >> hardware receives input data that does not match what the CPU wrote.
> >> Likewise, on the capture path, data written by the video hardware to
> >> the output buffer may not be visible to the CPU, so the client reads
> >> stale or partial data, resulting in corruption.
> > The only side effect of 'dma-coherent' not being present should be doing 
> > unnecessary cache flushes. It should still work. Maybe you are missing 
> > some DMA API sync functions?
> 
> dma-coherent tells the kernel that this device DMA path is hardware-coherent,
> so the SMMU maps its buffers as cacheable. That attribute is what causes the
> coherent interconnect to snoop CPU cache lines on every VPU transaction, so
> hardware keeps CPU caches and VPU visible memory in sync — which is why the
> dma-coherent property lets us skip the unnecessary cache clean/invalidate.
> 
> If a device doesn't support I/O coherence, its buffers would instead be mapped
> non-cacheable, no snooping would occur, and the driver would need explicit
> dma_sync_*() calls at each transition.

The driver should have dma_sync_*() calls regardless. Even if cache 
flush/invalidate are not needed, IIRC the calls still provide barriers 
which may be needed.

Rob

