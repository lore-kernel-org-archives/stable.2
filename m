Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03687421252;
	Tue, 28 Jul 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234191; cv=pass; b=r7KKCYpHtKBxZx3qhTl8U9wUWrEQ0aL5m3BhTZG2xQCjtTWRwMnhGWcMRcU8yknocJTo31rnjdRbZZU73HbNfUhcUmEYgGZvqQrXJsyPMuxDFavhFbnVO8aGe0cZBYisapxlJxr1FUH6l5PVqxqKADriZlUz2L+EgXzXCGeiU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234191; c=relaxed/simple;
	bh=mQAshLtZJyn/xxNsihL2I9GXjbctJk9On8SHP4nkFII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1lV0hRNaOJUSHgYn+LPOIqCBPqh6Njih6JIQAxIa6jw3dueWNAIwW7FuK3fy92iqcPlVFPHYh3LSV9T85BpQlrHXh7+GWD1Y5S8bKqEWRtGLMP6RvTMJdlsfBAbfSSqAlplK/S5o9zhowOVBpnH6Fqy/DjXDU989x7C4rP65Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e3O5cRzw; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e3O5cRzw"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h8WkR019Cz4BKLT;
	Tue, 28 Jul 2026 13:22:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1785234176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCRS7Rsox+x/ob4FVF1ns9sesLDCnpRHXC6LhZDCTrQ=;
	b=e3O5cRzwaDsfUrBtwE2XtuFQT8CaaE/6CihhPu+qtQJBtkG4lEtKQYsFb/5adl9QTj+aQU
	5gpg9j7BJhHlPilPq+hU0WUOaYc+vtvH779AHPhzArO5exoC/koZ1RAKx6MTWQXXUX0p56
	8Agc1jefnxGuKL79v/l2vs+ccNhfpNxACwCAvVpP47+5X6x/7P2onyVFhuThXf4sEceJRv
	idytLWJ+fLHcxwXwKZB7tnjgEsohARbJ/LLf5gXzd9L+h9ceJ2BOcy5voutFdICP5hS5w8
	yZWALfabrbCCOv0nn0e/nru0r+PmyEmy/Uo1ayW8cJv/6db0Qs/a6mJ4M3dlqg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1785234176;
	b=OGSb3W+1IS025/9LzIYKcgu6sfmkHyN0bE/C+LceYZheWmJJ1jDw8xLFxPIHZODWGtLEBx
	ZIFidomDkQbP91Sfexle/IShKINeQXKo1ZzQZeuPRNWbwClYHmEZxcfD6IHja65827guL2
	DDUYprh0KtkQGmUEAArYO0IPLsCNL/Q7zaopW8NWavUHgHQBvxnz37GY31qSabjiDiCVlS
	I1FM6vHabp3NJM8ZIXrpG0duaztIp8lKWoc+J64NJyAJdLWeidEijt6dInDKnSXLibtvMx
	e22n7ho4YZl0amTIGxuJQuPX8yCjMbzX1PQvk1zSL/DsGLgvWQRiOPFkmRxzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1785234176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCRS7Rsox+x/ob4FVF1ns9sesLDCnpRHXC6LhZDCTrQ=;
	b=tgIrAzDh/T8v6GfeomSfndc/MxomsPn/Wx22xwxwb23VVqkfeevosUznRTaHjsQIDFXiGT
	W9NrjSmrONqT8cxOqqGJHKmo1N1oxz0u1ctYis9nTGbIp5OB7wNNqKr2FJh9t4Xgw5TrSP
	RoEA4cmG2fhQ84vGRJI8SSfGfwb/T6AmlygQ1wDZD6BuzbD5R7VP1v53YyZw6Dtcsl73wd
	47WXeYvZ6VLY7epuJh1aW6NGIKpJJ0TfjX+16dEv/XnKS4qrMoK7f4vAu6aVsss/4M8kxj
	uIgWRT/+W3MxLdzpzc4mY+j5v1gzwOO//agH0gvf6zTBB+OcEnhoUYKhBqe7zA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <8d1dbc2900cb5d19c5de278fa2d41906197cb007.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: SCO: serialise sco_conn lifetime against
 sco_recv_scodata()
