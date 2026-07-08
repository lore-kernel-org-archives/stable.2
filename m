Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DF420883
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504004; cv=none; b=RxNrFYFdrX7XtcaC9alaoAZk3sQ3rYNlw2Qd5XmfsYrrS9O/Xg8MkERe4pobSG5x/pMXKx6PVvLvrFJOmwePCNEHaVA8OeQ5HM4AxsrThTTbaUf5BUYiQ0PUASgWBMGzMBGj/tdZAuNZb631zS+0KIdo9RnAvLDq8JpDctyfMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504004; c=relaxed/simple;
	bh=wmpfXwOOnhry9Q+7FIuUKY9er7IsvCB1ck1WlSzUW5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qno0B3b4gMs9Ohzm24bQYnx6ctAGWkfBU08iKwX9bDMflF+OvfVabajjrNUmC1WtBmjZjEP3tovWPrSwwjmDlkdipR3JyKOsLyfuY6r7JacHhF4oz1RtTiwKM7+OtozNStp04d3oSZFA3ScFm9YVEFqjWjQCVeL3ItHjORbcERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BYHWltk8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BYHWltk8"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwCsp0d1HzKvv2;
	Wed, 08 Jul 2026 11:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783503998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COJUhYqOhbFD0yRfI6JTEikK6q3GyC7gz712kjp9hWQ=;
	b=BYHWltk8xDgH1UOb/OUD81hzLUNegyGpYAy42HJaBBA4j1fjh4gg5mErcx/F6jPYaX7Bz4
	IatGwdola43jAOCxpK+TZG0fU+8LqPyLb8wrnSPk29kiE4Oa1d7coX9Mc+wc8Aze5F6BYd
	AQl+7dNP7XVj8ZrjOA8zKRJknc3u8CwcqcbFBY7izoDnDOsHekgTcyojHQ1H6D5FKh988u
	2oMm9UECQMEFcNiN7ZnxiXXCiExZMk/3yio70h+rb6uNjiAy0ZNaNepTzLCBY+Y7V+/Mpz
	OhN1yPPaGmtOVNnDv05NrZ4oCUBYBrku8+yJd87beW8Nd/yF8Cfth6AoHbCdBA==
Message-ID: <39a61cc710b34ffbfecbbddfadeb8b4d8352a7f5.camel@mailbox.org>
Subject: Re: [PATCH] staging: rtl8723bs: fix missing shared-key auth
 challenge length check
From: Manuel Ebner <manuelebner@mailbox.org>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, stable@vger.kernel.org, Hans de Goede
	 <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>, Larry Finger
	 <Larry.Finger@lwfinger.net>, Jes Sorensen <jes.sorensen@gmail.com>
Date: Wed, 08 Jul 2026 11:46:32 +0200
In-Reply-To: <20260708084342.136878-1-npetrakopoulos2003@gmail.com>
References: <20260708084342.136878-1-npetrakopoulos2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 2562f0c27290f2d00dc
X-MBO-RS-META: dc6c7a6ft6fanrnhsr3ptapsroorukeq

On Wed, 2026-07-08 at 11:43 +0300, Panagiotis Petrakopoulos wrote:
> The WEP shared-key authentication handlers use the challenge-text
> element's attacker-controlled length without checking it against the
> fixed 128-byte chg_txt buffer.

Plenty long and complex sentence. It took me a couple minutes to
understand (or misunderstand). Please split into a couple sentences.


That's my try in rewording (is it possible to drop 'shared key'?):

The WEP shared key authentication handlers use the challenge-text
element's length. This text and it's lenght are attacker-controlled.
The handler does not check the lenght against the fixed 128-byte
chg_txt buffer.


> In OnAuthClient() the length from rtw_get_ie() - up to 255 - is used
> to perform memcpy() into the 128-byte pmlmeinfo->chg_txt, so a
> malicious AP sending a malformed WLAN_EID_CHALLENGE element can
> overflow/underfill chg_txt by up to 127 bytes.

Again, but this one isn't as bad.

>  It is reachable over the
> air, before association, during shared-key authentication. In the case
> of an overflow, the driver can write out of bounds. In the case of an
> underfill, the driver can echo stale buffer memory. In OnAuth() a
> similar issue is observed. The driver compares a full 128 bytes
> regardless of the element's length, reading past a shorter element.
>=20
> The challenge text is defined to be exactly 128 octets, which is
> already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
> element to be exactly that length in both handlers.

This is good.

> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
I added the mentioned people in the commit to cc.

Thanks and
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>

> Cc: stable@vger.kernel.org
> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
> ---
> Compile-tested only; I do not have RTL8723BS hardware to test the
> shared-key authentication path at runtime. The change only rejects
> challenge elements whose length differs from the spec-mandated 128
> bytes, so conforming peers are unaffected.
>=20
> =C2=A0drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index a86d6f97cf02..13634d4e83d1 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -787,7 +787,7 @@ unsigned int OnAuth(struct adapter *padapter, union r=
ecv_frame
> *precv_frame)
> =C2=A0			p =3D rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_=
,
> WLAN_EID_CHALLENGE, (int *)&ie_len,
> =C2=A0					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
> =C2=A0
> -			if (!p || ie_len <=3D 0) {
> +			if (!p || ie_len !=3D WLAN_AUTH_CHALLENGE_LEN) {
> =C2=A0				status =3D WLAN_STATUS_CHALLENGE_FAIL;
> =C2=A0				goto auth_fail;
> =C2=A0			}
> @@ -873,7 +873,7 @@ unsigned int OnAuthClient(struct adapter *padapter, u=
nion recv_frame
> *precv_fram
> =C2=A0			p =3D rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_,
> WLAN_EID_CHALLENGE, (int *)&len,
> =C2=A0				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
> =C2=A0
> -			if (!p)
> +			if (!p || len !=3D WLAN_AUTH_CHALLENGE_LEN)
> =C2=A0				goto authclnt_fail;
> =C2=A0
> =C2=A0			memcpy(pmlmeinfo->chg_txt, p + 2, len);
