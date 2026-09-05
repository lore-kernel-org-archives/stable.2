Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E8316199;
	Sat,  5 Sep 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569035; cv=none; b=HfqJ216ElnZw8JNSZTGObe1k5pws5h4Mcv8gcue8SzIrEJtHDeNwXktxg8jUMizKj92dtMRL6cWJWMhtgn+PpVSrtbTqQVEe858LtRvNZXlM40imdaN1iQtZdiH0vcxYNX0cTy0SkxsGjrZhN3vlc/SFbYK7nHswYyxqVNCyPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569035; c=relaxed/simple;
	bh=tONzXXHVRexwihwa4L8T4PU+35XWSS9P+DHRbSS/RCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT2AzmRGHt37tLMirXHTNEUQMwLlWhM0QjEGn5J9Cyw/0/No0vrZU4t1t05zlgY0DWm2q8lf/5Mbog1/nJKTAwVbKxXZW++QrS2dWSku25MBcvo6zyvUMdX+iGuCnEA446qBgKuENU/TG7DW6k7dP9bHMF/F9jv2X5YQwAxYIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdWB7yhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdWB7yhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B821F00A3E;
	Sat,  5 Sep 2026 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569033;
	bh=mLcC8ESRfSwGtYect34ioKI8+g7lGs8VhTWZ3wiIVS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HdWB7yhcCdfAKim/IIEUz4wFYSEuPJBDnSHw/SsJ3Gcc7xIocHgQYh0G6/Yk7xCQb
	 HbMdfvSlriDWx+4PWZzX+3lgEl0/lYWpZdXMsoC1LJjuo/ruF/114ci8I0lQNo+Tse
	 A2FoxmgVt1IYlpaeXuZ6REpskXHY0zyd7s0XABnWIqFSSivFDlrshfe7GrPR4XX4/W
	 4EEn+V/d3KbIX/QD+rHiZgH6XsGMSMKePHVU7uIdWpjA+agbsTqsUg8iRMCsYta+iI
	 y+/7BZi0XOfmCCT3N2uUj5ATTEFhtITHFQ5qlATC36fo6E+ULv1ntS7mPukDO+7xzY
	 IT0RxHCfTJwRw==
Message-ID: <e57052ce-96a3-4006-bb06-e3349d1bff95@kernel.org>
Date: Sat, 5 Sep 2026 09:43:51 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
To: Niklas Cassel <cassel@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
 linux-ide@vger.kernel.org, stable@vger.kernel.org
References: <20260904134310.1465051-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260904134310.1465051-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 22:43, Niklas Cassel wrote:
> A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> 
> The failure is seen as soon as the ahci driver is probed, and booting with
> iommu=off does not solve the problem.
> 
> Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> for HBAs that do not support 64-bit addressing.
> 
> For HBAs that do support 64-bit addressing, the registers are read write,
> with a reset value that is Implementation Specific.
> 
> When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
> addressing, and a 32-bit DMA mask is set by simply clearing HOST_CAP_64.
> Thus, in this case, we need to explicitly clear the registers to 0.
> 
> Fixes: 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585")
> Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
> Cc: stable@vger.kernel.org
> Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
> Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This is clear now :)

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
