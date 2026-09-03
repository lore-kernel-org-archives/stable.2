Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D54CA276;
	Thu,  3 Sep 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448302; cv=pass; b=DNAHKe82TuuwlfgdEqY8WfSFuVD9mQt9Qao+4gmB7p8RAoEE00SSWl/PI58wFoRayvrXb7NL9/nbx395J5KcC9vMU43WqKK9ZstXQJpX4tBCN1MitGJHjjJ+q4a8fy76T9iuc7QUyaVr5htvJ+TfwqxaOLoT5P9Klx5OovInfLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448302; c=relaxed/simple;
	bh=v1PmPKoCt8nkso29KKmnve7NuIketKrvKoYM14WDueA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auvyGbkediwy9/+T8Ov+OoOoNI0hcDQ/+9JronQ8SrfOY7h2dhGEmJevlctV0kxxqDnDZ7RrJaK+GWhQzngeagnNUXe4D8oi+kdp6m0Q/dE2iggY87VyE0hXig56u//t/NjM9Tjc36PX0CVPuyo23y9wZf+p/fE4eoPBf4psYT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qT8fsDYj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qT8fsDYj"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hbNNN3yVSz49Py3;
	Thu, 03 Sep 2026 18:11:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788448293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z18BtSKIVrhss/X0bbm3YVQE1cHTU3NzWn05WQF3Cwo=;
	b=qT8fsDYj7XAX8NB2vx+tO/w/ajfsw1aJFuNZGs2r49OxUjkzvL8BHd1ERcW+D1oGoa/3Ey
	Pz5yPNpNJ7UCbIcZ5GZBjp/g4ITC7x4FwM7bCdsuB6V369VKNdRApEXMSD5f39BjcgYjLy
	3xqeeREBLSOKlkgPDqBdkpbekCfLtsrTSyLbi8or+EQovC3lxJPiMhktZ1c0G+VirPpIth
	p0+SCptAHTwlS+JFF664N9a1N6HK0L7/TosT0Mpup3/gYFVcH4JgZl4GV8sZ6akcRBmxib
	OXYBjNbUHXi1UJiv1I77to6rOx1WbgNhZfVHmOStZOND4EFopQC8nlyJ0C7gjw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788448293;
	b=CA5um7z12vvlMSMSGsU7f2BUGuf88A/MhdKx755JvnE4MqDmmhf5V4OI03OKJvsjiHhf53
	US2RJbhsWuQh6+5osEpLAenvyWmXQn4MZECWFKVB7ehIwVcU9gp3NFlUFT/2YAfuT3gd7u
	TSDXmUQZ9gcRGV9GaSyh1TTd2qoYw9EaHlnPsk9Te6lhfJCbRrM/imP6yiy5VIo0XLc2+3
	kiFv3UAgXEROX/w4G3m/MJP9TG0OLKZxJBmrOpXoMhnLVqEesYpqsVxd9k1rdftgBGVm7D
	b8un/xWX4n0Lz1rHykc7G65tcUAMFefUEi0AzopRSQ47RJPaHjUIOELf85xPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788448293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z18BtSKIVrhss/X0bbm3YVQE1cHTU3NzWn05WQF3Cwo=;
	b=qQPXBChsZIDfmjL8mAEqL7qNwERSr8IJKLBiahfrIvenfbGATRT2UhRncxb+es5LQVwCek
	70YzFJHTPj8YM43MoL9WIGNya6h9I5STvwIyf1XdCg+g7F/0ot9dju7UZgzblrU6ekDYie
	q2up2eWrRiBGE7suPJ9wjdqMAFA3evVouViunXaL3MsVyefHd9X2hvYFYOE8V7habqcYQ1
	F+Q9hw8YZKKtasHngpAxIBYZg+OjMyZ89BtorZ+qz+8zHkl0DI8VfKjGc87B5d40mbp/ae
	o9F0ABIVTlpU29QhydE2ibvcVocTf9kIrkVzVxrkoFgpUohjQ9lOEKoon/roRw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <3674f5d34d731403bfa0e680c9e5718237612315.camel@iki.fi>
Subject: Re: [PATCH v2 1/1] Bluetooth: Fix parent socket UAF in accept queues
From: Pauli Virtanen <pav@iki.fi>
To: Zihan Xi <zihanx@nebusec.ai>, linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz	
 <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 03 Sep 2026 18:11:29 +0300
In-Reply-To: <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
References: <cover.1788259244.git.zihanx@nebusec.ai>
	 <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
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

to, 2026-09-03 kello 11:11 +0000, Zihan Xi kirjoitti:
> Bluetooth children queued on a listening socket store the listener in
> bt_sk(sk)->parent, but the accept queue did not hold a reference on
> that parent socket.  The child side can later fetch that pointer and
> unlink itself from the accept queue while still needing to notify the
> listener, for example from L2CAP, ISO or RFCOMM teardown/state-change
> callbacks.

