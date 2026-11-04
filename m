Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811596;
	b=mx+FlfVV4i08MB9v+EuRM+ByFwOzCnXzF+xQh09r/HraluN3j7TwSg4TdqUODReI/t3k
	 75045AiWc0qjwEDWDUzKS2i4Jl4eGRJMjxdVL9RbnTNLBW7Re9MrfS2a1YC71yhsFG+5f
	 ARCvDlXgD33A6ym2KT+m0KR7X5SFe/vHfatcDaOYwgOhoYqzrGO3nUAW5oj3OojJsRxZv
	 70Jhjz4XTDEJqcB3kGPaZL7IRKzko0JP1X3c+hT+3KpRi27rDQ1N+S2j4/ByoQdI7fPsD
	 jqVh18zMD3Y3y0gaeAjld/nbM2V3+G1fAJ6X4q+H5ovEJNg2E+dzq2XAvsD9so1kGKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3nBmuFFvpK9ZuJMVGhj4Fxmt/qwgnA7lrzzghhGHOis=;
	b=K5qLrO0RIwIxgpTO0hUmJ5UQndbH22w3j94IYdqUJZius0JkK1uJpbjlakrob+t6kWfy
	 jU/bmhJcWqtpKnzKm4MKQLodeksL0hv7B3JH7IoGoxD0mQ4k4BIFwMfAlhDaVXRotUDJw
	 KZVN6lcsc1wRXz/U89XSGfs+k3hT/jQy8LdUnL6ff+RY9QQgdVcF8mkWct143bf9OyN7Z
	 GItS6RneAcjHrrCUg8V4e5sIfArXU7ikzWnvwyPlIYRG6rWwfm/oDTj0nXM+63FB13faW
	 ZWuwhUZtd8kgfZHWmGaV4HUwXZt07A1N5bpQs7W3zjNsMVB0Rp8satrqe0TNFBh4sJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCMplPqy;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37A606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F37A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCMplPqy
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490f38e9688so165093f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811594; x=1794416394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nBmuFFvpK9ZuJMVGhj4Fxmt/qwgnA7lrzzghhGHOis=;
        b=aCMplPqypvZ02Qbsm7VMD3bTNFEpqoSx1cyTAXBIt7KNVO+q2nAmW/IKy2PuDVXETR
         WHBjMbNP+1l3BOQE+u2M8lp5zAPtu7PPTazCS0uyJ+nO1RPAr+XWi9bxVx5lKiMH4ywd
         +Cl4vFbEHFnZywwCIRYqrtTYmdU3bnh3mCcDhDlo/sMJ/pzojDkG8mZuyBddOCPbEs1/
         B3cj95SagdKjtw5Jj59Uvg7guAwnSBRBknmG6MIYCZSgKK+HbdEsEBaxlK9kZqFlOIq4
         kY8I5lmO6Lasd2+R8YN3f6/WKzvP6Z2+bgKt+5y4k8aAkZZRNWr6BtFkMTL64VVzFi+q
         GOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811594; x=1794416394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nBmuFFvpK9ZuJMVGhj4Fxmt/qwgnA7lrzzghhGHOis=;
        b=se5zP9T1m501wErm5woxcJleUffU0rp6uYA4l/tInusKOTPaswcuwWQTzEtgVQ78HR
         EYe9pDkA3pvhPJLSwsv32CX+bT05033bUC7nbH2zHwHMVHC8lz8nGk0Q/h7AwL0ML1fP
         /ZRlSxntC8sJ27nu1ilb18d4IKpB7YAGwxsWC2BuUnIutDaVbyz6fNBg1U5oBSaz+ZZq
         idu2zSWllyZGO/fiBxGckVxRtlBFWtBAUk98D6oyqploH5sEppV4FxW8Tuk9OiP+jBGX
         TX545h9Y1IZsYUMFyZpfz6hokRTfjIA+MvIxs+LsmoLIuwuAVZNp1oQgubIltIh94wGQ
         ZCow==
X-Forwarded-Encrypted: i=1; AKwUvBxaSJpy9xFQi2YarJbISuboYODQP9NfcOohy4+zh8+7BXN2wq2zXJwONenIpVnYAYx3qBJzbFo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cK9atOEFQAqJrUtVq+7N55iWt3MXhT9EbdI+5LdDjE4m6nnNh
	AdFWccBrRqPFKAD9U+ZkRnF0lNhdGgmoHRINXn63R9RrOQ+p/492VK4K
