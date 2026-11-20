Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187694;
	b=gaUMj5PvjSWKqBeH+eoGnYOeCZhBtAMcrUczYXXUiBSNhDprQos03ZMlMyzvX0gKSyx1
	 dy7J8uTlmlaEkb5kbvJrWHVeg9PKI6ZOljnnd2kdWcXDFPA0zWA9HwEwD468lWKkd/9aN
	 TqzY9kNJBlYvmFo2bl9CzYGLBLQ4uGbD7halGTpvc4LClEnxijzyLUG3vAftlY0+Y2g9a
	 G/oepd0jLlRjkcaoF6TFSkAfeZvXNOVfrTuntXq22797EN2melOcQVMBU8VN6yTxDdzo5
	 o6sHgTbMkNGHxhS5Y5H5gukqIBzX0FbIW2jP63Gpply38y4o8As8RMToPTacOvEl20w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187694;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VUA4AZldclabl7KQ7qeQb/LRDMoYnf1ou18XMuVyDAs=;
	b=frFK/NG9Uo1UlpAwT43gkYsS7LndeLLHXVf9FmW0CcyvOPZ+TqenL+gH5eYAkERcxos2
	 8MACu6jMG3K8hY8+xX4fD5IkHviP03AKQyYNI1h+aLlUiR9u5uh2CkS90ze+JQyBqjRtW
	 5z33bYvD2bhVsLIAGD4aiTRu5zt5sIq/0y0WyQDi+A5YN1fWv4lU2YOTh+7UjAhJ6hW4b
	 SMP/PfFmll+jygjKe9dvMbk6aeL/bd8fUcHjYxQd+rz3eNReH7PXIqH08O9wghm79Moim
	 PoyOdZqXiwLGyCgEbnafaEUbFWb9SZkhPkcTjfM93VPu4jN/kwppGHbA3ulvshUn9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=dT24xTxp;
	arc=none smtp.remote-ip=109.224.244.118
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97660A2601
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B97660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=dT24xTxp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795187690; x=1795446890;
	bh=VUA4AZldclabl7KQ7qeQb/LRDMoYnf1ou18XMuVyDAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dT24xTxpAINTzYFcvBS0eyvxceCogQuX4AbP2E5NWQ2miarr8muxfe14Xm/inhFcS
	 DuoAil1OphlGXxO86kvc5wtqKourFN1sW2CrYtTtvwTgjXI/GhIpsSQXhdXFvLbcas
	 6a3Jf6dxG87eIeY7+y8CLtequLpQVsmkPxAaijTUQ1HE8JNyL/eb6WC2JGete336kx
	 squtEoRBwDgiLpYbbk9vYkMI2QOMgu7gZ7PUNmCxZERJx7VE/zVcpjfia75k/QbzTJ
	 nu0umj4qXIdiBBTKHBlk4FA7sg6OYzSpCKjPfy2tscLhCdTxA+AOAmZvUkNoBJX6Cd
	 x+rXI9W/bneTQ==
Date: Fri, 20 Nov 2026 15:14:44 +0000
To: Oliver Neukum <oneukum@suse.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data into sense_buffer
Message-ID: <8iDv29vCFEOxycORJWCZZoTT9dMFbUZZ9VK25sT27tKoWWtaKvLKZaW2YoQDygTrSRkZRE6Pu5PmkMFLl-PDCWXI9n1l-LSB9aJCByn8gks=@becholey.ch>
In-Reply-To: <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com>
References: <20261119084526.535901-1-alex@becholey.ch> <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com> <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch> <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 3e4d380063c7bf7d7a2631f03fc3f8974690252a
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 19th, 2026 at 1:51 PM, Oliver Neukum <oneukum@suse.co=
m> wrote:

>=20
>=20
> On 19.11.26 13:28, Alexandre Becholey wrote:
> > On Thursday, November 19th, 2026 at 1:02 PM, Oliver Neukum <oneukum@sus=
e.com> wrote:
> >
> >> On 19.11.26 09:45, Alexandre Becholey wrote:
> >>
> >>> The special case is not needed: for the error handler's own REQUEST
> >>> SENSE, scsi_eh_prep_cmnd() already points the data buffer at
> >>> sense_buffer with at most SCSI_SENSE_BUFFERSIZE. Handle REQUEST SENSE
> >>> like every other data-in command.
> >> Hi,
> >>
> >> thank you for looking at this, but this fix seems to not take an
> >> approach I can approve. Where sense_buffer is pointed to is
> >> internal to the SCSI layer. We cannot use that in an LLD.
> >>
> >> If you think that LLDs should not use sense_buffer then the clean
> >> solution is to remove it from struct scsi_cmnd.
> >>
> >> =09Regards
> >> =09=09Oliver
> >>
> >> NACKED-BY: Oliver Neukum <oneukum@suse.com>
> >>
> > Hi Oliver,
> >
> > Would you take a v2 that keeps receiving the REQUEST SENSE data into
> > sense_buffer and only limits the transfer to SCSI_SENSE_BUFFERSIZE?
>=20
> Hi,
>=20
> sure that would be fine.

Thanks, v2 will do that.

>=20
> Yet, I am afraid I have to ask why you want to solve this issue
> at the level of the LLD? This looks like a generic issue to me.
> The size of sense_buffer is documented. I don't see how this
> issue can be limited to microtek.
>=20
> =09Regards
> =09=09Oliver
>=20
>=20

The overflow comes from microtek receiving the data phase of a
REQUEST SENSE command into sense_buffer with the length of the
command's own data buffer. That length is chosen by whoever sends
the command (sg allows REQUEST SENSE on a read-only node) and has
nothing to do with sense_buffer, so I don't think the core can see
the problem.

I looked at the other drivers for that special-case REQUEST SENSE
(in drivers/scsi, drivers/ata and drivers/usb). They either
transfer its data into the command's data buffer like any other
data-in command, or emulate it there. I found no other driver that
copies a caller-sized transfer into sense_buffer, so I think the
fix belongs in microtek. If you see a place where the core should
enforce the size, I am happy to look at it.

Kind regards,
Alexandre
