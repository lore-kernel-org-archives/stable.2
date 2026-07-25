Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBF369D66;
	Sat, 25 Jul 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979431; cv=pass; b=LKwoH0pYj7z4m4tp2gP17320do2mhp9A+I9iSld/MH1mj5Pxb6gs1VEM8kUXzIYF+7zw4/CUWvttPkedxtob2W5J7xsrgsa8mPExjb2ttGs9q+J3WXD+ArrUNdNpT2/pBGUAQp7iGwgoY0+qOlXL4gQirQtnb879/OZF8E6JpoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979431; c=relaxed/simple;
	bh=Q2pugquHUKvEq9a9fpNRnVKo3p5HzcNzXlQBSbkruiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=da+01BlvCCVrKVKME+EbPvlV6D1CyR8bAe5eSEBIxwf4qFHXGH5O3OZJqOSBF2++2a0MAppB7/Z8VuRLEKLT1f40Md+Y6ghz80ZmSuCdRBAAUTJDB1ObXdItFRz13q3X1HqnkFswTn11HpEOPhHXLoRbGRhyzQKaNfkBCkqrgqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=k0L6hAhH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="k0L6hAhH"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:e011::d301])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h6jWP3DLdz49QHx;
	Sat, 25 Jul 2026 14:37:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784979425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkYJynOMiW3GnsdQgBx1yOPVJaeCVfgudgf39/FfL6o=;
	b=k0L6hAhHdzOnbrN4hsM7jxVtwt+D10Fwcn38h2uRGXw8Nnu+HrIitXkv4CCnWnpluqsKps
	0jGgPzcrkXB8bQc8mCwf5xroKWhKdOsn7iPJ/9UwkQY9Yny6NT+kowIOOksKxdmmTZ1XcX
	vc9Wh6LPh4uX0sVJeOy2QpSdiHBN4tvmihen0UxOWMXJgJbgew4zQ4PSkGrft0j4TEpKUI
	UtoffG/wQQX7mwBMKf6527CkydYzdJhh9B6aWmnxTsQNElB8rD78hUXfUl1jFQYTRpLEd5
	tNCTUZDf/sjGTuUVycLe6WC1b9Vwnc//a4baN32RZHBeGDtEw4C7OZo2v1McKw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784979425;
	b=R+qiaY7aDREnUUBA0ShETBgdEMbblKD+w+Zc3XCvKvV/xmVABAJyQGIpOPwqhFdyTwDdhv
	RnY3qo6gtDJKCXq0FsvZWqvdHIYdDa/TVkmndfIpT1tyZbKmuGZ10130XfP5x2H4J9JjAS
	yNO0kt383VqvDNSylntK6OG+hygDWdlRaRwL1i2obdDEfiROECpkcWAotbErmCln5qzltr
	N9zjgXQ0o82Q0f+JbmNNQs40TNT60pDsas+JEsSbf1TI/pqMjQQ07QOHr8ZVtaPaio+QV2
	FSdlVYZp0mJhHKxPKoFHYYTpSXksuKUXoGTq2Rteg26dP+AEGetAhM5iLtFzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784979425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkYJynOMiW3GnsdQgBx1yOPVJaeCVfgudgf39/FfL6o=;
	b=N4iSMpa9SvgeUvJb0rxJmONc4eWLBa5x5MUxV5N/kpdr59+MrqeRar9qG4v1CzNIEld9wn
	ESo1v6M8fRV6blQc+msRy5wlrTvD1T4AkUcQBFdVkxjoJjv1jFeoJTHpu+hZQPCHM9oAxP
	vN2dG+bG/X/+Z7lu7QB7VcMf/2JbZg3p+1VMWDMoDLHzeG06TQhbjbG3xIIdfoNgDEQkMa
	y9edplEA8o2uzoMwfTOeICkNTpjFa5o82S0v8gOo0pGdN7L4ezMsBHseq7fvelgkKtBrI+
	8gUri+LHCJkUfyS4SE1Mitj+hN3aQOHw0WJ4K1QY0Mk9bIKw7/32sEPVUm0JGg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <c6e534e497ee771ca80e5f3c6223eaf305bca48c.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: SCO: give the socket its own sco_conn
 reference
From: Pauli Virtanen <pav@iki.fi>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 	stable@vger.kernel.org
Date: Sat, 25 Jul 2026 14:37:04 +0300
In-Reply-To: <20260723232902.792805-1-qwe.aldo@gmail.com>
References: <20260723232902.792805-1-qwe.aldo@gmail.com>
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

