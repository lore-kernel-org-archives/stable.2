Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E03ED109;
	Wed, 30 Sep 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774896; cv=none; b=QD8MdOO6j9+HJnqqHqi2ue95cD3bv85ZqIHe1SNBxLpKGd4cgGOL2ETrTDKTZeFwCtWFJqUr2JP14d/a0gZI796UgMwSqslZk9KUv1EoNmuryaOFecjVKV1sX+vMAFbLscc2jFx2XhCMJ91P6BOODtbzyJ6aZ08v79+NDmdSODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774896; c=relaxed/simple;
	bh=Eyx93yZZEASpes3D9jK0aMrtguFfHVD53LVcjzqJRvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw0Zj+Nvs+A744DFyL+3oQplcVzIj8krRBqG2QwaRDcdZFGk0KDscYcZGxN29V3/63kRuuyiQtdUrywBGFf6fRlWLrCA77Giu8TFaZBVY2aE3deB3cPsmiuYYSDbijdMZzgn6JSpo095WdEoL4k6JgG9UGErt3HhDDNS8fqOPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnqSkhnF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnqSkhnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774889; x=1822310889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eyx93yZZEASpes3D9jK0aMrtguFfHVD53LVcjzqJRvY=;
  b=ZnqSkhnFm7iKEiIwTOuZ7OoZGLizjMpCC4pCEwOEPnYSEQEETWTvWz+F
   6x1tzURBk37T0SnHiXTWvbogKhmiR1pItildhTQQmG42K8Q3lC8koc/Uc
   7h5VyC+y+PwPYRWd0loctyXlTrLcTFMlyi3ns6vOyO7Gg6XUwXIxm3iPa
   lNdT4jtZ9BpeY0Z5RNHIRpvsRkrkrC3x3qGEcuvwTSFjzvWmWmXy5Nmi4
   yxJYOacyxOZAIheDJKcNiYIItk/jYL1F+WpJ+fQUhDvQzHoa5mrndoQ2k
   B1hU0Uokc8BAff2zaml8upommHpOWKj5K5RPJETKO4srpX82l2Q55DtMl
   Q==;
X-CSE-ConnectionGUID: lpFkNO5RQ6KKRcNFNPQNqw==
X-CSE-MsgGUID: 6Muc2A87Sc6hKKk+uPlftg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91375886"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="91375886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:28:03 -0700
X-CSE-ConnectionGUID: jFiYJJhETKagy+nwgU1wgQ==
X-CSE-MsgGUID: GAUgA2d+QbGW5gaPoXbDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274307671"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.78]) ([10.245.245.78])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:27:57 -0700
Message-ID: <57369b29-27ce-432d-aac3-b86c71a08330@linux.intel.com>
Date: Wed, 30 Sep 2026 16:27:53 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: host: Fix companion leak in
 usb_enable_intel_xhci_ports()
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, sarah.a.sharp@linux.intel.com,
 stable@vger.kernel.org
References: <20260916164840.2085101-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260916164840.2085101-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 19:48, Wentao Liang wrote:
> usb_enable_intel_xhci_ports() iterates over the PCI devices with
> for_each_pci_dev() to check whether an Intel EHCI companion exists and
> breaks out of the loop as soon as one is found. for_each_pci_dev()
> takes a reference on the device returned by pci_get_device(), and
> breaking out of the loop leaves that reference held. The companion
> pointer is only used to set the ehci_found flag and the reference is
> never dropped, leaking a reference to the EHCI companion device on
> every port switch operation.
> 
> Drop the reference with pci_dev_put() once the lookup is done. When no
> companion is found the loop leaves companion set to NULL, for which
> pci_dev_put() is a no-op.
> 
> Fixes: 26b76798e050 ("Intel xhci: refactor EHCI/xHCI port switching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/usb/host/pci-quirks.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0404489c2f6a..bde5bc248d45 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1076,6 +1076,8 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
>   			break;
>   		}
>   	}
> +	/* for_each_pci_dev() takes a reference on the found companion */
> +	pci_dev_put(companion);
>   
>   	if (!ehci_found)
>   		return;

pci_dev_put() should only be called if we break out of the loop, i.e when ehci_found == true.

Moving pci_dev_put() a couple lines lower, after the if (!ehci_found) check should work.

Thanks
Mathias
