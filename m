Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794553151;
	b=i0guBtF6t6G8TwVrzRBkmKOUEMkLM0QfV8YgVIwMg6Fc19W9PHdx3+hsVTm18lF+Rx1Q
	 cQbmAe2NqOi9ZeXdK/P+ObHb07hju8kzYz8sKWhYl20AM7gct+YlBflRykuVQFbrrQ6XH
	 ZAYYqbOQNL9xzkv+chiKDnPA4S6KofkTCQzFR0Nqqpzpgt9KlavXdGNPdMYE2BCHyIHRo
	 uK9D55XqG/W1VsXWCacciDkXUDJFj1WpriSwhT8dNk/yxyFkf8xbru1pklRabKSccbR8z
	 cMRUAhjQgPEoE4HJLFSyccBNL7BLlBSZZzU+52rVD82wCB8WHEmsM1RRrdzCcQsD4aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qeIzGejgUnOZAJR+NUnKQWT+JLX+S3iStcqz+L1EeNc=;
	b=Iva4VHa+MYdTFYqupiMkR3rPavHf4oHs0DJ6135XUOBGCPPLP11vosJQxqMJ39lH1jrv
	 XQhXQhHlqlVkjUedeYL+Kmacm3j/CHMdHiX7DpE1ldiWiDp0uLaXa0ArGSinfX2Wm+h2t
	 8rsd0r7PY99Q7c7WBxXZwBB/GByxJJa3geReIjd2sYMmD1FknQjhP6I9LlwJeuIYKH/EO
	 qgMdQXKiuGG6XslIOopwt0HjwQ5PGp/FfcH7uINEOvvzD86BYDAOCY2D04hsy7lsMA1IQ
	 o0CBuOV0u10NAoVGxawGI5cQv+viQ4RCko4F/25DGM2EZiyT+NE2EHbiP5H2BD64ZLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=yv8UBWw8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6E606A33A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD6E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=yv8UBWw8
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50a4a2132cso12241866b.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794553149; cv=none;
        d=google.com; s=arc-20260327;
        b=a1GWQfloik0Tt7MEaIrwwjup0QUvgP/bG3B2Ibp1GFbI223BI4bja/9VTmXijRiGuo
         EWnq4ISgKDUyEswe0uejrjjtw6I+4H59BQoWRV7+QnK6U7XefolmIwacPDYPc/TKQQow
         RtU65P1QHXl93CpcuD/myzKYfVJlkzF1++mcC068Z/UzpggIsaPZjPvRFAKogasj5+hq
         BrXjPLB1NzjZ3RhVpASNQz5w2oF7SDeBlZSzmLs8jTgVa2ftcGHx353/zd5kdB2ZHAY1
         HOnbd3jguNPxHTiwJ3Fy5wU/6lRBF92dHlKRLDJX6SpinE/sdmGfqtft+KX37KYjI5CO
         YG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qeIzGejgUnOZAJR+NUnKQWT+JLX+S3iStcqz+L1EeNc=;
        fh=BUYhOqZvhjo1zqtjHNv9rdHUdunvvyttk0uDcwlEOlw=;
        b=elNVGLx7Q4o9jWeVviVvxVHUNrYxyeNwyUjDaKSgclhCaQzYBnzDri+AZ6N0g5JYSm
         IMN3O+lAuClbBAa/GdQMWHfHfWxxRo0qi3m1MA3NHUyZ+FT/D0dLT4ZFL+DyHTaPHBaN
         5dMp2+pFqW+XoCBhr32IaqNnqGtyPoQSB27iUDanieEW9vaSvVdzPObIqTS4sbSm/4hx
         WbY6F22HM525snQPNX6x+dG4FiM9KOC31RJi6eiAISh/BM4qxmB30hkn5xHPf9s+pwk+
         BNC5gEyUmzqjtNLrEq2LIumRPNQXOTlHo6Fu/RHV5487jF31pdIBuI4Q0mQK1H9l1zM/
         aKQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794553149; x=1795157949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qeIzGejgUnOZAJR+NUnKQWT+JLX+S3iStcqz+L1EeNc=;
        b=yv8UBWw8+3wCTR92+nxE0nmLMArTGzE6Ezdymo6t2L6PVidgmuf99L/gf9wApGZVLF
         MujXKE7gtXTDvh/VTttvmrTZVmwUkWND5tw0R+mmAaHlSi6KAQNCjzEoE8a98Adih5zg
         OR25M5gaZD3H6FazwL5UKFl/Krjsm2NlIkoP9B5noXVIdYZ4n154vlYzpYg23HvcakLH
         jisUu+HO8fIGQi3l2MNGLeEjhz74mAZbrMh3TwYvP4ji8KAQUZMsWof7/1w9QRXt6fdi
         s103+8hy9Ke58DLD8w2P+diercjuAwQqHcvCZdZCvfz2uOq1RgnghI0ljrEgpUbJ/K+w
         gBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794553149; x=1795157949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeIzGejgUnOZAJR+NUnKQWT+JLX+S3iStcqz+L1EeNc=;
        b=zVa6k6jLL7FPiUhyiyjnazLo6RVVXoHg5kuB96yTk3V/VhzDn+3CDpek5t0ipgZRxj
         TAfpB7AuQetEE3iSWbu5YZL7ptmfg2HpdL6IWR9o6h4PF/b8V3uBolrrjm+GA+ASnwNd
         QC9iXQmRoiT74m4wmNUK1hcMrTESZNo6LmVkoBCbJP2F+1bON1IFfX4v8Z5Wmmt9l4tS
         PQ8fbEoEbUJ9xmhaBUISybNfnkEH/E3pCPz5r7q0UXITLz3/wYZjcSxa3FmGt6XSUXf/
         MXCj9gdWY6wwTI/eRf7Zjee53AlOWyFW5uAH320g7Opg4ofL75M8mMy0dE+CmHZcp2y3
         1yPA==
