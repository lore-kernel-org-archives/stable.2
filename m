Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793528057;
	b=u8BAgwP08rQfzDxXc9+QSHOcBGEATwKJ5sYmj7VioZyCNDcRki9CGWQ/V+YrATpMfikS
	 xMQERbDqH5FqgUMdsDmWuJWuXOPkgif1RU1PMa1b+0fZRjBhA/1NG9gTX1PTx5UnXWDZn
	 mG3UFIU3pWp5vZa0Nsbd7n5gpGi0+6KBYKGOwhLOqdPiaaJj4gcFfsMQbjM5jAYZMmeZ4
	 vv2Js861Yd2/LYNVrIPTPT0DkSpMhLtI6kjX+1ueGk9tV6FexwCEuSfY2vcxedtmXbPLh
	 7rTUWGWvKCU3hCbqBzTNX9cit3LbRj+aa5b3tAvyKDusfV9i13Uu8ERAZp9x+7sAajg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528057;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=hSHY3WVsUBqgQAxQOpMX314E9mDDGTULiBUsGnrUENs=;
	b=jHU9BaolApf9KhNLKPbb+nwJhUChIEtwOpSC9a04IaVHdsdroyfhOIhi8URzm9eOlNl8
	 q20k+vnplTBmoIT+6JQXy980jlFo5UYiIHDsB//i/y/SYtb6bkVX9ayOxv8u8th1QeWXm
	 hmYF+LDlvY/5tOeUxjfmgnNwrw8h1GrOwiHeZdOWnBDc5Kls01sCD1PGzCAj0UJ6qi8mg
	 y+kDdTRrhhfrVarMDcCPRVTHQjlbT5WDyLqUFvzeh9qLlMOXgIS/MKg44jB1dWi6+8DXv
	 EmObEixjPw7HzWm4dzpfwFgeGo2F1iigO/ZkGbgcZF9WgRXhiJGmVSPkB+zFnvje8yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=8alias.com;
	spf=pass smtp.mailfrom=8alias.com;
	dkim=pass header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=luNrfBMo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.161
Received: from mail-200161.simplelogin.co (mail-200161.simplelogin.co [176.119.200.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B44606A329
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 10:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26B44606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8alias.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8alias.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=luNrfBMo
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793528055;
	cv=none; b=N/XJjuHIuTxtx4AOGBy1RG38apD47dz139zc1KQSxHnRWEG8nPn0pmVv42Rx/5Pzaqv1Q51ugc52yQDxHv1mHkW5gjGHIzkb7R/AF+x9sbfUasGFAvrhwLzyN+kIBp5ghwVy7oRFKNDSP8My4eLwslmWSCwKkUBCOdsaip+knxSwTZwjolFOGRKqtifPfIL8nlja3QUWmHxJeEV+FpmjQy3eKONNIhRQjg15qViKXvHV28BW6slBCGcWE1cSHqHgwwvnsU1gjEVKgUkD+dwl4xv+Chd8HIR8oirpxkJDjoayzeiQk/O3e6p1eJSbnZA6TfHA6YOQYkHyp3Yl6aM55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793528055; c=relaxed/simple;
	bh=hSHY3WVsUBqgQAxQOpMX314E9mDDGTULiBUsGnrUENs=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=IXvdc0THb2oRVhXTLUma4oLDaY6SPSVfjD7J5yABTsdlRHMnWy+FFofGxM9bm1ZX8atQNOnWt+HPAPIF/5FJWllBHdF/hKishMe6REyiFGfcp6ChdEab/3kNeDYYcOzX0HVIS2QXr66Ytz7G86c1J4cgFQVOQ+gmMA0p+Xs1qqUoDSXCkKBAczZagCkDis7JXK9uSiPvovrDqDNbne1VQ1n8itdS/OspxT+QBhvdXdFo8wujEkPAGW9VimlVWsX/ArB7e8mq28PwBYZc/fwLVuMNYjWgaHxu989RdWSuWeXdPOAd0rSAa7XuO92UGS5yE+/t+u57dgQEFd/FWTFRIg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8alias.com; s=dkim;
	t=1793528055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSHY3WVsUBqgQAxQOpMX314E9mDDGTULiBUsGnrUENs=;
	b=luNrfBMobIpIdvKnmGhC5YQ+fCk5xXzXxE8neD3cn8XqbGoywh48XMzuSUfJAbTStHcPUv
	EF17Xs2TenlUznvZyoED3jzsZfjnR+TowpqjZi86WTzZJ+j0M6JfLIABFC0aEz9TatQ1A0
	QQSKDngvSUzUQR4h4viB7LYP1eKDefs=
Date: Sun, 01 Nov 2026 10:14:06 +0000
Subject: Re: [PATCH 6.12.y 2/2] mm/early_ioremap: Sign-extend PAGE_MASK when
 aligning the physical address
In-Reply-To: <2026103137-showplace-numerator-a05b@gregkh>
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
From: =?utf-8?q?Radek_Marci=C5=88a?= <github.unusual340@8alias.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,Thomas Gleixner <tglx@kernel.org>,Ingo Molnar
 <mingo@redhat.com>,Borislav Petkov <bp@alien8.de>,Dave Hansen
 <dave.hansen@linux.intel.com>,x86@kernel.org,Andrew Morton
 <akpm@linux-foundation.org>,David Hildenbrand
 <david@kernel.org>,linux-mm@kvack.org,Arnd Bergmann <arnd@arndb.de>,Michael
 Kelley <mhkelley58@gmail.com>,linux-kernel@vger.kernel.org
Message-ID: <179352805420.7.6433291196676980630.1737402061@8alias.com>
References: <179346145167.7.7861216093151225931.1735978772@8alias.com>
 <179346152914.8.7838190602983146541.1735981230@8alias.com>
 <2026103137-showplace-numerator-a05b@gregkh>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1737402103
X-SimpleLogin-Want-Signing: yes

On Sat, 2026-10-31 at 21:25 +0100, Greg KH wrote:
> On Sat, Oct 31, 2026 at 03:45:21PM +0000, Radek Marci=C5=88a wrote:
> > Signed-off-by: Radek Marci=C5=88a <github.unusual340@8alias.com>
>=20
> Sorry, but this isn't going to work for the obvious reason, so we
> can't take these as-is.

Thanks for a quick reply. I do have a public GitHub identity which
dates back to 2019 (https://github.com/marcinar).

Here's a recent PR using the same name and email (see the raw patch),
this proves that I control the account.
https://github.com/simple-login/app/pull/2866
https://github.com/simple-login/app/commit/f1eb1fcf36d1fd92a3c2057aab3faf1a=
5fae1e31.patch


Here's a PR from 2020 that was merged and has my full name (see the raw
patch), this proves that I didn't change the name or rewrote history.
https://github.com/ChargeTimeEU/Java-OCA-OCPP/pull/120
https://github.com/ChargeTimeEU/Java-OCA-OCPP/commit/9e8f2c09ee34a085103d3d=
6d46856606b05e9a8d.patch

Hopefully, this is enough. But if not, is there a way to contact you
(or someone else) privately about this?


