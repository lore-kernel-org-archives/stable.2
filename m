Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322A2E2852;
	Thu, 23 Jul 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847064; cv=pass; b=LrlBC++LAVpQW9D1ZP3NdaNeBp0Oy4FtJxfrjNHezUkDwubGAVqrCJbUvuiKQHhBhQWjvaQqAnJYY+j3hRGlf7hBSLobbWdnCw9ZW2qG7VAbvAVbSXEHyBZhRhwhT5nuHznKRBDfoqPdOYouKOo0/YOMAeNF58r1oZ3DGyHMy0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847064; c=relaxed/simple;
	bh=xoDpaocALmKchSnMPYSMoCABpXFnKJw8Y8/B6LZ/p3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVViudbnc12Ywrc4fIjfY+uSYWV9xinvsY9celMKxK5/GtPrzdt1QRpkuoYEz1SOpGp/WUWVuEACvGBQMYXy3tIc1sG01yMJN1VcObI0Rd9BRcqYTygupgonP8DhXuyyNgePX6top7qtKZVQRArNl59+gQBM5t00WfRH8j9aLuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CEUPk+Gj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CEUPk+Gj"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h5mYh1c8Hz4BKRJ;
	Fri, 24 Jul 2026 01:50:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784847049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v1P+rY5Ge4J61es0jwAxOOq95yCSXdYbAfSULP3DPsE=;
	b=CEUPk+GjXsoOOeia4vDOPGVdlIqetQ0McdbjBdv5nfd9MDn+co9NvRlBnk6pIEvpD1jfpv
	3lXpjvVkmbuzUZ71kMDqYEqm7Yw6QFSmNt9gQe5bLlHxjowY+pVCiIv0gL+wsVRSqAE+K7
	TdI4nx95yOMnw+OLlyAiuouN+gVJatZvu+psnTHyOO7rVJjzzJp1c3zEBEyBpGenmPvILb
	NqEm3Flwza0SARe4ORPU9RL+F3EItkePtNR15S+eV+mGHB7zuFkzhhcN+M0SI66pi0r/DE
	GBDsJfYEAGVNz5PGd7tXDXeLYQCjvdU1Oc8CwyuvOM9wRGAYn722lRzuiC8P4w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784847049;
	b=vNbEhkYTPFy7BQDMXkgp1gUr+7CJWg/MBkVREy+jxlEX7pgeSfVJAVD2drKz+n0b0yqDCz
	le+i2GvccFemQLw2mf6xEV73BjaSeP3MlHorMTfygnrCVhqleO02yjihtYi53ngRQlFy3U
	DMbfxQEQh4XO6aXwIQ+3mjGa5PzNcaqcYRs0cRS1yBIwzB9nzSc7rxk0QvfACM73OTSY+l
	F4oqDL+fDPCfLPcFL/+Ne6lZlBhLO12ShHCMZr8zOMgE0pUJQckZkP52OS1v9qOwrw9i+i
	DYh2TIHJgGp//ZFihipY79fck0DcZQV+oVKya3gOH4LO86FY1hpsy6UlZZ6kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784847049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v1P+rY5Ge4J61es0jwAxOOq95yCSXdYbAfSULP3DPsE=;
	b=eCws4n47b7soUG1824rSitVjZV+gFMcRnfXk94k66cqkxasA+gqaC44zKKaUIVxGsuRHmF
	JcQl+ER0Glktmm9abfdwR+m5yuYh52CmSY+SnnrInJPtOes62nj8YIBz8RWS2lmHTkd24w
	Ia0kgqU7YbXgZqzD+agJi1UOroFi4rcSYvEOoJUL7mt3n4HWvBZUFSz6cC9sUFkmDmPOlH
	1lIuQlhVWzOmRjBJ/xclWErCxFbtoDuLLsHKH74SnHpWQHmJfEKfUmLf0RU7cTgZ1U5C+Z
	jbiYgVHKJyVAw5cpmARDl0dZOrSpkj6d7poeJIvN+MPO3Vgm94QVxuqud8aMwQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <da921aaf7893dff6cb0c9352e0f06f94fa6b6e84.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: SCO: fix refcount over-put in sco_conn_del()
From: Pauli Virtanen <pav@iki.fi>
To: Your Name <qwe.aldo@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 	stable@vger.kernel.org
Date: Fri, 24 Jul 2026 01:50:45 +0300
In-Reply-To: <20260723221014.527674-1-you@example.com>
References: <20260723221014.527674-1-you@example.com>
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

