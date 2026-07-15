Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167E37A488;
	Wed, 15 Jul 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100715; cv=none; b=PIMe2P+v2F+7cTG/z8ErrO/x9e1WoyksgEKhslCXLz4Fo0/B8TR4/w2yc/E0fgXH+kaPVnGTPWg/Xb15VrY1IuI4f+9GC3fGDtqxxG+n2nOs66GXCoAExaBKuhZ8Y25NX8j/Yi1xb/InRfGrlQgAw2+p6lXSOxwJxyuUWfR/biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100715; c=relaxed/simple;
	bh=ttq3bswJ9BjVoJk5v8fT97WX6vjQXw/yGOSE6gcg0OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJntPMj4fZCZHvpvIxx13h3Kh69shQ3nBqryMSmE+09uEAQgQsisccKH/yngjsermaz3ldTUG0PqcqO4fAgBvaJI2SaK6/bqFB2PEV0v+y/AdFo1BinoIHzF0BQz9GDKw9P77FJkkf3PY+Mt6q8pu9ThsZP07qedmbBiKMh0sPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQtFsAWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQtFsAWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9801F000E9;
	Wed, 15 Jul 2026 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784100713;
	bh=Wv0DXBGXjlIHKPcNIJc/Uy30l+DaXgiyniMOlGcLge8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQtFsAWd0B58XT4fIaywWdgiMuqPW4uRpcKGq5XuLC6yfnL4fKun9qp31g1kwK/ID
	 Ez/ZmQRTIiAzKznQVq/UK7oHrZsEMZHMQebuLQ+mDBsBK7e8bo8u2F61pnUVXY36ff
	 3SrBW7aErD8BKfRKxdw87/SM6G2bsISS8ZzOJHhmqkCrC4e7O6VXamv2r/hoaIwCe4
	 nk4Pfl1PYmIRnsxUSUcApbaCYzQedFyE96UYugUTDXTnYXgyt8fhxrkTv5m0iuLWQS
	 mmW2/NEFJwuOtD6grKDMvtO4izopWiXYmdxVozLBhHB8TdMFo/k2mfrhesv2fjj9J3
	 izGtFny/GxFPw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wju5v-00000005pwS-1idR;
	Wed, 15 Jul 2026 09:31:51 +0200
Date: Wed, 15 Jul 2026 09:31:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] intel_th: fix MSC output device reference leak
Message-ID: <alc3ZyzBOZa9lDz9@hovoldconsulting.com>
References: <20260715070851.2077965-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715070851.2077965-1-lgs201920130244@gmail.com>

On Wed, Jul 15, 2026 at 03:08:51PM +0800, Guangshuo Li wrote:
> intel_th_output_open() looks up the output device with
> bus_find_device_by_devt(), which returns the device with a reference that
> must be dropped after use.
> 
> commit 95fc36a234da ("intel_th: fix device leak on output open()")
> attempted to drop the reference from intel_th_output_release(). However,
> a successful open replaces file->f_op with the output driver file
> operations before returning, so close runs the output driver release
> callback instead.
> 
> For MSC outputs, close runs intel_th_msc_release(), which only removes
> the per-file iterator and does not drop the device reference taken by
> intel_th_output_open(). Consequently, every successful MSC output open
> leaks one device reference.
> 
> Drop the device reference from intel_th_msc_release(), which is the
> release path actually used for MSC output files. Remove the now-unused
> intel_th_output_release() callback from intel_th_output_fops.
> 
> Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Remove the unused intel_th_output_release() callback as suggested by
>     Johan Hovold.
> 
> v2:
>   - Add Cc stable.
>   - No code changes.

Thanks for catching this.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