From: Pauli Virtanen <pav@iki.fi>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 28 Jul 2026 13:22:52 +0300
In-Reply-To: <20260728042639.1315193-1-qwe.aldo@gmail.com>
References: <20260728042639.1315193-1-qwe.aldo@gmail.com>
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

ti, 2026-07-28 kello 01:26 -0300, Aldo Ariel Panzardo kirjoitti:
> sco_recv_scodata() upgrades the weak hcon->sco_data back-pointer to a
> strong reference under hdev->lock:

iso.c in current bluetooth-next/master kept the weak-reference iso_data
and addressed races in a different way (I had alternative unsent patch
also for the strong ref approach).

Either one should work, strong ref may be a bit simpler.

>     hci_dev_lock(hdev);
>     hcon =3D hci_conn_hash_lookup_handle(hdev, handle);
>     ...
>     conn =3D sco_conn_hold_unless_zero(hcon->sco_data);
>     hci_dev_unlock(hdev);
>=20
> but the pointer is cleared from the other side without that lock. When
> the last sco_conn reference is dropped, sco_conn_free() ran
>=20
>     conn->hcon->sco_data =3D NULL;
>=20
> with no hdev->lock held, so the RX path could read hcon->sco_data and
> call kref_get_unless_zero() on an sco_conn that was concurrently freed:
>=20
>     BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x1=
60
>     Write of size 4 by task kworker/u17:0
>     Workqueue: hci0 hci_rx_work
>     Call Trace:
>      sco_conn_hold_unless_zero+0xbe/0x160
>      sco_recv_scodata+0x13f/0x490
>      hci_rx_work+0x3af/0x730
>=20
> kref_get_unless_zero() only guards against a zero refcount, not against
> the backing memory already being freed.
>=20
> Give hcon->sco_data an actual reference on the sco_conn it points to, so
> the object cannot be freed while the pointer is still installed, and only
> clear and drop it from sco_conn_del(), which runs under hdev->lock (its
> callers, sco_connect_cfm() and sco_disconn_cfm(), hold it). The reader in
> sco_recv_scodata() also takes hdev->lock, so the store and the read are
> now serialised: the RX path either observes NULL or a reference that is
> guaranteed to stay valid until it drops its own.
>=20
> sco_conn_add() no longer hands its kref_init() reference to the caller as
> the connection's only reference; that initial reference is the one owned
> by hcon->sco_data, and callers get their own via sco_conn_hold().
>=20
> Because the sco_conn can now outlive the socket (the association keeps it
> alive until the link goes down), the hci_conn can no longer be dropped
> from sco_conn_free() without regressing socket close: closing a connected
> SCO socket must still tear the link down. Move hci_conn ownership to the
> socket instead: __sco_chan_add() takes an hci_conn reference and it is
> released from sco_chan_del() and sco_sock_destruct(), exactly once. The
> sco_conn no longer owns an hci_conn reference, so sco_conn_add() stops
> consuming one and sco_connect() drops the hci_connect_sco() reference on
> every path; sco_connect_cfm() no longer needs its hci_conn_hold() dance.
>=20
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> Cc: stable@vger.kernel.org
> Suggested-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2: quote the inlined code and KASAN splat in the commit message with
>     spaces instead of hard tabs, to satisfy the bluez CI gitlint check;
>     no functional change (CI sco-tester and sparse pass).
>=20
>  net/bluetooth/sco.c | 84 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 3d4362a09df4..8df0fa48fc60 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -84,12 +84,14 @@ static void sco_conn_free(struct kref *ref)
>  	if (conn->sk)
>  		sco_pi(conn->sk)->conn =3D NULL;
> =20
> -	if (conn->hcon) {
> -		conn->hcon->sco_data =3D NULL;
> -		hci_conn_drop(conn->hcon);
> -	}
> +	/* hcon->sco_data is cleared and the association's reference on the
> +	 * sco_conn is dropped in sco_conn_del() under hdev->lock, and the
> +	 * hci_conn is now owned by the socket (held in __sco_chan_add() and
> +	 * dropped in sco_chan_del()/sco_sock_destruct()), so there is nothing
> +	 * left to release towards hcon here.
> +	 */
> =20
> -	/* Ensure no more work items will run since hci_conn has been dropped *=
/
> +	/* Ensure no more work items will run before the connection is freed */
>  	disable_delayed_work_sync(&conn->timeout_work);
> =20
>  	kfree(conn);
> @@ -188,8 +190,11 @@ static void sco_sock_clear_timer(struct sock *sk)
>  }
> =20
>  /* ---- SCO connections ---- */
> -/* Consumes a reference on @hcon, which the returned sco_conn owns until=
 it is
> - * freed. On failure (NULL return) the reference is left for the caller =
to drop.
> +/* Returns a new reference the caller must drop with sco_conn_put(). The
> + * hcon->sco_data association holds its own reference on the sco_conn fo=
r the
> + * connection's lifetime; it is dropped in sco_conn_del() under hdev->lo=
ck.
> + * @hcon is not consumed: the hci_conn reference is taken and owned by t=
he
> + * socket in __sco_chan_add().
>   */
>  static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
>  {
> @@ -201,9 +206,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn =
*hcon)
>  			sco_conn_lock(conn);
>  			conn->hcon =3D hcon;
>  			sco_conn_unlock(conn);

