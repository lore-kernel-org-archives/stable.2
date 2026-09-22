Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C6D541464;
	Tue, 22 Sep 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079468; cv=none; b=QT8v13N/xhyM9mSEDMtiCpF0inElMZy5ZQI3Kr4eU5iMnjBfonYFPNL7R8xPRR59hp40QV5jUQPu+fUkJla16dXx5QRcfpASDsG+fVeUrqWbjuTTdmOsE6LbxIQHsizb+2QqDHzOXrbp6Bh9gct60ZCaBCI95V5/V198CTKI9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079468; c=relaxed/simple;
	bh=hHj6ryPUb7nCKma00OFgMT3n+REclaknho5AYIRnK5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSVBQwgZHC9Cym52hQ64qsoQtFFBDIjKiG3OAtQXS69qU58fWaiqgDNalL2VR0QXSUW7yIoynL8UwLQjSH5Y18ph9aiKUPXPKDqNmFPf6V55r1ykU4/wjwHm6iASiGmUGZgNDVmXq4hrdwfQSUJXrJ1TH73RcuEah0/XJWaFB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnIR0JxT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnIR0JxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790079466; x=1821615466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hHj6ryPUb7nCKma00OFgMT3n+REclaknho5AYIRnK5s=;
  b=GnIR0JxTyA/agIhgmx0Tbz/8nK+aL2e1/HdwjVL+PQ7btsXLXvlIfBfm
   jIkRTR+RhI81Uerbv22Bb/h5YSdsbJmTvw3wnYX9kpRIVHx8pM/CIGthj
   TFksYyXxiaUaMNDZZZSoy29jRdgECmAYV6N6HgynXB+to+Xklwrcp2Jv4
   rvMtqjluP5hEWWdLScZX2GkKfArSlTyrcLLVy8ilYHlq+eiy6cvS/n+8O
   Ivok0KXxULSgwnkoos+RBFqMOzAi6K5LZNw3d/5VCW0mOQ4y6ij16CIni
   /dEqslV0bHHt6ehXBSmCQe16hNMcdfTwSFZ8FHA4IX/N2bAKlEOTaqjbL
   A==;
X-CSE-ConnectionGUID: 18kqYA9CR9iTcLcq5neBBA==
X-CSE-MsgGUID: ivnRagpfSCyOXImCXoVrSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116198217"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="116198217"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:17:46 -0700
X-CSE-ConnectionGUID: c7UPVCiESLqxHGnmfdg0SA==
X-CSE-MsgGUID: HZklwC3/Qae4HYUIMKmM0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271677477"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:17:38 -0700
Date: Tue, 22 Sep 2026 15:17:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Liang <vulab@iscas.ac.cn>, Miaoqian Lin <linmq006@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx: gpc: remove all initialized power domains
Message-ID: <arJx4P11hZAqxE0P@ashevche-desk.local>
References: <20260918031323.3376849-1-lgs201920130244@gmail.com>
 <aqzqvfbeh653jUce@ashevche-desk.local>
 <CANUHTR9ipEFUGteK4TTpnpN0yUmxjop1v783aOhyq6AE9cwO0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR9ipEFUGteK4TTpnpN0yUmxjop1v783aOhyq6AE9cwO0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 22, 2026 at 03:41:07PM +0800, Guangshuo Li wrote:
> On Fri, 18 Sept 2026 at 15:39, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 18, 2026 at 11:13:22AM +0800, Guangshuo Li wrote:

> How about this:

...

> Does this look OK to you? If so, I'll send a v2.

Looks better, assuming it works as expected I am fine with it.

-- 
With Best Regards,
Andy Shevchenko


