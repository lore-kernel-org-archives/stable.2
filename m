Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604672;
	b=AqW26eEbeJVkES+sCoqHUE/xEcE4Wfk/3GIZypO0dMkzJ6uAmeC0oXZnyLMiZANBfDDp
	 Iy5oQgpvEH0O5nVoVIVYnNFs7mF/vgrAgZQD33+N95T57Bx0IN2TTVN4kiWxgiWsLvS/k
	 MXBAB0Xsd70PiTuHfEdqE0ERXREH7Jp5aDF7EhEQzEfvYAWrTiRBJ4YwS/t4VBv8ORWCp
	 tc6+XosDVkpLdnUu3aYk3FhwDfNw8zctTqiApAQEtUiy9kXxxL1JdwxFEPsgbyCR9k452
	 GQFBnglMtGx2KN5O78DDjoLYgn501fQ+h6X6rRFS5KArM2bLN2A2hr/NdXojwNFolOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604672;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=IzxFenk2G7VefJKCYkyvqMIK7vNzaeYCCl7lHKySqeY=;
	b=p48IK7vmOD0VAfCQrKPt2Ne6ed2ChveYa0tpwWQ1dcr0eaFfQOYCsGyAvrLkqZw1gN9V
	 Qu6h+ZKOsRjskRKI+gIR2arOQK1aZ/kHBZLZLEeFgmcAzLoHYVCaCRJLRQ6uguKgxG6A7
	 riB1pEjWLRGnq9iWio3ckRUO824MTs+OuD7A6wpitzHUQFqayAWJvQulHWWOF62McwrC9
	 GnBzrRze89cnuCutapOm9an16NAYMGDkb5yho48piUEHRVj38bavIzZo4mYHwE21iq1kf
	 r2LasAe+23Y/i2RSfgbsCRkfC4G7rVE2VXXI2iePVwFoLOdRPU7RdqJG1NbF1VsxU5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WHk7qfp1;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0A606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WHk7qfp1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=IzxFenk2G7VefJKCYkyvqMIK7vNzaeYCCl7lHKySqeY=; b=WHk7qfp1pQYFR16LwBuP1BdPrV
	bO+zIkDYXOY/48NsWDmt2lT/HkODjJJIWKcXQH1gnhmJKc/CC1IanQjJbIfsU9d6FciA1mAyuHRjA
	JzK++EvqC0lbyMIEI+UGfa2dDbzGuzoyaqX/OOKN8J7StZjW6lHRMN9ttmLl3tcnt9G3XjAEZ3J1j
	TTBPAJOVYq6VfvLjL3x2aG1ieeMVacA5BCV5HSPr1R7LfDEP/FeJSqldTJrP8qvDGNXVNckK+YDsI
	zILrpUTIT9JZ+gAaINjOoP2cWZgGairKelJoIbghrUMzR3WlyT3+zXPir4BhD2Vf4b3DUGa8wtq7O
	oLdYvI0g==;
Received: from 84.124.56.23.static.user.ono.com ([84.124.56.23] helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xNmVX-00HUXo-Gv; Mon, 02 Nov 2026 08:31:07 +0100
Message-ID: <eb5603b15e2154d07b5dc3574026a466b0988877.camel@igalia.com>
Subject: Re: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a
 CSD job
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Jose Maria
 Casanova Crespo <jmcasanova@igalia.com>, Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 08:30:56 +0100
In-Reply-To: <20261101125619.2465064-1-mcanal@igalia.com>
References: <20261101125619.2465064-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Good catch, both patches are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El dom, 01-11-2026 a las 09:53 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
>=20
> v3d_csd_job_timedout() decides whether a compute job made progress by
> comparing CSD_CURRENT_CFG4, the number of batches the dispatcher
> still
> has to start, against the value saved at the previous timeout. That
> saved value is never initialized, so it is zero on the first timeout.
>=20
> On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher
> has
> started the last batch, but the dispatch keeps running until the
> batches
> in flight complete. If the first timeout fires in that window, the
> handler sees no change and resets the GPU while the job is about to
> complete. For example, this happens with long dispatches that only
> keep a
> single supergroup in flight.
>=20
> Initialize timedout_batches to the value programmed in CFG4 when the
> job
> is started. The register does not return to it once a batch has
> started:
> it counts down to zero on V3D 7.1.6 and later (CFG4 holds the number
> of
> batches), and to 0xffffffff on V3D 4.2 (CFG4 holds the number of
> batches
> minus one).
>=20
> Cc: stable@vger.kernel.org
> Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader
> dispatch.")
> Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index e6283a75bcdf..002116efc874 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -360,6 +360,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
> =C2=A0		dma_fence_put(job->base.irq_fence);
> =C2=A0	job->base.irq_fence =3D dma_fence_get(fence);
> =C2=A0
> +	job->timedout_batches =3D job->args.cfg[4];
> +
> =C2=A0	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
> =C2=A0
> =C2=A0	v3d_job_start_stats(&job->base);

