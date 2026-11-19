Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102138;
	b=H4riB8mOiZoQ7ThwW2b67qzE3xbtiry2LcAFsLCUWpAvo90VFH30Ebeh5rdpJn0B02B3
	 xsPlrZWaUsA3Vjd5kjpAHXY+l7uP1CUgsaBvVlckNNXfj1tbxJxT5uiPRjAyCtaaPgtWV
	 +Bx5AmpRlaEmBKQlaluM+n5K86OdwHI+B0ochwLcmqPPHyypzWxIkXSmYj7NpggpMJ9w7
	 Vx95AhQcXrvEkYPT69uWEC4mT7qk2HD62upwah1RFt2rVEasIB4cMY5Y5OVddvXmx4hWC
	 iVtAwirTAvA5Y8/w8lnJ+55vEbry0DPi6aS6nomvCE3R8AzII1WsOiZIygh49/SM9ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7WhtRZ2k/7EVm4x6FvChP8GlYWSfjSHXh2T11MAOs8c=;
	b=v8cgU/3LB6hSEUiYrs2zJ/F9I5mtk9YTgXxZPPG9EjZP3kYGArn0RwcdPhCcm6+Qq1g9
	 Y8Xhrf1Rt2lsXhgW0P1aw0FE0xkIDEIBIEI931b2QaB+ScdvYY4xmP4QnBB1go6OBjOnn
	 pyR1aJRaWQhubkuRFWYeLgjDHdMKubzXWAVb1LLRM8JhZ/p72cCvE/wYnyOwXpX/G9hfC
	 sBrUdq5GlGqCbCeTGyKdPLm8+eaLZIPGYVECcqY1QjNmH/4VJl9xmlR523HeWlJ8uBzpB
	 qiukK41w8/Obd3My4Ga4nd8UacqXtep5JzmeXWWn2O5x6lyGGM5dbXLPWfUryPe+XrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gn45WquT;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4260A260D;
	Thu, 19 Nov 2026 15:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B4260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gn45WquT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795102138; x=1826638138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hf+2gJBPqhjtTEobz463VsJzmbD+2TL1IcZlEbk4ZNw=;
  b=gn45WquTAHJ6eHNkHWFWCKg/SwfactxMyqEWa8C1mvT6FPTpo51fKGhO
   5kFpIIkdn0u3zNFP3AA1+2gPk1f6cM6h2kSj22IJlMW6t7wEWVR4DtQYu
   itMhvvTtzmElhRNDDL918zGTZqxc8ihMoMe2oMixYAs8Te4Yq2dwdCmHO
   +fmysHkR5l2O8SALBLws8+iteHz0fx8BZjQgoVSUEKnTOPVYSOP5Ec9Hb
   bnnUQeIOntmyT6hcoFlDMtr8K/4XF9fYYFAyoens1QZ0EwcHZsfdvvNBX
   pBSFMsTrX842tDcdg68RKiqe5/alJ1lfKhncbErooEgBYZkIfP5kt0Ygl
   g==;
X-CSE-ConnectionGUID: X2aG+Q8qTYC650gujhIuWQ==
X-CSE-MsgGUID: g7e8BNl8SROUe9ijbEYS8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4033863"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4033863"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 07:28:54 -0800
X-CSE-ConnectionGUID: 8dXNTts8TL2AMDKYgCzYBQ==
X-CSE-MsgGUID: N155q6NUQFCHjtcd4AtUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="11028600"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.68]) ([10.125.109.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 07:28:53 -0800
Message-ID: <4cabfb0e-c21d-4f73-9b41-9fb7eca5ea69@intel.com>
Date: Thu, 19 Nov 2026 07:28:49 -0800
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
To: Tina Zhang <zhang_wei@open-hieco.net>, x86@kernel.org
Cc: puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 yangzhen@hygon.cn, dengqiming@hygon.cn, stable@vger.kernel.org
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261028235712.383977-1-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +#define X86_MATCH_HYGON_MODEL_STEP_UCODE(model, step, ucode) \
> +	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_HYGON, 0x18, model), \
> +			    step, step, ucode)
> +
> +static const struct x86_cpu_id erratum_1386_microcode[] = {
> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x00, 0x9040000f),
> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x01, 0x9041000f),
> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x00, 0x9060000f),
> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x01, 0x9061000f),
> +	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x10, 0x00, 0x91000004),
> +	{}
> +};

This part is good.

> +static void fix_erratum_1386(struct cpuinfo_x86 *c)
> +{
> +	/*
> +	 * Affected processors enumerate no supervisor XSAVE state components,
> +	 * so XSAVEC is equivalent and is not affected by Erratum 1386.
> +	 * Disable XSAVES unless the microcode is known to contain the fix.
> +	 */

This comment is in the wrong place and is really hard to read. I think
you're somehow trying to say here that the kernel *COULD* just use
XSAVEC instead of XSAVES instead of disabling XSAVES.

But this isn't the place to litigate your solution. That's for the
changelog. This just needs to say what it does.

> +	if (c->x86 != 0x18)
> +		return;
> +
> +	/* Models affected by Erratum 1386. */
> +	switch (c->x86_model) {
> +	case 0x00 ... 0x06:
> +	case 0x10:
> +		break;
> +	default:
> +		return;
> +	}

This part is not.

Why do you need an explicit 0x18 check if there's already an implicit
one in x86_match_min_microcode_rev()? If there are unfixed
model/steppings, then list those too.

I also don't get what the switch statement does.

> +	if (x86_match_min_microcode_rev(erratum_1386_microcode))
> +		return;
> +
> +	clear_cpu_cap(c, X86_FEATURE_XSAVES);
> +}

My overall suggestion is to do more in erratum_1386_microcode[] and less
in code.
