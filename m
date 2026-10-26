Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038165;
	b=0ChEAbGlGK0z6J8uMiFdEi45JE5dqGE6LNews+FK9C6uEUWuiSzeUEuMZ292T/kgKAK7
	 yyJ6VhVCG2rBoC8y/jvkv5jwhKOiikE32STKvGWjzjMBrnMmNnhFRVeWaqiAUlditzqHy
	 a4SIvU0fSkuy0nW2uBdosDgP+SdMPXhymjzUTIrgtBILL2C57aNpP0XGG8JLUF3/4/L9C
	 VkH8R2JiDtRPzybXQIaxuzqdvMoJK3r5W2131W4ZGhZEez+5WLtolu9f+uupkk+4qzP+O
	 US9844JDFZdqw+XZjqyzvtk4aMgF9FK/vIseV73Vh3RI26VQqYdMWWBiO+NvrCYreTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038165;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Infomaniak-Routing;
	bh=ePgfAy3uzHAN/EkWHZ8Jng1TIwn/iiaFzzNrCetWo0g=;
	b=jUVcpmlTwk6UdYAK/s8JBfhYt+q1MIxPkOGrDVXSOJvbtTgUN17+0cplsymZYxGqbIeQ
	 /6nh524u1tLt/IkFmNR3cfUKpY5V5YFPw7N02557jy5hdxCe913vV1VbhNbe/A5TwmuT0
	 7Jhz+ia3kgsLNpB9dw3xkfcyX8BeRQnn7FJ9kbPDOpm0/3cWmzfT3L9m+TtrlMc9rNzp7
	 Qo+gUGiZnd4JOSzU5aeLWi+dOriXS+jVnXyWY6XFL6V6uKloL2qCuU1+M8i63kSCzHBfh
	 078fkiw/ckKgRbH/Vl4IOasZsgiu8Efq5A+IDA2vw0aLNrJaH0+0ODpakoEAkGuPc6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=etik.com;
	spf=pass smtp.mailfrom=etik.com;
	dkim=pass header.d=etik.com header.i=@etik.com header.a=rsa-sha256 header.s=20210927 header.b=wTqMTyv0;
	arc=none smtp.remote-ip=84.16.66.169
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC2606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EC2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=etik.com header.i=@etik.com header.a=rsa-sha256 header.s=20210927 header.b=wTqMTyv0
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jD1pt5NLqz1F2d;
	Mon, 26 Oct 2026 19:09:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1793038150;
	bh=ePgfAy3uzHAN/EkWHZ8Jng1TIwn/iiaFzzNrCetWo0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wTqMTyv0jprnEQTGDQYh/CbZDdAFRn7jdThjNhR7g6iNaU3bqOlAraT4/AAHq0Qi2
	 E43P5sv3T9ZrTo5D61jYrShfckpPqPNnXWEKyeFomO/64vSnjrEiSZ3GfzknXQ2CgW
	 dTZ49OR0j4kayABL9E8B1mwGPOfzJXK8fbtauwyY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jD1ps25P6zVbB;
	Mon, 26 Oct 2026 19:09:09 +0100 (CET)
From: David Vornholt <dv@etik.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vornholt <david@vornholt.online>,
	stable@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2] usb: typec: ucsi: Stop a power level change notification storm
Date: Mon, 26 Oct 2026 19:09:07 +0100
Message-ID: <20261026180907.76867-1-dv@etik.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <at8kLPzAnJAfZRjF@black.igk.intel.com>
References: <20261010183917.146821-1-dv@etik.com> <at8kLPzAnJAfZRjF@black.igk.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: :8e558a56fdab348:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha

Hi Heikki,

On Mon, Oct 26, 2026 at 10:58:04AM +0100, Heikki Krogerus wrote:
> On Sat, Oct 10, 2026 at 08:39:17PM +0200, David Vornholt wrote:
> > On a Lenovo ThinkPad X1 Carbon Gen 13 (BIOS N4BET78W 1.48, EC N4BHT61W
> > 1.41, UCSI 1.0) with an HP E273m monitor connected, the PPM keeps
> > signaling a Negotiated Power Level Change although the power contract
> > stays the same, and signals it again right after it has been
> > acknowledged:
> >
> >   ucsi_connector_change: port1 status: change=0040, opmode=3,
> >     connected=1, sourcing=0, partner_flags=2, partner_type=4,
> >     request_data_obj=1304b12c, BC status=2
>
> Okay, so the PPM really should not report the power level changes
> since there are not power level changes, right? Have you reported this
> to Lenovo?

Right. The connector status is the same every time, with the same RDO,
and the Negotiated Power Level Change bit is the only one set in the
change field.

I haven't reported it to Lenovo yet, so I've added Mark to Cc. Mark,
this is a ThinkPad X1 Carbon Gen 13 (21NT) with BIOS N4BET78W (1.48)
and EC 1.41, which is still the latest firmware on LVFS. With an HP
E273m connected over USB-C, the EC keeps signaling a Negotiated Power
Level Change for an unchanged contract, about seven times a second,
and GPE 0x6E fires about 680 times a second. Could you pass this on to
the firmware team? The details are in the patch:
https://lore.kernel.org/r/20261010183917.146821-1-dv@etik.com

> This problem may only affect your system, so we really have to isolate
> it somehow. I'm almost certain that like this there will be problems
> on some other systems.

OK. How about a quirk for this machine only? ucsi_acpi would match it
by DMI (LENOVO, "ThinkPad X1 Carbon Gen 13") and set a new quirk flag,
and ucsi_get_supported_notifications() would then leave
UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE out of the mask. That replaces all of
the detection logic in v2 and changes nothing on other systems.

I've tested the effect of that on this machine, with a test switch that
kept the notification disabled from the start. With the monitor
connected, the PPM signaled no connector changes at all, and GPE 0x6E
dropped to about 5/s, from about 680/s with the stock driver. The cost
is that on this machine the driver won't notice a real power level
change until the PPM signals some other connector change. The EC
handles charging on its own.

> Something that I did not quite understand from the above is, if you
> revert commit a0d4618788f2, do you still have a problem (I understand
> that you still get the repeated notifications, but do they cause other
> problems then)?

Yes, though only about half as bad. I didn't test a plain revert, but
my first attempt did the same for these notifications: it skipped
ucsi_pwr_opmode_change() when the RDO hadn't changed. That's where the
"about 360 a second" in the commit message comes from. The PPM still
signaled the next change right after each ACK, so the driver read the
connector status and acknowledged it about nine times a second, back to
back. At about 50 ms of EC transactions per command, the connector work
and the EC were still busy almost all the time. Only disabling the
notification stopped that.

I didn't measure CPU time or power draw with that version. If numbers
for a plain revert would help, I can get them.

If the quirk is OK with you, I'll send a v3 with it.

Thanks,
David
