Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5285248893;
	Sat, 19 Sep 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789829912; cv=none; b=F3sXvhhlNEpGt5yql9wGc0BprKvxSxxwiwBCywW96rim9CWuOuIgd4HUsQoFYC9NtyiaMH/T+Wn0KnJP9pafZjRO1vWFQGoCbNOfWliA+9KEYcBjkaB+UJGvdXObzRyiV19N7oCF79bgVHA9HC+4oe/QnkKaqe3Dc5CN5XP1Jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789829912; c=relaxed/simple;
	bh=+TKok9hDY7p6Z7PJqFMlszfKsfnvblxalzrMKMB6/q0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFst44fnFhSMASg2JPKabquNjdIHQPiEcuycWEt/NyEmHEI+MjaAY232Z80Ki043AudmZnxmFp6WYmD4JMSMTa80+xThqAVu9RM2CebVCBq+j+ChmtyafutcpZ3oS3/C6waRpdLlIxNR7t0o3rT7lGpGjS0xYv+VC4bW2sWR9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=Jvp0Ar6x; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="Jvp0Ar6x"
Received: from dog.kanata.rendec.net (pool-174-112-193-187.cpe.net.cable.rogers.com [174.112.193.187])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 76994D07A0;
	Sat, 19 Sep 2026 17:58:18 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 76994D07A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1789829899;
	bh=+TKok9hDY7p6Z7PJqFMlszfKsfnvblxalzrMKMB6/q0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jvp0Ar6xR4ZpiyfqrF7J0StzxmS2aizkdXj11lYVxsiDzhlswXGVjC3fU5+HrQrJs
	 15fJ9Cu8X59KIAoVI2VX9iMCPysTxorrPjnhvZqPcYj/LF5UuDPxuMobkHEBEa9yMQ
	 AP5UvQ5VxX2wkwHPbIM8DWUq1HC/NOthnlrqzhv0YRTmgPwbRT8bGAVklmytEGMI3S
	 t1tuJqNbA2fc+a1SBTKQrk5SLFI7C0j+7PsNqVvuBUGhUj0SVNX1Jy2acdcxUpcuMQ
	 aGLy3GR/OpUrP1Oue+MKG6BElK1xSdY+R3PXfruUSOGfrPXAOaLlwjERnRKEE+Pvls
	 tCkR0K6f9RHpg==
Message-ID: <7c106eb265802b0db161101d376442b2aaf33c08.camel@rendec.net>
Subject: Re: [PATCH 0/3] irqchip/gic-v3: Lifetime and range fixes in the
 GICv3 and ITS drivers
From: Radu Rendec <radu@rendec.net>
To: Fuad Tabba <fuad.tabba@linux.dev>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Will Deacon <will@kernel.org>, 
 Fuad Tabba <tabba@google.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 10:58:16 -0400
In-Reply-To: <20260908142632.2795308-1-fuad.tabba@linux.dev>
References: <20260908142632.2795308-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 15:26 +0100, Fuad Tabba wrote:
> Hi folks,
>=20
> Three fixes to the GICv3 and ITS drivers, from reviewing the GIC series
> floating around and chasing down Sashiko's reports.
>=20
> The first releases the partition node that gic_irq_get_fwspec_info()
> takes from of_find_node_by_phandle() and never puts. Sashiko raised it
> on an of/irq patch of mine, and I said a fix was forthcoming [1].
>=20
> The second widens the per-device MSI clamp, which truncates to zero when
> GITS_TYPER.ID_bits is at its maximum and then denies every MSI on that
> ITS. I couldn't find an implementation that reports that maximum, so
> this is one value at the edge rather than something anyone is hitting.
> It carries Cc: stable because the commit it fixes was itself
> backported, so drop the tag if you'd rather.
>=20
> The third clears vpt_page once its_vpe_teardown() has freed it, so the
> NULL guard holds if teardown runs again on the same vPE.
>=20
> Based on Linux 7.3-rc2 (df2908090cda3).
>=20
> Cheers,
> /fuad
>=20
> [1] https://lore.kernel.org/all/CA+EHjTx7eP_30vP47=3DUFk_wMAut-2uf+2DF-MZ=
qn2SLE_k-8qg@mail.gmail.com/
>=20
> Fuad Tabba (3):
> =C2=A0 irqchip/gic-v3: Release the partition node in
> =C2=A0=C2=A0=C2=A0 gic_irq_get_fwspec_info()
> =C2=A0 irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
> =C2=A0 irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
>=20
> =C2=A0drivers/irqchip/irq-gic-v3-its.c | 3 ++-
> =C2=A0drivers/irqchip/irq-gic-v3.c=C2=A0=C2=A0=C2=A0=C2=A0 | 7 ++++---
> =C2=A02 files changed, 6 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: df2908090cda368b01ff43709f51890076c56157

Reviewed-by: Radu Rendec <radu@rendec.net>