X-Forwarded-Encrypted: i=1; AL+hErGhia22Z9gEjj0adACUJ5BUSCMme5Snh0Vr/aIZBj2PMMB0j9Bb9BkNSQE6rTazv+iPw392pPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AhZOgeYnPo9jXe/OHUsLAN4MfeEKKuAeWEP1r/5rP27VnCavi
	NumZT05NXV/gJ8P/atbE/4jmZBvhzvD1gTd8nyNGcO7AIY048z+kM4qGFuMrLgwwllhs1kOxV0n
	1Qi/0911UDahbkkLkumtHn4AUzWBxfPkWDpxC79Plqw==
X-Gm-Gg: AYBFou3DCyobkknhAXi1iHbsFsOAFgHG8QkC6kPmFQ3nPfOmJ8SDPkK1X301u6h/uEb
	uz10k6rsGBr49ygNSbToh8DXKPD9nzpvTWwYTzCKmL3KwlJxCVEhfU0q5rHwXIFVXiU3yUhl79D
	MCH6t1Wy9B6HxyyTuDbk1tTIypU0EtTJ9JdJPHDZnNdV38O7O6sw2hVJPaQE9lcuWKr+OFNc4Lw
	vvMf826vZ4kfq7DwxuUqB+enUyk0KV/c1iD6q1dm43JNM98OZ5p/RA9BnhixCa0ZsaWOqvYKen0
	XgpcrQrm+rzxvpLHw+Khdn/zaNxNMqXuds1GpJHiX1XiTTXqjYnHtCNiQlmXk/yUFy5UKAYLdUZ
	sG4fF/U9lGA/ZPzQ4y+Y3sqUWD9lSHHivyPrb8SfW4HgHAfggaRrYJwAPMk44O7ZSufLj
X-Received: by 2002:a17:907:96ac:b0:c29:3c97:c994 with SMTP id
 a640c23a62f3a-c50963bd677mr113775466b.35.1794553149505; Thu, 12 Nov 2026
 22:59:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-udc-connect-v1-1-03c73259642b@flipper.net> <57e83596-03c7-4406-b01c-db2ad2298413@rowland.harvard.edu>