The above is probably dead code now, is conn->hcon =3D=3D NULL && hcon-
>sco_data !=3D NULL possible?

> -		} else {
> -			/* conn already owns a reference on hcon */
> -			hci_conn_drop(hcon);
>  		}
>  		return conn;
>  	}
> @@ -227,7 +229,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn=
 *hcon)
> =20
>  	BT_DBG("hcon %p conn %p", hcon, conn);
> =20
> -	return conn;
> +	/* kref_init() above set the association reference owned by
> +	 * hcon->sco_data; hand the caller its own reference.
> +	 */
> +	return sco_conn_hold(conn);
>  }
> =20
>  /* Delete channel.
> @@ -242,9 +247,20 @@ static void sco_chan_del(struct sock *sk, int err)
>  	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
> =20
>  	if (conn) {
> +		struct hci_conn *hcon;
> +
>  		sco_conn_lock(conn);
>  		conn->sk =3D NULL;
> +		hcon =3D conn->hcon;
>  		sco_conn_unlock(conn);
> +
> +		/* Release the socket's own reference on the hci_conn taken in
> +		 * __sco_chan_add() so that closing the socket still tears the
> +		 * link down even while the sco_conn is kept alive by the
> +		 * hcon->sco_data association reference.
> +		 */
> +		if (hcon)
> +			hci_conn_drop(hcon);

UAF race here, similarly in sco_sock_destruct()

    [Task 1]                          [Task hdev->workqueue]
    sco_chan_del()                    sco_conn_del()
       sco_conn_lock                    conn =3D sco_conn_hold_unless_zero(=
conn);
       conn->sk =3D NULL                  hcon->sco_data =3D NULL;
       sco_conn_unlock -------------->  sco_conn_lock
                                        sk =3D sco_sock_hold(conn); /* -> N=
ULL */
                                        sco_conn_unlock
					if (!sk) return;
                                      /* caller frees hci_conn */
       hci_conn_drop(hcon) /* UAF */

Moving the drop before conn->sk =3D NULL probably fixes this.

Probably a good idea to have GPT or other recent AI model review your
patch (give sco.c and the patch as context)=C2=A0with prompt that explains
the hci_conn lifetime (iso_conn_del called before free, hci_conn_hold
does not prevent free).

Theres AI review at sashiko.dev which often useful, but it=C2=A0has trouble
understanding hci_conn lifetime, and it didn't get this one.

>  		sco_conn_put(conn);
>  	}
> =20
> @@ -266,6 +282,15 @@ static void sco_conn_del(struct hci_conn *hcon, int =
err)
> =20
>  	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
> =20
> +	/* Detach the connection from the hci_conn and drop the reference held
> +	 * by the hcon->sco_data association.  The caller holds hdev->lock,
> +	 * which serialises this NULL store and put against the read of
> +	 * hcon->sco_data in sco_recv_scodata(), closing the use-after-free
> +	 * where the RX path could upgrade an already-freed sco_conn.
> +	 */
> +	hcon->sco_data =3D NULL;
> +	sco_conn_put(conn);

