Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606452;
	b=LuWgicSmsKHO/O1A7lSu9KnU3UHmC0ls5J0dpzMc0TstD7Iunfh2VoIRNPsGkVwr6+rq
	 o+nzatKr52CN619HH1pFy6FJ+LnroZqe9xnoVlkaNiiHiOAqPJZS5pLnXbujoR11wXjA9
	 xWC3SadQSmqk+ORv44RcJ5qwMRLBJq+0IIfPieBsHEZvpbq7MITiU4bjIfKPGR3SSgsLt
	 MxY/BAuNi5hI5NFgSkYGXsuJkdSEclORrmnUKWSVgsYVI04B9LMN314zJAa8mSx/cM/jr
	 3mZ+VyCmNIrDx4A/AIw6HK1mXX7VIWeOWueAxwnqxy/Z9HOCz7/QrtrbydEiBdhKFkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606452;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=G9DtsXcfz4y+IZgCUkf0GaIAzu44qcRml02dPTNgx/8=;
	b=qJ8oB4XIqikGBUnSKBMLlAkuxrvb9b0e5bJDRUWTLwFZFe1MMC3gASLXP2ZrbM67pAwZ
	 nluaeSvLwLuQ4x+sulK32AaBd2GSW2CqP0drheTIS5YXOOqWRlVDvkjhniAyfcksMpFXW
	 aqunWgevNqwlde5vI8K/XhkntvozLYYhcrnnE5dOXQLI0NQEp4e4K3oWnICVn043fNIMk
	 MJ3v0+p0isC6Wk/9OFg5U5XWWtTlWZBvIwy4QIHrUu/5fbh/NlkUbsn+Di4bmmnc/cnbC
	 IIBuIHQiATzlBxoFnEIh7Ygzwa+9DYjOJmDsl7r5j15xclHtPtt2GxEExjrkW0s58Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mCB1hAko;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC9606A333;
	Wed, 25 Nov 2026 11:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00BC9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mCB1hAko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795606452; x=1827142452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fMsAeJ0c7n73+oW7qS3cdLS2Wtgb2G4gCGLgjIUYl98=;
  b=mCB1hAkof/qAkU/YUshoYcncwF1o24IYqxTGmFA0gvFxaH1ZYeloofqE
   +DqIVKdaYQ+QB3TuRAgrFfqUbvkr21IsD0sps46WWDGtmQco/vTeamx43
   0mwGpq33Hvxr6bJFOlNyHwl6++JVAmyb+2KRZjfYplOW14oNppTAAm6Ma
   IyAPfm+qDzrhXEyo5w+CeLn/M8cjteoYTafKUKknM179tmPbpDAakATcm
   MRkyc3dteXGxJS28OUasIMGR5/83/1y10mITVTfge4/+BlZWtojmRFYWn
   nzsrsyFHNOF6WhH7yvbzGCu2FK0zxcCT0lurcY8JUXoi30WIwZ8nyTMq9
   Q==;
X-CSE-ConnectionGUID: v9I3QGsdTICG7YwFiaZBdA==
X-CSE-MsgGUID: /nM14pTvQ5a4weCQ1WTVJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4360646"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4360646"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:34:11 -0800
X-CSE-ConnectionGUID: ZhjG67rZRPKeRun9bRDfUw==
X-CSE-MsgGUID: o17WY9CCQAG8Z3ghnBYZ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11954522"
Received: from alekseim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:34:09 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A76F411F920;
	Wed, 25 Nov 2026 13:34:12 +0200 (EET)
Date: Wed, 25 Nov 2026 13:34:12 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] usb: ljca: fix NULL pointer dereference on events for
 callback-less clients
Message-ID: <awbHtFvxuSfbO4rw@kekkonen.localdomain>
References: <20261120150143.2591-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261120150143.2591-1-25031212351@stu.xidian.edu.cn>

On Fri, Nov 20, 2026 at 11:01:43PM +0800, YuanZhe Liu wrote:
> ljca_handle_event() dispatches an incoming event message to the first
> client whose type matches the message type and calls that client's event
> callback without checking that a callback is registered.  Only the GPIO
> client calls ljca_register_event_cb(); the I2C and SPI clients never do,
> so their event_cb stays NULL for as long as the adapter is bound, while
> they are present in adap->client_list.
> 
> A device that sends a message without LJCA_ACK_FLAG and with the type of
> such a client therefore makes the driver call a NULL function pointer
> from the URB completion handler:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0x0
>   Call Trace:
>    ljca_handle_event drivers/usb/misc/usb-ljca.c:217 [inline]
>    ljca_recv+0x651/0x850 drivers/usb/misc/usb-ljca.c:295
>    __usb_hcd_giveback_urb+0x238/0x550 drivers/usb/core/hcd.c:1657
> 
> Check event_cb under client->event_cb_lock and skip the call when no
> callback is registered.  The same lock is taken by
> ljca_register_event_cb() and ljca_unregister_event_cb(), so the check
> cannot be invalidated before the call.
> 
> Fixes: acd6199f195d ("usb: Add support for Intel LJCA device")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
