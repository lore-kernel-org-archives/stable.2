Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F361F942;
	Sun, 26 Jul 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785060974; cv=pass; b=DyV1nZaWrjL+X0kDhoBsvFMRZQNXruM5Ezh+l7+lEVnaMCiwGkLwnRHTrywFvAJc9rrRvXIBbwHfHRn7rSl+wmI7KjZH0orBLojcqLlts5AH/47fNgl3SFezPl4JfXkYjy2yju/juOO3v48SKDtfdBsnn8OG7qQ4lGnalEj8DIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785060974; c=relaxed/simple;
	bh=VOOrAeRzm4gUnjywCWJ8p9xhNacZ0icJPwUO48c3CtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qO3wXysk7vOOYgHuD6OEeQoPxmHMH3S3vTPajaWKH3Lc0bngGBAani1D0DKQ1S/X3tXzNarnsD4X4RuY1oQGiO3ql36fApC3+LL4BTVtGN9nI07IutM0NORkWoMrozWg7SSrlBtDJY8HgDCHVWizgVh8PwQZUmJsFWAm2JHMFbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=h5sVRr+7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="h5sVRr+7"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:5::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h7HgM1yqwz49QG8;
	Sun, 26 Jul 2026 13:15:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1785060960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uiqj6ixCkhVMUdmPmI132RDLCRprbNRAVXs55pmkdAk=;
	b=h5sVRr+7zBy48L+aWNE3VTwMc+jvmQz0N8+4IHhzwqXCXvmPF4YDQCKsXZ1Xb7paTvrkhZ
	n3ErJZzTnt86ydnR4fEtUQ2rVYVYZoLt3yYF5Or5MklWLRV+NB6xOhWOfT7fXQMJibAdKo
	6aBYxveF3FYKFZgaasiILqOy1QrJChCBrnOUkZ1lADQ6v4Ug9NQkWl0Y4fAsIGvdxDAaam
	GdrouiuNmz+/CBOSUQYCQ7oUqQRNIaWueFA0p+4DGEMnk0Y4Zpw+cuMLP+vheCMVjEd8dT
	MMVz7Jpotc+JbqcnPH4+O5lYH9w/kva8BIg+NvGaORhR7aTOTWXaTuTlRpL/OA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1785060960;
	b=TZvg/21MBbfNIbbJ2bQhIpOexzPQiRU7UJ5pEsY9gjcQ5ypl4s+Ay09JJK1gdYnnTi4hpf
	QNbIsHvZV4BknXVypGq5qyw+T4pAAdkZd6INEFOZg/xgsJFUsO6zbnU4z2SRVuYtm13eTb
	Trd92/QPMoKkx3jJKO1axdGU9s118B2n3uW3PUAYo7e0rL4LDkjhdNkoJcoKcA12YjWqIs
	fFrfuidt0M2ljLsRm/Ue+0lowqtfHyuMyEyLxCWEEoLs1MgKMi7quL0Lin3Om2LljVelbE
	C9hhoybK38mXJBxqRU6EumCC7e5WH/KPE7gGUwpE7FLgqpZCtBZaPGA0ol4BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1785060960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uiqj6ixCkhVMUdmPmI132RDLCRprbNRAVXs55pmkdAk=;
	b=tRo3L7gCTNBX7UqQ7S76K33zVZTixYkStWquSqId07MkbtPl6XqdIrIYYam9HAkveS6ni9
	wGhzt2qLGnNCDfBcYZEZlHwFgvSCFp5m1z/lgHGdQ10CVCvaPzgftpZ4a1TK9BXzneR1jB
	/0umlWsGAgHY9xKZqRV7c0Q/9oZkChzhZowvSsJnP4KGVUade4lfC0uHvehKfqTHEB8Eh+
	RCUQ9uQOaKxqf1iMTANBxn6RI7xJ5SwaM7yD7mCiKWYVdlijWLRT0zaLaKTvn3ymcdCDmC
	tpksXxG5q3FtvE+P7d0YBwtef6hyWS3nmanR3roU54+axDtiyaBuWWjtYYNUiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5e2a239a419898c87e80ed360b06e287225de00a.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: SCO: fix sco_conn double free on outgoing
 connect
From: Pauli Virtanen <pav@iki.fi>
To: Baul Lee <baul.lee@xbow.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, federico.kirschbaum@xbow.com,
 	stable@vger.kernel.org, Your Name <qwe.aldo@gmail.com>
Date: Sun, 26 Jul 2026 13:15:57 +0300
In-Reply-To: <20260726055431.42350-1-baul.lee@xbow.com>
References: <20260726055431.42350-1-baul.lee@xbow.com>
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

Hi,

su, 2026-07-26 kello 14:54 +0900, Baul Lee kirjoitti:
> sco_conn is refcounted with a kref that sco_conn_add() initialises to 1.
> That single reference is the connection's association reference, owned
> by the hcon and released when the link goes down.
>=20
> The incoming attach path takes an extra reference for the socket before
> __sco_chan_add(), but the outgoing path, sco_connect() -> sco_chan_add(),
> does not.  An outgoing SCO socket is therefore attached while conn->ref
> is still 1, and two unrelated teardown paths both release that one
> reference: sco_chan_del(), reached from close(), and the !sk branch of
> sco_conn_del(), reached from the sco_connect_cfm() / sco_disconn_cfm()
> callbacks.