Please revalidate the KASAN crash on current bluetooth-next/master,
there have been related fixes since v1 of the patch and the v7.2-rc6
shown in the KASAN crash in the cover letter.

With commit d4bfa78fd679 ("Bluetooth: L2CAP: reject accept queue add
unless BT_LISTEN") in v7.3-rc1 cherry-picked on v7.2-rc6 the POC no
longer reproduces for me.

***

The design intent AFAICS is that the accept queue of the parent socket
shall be empty when the parent socket is freed.

Otherwise, the child sockets in accept queue would leak.

There must then be parent->sk_state =3D=3D BT_LISTEN check before
bt_accept_enqueue() and some were missing in v7.2-rc6.

bt_sk(sk)->parent read/write is guarded by lock_sock(sk), and it is set
to NULL when removed from accept queue.

Dangling bt_sk(sk)->parent should then not occur.

If bt_sk(sk)->parent !=3D NULL is observed under lock_sock(sk), the
parent socket is valid during that critical section.

The sock_hold/put(parent) in this patch are in lock_sock(sk) critical
sections, so should be no-ops.

The accept queue items owning reference to parent also should be no-
ops.

> If the listener is closed concurrently, removing the child from the
> accept queue can drop the last listener reference before those
> callbacks call parent->sk_data_ready(parent), leaving a stale parent
> pointer and a use-after-free.
>=20
> Take a reference on the parent when a child is queued and drop it when
> the child is unlinked.  Since unlinking now drops the accept-queue
> parent reference, take a temporary parent reference in the callbacks
> that continue to notify the parent after bt_accept_unlink().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v2:
>   - rebase onto current bluetooth-next
>   - refresh trailers to the current submission template
>   - retarget author identity to Zihan Xi <zihanx@nebusec.ai>
>   - v1 Link: https://lore.kernel.org/all/65767989c644f8adf52f35334f4034c6=
6f47881f.1784383243.git.xizh2024@lzu.edu.cn/
>=20
>  net/bluetooth/af_bluetooth.c | 2 ++
>  net/bluetooth/iso.c          | 2 ++
>  net/bluetooth/l2cap_sock.c   | 2 ++
>  net/bluetooth/rfcomm/sock.c  | 2 ++
>  4 files changed, 8 insertions(+)
>=20
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 411d66f24393..61a232378e6c 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -218,6 +218,7 @@ void bt_accept_enqueue(struct sock *parent, struct so=
ck *sk, bool bh)
>  	BT_DBG("parent %p, sk %p", parent, sk);
> =20
>  	sock_hold(sk);
> +	sock_hold(parent);
> =20
>  	if (bh)
>  		bh_lock_sock_nested(sk);
> @@ -266,6 +267,7 @@ void bt_accept_unlink(struct sock *sk)
>  	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
>  	bt_sk(sk)->parent =3D NULL;
>  	sock_put(sk);
> +	sock_put(parent);
>  }
>  EXPORT_SYMBOL(bt_accept_unlink);
> =20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 75bfd5938b2e..e709292aa112 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -286,8 +286,10 @@ static void iso_chan_del(struct sock *sk, int err)
> =20
>  	parent =3D bt_sk(sk)->parent;
>  	if (parent) {
> +		sock_hold(parent);
>  		bt_accept_unlink(sk);
>  		parent->sk_data_ready(parent);
> +		sock_put(parent);
>  	} else {
>  		sk->sk_state_change(sk);
>  	}
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index b553b6356af8..3720ab2e39ed 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1748,8 +1748,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_ch=
an *chan, int err)
>  		sk->sk_err =3D err;
> =20
>  		if (parent) {
> +			sock_hold(parent);
>  			bt_accept_unlink(sk);
>  			parent->sk_data_ready(parent);
> +			sock_put(parent);
>  		} else {
>  			sk->sk_state_change(sk);
>  		}
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 958081adb9b5..a16daa68ecb8 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -78,11 +78,13 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc =
*d, int err)
> =20
>  	parent =3D bt_sk(sk)->parent;
>  	if (parent) {
> +		sock_hold(parent);
>  		if (d->state =3D=3D BT_CLOSED) {
>  			sock_set_flag(sk, SOCK_ZAPPED);
>  			bt_accept_unlink(sk);
>  		}
>  		parent->sk_data_ready(parent);
> +		sock_put(parent);
>  	} else {
>  		if (d->state =3D=3D BT_CONNECTED)
>  			rfcomm_session_getaddr(d->session,

--=20
Pauli Virtanen
