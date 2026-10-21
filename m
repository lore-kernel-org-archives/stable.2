Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568554;
	b=ZVKQ5jAG8iq1oqqgHM2Ut43S/NaZ/eNHn6y1CgKxepPI4iEJOdCkUcDe7+I2EMDe8pIN
	 Y/6B1pfXBz8qfVIAf2IhxIRcllgPZArex7eHANJEW0P5I99yHZkC+J+AYsX00X1SzXTu2
	 8DVJCZ3uFsQaN327+6W0JSkISqH83GL3eeZm1gKpq3gntz316fIE6LZJR/k+TwBZfc8Am
	 Po6xjyR4AjZPrzGZGPSCSjyIrIzZmY9LB7/jYmj3ozB6V4MziwH7IWvsY73vTW/UFzkhB
	 B2obtIEMhn6PgdHvhFQR126TGDsO+H/c2cdU4mXB3+QoX0OIY8/rtLctv1019X2h+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568554;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SrMJu/tPUiSUut5zE490wX9ihBWXDV4lmTuNbxq60bg=;
	b=maYaxRykfn+/PEhd7nipLJsPxspKtG/lpbC5PKQCt7y6ROa307ypoH5wBU8mAEGUEJut
	 0k56OXKM+YXgJoOF26cK0vA1iK8OCnwner8qOAACO4z2eo7dT3acx06vqz5iqxaLFUFRw
	 pF5OT8e0jb6RlnF0HSaZ+zY3RkUSCGDyoN1V566UReHxvHRH+0YBw7eX2cEfsHq3FJWwY
	 JMa2bAW98Wu9Yi3LplpB31pzRYgKmng2lSodFQtHzzErieyaG7MDm2YFzQrCO0aWd7y80
	 9W5Ww4ueYYP11M9TVmJ4X2vbuYE8BDXYYxP6dbw6+SCEN2jlq10GyTitA41qnQ9xJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=BXZG+It6;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C6606A319;
	Wed, 21 Oct 2026 07:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 888C6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=BXZG+It6
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1262DA012B;
	Wed, 21 Oct 2026 09:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792568550; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SrMJu/tPUiSUut5zE490wX9ihBWXDV4lmTuNbxq60bg=;
	b=BXZG+It6CtWbR7Obz+4TgjB+ZwtyvWP/bZ/K4akuDDZdysVL3gWs/GNx8uc92oQU56UJZB
	hIPbTMZUSIAts9v27IKLJECoGZs6mZpJbV5Ic8w0mf5GO1TkMDsJj0vOSsrqp6dmo/LH5Y
	FY0WmrPlzv2cUher+V0Z/kNSFc7Xz1IzX+e82rSvfUp+X2l1UF3wJXsgHTyWEBTVYthYzf
	14CHKyp+ZSVPs8wM8PKX+oVWqG3Y5OppvovknOz+WYECCxgYMujkseVdEUC18+cN4jGAn2
	5TEYCuf5w8X8aOtgxIZBzaa2LdfPZBy2QzKzvFxYqCBf7w0l4oQSjPtSXyWROw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 09:42:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <20261021005654.23517441.michal.pecio@gmail.com>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
 <20261021005654.23517441.michal.pecio@gmail.com>
Message-ID: <5f7be4fcf5cb8c3b60e8acc5312d9980@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Michal

On 21.10.2026 00:56, Michal Pecio wrote:
> [...]

>> So this looks like the better fix. How would we want it gated, a USB
>> core quirk flag per device, or per controller?
> 
> [Cc Mathias]
> 
> Good question. Do you need this fixed in stable?

Would be nice, as I've also seen other reports of this issue with
Rigol / Siglent test equipment. Otherwise I can carry it for a while
in our tree.

> 
> Depending on regression risk maybe we could get away with no quirk
> flag at all. That's what ehci and dwc2 seem to do, which means that
> hopefully no device specifies illegal packet size while using 512.

They do. dwc2 just takes usb_endpoint_maxp() as is, and ehci even does
it on purpose, see qh_make():

         /* The USB spec says that high speed bulk endpoints
          * always use 512 byte maxpacket.  But some device
          * vendors decided to ignore that, and MSFT is happy
          * to help them do so.  So now people expect to use
          * such nonconformant devices with Linux too; sigh.
          */

So I'd suspect that Windows takes it as is too.

> 
> Other possible risk is some device doesn't truly care (no transfer
> is ever large enough to matter) and works with 512, but setting its
> requested packet size (needlessly) breaks some xHCI controller.
> 
> Such devices seem not very likely to exist, though more likely than
> the former kind, so I will try to test whether such xHCI breakage is
> possible. Preliminary results are encouraging: although several of
> my HCs reject packet size of 1024 or corrupt data, 64 is accepted by
> all but one. I haven't checked for corruption yet.

Thanks for testing!

> 
> I will also see if I can figure out what Windows does in such case,
> because doing the same thing as Windows may be the safest bet.

Sounds good to me. Doing the same as ehci/dwc2 (and maybe Windows)
feels like the cleanest option. Happy to test whatever you come up
with on BCM2711 and RP1 xHCI with the three devices here.

I can also check on Windows, but I'll need to look up how, as I'm not
really familiar with Windows internals anymore.

Given Guido's reply and the USBTMC spec (the host "should not send a
zero-length packet" if the last payload is wMaxPacketSize), I'll drop
the usbtmc series and work around the Rigol ZLP issue in our test
software instead.

>> >> The Rigols still have one issue I can't work around. They split
>> >> replies over 500 bytes into several transfers, and a follow-on
>> >> transfer that ends exactly on a packet boundary never arrives. Raw
>> >> libusb shows the same, so I guess it's another firmware bug. Should
>> >> be fine for most use cases though.
>> >
>> > What exactly is the sequence of URBs you see vs would want to see?
>> 
>> The Rigols split anything over 500 bytes into two transfers:
>> 
>>    REQUEST_DEV_DEP_MSG_IN #1
>>    IN: 8 x 64 bytes (12 byte header + 500 data), then a ZLP
>>    REQUEST_DEV_DEP_MSG_IN #2
>>    IN: header + the rest
>> 
>> That works fine, unless the second transfer happens to end exactly on
>> a 64 byte boundary (e.g. 640 bytes). Then the device just never
>> answers request #2 and the first IN times out. I also tried leaving
>> the ZLP from #1 pending until after request #2. That fixes the
>> boundary case, but then the device randomly ignores request #2
>> instead (roughly 1 in 5). Raw libusb behaves the same, also with
>> maxpacket 64 in xHCI, so I'm pretty sure it's just another firmware
>> bug. What I'd want to see is simply the second transfer arriving :)
> 
> Doesn't look like any obvious xHCI problem to me. Did it also happen
> with those USB2 controllers that you used previously?

Yes, it's pre-existing and also is present on dwc2, which is what we 
used
before. Replies up to 500 + 480 bytes are fine, but as soon as the 
second
transfer ends on a 64 byte boundary it times out, and some of the
missing data shows up later as garbage in the next reply ("wrong
MsgID: 79 != 2", 79 being the 'O' of RIGOL). So that's a firmware bug,
which I can work around in our application if needed.

The only real blocker is the strict maxpacket handling in xHCI. If it
could be relaxed to what dwc2 (and ehci) already do, that would help a
lot!

> [...]

Thanks,
Nicolai
