Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139487;
	b=EglDTeKGlWS5xk0AdY4leUIekfcLzD4yOLizyQ+yjPIZp1NAm7dQE/c9x7jgLBbrhWj5
	 pPabLQWyNUexILxrGDrZTW+puuXZWRbAKpKeAi3IHXhqANdYA7/T5oKpxOgZ4z6VAXRrE
	 u3JYfjiwiTc9wARqvAi5ty0nX8uT2BOUlrj3KuuqxIeB2NtiF6SFfxK0PDZkEn2dZsbH/
	 DXVkeh6k6JeWwcXajuOO3vbRR6KUaCyQOwnTJz05y0CwFq6++zkUe2dkUBi6GcRg5d5VB
	 g9C8Ar0euk4GT3r8MsvL0BvAfgPjXW1+xPGM/74EXpB2nCSA2ycMe5iBDBZJbPMo/yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139487;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Sa/kRm/Czd3oa0ITjRFbGWzsUdwALeInsHgWFTaIKQ8=;
	b=3Z8NC0iJXIJuhK20VKrEjweUHo217PPE9PMebbexS33ew4DZ/HENc1oqsQjyhilk/ikY
	 pATuANENUKzx2E3ypl5QHxXOw4CkRc4mxHeb5TBjGef2KYhvVdigDqgWCX8H8SvZ6CTjD
	 KZjH3CtvSgkkVw2Y6QJq+VRh314apOx7R82E+nto6sV3lLZ6rWPl51AZjAn731Olt67YS
	 zvlgOeV9yPmW/VfcvAtrtOcgPb+NwbqBDZIMh+jyr1Zg3CB2KuVLVEM6X3B6wS8WBnUeP
	 SXRJTUoX7HiSx1RiMewvsi2UPLM2g/3HXs4b/XlEZMVL4tnPiVTe8zokeucwVT0YAKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.147
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B147606A320;
	Fri, 20 Nov 2026 01:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B147606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08114662|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00621641-0.000610858-0.993173;FP=7179771474107532699|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k67.P.w_1795139472;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k67.P.w_1795139472 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 09:51:14 +0800
Message-ID: <a5c3df5f-f133-4726-b2c1-c130f2503f18@open-hieco.net>
Date: Fri, 20 Nov 2026 09:51:10 +0800
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
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 yangzhen@hygon.cn, dengqiming@hygon.cn, stable@vger.kernel.org,
 zhang_wei@open-hieco.net
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
 <4cabfb0e-c21d-4f73-9b41-9fb7eca5ea69@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <4cabfb0e-c21d-4f73-9b41-9fb7eca5ea69@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave,

On 11/19/2026 11:28 PM, Dave Hansen wrote:
>> +#define X86_MATCH_HYGON_MODEL_STEP_UCODE(model, step, ucode) \
>> +	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_HYGON, 0x18, model), \
>> +			    step, step, ucode)
>> +
>> +static const struct x86_cpu_id erratum_1386_microcode[] = {
>> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x00, 0x9040000f),
>> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x01, 0x9041000f),
>> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x00, 0x9060000f),
>> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x01, 0x9061000f),
>> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x10, 0x00, 0x91000004),
>> +	{}
>> +};
> 
> This part is good.
> 
>> +static void fix_erratum_1386(struct cpuinfo_x86 *c)
>> +{
>> +	/*
>> +	 * Affected processors enumerate no supervisor XSAVE state components,
>> +	 * so XSAVEC is equivalent and is not affected by Erratum 1386.
>> +	 * Disable XSAVES unless the microcode is known to contain the fix.
>> +	 */
> 
> This comment is in the wrong place and is really hard to read. I think
> you're somehow trying to say here that the kernel *COULD* just use
> XSAVEC instead of XSAVES instead of disabling XSAVES.
> 
> But this isn't the place to litigate your solution. That's for the
> changelog. This just needs to say what it does.
Agreed. I was trying to explain both why the workaround is needed and
why falling back to XSAVEC is safe, but that rationale belongs in the 
changelog. I'll reduce the comment to:

   /*
    * Work around Erratum 1386.  The XSAVES instruction may fail to save
    * XMM register state on affected processors.
    *
    * Clear the feature flag on affected processors without fixed
    * microcode.
    */

> 
>> +	if (c->x86 != 0x18)
>> +		return;
>> +
>> +	/* Models affected by Erratum 1386. */
>> +	switch (c->x86_model) {
>> +	case 0x00 ... 0x06:
>> +	case 0x10:
>> +		break;
>> +	default:
>> +		return;
>> +	}
> 
> This part is not.
> 
> Why do you need an explicit 0x18 check if there's already an implicit
> one in x86_match_min_microcode_rev()? If there are unfixed
> model/steppings, then list those too.
Right.

> 
> I also don't get what the switch statement does.
> 
>> +	if (x86_match_min_microcode_rev(erratum_1386_microcode))
>> +		return;
>> +
>> +	clear_cpu_cap(c, X86_FEATURE_XSAVES);
>> +}
> 
> My overall suggestion is to do more in erratum_1386_microcode[] and less
> in code.
Agreed. I'll move the affected CPU selection into the table, including 
fallback entries for affected models.


Thanks,
Tina