to, 2026-07-23 kello 20:29 -0300, Aldo Ariel Panzardo kirjoitti:
> sco_conn_del() drops a reference it does not own. It takes one transient
> reference via sco_conn_hold_unless_zero() and releases it with the
> sco_conn_put() that follows sco_sock_hold(); the additional put in the
> !sk branch releases a second one:
>=20
>     conn =3D sco_conn_hold_unless_zero(conn);
>     ...
>     sk =3D sco_sock_hold(conn);
>     sco_conn_unlock(conn);
>     sco_conn_put(conn);
>=20
>     if (!sk) {
>             sco_conn_put(conn);
>             return;
>     }
>=20
> When close() races the controller's Disconnection Complete, sco_chan_del(=
)
> clears conn->sk and drops the socket's reference while sco_conn_del() is
> running. sco_conn_del() then sees sk =3D=3D NULL, its own put drops the c=
ount
> to zero and frees the conn, and the second put writes to the freed kref:
>=20
>     BUG: KASAN: slab-use-after-free in sco_conn_put.part.0+0x1a/0x190
>     Write of size 4 at addr ffff8881099dec74 by task kworker/u17:3/413
>     Workqueue: hci1 hci_rx_work
>     Call Trace:
>      sco_conn_put.part.0+0x1a/0x190
>      hci_disconn_complete_evt+0x1ee/0x3e0
>      hci_event_packet+0x54a/0x650
>      hci_rx_work+0x321/0x3d0
>     Allocated by task 413:
>      sco_conn_add+0x72/0x1a0
>      sco_connect_cfm+0x88/0x670
>     Freed by task 413:
>      sco_conn_del.isra.0+0x3f/0xf0
>      hci_disconn_complete_evt+0x1ee/0x3e0
>     refcount_t: underflow; use-after-free.
>=20
> Simply deleting the extra put is not enough, because the reference it
> releases is not always accounted for elsewhere. __sco_chan_add() stores
> the connection in the socket without taking a reference:
>=20
>     sco_pi(sk)->conn =3D conn;
>=20
> so the socket inherits whatever reference its caller happened to hold.
> That works out for sco_conn_ready(), which takes an explicit
> sco_conn_hold() beforehand and whose caller puts its own reference, and
> for the success path of sco_connect(), where the reference returned by
> sco_conn_add() is silently handed over and later released by
> sco_sock_destruct(). It does not work out for the two error paths of
> sco_connect(): if the socket state changed while the lock was dropped, or
> if sco_chan_add() returns -EBUSY, the reference from sco_conn_add() is
> never released and the connection is leaked. The extra put in
> sco_conn_del() is what eventually reclaims those orphans, which is why
> removing it in isolation trades a use-after-free for a leak.
>=20
> Make the ownership explicit instead. __sco_chan_add() now takes the
> socket's reference itself, sco_connect() releases the one it got from
> sco_conn_add() on every path, and the now redundant hold in
> sco_conn_ready() is dropped. With the socket holding a counted reference,
> a connection can no longer reach zero while conn->sk is set, so
> sco_conn_free() no longer has to clear sco_pi(conn->sk)->conn. Every
> reference then has exactly one owner: the one sco_conn_add() returns
> belongs to its caller, the socket's is taken and released with the
> channel, and sco_conn_del() and sco_sock_timeout() only ever hold
> transient ones.
>=20
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2:
>  - Do not just delete the extra put: make the socket own its reference,
>    balance sco_connect()'s error paths and drop the redundant hold in
>    sco_conn_ready(), per Pauli Virtanen's review.
>  - Drop the now unreachable sco_pi(conn->sk)->conn clearing in
>    sco_conn_free().
>  - Indent the quoted code with spaces so gitlint stops complaining.
>=20
> On hci_conn_drop() vs hci_connect_sco(), which was also asked about: the
> reference hci_connect_sco() returns is released by hci_conn_drop() on
> each error path of sco_connect(), and on the success path it is handed to
> the connection and released by sco_conn_free(). That side looks balanced.
> There is a separate asymmetry that this patch does not touch: when
> sco_conn_add() returns a connection that already existed for the hcon,
> hci_connect_sco() has taken a fresh hci_conn reference but sco_conn_free(=
)
> only ever issues one hci_conn_drop(). That looks like a pre-existing
> hci_conn leak rather than an sco_conn one; I did not want to fold it into
> this fix.

There's a double drop on the error paths now, so it'll probably hit
WARN_ON() if these are reached, but it's not fatal.

