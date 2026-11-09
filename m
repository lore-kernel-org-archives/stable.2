Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247476;
	b=XwaSy/VPti6F65uFmaE+WrlYWaAX/vjU3uyahZ3TkFD8lMk4ABrTA/dWge4YWs4a9R3d
	 fFQbk0HB3eZBPEgGtt4shn2DMVVF4f5xwpwzaAgxBGTpva+BdyHwDKc6LOCKtpYOeXvXz
	 +vdnNZNSrrsCTkzvH6uJm0KeCEoaehQWPklXFL/t24XPTKEHGTSjmDvvlFAQ6NP+Vx3Cl
	 qGoVfKeZU/F8kOOr+XY8Cql1A+FSR5/HPjghLLnlGN/AvHRqKVQzSczdlH6E0BZyxxs13
	 qZFWzOzKozYB/VABRDfam+GmR0xnOxHZRXVyoyJ1ULCn/nKn33ui8ijf6kYDxJZKbuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qiJ7xcOjNXyII+yiz+zZqioSWqQJ99faJ7nKZxybbn4=;
	b=r+FPk2vfWj2JE+wbBBTutNXJO989kp6eR29QQ5RNyWtsNvKZypgColGPgLI0somZsbY5
	 u7F6Ozf/AwiSajX97lSxOfLF/PspAThXKeHErEGkq3sPlX2a1dHQIppCuIR8WDxDimbXU
	 lCOJID+OfpvPFSJz6H6/a3OvDb8nulQs/03WV07ivtGx6NarnsUntbnr0XFdDsfcEZWlx
	 hM2xPzR8C7woa40pC+CG+Ttwz9zwPMid+pmnbNfYMyNVgEukCdY3OG4tzrqTBBR1eAGhH
	 43iJ4wqK2NIwcGa0wtBgle2KVjh9AX0oScNCAJkF8tpRIHs3D5gWEqdzhbpQ3SzKyVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JfS6SNA+;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BF606A31C;
	Mon,  9 Nov 2026 18:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JfS6SNA+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794247476; x=1825783476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PwpaDGj8GyOkiCWitGngWvUI379OhhscqTT8voYCpFk=;
  b=JfS6SNA+qxXuwLaAAHsrkfwwaIxSMC2FHqxirqlVSo+nEijMqBx8qfHx
   V1HKA9JhNVti9VHRvGymsSeDjN7m9OSU+187AJpmGzayjAJlUwppirasN
   nYOvrRNlWb9X16tGkGNv1p9qTd4Vz7vNL/AKZNUaLrjT6atV1x4JNCu+e
   9gEYKgdVQ5hAfHD5+u0PZmgQ4fs6Ghq1tpZbd6PX2Yt8376GoQ5yXAQ7r
   lvjgWCuGHB7lU2mWp1WQCoieYRVfxdprj7yX/WKQic/bS/5gkguj2203u
   a13w4ZFXd2HmNpDtfoa5lPNc4dKp/ffvuZYHC+U82NbXttLbg9FiPbiil
   g==;
X-CSE-ConnectionGUID: T1hYD3iGSkSv7h+Bb6yPDQ==
X-CSE-MsgGUID: aGj4kNATR+eqhaKmezj5ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2877641"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2877641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:04:36 -0800
X-CSE-ConnectionGUID: hZ6m/+OiTE2G7CON2L9ZNg==
X-CSE-MsgGUID: XoLv/KaHTYqwEe1jgRTFtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7790832"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:04:34 -0800
Date: Mon, 9 Nov 2026 20:04:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: synchronize updates of descriptor labels
Message-ID: <avILL4gd737gmDR2@ashevche-desk.local>
References: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
 <auyYVmSaLBS--52n@ashevche-desk.local>
 <zgvjoccnnhhjmlejoazmz7mpfmndbhi2filwbtudq5i6s46boy@szoywmokacny>
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
In-Reply-To: <zgvjoccnnhhjmlejoazmz7mpfmndbhi2filwbtudq5i6s46boy@szoywmokacny>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 10:22:07AM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 05, 2026 at 04:53:10PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 02:23:45PM +0100, Bartosz Golaszewski wrote:
> > > desc_set_label() swaps desc->label with rcu_replace_pointer() but
> > > without any synchronization of concurrent updates. The swap is a plain
> > > read + write: two threads can observe the same old label and then call
> > 
> > s/call//
> 
> Why? It's "call $function_name" which happens to be call_srcu().

Because with that kind of name it sounds not good (tautological).

> > > call_scru() on the same SRCU head corrupting the state of the chain.

-- 
With Best Regards,
Andy Shevchenko


