Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DE38D6A2;
	Wed, 10 Jun 2026 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079528; cv=none; b=erg/dohq/F4kJADg4Q+N06YgwO79Za9o79dyR3zZFy0xX4EhZ1UGUSfxj/VTANltbyvMKc4KyIilWZ2oaK1LChV7KQev2UC88VoWmhEgjIEjqlBlEEOUYpiEylr5mAtl65Gkgvgkzwxbmv9hDohHUQs0KTaB/4rSy8I25Ud2teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079528; c=relaxed/simple;
	bh=dFWV170uGcGTNRXt5fX8cWxKq6oMa2XSGSL/KVli6B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR/bukXczLstFwE94nBuWgdsUBMZI7uvmg6eMD8itpC4LsTWBR/9Z5CoMdHPb7h3hcu47wIxawv4AvKJXCUi4KhWkDPXh6SJ0e8J+fDFTZ1bKq2Y/sfHWJBOBBaoc2bwqu1cEosPsntQ/V2zM/GBcvFq0oEiWKoIjsABtgzRLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NKJLD4un; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NKJLD4un"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 925EF9D1;
	Wed, 10 Jun 2026 10:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1781079496;
	bh=dFWV170uGcGTNRXt5fX8cWxKq6oMa2XSGSL/KVli6B0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NKJLD4uncIgZ1+JbXL4rtTJDgyWQsF3iRP5htr28v3WaGDMXPK3L/dtO0E2y9DQQ8
	 AKliG+f6E30Z90tnV7yXFLiTXhmqGqKRRLzFrC723tUBdO37TcRsaxE1FfhO2pkU9D
	 UBfRkyG6AgaGG2uGaWOLRGrVShhPdOoe774xPnuo=
Message-ID: <d327a464-6a8d-4f36-884e-52f3e396762a@ideasonboard.com>
Date: Wed, 10 Jun 2026 09:18:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mali-c55: Fix AEXP IHIST disable bit shift
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 David Carlier <devnexen@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260609053231.24855-1-devnexen@gmail.com> <aie1vqkd96-8uCmA@zed>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <aie1vqkd96-8uCmA@zed>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/06/2026 07:42, Jacopo Mondi wrote:
> Hi David
> 
> On Tue, Jun 09, 2026 at 06:32:31AM +0100, David Carlier wrote:
>> The post-Iridix auto-exposure histogram disable bit in
>> MALI_C55_REG_METERING_CONFIG is bit 16, but MALI_C55_AEXP_IHIST_DISABLE
>> was defined with a shift of 12, copied from the AEXP_HIST definition
>> above it. As the value is masked with the BIT(16) disable mask when it
>> is programmed, the result is always zero and the disable bit is never
>> set. The IHIST can therefore never be disabled, neither at ISP init nor
>> via a parameters block flagged V4L2_ISP_PARAMS_FL_BLOCK_DISABLE, and the
>> hardware keeps producing histogram statistics that userspace believes
>> are switched off.
>>
>> Use a shift of 16 so the disable request takes effect.
>>
>> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: David Carlier <devnexen@gmail.com>
>> ---
>>   drivers/media/platform/arm/mali-c55/mali-c55-registers.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
>> index f098effde..4cd13b702 100644
>> --- a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
>> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
>> @@ -173,7 +173,7 @@ enum mali_c55_interrupts {
>>   #define MALI_C55_AEXP_HIST_SWITCH_MASK			GENMASK(14, 13)
>>   #define MALI_C55_AEXP_HIST_SWITCH(x)			((x) << 13)
>>   #define MALI_C55_AEXP_IHIST_DISABLE_MASK		BIT(16)
>> -#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 12)
>> +#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 16)
> 
> Thanks, this indeed was a bad copy and paste I presume
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Yup, looks like it to me

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> 
>>   #define MALI_C55_AEXP_SRC_MASK				BIT(24)
>>
>>   #define MALI_C55_REG_TPG_CH0				0x18ed8
>> --
>> 2.53.0
>>