X-Gm-Gg: AYBFou3ioVIlze9lvk/ns+cva5g7mjMYuW7hnUpAEQtFmk+NeNNIRs1RiXZFAo0ninA
	JtVLd5binbo63HzjSqWicGgJRq4F3wDig+sdlzkQI2nYqEOH7VuZ3I7wHok0M+9O9sxM9RstJyN
	ZeGmYOGNUbTvf/NZddQ8IMyB0vQGALYyeDmjtDqFdmWv+b/9jEsT6RwlZKiXTZcsONfSkYiM4gn
	+X/BIRaWF1bA8U5FeveGCgLf21a7q+GXlmBn/9zCAP7eyHCVTIE2eDkbMiT0Myb0gpd9hxIYpj0
	gshJSYodqEg8iA1lzOFJZXbZcW1mYbThyQsccaN0wlIPg5Fi28T6X57INlgiFgVgnAgw49+z1dY
	+xpMXBHs5s136qblb12hqkJ9XqijfUFqM5RetcQo/Wg8NR7zb9Pv4HNqKOml8OaGiHhFLrH8Msy
	9dGC0A5cm76aA4UYORcIKdGkshDGDVp3mRKVD/KS5qMAicl4tq+4mtNsLcPQJeWPyNAuGcpAEjG
	C+0Li7LOZArfijBZhbBrDNBFShFs8VyJegj8IhumcewKoqTVRIaaIv3I/fb0llWRak70OXFGbEL
	l/m9eDPhZMsRGnv9b20GJiMaVmdk2d/+DUQ2rgSZZ3LFynUK0AHO/VmM+oyYog==
X-Received: by 2002:a05:6000:4804:b0:48e:22fd:1ea3 with SMTP id ffacd0b85a97d-4911aa56dc1mr33104f8f.28.1793811593929;
        Wed, 04 Nov 2026 08:59:53 -0800 (PST)
Received: from foxbook (bfg124.neoplus.adsl.tpnet.pl. [83.28.44.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm4769440f8f.49.2026.11.04.08.59.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Nov 2026 08:59:53 -0800 (PST)
Date: Wed, 4 Nov 2026 17:59:49 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen
 <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
Message-ID: <20261104175949.71804650.michal.pecio@gmail.com>
In-Reply-To: <b8ea2f8f-ff9e-4cc6-853b-114fe51173e6@rowland.harvard.edu>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
	<20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
	<b8ea2f8f-ff9e-4cc6-853b-114fe51173e6@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Nov 2026 10:02:48 -0500, Alan Stern wrote:
> On Wed, Nov 04, 2026 at 11:56:37AM +0800, YuanZhe Liu wrote:
> > The port suspend is a hub class SET_FEATURE(PORT_SUSPEND) sent from
> > userspace through usbfs, and the teardown is userspace releasing the
> > hub driver interface, which quiesces the hub and disconnects every
> > child under it.  Neither side takes a per-device reference, and the
> > usbfs control request is not serialized against the hub driver being
> > unbound.  That is also why xhci_bus_suspend() 100 ms after a disconnect
> > looks fine: this is a different entry into xhci_stop_device().
> > 
> > CLEAR_FEATURE(PORT_SUSPEND) is the resume direction: in
> > xhci_hub_control() it ends in xhci_ring_device(), so it cannot produce
> > this trace.  
> 
> > The patch makes xhci_stop_device() re-read xhci->devs[] and the "device
> > is going away" marker under xhci->lock, and give up with -ENODEV
> > instead of touching a device that xhci_free_dev() has already detached.
> > For that check to mean anything, xhci_free_dev() has to clear
> > virt_dev->udev under the same lock, which is the second hunk.
> > 
> > If you think the mutual exclusion belongs higher up instead - do not
> > let usbfs suspend a port while the hub is being unbound - I am happy to
> > work on that; from your message it sounds like you would prefer the fix
> > there.  
> 
> Don't know about Michal, but _I_ think the problem should be solved 
> higher up in the stack.

Perhaps in userspace? Or is it expected that root hubs (or other hubs)
receive random and conflicting requests through USBFS?

Do we know that the device whose port is being suspended has been
quiesced? Is its driver even aware of anything?

What I find more disturbing is the existing protection from this race
added by 88716a93766b - it looks like core was triggering this too.
I found this usb_disconnect() code suspicious:

        if (port_dev && test_and_clear_bit(port1, hub->child_usage_bits))
                pm_runtime_put(&port_dev->dev);

        msleep(150);		// my addition

        hub_free_dev(udev);	// this drops xHCI device state

        put_device(&udev->dev);

but it seems that even with the sleep, the bus only gets suspended
after put_device(). So IDK how that panic was possible in 2016.

> It sounds like the sort of race that could  affect any HCD, not just
> xhci-hcd.

xhci-hcd is affected because it tracks association between devices
and ports and accesses devices on port suspend. IDK if others do.

xhci-hcd shouldn't even need to do this, becaues it's pointless if
devices behind the port have already had their URBs unlinked. Case in
point, nobody noticed it's only done to the immediate child :)

I would have sent a patch to nuke xhci_stop_device() altogether, if
there weren't known cases where core leaves URBs on suspended ports.
That stuff should probably be fixed, it caused problems before.

I recall the main blocker being that core wants to setup wakeups in
the same call which puts ports to suspend, so it cannot reject ep0
URBs before doing this call.

Regards,
Michal