In-Reply-To: <57e83596-03c7-4406-b01c-db2ad2298413@rowland.harvard.edu>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 10:58:58 +0400
X-Gm-Features: AclHuK9vJOW-Z7MYq2yRXHeCiiCDHnszsRMvz5_5l2FLX1hDAYnqlpu_XsOjoZY
Message-ID: <CAKTNdwHb4ahziiFLDCCWsi9_65toGx=HTkvaB7bv3vhqzuCc6w@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Clear a pending connection when
 starting the UDC
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Neill Kapron <nkapron@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Fri, Nov 13, 2026 at 7:36=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Thu, Nov 12, 2026 at 06:31:35PM +0400, Alexey Charkov wrote:
> > Since commit 62911bc82b03 ("usb: gadget: udc: skip pullup() if already
> > connected"), usb_gadget_connect_locked() returns early when
> > gadget->connected is set. A connection requested while the UDC is
> > stopped sets that flag too, without enabling the pullup. A later
> > gadget_bind_driver() or soft_connect "connect" then finds it set and
> > never enables the pullup, so the host doesn't see the gadget until it i=
s
> > unbound and bound again.
> >
> > This happens whenever a UDC driver reports VBUS through
> > usb_udc_vbus_handler() while no gadget driver is bound, e.g. when a
> > Type-C port controller switches the controller to the device role at
> > boot, seconds before userspace binds a configfs gadget.
> >
> > The pullup is never enabled while the UDC is stopped, so clear
> > gadget->connected once it starts. The bind connects according to the
> > VBUS state that the core tracks anyway, and a function that deactivates
> > the gadget during bind still has the connection recorded for
> > usb_gadget_activate().
>
> This is good but it doesn't go far enough.
>
> The UDC core has gone a little overboard in the ways it allows gadgets
> to connect to or disconnect from the host.  Along with the automatic
> actions associated with bind and unbind, there's vbus_event_work(),
> usb_gadget_{de}activate(), and soft_connect_store().  In some respects
> these interfaces act at cross purposes.
>
> (There's also usb_gadget_{dis}connect().  Those two routines seem to be
> EXPORTed solely for the benefit of
> drivers/power/supply/isp1704_charger.c -- is this really a good idea?)
>
> In addition, there's a good case to be made that soft_connect_store()
> should rely entirely on udc->connect_lock, not on
> device_lock(&udc->gadget->dev), and it should check
> udc->allow_connect instead of udc->driver, and it should not
> call usb_gadget_udc_start_locked() or usb_gadget_udc_stop_locked().
>
> And of course, as you implied but didn't state explicitly,
> gadget->connected is being used for two different purposes: to indicate
> the current connection state, and to indicate whether a connection
> should be started when it becomes possible to do so.  There should be a
> separate variable -- or none at all -- to handle this secondary purpose.

Thanks a lot for looking into this. I'm happy to look into a broader
refactor and submit it separately; however, I believe this immediate
targeted fix for a recent regression would be good to merge
regardless. Without this patch, the gadget doesn't come up at boot for
me at all, and a larger refactor would require multiple review rounds.

> The whole situation needs to be straightened out.  I think the following
> approach makes sense:
>
>     1.  Connecting is never allowed if no driver is bound, because
>         in that condition the gadget can't do anything.
>
>     2.  Connecting is not allowed if Vbus power isn't present, because
>         it would violate the USB spec.
>
>     3.  Connecting is not allowed if the gadget driver has
>         deactivated the gadget.  Note that the activation setting has
>         to be forgotten when the gadget driver unbinds, since it is
>         driver-specific.
>
>     4.  soft_connect_store() should be able to force a disconnect,
>         but it shouldn't be able to override 1 - 3 by forcing a
>         connect.
>
>     5.  Whenever the state changes, the gadget should try to connect
>         if not prevented from doing so by 1 - 4.
>
> In addition, the gadget should be started when it binds to a driver and
> stopped when it unbinds, with no changes at any other times.  (Read the
> kerneldoc for usb_gadget_udc_stop_locked() to see why.)
>
> And the proper way to test whether none of conditions 1 - 3 apply should
> be to check udc->allow_connect while holding udc->connect_lock.  All the
> relevant routines should maintain this invariant, perhaps by calling a
> subroutine to set udc->allow_connect whenever the state changes.
>
> Have I left anything out?
>
> We do a lot of this already, but not all of it.  How would you like to
> implement this scheme fully?

Let me give it a try and send an RFC series.

Best regards,
Alexey
