Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0D480DEB
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147820; cv=none; b=oDMTr2+lNKWQFo/05Wp5g4TNuYJ0C/AwM3C3iwSB36mXnE/d0y4YbNLdsSFdmvR3gNQKAU8ZsgUl16wQgHXbDA931LtLXKBXvWbLQpnfLcWKNBKukeNuiViN6IEjOWeitBOMfLCc8jz7lf/OETpz12FaF48MT+e3fl5xJB0K6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147820; c=relaxed/simple;
	bh=MJhCB7uRhMADT4eh41CKINoVvSDQQtbHuD4lX8vPSK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlWrjekugMgZxIaDIHJm24DHzBi1TfR6w5i6w7xCzHocw7f3hASc74nrDcSBcSCu0oiXvVjSbBgYc03wmdONY6cqBz8Jv1sNY9HbT3kR0chbL70o1Tkm4QfN0hFKVk3rZ0y3gk84P+jq5QDIvdLTHpNELxcHvCYazttdviVtmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsQ3cvRB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsQ3cvRB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 744571A113A;
	Sun,  4 Oct 2026 21:03:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 304E8604FE;
	Sun,  4 Oct 2026 21:03:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2088210328384;
	Sun,  4 Oct 2026 23:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791147815; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7pjV1gWlf9aETc+XjjWgbEA19fRIN9x9kDhtbidus5o=;
	b=hsQ3cvRBkVAPGTOiAm1ZbKxiFVFBP8YlDHA/cUOBFt04VsqYpUOx4izUP0Gc6CO//Qxrec
	egFUav/rvvqAroNgzZOoJxeNUCblqwNiKo0Y+PNZ9KLwt8HR/qcVT5rxw3nRcVkuKNDvre
	U3zsO8mqjPjqolluPwdt2VkHmNx3A8qItzxuk/pmhh3I8V5M1O6QM95VK/HNQO18XYHAJT
	TlI2GIn0eZ1CKZr/raSdXro9EF4VtGMgFbuMQ4oWJXLEyGd0bszew1KY60kkx6UsvgntCl
	TXnpbpkesL4CzLZg1+AQ5i8fhqBu8MF01kez7rMRwPLobAeIKJ1XB14QUEAy/w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  David Laight <david.laight.linux@gmail.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
In-Reply-To: <20260930071914.421586-3-benquike@gmail.com> (Hui Peng's message
	of "Wed, 30 Sep 2026 07:19:13 +0000")
References: <20260930071914.421586-1-benquike@gmail.com>
	<20260930071914.421586-3-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 04 Oct 2026 23:03:31 +0200
Message-ID: <87ece5jhzw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


> Initialize lenvar =3D 1 in ca8210_get_ed() and return
> IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
> response.pdata.hwme_get_cnf.hw_attribute_length exceeds
> *hw_attribute_length.

The relationship is not obvious to me.

> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - No changes.
>
> Changes in v2:
> - Split out as patch 2/3.
> - Replaced the temporary stack buffer in ca8210_get_ed() with lenvar =3D 1
>   and an upper-bound check against *hw_attribute_length in
>   hwme_get_request_sync() as requested by Miquel Raynal.
>
>  drivers/net/ieee802154/ca8210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8=
210.c
> index a990a0f..8aa7ffe 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>=20=20
>  	if (response.pdata.hwme_get_cnf.status =3D=3D IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;

Why is hw_attribute_length use here before being set (or re-set) just
below?

The organization of this patch is weird.

Miqu=C3=A8l
