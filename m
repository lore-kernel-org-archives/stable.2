Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57683E559A;
	Fri, 26 Jun 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467604; cv=none; b=Rp8uIpueO350CsQc4gI58vgqOADt7iufcbqGH537AcN2NqhtSjGkWmC99LI/0aqEv3+/Bqfc1woVPplvhQ3YxJZO09pt4OqzgNf8EKRXp89vQugebfMYuybsF2aKQCu2u5WktbO9Dlgbm7HbkQeeeA5w0maOyD3HbhLy3xBUg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467604; c=relaxed/simple;
	bh=W+4jTqyA35mdIBJXfx4qPHeN+wgeMjX9V4IVniOdQfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szogrBDJIJE5vK8noVY/ndGJlRuAO80ppKxTabu/RCnCtw0iHCqSkGs6kcTaIN7LK5y/0BeBMG+PpbWVVXcfB7DjzPUkp8FCNNUmBJUGHny5wRO+ZG++WRJgLpJUz7PhTIj8+lu19w7fkayEocDHxyaPOa9y361IWmwEfRdgrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF9iYpno; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF9iYpno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782467603; x=1814003603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W+4jTqyA35mdIBJXfx4qPHeN+wgeMjX9V4IVniOdQfc=;
  b=LF9iYpno7J5EF1ip48e+XvK/+mtDoX2jmxnNAgaHnyrTz/FHbFOmvmVZ
   y40jNcWvDaAtb4tEEZefKXRE0mOL/hVgmrflw3+vr+8+YXEKLib4Gceeu
   u16RQdxqFnMFzceytCNaDM1rvg3GJDoh4Oh7bCZsDPvS5637fQkpCk3Ek
   hF+1xPLdFarL2dgg5oy4HcbpMp9vq+W85KSquYuRB5Su4BPVH8iDdFX3x
   Z3An+27Y7c4KBpZPkR+XMH0r0F/pUGaeQbp6gRedvvXkKjXP4/GZxRcLD
   0+p3UvGbCqiBM7bylJHrDEqwIsyY4HYp5ozXyIQ59t7eboI6IZDjsctbV
   w==;
X-CSE-ConnectionGUID: +vlqCeeQQZy7GrfNVC8H+g==
X-CSE-MsgGUID: tsceU0m3Sh6gB2MQ0MLZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93612493"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93612493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:53:23 -0700
X-CSE-ConnectionGUID: pn/V1DmQSnSGfH29J0WnVA==
X-CSE-MsgGUID: RUUfVz8bSIKYC9/rWe2ejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="250218913"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO alaakso-desk) ([10.245.246.23])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:53:20 -0700
Date: Fri, 26 Jun 2026 12:53:15 +0300
From: Antti Laakso <antti.laakso@linux.intel.com>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usbio: bound bulk IN response length to the
 received transfer
Message-ID: <aj5MC6Iy0J-A4c3t@alaakso-desk>
References: <20260624090952.86439-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624090952.86439-1-skyexpoc@gmail.com>

Hi Wei,

Thanks for the patch.

On Wed, Jun 24, 2026 at 06:09:52PM +0900, HE WEI (ギカク) wrote:
> usbio_bulk_msg() copies bpkt_len = le16_to_cpu(bpkt->len) bytes out of
> the bulk IN buffer (usbio->rxbuf, allocated with size usbio->rxbuf_len)
> into the caller's buffer.  bpkt_len is fully controlled by the device
> and is only checked against ibuf_len; ibuf_len in turn is checked
> against usbio->txbuf_len, not against rxbuf_len:
> 
> 	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
> 	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
> 		return -EMSGSIZE;
> 
> txbuf_len and rxbuf_len are taken independently from the bulk OUT and
> bulk IN endpoint wMaxPacketSize in usbio_probe().  A malicious or
> malfunctioning device that advertises a large bulk OUT endpoint and a
> small bulk IN endpoint (e.g. by claiming one of the quirk-free IDs such
> as the Lattice NX33U, 0x2ac1:0x20cb) therefore makes ibuf_len, and
> hence the device-supplied bpkt_len, exceed rxbuf_len.  memcpy() then
> reads up to txbuf_len - rxbuf_len bytes past the end of the rxbuf slab
> object.  The over-read bytes are handed back to the i2c layer and on to
> user space through i2c-dev, disclosing adjacent slab memory; with KASAN
> this is reported as a slab-out-of-bounds read.
> 
> The number of bytes actually received is already known: act equals the
> URB actual_length and is bounded by rxbuf_len.  Reject any response
> that claims more payload than was received, mirroring the existing
> "act < sizeof(*bpkt)" check just above.
> 
> The control path (usbio_ctrl_msg()) is not affected: it uses a single
> buffer (ctrlbuf) for both directions, so its analogous copy can never
> leave the allocation.
> 
> Found by code review.  The out-of-bounds read was confirmed under
> AddressSanitizer with a faithful userspace model of usbio_bulk_msg()'s
> receive path (an rxbuf_len-sized buffer, the same act/ibuf_len/bpkt_len
> checks and the memcpy).  A USB raw-gadget + dummy_hcd reproducer is
> also available.
> 
> Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>

Tested-by: Antti Laakso <antti.laakso@linux.intel.com>
