Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703136;
	b=pHbxE7S6ck6n1BlI5eOd208F/RTVyQwA0wMMgmKozNE8M1QWBPT8LlqRf2FUDMe4pLAX
	 AnQ04LUhX+DffLHzoto5CSIapm+h3NbdB9lusfUJlRCfYGAoUhHCI0mgrldPuqF37uUhY
	 w7nbTiihAMkLYza+PRNzQ7dCCiS2rLX2gimOB/vJiT4tQ1mRTTGIjMHioJQ5P7kC5tAZV
	 lkKN7Tp5ylUMRZDJBv7zEi6za/jpm/Y+ULz/IJ2+nIrVtkWO6hLC/Suy8K4fhGUe0sNZc
	 HaBBNEA95tPcehq5dZVCS0LjRY352yTZo6iDjaeN7yI5vuH8WgR3BURgIT/cRaQAFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703136;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=BHFPz8Be5QKCVskOcJKGu8lTcVbSuPEigBpZlzznf24=;
	b=M4qAijugsVTtPRlofM8qic5+BBVgKd78Eu/wxMhViTb+Q0HL4G9ctC6mcNMPGeUDFmAE
	 jWfhrEOFfVwLXIGpu8dvzEvH/pY8/UNxLNNIUgU/gm1y/jOKPIrnhX361KvdvyvVQjWBB
	 kd1Ldb3xLu7hJgVMfjzrGMbVXjE+J5hQOg0RGyMBIM0TYINMTOLmREeYFEa9m/6MXW6ox
	 yw1ozP3+5jd99LZeNGcQS+mVfJd73c4IU2A3//pfUkCAvK6Ecq7uL0v7F0i5d2yDF8+lH
	 tbMWl/nyHpWypzszolUySwCc+C9wHTEbM4mQS2Sn5icfPs9FFNOjEm/P0HmLGAZEN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PgqH3S6D;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A417606A80D;
	Tue,  3 Nov 2026 10:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A417606A80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PgqH3S6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793703136; x=1825239136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gw8V3xJNxmajFzVsnGtqeA8arkUJ2FVYOqF13cfnOzA=;
  b=PgqH3S6Da4U3/o1lFn9Dtub5lXssH/RQ+vUA2WBYm8yXTTI4i9jwytoz
   WgAp7iJZIxRxFe/g4VkoGb5s4CKwKuJM/jekAMq4KkoTIvFHY/8OarCLE
   IUvrle6zjxv9peOqUCffint1Czw/17Xa+UZwMEwuDIy2amsuOJsf05Eel
   f4zU5sTydfE/u9QGnaqt1JYQ6MpPDnZYnidXkN1VTrP8y0YLFoO9WwqkO
   a17k7lFDVynnbA3ci7NwxL62nkp7tAFQYJnFT03R4jQ74ffsCvNOnZu3h
   Vz76bvdYK84LGFjyuIEM3q4mOEWkIqKpaZPIlbcI5rUYUAI0LDShX6Lwu
   g==;
X-CSE-ConnectionGUID: jD5MmYBOSyCbPJKL1eDyLA==
X-CSE-MsgGUID: KM9OuhiDSQ2VvLb4NM9jsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2300773"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2300773"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:52:15 -0800
X-CSE-ConnectionGUID: Mo0drrHlTJKA4eNiPsPqng==
X-CSE-MsgGUID: NLN1DBZ4THOrWyioerzg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6236843"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:52:12 -0800
Date: Tue, 3 Nov 2026 12:52:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 7/7] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <aum82qe3S5W0FvK2@ashevche-desk.local>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
 <20261103-gpiolib-chip-removal-v5-7-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261103-gpiolib-chip-removal-v5-7-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 12:32:40PM +0200, Adrian Ambrozewicz wrote:
> gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
> and only then calls the device notifier on which the character device
> frees its own IRQs. The character device can then free an IRQ it no
> longer owns: after its mapping was disposed of and the number reused, or
> from a release that races gpiod_free_irqs() and
> gpiochip_irqchip_remove(). free_irq() then warns "Trying to free
> already-free IRQ" or uses a disposed descriptor.
> 
> Call the notifier once the chip pointer is cleared and the SRCU grace
> period has elapsed, when no ioctl can request IRQs any more, and free
> the remaining IRQs after it. Have the release paths free their IRQs
> before unregistering from the notifier, under the lock its callback
> takes (config_mutex, or a new mutex for v1 line events). Herve Codina
> first proposed calling the notifier earlier.
> 
> IRQs that in-kernel users leave requested are now freed after the chip
> pointer is cleared, when gpiod_*() calls on the chip fail.
> 
> Reproduced with a test-only chip on the hierarchical irqchip: both races
> warn in all 30 cycles; with this change, none does.

> Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/

No. Either make it Closes tag (if appropriate) or add a reference like

Link: $URL [1]

and mention [1] in the text, otherwise it makes Linus T. grumpy. I think
I already told that.

-- 
With Best Regards,
Andy Shevchenko