This appears to break closing SCO connections, indeed "SCO Disconnect -
Success" fails now, due to hci_conn_drop() not called on socket close
since one sco_conn refcount is now owned by hci_conn::sco_data.

The socket should own a hci_conn_hold/drop refcount that it drops when
closing.

Another option is to have only socket own sco_conn, like here
https://lore.kernel.org/linux-bluetooth/20260725195230.967546-1-qwe.aldo@gm=
ail.com/

However, in that solution one would still need additional
synchronization to deal with the race between sco_conn_del(),
sco_conn_free(), sco_conn_add() vs. hci_conn::sco_data access
https://lore.kernel.org/linux-bluetooth/b84fd01c20f0d2975c7817da345a6937d67=
cf314.1784923689.git.pav@iki.fi/


In the patch here there seems to be some remaining UAF, could make
sense to try to address them while at it

sco_chan_del()				sco_conn_del()
  sco_conn_lock
  conn->sk =3D NULL
  sco_conn_unlock
					sk =3D ... /* =3D NULL */
  					if (!sk)
					  { sco_conn_put; return;=C2=A0}
					/* free hci_conn */
  sco_conn_put
    conn->hcon->sco_data =3D NULL /* UAF */

and

sco_sock_timeout()			sco_conn_del()
  conn =3D ...				conn =3D ...
  ...	  				...
					sco_conn_put()
					free hci_conn
  sco_conn_put()
    conn->hcon->sco_data =3D NULL /* UAF */

since access to sco_data is not serialized by any lock. Probably it can
be cleared in sco_conn_del() so it can get
__guarded_by(&hdev->lock) context analysis annotation
https://docs.kernel.org/dev-tools/context-analysis.html

> When an outgoing SCO setup fails while the socket is being closed, the
> two race, starting from conn->ref =3D=3D 1:
>=20
>   1. sco_chan_del() clears conn->sk.
>   2. sco_conn_del() takes a temporary reference (ref 2) and, seeing
>      conn->sk already cleared, gets a NULL sk.
>   3. sco_chan_del() puts the reference it believes it owns (ref 1).
>   4. sco_conn_del() drops its temporary reference (ref 0) and the
>      sco_conn is freed.
>   5. sco_conn_del() takes the !sk branch and puts the freed object.
>=20
> KASAN reports a slab-use-after-free of the kmalloc-128 sco_conn in
> sco_chan_del(), followed by a refcount_t underflow.  Both operations are
> reachable from an unprivileged AF_BLUETOOTH / BTPROTO_SCO socket doing
> connect() and close().
>=20
> Give the socket its own reference on the outgoing attach so that the two
> teardown owners no longer contend for a single reference, and drop the
> association reference in sco_conn_del()'s socket-kill path so that it is
> released exactly once there as well, symmetrically with the existing !sk
> branch.  sco_conn_ready() consequently has to take both references
> itself, because sco_connect_cfm() puts the one from sco_conn_add() as
> soon as sco_conn_ready() returns.
>=20
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> Reported privately to the maintainers on 2026-07-10 with root-cause
> analysis, a PoC, a KASAN log and this fix; posting to the list was
> requested as the follow-up.
>=20
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  net/bluetooth/sco.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index c05f79b7aa31..3db6552de06c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -276,6 +276,9 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
>  	sco_chan_del(sk, err);
>  	release_sock(sk);
>  	sock_put(sk);
> +
> +	/* Drop the association reference, as the !sk branch above does */
> +	sco_conn_put(conn);
>  }
> =20
>  static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
> @@ -296,10 +299,16 @@ static int sco_chan_add(struct sco_conn *conn, stru=
ct sock *sk,
>  	int err =3D 0;
> =20
>  	sco_conn_lock(conn);
> -	if (conn->sk || sco_pi(sk)->conn)
> +	if (conn->sk || sco_pi(sk)->conn) {
>  		err =3D -EBUSY;
> -	else
> +	} else {
> +		/* Take the socket reference, which sco_chan_del() drops when
> +		 * the socket detaches.  Without it the socket and the hcon
> +		 * would share the single reference from sco_conn_add().
> +		 */
> +		sco_conn_hold(conn);
>  		__sco_chan_add(conn, sk, parent);
> +	}
> =20
>  	sco_conn_unlock(conn);
>  	return err;
> @@ -1452,6 +1461,13 @@ static void sco_conn_ready(struct sco_conn *conn)
>  		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
>  		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
> =20
> +		/* Two references are needed here: the socket one, dropped by
> +		 * sco_chan_del(), and the association one, dropped by
> +		 * sco_conn_del().  Unlike the outgoing path, the reference
> +		 * from sco_conn_add() cannot serve as the latter, because
> +		 * sco_connect_cfm() puts it as soon as this function returns.
> +		 */
> +		sco_conn_hold(conn);
>  		sco_conn_hold(conn);

I think it would be stylistically better to have the holds where they
are assigned to the fields that own the references, and the puts where
the variable is cleared.

>  		hci_conn_hold(conn->hcon);
>  		__sco_chan_add(conn, sk, parent);

--=20
Pauli Virtanen
