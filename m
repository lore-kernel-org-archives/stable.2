Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439081;
	b=sX72Y+zp6+0Kd6OgIi+vEZ8r0xXwG5jloWTi5waV9zCVw45yiycBiLY/g8Gxs3Gl6jmT
	 /DqubXQx0DitXcW/Bo+vkDvNC7/x+p85HU0TLlq2i0tvjKJM7n4a4MFYYkXKc7ZITOqy0
	 j918CRWZ0bhqlsfiVr1h1iWrv9sUfh4gx3VIQ26R4E4YqRWSmr6+LqAnnDl0E4+7spXdD
	 9FV1UXp1Ds4PnkCyFHpFnWR1dUSn2a9VQoSGXV7E9NI6fG+aOqP7rJSNIsIS6+lU2F6Fi
	 0BFBYbK87tYmx8v0XuNimhEg5maqMFuAGQSkiG15hsOrArk2nGcn608ZACYkSWM5Fow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439081;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=zCDqV6y0doa5WYO5K5fzLNOLmziMydS10KViqm3njzo=;
	b=oKcBGU20cJV0+fU2ZHXe3r4TUb5BpLJw5vox+1W4U3bfYUfIFQdYFGlZwR4ytLG+UfEc
	 EXBy+idtHLpGddIRgoZRHc7mpXDqjMjW9TVLmOc1Oh0Cw/BwhrwTe/3LyIdVPxwrq9s2r
	 rflIrai9dSqoQIjoJSSMibCXdF6nEwM1WhwFoq60i11+qh10Dv4Vyuso7Mbaplq8yb/pB
	 jg5tgtel8J5axPQDrwuJT22Ei+1kO+ZXTkkXW6MqT1UQx3+a4WtCecYv4Yhwjopwcjflf
	 zDOl2up1vS6ELIVhG1jwVAljzCbnOnJUzKLiOf7tM2ZQ+Axgs0aiPmUnvModoss+L4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=nnCIjnJ5;
	arc=none smtp.remote-ip=79.135.106.120
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50E606A330
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF50E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=nnCIjnJ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795439078; x=1795698278;
	bh=zCDqV6y0doa5WYO5K5fzLNOLmziMydS10KViqm3njzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nnCIjnJ5ZmOSizYmh88sfXzIIFh8+ZZGCtuRvtFSnBmaNZ6Te3pmHNpK2KHz3QF8v
	 +oOZG2DcPJD5rrRwYTxKD8EmoYZXF7lhwhYn28Zg3hnapzRjLsurnzmYamuUltjDbS
	 2OiLbv14o9owmDycb/LGv1wKC5JqmPxxGFMBQOsT22JvjhU/KI5/Nz4jeQJdOi2bBK
	 Q4TlMN59MBEb1GwSZDziAxVxNZoqDjFI20rCLvOw06VnOCyvn/TDC1WMpv0oNfPA8c
	 a5u8sjdjbRULifjkaNim2rGwxn9eMKbiSGVLOSk5hyoS7ALonbKtvMIYAQEfr7HYiQ
	 +vVL+fDtb6xdw==
Date: Mon, 23 Nov 2026 13:04:33 +0000
To: netdev-bot+sashiko@kernel.org
From: fadouse <fadouse@pm.me>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: act_ife: return -EAGAIN after dropping rtnl_lock in load_metaops_and_vet()
Message-ID: <9VcRS9CU-2EQHb_vgmqLp8_F5UYnRrlqgIlr_IpKMsNgNGXJDg9nJZOILB_d2TuFVAacbsK28Ow9_zpxNdYQeL0Ts6s7oXJUcm1Urs36POk=@pm.me>
In-Reply-To: <179543813406.3135.15745616872300382040@kernel.org>
References: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me> <179543813406.3135.15745616872300382040@kernel.org>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: eed5be8e258cc27723349af12f37dff59c8fe4d8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------50a90c1dfec43a8dd15b8afbe1635532f6c0ea395e5089f5674adfdceea9a0aa"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------50a90c1dfec43a8dd15b8afbe1635532f6c0ea395e5089f5674adfdceea9a0aa
Content-Type: multipart/mixed;boundary=---------------------befe82236b17a543bc1350b048947fc5

-----------------------befe82236b17a543bc1350b048947fc5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

Thanks for the review.  The u32_change() new-key unwind path on an
unpinned non-root hash table is valid: returning -EAGAIN still reaches
erridr: idr_remove(&ht->handle_idr, handle).  As noted, that is a
separate pre-existing cls_u32 issue also reachable via existing
RTNL-dropping autoload paths such as tc_action_load_ops() (both on
-EAGAIN and on -ENOENT), and changing act_ife alone cannot fix
cls_u32's error unwind.

Returning -EAGAIN from load_metaops_and_vet() matches the other
RTNL-dropping TC autoloaders checked (tc_action_load_ops(),
tcf_em_validate(), and em_text_change()) so callers unwind instead of
continuing on the success path with stale filter pointers.  The
cls_basic replacement UAF was reproduced and verified fixed at runtime;
by code inspection, cls_flow, cls_fw, cls_route, and cls_u32's
filter-replacement branch (the `if (n)` path, which destroys `new` on
error without touching `n`) also avoid their success-path use of the
old filter pointer.

Since I am respinning v3 to drop the comment per Stephen Hemminger's
feedback, I will also narrow and clarify the cls_u32 scope in the v3
commit message accordingly.

pw-bot: cr
-----------------------befe82236b17a543bc1350b048947fc5--

--------50a90c1dfec43a8dd15b8afbe1635532f6c0ea395e5089f5674adfdceea9a0aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wrsEARYKAG0FgmsEOdMJELmdYLfl5tl0RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeF9uKMBwl7PKMOpqA1eXo4ul0NhAEtc3z91lku
IgC/hhYhBJlIWqN2fwJwSOCwWLmdYLfl5tl0AAAkwAD+NiV9OOO0c4E+vipV
15sxybG3N54IlqKJBxIAe6bQyJMBAPfYzYQKFzaCO4VsJCZ1yNgb0Moj35Ox
26OW76x6o70J
=+Yjn
-----END PGP SIGNATURE-----


--------50a90c1dfec43a8dd15b8afbe1635532f6c0ea395e5089f5674adfdceea9a0aa--

