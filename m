Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465061;
	b=TG90fkpC6BBRYFcawpaJ0XYvsGqSE/T6T1j9FQp9A0gqgqP9s0aQ6pGK2SzEg0MeBZSi
	 dOgQkHclhuwp5p79y7ZabiHOwsxcbe+Zrv9TbAK20qpJVdktEECmO+4V0Q9B8h5CDn90W
	 yBvu2cM05BvQSZ1xlblTlq13QeDwFp1syj8vu2JmfaLQI5V/9MlAMxArTsFRGWytuuPuL
	 xEbCCsFVDose2dE3fO+BvLNMYShOMld5UOT+C3DB/ZbS7Eb/6Ivib57cKZMF7qnpbwlp8
	 KfIC6SAKDZcdcRyIPDr5mOSOsuEb3jafjRlB6cU3GdhJZwp26J5vFBwIF1ROpo75pUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:User-Agent:
	 MIME-Version;
	bh=vaTxSvR5uRGznwAaCzW/CZ+c+SqZLPHFjqdiifAy+hc=;
	b=yQ2tCfU4DK825gGQnK12YPEwDUj3ngnjtMVKfhbBVuFBR7t6fkqF8jORMdOCi41HGTwK
	 0j6s1AXCID2eU3ZA92zk53yDT0l/jHhL01gtqlEhzbr5tHqEV16rUqloTZRcW+oZfNtoJ
	 bkWiq8MBoWeXJWDYs6ZXab9bcgx1rH5YquY+sUMMCyMTQgGs/X+dS9jeHQ3sNIHClkw0G
	 dvHeEjfrhjNyDDV/sHkFlv5S56RMP1n9QX3+VvlSiGRfK/Ou5JoqOF2AdNM2VRUfxXVxJ
	 8zwN/LqY1/GTpwFBdFDaZHenKNkPo4YpOxpSqemyZ16GQESvMqaBWUKM73ztku7eO7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ndufresne.ca;
	spf=pass smtp.mailfrom=ndufresne.ca;
	dkim=pass header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="RplCXp/g";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A9606A330
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RplCXp/g
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55c48582654so43321851cf.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20260707.gappssmtp.com; s=20260707; t=1795465060; x=1796069860; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaTxSvR5uRGznwAaCzW/CZ+c+SqZLPHFjqdiifAy+hc=;
        b=RplCXp/gZXox2teRZf7DYhDSJAxB93wwhVKgD4CAUskoLuIBVGFLIGhQERlAzdlN22
         MUylmL7KarchGd3oBC9HkxKJE0iTmmtlco4NpUJ50X57I24n3PsZMq5G88TgSewAJmEi
         8UUoe3LniFV6OqDDBPsbGDqzvu1b8pJwce4UYWPa9K2SLf+7pobevyJFSkexwdfXuULv
         f6w7FKJc1L7Ea90LVrwQedo3PFKnGz403zAm/gIqYEqrtZL0CiNjCkWwum/3fwr9JXNs
         Vdf0HMEP9HncTo1kf8HSz+/5jCwq3QbVQsuE1FI2SuCcuqqYCIjRdIthLItsAayTmC8j
         nKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465060; x=1796069860;
        h=mime-version:user-agent:content-type:autocrypt:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaTxSvR5uRGznwAaCzW/CZ+c+SqZLPHFjqdiifAy+hc=;
        b=ZgXKZbZXkFnAmN4usntmL/gP3pWoP6jQHEn1Fblf+GA2J/7K8n931NYCYAcU1zlV8y
         svU7xUq0tEtkcGxkGqUk/HGU8NiMP+d7DqB3nFaoYpqMOBYWB9kNRZAvq/l6OFNIOCvo
         kQ82vrCh4QxIreb3iln1hI9N6IrR+8b7tjdAFOCmUb5xcIEiK6mUH85qAgFiZCw2Tub6
         bA8lDkgeXJx4BJyq1P8ax2WZM798l8f65RruFiw6neFQtA5Vj7umY5HY8dhTOI3mMeDs
         YyD6G++GbpC4adDQALQrjWKh0RtQLgguN2KAztepjEYXWOFp8GltZQrlIFmfEw83COte
         rvtw==
