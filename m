Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66537C91A;
	Thu,  3 Sep 2026 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413051; cv=none; b=qW7GT2s7u2XclEdSyBFeQyOuKlsdoHb049ygCQjbQecMmXcwofR85nV6mvbkR2+M+bhH5vj6go9ejmxAD1Xba1SDqsv8SSPJgSVeAH6rnecGnMewzlsQiJb8DO+69SO3FM1TmVYiL1SsWEkrl5Z7aB8gRWl+ti4lI4uAPE68ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413051; c=relaxed/simple;
	bh=1PA+XMFaH5TzOgo1SJ3emfN3CYUgHe/uZnNmVOJLC50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4wMSib/0IFXYHO3z4XMeyXhFdI8Fj6Hp2xYLmUWk5c6mGpx4PlVN3crM4weeBJEfpIHKZRvggtX1cg16Ozjy9Y8ruBooVRQ7onA+GjNV8+Pq75iHlrLRDp0F4mbk2qEIH/WG+pHNfAlg0DfhoTOVQOU9RkI9AkI4BpVhTDQn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SvIeRoWi reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SvIeRoWi"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A17040E02C2;
	Thu,  3 Sep 2026 05:24:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l2s1PqN88mk5; Thu,  3 Sep 2026 05:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788413034; bh=qPSQhfgflmafwjyzeoKa7tQbzZZtFrhYulM1lgDSmNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvIeRoWiIwa3jt1ek0kmuYqEg5ZhX/jcXzd21z41NnssiBuMNkZX/3OP/wc2W3f01
	 tf0KfUouvdO2cofe5VisYuxAUfDwxstPBAG8WxWQeQTIqK+vGkqLk75S+va1HMjevj
	 t1gY4sY3thvRUcu7aueN8FroSwtNR0VKQhSW2gwW+p3lX27wU0no7+wvqGv/IQzx8x
	 ZEJMLig2m/C0oE472YGF1WXMTMDd5zv/WColutNhTvouVpe+83CtQ8+6hYi0XUkPMF
	 XTiC/CTbfykodpeXtjzDE6cJ9jjS9QqTqCqOGhPkjLC7Uclget+vE2bpwAI9UWggI7
	 CEx4kgOw1DxBNQGF+2alQH8Nm5cnW0DMc2I4mZ1eh8VXTN/0E4qZam/PJSIx1BFEM3
	 Dg4FSGF3bqYISxIa8M2gZmqchRoMmD+KiiF+NGlH/IAkwAFD/ggn3wzfcCXJA94mcp
	 4s/YlKIKPPnGsPiUXwWqPbPoyDXZZVJucW4qSfRdgfxN/nx0YtztVMi/KYXwmuAuGD
	 OsB/gD5xq+X27Srbrd9ha0vEvv43JodyBXj8vuAxe70eC/VN/uEgDt0bfFn37K9ayA
	 MCK8pdhhYgIjGgGh1e7UvMnkJgwPBEFRhKSZU2ELpbnMLapMFazW8LWQi8tttWq8VS
	 VgKhLKAWt875JGFUZggQALyE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B154040E024B;
	Thu,  3 Sep 2026 05:23:28 +0000 (UTC)
Date: Wed, 2 Sep 2026 22:23:25 -0700
From: Borislav Petkov <bp@alien8.de>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, rust-for-linux@vger.kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	ojeda@kernel.org, nathan@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev,
	Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/build/64: Prevent native builds from generating
 APX instructions
Message-ID: <20260903052325.GKapkETZDh2AU8aWNP@fat_crate.local>
References: <20260807151715.7247-1-chang.seok.bae@intel.com>
 <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com>
 <b00de567-f828-4ad8-a6ab-6ab1c47de68e@intel.com>
 <CANiq72kT7KozY5yXyCFpN7-7rc1Rbw1cLPs-c5AFuKYVu2f4KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kT7KozY5yXyCFpN7-7rc1Rbw1cLPs-c5AFuKYVu2f4KA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 05:24:55PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 8, 2026 at 5:21=E2=80=AFAM Chang S. Bae <chang.seok.bae@int=
el.com> wrote:
> >
> > Yes, I intended =E2=80=9Cthe commit=E2=80=9D to refer to the one in t=
he Fixes: tag. To
> > make it explicit, I can add the commit back here:
>=20
> > I=E2=80=99ll add the link to reference the status of the Rust support=
. Thanks.
>=20
> > Yes, I have included it.
>=20
> Thanks! With those:
>=20
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>=20
> I guess this would go through the x86 tree? Otherwise, please let me kn=
ow.

I can take a v2 with feedback from this thread integrated.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
