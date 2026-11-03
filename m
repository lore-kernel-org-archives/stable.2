Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705708;
	b=amtVUW85rSvzmSzIj+puJcmfXLWRvuNhlFLBjWXOrfJwvNIRucGJQ2Xta1pMbXzdZBe+
	 nd88exaji5RSRkh+dPpb5kp52W06vOhzrvfkxr3yYtwFrR26ZEnz4dtKvLquqXUVXxV81
	 gNNofanXPJ0K6MO6ooZTibGHy3g8opxtnoNUwVOEyP6AshMDugj9MTgzLta5IADLvoABd
	 3Olq6yc8Ct/rp2TneZW5SojZMHlvwqOw4RL2s+sLMTIeAgAfKS7KQX1V+TIavs2HjxuNS
	 zB+Hmp2IPLeGhfgJT38gb/dp/W1AWxyt/C3w6iG8FS9El5KbLolO4MCj4ilZTZ4q2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705708;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c4JVriSqnhUXcVvzsLVWWTJSNNQ43arV+TIdoGKN4wc=;
	b=0HgoXP5sWxsvya+3rc1O/tKM4wHzm3wyyetvbJo1FnkXCHDn0Yt4ucHJUzEnMx6icinI
	 feVYEu1kWlYKBV+ojIVrMkP7/H9+xwCkN32vLVNKoo+szMjHCDUFLCxT+EJ6jIZZdZaYN
	 G7IHP6A2pcfpMrHu9v9xf9tgYrrpOycn01NHvaV2J37nALtCz1VTLB6c6Q5SsuTh8V9OP
	 Go/47+9CRIn7JrAZHd3wPMXQGqkFKDCOY9g8umtmVTbxApVR1A6OlCBD3QrfthmPwu/ND
	 ia2tKvV4HBRIc1kUPt99fApXZKO3wLg9cKYlwWsI6o8gYg4SY9fVqY6z6oTjFrgCXSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TCjQ2/+u";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0167606A335;
	Tue,  3 Nov 2026 11:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0167606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCjQ2/+u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793705707; x=1825241707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOgvAIWfP2qhCgfnXFmqJFEJPtgyNY65FfFSjXCkrF0=;
  b=TCjQ2/+u049wJbDb8DTu1nLMdwCkTynso2p4aDOStjizdvTHxp7NZRAq
   5H1RxOVDeJbvwnvQM+QNliEwGvtoSkY6WtqvMr4D6XOCzO0e48zxDFBqI
   7TH8iGnVCifRMbxJUIU09C7zP9zK5TC8DzjWzH7OSasXlskdwAO2806z6
   LdA3/oN/Iy/3x5273rAhjQkACR4cZrF8/Ba4mJg5dGyHG87cdn4A393aC
   LRBWp/KgwWLQ/1d0FGIKQeu/26YBv3RNJiiknRweYfx1E48NBhxzfSKr5
   E/3ASdfkv/Ukj3By7jodGpbE+/8sSj/H9DauGN4MAVNsNonqo3vi9PilS
   w==;
X-CSE-ConnectionGUID: DW2bZ6pUSGGGfDgCMNJe5A==
X-CSE-MsgGUID: k6kEylNHRe60U3xm20TH5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2419704"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2419704"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:35:06 -0800
X-CSE-ConnectionGUID: 1kyjFEKOSMKKVAo4bH7i9w==
X-CSE-MsgGUID: G++Ps7n8TbyaAh1xolbZhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6231256"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:35:05 -0800
Date: Tue, 3 Nov 2026 13:35:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 7/7] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <aunG5r3aKrJG-vJA@ashevche-desk.local>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
 <20261103-gpiolib-chip-removal-v5-7-aambrozewicz@nvidia.com>
 <aum82qe3S5W0FvK2@ashevche-desk.local>
 <20261103122634.6badd16e@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103122634.6badd16e@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 12:26:34PM +0100, Herve Codina wrote:
> On Tue, 3 Nov 2026 12:52:10 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Nov 03, 2026 at 12:32:40PM +0200, Adrian Ambrozewicz wrote:

...

> > > Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/
> > 
> > No. Either make it Closes tag (if appropriate) or add a reference like
> > 
> > Link: $URL [1]
> > 
> > and mention [1] in the text, otherwise it makes Linus T. grumpy. I think
> > I already told that.
> > 
> 
> IHMO, "Link:" instead of "Closes:" according to this reply in the series
> pointed out [2].
> 
> [2]: https://lore.kernel.org/all/20240923150522.66b418d1@bootlin.com/
> 
> The history was:
>  - [1] (the link in this patch) proposed a fix
>  - It has been rejected and a improved one has been done [2]
>  - [2] has been accepted and led to the commit ec8b6f55b981 ("gpio: free irqs
>    that are still requested when the chip is being removed"). This commit
>    is already mentioned as 'Fixes:" in this patch.
> 
> So, IMHO, in this patch:
>   ...
>   takes (config_mutex, or a new mutex for v1 line events). Herve Codina
>   first proposed calling the notifier earlier [1].
>   ...
>   Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/ [1]
>   Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")

Thanks, WFM!

-- 
With Best Regards,
Andy Shevchenko


