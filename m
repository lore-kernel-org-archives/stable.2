Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22A4B0C83
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552656; cv=none; b=djCCuBEMX/wCDkYu5bM9HoTNeMfTpIcvRcNnPnQUyrlG1tjSLY5JoPKPxABvFdquXWYZhTvuMgxslLe8H9/tDxC63RM1gSMWyr/+QOSkObjBE8Khewf4mGmGIpZ9rY8i2FdYZLcFXdyzzcJSoXz7xrJNXQXSvNuljy+ooSXziQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552656; c=relaxed/simple;
	bh=r4MxKVUpVOphBodMJ8sw/Wpc7j8tML5z/BSxDV9WLps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYf+Vf0ajrmWWnbJtTixSml2aXOFv4Fb0wKtoIy1ySY8/taVsymnfzfZzV88pGHuOjCmTNVzaLj0O58w/erfZ6s8IBxKbWsc5Xl93HwFKLb39RsQmqcy9IaEG3aSXfYTyQIUnNNy77kLaNJRYO4afgTPK3X3MTYRoQ3C6nF+itM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpYnGQHd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpYnGQHd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so16483835ad.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552634; x=1790157434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4XoxT2FpvN2jeEt9ImVCB0YUQFanB/NfCBuFC1HNkg=;
        b=lpYnGQHduFTTV7st20ooBUvZxZrLiQeq5wY/nXzzMKQoREiRPg4kLklBctdPLQy8+U
         LW28usYqtsHb1xd9nmVlsp068ez6077IZzcfjGOz6CIWwZXVXnoCXrKwdyJdltgMCh12
         6kDuDu10dmtnjQhhs/0uAUditbVSYRCEAOXn9q0w5QJ9KkJQZWT4Zrw3YxTg1aPOHVsd
         4O74WMaRKtnCrql1IY3tch0dMVqRqw7E2dmN6F9SYfdzTDt1Jk0UPU/0RNB5zbuzv3TG
         13B4NluSDogZ1Jov9hz0Gsa2vtFry1Dwf000UpyO2+Ip0YozCIx+Wm2eZABRskB80Nxc
         S7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552634; x=1790157434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4XoxT2FpvN2jeEt9ImVCB0YUQFanB/NfCBuFC1HNkg=;
        b=nmPMlorkQlGKt076luT+8WwfARSc6lwzXvEu7DxTF9zz2YjWrt7RLeMJKZbfOfdILj
         1pgVF3CZAt9o2sM/dn9ANC3soTP/kwgbmRL0xDqf57LS41mcLjzUMrMB/qC+yN0gplnE
         sRgNnQ1pjMcPtz1R/iOxi9/KsPU4BynGgq2aE4Kcz2jdRHe5nyy1hhKimJuJ+t7Bcgku
         tlQs01z/p20TaqD65KalYy7YRyVbj5uYcqlY9fUiyw7k/q5hNFn0cv2oYtJI/0i8ZIdF
         jHJwbROSVeP7+qyWfZWApmn2o3+5MM0+xZMRvSKoC2skUYO/D7p55kUyS+k3x4f1DcVh
         b5Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwKNLMi9MfI4bla8tpPzUFP8730U//nqyZ9A1LBHxfzL+50uo3pk8n9ts4GJOGXMaUGh8uRwTw=@vger.kernel.org
X-Gm-Message-State: AFuF++lVrIUx9/5xqsNVOHIIsS/1uUJrudZKs1DmNcKVh1w9+i1TvlWj
	Ui/urTQbZ9GiEOAZKM+O8V+htOhh6GKW70CGv0Enyd0JOtEkTTb0bO0R
X-Gm-Gg: AYBFou1T5Or/7NDnniWwz4R+LZiRjqVJxvCfBr6yfzgf1n4yGGwv7MKzagiiNXgMCAs
	VU+cSo26bvJ2OM4EYiZvzmMsVIDyK27Y8lalKCzBYctMu5Bo0MW9LsFxOU4IdpzAAwVs0nyZ+ou
	UZpQcHS8N9XD46TQI4OpFl3QtEkR30Q7qa0Q68CqmxpkgzKXm+bJBPpNpSNDcPg/UTPUwyAkIf2
	tMkE1rAHajmiSUriX+cVuF00dNVurOWfKOGh9vOU4UZuEw4f4jpp4nIcW4UivCbC5VUhv8hWj8+
	MMXXg8QmQp/MX+SNnhhlalBV1E9XUjvDiEb0GJoftBkC83PBXinHFgq51FXcNF8m6fB0Fm5L9Sw
	+j8KEa6b9TaVnIRZWQAqQFk0niubpGRi6YlQhIg7akH8hLGC23mTKFMneexTfJa+3KmAWXMmkCj
	RYGQSMdIvjCLXrlxoh+TOQYu+wLO1hyI0yJbBxiXSpcsw+8f3WmfpZZkIQz5uUmxZoYz1VoQ==
