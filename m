Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9635DA67
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523758; cv=none; b=grcJQovcOaa16y89p2t8WSIyec5/EaXPg0eZXzBNfHdvdqA2lc0Lrqk4FM71q7pntZ61WA39YBV5DPSYHlb2KGIIR7wvIvajis8wmcNj5gpkzIOQn6gopCahze1HJ8qiLVIwGd0GCINEUA8bY8ZashaXyg0lZWWwhZbmY0lrlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523758; c=relaxed/simple;
	bh=t/2+b3AtJsgFR8IXWrWjkRg7jB/phfUvb6Q/32KrePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKQG+/BGbATCxXffdMKQy59pMNpvIIvGyCoaYZpTVYerEVcrVsxX+65/CV4+55d7D4PS2OYc76NIPcw0IRv4F739/mFfffiyj+AkZKLq0++9G4mI7ouaM8Emr7MOav2F0fFWp3x5/CbotBlHogZMtbzE4/qKG1hB1KyJYBRwkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fl9VLe34; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl9VLe34"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847aa193d98so687997b3a.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783523756; x=1784128556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Fg8Se2hiAKXkLJuouIxenZYWdQVVvaSqK94he9SndE=;
        b=fl9VLe34V+9HzgKP0uFtHcQa87HqU4khIq/uoAwE74G/InGQIX8dGbGcA9cZD3qjVi
         sCaiycEpUnaNPiZ6NeSxmZjoYWLiSGRvjQBkF2PMYcnkAUFLJxsrCADh0qXZOWe1aEIG
         KSdafkWs86qLC+a2ZLFgIKJ5uhciVSD7pIfggfgwtMiejq8ur6/M5O+3iKWOtjWXeI40
         1de+qHZbOBTu2x7cMjJlufstIHKtCRuH/UIEIgNbIcgKgPjV5JeYAe4XD/R1HWVFWcb6
         J+PUr8SvPn7ix+N8/6JxwiReiH+nLYNvSG1MJjTp+5N49+YZxw2LROduQYqh3BwzpK58
         tAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523756; x=1784128556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Fg8Se2hiAKXkLJuouIxenZYWdQVVvaSqK94he9SndE=;
        b=ktrx7KNpHK9Czlya08m+mai1Ru0G8/rdIbnGweo+wtxKFZrv9r1KCtCcojR3QHeyXb
         7LPza0aOwVX36nhJbonPQdINNQp+m7pyQL9lQ7149xSEqK61ntrPmu0ey0v/egOzUCT5
         tYAZnzBA7nCql5FsXMGjtuD2EmBtf1PHVZB2zO3OJqQnl+tX/+rFphwwo/XUti4weo+X
         X3fxuw6RkYVIa1IN75VzbXJHPDLkxYKVEOXCK5ECmSOw2PE59aGtPvsZqA2bDzBOUMqT
         FNdwElnqAT6wm08F9a2HdEW2ZSERetoQQga687jPagKDim/6hnqNJMZM3ODpJcXi9MHV
         VoGw==
X-Forwarded-Encrypted: i=1; AHgh+RqMX4WCe7rzzGT2Pgbd+UHnnERBp2jQPlLPPm6UjAgYIIS9L1osL/4VrDBm/HLRQSMV/aMKeII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURLivqCIx9OfD49r+eJyEm9l6Z+k2umKLOSONDAY92BhW0Ja2
	+cwKAnFr9ycMh7ibFW0Cfimj3OMhTJGFJ0W5mo4t0EfyXcJPl5ARel5ljWigkww/Yw==
X-Gm-Gg: AfdE7cnQOLw03r7XP9LH0WxkFMjRrR5GamyJ8XbGp5l7hMCFkva3g2ncb3UeOEHlGok
	TuLgV64V7jqQuuQe8cmj82UiMkMPy47AagMv3RberQoPR1fX3Vgzl1TR6M+a82/A2VxH9ZhJgX/
	BMSuJxjOMeyFITb0eOJmJ6M9N9a39zXcWDJUrIVWGeSeWRrvF+SUAnhE3DaILCYWR+lloHKkeH2
	sH9PW6ZfOKH0T36k1ociuNN84cXDE5T/wG23nTVGs1adyDYsbOPI9xrAz6b6oRej0i/gwcllCZk
	A62dA5czsU/0G/7N8w1eiYB3nh/WQptfV0HgWGx90Ppld+76irdt/R91yWy54WLQ9FgYptyvHvn
	o5ze1uvrcHGeR+PrXsSnSyyiA2MeGMdiTC35g7/LfbhPyv0lMIzdugLML+YK6Aoie9wZ+5ATfGv
	J7kbaq9YiKnd8qcZ04cpiplgzUFgACkPtAvunpCDnN+yqr0pNYauo=
X-Received: by 2002:a05:6a00:148f:b0:847:9565:7a58 with SMTP id d2e1a72fcca58-84843410c9cmr3189929b3a.48.1783523754936;
        Wed, 08 Jul 2026 08:15:54 -0700 (PDT)
