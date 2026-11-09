Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253939;
	b=ej5bxharmSbi7RvVD/mpH0wSLQVK+ykh3QZ6dMeWStHkNUeU9qLiViiFuUVXJ3jntEav
	 Zw1ZIYzshEGtPYAK/xrSWwUZ2uel4CcWMewl8d915LcuT1mXEWpB1noNnNzpDEp5tOCr0
	 ftsAKgpNsG7u7tKusMRWCMcI+UfeagleIaYq2vCl9ZRefijAYUAmuOXkRH/dWvhsyMQnE
	 eeRho6enE0XRjkAhimke7HJCNo5h/8KpCukI/fnk4gFsTKZQTHWz34t6CJ3Gj+wrZZOGv
	 8G/Lfo/iOvp2THM5CXhc2N5YU5aQ2y8cxTcxWBgx5rQcivXkBsPLyHSvNKCsMANMZOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253939;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=I2RDZZItKfk91FNeXS1/Q1/PaV3CH5F+rzlTBM5/OdA=;
	b=AXqUz+pawX36XWl8zV2ICnpWxh7ot3XyRZR1c1G84+ZkKjbKR1Kti3UItuz0d99AsJ3j
	 bSo3kTw6fijzoNQgJ+rGdaNkmhv4M+GBjULLgb+1Ou26xyi9f4CTO4BCWQWYuZ2jzu1oE
	 mYP0IiPK3Z8+vjvVTNdiJsd7F/LpUlSAOdOBr9YvAsawwshvsBoaiUMPjQn1J9VA7sj/C
	 2/ag32SIwsjdA3o1LZT6DlelIhZQ7yusYRcPrtrhFj5EitwPZP5OZmsCMzATH9YG9wuJa
	 35ql4jZipMHBNdnSHRVfuO/wwM4cyRuD5hDzmXAaaijIQdbDewVARG/ASjpw0nqnPqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XJPHBQdx;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421B606A325;
	Mon,  9 Nov 2026 19:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E421B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XJPHBQdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794253939; x=1825789939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+I4F4Fiy5/9FyYAEvRG3wsPXsygY/w4BgaxgMFsv74=;
  b=XJPHBQdxf1tj4lEoJZcKVvfF4mebKk7jfHOwIBGs+5hxOkGjFmSJ9z6r
   a/DBCrrb6jCg2pPwV63Ypjtrb1pRxUksKpdmdNlSe3xia3IqJyAfAdcnV
   GXMp8kjlljTgOU12u8IdwygidJAOsSlsQVfrR1FAbDHXEivWnKM5Knf+K
   mvEuAgn7fW6hjNOaKUGxwzaycpzNEIfwDBlS6C/3tjL1R+NDbUJpd7e2M
   /UNAS1s5X4D24e8kKO1cI7XXKdCwlIdyPWIxyw2g/FHDs+NsxF07giyIO
   5mGhcBMtqzjfJeJK0Ot2RHA1xTT1x5aOsLBwql+LK3XEPLZ00QlXcK9rQ
   Q==;
X-CSE-ConnectionGUID: tVddFMKiQJ+1uIG+crsOOg==
X-CSE-MsgGUID: npaUTZcrTZi8rZHac2HEng==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2976617"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2976617"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:52:18 -0800
X-CSE-ConnectionGUID: zt6jYjfSRgS7z/dq5H10PQ==
X-CSE-MsgGUID: WPoVGlx+RVWK8DJAL6FQGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8005616"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:52:15 -0800
Date: Mon, 9 Nov 2026 21:52:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] software node: make swnodes hold their own references on
 parents
Message-ID: <avIkbNrRtnJxZuYL@ashevche-desk.local>
References: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
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
In-Reply-To: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 12:13:28PM +0100, Bartosz Golaszewski wrote:
> In swnode_register(), swnode->parent is assigned before calling
> kobject_init_and_add(), which normally acquires a reference on
> parent->kobj via kobject_add_internal() that is held until after
> software_node_release() completes. However, if kobject_init_and_add()
> fails before acquiring the parent reference or drops it on error in
> kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
> while swnode->parent remains set.
> 
> With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
> kobject_delayed_cleanup() may create a situation where - when
> unregistering the child node and then the parent - the parent object
> gets released before the child who's left with a dangling pointer.
> 
> Acquire a refernce to the parent swnode when registering the child and
> drop it on child's release.

...

> +	if (parent)
> +		swnode_put(parent);

This will be the second case of potentially NULL being passed to swnode_put().
Since it's a static internal API, I would just add a check there and hope that
compiler will inline and that will be optimized away on the cases when the
parameter is known not to be NULL.

Maybe in a separate change.

...

> -	swnode->parent = parent;
> +	swnode->parent = parent ? swnode_get(parent) : NULL;

For the consistency's sake, same to swnode_get().

Note, that it also has a case in the current code. So with that patch it will
be two users of each.

-- 
With Best Regards,
Andy Shevchenko