The SCO refcounting rule probably should be that sco_conn owns one
hci_conn_hold reference all of its lifetime.

hci_connect_sco() returns a hci_conn with a new hci_conn_hold reference
given to the caller.

sco_connect_cfm() never gives callee a hci_conn_hold refcount.

So probably (this will have to be thought out better and maybe separate
patch):

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 5cab7e2fb898..0e1dd6a8e6d7 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -185,6 +185,8 @@ static void sco_sock_clear_timer(struct sock *sk)
 }
=20
 /* ---- SCO connections ---- */
+
+/* Consumes hci_conn_hold refcount */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
 	struct sco_conn *conn =3D hcon->sco_data;
@@ -195,6 +197,9 @@ static struct sco_conn *sco_conn_add(struct
hci_conn *hcon)
 			sco_conn_lock(conn);
 			conn->hcon =3D hcon;
 			sco_conn_unlock(conn);
+		} else {
+			/* We already own the refcount */
+			hci_conn_drop(hcon);
 		}
 		return conn;
 	}
@@ -362,7 +367,6 @@ static int sco_connect(struct sock *sk)
 	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
 		release_sock(sk);
 		sco_conn_put(conn);
-		hci_conn_drop(hcon);
 		err =3D -EBADFD;
 		goto unlock;
 	}
@@ -371,7 +375,6 @@ static int sco_connect(struct sock *sk)
 	sco_conn_put(conn);
 	if (err) {
 		release_sock(sk);
-		hci_conn_drop(hcon);
 		goto unlock;
 	}
=20
@@ -1449,7 +1452,6 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
=20
-		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
=20
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)-
>flags))
@@ -1505,7 +1507,7 @@ static void sco_connect_cfm(struct hci_conn
*hcon, __u8 status)
 	if (!status) {
 		struct sco_conn *conn;
=20
-		conn =3D sco_conn_add(hcon);
+		conn =3D sco_conn_add(hci_conn_hold(hcon));
 		if (conn) {
 			sco_conn_ready(conn);
 			sco_conn_put(conn);

>=20
> Testing: the original defect reproduced 45 times across 2 independent
> runs on unmodified v7.2-rc1-240-g71dfdfb0209b with KASAN, driven through
> /dev/vhci by racing close() of an SCO socket against an injected
> Disconnection Complete; both KASAN and the refcount_t underflow fired
> every time. The BlueZ CI ran sco-tester against v1 with no regression.
>=20
>  net/bluetooth/sco.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index fcc597be5bbd..21f829575803 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -81,9 +81,6 @@ static void sco_conn_free(struct kref *r
> =20
>  	BT_DBG("conn %p", conn);
> =20
> -	if (conn->sk)
> -		sco_pi(conn->sk)->conn =3D NULL;
> -
>  	if (conn->hcon) {
>  		conn->hcon->sco_data =3D NULL;
>  		hci_conn_drop(conn->hcon);
> @@ -265,10 +262,8 @@ static void sco_conn_del(struct hci_conn
>  	sco_conn_unlock(conn);
>  	sco_conn_put(conn);
> =20
> -	if (!sk) {
> -		sco_conn_put(conn);
> +	if (!sk)
>  		return;
> -	}
> =20
>  	/* Kill socket */
>  	lock_sock(sk);
> @@ -283,7 +278,7 @@ static void __sco_chan_add(struct sco_co
>  {
>  	BT_DBG("conn %p", conn);
> =20
> -	sco_pi(sk)->conn =3D conn;
> +	sco_pi(sk)->conn =3D sco_conn_hold(conn);
>  	conn->sk =3D sk;
> =20
>  	if (parent)
> @@ -366,12 +361,14 @@ static int sco_connect(struct sock *sk)
>  	 */
>  	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
>  		release_sock(sk);
> +		sco_conn_put(conn);
>  		hci_conn_drop(hcon);
>  		err =3D -EBADFD;
>  		goto unlock;
>  	}
> =20
>  	err =3D sco_chan_add(conn, sk, NULL);
> +	sco_conn_put(conn);
>  	if (err) {
>  		release_sock(sk);
>  		hci_conn_drop(hcon);
> @@ -1439,7 +1436,6 @@ static void sco_conn_ready(struct sco_co
>  		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
>  		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
> =20
> -		sco_conn_hold(conn);
>  		hci_conn_hold(conn->hcon);
>  		__sco_chan_add(conn, sk, parent);
> =20

--=20
Pauli Virtanen
