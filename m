Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAA3A254A;
	Wed, 19 Aug 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787099481; cv=none; b=eyNtJd04CJRnIbl0zv+bWlnRvRdvbcD7HIU3OoHH9UNVg/Kur24bZNUrCGcpq44A4ko/GWlzg4PFw4DGQcymhR6yzFZ36U9RuZp3WaMxHbjYncPGwldpEbvhl2l7KXWqSix17XUo5hvLY30Z8mUwvYRLr0fpc41jhCdJdJTBcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787099481; c=relaxed/simple;
	bh=deGHfyias9Px9tEFcvbpOcCWoY5v6geseual8v4YNBY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=o0PdqgW+jeCG9ryVN0bAi6HJfeueOd43PrkhYXf35LTlU2oJUlsqRmRdmCnvzITfe/Edub43RhN22iWvbCTOjUuHp6lYf9Xe6BvJDGhB9o1xYthbAuW/W996c7MQMoRvwBn4ZWIPWenV12sTRspuoZ01a6BH6R+/izNCZ2pdFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (c.1.a.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::a1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 47064340E8C;
	Wed, 19 Aug 2026 00:31:15 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: linux@weissschuh.net
Cc: bp@alien8.de,dave.hansen@linux.intel.com,hpa@zytor.com,linux-kernel@vger.kernel.org,mingo@redhat.com,stable@vger.kernel.org,tglx@kernel.org,theron.york@cloudnuke.org,x86@kernel.org
Subject: Re: [PATCH] x86/tools: Only use unprocessed UAPI headers for vdso2c
In-Reply-To: <20260530-x86-tools-build-fix2-v1-1-2eb92ed1b0b7@weissschuh.net>
Organization: Gentoo
User-Agent: mu4e 1.14.2; emacs 31.0.91
Date: Wed, 19 Aug 2026 01:31:08 +0100
Message-ID: <878q632boz.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Gentle ping. It works for us in Gentoo.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEBBAEWCgCpFiEEJaa7iN2bdkxrVUHCc4QJ9SDfkZAFAmqE+U0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQyNUE2QkI4OEREOUI3NjRDNkI1NTQx
QzI3Mzg0MDlGNTIwREY5MTkwDxxzYW1AZ2VudG9vLm9yZwAKCRBzhAn1IN+RkB+9
AP91Ww5oJ6At7Syc35QqbXZnM9h/+cgc9Gx2Eaf5chTuSQD/Sp58uIQ3UuImdsy5
ua348lU+/y4MTwG08ehGvYd/vgI=
=TXju
-----END PGP SIGNATURE-----
--=-=-=--
