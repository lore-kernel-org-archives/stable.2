Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B9280331;
	Wed, 19 Aug 2026 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118788; cv=none; b=SX2cutHnOvn+rTcgR1fQHK6CxWg5KcYtTUCCCzs+YN5lzNCeZQozOvA/66AF5ZYCPfYmeXa9PzchRXPaStixH+GQ1odh5N6UyXg83nZrSg7hLq6o4qZBoIXrsiTKwB5AyW3YSp4MdyXGUTTmW/LvqlM12sBXI+k4aOyxaWsJJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118788; c=relaxed/simple;
	bh=7NCorM85s5uOWK0qhGsIkhe7FHcyLABs1/v84F6m2nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeYTlY7qNEucLktkX3FKeks5Hrjh7hRxIza6o/QTVqT4u8RbX0JB8aXDTikMT7aMGHYjcXTJu8CKbLTmmhSl9ciNDXszS9vBFMfiCCAmGOod7CUbslyPP9PLh80q3+eLYMnQKBU8ye3giuGd3V0lrDtotJW1HMXA4TCH/cuj8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oZTYiqAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvTmeDa8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oZTYiqAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvTmeDa8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 168A9EC0121;
	Wed, 19 Aug 2026 01:53:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Aug 2026 01:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787118786; x=1787205186; bh=aWQcPY8SSz
	mvyfwsbCuMVXWmQInVNuwV6kXCGkYp0iM=; b=oZTYiqATmV+8lmRNCxWfCAvTP7
	HV98X8Zum+1JlHWzwHp7jDEZXF+KNdfLGNMP9QrDacOkln4Yhk6q+RdIyjeDb565
	hQ8Sq2HMPZLbmUvCYyGttceBsHVgkf65dqfpLtZbcstLNipTDALSpw64qgsWNruW
	MsRIckDp42ZQXyU4CbARVhaFVOqSEly8XtHtwB93vHJYrQbkPfqLRndM0BqqiUIo
	QLo37g22VwP08eU2zcZCMXPKep9py6tKkXy7+3FN3tKUS3s5UxVeZjPeNEgoGsvV
	biQVAVEnhNrwyjAE2YzEQdKgn5elBfmhF+n4WRVaiSGnRtssHanvAHv6Plrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787118786; x=1787205186; bh=aWQcPY8SSzmvyfwsbCuMVXWmQInVNuwV6kX
	CGkYp0iM=; b=gvTmeDa8bZudI9YAwCxH5zbLNrnBKdMiHBeVVuJWkp2CVhu7+Xy
	4G7Jhg07m2CXo3XXqM60GLSGUp/UkgWnKPwBOZmlpT0XZ6Ro8oz/FIiDZK3yKhpo
	rvAOdRQQLsfrUBm4oyS83tGNs49+pD5W7n0AGyCrNyXHzcnAABe/IF1nrL7aTtxS
	nB6aF1kXH6LAvBtfkQQ1wNCs0FEbhrqNCc6M0w5Agz7IQdmyk3CJfx80V03EI220
	PsPnYFkH6dgEuqdlvVWyXED2SNZhjXO9K9qGNj7DjZdjknfdy2fRt6d6/2d47oCM
	APpNynC/HFY51UC5o9kuOwR15FaDvYgTkkg==
X-ME-Sender: <xms:wUSFamLLAQKuo6_-1EbaXCpObwMSaFEHClJRB8HLQCJtBvEEKPaozw>
    <xme:wUSFakgjQERi93uShrO0PC5kpkLQdFWFUVNRGh-WB8y0AI3bktvbH2EWGT2-0Sa5j
    ZQYTxdAOcbplSw4878EdqdhwJUqIlPvHrYBgEsdHTx3jSRYMw>
