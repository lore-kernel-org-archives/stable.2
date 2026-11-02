Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603609;
	b=pX3cHIFtLp3/jBeGhfZfAYt3dUtIUKRkZKh7AQQCzV0IHVVtnEefDZxtejakaCLolZRc
	 nUuZ27Z/zyxjuTW0OmMfDpfmmErCVww15Fs5ISJJ+tOLglNVqyUVEdt8fJp+QdNOFXGEs
	 K34QNVsS301M0EG9tX3snp21TKueIOxr7vW9z0eCAcEpLn2A25FFJHm0AP/wRFEP6mqc0
	 s1eXdUb/BH4X0FYnCKplUZatG6EbYentR9Carzr1f0c/zqqH9dW0LikxqZY8/ri/X+Ol2
	 Zx3MH+h0T0XoTcmnAuliK1CkCcCX9r0FpQ95JXL29x/865gXT3ObG9m2pTs9gsG5M9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603609;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KY9RYXaRnQDli/vu8vgfR6JwdPnkjzpG6Vj3ogcKevs=;
	b=RiUGrE1wHF3iu49EBYf5B22y3H2YBSpFfchCfpkkVN0Wyi5QJxPgOjOj0UMc97mpinEJ
	 X2wbpKhu+mxrN6VwPn7l1eQATAMzsI6gy6n/zwGklg8UrBix+/5nCVGw7QfOxIxyJY2F3
	 OGuDhyC5yS8BvUUpg5jHLsFHuAsbs8H+jR7MJcEDeeD/4x0YbmDZutgDcztudD4+RgCsJ
	 Ww/mhCOpu/C3Ye+s+5Emr9jLw3RWZbjTB7HpoHZYyOuPHVE/oPbIE8oUERCj897m8kz0k
	 mvHg/7QEc2ziV1YMjxmPnrsLFVEweTP3BfmnzrGPm+oB3Hyh/FzyecSV3/oiWPtubAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=kcv8x00D;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAF606A326;
	Mon,  2 Nov 2026 07:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDAF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=kcv8x00D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1793603606; x=1793862806;
	bh=KY9RYXaRnQDli/vu8vgfR6JwdPnkjzpG6Vj3ogcKevs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kcv8x00Ds7p5lYgYo+m3HpAeIS4DnIfGO6h97oJ7/6JrK9yDhsTI4H9B4WObLjR2a
	 BNpqC2DyR9bs6fHHb/qCEiASLcBauoOQ0qPa9Ce9rm/cIkDuUj5ZtTE39BU8JzxoCE
	 wToE3YIFgM2utcrtgS3x0msE26r95fZBHFC2COMZ/RbO4eC9J/FzD+lMCaTnOy+w7G
	 qB6tjOKm0qsUOG2QZMNYW2ENL6h5Bvj+Xkj/qi2V+iDrI18bWxSL6j44+gqK2bPzOe
	 0LiVCJIou7YhNio+N3EhinnsqgRuRu+jbpbLvzw1IhXCtMAOH1B/H9kP/nhWg0eH1N
	 sf+FhjdY7CP6Q==
Date: Mon, 02 Nov 2026 07:13:18 +0000
To: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
Message-ID: <20261102071310.3004332-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: fb738ba593e0085010f36fbc498bff8419c12ce7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

dpaa2_switch_probe() reuses i while probing ports, adding NAPI
instances, registering netdevs, and unwinding failures. Consequently,
the value reaching the port removal loop does not always represent the
number of successfully probed ports.

If IRQ setup fails, i is left equal to DPAA2_SWITCH_RX_NUM_FQS. A
switch with one interface then causes the unwind path to access
ports[1] out of bounds, while a switch with more than two interfaces
leaks all ports after ports[1].

If register_netdev() fails, the unregister loop consumes i down to -1.
The following port removal loop is therefore skipped, leaking every
port netdev and its MAC endpoint reference. The NAPI instances attached
to port 0 also remain linked while their enclosing ethsw is freed.

The issue was discovered by a static analysis tool and confirmed by
manually tracing the probe error paths.

Track successfully probed and registered ports independently. On
post-NAPI failures, unregister only successfully registered netdevs,
delete the NAPI instances, and then remove every successfully probed
port.

Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control inte=
rface")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/=
net/ethernet/freescale/dpaa2/dpaa2-switch.c
index fe8ac5e85259..0d80706ac41f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -4086,6 +4086,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *s=
w_dev)
 {
 =09struct device *dev =3D &sw_dev->dev;
 =09struct ethsw_core *ethsw;
+=09int registered_ports =3D 0;
+=09int probed_ports =3D 0;
 =09int i, err;
=20
 =09/* Allocate switch core*/
@@ -4148,7 +4150,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *s=
w_dev)
 =09for (i =3D 0; i < ethsw->sw_attr.num_ifs; i++) {
 =09=09err =3D dpaa2_switch_probe_port(ethsw, i);
 =09=09if (err)
-=09=09=09goto err_free_netdev;
+=09=09=09goto err_remove_ports;
+=09=09probed_ports++;
 =09}
=20
 =09/* Add a NAPI instance for each of the Rx queues. The first port's
@@ -4178,19 +4181,22 @@ static int dpaa2_switch_probe(struct fsl_mc_device =
*sw_dev)
 =09=09=09dev_err(dev, "register_netdev error %d\n", err);
 =09=09=09goto err_unregister_ports;
 =09=09}
+=09=09registered_ports++;
 =09}
=20
 =09return 0;
=20
 err_unregister_ports:
-=09for (i--; i >=3D 0; i--)
-=09=09unregister_netdev(ethsw->ports[i]->netdev);
+=09while (registered_ports)
+=09=09unregister_netdev(ethsw->ports[--registered_ports]->netdev);
 =09dpaa2_switch_teardown_irqs(sw_dev);
 err_stop:
 =09dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
-err_free_netdev:
-=09for (i--; i >=3D 0; i--)
-=09=09dpaa2_switch_remove_port(ethsw, i);
+=09for (i =3D 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
+=09=09netif_napi_del(&ethsw->fq[i].napi);
+err_remove_ports:
+=09while (probed_ports)
+=09=09dpaa2_switch_remove_port(ethsw, --probed_ports);
 =09for (i =3D 0; i < ethsw->sw_attr.num_ifs; i++)
 =09=09mutex_destroy(&ethsw->lags[i].fdb_lock);
 =09kfree(ethsw->lags);
--=20
2.43.0


