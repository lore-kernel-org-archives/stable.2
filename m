Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098655;
	b=TpoWAK6asMOBaYwZmG/4kiPSOyg6hi9lO5z7BevLp2v/k9oUlWSJCKmyo027MfrXIDmm
	 rap9fTkzVpTgtjOwRp58Ldkr4gBvGGj1+Wxdn+C5wVP/rKH6+SZzp+TDkgMIKvUpHPFIS
	 C3vxnQMmZ4fNFS0VNQMN+3xPNdpTsI9Lgs4PsUlkGVh5kN7e1vdUChBdTfhCOrBZuLPmI
	 j8KtjvNGRzEETEloQyRiOSI5ItAxiQP4qpdbi5+0Jo6dbFE8wAGjMiPbQEN2ET4jjKacR
	 HiBx0q/5l8lEfudAF1J2uyjf/C1EV6CNehGKf8RRDV4ySZWyQzUKNoa+TmzOkHduE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098655;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=dZz9lepwmlI/2ss/zkEKEg3BC+T3gnksNTo7+qpe9cw=;
	b=N5441xdTeA/dX6VS26XkTHdKdUcQSnSgLb08jjiD1JeQgOfFfoZfrbK6kHgHW4hXSaS/
	 wG8p6UAFDSuaTgZCLz8LXwAMcbUZENnZ09F+1rKq7j2j2e01MV9OUIdDqof7qkhQD57Vl
	 mDCMUJmXAsMfdgu0BnF2mYsEBVdhhDpI4UqBQ+o1+2YEst2PKIfwg383V1/whfJZBvYdV
	 a3zsNsgKdJhW+PBSCJB9e9/4rQbfmm0SHwXn2ldGllkOOCI5O3j6EUhUJWClyfQ10Fg1s
	 yAGCPEudReZaCmohbrFr+uapoKojM5frC6wfyp0yb0q12h8TMoKwmR9aCz+Y/90naYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ju2DiaR9;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D13606A31B;
	Tue, 27 Oct 2026 10:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D13606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ju2DiaR9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793098655; x=1824634655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NJXnj7w8pWN3MAmf0AvWK3yUGzwNpUAqyM+X0M9ZSTI=;
  b=ju2DiaR9hMXgLQD0vkwlbK8jvdF1UUGCKKNQGZv8LJ3/sYPFxAnBuFXM
   8Nagi/Qj4VhrH1k/kIoOl559hQXomF2vzas8YgIHOoBruIHyfd6hPHE37
   vvIOIrYwh1ko/jqw46sbHXLqNg/QIiVjQLw7lIW8Rz/8aqes3vZWX9/mj
   FSk9Z/ifCIddmq3iAOntUm2SxB4LoEgFbxLAGUo4KCijlKAa3g2KXhnM/
   GE8j0/TR2iv5OxN4hQOOYeyB8yyZbVyvJ2EiotP+kxpbU45/A5ITk3O46
   negytHUZVwFKXSp5cWrTPEbDMgVtve5WByzmIRVlQQrXhOlXGJ13kacgb
   g==;
X-CSE-ConnectionGUID: qs9Fzu/9QfyU3Ng+Gd12qg==
X-CSE-MsgGUID: cOdqnKJYSiaWg7JfV1AWXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1698414"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1698414"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:57:34 -0700
X-CSE-ConnectionGUID: mKWLNoNfTvq7NWi3cOEIBw==
X-CSE-MsgGUID: yXzo/wnYTh+aZbgjrPdnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6265627"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:57:27 -0700
Date: Tue, 27 Oct 2026 12:57:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>,
	Gene Chen <gene_chen@richtek.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Cong Nguyen <congnt264@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Christian Eggers <ceggers@arri.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Justin Weiss <justin@justinweiss.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Archit Anant <architanant5@gmail.com>,
	Stefano Manni <stefano.manni@gmail.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Piyush Patle <piyushpatle228@gmail.com>,
	=?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>,
	stable@vger.kernel.org,
	Adi Nata <adinata.softwareengineer@gmail.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 00/39] IIO: Continue removing deprecated
 iio_push_to_buffers_with_timestamp()
Message-ID: <auCDk6qMQDMEGdOr@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:18PM -0700, Jonathan Cameron wrote:
> A bit of technical debt cleanup that was partly a discovery exercise in
> using AI tooling for this sort of somewhat messy subsystem maintenance
> activity.
> 
> Replace iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() which includes a runtime check that
> there is sufficient space to insert the timestamp.
> 
> A few other modifications of related code seen whilst working through
> these and a couple of fixes for DMA safety. Those are not sent as
> separate fixes as they are in old drivers and we have had no
> reports of problems. So no rush to get upstream.
> 
> The remaining users of iio_push_to_buffers_with_timestamp() are
> the more complex cases that will require more careful review so
> are left for the next series.
> 
> I appreciate this is a large series, so if you have time to take
> a look review what you can and I'll nibble away at applying the
> ones that have received sufficient review.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
assuming we get a positive feedback from Srinivas on testing HID sensors case.

-- 
With Best Regards,
Andy Shevchenko