to, 2026-07-23 kello 19:10 -0300, Your Name kirjoitti:
> From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>=20
> sco_conn_del() takes exactly one transient reference to the sco_conn via
> sco_conn_hold_unless_zero() and drops it with the sco_conn_put() that
> follows sco_sock_hold().  The additional sco_conn_put() in the !sk branch
> drops a reference the function never acquired:
>=20
> 	conn =3D sco_conn_hold_unless_zero(conn);
> 	if (!conn)
> 		return;
> 	...
> 	sco_conn_lock(conn);
> 	sk =3D sco_sock_hold(conn);
> 	sco_conn_unlock(conn);
> 	sco_conn_put(conn);
>=20
> 	if (!sk) {
> 		sco_conn_put(conn);	/* drops a reference we do not own */
> 		return;
> 	}
>=20
> sco_sock_timeout() has the same entry semantics -- one
> sco_conn_hold_unless_zero(), no incoming reference owned -- and simply
> returns from its !sk branch with no second put.
>=20
> In steady state the only counted reference to a struct sco_conn is the
> one held by the socket.  When close() races the controller's Disconnectio=
n
> Complete, sco_chan_del() clears conn->sk and drops the socket reference
> while sco_conn_del() is running.  sco_conn_del() then observes sk =3D=3D =
NULL,
> its own put drops the count to zero and frees the conn, and the second pu=
t
> writes to the freed kref:
>=20
>   BUG: KASAN: slab-use-after-free in sco_conn_put.part.0+0x1a/0x190
>   Write of size 4 at addr ffff8881099dec74 by task kworker/u17:3/413
>   Workqueue: hci1 hci_rx_work
>   Call Trace:
>    sco_conn_put.part.0+0x1a/0x190
>    hci_disconn_complete_evt+0x1ee/0x3e0
>    hci_event_packet+0x54a/0x650
>    hci_rx_work+0x321/0x3d0
>   Allocated by task 413:
>    sco_conn_add+0x72/0x1a0
>    sco_connect_cfm+0x88/0x670
>    hci_conn_complete_evt+0x4c5/0x890
>   Freed by task 413:
>    sco_conn_del.isra.0+0x3f/0xf0
>    hci_disconn_complete_evt+0x1ee/0x3e0
>   refcount_t: underflow; use-after-free.
>=20
> The freed object is a kmalloc-128 allocation, so this is an out-of-bounds
> write into a reclaimed slab object rather than a plain crash.  Opening an
> SCO socket requires no capability, and the race is reached whenever the
> controller delivers a Disconnection Complete concurrently with the socket
> being closed.
>=20
> A related refcount imbalance introduced by the same commit was already
> fixed in commit ed9588554943 ("Bluetooth: SCO: remove the redundant
> sco_conn_put").
>=20
> Drop the extra put so the !sk branch simply returns.
>=20
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  net/bluetooth/sco.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index fcc597be5bbd..6502fcdfc0f0 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -265,10 +265,8 @@ static void sco_conn_del(struct hci_conn *hcon, int =
err)
>  	sco_conn_unlock(conn);
>  	sco_conn_put(conn);
> =20
> -	if (!sk) {
> -		sco_conn_put(conn);
> +	if (!sk)
>  		return;

This will leak the sco_conn under some conditions, you probably need
something like the below and check all code paths touching the sco_conn
are consistent who owns the reference.=20

Previously the idea appears to have been it is sometimes owned by
hci_conn::sco_data but it's probably simpler vs race conditions to have
it owned only by sco_pi(sk)->conn.

With this change, sco_conn_free() probably should not touch
sco_pi(conn->sk)->conn

Please also check the hci_conn_drop() refcounting vs. hci_connect_sco()
is OK.

Please also describe to what extent this was tested.


diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c05f79b7aa31..3000b723f081 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -283,7 +283,7 @@ static void __sco_chan_add(struct sco_conn *conn,
struct sock *sk,
 {
        BT_DBG("conn %p", conn);
=20
-       sco_pi(sk)->conn =3D conn;
+       sco_pi(sk)->conn =3D sco_conn_hold(conn);
        conn->sk =3D sk;
=20
        if (parent)
@@ -366,12 +366,14 @@ static int sco_connect(struct sock *sk)
         */
        if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
                release_sock(sk);
+               sco_conn_put(conn);
                hci_conn_drop(hcon);
                err =3D -EBADFD;
                goto unlock;
        }
=20
        err =3D sco_chan_add(conn, sk, NULL);
+       sco_conn_put(conn);
        if (err) {
                release_sock(sk);
                hci_conn_drop(hcon);
@@ -1452,7 +1454,6 @@ static void sco_conn_ready(struct sco_conn *conn)
                bacpy(&sco_pi(sk)->src, &conn->hcon->src);
                bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
=20
-               sco_conn_hold(conn);
                hci_conn_hold(conn->hcon);
                __sco_chan_add(conn, sk, parent);

> -	}
> =20
>  	/* Kill socket */
>  	lock_sock(sk);

--=20
Pauli Virtanen
