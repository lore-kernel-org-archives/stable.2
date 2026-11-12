Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794443222;
	b=LQ+Vy4szw7AFpiQ24UwFQTiesx4Mj9HGnEJ6/MtIIg3OyEHbJIsquKMVJ4FYquewH40s
	 ZXNnqwqnyh+Y8LgE3VwWnR2cICE/GRFbuLlEy99HzK+3o2XbDsLGlzdA59mQ2Z/hYR30b
	 2jh+9kZNGVyMG9C0iDen/yXZSQqdPod0lhcPW53zd9Ys4KrVx90OS2ThMDi1PsqRAvhQP
	 4mKiw9mfGc4dd5xwMNe5n4OqSEhgmHrL2AbdmHi5JwkABR43ojjtHKO/qi1ibrx5D1ph/
	 /IeqnfKFKkLm1oMxBBIQGbnbjQtUohGBqMv4KEmYM/YonFCQ1c5ADHz0vKWyQuWqmcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443222;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=5VreXYsAy0I3awJczRv6J15MPIiXQTNkzvzTa1M+ozE=;
	b=N5OIpy79mO1gRH7K4nYGo1D8ZGh080haionfUY4hbQmVuxSA+4QEGDPzQnH7iEt8M7Bd
	 UINJRKE3YMx4/TCS9A4aYuHI1vvLkGh0QojE8JKMsg7Qpa1A6uSpVEwTgAZ60GmBeo+Md
	 j4xrhMhbEN4JpdCTFhjWg9Ioepkca7CPeLyATtyFAvH9U8it2NQOPNwSlxdDi5OEKSMhI
	 GuUOl4Q02WydfECCi6TMPP7KLB9L5EZNMIIkfsnhFRg5SHnEpiuQJr8RIAbWmyLKLJW0e
	 C6PUDd3z1LB2cQ0MOwHh5K3QWWJ2j4b6zGCmTNFLFN06jzN5rrqX6HXI+7KtxbRNRMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Mfkz+Fa1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B673606A321;
	Thu, 12 Nov 2026 00:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B673606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Mfkz+Fa1
ARC-Seal: i=1; a=rsa-sha256; t=1794443214; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KlrRpjV7PnOqRjDmZSsV/5C5d0NGhKqNvDbX/ZE7+MUmbyanGf1iGq+vnq+miIugHawajlegL0/5ZW9fS7/QIscVKStMcD3qwNOxYObdCkHbeT9+AnH9lzyLiW7932hoC4Vr2MPL31EG6IOIt+0rQ+EzzJb6s6sx51olBZUPnRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794443214; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5VreXYsAy0I3awJczRv6J15MPIiXQTNkzvzTa1M+ozE=; 
	b=M7/ds4+3ZJ7AsWr+COAXwD3zO4/C4YC2k/vxS6hYoh9FoXEhABrVHLyUXbeO0pOQjko5PI7vlWwoJvTX0Ovw5fANIZZh4HathdaryUGrSnER3pxwo3KBNj0LdKruLUyfrmMRnKSrtNfcBSVYpS5bfr/5HTbFEV1lOWJLNZ5Y4AM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Mfkz+Fa1b6awllfwudky8/YGJBmDpSowGBpB6PxEVzT0vuFTzo9w7pFG/oWsbBUOQFcrZku5/wo8yoTuiVRUZ03ddtcXyZ+DD/MthnmiRBgQwqlbAyYIFIy1OJuw7H1zui1T9LrT1wkvEuqdjIZiJuoPfeoYP5XrhdKoMKX4MYQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=5VreXYsAy0I3awJczRv6J15MPIiXQTNkzvzTa1M+ozE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179444321247099.65115144573394;
	Wed, 11 Nov 2026 16:26:52 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 1CC9D180BC0; Thu, 12 Nov 2026 01:26:49 +0100 (CET)
Date: Thu, 12 Nov 2026 01:26:49 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	RD Babiera <rdbabiera@google.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] usb: typec: tcpci: Receive SOP' only while sourcing
 VCONN
Message-ID: <avUHqKJtDv2MNV7m@venus>
References: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
 <20261103-husb311-cable-comm-v1-2-6217dabc1a85@flipper.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wr6dlyvciuauighc"
Content-Disposition: inline
In-Reply-To: <20261103-husb311-cable-comm-v1-2-6217dabc1a85@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.427.16
X-ZohoMailClient: External


--wr6dlyvciuauighc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] usb: typec: tcpci: Receive SOP' only while sourcing
 VCONN
MIME-Version: 1.0

Hi,