X-Received: by 2002:a17:903:324b:b0:2da:e553:c6ff with SMTP id d9443c01a7336-2dd764c1b47mr95237755ad.9.1789552634365;
        Wed, 16 Sep 2026 02:57:14 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f34921sm8679235ad.84.2026.09.16.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:57:13 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:56:31 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, "Anton D. Stavinskii" <stavinsky@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <chen.wang@linux.dev>, Sasha Levin <sashal@kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.12 0889/1376] riscv: dts: sophgo: cv180x: Allow the DMA
 multiplexer to set channel number for DMA controller
Message-ID: <aqpnHyo8p2ygP1-8@inochi.infowork>
References: <20260912065607.535295758@linuxfoundation.org>
 <20260912065627.376202771@linuxfoundation.org>
 <812a006e-a7ad-4a66-ab8b-45865cbe47f4@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812a006e-a7ad-4a66-ab8b-45865cbe47f4@oracle.com>

On Wed, Sep 16, 2026 at 01:30:56PM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> On 12/09/26 12:25 pm, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Inochi Amaoto <inochiama@gmail.com>
> > 
> > [ Upstream commit 5011466bade64483bb52bc4a926719d6794e6dab ]
> > 
> > Change the DMA controller compatible to the sophgo,cv1800b-axi-dma,
> > which supports setting DMA channel number in DMA phandle args.
> > 
> > This dts change does not break backward compatibility as a fallback
> > compatiable string is added.
> > 
> > Fixes: 514951a81a5e ("riscv: dts: sophgo: cv18xx: add DMA controller")
> > Reported-by: Anton D. Stavinskii <stavinsky@gmail.com>
> > Closes: https://github.com/sophgo/linux/issues/9
> > Tested-by: Anton D. Stavinskii <stavinsky@gmail.com>
> > Link: https://patch.msgid.link/20260511063818.463877-3-inochiama@gmail.com
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Chen Wang <chen.wang@linux.dev>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > index b8063ba6d6d7f..e519a72c093d1 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > @@ -298,7 +298,7 @@ sdhci0: mmc@4310000 {
> >   		};
> >   		dmac: dma-controller@4330000 {
> > -			compatible = "snps,axi-dma-1.01a";
> > +			compatible = "sophgo,cv1800b-axi-dma", "snps,axi-dma-1.01a";
> 
> 
> I ran an AI-assisted backport review, and I have verified the report. It
> looks valid to me.
> 
> The patch adds the Sophgo CV1800B DMA compatible, but 6.12 lacks the
> matching driver support from b49c70273801. The generic fallback
> therefore matches and still calls dma_get_any_slave_channel(), so the
> phandle channel number is not honored. The branch also lacks the CV1800B
> mux driver db7d07b5add4 and its syscon/mux DTS integration from
> 126a1b3c61cb.
> 
> Upstream driver code after b49c70273801:
> 
>     if (dw->hdata->use_handshake_as_channel_number)
>             dchan = dma_get_slave_channel(&chan->vc.chan);
>     else
>             dchan = dma_get_any_slave_channel(&dw->dma);
> 
> Downstream 6.12.y code:
> 
>     compatible = "sophgo,cv1800b-axi-dma",
>                  "snps,axi-dma-1.01a";
>     dchan = dma_get_any_slave_channel(&dw->dma);
> 
> Downstream falls back to the generic match and ignores the channel ID.
> 
> Maybe we should be dropping this or reverting this.
> 
> thanks,
> Harshit
> 
> >   			reg = <0x04330000 0x1000>;
> >   			interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
> >   			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
> 

I think this fix does not change something as we already have the
fallback compatiable, even if we does not backport the driver fix.
As this does not change the behavior, I think this could be kept.

Regards,
Inochi
