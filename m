Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015F32A3FD;
	Fri, 12 Jun 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289139; cv=none; b=ans51846Bm+hVf2xQlJqQHLf0qOvDuJpumW+yQZT+YBIrLf5GyYQSfvCgVWwrJlLWxFw37vMgOZwplmeWfjb/wCPAMp9CLXMkVpUk5WzTPw543nQTLXuc2+HQz1oRI8v9yhmfObd2rmy5y0PfWjaUz02pBrXEEB7/eIvsmvUS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289139; c=relaxed/simple;
	bh=teAGIu20S+DfVjCHbLEHuNbZ11mMm4HiN9c3DP7SxHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmepy6fHCHqScJ++1gPgT2ZA4JLeEkIBwvODZ3EMoYKUA27DDPy/h2sYDlszA+08eHXtiuCiKvrkuCE2Y8OVKaN9w7QWXm0IpMJRJpXY54fzDqhwTXv6C7qx9XtNJF0wbFIwX4c1d3p2ITseu/I++MUzTSXqPXtuhdMTfeoyOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky93kri/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky93kri/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781289136; x=1812825136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=teAGIu20S+DfVjCHbLEHuNbZ11mMm4HiN9c3DP7SxHo=;
  b=ky93kri/s0ompeRsNo/HXFPIKdBSBhmLUqsg0kMESpgjlTUZzX3H/6bm
   vldndyA/7BB9gu/dHfuTQu0M33qNyOxvGAU+R7Ekg7+apNj2ifN/inupq
   siKowFlhUIUC9OIX4XKlw/6uKugxj7vlFEhMXRMWqxqUcrAZ64mDOblUO
   Vlno8fE9vJ+iN1E5bBcMQBr2ql576pjeFaQttd1EOIHYKyz3qDVjKl4IX
   Hm3GeRirDh1uHSrOWg1oFJsPbzLTp+Gb0kGuudfE5Vj9bM3TLRiBPg2CT
   /Ez2Os/3I7XPYh81X09n+oaXk6NnrVnPeZHxMyMTBxa98966963RDy/W8
   A==;
X-CSE-ConnectionGUID: 0fqHkyR6Qga/HtMbxbT4Rw==
X-CSE-MsgGUID: rBbELQNXTlKB3q04e0uTHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81969316"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="81969316"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:32:15 -0700
X-CSE-ConnectionGUID: LRQ+WIO9QSabUQjeviLM2g==
X-CSE-MsgGUID: 9mWp3+uRQGmnNKBT8ZADWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="246758789"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2026 11:32:12 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wY6fq-00000000PCT-0vYD;
	Fri, 12 Jun 2026 18:32:10 +0000
Date: Sat, 13 Jun 2026 02:32:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jipa Alexandru-Ionut <jipaionut@gmail.com>, valentina.manea.m@gmail.com,
	shuah@kernel.org, i@zenithal.me, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jipa Alexandru-Ionut <jipaionut@gmail.com>
Subject: Re: [PATCH] usbip: vudc: fix NULL pointer dereference in vep_dequeue
Message-ID: <202606130221.e57TS4Rk-lkp@intel.com>
References: <20260612114148.6849-1-jipaionut@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612114148.6849-1-jipaionut@gmail.com>

Hi Jipa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v7.1-rc7 next-20260611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jipa-Alexandru-Ionut/usbip-vudc-fix-NULL-pointer-dereference-in-vep_dequeue/20260612-195006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20260612114148.6849-1-jipaionut%40gmail.com
patch subject: [PATCH] usbip: vudc: fix NULL pointer dereference in vep_dequeue
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260613/202606130221.e57TS4Rk-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260613/202606130221.e57TS4Rk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606130221.e57TS4Rk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/usbip/vudc_dev.c: In function 'vep_dequeue':
>> drivers/usb/usbip/vudc_dev.c:336:26: warning: variable 'req' set but not used [-Wunused-but-set-variable=]
     336 |         struct vrequest *req;
         |                          ^~~


vim +/req +336 drivers/usb/usbip/vudc_dev.c

b6a0ca11186759 Igor Kotrasinski     2016-03-08  332  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  333  static int vep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
b6a0ca11186759 Igor Kotrasinski     2016-03-08  334  {
b6a0ca11186759 Igor Kotrasinski     2016-03-08  335  	struct vep *ep;
b6a0ca11186759 Igor Kotrasinski     2016-03-08 @336  	struct vrequest *req;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  337  	struct vudc *udc;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  338  	struct vrequest *lst;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  339  	unsigned long flags;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  340  	int ret = -EINVAL;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  341  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  342  	if (!_ep || !_req)
b6a0ca11186759 Igor Kotrasinski     2016-03-08  343  		return ret;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  344  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  345  	ep = to_vep(_ep);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  346  	req = to_vrequest(_req);
c21cd67cd337e6 Jipa Alexandru-Ionut 2026-06-12  347  	udc = ep_to_vudc(ep);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  348  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  349  	if (!udc->driver)
b6a0ca11186759 Igor Kotrasinski     2016-03-08  350  		return -ESHUTDOWN;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  351  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  352  	spin_lock_irqsave(&udc->lock, flags);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  353  	list_for_each_entry(lst, &ep->req_queue, req_entry) {
b6a0ca11186759 Igor Kotrasinski     2016-03-08  354  		if (&lst->req == _req) {
b6a0ca11186759 Igor Kotrasinski     2016-03-08  355  			list_del_init(&lst->req_entry);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  356  			_req->status = -ECONNRESET;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  357  			ret = 0;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  358  			break;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  359  		}
b6a0ca11186759 Igor Kotrasinski     2016-03-08  360  	}
b6a0ca11186759 Igor Kotrasinski     2016-03-08  361  	spin_unlock_irqrestore(&udc->lock, flags);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  362  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  363  	if (ret == 0)
b6a0ca11186759 Igor Kotrasinski     2016-03-08  364  		usb_gadget_giveback_request(_ep, _req);
b6a0ca11186759 Igor Kotrasinski     2016-03-08  365  
b6a0ca11186759 Igor Kotrasinski     2016-03-08  366  	return ret;
b6a0ca11186759 Igor Kotrasinski     2016-03-08  367  }
b6a0ca11186759 Igor Kotrasinski     2016-03-08  368  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
