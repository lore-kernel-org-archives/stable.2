Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706633;
	b=NvG0SpqdN6vK0pViOATO82A2AUhHyqM7kUgHQn56xClJnawk9HGABJHiI023D9CZyrr6
	 lk4YmzNBCCuD1bZybKnT7Bp3N1WGT5epVCQzLJC8545PpJKy721HHyOtseU5a7TkxLSZx
	 BtUM43hAmVoHmj3UJkE5V4ky1cArHQif5xdKFVvtqHhkZhgvqODZr942KZ7Z0A80G1fKl
	 CGP+LNGlAFUuZByWDB95eXo4qmmqbay6ZmVv1tb/dPCzy2N/+t33NC6JFzahsgzsaaA+7
	 6F6+klDR4MLg2hlrO9yhsP5UedUdOZ/spXCmCC/M6u+s9LmXgWPu2ezQgfpVtUvMvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706633;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Mk/qZmByhXRqlrZP6lp4cyE3eXvfgviZGdXDBSlTm1U=;
	b=vEp61J0xnPcPFlfx0cE0sAEjFmFMt1FOlL46+Ih/gse8/Rb+odlxhyuf7s5UrQWl2MR7
	 Yi9arVdgYYNj7sxdA7qarzvV9fPg1aNpDAGqvp5VDISffb+NSTeiwmVS5+sfWC3q5OrRY
	 K/iVJbPq0RDx0nobQ0rcOKzKgwyIg4RDhhlMij34lHrBKCUrrEXghedk+hcZdOl1QGOam
	 ZRV/UoNCurPSfUmiYYCvb6evHdhqPt6j2cfEaAwTaJRrxt9WyBwbShy+XtDjjcEFx7alh
	 QvobMkZ5iUpFOYR9yx156z+BzthUJ/THZxBesjLS3FL2h9x817FSaxt6rtQ2HiB/NrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JaPS8GPt;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81029606A31C;
	Thu, 26 Nov 2026 15:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81029606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JaPS8GPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795706633; x=1827242633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YV/1SDqQDXBBeunedgOPKZaKkiogMLzPsgimzmJMIfE=;
  b=JaPS8GPtijgXHaNysWgWx5NufXtqtqM7/xmWr+b0ix15n1KGnmtBCJlt
   hlQkK0aME8mQjsjPJYfCpV/A58+/9Q8PwB9QFAUOZIH3QtQb+OEsaB4QZ
   xNQh15R0lB4emZlVwo2y9NvWMzM4H3233CkF0JwKqXgd447PR5bcJQy6a
   SY+HJBS45r5Cbco0bui8QYCsYozwcguPKHObEHeEMHbs/pFacm8coa8pR
   UCnvrUTLdwhjTHIC0qG+R/lMklxDu/luFpS+QNw2rUF6jnXlFIRWe0CUY
   rOvgWv9O7g7Lveywl9JuEBCg00MACEbec1bv3O1WfFqwk+Abdy78hGuV0
   g==;
X-CSE-ConnectionGUID: XU/P5pzrTbSSzWyiov+fbg==
X-CSE-MsgGUID: QjkESGMtTay8lvJiN28HpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4548613"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4548613"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:23:52 -0800
X-CSE-ConnectionGUID: 0EGqYNBhSjuCS43Xj6NnDg==
X-CSE-MsgGUID: Fwh6lztOTVGZ2bZ+E+7oRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12229963"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:23:50 -0800
Date: Thu, 26 Nov 2026 17:23:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gary Wang <is0124@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Message-ID: <awhPAzKefJVW2meb@ashevche-desk.local>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
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
In-Reply-To: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 11:09:43PM +0800, Gary Wang wrote:
> Add support for "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> "UP Squared i12","UP 7000" and missing groups and functions data for 
> INTC1055 & INTC1057 & INTC105E.
> 
> Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> on the AANT0F04.
> 
> There are no compile-time dependencies for each file, all pin groups 
> functions data will forward to set default when pinctrl upboard probe.
> It shows an error when run-time dependencies are not mapping to right
> groups and functions.
> 
> The pinctrl-upboard is provide additional driving power and pin mux 
> function through native SOC pins->FPGA/CPLD->hat pins for flexible board
> level applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

Thanks for update! Looks much better now. I'm about to apply, but I want to
make one thing clear before that, id est is it indeed ISH has only a single
UART? Or do we need to add an index there?

-- 
With Best Regards,
Andy Shevchenko


