Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F3363086;
	Mon, 27 Jul 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147554; cv=none; b=rZUT6h7T8WzpgT2XDcUMImKvuv63Md5As+zaZRXx+3SJzJo2EeKdiLV2jYioFi6xQa26qKbdVkY9j3Th5rFoYWirautpkNPZJ9Aat/qj07ZDrwA+pFY03NFQNZzCZ8cI6clD+KFhIXWaRqeZz7137ox7NESaGNncaoEO1yXjWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147554; c=relaxed/simple;
	bh=mvrEQn8i1eu/a5L2ZgTg8WB0Trhw3iUDMHGk8ODs160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG+GUZ0eNv8JdMzcJWmY/rhlBSKW/zpE8I64/sM07apIlC0mGO/9R9sx2bhJjjOcz9eswAw9uhUwkdAxKg6rTjFhHSj5kbPdN+a0b9U1HpAsmAWm49pDVj2XUwXQl4LOFdbrYQ0OQC7/QifMPKVdmFlAqBcK8ZT4CAG7A0scgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3eMRP9M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3eMRP9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785147552; x=1816683552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvrEQn8i1eu/a5L2ZgTg8WB0Trhw3iUDMHGk8ODs160=;
  b=A3eMRP9MoBfPpV0dEXNXOFavss5stn57R7xapXFgRUe9LAokUsZRf4uu
   Ut9UMCduR2oKT/PeH4A9mq1/dO5pxvdLeI1Vmnl4+pK/oU64kQIGqe5mW
   1ckT00ZP4vn3gUPVnYWJhIw/+Y4uAfSBqH6KodF9E/0I6B5ZP6d2w/qGd
   j/uwNJvdF57h/ZcvcOIq+LKMiI8hxKT/agpalRnBsZHyE3rgGjVcMgvUE
   wyrrIxkkhs8GMIYKkc+61vMFsQl6sa8h6grcxaq7/xAXdWz/VuzKYKz9Q
   l9lOMkqnV4cPcCEEnA6GHNeSIINywyGx/VzVdWWDGyT//EtCNn38WByWD
   Q==;
X-CSE-ConnectionGUID: Lc1y2KKzTWiIpwgEl4LDCg==
X-CSE-MsgGUID: XylQlII4QQuuNfmNefYp+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85755485"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85755485"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 03:19:11 -0700
X-CSE-ConnectionGUID: OJw7Dg/mQQG46WFz2Yizxg==
X-CSE-MsgGUID: W5dXRSuqTtSoGhnTQFUEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256014602"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jul 2026 03:19:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4FA8199; Mon, 27 Jul 2026 12:19:09 +0200 (CEST)
Date: Mon, 27 Jul 2026 12:19:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: andreas.noever@gmail.com, westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/thunderbolt: tb_tunnel_pci: missing
 tb_tunnel_put on success path
Message-ID: <20260727101909.GC2365036@black.igk.intel.com>
References: <20260627024640.57118-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627024640.57118-1-vulab@iscas.ac.cn>

Your $subject is not following the conventions. Look at the existing
commits in given subsystem to see how they should look like. Here we like
"thunderbolt: ...".

On Sat, Jun 27, 2026 at 10:46:40AM +0800, WenTao Liang wrote:
> In tb_tunnel_pci(), tb_tunnel_alloc_pci() allocates a tunnel with kref
> initialized to 1. On the success path, the tunnel is added to the tunnel
> list via list_add_tail() but tb_tunnel_put() is never called to release
> the initial reference. On the error path (tb_tunnel_activate failure),
> tb_tunnel_put() is correctly called.
> 
> Add tb_tunnel_put(tunnel) after list_add_tail() on the success path.
> 
> Cc: stable@vger.kernel.org
> Fixes: 99cabbb006f1 ("thunderbolt: Add support for full PCIe daisy chains")

This is wrong commit.

> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/thunderbolt/tb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952..57c9839b133f 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2313,6 +2313,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
>  		tb_sw_warn(sw, "failed to connect xHCI\n");
>  
>  	list_add_tail(&tunnel->list, &tcm->tunnel_list);
> +	tb_tunnel_put(tunnel);

This will release the tunnel once it is in the list e.g causing
use-after-free later.

>  	return 0;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
