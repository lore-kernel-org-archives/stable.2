Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF327FB05;
	Thu, 16 Jul 2026 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167713; cv=none; b=kCvGByhoETVVcipQmR0W9R9ZEjFG3gGuY2sWmlOMK72t4VBumpdCVqMnHjUCRoL0OaQCUDDIXIs6s5ENyquTCMXNY0SlqSxHfHZYxyCll83cr1o7QHpAO5adT8lGBcpdhtGzDNtgPasaHcByaBQ5BXLZL0ygAjEONkp/JP6eeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167713; c=relaxed/simple;
	bh=SkDNqMJNbQoqJNADte89eq2FvxEhrTXYwMFWlKCfCxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJ2xwxZvDl+T5CdM9OKN50BcgBqo6lvtyCj8IlLdYLzWEQDGtjJQQ6AG/Oc/prtYVmpCsvSE+gnQAN4Od9QBf70HtX/O8yqaqF7W3wjO9Ls5bhl1vf3s7g7Occen8If6/PjFbOB1sifFQ2b2liZP/gJ64NLs3c3ZwiXNbzV+veM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A0xeVtxw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A0xeVtxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784167710;
	bh=SkDNqMJNbQoqJNADte89eq2FvxEhrTXYwMFWlKCfCxA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=A0xeVtxwxZoeoNDpaX0WlR4bBv6HlcH2EqB5glfcEHDHI6ZfVdq/YnfkhwoxPtQy8
	 bKTSRF2EE05Z5ftTF7VJSinM/qgHSXorN+UV/vI2AnkJ6m/MGvNOy3Knbx1oS2dLAF
	 0os4tkdpLwIH+6J7y5CaT0GDY2aJm8ia7FnpgyuiFo1RntbTlZMQxzbMd69Um0bM3p
	 5yFrxExjUdQ4X/s+XfQWsvR3pLNZ+r4Xo/y+dVKThsL4dnVvYhv+1mvRXAPCP2IDKW
	 rFwiriswUzy5GnwUDRTk6hcBhz/qbYFqhI0RHGFC9P+nxmM3YKRk4vuepT4uPbKO3p
	 XZIfEqvfMXUrA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 573D417E0E08;
	Thu, 16 Jul 2026 04:08:29 +0200 (CEST)
Message-ID: <0c2e1bd0ef223abea99d7b6f1ca0f7fc805fe47f.camel@collabora.com>
Subject: Re: [PATCH v1 4/7] media: chips-media: wave5: Add timeout while
 stop_streaming
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 22:08:27 -0400
In-Reply-To: <20260626012232.111-5-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-5-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-uxVVISLXEVfI6t6A2LE+"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-uxVVISLXEVfI6t6A2LE+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> When stop_streaming is called, an infinite loop may occur in some cases.
> Add a bounded poll of the queue status: loop until the queues drain,
> sleeping briefly between polls, and bail out once VPU_DEC_STOP_TIMEOUT
> elapses.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

This is not the nicest thing to do, but I don't really have a better idea. =
We'd
need something from the firmware to signal this instead. The code was clear=
ly
prone to spinning and CPU hugging, even if the HW was behaving, so I'll adm=
it
this is an improvement.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0.../platform/chips-media/wave5/wave5-vpu-dec.c=C2=A0=C2=A0=C2=A0 | =
15 +++++++++------
> =C2=A0.../platform/chips-media/wave5/wave5-vpuconfig.h=C2=A0 |=C2=A0 2 +-
> =C2=A02 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 6c6e86b09b40..93f7b724d86c 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright (C) 2021-2023 CHIPS&MEDIA INC
> =C2=A0 */
> =C2=A0
> +#include <linux/delay.h>
> =C2=A0#include <linux/pm_runtime.h>
> =C2=A0#include "wave5-helper.h"
> =C2=A0
> @@ -1537,15 +1538,15 @@ static void wave5_vpu_dec_stop_streaming(struct v=
b2_queue *q)
> =C2=A0{
> =C2=A0	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> =C2=A0	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
> -
> -	bool check_cmd =3D TRUE;
> +	unsigned long timeout;
> =C2=A0
> =C2=A0	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> =C2=A0	pm_runtime_resume_and_get(inst->dev->dev);
> =C2=A0	inst->empty_queue =3D true;
> -	while (check_cmd) {
> +
> +	timeout =3D jiffies + msecs_to_jiffies(VPU_DEC_STOP_TIMEOUT);
> +	while (true) {
> =C2=A0		struct queue_status_info q_status;
> -		struct dec_output_info dec_output_info;
> =C2=A0
> =C2=A0		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status)=
;
> =C2=A0		if ((inst->state =3D=3D VPU_INST_STATE_STOP ||
> @@ -1554,8 +1555,10 @@ static void wave5_vpu_dec_stop_streaming(struct vb=
2_queue *q)
> =C2=A0			q_status.report_queue_count =3D=3D 0)
> =C2=A0			break;
> =C2=A0
> -		if (wave5_vpu_dec_get_output_info(inst, &dec_output_info))
> -			dev_dbg(inst->dev->dev, "there is no output info\n");
> +		if (time_after(jiffies, timeout))
> +			break;
> +
> +		usleep_range(1000, 2000);
> =C2=A0	}
> =C2=A0
> =C2=A0	v4l2_m2m_update_stop_streaming_state(m2m_ctx, q);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b=
/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> index 4ebd48d5550e..e04f2dbf3b65 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> @@ -59,7 +59,7 @@
> =C2=A0//=C2=A0 application specific configuration
> =C2=A0#define VPU_ENC_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 60000
> =C2=A0#define VPU_DEC_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 60000
> -#define VPU_DEC_STOP_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 10
> +#define VPU_DEC_STOP_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 300
> =C2=A0
> =C2=A0// for WAVE encoder
> =C2=A0#define USE_SRC_PRP_AXI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0

--=-uxVVISLXEVfI6t6A2LE+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg9HAAKCRDZQZRRKWBy
9G3xAP95j4sIS0qkQcJlZRJgBJXE1uPIuQ8AJccAvNF7HRThjgD8DMc99hytYcH3
Tahd3e240r5dXmssdBxKjjVZUMPeXAM=
=I+9N
-----END PGP SIGNATURE-----

--=-uxVVISLXEVfI6t6A2LE+--
