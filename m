Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C73EC830;
	Tue, 29 Sep 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688779; cv=none; b=VCHjM7GmcVwPhy7tPjLExCP03XtHKkYVT3V18JH/SLTAKfKX/NthxqGlPtmox7T9lRuwuoplCqM8xsNAWi1cR/gwCRy+F+sj+IRxfKTTQYh/R4OMdcnus1c9IUTiKPURekvF0j6jJ4PxP4X/pgQx90Ov1hJXro7amD8oz7wlSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688779; c=relaxed/simple;
	bh=XERgZ3+OK1lQuTGAOBOssUmLnqYQAgqZFnS2f6ME8Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUrAb41JY79/Lm02J4g5TZdZgZW8OoBVEfymD+nHfvqYdfdjxinccac2NmpnWjuTUKEPtBKGZPVdI3NuyuUpGB1/MpHK6+PGYqRj87OJzgUlD4xpiM6NEKZUXhCNbD54O2wCKfhBqtur/vhYQsdtxSrZTNJnk6nVLISomjHSP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhFhCXRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhFhCXRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941621F000FF;
	Tue, 29 Sep 2026 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790688778;
	bh=2XYvEZHFWs6yFyGF+VEUXWrv2zaJBuJjid9em3m6w08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qhFhCXRGACDQ0OIFm8eJg8NFwydCV2M3zoxaaR5JPFIwuvhTC9mgC35/0PYgFU8Z1
	 AY/v9JP3+v7idBXmrohRnD0LZ+7CkY8pwYJbrHJDAT2UTVv0tholKo6iGnwzJs7TYy
	 4UhG9xGnVeQErbViOpw7+JsFUXJVUSUDWqfwm7SQ=
Date: Tue, 29 Sep 2026 15:32:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: pip-izony <eeodqql09@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Message-ID: <2026092932-arbitrate-snorkel-3fca@gregkh>
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
> 
> Fixes: b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Did you forget to add an Assisted-by: tag?

thanks,

greg k-h
