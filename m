Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F232F7F11;
	Thu, 16 Jul 2026 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168026; cv=none; b=Bub1HKjzK9Dm40qF5rhnPn1G63Lg0S+MnvZOxcETbC9Y4+8u8z4N1QhgW0AXfM4aQJ+JPZFJ95qnUgKKyfrHCq8+JFY/6SYQhmsq57ABzkji7xv5WDuN/GMax/FAaml5spYON0HxT67PvApQ+xNecZ1XjB6QKkK6ZC7xorzSbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168026; c=relaxed/simple;
	bh=85dtUKYBI9E1vdQZi6Sc2n1KeQg/ooNnSnhXUuxHVUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3ZpsXTQF152ZF4XWLB6LMMC9+FdHE3kpOjTu56orXb/Rd5zqr4qPSPwf795nABIakWtV0GdC/wqhrz0uBklt/tYP9iQQynJPdcbm+LnulXtpZPV+YfObiVlxYlWQ6+1bRy9VCdWUqeMMlcDifTSormbGjaMfNkHjINVSQlMGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hz3wwwQm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hz3wwwQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784168023;
	bh=85dtUKYBI9E1vdQZi6Sc2n1KeQg/ooNnSnhXUuxHVUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hz3wwwQmDtaJHMndHYnjGdu3vFEjN7JM7moTZ/PdM0QEDt1Q7Kp62QF9yRZ6hrINk
	 J0/M5kQA4TW72/FWWk2+m3V55zXP+PvgF98IFnruhF8oPJ4Yg2d5cFSXloiyw93+SH
	 Mizy99P6auZdyMUBDNxIhRRIqM0+X+sMhxD7MGPWzPluFTHr8IbF776QnU9qwhabAe
	 r97O5BUGOGgb9prq8W54CohX2z8dSVnMQJR8N/OXkxiuCYkWKVBeY98WYO7Y8ym/39
	 jfZxdRUEF/4Y9vWpUWRrorFYP+ZEkApwTZuoR0ikO6sVsAolgyDmTUShgyH69ItuXa
	 mb3O2eb9tixYw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0ED4617E0720;
	Thu, 16 Jul 2026 04:13:41 +0200 (CEST)
Message-ID: <0770f5e728a1497eece1458a62b2fd4f88933845.camel@collabora.com>
Subject: Re: [PATCH v1 5/7] media: chips-media: wave5: Defer job_finish()
 only when a DEC_PIC was queued
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 22:13:40 -0400
In-Reply-To: <20260626012232.111-6-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-6-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
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
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-pwJgK8ts2GW3SzjOyvZe"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-pwJgK8ts2GW3SzjOyvZe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> Decoder instances sharing a VPU also share one v4l2_m2m job slot, release=
d
> when the running context calls v4l2_m2m_job_finish(). While draining,
> device_run() defers job_finish() once EOS is sent (sent_eos), expecting a
> later finish_decode() (from a DEC_PIC completion IRQ) to release the slot=
.
>=20
> But the m2m core checks job_ready() only when a job is queued, not when i=
t
> is dispatched. A job queued while draining can run after finish_decode()
> has already moved the instance to STOP and sent EOS. device_run() then ru=
ns
> in STOP, issues no DEC_PIC, yet still skips job_finish() - so no IRQ, no
> finish_decode(), and the shared slot is leaked, stalling every instance.
> With several v4l2h264dec instances in parallel, GStreamer hangs at EOS.
>=20
> Track whether the run actually queued a DEC_PIC (cmd_issued) and defer
> job_finish() only then. Otherwise finish the job immediately
>=20
> Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of d=
ecoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0.../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 +++++++++=
++-
> =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 93f7b724d86c..f33c00cb801b 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1655,6 +1655,7 @@ static void wave5_vpu_dec_device_run(void *priv)
> =C2=A0	struct queue_status_info q_status;
> =C2=A0	u32 fail_res =3D 0;
> =C2=A0	int ret =3D 0;
> +	bool cmd_issued =3D false;
> =C2=A0
> =C2=A0	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstre=
am data", __func__);
> =C2=A0	pm_runtime_resume_and_get(inst->dev->dev);
> @@ -1752,6 +1753,7 @@ static void wave5_vpu_dec_device_run(void *priv)
> =C2=A0			inst->retry =3D false;
> =C2=A0			if (!inst->eos)
> =C2=A0				inst->queuing_num--;
> +			cmd_issued =3D true;
> =C2=A0		}
> =C2=A0		break;
> =C2=A0	default:
> @@ -1769,8 +1771,16 @@ static void wave5_vpu_dec_device_run(void *priv)
> =C2=A0	 * in power and CPU time.
> =C2=A0	 * If EOS is passed, device_run will not call job_finish no more, =
it is called
> =C2=A0	 * only if HW is idle status in order to reduce overhead.
> +	 *
> +	 * Deferring job_finish() is only safe when this run actually queued a
> +	 * DEC_PIC command (cmd_issued): that guarantees a completion IRQ, and
> +	 * thus a later finish_decode(), will release the shared job slot. When
> +	 * device_run() is entered with no command to issue (e.g. a job that wa=
s
> +	 * queued while draining but reached the STOP state by the time it ran)=
,
> +	 * no IRQ follows, so finish the job here to avoid leaking the slot and
> +	 * stalling every instance sharing the VPU.
> =C2=A0	 */
> -	if (!inst->sent_eos)
> +	if (!inst->sent_eos || !cmd_issued)
> =C2=A0		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> =C2=A0}
> =C2=A0

--=-pwJgK8ts2GW3SzjOyvZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg+VQAKCRDZQZRRKWBy
9GMfAQDGs2PynEcF1rLmYzp8pAMTaAhnhZmCqG+gsPzRlO9DIgEAmJxv1DHcWC3g
pgYODP2HnsUqUNoMDp/EzxyLSho3DA8=
=r5sO
-----END PGP SIGNATURE-----

--=-pwJgK8ts2GW3SzjOyvZe--
