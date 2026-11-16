Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832021;
	b=g/rpX0zd9sudGizVPnZ1Xnrr78fbiUAq+24sCeH+I0N4vkGX3k6Ui1DOs5J0JcF8hHix
	 JtHE64cFJOmJwdqtLAttz5ZniNx9uI1J4AL6Qpca0qYduzCEdmnmq6dwnkbrwkrRNhM8r
	 cJpEQ7Z1yNTH7R6MUxCZ+TlKPSSG4WpUMmK1mWN+rNaLxo3bxW14s+YIx5kbol3IVkPx0
	 UR7fiNwel11H08MdKmD6LWzS5+iSy/1ZbDt5aoGUgo77bZQs/OnDn8nLfnfN+8eiOkX9n
	 nnne7xx0c9b7AVuR+soY8b79yGZt9qaRBd7f5zml4CZps1SAs7WC2xBAMuQC+peZfnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832021;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LztVH/Br0K4gtRrkNgsVN8G2Ix17Zkmh6T5nMPGmD4I=;
	b=rB+FAyl4/Jz15S+XncWWpAaScCwihnY20NQj1oQNy4Ynxwdc/GTV3ukmLdzeIPXkOV57
	 CazfzZuJ6fa7FTDpsr/jTbKT7sN5sKFifJ41wEtl4O2X/NSfoOASMNL3kDtAy6+1kAdDC
	 Qyb/7PBkrPSP0nmvg1ZCOcyHZynB8+gZnSwPh3FCFil47Emcy7SJdG2k+zFuexdFmTnGa
	 EgQSrPwhHTxhrNQT9dfkZ9qcCNTIGUX6ZQST7ZEM/FkSdcem4RhiTcHm6pJ5fSXd5eoFZ
	 8BcWUqilpyKhX7AEhNZgpY3LnSchkRjmQJwbftHCHSAtws+cextPrCt82CPcGusPFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X2TwkGhS;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997B606A31C;
	Mon, 16 Nov 2026 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2997B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X2TwkGhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794832020; x=1826368020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cFOAVePZVgxrC8JkOnzlLlxAgWuxq2P3Pj4zDMgFhLs=;
  b=X2TwkGhS/Q6d99fUCmP8WdNH+YSFnJuZ6JTGWQz+dqz6fw5WXhDIT9S5
   KhQ1UJhQbJ8pvtVkwYwqSGu//YOphSKI7kXHuFbfIPgMXgdaAUYyUwvvL
   gjPWSKT/oMbbTxNLBqX7j+OZHd6DvAVhalptld9k72d1q9uOEhJt6u+tn
   eRauWhRbVd++HOIlLRAXivLAnmnH0jspJyXN/LO6Ui43nquKeVhlkGZ85
   8FC+1c1iOQ1crF12pFvdw2G6ApaCDtaxF4lRwd68mHXIZisvLPNq1s2Dl
   KF3mEcaX8CoaFdBhDt8CXMX8w07flMYzTxCne6eEdgYEYK/ssxki+l4YN
   Q==;
X-CSE-ConnectionGUID: NaABzIO2T+KZrfeQoi4fCg==
X-CSE-MsgGUID: 3weAZLfjSQeBxj+XISluOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3444669"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3444669"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:26:59 -0800
X-CSE-ConnectionGUID: PpbZemL8SG2DHsPDCH0gZQ==
X-CSE-MsgGUID: j+5TbJsdQlSLfmB3YkmOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9535089"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:26:57 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3BB55121B5D;
	Mon, 16 Nov 2026 14:27:00 +0200 (EET)
Date: Mon, 16 Nov 2026 14:27:00 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	"Paul J. Murphy" <paul.j.murphy@intel.com>,
	Martina Krasteva <martinax.krasteva@intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bryan O'Donoghue <bod@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Gyula Kelemen <gyula.kelemen@advasolutions.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/8] media: i2c: ov9282: fix strobe timing and control
 handling
Message-ID: <avr2lDQxiFnv2Gq8@kekkonen.localdomain>
References: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
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
In-Reply-To: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>

Hi Richard,

On Tue, Nov 10, 2026 at 02:10:09PM +0100, Richard Leitner wrote:
> This series fixes a set of related issues in the OV9282 strobe timing
> and control handling code.
> 
> The driver updated exposure- and flash duration-related control ranges
> in several places, but some of those updates used an incorrect timebase
> or were triggered too late, which could leave the controls clamped
> against stale values.
> 
> The series:
> - checks the return value of the exposure range update
> - drops the redundant vblank field
> - converts probe error messages to dev_err_probe()
> - fixes the 8-bit pixel rate (192 MHz instead of 200 MHz) and the
>   corresponding line time calculation
> - treats the strobe frame span as a line count and converts the flash
>   duration accordingly
> - fixes the flash duration range (min/max/default) and refreshes it on
>   HBLANK changes, independent of the sensor power state
> - refreshes the exposure and flash duration ranges on mode changes
> - reprograms the strobe span when HBLANK changes
> 
> This series was tested with an ov9282 sensor on a vision components camera
> module attached to an i.MX8MP mainboard in a defined (dark) environment
> with a custom made LED flash pcb.
> 
> Any feedback is warmly welcome.

Can you fix the issues 0-day bot found? I think the patches seem fine
otherwise.

-- 
Regards,

Sakari Ailus
