Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0D3D6CDF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539944; cv=none; b=WPkS5IlJu3RdVZKXcrIQR5xfRW4DLmeBSKqtcNCL0/jdQEP8/4vmaDauOTTyPVEgzoj5VhojepaQTHZayvxqYnFPemfwxiBj4KKGRq8B0vmEP/u5H+DaI9p/2wo7nYwuWxwBzxhlJ9fV3CmG2s/HzLoUw79I4ifC2Y+czentUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539944; c=relaxed/simple;
	bh=D3JZPaESfH8iwXG+5oYUqhlXe7bCJsb662lIocix6OE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUUBNg58w2O7kYBCdbwYm7D8qJW55kD0Q54UPj0h7Jg90PIrQ4Ab+6wYbqKWHgt+kRAK4VrbWHr76/o8aC9eSFzs7I55rK2VhPUdctfvemklbDBrU0kdytFwBLPv3QWcLquO/qVASgUziZ/3GmgU68MwMXyeRn3I23gfCQyilsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=acdgbrur; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="acdgbrur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=D3JZPaESfH8iwXG+5oYUqhlXe7bCJsb662lIocix6OE=; b=acdgbrurH+3S5yh/+JnVOwuMhw
	qBKnv5EknaTyniJUy1op9D9lYswITVGTzXwQxC2A9HomWysh2dKMwk3cg+pglAFWXLL9WhZFr+2XW
	iKRIotpgc3DD2yftGyTjHun4n4/6p1jeCR0SThUJ1eChq6rBLoC7TvPYPFbkPsOO6uoJ0Wow4mGmq
	gpHMG6Rtgi/BPOwzCzt1w7Y+JZGFsFiXgEtTHKu1NFrFS6Vr6rdQRZQ0tUaxfrpR8LkpwRoeOBEl0
	iY1/bykp5AjR/flBgdLoEvRLVTW7TT5dapOiK/Uz+jRpbfnpQU+qa1FpGlGM421QUytnWGdq2P33S
	F8QNOe+w==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wlkM8-000sNC-Lt; Mon, 20 Jul 2026 11:32:12 +0200
Message-ID: <b15fb627d91cb75f6fd8bf61b611c28174e0e161.camel@igalia.com>
Subject: Re: [PATCH 0/3] drm/vc4: Fix binner overflow-memory corruption and
 GPU hangs
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Jose Maria Casanova
 Crespo <jmcasanova@igalia.com>, Emma Anholt <anholt@igalia.com>, Maxime
 Ripard <mripard@kernel.org>,  Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Mon, 20 Jul 2026 11:32:02 +0200
In-Reply-To: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
References: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Ma=C3=ADra, for the series:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

I do have a question though:

How certain are we that this issue with vc4 not realiably following
continuation block chains is a hw problem? If we are confident this is
a hw issue and not a side-effect of a driver bug, we should talk to
Broadcom about this to confirm and see if there are any known
workarounds (I am assuming this has not been confirmed with Broadcom
yet)

Iago

El s=C3=A1b, 18-07-2026 a las 14:28 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> This series fixes a couple of long-standing bugs in the VC4 binner's
> out-of-memory (overflow) path. The binner writes each tile's binned
> command list into a per-job binner BO that is carved into fixed
> slots,
> and spills into overflow memory whenever a tile's list outgrows its
> initial tile-alloc block. Bugs in that path have been reported for
> years
> as GPU hangs, a GPU that stays permanently wedged after the first
> hang,
> userspace heap corruption and occasional full system crashes [1][2].
>=20
> The three patches address distinct problems and can be reviewed
> independently, though they were all found while chasing the same
> reports.
>=20
> Patch 1 address an issue in vc4_overflow_mem_work(). The function
> points
> BPOA at a 512KB slot inside the 16MB binner BO but writes the size of
> the
> *whole* BO to BPOS, so on every binner OOM event the hardware is
> authorized
> to DMA tile lists across other in-flight jobs' slots and, for any
> slot but
> the first, past the end of the BO into unrelated CMA memory.
>=20
> Patch 2 resets the software overflow allocator and the BPOA/BPOS
> registers on GPU reset. Today a reset force-completes the RENDER job
> that
> would have consumed the pending overflow slot, so a slot leaks on
> every
> reset and the hardware is left pointing at stale overflow memory that
> the
> re-queued BIN job would consume before raising a fresh OOM.
>=20
> Patch 3 dynamically sizes the initial tile-alloc block up to the 256-
> byte
> hardware maximum, picking the largest size that still fits the binner
> slot for the job's tile count. This keeps more tiles' lists in their
> initial block and off the continuation-block chain, which VC4 does
> not
> walk reliably, and takes the reported EmulationStation workload from
> storming resets to zero. As explained in that patch, it is a
> mitigation
> for a hardware limitation rather than a complete fix.
>=20
> [1] https://github.com/raspberrypi/linux/issues/3221
> [2] https://github.com/raspberrypi/linux/issues/5780
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Jose Maria Casanova Crespo (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Supply the overflow slot size in =
BPOS, not the whole
> bin BO size
>=20
> Ma=C3=ADra Canal (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Reset the binner overflow allocat=
or on GPU reset
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Dynamically size the initial tile=
-alloc block
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 +++++
> =C2=A0drivers/gpu/drm/vc4/vc4_irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 14 +++++++++++++-
> =C2=A0drivers/gpu/drm/vc4/vc4_render_cl.c |=C2=A0 3 ++-
> =C2=A0drivers/gpu/drm/vc4/vc4_validate.c=C2=A0 | 29 +++++++++++++++++++++=
+++++-
> --
> =C2=A04 files changed, 46 insertions(+), 5 deletions(-)
> ---
> base-commit: 7a4b7122a623e3d57fc15cf843a9d45fbd72c6ab
> change-id: 20260718-vc4-bin-oom-fixes-29cf2cce2562
>=20
>=20

