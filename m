Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186672;
	b=pUnaE202vor0ztfMdagq2VVjaIS+IAdYc0ixO5KMyPncappBYfUteZOE2+1V6Fm/hQl+
	 xbbJzg2vKVBf1mS87V5dEy33cj0T8PX5fUD9P0dbRQeOinOCJGObYMjmG7aLxr46UsMDd
	 Ra8qdKPnFO897cPxPoxPr3hXanl4BCUMoH+VsEBKWQbCmKeE3j3Tqr0exk6WbLNMZhjEY
	 zUU2P3A4iXvp05RSWRcviJJ92b8r8zAQzO5lc2/tq8bTvAJyDFEnOXCyQxy1+ghB1osm9
	 aJQeXQeTBYgmDw4CbXQaRc8Fwxw5MOvniAwncSlgrq4VBPUZJx2zgTSCnh1PoyGx1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186672;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UzYqfwK03XswOM+aAiEKuPhg2qiLfmbDsVStkI8SOkA=;
	b=LWzrp9nWTP79VLcmmJefj6c/V4ZFdFBbimNEzhpXsN6dvbo5s5+e+yt+hxegFJ5QG8WF
	 N0lcRHwoXew6lbot5AwBinpA3GthuzDu/w9ZzKEUMIYUVVzKGTC6frNi6Ba9qNgy+BIa3
	 xwmsnkLl+FnJ0JIAXqY9JAmxchsWGomkoPt6rcO/OlusWK8E9YFNfVtc6v/5ZCqYZTxtC
	 n7MD1gGLqjE3G6Dg/JZDreNEvticOeni9r6RavVc7hPXK4hodwMo18nxOYAck1RyNfIps
	 l3hffjqSjP7aLBiQKHSVzdHRTJJ1BBvhQSChTbz+SKiLD3RGGefzMwBpOHFB21/X8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WUc5n26O;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687E606A325;
	Fri, 20 Nov 2026 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7687E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WUc5n26O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795186673; x=1826722673;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Toql5mJ4cCFYPW7Pu+YFyJaUBUmYDrRv0by+tOZIa6Q=;
  b=WUc5n26O6t8GUmociUeTFzJeDz1kU2cEDAH9L3LTniF1SZQI5esRBrQo
   QtSXdQ+pYk8TV0rEJbe5RLp4TnerhT1K7A1MvB63ML2xWHIEdwuvZ5iik
   1CguWdSm0es8N4LufXrtUhvrVM1Jeg7bY+a7PuJivuBlNiiRC7lMukCYz
   wBX5e1AIZ8dqcgFrWmDoEl6+KRx65uXzTxAXsi9o1Byg/BTHt/Ip1YUAI
   B6iaJlPQ07O5f0d2+4CWSHb/27yyslMXlCDoUAYwnaXqQ66wOOHcksWSt
   +ra4y2hGfdRRoU1rJ4EtATmxAYb/OOGschO4rC5rRnX7yCeTc/+jvsHo6
   A==;
X-CSE-ConnectionGUID: TQ57xOOVRq2foUwKEmD+MA==
X-CSE-MsgGUID: Bo017nQyQcCHFrQ3Srokyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3976592"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3976592"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:57:52 -0800
X-CSE-ConnectionGUID: hNZ3gathTZ+p5+Gmf2E3VQ==
X-CSE-MsgGUID: kaBnqMCZQWaMXCaij3/u5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="12553753"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:57:52 -0800
Message-ID: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
Date: Fri, 20 Nov 2026 06:57:48 -0800
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
To: David Laight <david.laight.linux@gmail.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, yangzhen@hygon.cn, dengqiming@hygon.cn,
 stable@vger.kernel.org
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
 <20261120094627.513b216e@pumpkin>
 <22eb33f3-a6f7-43b6-837b-74c8f5a3428b@open-hieco.net>
 <20261120144430.0b1b43a3@pumpkin>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261120144430.0b1b43a3@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 06:44, David Laight wrote:
>> Did you mean that the kernel could prefer XSAVEC when no supervisor 
>> XSAVE state needs to be saved, rather than clearing X86_FEATURE_XSAVES 
>> on the affected processors?
> Or when there can never be any supervisor XSAVE state to be saved.
> I rather lost track of these instructions after XSAVEOPT.

Could you explain how that would help, exactly?

First, there needs to be a reference to the erratum in the changelog.
For me, searching for this string git the PDF to pop out of Google:
"Revision Guide for AMD Family 19h Models 00h-0Fh (Publication #56683)".

Second, I don't see anything in the erratum that says it is triggered by
supervisor state. Do you know something about this erratum that's not in
the public document?

I'm not even sure AMD _has_ supervisor state components on Zen 2 that
Linux uses.

Third, even if we could move to XSAVEC, I'm not sure it buys us much. I
certainly don't want to add the complexity to our already horrid XSAVE
mess. The right fix is in the microcode. Let's not give our dear
hardware vendors to mitigate even fewer issues than they do already.