Received: from google.com (139.131.233.35.bc.googleusercontent.com. [35.233.131.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6162esm7388680b3a.11.2026.07.08.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:15:53 -0700 (PDT)
Date: Wed, 8 Jul 2026 15:15:50 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix race condition and ordering in
 port unregistration
Message-ID: <ak5pptaSqRi2222y@google.com>
References: <20260707141736.1635698-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="edq91EuV5EjNbSUI"
Content-Disposition: inline
In-Reply-To: <20260707141736.1635698-1-akuchynski@chromium.org>


--edq91EuV5EjNbSUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 02:17:36PM +0000, Andrei Kuchynski wrote:
> A synchronization issue exists during port unregistration where pending
> partner work items can race against workqueue destruction, leading to
> use-after-free conditions:
>=20
>   cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:__queue_work+0x83/0x4a0
>   Call Trace:
>     <IRQ>
>     __cfi_delayed_work_timer_fn+0x10/0x10
>     run_timer_softirq+0x3b6/0xbd0
>     sched_clock_cpu+0xc/0x110
>     irq_exit_rcu+0x18d/0x330
>     fred_sysvec_apic_timer_interrupt+0x5e/0x80
>=20
> Fix this by ensuring strict ordering and proper serialization during
> teardown:
>=20
> 1. Move ucsi_unregister_partner() to the beginning of the teardown
> sequence and protect it under the connector mutex lock.
> 2. Ensure all pending partner tasks are explicitly flushed and finished
> before the workqueue is destroyed.
> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
> queue_delayed_work() sequence. This guarantees that items currently marked
> as pending won't be scheduled an additional time, preventing a double
> release of resources which leads to the following crash:
>=20
>   Oops: general protection fault, probably for non-canonical address
>     0xdead000000000122: 0000 [#1] SMP NOPTI
>   Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
>   RIP: 0010:ucsi_poll_worker+0x65/0x1e0
>   Call Trace:
>   <TASK>
>     process_scheduled_works+0x218/0x6d0
>     worker_thread+0x188/0x3f0
>     __cfi_worker_thread+0x10/0x10
>     kthread+0x226/0x2a0
>=20
> To ensure these rules are applied identically across both the normal
> teardown and the ucsi_init() error paths, consolidate the cleanup logic
> into a new helper, ucsi_unregister_port().
>=20
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner=
 tasks like alt mode checking")
> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are =
flushed")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>


Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 92166a3725b16..d9668ed7c80ea 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, s=
truct ucsi_connector *con)
>  	return ret;
>  }
> =20
> +static void ucsi_unregister_port(struct ucsi_connector *con)
> +{
> +	struct ucsi_work *uwork;
> +
> +	if (con->wq) {
> +		mutex_lock(&con->lock);
> +		ucsi_unregister_partner(con);
> +		/*
> +		 * queue delayed items immediately so they can execute
> +		 * and free themselves before the wq is destroyed
> +		 */
> +		list_for_each_entry(uwork, &con->partner_tasks, node) {
> +			if (cancel_delayed_work(&uwork->work))
> +				queue_delayed_work(con->wq, &uwork->work, 0);
> +		}
> +		mutex_unlock(&con->lock);
> +
> +		destroy_workqueue(con->wq);
> +		con->wq =3D NULL;
> +	} else {
> +		ucsi_unregister_partner(con);
> +	}
> +
> +	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> +	ucsi_unregister_port_psy(con);
> +
> +	usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> +	con->port_sink_caps =3D NULL;
> +	usb_power_delivery_unregister_capabilities(con->port_source_caps);
> +	con->port_source_caps =3D NULL;
> +	usb_power_delivery_unregister(con->pd);
> +	con->pd =3D NULL;
> +	typec_unregister_port(con->port);
> +	con->port =3D NULL;
> +}
> +
>  static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>  {
>  	u16 features =3D ucsi->cap.features;
> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
>  	for (i =3D 0; i < ucsi->cap.num_connectors; i++)
>  		lockdep_unregister_key(&connector[i].lock_key);
> =20
> -	for (con =3D connector; con->port; con++) {
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> -		ucsi_unregister_partner(con);
> -		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(con);
> -
> -		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> -		con->port_sink_caps =3D NULL;
> -		usb_power_delivery_unregister_capabilities(con->port_source_caps);
> -		con->port_source_caps =3D NULL;
> -		usb_power_delivery_unregister(con->pd);
> -		con->pd =3D NULL;
> -		typec_unregister_port(con->port);
> -		con->port =3D NULL;
> -	}
> +	for (con =3D connector; con->port; con++)
> +		ucsi_unregister_port(con);
>  	kfree(connector);
>  err_reset:
>  	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
> @@ -2194,33 +2216,7 @@ void ucsi_unregister(struct ucsi *ucsi)
> =20
>  	for (i =3D 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -
> -		if (ucsi->connector[i].wq) {
> -			struct ucsi_work *uwork;
> -
> -			mutex_lock(&ucsi->connector[i].lock);
> -			/*
> -			 * queue delayed items immediately so they can execute
> -			 * and free themselves before the wq is destroyed
> -			 */
> -			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
> -				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
> -			mutex_unlock(&ucsi->connector[i].lock);
> -			destroy_workqueue(ucsi->connector[i].wq);
> -		}
> -
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
> -
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sin=
k_caps);
> -		ucsi->connector[i].port_sink_caps =3D NULL;
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sou=
rce_caps);
> -		ucsi->connector[i].port_source_caps =3D NULL;
> -		usb_power_delivery_unregister(ucsi->connector[i].pd);
> -		ucsi->connector[i].pd =3D NULL;
> -		typec_unregister_port(ucsi->connector[i].port);
> +		ucsi_unregister_port(&ucsi->connector[i]);
>  		lockdep_unregister_key(&ucsi->connector[i].lock_key);
>  	}
> =20
> --=20
> 2.55.0.rc2.803.g1fd1e6609c-goog
>=20

--edq91EuV5EjNbSUI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCak5ppgAKCRBzbaomhzOw
wlxHAP4puQBBoKeFh99egJECKxdSCdFUxfCSUb1XzHyoHFACKAD+Mrrjo9yfscIG
pt7U6AG5lHOmIxohvgQdvj5J/ZFC0wQ=
=VWtv
-----END PGP SIGNATURE-----

--edq91EuV5EjNbSUI--