X-ME-Received: <xmr:wUSFai_XUSKhYUhY25nfdmSMddZtvXelN_BnMDW5ZDyduWiZ9QoRwFgUwnMN4lAs3gWoI0-DDhFpmlBsrXXubjh-7okOUJ5LgIoX8sRQYQg>
X-ME-Proxy-Cause: dmFkZTE73ujevzT5sJ7LWdSTnT744BB1XZ6a06oJQvdB5QcdcqtsTo6nzyIAzPmPU9ikbV
    Z5bNYq1Ru+3Qs8JhgICyHwyQE5/qclTF0l/EmNIN2F4H/v6Hum+A0AfArmDOsDMUUDdepm
    Doljx63ypcwCmuM2g4QWA1InMMmTu/goSY0QgkGfga04bL8bwYyX8EbeLqaoy6I/bHFPdQ
    MKqnyrzs+LJ2xudxEf3TNdOC02TL0tNebcNHBiwudNao54iYvjtinhp+mKYTzauCCsxE+s
    m9FII7/aVEznL13gI5DOarv9YR7JJedFtH+XD63Gz36pH0415er9f8+8sfCseQ83dCjTZs
    dcFDWaOOSD6AflSFGyGc+4qWQk6f+KOFG6jqHDOgbXAMMhOKlMGj8Nc903KeU54jW0M2TO
    mcPqrEd8crQ7NNgelXprpfj2NPnb5KbggKFu9kw3kTUleJwZF6qcoLKCMlm4qTkqReg9Jn
    Gjh2v1m82q1RBHIZCsXqhgKD4sX16mfNsfrG31nHOzenoGX9XxAKpa9jLAFBareXKoyxBl
    Wdc0fIjv7VSQ0hJzocgEIIdwUIjK/5NklGEdi9XFDZpsdN5Hk2FKFIPFWw8yqk7LUbHNem
    f/xFRnkXkov8YEkDCbJUb+AL1W5k0hNHt9vapD5dsw1Yy/MtGuVBTx80L5aw
X-ME-Proxy: <xmx:wUSFapN47qo02jGTiTjnWUj5t47UP9lPi9PxhfqGeJUmzmvm2Ubbzw>
    <xmx:wUSFamBzS0IHcp4PjK1-fBYoZPMLtIZuY_TwLvz3WFWabc1zTFifLg>
    <xmx:wUSFatOr8q3E-R14R5UVUkht4g5Asbb4mo3sFLAQ0KjEbAOF85uF7g>
    <xmx:wUSFatedJPEhs14CPm84Eb9tElgfzjoTSK_2AmazNq2PJ6FywnSKtQ>
    <xmx:wkSFag7t87anTSIuPNLgAik7fqu0iyeWD3-bQmzALUw7Of0OVkY2_FXy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 01:53:04 -0400 (EDT)
Date: Wed, 19 Aug 2026 07:52:56 +0200
From: Greg KH <greg@kroah.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] HID: core: fix device cleanup on allocation failure
Message-ID: <2026081930-nutlike-jalapeno-1910@gregkh>
References: <20260819013149.889913-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819013149.889913-1-tristmd@gmail.com>

On Wed, Aug 19, 2026 at 01:31:49AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> hid_allocate_device() calls hid_destroy_device() in its error path when
> hid_bpf_device_init() fails.  hid_destroy_device() in turn calls
> hid_bpf_destroy_device() which invokes synchronize_srcu() and
> cleanup_srcu_struct() on the SRCU structure.  However, at this point
> init_srcu_struct() has not been called (or has failed), so the SRCU
> internal pointers are all zeroed from kzalloc.  Dereferencing them
> causes a general protection fault:
> 
>   general protection fault in check_init_srcu_struct
>   KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
>   Call Trace:
>    synchronize_srcu+0x1c/0x2b0
>    hid_bpf_destroy_device+0x64/0x90
>    hid_destroy_device+0x29/0x240
>    hid_allocate_device+0x420/0x4e0
>    uhid_dev_create2+0x161/0x890
> 
> Fix this by replacing hid_destroy_device() with put_device() in the
> error path.  At this point in hid_allocate_device(), the device has
> been initialized (device_initialize) but not yet added (device_add),
> so put_device() is the correct cleanup call.  It triggers the release
> callback which frees the hid_device without attempting to clean up
> resources that were never set up.
> 
> Found by syzkaller on Ubuntu 6.14.11 KASAN.
> 
> Fixes: 6cd735f0e57a ("HID: bpf: protect HID-BPF prog_list access by a SRCU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/hid/hid-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cf123347a2af7..9534de5317783 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -3060,7 +3060,12 @@ struct hid_device *hid_allocate_device(void)
>  	return hdev;
>  
>  out_err:
> -	hid_destroy_device(hdev);
> +	/*
> +	 * hid_destroy_device() cannot be used here because
> +	 * hid_bpf_device_init() failed and the SRCU struct was never
> +	 * initialized.  Release the device directly.

That should be in the changelog, not in the code, as it can, and will,
change over time.

thanks,

greg k-h
