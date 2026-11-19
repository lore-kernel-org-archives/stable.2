Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091310;
	b=QpKzHKUaxrvTJHkzar3TpJvGqkhFg1X+DaDF9T7fl6bJJpjodmb9unSYCyndZF7C3AMK
	 VQhy9WIXkQ/8QJ3V5bHohPpiTcTjBXE/1hLgslTA58+i++75hk85a1nBE79/xZwPde9JE
	 ccDcdyYZTHrnc0pMABMry5u+NX7XJIp69UVVEYsWp/gtHEQKFf5bNu7ox8mPRMtiGYKlE
	 jofRqxKrdCBH1rzzEwbGhu3E9qpJm4R8dfYnkIdYudnrJEOKj2ma5MPGMUBBUmaD646EA
	 rRW0APS/qd+1+Pmf6Hg1yu9XkjZ3+SIBzMFx1exePEPzjGUoCgx5uLq3fIWnNZlXmGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091310;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Q2+3flLdKkitImz/XEZPl3BJeh/zAmy9i48Y4faWGuE=;
	b=uSjRYuZW+dE/hIJIW+Nsfwi8HOOtSJH/YWx1JkB+/+zLfQG59zkqk5wQ9l2LXvvjqSOU
	 1Qvumsoig51BcSGByFFQdrJKDt5MnXqWGIFKzVI/aassh69R/nbBncNneTsp2wRuXBT4X
	 ZEta2j5Dk5tAmGWO1lcyJDDMJBH5IL8LrvUD0lvYCyDlTwJZxd8l0V3Tkt4sXSe9pLExX
	 cVtPO6eLoWwpR6CXhL27p+CMOE3+3O9mRFC0bI+F++HjhbeFFlt+p6fDR6PM7mHCihhFt
	 0Op8gZ7C4VTCgd1pNBVUL2iqKyWLPv7IiOuoO65S9S9htMZ8tw47Ypkld71qeebv0kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=T7JqdxRn;
	arc=none smtp.remote-ip=185.70.43.99
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D01606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D01606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=T7JqdxRn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795091306; x=1795350506;
	bh=Q2+3flLdKkitImz/XEZPl3BJeh/zAmy9i48Y4faWGuE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T7JqdxRnr7v5jyWQwUYRxaAiuaTcyJqozNoThFytr/sbdKmd3Gz//m0SZmhsMai77
	 OuiF5f8O+SVZt3ZutGhF+W11GCQFIIZLRy0QO0FthchO2CRfsYCSjU0GmBK8YWspy+
	 Zn+XD5w5I6Fm0yfc2NUl24LjCmzdMvU4bHWVw7w3xOx4cvFOL2YRrhOS2211htxmP9
	 sad0hT+vfufiyh4p/JElVYVnPhsNGuzmMQ7BX6WxODNiciatbwzaTDfz868MzUJs8D
	 5iP1zK2qOLpEANEuiJVw10RuwBaV3Ix/sGqD8vTV+gnoNsos8G1mdakdLP1upFIyEP
	 fRPlAED84fW9w==
Date: Thu, 19 Nov 2026 12:28:24 +0000
To: Oliver Neukum <oneukum@suse.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data into sense_buffer
Message-ID: <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch>
In-Reply-To: <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
References: <20261119084526.535901-1-alex@becholey.ch> <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: f481e75571a0ab0fcd499d96fddf34996bd4e000
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

On Thursday, November 19th, 2026 at 1:02 PM, Oliver Neukum <oneukum@suse.co=
m> wrote:

> On 19.11.26 09:45, Alexandre Becholey wrote:
>=20
> > The special case is not needed: for the error handler's own REQUEST
> > SENSE, scsi_eh_prep_cmnd() already points the data buffer at
> > sense_buffer with at most SCSI_SENSE_BUFFERSIZE. Handle REQUEST SENSE
> > like every other data-in command.
> Hi,
>=20
> thank you for looking at this, but this fix seems to not take an
> approach I can approve. Where sense_buffer is pointed to is
> internal to the SCSI layer. We cannot use that in an LLD.
>=20
> If you think that LLDs should not use sense_buffer then the clean
> solution is to remove it from struct scsi_cmnd.
>=20
> =09Regards
> =09=09Oliver
>=20
> NACKED-BY: Oliver Neukum <oneukum@suse.com>
>=20
Hi Oliver,

Would you take a v2 that keeps receiving the REQUEST SENSE data into
sense_buffer and only limits the transfer to SCSI_SENSE_BUFFERSIZE?

        if (context->srb->cmnd[0] =3D=3D REQUEST_SENSE) {
                mts_int_submit_urb(transfer,
                                   context->data_pipe,
                                   context->srb->sense_buffer,
                                   min_t(unsigned int, context->data_length=
,
                                         SCSI_SENSE_BUFFERSIZE),
                                   mts_data_done);

The device can then no longer write past the 96-byte buffer, and
nothing else changes.

Kind regards,
Alexandre
