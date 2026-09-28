Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF914D599E;
	Mon, 28 Sep 2026 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604920; cv=none; b=cTvntvnoNAgcJAKQ8Y0USHDuyKktd0pm9LLUY+bqO2MUFFRAZor1sE8lcm4oiAQoo8wFjNzIQtou9WXwenqqnc1i7fPrBetxjW7fdnTWQLX21nqOeSWuBlUhKU6u6P0BEeLYbqzUbmYD3689bkKsOk7c9IM3nUM2z4nU6OsMgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604920; c=relaxed/simple;
	bh=sNGhPL/BkYrHIBtMiL3IlNg9RUcfbK/9dzPLjSy+4LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqDm61k4McE8pKmNQNXp75tbZs9pew2Fw/NNdAolKlbw8Rs4ZzYD3C8qteh3/jHGUbF4V+KAN0kbJbLx1SFwpquiB83A31ViS3XoCFSJssG9dj38g0CLZMfWVu78kYpFtPlbsnyE9l8jN4c3BPu444TutEhA2w4y5ZQtNgoSJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSKt3AyN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSKt3AyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790604919; x=1822140919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNGhPL/BkYrHIBtMiL3IlNg9RUcfbK/9dzPLjSy+4LI=;
  b=mSKt3AyN1KYH6i2x1jyGsXsMOb5d8ioL5o4xOCUKbcqIMGa1Jye+KsPR
   s53z2MdpGcTclhU2rrWh/w6jFZqzEBNBptcUCmbteunpseXr8ZmAh4SVX
   RZ+czCV5nW4Ic1IG+Bi1CWQv84TAqj6fxpADLlm+6xoDIfjin4A1a81l6
   yuMKenB7F5dQlvWprhdZiEyOmKck61Gf/u/2+LlmgxHlOVvDw34z3Aybi
   YyS191AW709HVZdxUXpGEWF6UKKbzM5ieLhl6Hvf6D0wXg5u7ygJh8hg8
   k6QcBjatF59JQPt11NCXlRnNOtV26llPodhGrJK+dhjoDearxQGxNbDBm
   A==;
X-CSE-ConnectionGUID: /nKmFZ2XTRC8wDkI5vwvLg==
X-CSE-MsgGUID: TTHRAgZSR8ymXoGaC6XpPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100637662"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="100637662"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 07:15:18 -0700
X-CSE-ConnectionGUID: r7LjRJF3RLeWL+cE9ECceA==
X-CSE-MsgGUID: 2b49oJs6Tw69bZQeBSldAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278425331"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Sep 2026 07:15:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3784699; Mon, 28 Sep 2026 16:15:14 +0200 (CEST)
Date: Mon, 28 Sep 2026 16:15:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: limit the PDO count to the number of
 PDOs requested
Message-ID: <arp2cstT7184pH66@black.igk.intel.com>
References: <20260927214904.447250-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927214904.447250-2-eeodqql09@gmail.com>

On Sun, Sep 27, 2026 at 05:49:05PM -0400, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> In ucsi_get_pdos(), the number of PDOs is derived from the data length
> reported in the CCI register, which is provided by the PPM firmware.
> 
> The function requests at most UCSI_MAX_PDOS PDOs on the first read and
> PDO_MAX_OBJECTS - UCSI_MAX_PDOS on the second, and ucsi_send_command()
> only copies that many bytes into the buffer. However, the returned
> length is taken from the 8 bit CCI data length field and is not bounded
> by the size of the request.
> 
> If a malicious PPM reports a larger length, e.g. 0xFF, each
> read is counted as 63 PDOs and ucsi_get_pdos() returns up to 126, beyond
> PDO_MAX_OBJECTS and the number of PDOs actually read.
> 
> ucsi_get_src_pdos() stores this value in con->num_pdos, and
> ucsi_psy_get_voltage_max() and ucsi_psy_get_current_max() use it to
> index con->src_pdos[con->num_pdos - 1], resulting in an out-of-bounds
> read. This happens without any userspace action, since
> ucsi_get_src_pdos() calls ucsi_port_psy_changed() and the resulting
> uevent reads every property.
> 
> Fix this by limiting the count of each read to the number of PDOs
> requested, so that the returned value always matches the buffer
> contents and never exceeds PDO_MAX_OBJECTS.

I'm not going to accept any more changes like this that silently "fix"
real or hypothetical firmware issues.

In stead of doing that, make the code print a big fat error message
informing the user that the FW/PPM sucks in the system, and then
return a failure from the function.

Thanks,

> Fixes: b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index bef3f9b71d71..639f99f49ff9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -898,7 +898,8 @@ static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
>  	if (ret < 0)
>  		return ret;
>  
> -	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> +	/* The PPM may report more data than was requested */
> +	num_pdos = min_t(u8, ret / sizeof(u32), UCSI_MAX_PDOS);
>  	if (num_pdos < UCSI_MAX_PDOS)
>  		return num_pdos;
>  
> @@ -908,7 +909,8 @@ static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret / sizeof(u32) + num_pdos;
> +	return min_t(u8, ret / sizeof(u32),
> +		     PDO_MAX_OBJECTS - UCSI_MAX_PDOS) + num_pdos;
>  }
>  
>  static int ucsi_get_src_pdos(struct ucsi_connector *con)
> -- 
> 2.43.0

-- 
heikki
