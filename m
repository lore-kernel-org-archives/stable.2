Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512653A6B6F;
	Sun, 16 Aug 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786890377; cv=pass; b=gcWV84m/7tDMqQZMi4jnpwmkULcJv6O2mXR+onvu70zsyzdedBGsopA9fW6B7qgnkTwII2sp6CvJzuM37PwVuf/x+oWcKac+IP/T+9hHXlCbSbAZ3AQlIzDJjIlNDsaTN/zvCrpIesDimaTKaGcueemFG80i73jd0cMIcifY+Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786890377; c=relaxed/simple;
	bh=N9RhH3ZdoJqEXKokXNgN1QLiiBiMq1ubzS0u60C/j1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ki75ZsI/9ZPO83G/iuinXmV3L8gkeDE3Y0JwC/P5Y7hxrZko7sY8a2ABdHUFqvWPe0pa/yE54rBwnTmZvc/hOmwJlVyP6vZfs0EPsprOs1Jdjp+NGZHOtNCHx76TVokSwksnL1ZMZwJzSpNiEOUDNhhC3fNNAcE8LzPp6/NrJcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ivp/7Goa; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ivp/7Goa"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:5:f011:31::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hNJDG4Qdkz49PxG;
	Sun, 16 Aug 2026 17:26:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1786890367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0uCRFzGuboIOzZ6xcvU78o6ZZXbp3EUcxq3O1/WQ18Y=;
	b=ivp/7GoaqiW+zxI76qUyTDs8CrCwVJWLLXnEcQhhfq1TYWABUvZ6i7MCNCmoDYMum0jKl2
	DCH30dTdH+TgX5y/NfDo2Heb17XsUJOYZON3dd1CQLqTDkYPGQpCz09BT00GZtgUUYPSwf
	NyEgLnpDVOj4a8SWzki+SqRJdtYGYev9JTmwkdYDWe2XPh8jLg/uIS0fdJnGk6wT8/ShTu
	r/xG6nq2vwhP5n6Q2VFTOr4HCbQug/iISSvXtoMpP4yUb2niFTGjQ8w6/uSvcrOTGdU5PC
	MEBCc5tC5a+0TazW49ht4imK8s9Z2P2jTXhKvMipBwb07RIRBEC4wH5uRn54DA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1786890367;
	b=sFV7JM+RciE+v800gTvJZCNOPTico5hH3Cy9Q9/sPHdmBeGyCFNozIu7LB88Kz2L6VNrJh
	sCDrLnYjxUD9VpWF9lZP4XQruAJj2n2U1yfzY6f4RNQx/kU5ndvSm8KUQPodd18SGnekAd
	77eF6PZA0k4B9Nwdm/MROdxERO/MkC3mFnMGDutyBvjvUOPYriCnDf0MjdmUegsKX7i4Tt
	lkus+aucQIEOkezn+aWx/9S+b2siFvotv4svlJXeuitQBXi/HxAM6DCmZo3p0noh9yjdz4
	T1sYkzuEu+rEFybQ56rWorUayhqE6d9Hqhno6dfK857/4u+d8YBbr8pLLL+i6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1786890367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0uCRFzGuboIOzZ6xcvU78o6ZZXbp3EUcxq3O1/WQ18Y=;
	b=SQGmZ1iI9u092SQ6X8b+NRAhtszR50JcanYWklViJZ66u63Y7NNRtKLH2hgK2nJUcptmg8
	J321cvlnQMxab+FREbNdkrUE39J0eq86FQd1IyBtE7YuA33t9+6hw0Wro0cu32toeCPZNM
	fXXtBLq7iQRh+vTsQoIZzfbu48N/AAj3iCOhaxmyjH+enEw5aKboMH7SwHc10GkVn+1RRZ
	hvpFqH3zlhmNV/o2pwYh6ZYNrDSN4kNKZBiLFIeBZfChQ3izzx0zrhKez4wrv+JHUZlvHm
	a51cP8pmAKOzcyPLpsqwpU96pwe+6488K6p+P3yR3Ot7jItKMCfqCBCDaKucAw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <cd71d83c71abbd0cdba00c0aa9160d421e7c28d4.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: ISO: fix use-after-free of listener
 socket in iso_conn_ready
From: Pauli Virtanen <pav@iki.fi>
To: Hang Nan <2122295973@qq.com>, linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz	
 <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 16 Aug 2026 17:26:03 +0300
In-Reply-To: <tencent_E5954D5C14D99713A73E3121B97EEDA6170A@qq.com>
References: <tencent_E5954D5C14D99713A73E3121B97EEDA6170A@qq.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

to, 2026-08-13 kello 19:39 +0800, Hang Nan kirjoitti:
> iso_conn_ready() looks up the BIS listener socket with iso_get_sock(),
> which takes a reference, and then, without re-checking its state,
> creates a child socket from it:
>=20
>     parent =3D iso_get_sock(hdev, ...);
>     if (!parent)
>         return;
>=20
>     lock_sock(parent);
>     sk =3D iso_sock_alloc(sock_net(parent), NULL, BTPROTO_ISO, ...);
>     ...
>     iso_chan_add(conn, sk, parent);
>     ...
>     release_sock(parent);
>     sock_put(parent);
>=20
> If the listener socket is closed concurrently, between iso_get_sock()
> and lock_sock(), the reference taken by iso_get_sock() may be the last
> one: the close path drops the link-list reference, and once
> iso_conn_ready() drops its own reference at the end of the function the
> socket is freed.  The child socket, however, is already linked to the
> freed parent, and a later disconnect of the child runs iso_chan_del()
> -> bt_accept_unlink(), which dereferences the dangling parent pointer
> into the freed accept queue (a use-after-free).  The same dangling
> pointer is also dereferenced through parent->***() in
> iso_chan_del().
>=20
> Fix it the same way the connected (non-BIS) path was fixed in commit
> 0d255e63fcf3 ("Bluetooth: ISO: hold sk properly in iso_conn_ready"):
> after taking the socket lock, re-check that the parent is still a
> listening, alive socket, and bail out otherwise.
>=20
> Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
>=20
> Changes in v2:
> - Fix GitLint B3: replace hard tabs with spaces in the commit message
>   code snippet (no functional change)

Changelog should not be in the commit message, but below the --- line.

> Signed-off-by: Hang Nan <2122295973@qq.com>
> ---
>  net/bluetooth/iso.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index aa2ce78f56a2..069fc87a4e18 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2277,6 +2277,21 @@ static void iso_conn_ready(struct iso_conn *conn)
> =20
>  		lock_sock(parent);
> =20
> +		/* The listener socket may have been closed concurrently
> +		 * between iso_get_sock() and lock_sock(): the reference
> +		 * taken by iso_get_sock() may be the last one, in which
> +		 * case the socket is freed as soon as we drop it at the
> +		 * end of this function.  Recheck that the parent is still
> +		 * a valid, listening socket before creating a child
> +		 * socket from it.
> +		 */

The explanations are long. Assisted-by: some LLM?

> +		if (parent->sk_state !=3D BT_LISTEN ||
> +		    sock_flag(parent, SOCK_ZAPPED)) {
> +			release_sock(parent);
> +			sock_put(parent);
> +			return;
> +		}

The change itsef looks good to me.

> +
>  		sk =3D iso_sock_alloc(sock_net(parent), NULL,
>  				    BTPROTO_ISO, GFP_ATOMIC, 0);
>  		if (!sk) {

--=20
Pauli Virtanen