X-Forwarded-Encrypted: i=1; AL+hErF2ahiokNiVjxPdgBWOpmTfjZMLN1vjIH87i5pOS3ZGoV+z7K7Cz2EfGpx7QrRPX3rACqUFO7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DstXsznN37bU4GMuaAoC5ows8ZDQlMTZs0Vsm57hQvddEl4hI
	W2Mcn4j6yYXF8OSPztYcXpuEVuQEJjPNl3fyhBf9bYX6ar0lNDxY0RcY8pwzOtYDOE8=
X-Gm-Gg: AZFdTZd8oqsHdqUTq4dm3/D5W6v/2umvJHLjn7TkhyjTtJXNAeMha3FhsE0jVqrndzm
	nfm1xQT2at4PFOb3iU+RTMpyszgLgtgg0QC8lx5Cf1x3SyIw60xC0sjfoLQzV9VhbN6D30Ns34I
	5ZGAnOPZ0TgCWAUgDj3ohrGlJyFh1Hwog6CMqczb5Oba1Yo6kaZcR6cSKI1Rq8vRHxTiskjEtei
	JYxRS1sJWqm4V2xL1J2JA6ZKwrje+4VEW6ahDnXSQH2ytZAp+Gh56QEKR9gi0Nb5JRFAsfV4Dwr
	TWXu+PjxH3TN5cIo2j4Ye0HdUspx8dt84U2Nh2ckoBBD51lrQ68u3hs+n/T3OBiuFSwJu7QHGyO
	DLuA+trCm+1/oD8tj93XdDtrrPGa2Lv56aLtsdigTcMARxjoW4I2VXOuPl8u6H/7tf5Wqssrnw4
	VTySJmXVrqGW2Vp9LoFXAra0So8E+AZlWHvfLujqcJkPEVlkk8LnY9BaZ4Y3ekzbSW7pDDQVnZD
	B6WBUdw4WuWf3PuQ2N+UZNaGnYDZaL1D0DNiPORK3mv+0eH4nfYXt3SXkgsWTjLH/ZSz53WusV/
	14colVWFMr3aKSaH4aYmE2Sj1dsktZw4hiNaE2P5DTJogR9vC4V7EvI=
