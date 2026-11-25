Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616903;
	b=PrxqTzs7X4p6jk0jiPUmSavrh/hBnBx57DMXeS5OLF4tP+FEGK/1i3AHH107WTvhLv6K
	 jU1LM8woA4S5ggYt6es3KQV2AWnrq/nCAAdmwNv6ksLjiU+llbYFIT+1wDxVrGYr3soWt
	 yNDupU79BXzeADZEGaqom7Q5cfYMRFDgFhREV6gJxTN6APD+TQdK5/djuXtTEjOvnaJfH
	 cnlueItW2UG42aBy6cpg4ooWxrzEyIpg86teVpuA2Ue0cTYqWG/CXA0zGyAWXma0WN/ZN
	 HGD0ZuO11LAeRsCFIxmTFhuzTMJjvPVj85Vl5s+LjmcnbDLRA864f11aS8PcyQXfBMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616903;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SL0Oq2dFYcdjGnJP7NWtsXQS7LsxYOscXr4Ry4WrgHw=;
	b=CjE+Jpa+OuAK23wJq0DEJHgCrCyhes7b9Q3JDjiAs2GHuzpc50ATTf9Z56ioyfQc8rQk
	 JEoiRar9f2vkkrP3eHFD1Fj59KvRE2Bsto8bu7bmjgsRM68/jYR9PWUItTpwwPk/iYS/e
	 RltXOTnBseV+BmlxanbjgOcPZKJJMEr7wR9+46AnGvaKUcvFLMrShQCPczQ05XIm7ZLxf
	 mz56NcIFcYC9OaGLXEzjmZHkpi404HOcTE/jm1mUvFwJ6yWet4lhrb4tNCtTq9KAgn59v
	 thOBbaOCibtGlkqR1rL/p23Sr1S4enZOJbI4ATBp9mRc6MiETbD2oXjozOcNBxVJSFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail2 header.b=oIIAmZOW;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E25606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E25606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail2 header.b=oIIAmZOW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail2; t=1795616900; x=1795876100;
	bh=SL0Oq2dFYcdjGnJP7NWtsXQS7LsxYOscXr4Ry4WrgHw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oIIAmZOWYKKkHKw25w97jfTqs+/qN27Z/zm9Q2OH5VTVL3WjWvRu4f011q4mJT/tR
	 Guta03xsA4toxY41kR6isUU4fkR4AfLXBCyPSMAwvPOF7pzGmFFHSf9PhE3D9aWtfh
	 ivznOG978HEs4zfYmtzn8vFrIXnY/Fmr8GpD+o4ySZ7308uXQWhYPtbdMcj5crI0mc
	 59+ZPs4CoxERM+JkY6HJv3djdlH7v2sH1i3dbIrITVRt1KfoZu5Z8yrK5BgCS96hff
	 TKScMdmYJfOl0kMSrStoQyDYNcty8KPuCQpTvrYesqljdczXL40+s9n2+GXEHmQZFo
	 t/6ZH6/KoUutg==
Date: Wed, 25 Nov 2026 14:28:14 +0000
To: Oliver Neukum <oneukum@suse.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data into sense_buffer
Message-ID: <HSkiYehoEZjHsmtOkLlo174eN2wrhaDGyLpIMwWTMy0Cdn4t_nrRvoS0dslql-VSF3jaeKvglXyGaJ6OxnGMs_0TMQVXRUFDK1IDH7yjR58=@becholey.ch>
In-Reply-To: <f9715edb-94be-47cb-8bf1-f84a3323f000@suse.com>
References: <20261119084526.535901-1-alex@becholey.ch> <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com> <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch> <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com> <8iDv29vCFEOxycORJWCZZoTT9dMFbUZZ9VK25sT27tKoWWtaKvLKZaW2YoQDygTrSRkZRE6Pu5PmkMFLl-PDCWXI9n1l-LSB9aJCByn8gks=@becholey.ch> <f9715edb-94be-47cb-8bf1-f84a3323f000@suse.com>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 43cb28c887785995532cd068d488e0dd4b39e612
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

On Monday, November 23rd, 2026 at 9:53 AM, Oliver Neukum <oneukum@suse.com>=
 wrote:

> On 20.11.26 16:14, Alexandre Becholey wrote:
>=20
> > I looked at the other drivers for that special-case REQUEST SENSE
> > (in drivers/scsi, drivers/ata and drivers/usb). They either
> > transfer its data into the command's data buffer like any other
> > data-in command, or emulate it there. I found no other driver that
> > copies a caller-sized transfer into sense_buffer, so I think the
> > fix belongs in microtek. If you see a place where the core should
> > enforce the size, I am happy to look at it.
> Thank you, that makes the situation clearer. Yet it kind
> of brings back one question: Why does scsi_cmnd have the
> member sense_buffer at all, if you simple can write the
> result into the generic buffer?
>=20
> I have no problem with cleaning up an issue in the microtek
> driver, but if an issue is to be cleaned up, it should
> be done fully.

I understand. A fuller cleanup is more than I can take on right now.
So I will send the v2 you agreed to: it only limits the transfer to
SCSI_SENSE_BUFFERSIZE, so the device can no longer write past the
sense buffer. If you would rather not take that fix, please tell me
and I will drop it.

Kind regards,
Alexandre
