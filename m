Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7C4C650B;
	Fri,  9 Oct 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544893; cv=none; b=aXr7pGZ7ccumqSf4Wsh/7WH2oGs/H3l25yycXi7dMr+3w1EWNIJHPUclVH9FcN52C8UEQTArPQjBDeGDnpLT2ZelwmVfZ0ymLHWbr6SseQuzgDqGvtxTtbMxeokfndhgbzM6dNlUwEIh+ZqoSmF6l1GULxIs9f/oSLrimNQBLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544893; c=relaxed/simple;
	bh=NZawBaQ9IJi/GpNjwKAnXaEzI5PhrWb/cau9GOSYIxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUjCFrKFZMavr9euHGmMbMgV+eZmDOKW+QkjYthYSZX0fq11OAea3fJTuU+EX2lUOwKvn+pKQKXTT9mBpez8tnh8Nfg/9ikfjzy+cw7IsLS2ggx1h8WAIW/h5YZ5XeoFkzs5ZRLJyJibS0db3VS5APjIy/ukLP40dpQUvf/w9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf+IXdbC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf+IXdbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791544886; x=1823080886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZawBaQ9IJi/GpNjwKAnXaEzI5PhrWb/cau9GOSYIxc=;
  b=Bf+IXdbCYXDVraRzARFytTKK9ttlY8xret0de9woWpq4das8HtZhdE4f
   Wuo+4Byi8Myobdl7y8SKzvstrmGRP3ZKo3SewHbAhU94yba0+1gkQSGu8
   a8AZmJuUKoXa35pB2hhbMd/NN57MtRPi3zGbvjDVEpr55D6ZvjcRjTYtS
   ze3dcuV+PT+ci8VlSNROKJmWsupZhMmFIXOTt2UDt3UFHXozWpgHNo35F
   Gx+SEllqufia/++1nLogdHDBqRLIXIrfvUKfJHl/09/kabHDBhpt4NTIR
   PRjtAZiLuUTHoBfSvAUI8QWz/QIqShqk2LMPm2ATkNVO4TiE+lMmvNcgc
   g==;
X-CSE-ConnectionGUID: R6xts7anRPGzKRq5g75E4Q==
X-CSE-MsgGUID: KN9UaplNSA6S0CDbg4MBqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="229132"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="229132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:21:25 -0700
X-CSE-ConnectionGUID: 3JWR8+fmQrWcU9wE1DccFw==
X-CSE-MsgGUID: Izq5uACYRqadtQq8fcyIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="258573"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 09 Oct 2026 04:21:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0D0C099; Fri, 09 Oct 2026 13:21:21 +0200 (CEST)
Date: Fri, 9 Oct 2026 13:21:21 +0200
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
Subject: Re: [PATCH v2] usb: typec: ucsi: reject GET_PDOS responses longer
 than requested
Message-ID: <asjOMb_guAbHRyWR@black.igk.intel.com>
References: <2026092932-arbitrate-snorkel-3fca@gregkh>
 <20261002202102.599998-1-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002202102.599998-1-eeodqql09@gmail.com>

On Fri, Oct 02, 2026 at 04:21:02PM -0400, pip-izony wrote:
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
> Reject such responses in ucsi_read_pdos(), if the PPM reports more data
> than was requested, print an error and return -EPROTO, so that the
> invalid count is never used.
> 
> Fixes: b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  v1 -> v2: Print an error and fail instead of limiting the count, as suggested
>  by Heikki.
> 
>  drivers/usb/typec/ucsi/ucsi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index bef3f9b71d71..17beec16fe19 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -862,6 +862,7 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>  			  u32 *pdos, int offset, int num_pdos)
>  {
>  	struct ucsi *ucsi = con->ucsi;
> +	int len = num_pdos * sizeof(u32);
>  	u64 command;
>  	int ret;
>  
> @@ -875,11 +876,17 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>  	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
>  	command |= UCSI_GET_PDOS_NUM_PDOS(num_pdos - 1);
>  	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
> -	ret = ucsi_send_command(ucsi, command, pdos + offset,
> -				num_pdos * sizeof(u32));
> +	ret = ucsi_send_command(ucsi, command, pdos + offset, len);
>  	if (ret < 0 && ret != -ETIMEDOUT)
>  		dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
>  
> +	if (ret > len) {
> +		dev_err(ucsi->dev,
> +			"PPM returned %d bytes of PDOs, but only %d were requested\n",
> +			ret, len);
> +		return -EPROTO;
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.43.0

-- 
heikki