X-Received: by 2002:a05:620a:28c8:b0:949:7acc:1695 with SMTP id af79cd13be357-949ba6c5900mr2056425885a.0.1795465059662;
        Mon, 23 Nov 2026 12:17:39 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:8ec9::c41? ([2606:6d00:11:8ec9::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca846322sm695648785a.34.2026.11.23.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:17:38 -0800 (PST)
Message-ID: <104c4805de06b15ce0701c026de4540b19016b82.camel@ndufresne.ca>
Subject: [PATCH v2] media: verisilicon: suspend the device before
 unregistering it on remove
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Sergei Khomenkov <shomenkow@gmail.com>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
	 <hverkuil+cisco@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Frank Li
	 <Frank.Li@nxp.com>, Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
Date: Mon, 23 Nov 2026 15:17:37 -0500
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uwgP2ITtTeUtNsVLr8YC"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-uwgP2ITtTeUtNsVLr8YC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Sergei Khomenkov <shomenkow@gmail.com>

The clocks are enabled and disabled by the runtime PM callbacks.
hantro_remove() calls v4l2_device_unregister() and clk_bulk_unprepare()
first and only then pm_runtime_dont_use_autosuspend(), which suspends
an active device right away. By then v4l2_device_unregister() has
cleared the driver data (it points to the v4l2_device, the first member
of struct hantro_dev), so hantro_runtime_suspend() dereferences NULL.

The device is always active at that point: the driver core resumes it
before calling remove(), and its put only starts the 100 ms autosuspend
timer. So every unbind and every module unload, with or without a
decode before it, gives an "Unpreparing enabled" warning for each clock
and then that oops.

Stop runtime PM before the unregister and the unprepare. If runtime PM
is forbidden through sysfs (power/control set to "on"), the device is
still active after that, so disable its clocks and mark it suspended by
hand.

The probe error path unwinds in the same order. It can only hit this if
a job runs between the encoder node registration and a later probe
failure, so it is left for a follow-up.

Fixes: 556ab0b2741d ("media: hantro: release runtime resources when device_=
run fails")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---

Changes in v2 (maintainer update):
- Slimmed commit message
- Re-use hantro_runtime_suspend() instead of open coding
- This required moving code around, hence posting it to be clear

Moved outside of the commit message:

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board (G1, ID 0x6731); the assistant also drafted this
change. Tested on that board. Without this change, unloading the idle
module (runtime status "suspended") gives the warnings and the oops.
With it, the idle module unloads with no warning or oops, and so it does
right after an H.264 or VP8 decode with the autosuspend delay raised to
10 s through sysfs; the clock enable and prepare counts are back to
their values before the load. The same holds with power/control set to
"on", over three load, decode and unload cycles on one boot. kmemleak
reports nothing after five load, decode and unload cycles. Built with
W=3D1 with and without CONFIG_PM. Not tested on other SoCs or with a
power domain.


 .../media/platform/verisilicon/hantro_drv.c   | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/medi=
a/platform/verisilicon/hantro_drv.c
index 70a2bb39777f3..55480ff1ca57f 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1285,6 +1285,14 @@ static int hantro_probe(struct platform_device *pdev=
)
 =09return ret;
 }
=20
+static int hantro_runtime_suspend(struct device *dev)
+{
+=09struct hantro_dev *vpu =3D dev_get_drvdata(dev);
+
+=09clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
+=09return 0;
+}
+
 static void hantro_remove(struct platform_device *pdev)
 {
 =09struct hantro_dev *vpu =3D platform_get_drvdata(pdev);
@@ -1296,10 +1304,16 @@ static void hantro_remove(struct platform_device *p=
dev)
 =09hantro_remove_enc_func(vpu);
 =09media_device_cleanup(&vpu->mdev);
 =09v4l2_m2m_put(vpu->m2m_dev);
-=09v4l2_device_unregister(&vpu->v4l2_dev);
-=09clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
+=09/* Suspend first: v4l2_device_unregister() clears the driver data. */
 =09pm_runtime_dont_use_autosuspend(vpu->dev);
 =09pm_runtime_disable(vpu->dev);
+=09/* Runtime PM forbidden through sysfs: the device is still active. */
+=09if (IS_ENABLED(CONFIG_PM) && !pm_runtime_status_suspended(vpu->dev)) {
+=09=09hantro_runtime_suspend(vpu->dev);
+=09=09pm_runtime_set_suspended(vpu->dev);
+=09}
+=09v4l2_device_unregister(&vpu->v4l2_dev);
+=09clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 =09reset_control_assert(vpu->resets);
 }
=20
@@ -1325,14 +1339,6 @@ static int hantro_runtime_resume(struct device *dev)
 =09return ret;
 }
=20
-static int hantro_runtime_suspend(struct device *dev)
-{
-=09struct hantro_dev *vpu =3D dev_get_drvdata(dev);
-
-=09clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
-=09return 0;
-}
-
 static DEFINE_RUNTIME_DEV_PM_OPS(hantro_pm_ops, hantro_runtime_suspend,
 =09=09=09=09hantro_runtime_resume, NULL);
=20
--=20
2.56.1

--=-uwgP2ITtTeUtNsVLr8YC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawSfYQAKCRDZQZRRKWBy
9KeKAP9CcDZUI34xMYJIMGncXf4XJcb7fZENpFaEKrlq8u8HuQEAgGgRcRqx3b09
Fpe+wdqI8J1FIvo6R7IA/MeN6qQXgAM=
=ZcMk
-----END PGP SIGNATURE-----

--=-uwgP2ITtTeUtNsVLr8YC--
