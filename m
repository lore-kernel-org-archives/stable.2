Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643976;
	b=O9tIaWpigz1xlILL4cKUQzsyQIQFZJeB0mvOZwpEViHjhQSG2zOU1egJIPk7eaa18kE7
	 NF1RD01EN6ZkQwxbvCY+nDwsMW/mgqn/qc28fimemOl43QACwVIn6eLVmut8iq8HQn7bZ
	 B7RFrronhjdtD6TGgUhoXmttF6J90d0DMeqmzArGOA6Zw/IN5iljVi0YjxxuwdnC7dpH3
	 sYxHzmCReSUr5C5XgoGB3Np7oA23pq5GO/8vf16CBDwf15yLRbEGo8nyzI4Mx6j8dEDRx
	 pXUvr2JSrg+B6nf92FmxFK0KcoYzM2pRsSGGSKcGGz4ldvFM0dvs8HGbknncb/Xat+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643976;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=ThEALp9KDam4vLS+PSEBuO21snQDowXhI7y10it8/1s=;
	b=nMWr+PjVNBv/zLlXUqMIuH2n87zDjzNDzQoT4Cl4iECL4kHbfdrBH6eEPpnhbMTFHSdb
	 AIbRTZ4gRFtrQrtWMQJ589e72PWZMb6Yh07CgxkeTctF5q/fxd5Q8yBrj3NhmPi61tlp4
	 mcMhMp2nZ1f9MS+Dv9OlydDmnuW0dKaYoW91gLRFc/fqz6IuXUuL5u095vAGxzXUijAl5
	 0MhYy4w6YZ0KsXzlRAXNt29uzjOTTrTEuTLGbmhF/kmG3u01uz4FiXdZbX2Ooa+AM8mCT
	 BfkIG84/XWrzTu9xDrwQE4uFBLM11Dk5sngn/D250VLbIBlykGgry2LnyTbqs+Id9Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b="d96Rzo/i";
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB5606A319;
	Thu, 22 Oct 2026 04:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54EB5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=d96Rzo/i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792643966;
	bh=ThEALp9KDam4vLS+PSEBuO21snQDowXhI7y10it8/1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d96Rzo/iolCWJqDYNNC41kudhUh5rYxt6JtirOQIdSt72lvSZ7f8H953BODBBe6m3
	 ZtZBeGOuaCWHRtKAc/u9vtsQu5S+E6Rpxv2UK4zHnnTQF2YhVINtzSrm7vY2Bs+b0p
	 PxmBKYt9ernKl5/A4cNCf2LxQM6089l6BHpMaimmq9N7oCySecEv4otfyD9rn7Edk6
	 5chTkTrMenXWHw8M4wCbGJfO+eHZywMBw/vWu5nxAMpdmMKtHBkwfHbLL5ZdegGoWn
	 8ca8ETUDzIms0E9ByEbLSdsilMGFhtWgY2XFCZqaa6u+ShTN0Gc2L+P+7QRfti0otk
	 7fccr5TpxpI+A==
Received: from [192.168.12.105] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7B160707FB;
	Thu, 22 Oct 2026 12:39:25 +0800 (AWST)
Message-ID: <51bf6b10b2fc1c5d6ed7234e61067869380eebad.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] mctp i2c: fix double free of midev on netdev
 register failure
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>, netdev@vger.kernel.org, Jeremy Kerr
	 <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
	 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 12:39:25 +0800
In-Reply-To: <20261022031704.2295541-1-kenny_hsieh@jabil.com>
References: <20261022031704.2295541-1-kenny_hsieh@jabil.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Kenny,

Thanks for looking into this.

On Thu, 2026-10-22 at 11:17 +0800, Kenny Hsieh wrote:
> mctp_i2c_add_netdev() initialises midev before registering the netdev,
> and frees it on its own error path when mctp_register_netdev() fails.
> The netdev's ndo_uninit, mctp_i2c_ndo_uninit(), frees it too.
>=20
> register_netdevice() calls ndo_uninit on its later failures: the
> err_uninit path and a NETDEV_REGISTER notifier error. On those, midev is
> freed twice. The second mctp_i2c_midev_free() runs list_del() on an entry
> that is already poisoned, and drops a second reference on both the
> adapter device and the client device, which can free either early.

I wonder if it would be better to delete mctp_i2c_ndo_uninit() and move the
the mctp_i2c_midev_free() to mctp_i2c_unregister(), before free_netdev().
Then the free sequence would be symmetrical with the init sequence in
mctp_i2c_add_netdev.

Prior to mctp_i2c_midev_free() calling mctp_unregister_netdev() it would ne=
ed
to deselect mcli->sel if matching (the reason mctp_i2c_ndo_uninit() existed=
):

	/* Perform cleanup here to ensure that mcli->sel isn't holding
	 * a reference that would prevent unregister_netdevice()
	 * from completing.

Cheers,
Matt


> Earlier failures do not reach ndo_uninit. mctp_add_dev() failing,
> ethtool_check_ops() failing and a name that is already taken all return
> before it, so the error path's own free is still needed for those.
>=20
> Make mctp_i2c_midev_free() safe to call twice, by clearing midev->client
> once it has run and returning early when it is already clear. Both
> callers keep working unchanged.
>=20
> Tested on an AST2700 BMC by taking the netdev name before creating it,
> so the register fails early with -EEXIST. midev is freed once, and a
> later create on the same adapter succeeds.
>=20
> The double free was pointed out by the Sashiko AI review of a pending
> mctp-i2c change, as a problem that predates it.
>=20
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Closes: https://lore.kernel.org/netdev/179239912623.3135.1135265215662681=
7288@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
> ---
>  drivers/net/mctp/mctp-i2c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d33..bca379af3 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -788,6 +788,13 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev =
*midev)
>  	struct mctp_i2c_client *mcli =3D midev->client;
>  	unsigned long flags;
> =20
> +	/* Runs from ndo_uninit and from the mctp_i2c_add_netdev() error
> +	 * path, and register_netdevice() calls ndo_uninit on some failures
> +	 * but not others. A NULL client means midev is already freed.
> +	 */
> +	if (!mcli)
> +		return;
> +
>  	if (midev->tx_thread) {
>  		kthread_stop(midev->tx_thread);
>  		midev->tx_thread =3D NULL;
> @@ -810,6 +817,7 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *=
midev)
>  	skb_queue_purge(&midev->tx_queue);
>  	put_device(&midev->adapter->dev);
>  	put_device(&mcli->client->dev);
> +	midev->client =3D NULL;
>  }
> =20
>  /* Stops, unregisters, and frees midev */
