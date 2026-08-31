Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF533C3F56;
	Mon, 31 Aug 2026 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160563; cv=none; b=MORur13l4gxYFHdnE747SOXz2yHY9AaGgbo6Gl+A8cwH590Qla9CfMQqWJJ+hE9zc3Yg6erPjxTt2zvP9uUX1vc3ryszKK/hxsCL5uvWL0afwgGORAeXY1hsuatsJ+rks7Ad/84eR+vkMrb1qblLYy55c4V7C+hEnOHsQhrbxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160563; c=relaxed/simple;
	bh=/hoUMFCaauEhjFwUBFMBWHHPovsKQSacc+fhwjP7M2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYxRssizd4hIaOoxpJMoEMf009Ma+EmSAuIdnH7Hem14oOf1q4VWOgqDe3LyrUs3Ie8HX5ZdmcmwA0wT2+OLGNBUysJESKIt4Ze7v/bTURVovZXhUnFzeNvfjd+RFrTG/lCAsZWTLpusP2k5QMUvYTKh2gJEWNXBH+9A23/F8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpJCoqpJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpJCoqpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160560; x=1819696560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/hoUMFCaauEhjFwUBFMBWHHPovsKQSacc+fhwjP7M2U=;
  b=MpJCoqpJcpYO8s2w/qDDvNresV12syu0wq2lvqutav7yjtSiKitC/ZDL
   f3gVEH0BV9tvzKvQlsjtgNSLB0qNYH/8MjJeZNBX2m2sMFM+FdEL6osHC
   7/i7HuL5qjZ7071SYdKIHcoTtr7wiqLWvsrtdaEWmjrd/o1WwBPjk6DKC
   QLE2vn0YzmaNaPIYsEJ71KKU3CAQawJMO+W1zJTi9t9TOIILtaGQzlpFQ
   ZAYL79jJgTj+HSWsIq0yM4n9Fm21XfshuTh2jAMeZgpgVl5ps43dFIa1J
   XCR4zs6mU1V38ghCcM+nuD9acBglksqwYhdPVP9QFGVqPgp/LbVop8Ed6
   g==;
X-CSE-ConnectionGUID: UP7RsrTgR+6+TqPbVZ/Vog==
X-CSE-MsgGUID: DTMriQGkTG68CQlsdMSKDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88683393"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88683393"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:15:58 -0700
X-CSE-ConnectionGUID: o5TIfp7KSZ6jh/FNa2mDmg==
X-CSE-MsgGUID: ZO4a12Q7QBaX6yOaRId11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="264433046"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:15:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 41C4A11F7F5;
	Mon, 31 Aug 2026 10:15:54 +0300 (EEST)
Date: Mon, 31 Aug 2026 10:15:54 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: Martin Kepplinger-Novakovic <martink@posteo.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, kernel@puri.sm,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: hi846: Improve the power on sequence
Message-ID: <apUqKhktiQR4gRMN@kekkonen.localdomain>
References: <20260831-hi846-poweronseq-v1-1-1091cf78cac3@puri.sm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-hi846-poweronseq-v1-1-1091cf78cac3@puri.sm>

Hi Sebastian,

Thanks for the patch.

On Mon, Aug 31, 2026 at 12:13:32AM +0200, Sebastian Krzyszkowiak wrote:
> Section 4.2 of YACG4D0C9SHC(Hi-846) datasheet specifies the time
> between XSHUTDOWN rising and RESETB rising (t3-1) and RESETB rising
> to the first I2C transaction (t3-2) to be both at least 2400 MCLK
> cycles. This driver currently requires the MCLK rate to be set to
> 25 MHz, so t3-1 and t3-2 need to be at least 96 µs.

Could you calculate the required delay instead of usign static value? The
minimum external clock frequency for the sensor appears to be 10 MHz.

-- 
Regards,

Sakari Ailus
