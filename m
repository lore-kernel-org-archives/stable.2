Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308303;
	b=5XYT3FctbFG/n+in1s5WVlXkI3a1NnJR/3NUBZGHNpIOwmfW2f+EKy9htsyDydW+7Q4M
	 4Zt/s2n8EtyvB5vFeZpRek0u8t20AiyP9Ckz6Ua1cW/zn0a6fdRcGKi/uW7SakDigQ1Yp
	 ACEJeBuL6N5VXe2JEKBS6oRQ/ywbeiwaaF5wd1Wc5fhjBvDDI0wLZjBjEXqabSq+BIFTF
	 ayEgH7EdlLwsXhTvjdO4R0Mb50w1GjZ8e5+gGEXTFmJeNWjeTRP1sleWK4wYwgefZryvY
	 CBIkFFxUYVnWgPDFFWB1T0m6pgthc03l1cRRuB5+P/Y1y61Nq6tcVZSSaMq3hJiHD+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308303;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6KUDHj9lnMhAg+nHCDiWshEywbgwlvmxhCYqrSNjsow=;
	b=cXRJzsF1yvb261BuwIgcwjEUnqg4+J9nOMv4Ln6+WbjBe8p2ZTekU5Rx+gJstrtJ1jVP
	 0pJcIvs6yd7PZ/kzBvmNbdFRuPjmSfKZmj0Hd0HUhleVXTpc9pVjFFXfU/aApj6nEhIBH
	 gug9rSuS0i3DrrRIj0xmo3MPTUzFXoSjvMMzfXpQUoe1ITmPg2cuq5Ko++Rk7iG6KDVGJ
	 h1O5iEtEBTXWBtagE8xJhkraIT7Ul8D4UM3Rhbrt0wrT5UqUZ9Wh1QTzhh5g2ESLY/ECc
	 C0Rx46B6cRUycHbeeHoQC0h4C47jXmMLvMu9hE4680OiRpsDzV6e7KF8YOub3HWmllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SDKOEak/";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CA606A31C;
	Tue, 10 Nov 2026 10:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SDKOEak/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794308302; x=1825844302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rzWOvcnMo7ieIYwX8DGNSb4d4JD47sR79PHePk6OGc4=;
  b=SDKOEak/K+/eE2mERxsjjHJ/iP5wKsI3ETPMdgU48lw1pqVd1F2Mh3HJ
   MfSDGWQvyFuHTg95V18aa0CfgPy05Ne6JCxzRHBsTFc5L5oQpa/nLU3cd
   2QKBpiDIZ8OXQfrJwIiI0YL6Ut1WKAcMwyfU8Y6vLATATG0+bmgxXNP2a
   8wqjPYgujaJnkeFwbkkxcRak9U5Ud16o62K2v3eVmiea04vXe9k8jcrhP
   +0BzCKdkukr2W6wJQ8WjYNj/rRNf/jfdfswalwWmEr7ihUVINQyTC+Lka
   XJuBavTZtiMP1qUsA80Ar/qta4MLjZLFGO7QvvBS6ohyb1CTTFMWe88UX
   w==;
X-CSE-ConnectionGUID: p4/Sz5Y2SG60ypDhIw48fQ==
X-CSE-MsgGUID: 0xkYZtCRRyq8WeWnPDgNBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2955687"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2955687"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:58:21 -0800
X-CSE-ConnectionGUID: svM277OqS7Givrs42fzSFg==
X-CSE-MsgGUID: niEuaG0QT1+pIEt/DikLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7993273"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:58:17 -0800
Date: Tue, 10 Nov 2026 12:58:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 2/8] i2c: core: fix swnode use-after-free on client
 deregistration
Message-ID: <avL4x_clSegBu-Qi@ashevche-desk.local>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-3-johan@kernel.org>
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
In-Reply-To: <20261110085125.2535508-3-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 09:51:18AM +0100, Johan Hovold wrote:
> If a client has both a primary and a secondary firmware node, the
> secondary node is accessed via the ->secondary pointer of the primary
> node.
> 
> Use a temporary variable to track whether the firmware node is a
> software node and remove any software node before dropping its reference
> to avoid a use-after-free in device_remove_software_node() when
> accessing the secondary firmware node.

...

> Fixes: df6d7277e552 ("i2c: core: Do not dereference fwnode in struct device")
> Fixes: 1c24e5fc0c70 ("i2c: core: Fix double-free of fwnode in i2c_unregister_device()")
> Cc: stable@vger.kernel.org	# 6.16

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hansg@kernel.org>

Can we keep these two Cc out of the commit message?

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

...

>  	struct fwnode_handle *fwnode;
> +	bool fwnode_is_software_node;
>  
>  	if (IS_ERR_OR_NULL(client))
>  		return;
> @@ -1066,14 +1067,14 @@ void i2c_unregister_device(struct i2c_client *client)
>  	else if (is_acpi_device_node(fwnode))
>  		acpi_device_clear_enumerated(to_acpi_device_node(fwnode));
>  
> +	fwnode_is_software_node = is_software_node(fwnode);
> +	device_remove_software_node(&client->dev);
>  	/*
> -	 * If the primary fwnode is a software node it is free-ed by
> -	 * device_remove_software_node() below, avoid double-free.
> +	 * If the firmware node is a software node, its reference count
> +	 * was decremented by device_remove_software_node().
>  	 */
> -	if (!is_software_node(fwnode))
> +	if (!fwnode_is_software_node)
>  		fwnode_handle_put(fwnode);

Do I understand correctly that this is a dup with the platform device case? Can
we make a helper (on swnode API level) to cover any other existing or potential
case to avoid similar issues in the future?

-- 
With Best Regards,
Andy Shevchenko


