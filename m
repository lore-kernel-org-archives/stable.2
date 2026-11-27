Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784545;
	b=WE6+rYSC/A7QfEsZdzLVSiOMvYtoE9t495VMfxuAzQgZpXSpDqju8OM4/osTd55iy4uE
	 erMX0i1+AmpJXTARFNFWKultar+7M3ux8crjh0JUNA7fDL5dFsU4lePMvoKlFhK7UWAqw
	 Dwq6i7r+IPtPP6CFlSrF+rULlZBHktkqVeGp6+uix/qctld6QiUp80RL2eXJp88g7JjWZ
	 YuqtXQLvK5ZDiIPCNDhM2SnHs+oQNNMPLsoLomgQ1PcuTtJCT3WeNS9/sFu4p5RqxSMCH
	 WfT5k3Pr2O9bKJpfYUqiUqJGRKN7jTdgMnWskgtvPmUgoaTPsCf983toP+XRnr/0oXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LtJEEQG4iK+tOAIiGdDHJtxrocD8+I8V0KWp8R71igo=;
	b=KlnYA/JhoBcKWaegmjHk8+sKwViB8FcdonXpBvsrK2d8YmRhpBWRHVSnxH9AaDRZN281
	 MfVjFn/E9KMaTVywZOrw+AFY+Btp2VL97zy0w5nb3HsZq1336eGqVaVFHtPux3Xy6SP5k
	 RsBg2hzOyi7FCx3AzL9qdwsEeVal8BJ1vuB1V2ued1NTIa7ci/3V4YEEkwJoTjj2Ko/bf
	 WiF0OS7JkAmUptOcPEkCw4/Mw45JLUW/7KYXwHBML3MxhgC1HA/0+Ym7cPOPWWjDULkue
	 FvHaLziXz6Oz5vzy8oq+pKs6ghb+wGH2jVdNb9QNodxPu7L8sY9jy+xX+/h+H7pg/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JXbB92Su;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42852606A31E;
	Fri, 27 Nov 2026 13:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42852606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JXbB92Su
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9198C1570;
	Fri, 27 Nov 2026 05:02:21 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E46513F86C;
	Fri, 27 Nov 2026 05:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795784544; bh=QeFOK6g8h2iQ2txNI2mx0B0PPeSALxkLl0Q5BbCVDmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXbB92SunCgR+kVz71rmMiUis52LA1z+gix44AySQQhACoDyc0LdD7F+RFyIqqgN2
	 BGftvxnt09g4GhWHRASIwOxPtgey38xSjx5/hu1Ay7j+RDY/Ifx2fPDgpSoz3UEbZ2
	 2pCGVjA4EEaDZgJEFaYNECT83+NmviaX6/uZyfpo=
Message-ID: <6fe998dd-cb41-49ee-8018-26071d347db5@arm.com>
Date: Fri, 27 Nov 2026 13:02:20 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "irqchip: nvic: Fix offset for Interrupt Priority
 Offsets"
To: Yoshifumi SHU <envzhu@gmail.com>, Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Brad Hawthorne <brad@sim.vu>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20261127122801.4189591-1-envzhu@gmail.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261127122801.4189591-1-envzhu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/26 12:28, Yoshifumi SHU wrote:
> This reverts commit c5e0cbe2858d278a27d5b3fe31890aea5be064c4.
> 
> nvic_base is mapped to 0xe000e100 (NVIC_ISER0). Thus, the Interrupt
> Priority Registers (NVIC_IPRx, at 0xe000e400) are offset by 0x300 from
> nvic_base, not 0x400. The reverted commit overlooked that nvic_base is
> already offset by 0x100 from 0xe000e000 and incorrectly changed
> NVIC_IPR.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/b0be3be5-3a7d-469e-9166-a3414a52cbea@arm.com/
> Fixes: c5e0cbe2858d ("irqchip: nvic: Fix offset for Interrupt Priority Offsets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yoshifumi SHU <envzhu@gmail.com>
> ---
> Vladimir asked for this revert (see Link:).
> 
> Tested on MPS3-AN547 (Cortex-M55) and EK-RA8P1 (Cortex-M85) hardware
> against v7.4-rc4. On EK-RA8P1, confirmed that the driver now writes to
> the correct addresses for NVIC_IPR registers.
> ---
>  drivers/irqchip/irq-nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 2191a2b79578..9438891e66f2 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -26,7 +26,7 @@
>  
>  #define NVIC_ISER		0x000
>  #define NVIC_ICER		0x080
> -#define NVIC_IPR		0x400
> +#define NVIC_IPR		0x300
>  
>  #define NVIC_MAX_BANKS		16
>  /*
> 
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
> -- 2.53.0
> 

FWIW,

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

Sorry for such silly mistake!

Cheers
Vladimir
