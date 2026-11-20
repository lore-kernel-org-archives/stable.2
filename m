Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178064;
	b=CXnOcsp9o2J1yIITROuuwNQ6Hk5/CUe7qVgqBmwuL33FWRHR39nYPEbh/zf6eOH6vYSK
	 GZ/Ej4SOUgjQDC6+HVnrPhfvaNxUMeq+a6JrtRfXcZE3LG/XLgrSPRp2tM4918zkA8iqb
	 mQ7I4KmeI63VhPjAjU1TrWaY3vOUtXf79SPtsjnvU9Ju/4qts98AszhmFApeezRg1x9jH
	 Eows+4KgW2xicKBDlnV+k7e93UrRuFi8tupFy5Hdlu2TW0VOFZuO/0tU7PBalL2PXmFV0
	 wsFCd/gQQuaEZNftxAgdv0rCNwb2NzEG/+H6Qos/oF5R8EAOD3HaQ61VoQJJSL9pimQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5dtqdfofcnjYHJTgvBsb6ylcv+bNY0oa4DU61wLgsWo=;
	b=qXsZNT0heWtaszg/Xz+U9OxBjlr+JWFuEdS24k/2kp6Xp9pdH8otKqkImVNJo7kb928A
	 qX+C1rPyYeuJ3uWPleUyrJsVyIk/BVAQkpQFOLJ/ltzl5LUguxpVzxEw5LCVlCx+lLX0B
	 ZM45m4NfL41hKjAdAqMC5Odu2IIZYWEy/GaMpjCPiHbThxbI9XRgxA+Fb7o18TrcFlCCC
	 GhGuYqjf33dMmwubHx0XNK0qai9Vw87CZ5GPbrTeNoGL/EXwp0GKHrGEtc/pm9lTlQ4qk
	 1bRvpGfjXRz4tjKA7ft28MN9IOZeWaMt5sdwNXnURwMiEh9B9hMFiEwXJFTyKR3K9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b00ehjRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6D606A32A;
	Fri, 20 Nov 2026 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b00ehjRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3681F000CA;
	Fri, 20 Nov 2026 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795178063;
	bh=5dtqdfofcnjYHJTgvBsb6ylcv+bNY0oa4DU61wLgsWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b00ehjRmu92QlDIqeq18dE3lDMZRB/JBEL9MPe86VIX7TRG+X0ZgtpUO+rQLyyqTG
	 55CDMguuZZjNJbRt5rh5GTpkHhxde6XdraDSdyWXbaSdZD7/SoBfCfIxN6fsL6PRJZ
	 Eui4hHVPRDM+cnZlahZ17K+3xLfRAmn6bocyEiiE=
Date: Fri, 20 Nov 2026 13:34:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saranya R <saranya.r@oss.qualcomm.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Fix spurious suspend event during
 HS link training
Message-ID: <2026112002-sapling-nail-396f@gregkh>
References: <20260903110947.2761354-1-saranya.r@oss.qualcomm.com>
 <20260907101236.1543438-1-saranya.r@oss.qualcomm.com>
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
In-Reply-To: <20260907101236.1543438-1-saranya.r@oss.qualcomm.com>

On Mon, Sep 07, 2026 at 03:42:36PM +0530, Saranya R wrote:
> During HS link training, a spurious DWC3_DEVICE_EVENT_SUSPEND carrying
> link state U3 is fired before CONNECT_DONE completes enumeration. At
> this point gadget->speed is USB_SPEED_UNKNOWN since CONNECT_DONE has
> not yet run. Calling dwc3_gadget_suspend_interrupt() here triggers an
> unwanted composite_suspend, causing the charger framework to drop
> current to 2mA and then ramp back to 500mA on every USB connection.
> 
> Fix this by skipping suspend event processing when gadget->speed is
> USB_SPEED_UNKNOWN. This precisely targets the pre-enumeration window
> without affecting genuine suspend events: a real suspend at ADDRESS
> state (required for BC1.2 compliance) only arrives after CONNECT_DONE
> sets gadget->speed to the negotiated speed, so gadget->speed is no
> longer UNKNOWN at that point.
> 
> Signed-off-by: Saranya R <saranya.r@oss.qualcomm.com>
> ---
> 
> v2: remove Fixes tag and add cc stable

cc: stable was NOT added here.

> This issue observed on 6.12 kernel.

Please test a modern kernel version.

thanks,

greg k-h
