Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4D3D3CEB;
	Mon, 27 Jul 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150303; cv=none; b=A/ZdvpBLoe1BVbZfHn/LNXpSvlicQBTS+GwRjzMvwtJvW7SMejHk/+//dAnvfySltJ0pCx8teFKQIj6XxGPT92gvDgGvoppMvHa3+abFydxmWiTySJbQ9eYuPYk/gnpJHODI31CDcuC4zIsYIHJjCatux4xkTxC8hxiCYzl8gy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150303; c=relaxed/simple;
	bh=7mt6BZOnmtVbD9vLUXdK50ILuKZ8pafLEG2RXqM8qhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLWNPh24WWmctpAJnzm5FC2hvvanUZHw6dLSib006WnSURlOg+yWATOk+KU9SQQryrbMzqqZ0+GDSNqTJ6NbjY/OA3jnmd5qJKoV1KBATcC5SQy5U2WVhHfMlgNWaBo1zP300cWcA5x67oPLJQ7uvHNlPqwUS2u+1BvO+IN5Ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1qWWNxf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1qWWNxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785150302; x=1816686302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7mt6BZOnmtVbD9vLUXdK50ILuKZ8pafLEG2RXqM8qhI=;
  b=e1qWWNxf+C9yKybQeFQtnioEZWxFVCjVY7RR2Wg7s68jTECyp+OOwPD+
   Sic5mG2XRog5CYns8riGMWeDt3ZzQcRdO7uHeHfmK18eJU+ZgFuewDHmB
   ew2PDbf6tD/NUORRNlBSYDjoqsB41NfsTHnow5cxBvJO1LKo9841DApRk
   JMoPlWThcBb/tB3/0s9HUyJDIqmBLdjS3ap+xjOnHc4qqE5BM27ivmYB0
   Ew1zjOjmblbfeVN/AZ/RM1r/EVsg7yhShcCXuy5Z7l5zXEBcDsIm2XDdv
   3Ydq9fJ49zsuKZn1G7KtPwFlsUuEUsR7N13H+gu9M05e7lmTvEHgvrfLC
   Q==;
X-CSE-ConnectionGUID: 6DaJNgBYT0iHBqFhzvb+kw==
X-CSE-MsgGUID: 1vy48teIR4aUlnba3ogZZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85478355"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85478355"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:05:01 -0700
X-CSE-ConnectionGUID: 1iJbDDvdRd+Yd1hub+cvQg==
X-CSE-MsgGUID: TOAXQaf/SmaczJa4NwgGbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="297611032"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 27 Jul 2026 04:04:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 352B799; Mon, 27 Jul 2026 13:04:58 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:04:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: andreas.noever@gmail.com, westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: icm: preserve USB4 proxy data-valid bit
Message-ID: <20260727110458.GH2365036@black.igk.intel.com>
References: <BA3238878103AC07+20260713093237.3516283-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BA3238878103AC07+20260713093237.3516283-1-raoxu@uniontech.com>

On Mon, Jul 13, 2026 at 05:32:37PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The ICM USB4 switch operation request encodes two values in
> request.data_len_valid: bit 4 marks the data payload valid, while bits
> 3:0 hold the payload length in dwords.  A zero length with the valid bit
> set represents the full 16-dword data array.
> 
> icm_usb4_switch_op() sets the valid bit when a transmit payload is
> present.  For payloads shorter than the full 16 dwords, it then assigns
> the length to the whole field and clears the valid bit that was just set.
> The payload is still copied into the request, but the descriptor sent to
> firmware marks that data as invalid.
> 
> This affects USB4 router operations that send short payloads through the
> firmware connection manager.  In particular, USB4 NVM writes can send a
> short final block when the image size is not aligned to the 64-byte proxy
> payload size.  Firmware may then ignore or reject that final block, while
> full 16-dword blocks are unaffected because they are encoded as length 0
> with the valid bit set.
> 
> OR the short payload length into data_len_valid so the valid bit is
> preserved.
> 
> Fixes: 9039387e166e ("thunderbolt: Add USB4 router operation proxy for firmware connection manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied to thunderbolt.git/fixes, thanks!
