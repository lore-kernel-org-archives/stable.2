Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A9223708;
	Sun,  4 Oct 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134214; cv=pass; b=H59JQ/D9GY2cdMO2nFHX6RRAofo3ZPY9P4jDIlrSQeSbyZqoCiQ4XgPv9zd4NRzabxGXQuh7cevO3TnSw3I9Ca8VKA7W2CfSEPHhOLj+IfI54FtsisLnf57o7qNEsiSA/2WT5eJDcjB0oNuDJTRXCD2fdVZFzkre0O4abLgw+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134214; c=relaxed/simple;
	bh=9uM8fw6m2guR7cSseDbThebh8yDVb+s/YIo7WspHacA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csY6no8m8T+U2HoNB/QrQq5AmVhol59yJjK310KDUBoRMaWMH0+zLNAAGUhUDiABaMP6SoeMegHme8cQ2ohbNOjdg7IMWy1BafsGfN3E3HvhpPiLYMstDWC19t/LJ96cncz2OKAIUrK0auT7+5zid9U9KFX5Pd61wP0pN1UNkew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ecBacQsK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ecBacQsK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hyThQ29mwz49Q38;
	Sun, 04 Oct 2026 20:16:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1791134199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auIRK6r389J6WMqNZPbjgoq3erqxe5KMzzpW35kMKj8=;
	b=ecBacQsKhUp8toa6CXne65mNKdKbsXRZResdWtCWnJBclGn2KB2BrNRadYwA7+6C5w+bmK
	QiEJKwUgNclWG/PoarppDpubnScH9J0SPFPnjkvnjSmkRQETkSLgRLCl41KA86NF7E61ts
	SDYHl83Wad4MVv4O7z+AaQbRM57JTKxLOlhy4XgiNeJbGNCATwL0vcmsJK92tezCtHOgLr
	qcosI6dnv29COGsfMWJBpkBJq1TiMsDfATt5CK+ukquAZVSCWuGj4DpQX4h+ewkv36Wqbp
	0wcte2T429IS1pXv2ZrPEp85Z5BP8uhoaGdczY6avPpU7iaRFA0C+TGg2AH3FA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791134199;
	b=uleoP+y3fcrlb2l3Sua7YPLqwf34qFQdF0PtNRnDqqjOZigAxgp+YzyIP9cWg0nP9u/mz1
	vh2fHAgY3vVpLqBgPeulEgIQol9k/OjE66uWbYEysGOSXAQaeuIXCj4zw9HigCcIBKSLOs
	1mTLrzjtPMoFhL0FL5FsmMi/X0D7jt9hjUbngM/NOAtU1BYuV7NuBYAvE+xios3JWAAaLu
	M9lsIHF3DAjr4XwxsdSb6gUAChLBVEJKX/OrQjPxf53DPZphmf8ifXWYnzotJ1Rac1iZSY
	Twu8l7S/OdD5sBguNchNOaRbw8xFW+LNdX6Xfs68rKPkiap6Xw+Hl7bRvFKhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1791134199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auIRK6r389J6WMqNZPbjgoq3erqxe5KMzzpW35kMKj8=;
	b=FpFMFQl7impP/8Ljxjed+a6rDXXfYnJ13MGnfWpnw6QuYVsqr76SGxtGqMFZmYKaorPSbR
	vyVJqKvDRDl6rYppnde6Lt+2RAizJW8JOUSjT8lB7nJPVaVTqOd+vdSr/NTM3N1Xhz0LLq
	IhyYnZkN7G0QcdqbgnoD4lS5dBCte6zYwdZD26vmVMuRThDiHSJbe9cDAZAwAq/blYDphx
	bE4Zn+uDm/mBT+wGCM1lha6aIRvYAu2Xb3ktbDXD+DG/AE7VYN2IPuU2znGEcWvuGzWesv
	Wy810zJ4T/36tCuIYz/cArekeWGVe/dgmiGWuEwWVAkqpXyqo5Jw4kL9efgBcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <225d8d84c8e5155d5af0adfbea270eeeda326021.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: Serialize concurrent connect calls