In this design you can add `void *sco_data __guarded_by(&hdev->lock)`
context analysis annotation, so there's no need for the temporary hold
of sco_data in sco_conn_del() as access is serialized by hdev lock.

> +
>  	sco_conn_lock(conn);
>  	sk =3D sco_sock_hold(conn);
>  	sco_conn_unlock(conn);
> @@ -290,6 +315,13 @@ static void __sco_chan_add(struct sco_conn *conn, st=
ruct sock *sk,
>  	sco_pi(sk)->conn =3D sco_conn_hold(conn);
>  	conn->sk =3D sk;
> =20
> +	/* The socket owns a reference on the hci_conn for as long as it stays
> +	 * attached; it is dropped in sco_chan_del()/sco_sock_destruct().  This
> +	 * keeps close() tearing the link down now that the sco_conn can outliv=
e
> +	 * the socket through the hcon->sco_data association reference.
> +	 */
> +	hci_conn_hold(conn->hcon);
> +
>  	if (parent)
>  		bt_accept_enqueue(parent, sk, true);
>  }
> @@ -371,6 +403,7 @@ static int sco_connect(struct sock *sk)
>  	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
>  		release_sock(sk);
>  		sco_conn_put(conn);
> +		hci_conn_drop(hcon);
>  		err =3D -EBADFD;
>  		goto unlock;
>  	}
> @@ -379,6 +412,7 @@ static int sco_connect(struct sock *sk)
>  	sco_conn_put(conn);
>  	if (err) {
>  		release_sock(sk);
> +		hci_conn_drop(hcon);
>  		goto unlock;
>  	}
> =20
> @@ -395,6 +429,11 @@ static int sco_connect(struct sock *sk)
> =20
>  	release_sock(sk);
> =20
> +	/* The socket took its own hci_conn reference in __sco_chan_add(); drop
> +	 * the one returned by hci_connect_sco().
> +	 */
> +	hci_conn_drop(hcon);

You can move this after __sco_chan_add, probably doesn't need comment.

> +
>  unlock:
>  	hci_dev_unlock(hdev);
>  	hci_dev_put(hdev);
> @@ -495,9 +534,26 @@ static struct sock *sco_get_sock_listen(bdaddr_t *sr=
c)
> =20
>  static void sco_sock_destruct(struct sock *sk)
>  {
> +	struct sco_conn *conn =3D sco_pi(sk)->conn;
> +
>  	BT_DBG("sk %p", sk);
> =20
> -	sco_conn_put(sco_pi(sk)->conn);
> +	/* If the channel was not already torn down via sco_chan_del(), drop th=
e
> +	 * socket's own references here.  sco_chan_del() clears sco_pi(sk)->con=
n,
> +	 * so the hci_conn and sco_conn references are released exactly once.
> +	 */
> +	if (conn) {
> +		struct hci_conn *hcon;
> +
> +		sco_conn_lock(conn);
> +		hcon =3D conn->hcon;
> +		sco_conn_unlock(conn);
> +
> +		if (hcon)
> +			hci_conn_drop(hcon);

UAF since conn->hcon is not valid after conn->sk =3D NULL in
sco_sock_kill.

> +		sco_pi(sk)->conn =3D NULL;
> +		sco_conn_put(conn);
> +	}
> =20
>  	skb_queue_purge(&sk->sk_receive_queue);
>  	skb_queue_purge(&sk->sk_write_queue);
> @@ -1511,12 +1567,10 @@ static void sco_connect_cfm(struct hci_conn *hcon=
, __u8 status)
>  	if (!status) {
>  		struct sco_conn *conn;
> =20
> -		conn =3D sco_conn_add(hci_conn_hold(hcon));
> +		conn =3D sco_conn_add(hcon);
>  		if (conn) {
>  			sco_conn_ready(conn);
>  			sco_conn_put(conn);
> -		} else {
> -			hci_conn_drop(hcon);
>  		}
>  	} else
>  		sco_conn_del(hcon, bt_to_errno(status));

--=20
Pauli Virtanen
