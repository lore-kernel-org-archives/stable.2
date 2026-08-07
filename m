Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E242882B;
	Fri,  7 Aug 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119848; cv=none; b=WVz1+U7mJybuydHue8vI5vdSTDK9sYAv5b5uNa+TvauAqziNC57wKsc9VHkn5R+L7Kv+WS9NupL296hyaE+ukVwIy0OvMrFgSQuD3GuTTKipnxUcoeCtOa4CffKNVfYT2Tov8l7uijJxIxYn7pqJtmhAhCcHTDMupuLXAyTQ+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119848; c=relaxed/simple;
	bh=HJmelZBkGJ3fs60a9AFTN5SU/MTv4T95mVU514g09d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQvYiAnGHzNoPLML93QTOR5difhsA7h6bdEwOEN34ZEWVBwytRioOgH/QTLnERksAJGgI62j+VhO3FC73+1luFvx9VHEjAfgQd/yG1JwuwhTwotYFLWOo8IQ4LhtuA+UT7wcZ0zr6P7WuWAx3tND/fI2UKw8Qa77LKd8rC1rWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LukuwJoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LukuwJoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E011F000E9;
	Fri,  7 Aug 2026 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119846;
	bh=JpK2GRoQzXcryb8G9EYVZqijm6DNJokoOliHq07rgC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LukuwJoBKFNiyI/39Ka9P3qQM1VQJHQlTb0dvdfRUJtLNMU2EFD87WyQY058kY5t6
	 5cfijZWM1VxIpsZSpX/5OU03Zfz59FRfbgwjr43sOuJybafMDWkVh8zkffT8y4mBGh
	 UCWLBg5e+DV7qaiqCdMhBbArItG30ozebJeuaYY7oc1Lw5mj/Sw/5C3rMMHzvatQ9d
	 Lpcv8GrM0RQxFCod2/QuFp6/hpi/PnrHNXyKH98Hgn1GttfdT7ImIPDNkvCUuq6oLK
	 JE8ZpgpQunNOsKHT13IViOgHd7nT1gX1Sxqk7n6Xwe9+Bx5OP1FS7Sbch05EwOz6zp
	 lFRUOXou+0HxA==
Date: Fri, 7 Aug 2026 11:24:05 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Mansur Alisha Shaik <mansur@codeaurora.org>,
	Andy Gross <andy.gross@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Marc Gonzalez <mgonzalez@freebox.fr>,
	cros-qcom-dts-watchers@chromium.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Aniket Masule <amasule@codeaurora.org>,
	Malathi Gottam <quic_mgottam@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Dikshita Agarwal <dikshita@qti.qualcomm.com>,
	Renjiang Han <quic_renjiang@quicinc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range
 for Iris
Message-ID: <20260807162405.GA896590-robh@kernel.org>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>

On Fri, Aug 07, 2026 at 12:03:50PM +0300, Dmitry Baryshkov wrote:
> On Fri, Aug 07, 2026 at 01:54:48PM +0530, Vikash Garodia wrote:
> > From: Daniel J Blueman <daniel@quora.org>
> > 
> > On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
> > below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
> > into that range, from any other stream id would triggers unhandled SMMU
> > page faults that cause spontaneous device reboots. This is readily
> > reproduced with one or more browser tabs driving multiple concurrent
> > video decode streams.
> > 
> > Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
> > and reference it from the Iris node so the IOMMU layer keeps DMA
> > allocations above that boundary.
> > 
> > Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
> > Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel J Blueman <daniel@quora.org>
> > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> > index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
> > --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> > @@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
> >  			hwlocks = <&tcsr_mutex 3>;
> >  			no-map;
> >  		};
> > +
> > +		/*
> > +		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
> > +		 * primarily for non-pixel buffers using different Stream IDs.
> > +		 * DMA into that range triggers unhandled SMMU faults and
> > +		 * spontaneous reboots, so reserve it to keep IOMMU
> > +		 * allocations above this boundary.
> > +		 */
> > +		iris_iova: iris-iova {
> > +			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
> > +		};
> >  	};
> >  
> >  	qup_opp_table_100mhz: opp-table-qup100mhz {
> > @@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
> >  			interconnect-names = "cpu-cfg",
> >  					     "video-mem";
> >  
> > -			memory-region = <&video_mem>;
> > +			memory-region = <&video_mem>, <&iris_iova>;
> 
> I don't like the idea of this series, because it _again_ doesn't tell us
> the truth about the hardware. This typicall ends up with bigger problems
> later on, when it starts to affect other bits and pieces.
> 
> I don't want to NAK it, but I'd strongly ask to reconsider it.

I think this is an abuse of /reserved-memory. reserved-memory is 
reserved *physical* memory. Reserved IOVA is a property on top of that. 
I'm surprised this passes validation. If it does, I may go fix that.

Rob
