Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195063;
	b=Gftzqwsdi3VXsO9iQq8r/JkilChKRdBJsgCD0ENV88xroMxRaoRfe6PNsDFKczKolPV6
	 70zzzm7drFm3cY1368GYztVRW3ntSxVZUpXlmNNDVc84Pfc7i368qkQQfDC8623Cja8aY
	 5ZetY7XC1VgnkB3QeRgSDrQNRKrNQpzMWPKY6rBxlT7/4+/4LOBFJIMt5rYFOmo1VvLh8
	 POrmZ747JdiG2Tj6B0U68meBy8+DCr5K/AGi753Fql9LYhaf8TaZVUa6h1GmrQmtpV0B/
	 NRhspsNSxElUxFHTYsyVxKzexcIVN06UrqviygyaK7Pzy1oSRj3XjtmK8FKz8Rugucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195063;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authenticated-Id;
	bh=QQZ+cbtcpKFHgk1DpEzLueNxHPxmGXXgeatclk9OYMY=;
	b=3DN8otY4VxmxnPfpQ+czIS1aoMhPkB3EjF53VS8gHkEKLEY20ievwTegBVBuNGNR6hSM
	 jyUyfrZcXsFcztP8DsDjeNmCJQTadrFSEjQm6h0e0SgrNDk6CYCZ5kwrl1fSIdpq8iO/o
	 yszKb9uqHGIfCTpj7idcPpVZ3iCihsrX3AdMrWA18t/dECxcXwZjBGwpt1TC0MuH+PyQA
	 BX0oPcAx/zZncTa0WVpAvkQu4A04t9fUm0Crl3dI7v3WMvTCjeTILv9NYZSMWtkOCUejO
	 /MlF/22vCjlJ3Yd9gYdKE8Qr8rvnAUQUYwLMgMftZGiKD+a9GiCxCR/2/J6pOUdVTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.39
Received: from mail-e618.seohost-mail.eu (mail-e618.seohost-mail.eu [213.239.133.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFD606A320;
	Fri, 20 Nov 2026 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6AFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=[192.168.8.166])
	by h84.seohost.pl with esmtpa (Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xUSF2-0000000GmV1-10OU;
	Fri, 20 Nov 2026 18:17:40 +0100
Message-ID: <b0026332-b980-49a8-80bb-a41735468592@kubik.pl>
Date: Fri, 20 Nov 2026 18:17:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: cdc-acm: restore the line coding after a
 reset-resume
To: Oliver Neukum <oneukum@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Francesco Lavra <francescolavra@interfree.it>, stable@vger.kernel.org
References: <20261119122842.3611681-1-piotr@kubik.pl>
 <1817932e-469f-401b-bc04-37f30625c3ec@suse.com>
Content-Language: en-US
From: Piotr Kubik <piotr@kubik.pl>
In-Reply-To: <1817932e-469f-401b-bc04-37f30625c3ec@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: piotr@kubik.pl

Hi Oliver,

thank you for the review. You are right. usb_resume_both() resumes the
interfaces in the order of the configuration descriptor, so the control
interface is not always the last one. On the CH344 that I tested, each
control interface resumes before its data interface, so v1 sent the
request while the data interface was still suspended.

In v2, acm_reset_resume() reads acm->susp_count under write_lock and
sends the line coding only when the count is 1. So the last interface
to resume sends it, before acm_resume() restarts the URBs.=C2=A0
I tested v2 in the same way as v1, and an extra print showed that on the
CH344 the data interface now sends the request.
I will send v2 as a new thread.

Regards,
Piotr


On 11/19/26 13:47, Oliver Neukum wrote:
>
>
> On 19.11.26 13:28, Piotr Kubik wrote:
> Hi,
>
> thank you for this patch. However, it has an issue.
> Let me comment on this inline.
>
> =C2=A0
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The device can lose its line coding, for e=
xample when it loses
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * power during system suspend, and acm_tty_s=
et_termios() sends the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * line coding only when it differs from acm-=
>line. Send it once, for
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the control interface. In a runtime resume=
 of the device, an autopm
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reference here would wait for this resume =
and never return.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (intf =3D=3D acm->control)
>
> This test is problematic. The interfaces may be resumed in any order.
> You are setting a line coding before the rest of the device is
> resumed.
>
> To do this cleanly, you need to look at the counter.
>
> =C2=A0=C2=A0=C2=A0=C2=A0Regards
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Oliver

