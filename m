Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83238EEC0;
	Thu,  9 Jul 2026 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561853; cv=none; b=R00CghrTxSrRxmxAgQt35c2dbQG1FqdZJ1OA5FsjPAg4wo8MnBeF39jqkwrd1VOcWfEzcqDC5fnewgHAU6MD/4OztDzZXpRtikjFQ5zcJRsBd8TKyiqxtbo5y2KiS1rJOn0CEES7TFDVA2d15In/Pfwss51j1VDKNvKbMenIaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561853; c=relaxed/simple;
	bh=CmOX7MaZZ9ifvd2zrDohkShz5toPMjJokDKEFZ947Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw03T27VLyu5EC3P3e73+14gnnUV8xtp2FCMM0UVxNbGMcgU4JlOEakw00i+JtscuMsuplYVGzB5YQzETTamznG335b/VuBOswYEsSCgEFctlRDHlEeAlpwMQ42sCnENEillwzF0rE+BSdKqhE9vgCNsWwfmFdgT/A1NTSl75ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX63E/no; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX63E/no"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783561852; x=1815097852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CmOX7MaZZ9ifvd2zrDohkShz5toPMjJokDKEFZ947Fs=;
  b=OX63E/nodwC6P0hUx0yL2lX+2vzmItBqX6tX6ZNtAV6hJCgsFKdU2IMZ
   LEH+igFzylL2X/BA1x/IrTN09VlwaXGZLR/SpFGJP4QNdh/nQSI3TwKyl
   qwabw1U4t48OL8p81ffN1TBIAa/yb6cBLnbR7ZrrQSBB/413voY51Ip2U
   Y5iWz2vqhYNGNq78qjR3qA3OKYXkM6ODM4XfVIZ3ywQXJAnIDPp/CYn3x
   gB3gG5EvjTvyDdqMzZLRPMLrmeH6gA0PpRIO23uiOZjV4DmCZJR//NAWC
   KWdtnf/Z5locuNAljFnLicYAUcRy5ma5sO6peNxSCokS7DLUQqBJ42SMF
   A==;
X-CSE-ConnectionGUID: JWX9YO7ESiimUeMrshCcOA==
X-CSE-MsgGUID: iUn+DjdYRsOuaQJuH+DawA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95392457"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95392457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:50:51 -0700
X-CSE-ConnectionGUID: zefSPwRmTXGLmvAlvdu2Hg==
X-CSE-MsgGUID: bww8dSPPTdmw3BJ2JxO13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258310129"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:50:48 -0700
Message-ID: <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
Date: Thu, 9 Jul 2026 09:50:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "seanjc@google.com" <seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <ak4NdJSK60zKD8Uy@linux.dev>
 <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
 <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/2026 12:20 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-07-08 at 17:04 +0800, Binbin Wu wrote:
>>> Maybe it would be better to check for a mismatch and return -EINVAL?
>>>
>>>  	if (init_vm->cpuid.nent != nr_user_entries) {
>>>  		ret = -EINVAL;
>>>  		goto out;
>>>  	}
>>>
>>> That would make the mismatch explicit instead of silently accepting an
>>> inconsistent userspace snapshot.
>>
>> I chose to use the snapshot value to follow KVM_SET_CPUID2's style.
>> KVM_SET_CPUID2 kind of uses the snapshot value of entry count.
>>
>> But returning a error code is OK for me.
>> Let's wait and see what others prefer.
> 
> It does seem safer to reject input than have some implicit behavior.

Yea, had a second thought.
If there is a mismatch, the userspace is probably malicious.
It's safer to reject the request when the userspace is suspicious.

Will send v2 to reject the request for the case.