On Tue, Nov 03, 2026 at 03:21:23PM +0400, Alexey Charkov wrote:
> A TCPC acks every message type enabled in RECEIVE_DETECT and passes it
> on to TCPM. With SOP' enabled while the partner sources VCONN, the port
> acks the partner's requests to the cable plug and the plug's replies to
> the partner, colliding with the GoodCRC that the plug or the partner
> sends. TCPM also tries to answer these messages as if they were destined
> to it, which for the case of a partner's SOP' Discover Identity on a
> HUSB311 made the partner soft reset the contract every time.
>=20
> TCPM talks to the cable plug only while it is the VCONN Source, as USB
> PD 3.0 section 6.3.11 requires, so listen for SOP' only then.
>=20
> Switch SOP' reception off before VCONN goes off and on only once it is
> on. If that fails, warn instead of failing the VCONN switch: SOP'
> reception left off only costs cable discovery, and left on is no worse
> than before this change.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 3bbb9ba4f660 ("usb: typec: tcpci: add tcpm_transmit_type to tcpm_p=
d_receive")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/usb/typec/tcpm/tcpci.c | 72 ++++++++++++++++++++++++++++--------=
------
>  1 file changed, 49 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpc=
i.c
> index 6717ac914c6a..af8db6b4497a 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -41,6 +41,7 @@ struct tcpci {
>  	unsigned int rx_type_mask;
> =20
>  	bool controls_vbus;
> +	bool vconn_enabled;
> =20
>  	struct tcpc_dev tcpc;
>  	struct tcpci_data *data;
> @@ -344,11 +345,45 @@ static void tcpci_set_partner_usb_comm_capable(stru=
ct tcpc_dev *tcpc, bool capab
>  		tcpci->data->set_partner_usb_comm_capable(tcpci, tcpci->data, capable);
>  }
> =20
> +static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
> +{
> +	struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
> +	unsigned int reg =3D 0;
> +	int ret;
> +
> +	if (enable) {
> +		reg =3D TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
> +		/* Only the VCONN Source talks to the cable plug */
> +		if (tcpci->data->cable_comm_capable && tcpci->vconn_enabled)
> +			reg |=3D TCPC_RX_DETECT_SOP1;
> +	}
> +
> +	tcpci->rx_type_mask =3D reg;
> +	ret =3D regmap_write(tcpci->regmap, TCPC_RX_DETECT, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  {
>  	struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>  	int ret;
> =20
> +	/*
> +	 * Without VCONN from us, SOP' traffic is between the partner and the
> +	 * cable plug, and our GoodCRC would collide with theirs. So stop
> +	 * receiving SOP' before VCONN goes off, and start only once it is on.
> +	 * Neither is worth failing the VCONN switch over.
> +	 */
> +	if (!enable) {
> +		tcpci->vconn_enabled =3D false;
> +		if ((tcpci->rx_type_mask & TCPC_RX_DETECT_SOP1) &&
> +		    tcpci_set_pd_rx(tcpc, true) < 0)
> +			dev_warn(tcpci->dev, "Failed to disable SOP' reception\n");
> +	}
> +
>  	/* Handle vendor set vconn */
>  	if (tcpci->data->set_vconn) {
>  		ret =3D tcpci->data->set_vconn(tcpci, tcpci->data, enable);
> @@ -356,9 +391,20 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bo=
ol enable)
>  			return ret;
>  	}
> =20
> -	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL,
> -				TCPC_POWER_CTRL_VCONN_ENABLE,
> -				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
> +	ret =3D regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL,
> +				 TCPC_POWER_CTRL_VCONN_ENABLE,
> +				 enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (enable) {
> +		tcpci->vconn_enabled =3D true;
> +		if (tcpci->data->cable_comm_capable && tcpci->rx_type_mask &&
> +		    tcpci_set_pd_rx(tcpc, true) < 0)
> +			dev_warn(tcpci->dev, "Failed to enable SOP' reception\n");
> +	}
> +
> +	return 0;
>  }
> =20
>  static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool e=
nable)
> @@ -478,26 +524,6 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bo=
ol attached,
>  	return 0;
>  }
> =20
> -static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
> -{
> -	struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
> -	unsigned int reg =3D 0;
> -	int ret;
> -
> -	if (enable) {
> -		reg =3D TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
> -		if (tcpci->data->cable_comm_capable)
> -			reg |=3D TCPC_RX_DETECT_SOP1;
> -	}
> -
> -	tcpci->rx_type_mask =3D reg;
> -	ret =3D regmap_write(tcpci->regmap, TCPC_RX_DETECT, reg);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>  {
>  	struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>=20
> --=20
> 2.56.0
>=20

--wr6dlyvciuauighc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr1B70ACgkQ2O7X88g7
+poKBg//WzKxui/0iHZ9XXhMaEToRVIt7Ci8P8n296mv7mWswKyIFcy9/8fjNtUi
EM5aY5MVqgSfXxnpOuaN7bxrxlyX3krzXZOl+4xuScXdKZfqkNgVE6bLCwJKTVCN
KxKTYWY//lEOcx+XioBNYODYCU0HIVBLoz5uR9i3hQXcNEBTCR4RD1+OhYgoPZjW
kBcpxuprrtFKcv/XJsvRqyKsLjZlowKYcQiO0712D6W0p90Aen7v6lrmhiWWvCC5
yojUzrMrJmLH37rQ0dgYKpxa4F+dFHtqhu8xw1qvrdJAolnyiHpYw70FiJN0u3H4
GnOaFsZWW0lbaWietM6hJ0GONeBtlIK3pWNoU4zP7XgsLVH2bdBKOmkia1dj3iYP
so8llG2cABH+QI78Wan1eQBseg9mFvxsHvvC1/4lzlefnN2Xng4ca5mMvL1x7ggQ
iMnHZwAuM790lRSNj6YlHyZvdSwG79endx5iVmaaYZmY0bLscWnc6anLdqp8wdaS
xegrrwJvIp6yAGxulDOEuUo7nY439M0DpnvuVRM+AAdY4eE/iooOWU3ub9wfMX1L
YISLaN81YGme5/O2HsDXQkZ2S/TbfTrOgqt07TBWYoz+x03fU9CPaNN/Su5zzk4p
5PNzQCIMPn4YBRN68iAps0AhaPiIlsKglKgMDA/j8Fn6rukx0YU=
=S6iY
-----END PGP SIGNATURE-----

--wr6dlyvciuauighc--