From: Pauli Virtanen <pav@iki.fi>
To: Chengfeng Ye <nicoyip.dev@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sun, 04 Oct 2026 20:16:36 +0300
In-Reply-To: <20261004162458.3968546-1-nicoyip.dev@gmail.com>
References: <20261004162458.3968546-1-nicoyip.dev@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-10-05 kello 00:24 +0800, Chengfeng Ye kirjoitti:
> iso_sock_connect() checks the socket state before taking the socket lock
> and drops the lock again before setting up a connection. Two callers can
> both pass the admission check while the socket is open or bound.
>=20
> Caller A can copy its destination for route selection, then caller B can
> replace the socket destination before A binds or connects the CIS. A
> then uses B's destination with the route selected for its own request.
> B can also proceed after A attaches a connection and sets BT_CONNECT.
> For deferred BIS setup, B can bind a second BIS and overwrite
> iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
> back-pointer stranded. Concurrent CIS connects can likewise replace the

Memory safety probably should be enforced somewhat down the calls,
likely __iso_chan_add() should reject adding a different iso_conn to sk
if it already has one, since that looks like it leaks the
iso_conn_hold() reference and the back pointer association.

> socket's connection. Later teardown only detaches the current connection,
> so a callback on the old connection can race with socket release and
> access a freed socket.
>=20
> KASAN reported:
>=20
>   BUG: KASAN: slab-use-after-free in iso_sock_hold+0xf7/0x1b0
>   Call Trace:
>    iso_sock_hold+0xf7/0x1b0
>    iso_conn_del+0x7b/0x1d0
>    iso_connect_cfm+0x186/0x16a0
>    hci_conn_failed+0x154/0x280
>    hci_abort_conn_sync+0x3dc/0x7d0
>    hci_cmd_sync_work+0x173/0x300
>=20
>   Allocated by task 121:
>    sk_alloc+0x2b/0x6d0
>    bt_sock_alloc+0x29/0x370
>    iso_sock_alloc.constprop.0+0x19/0x300
>    iso_sock_create+0x94/0x100
>=20
>   Freed by task 121:
>    kfree+0x121/0x3c0
>    __sk_destruct+0x42b/0x540
>    iso_sock_release+0x29d/0x340
>    __sock_release+0xa1/0x260
>=20
> Check admission under the socket lock and mark the connect operation in
> progress before publishing its destination. Keep that flag set across
> route lookup and connection setup, rejecting another connect with
> -EBADFD before it can change the destination or attach a connection.
> Clear the flag after either helper returns, including on failure, so a
> failed setup can be retried.
>=20
> A separate flag is needed because the socket lock must be released before
> acquiring the HCI device lock, while BT_CONNECT requires an attached
> connection. Keep the existing state transitions and the deferred CIS
> completion through iso_sock_recvmsg().
>=20
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6 Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/iso.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 7657c2a0abbf..8113367c796e 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -61,6 +61,7 @@ enum {
>  	BT_SK_BIG_SYNC,
>  	BT_SK_PA_SYNC,
>  	BT_SK_KILLED,
> +	BT_SK_CONNECTING,
>  };
> =20
>  struct iso_pinfo {
> @@ -1269,17 +1270,26 @@ static int iso_sock_connect(struct socket *sock, =
struct sockaddr_unsized *addr,
>  	    addr->sa_family !=3D AF_BLUETOOTH)
>  		return -EINVAL;
> =20
> -	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND)
> -		return -EBADFD;
> +	lock_sock(sk);
> =20
> -	if (sk->sk_type !=3D SOCK_SEQPACKET)
> -		return -EINVAL;
> +	if ((sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) ||
> +	    test_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags)) {
> +		err =3D -EBADFD;
> +		goto done;
> +	}
> +
> +	if (sk->sk_type !=3D SOCK_SEQPACKET) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> =20
>  	/* Check if the address type is of LE type */
> -	if (!bdaddr_type_is_le(sa->iso_bdaddr_type))
> -		return -EINVAL;
> +	if (!bdaddr_type_is_le(sa->iso_bdaddr_type)) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> =20
> -	lock_sock(sk);
> +	set_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
> =20
>  	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
>  	iso_pi(sk)->dst_type =3D sa->iso_bdaddr_type;
> @@ -1291,16 +1301,18 @@ static int iso_sock_connect(struct socket *sock, =
struct sockaddr_unsized *addr,
>  	else
>  		err =3D iso_connect_bis(sk);
> =20
> -	if (err)
> -		return err;
> -
>  	lock_sock(sk);
> =20
> +	clear_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
> +	if (err)
> +		goto done;
> +
>  	if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
>  		err =3D bt_sock_wait_state(sk, BT_CONNECTED,
>  					 sock_sndtimeo(sk, flags & O_NONBLOCK));
>  	}
> =20
> +done:
>  	release_sock(sk);
>  	return err;
>  }

--=20
Pauli Virtanen
