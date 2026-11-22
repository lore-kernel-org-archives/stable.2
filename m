Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340332;
	b=UUDxo/e7PvcpUbOcBbGCrVofYb2Blm06tsNdp6FmHZ6pI7mFGK73UaRGovbIfZnjk8Oo
	 8jNeVcXkeFtZlFLXBNP0kB9d7Y6Y2hq7oOdv3OLNe8EaeNZr+LtpsYmghz9JDYAT60j8w
	 uW1rPkOI4XplOz+3LJka3b8f3k81VreBOnwitmGYWE6M23Cm+W+Yhgmav0cRIePjNSyeK
	 epxxiowOrd2bMfB5Griq5rT3xQGDjy5ohcuVWb2dvCfCkj8vuezdlqZKl0AQOio6rZ/TC
	 t1qClv0h7ZZyvFYzKqH1f3INcx3wFrFgFvu0vvXBPhBDE0ne9pfyCf34ZMiQfBW/X5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340332;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=U1mDAIJW9kD2eG2GVBXGTpymWIz23aeKAV8ShM6Iapk=;
	b=V53Jplc3P9ePZ2yOjX0/eYf6uvwY4kimZzflfvaP/snUDZEADKE8ZhkyaziIlZs7YCNm
	 SBEqproWWUJX9IMk7WYtOUv4U7iaWWvcJYfyoecXz0xQZ/iYm6rmex4ohK0J8IcoQKwCq
	 nB4VexHXkH+vHufiOEtraSIXoejbchmHdUAnQaGN1vtGSBRd/KwbxICPvPh6YvtJ+wBCb
	 s79pi7LvXL2zWUK3r2AL9jkm8H/Hc/eYl+w+SPtGENoDIwwrNYjT24DBMfmgVYfeAPj7h
	 /699EfU4nMmAX8/xYkgLVd4QfbVTztJHLc0U5V0NrsmSzMt0+Su0E16o9Aw2IrTs9aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=Z9A9R7JA;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB4606A32A;
	Sun, 22 Nov 2026 09:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBFB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=Z9A9R7JA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795340322;
	bh=U1mDAIJW9kD2eG2GVBXGTpymWIz23aeKAV8ShM6Iapk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=Z9A9R7JA3rkl6EYunOiCP/mpzrbTetkxuNkubCTUZraXO2qNiVwI/GWNqjjGJnQB9
	 76n8/uFL6fiKKczHGCM1pZUioPE7Z5dfg0cAkB6DLR4h8X67jmYPkrisILIHbha4k/
	 rxOmacCAE/a1x+BjG46/uSbGgfOyQVbnJqd2Cmo7Glhdo20AoaxvX7vTXPw1g6lPtQ
	 1kq6CtRPAY6ww6wz0r2DvxiWlt7e1W0xGWuw31kd0MhDrvr/amlm0ifWmN/3qSs240
	 N6b7oc7clmzYTPjHuUkybI7UovVpoZdRStm9lX40QwvzFy+DcCnzqFhQR5p1u4Xks9
	 6nIsjrsrjLPhg==
X-KAS-Sym: v3:f51bdf72230551df:BHLVAvXUbecqCx65KAKRaRfSCRJ/RnepLulMBbwPWwteb
	mripFIUpAml7cCtqERpaMGvp6Ak7OV3lE8iPMOqmpySjQJMXBc3GoUaNiOJ3JYVYJ6TKopF46jn
	q4uVWX6C3Ji3T33tnuwTxe3Tg5o4SRtDYVASaC9EWX+SWjXVbz1MzhyHPUZKqWAoEsfJYQOCr3/
	e8Hmx1pjaNOkVRlBEOwew3D70xuqqwYoYiiy7493mCJFAFA1pSDWWiaM9UqR8fM4BH7M4Lf2I7O
	IPBxu8VLsAFMYOTxjDWwPLNwXk+ftVWkLUIsiPpytvLNorB9dwbxDD9FVg92DyAthgqKyJeg==:
	a7G5SU3Bbpm/3eSfzfoRgv+f07BU8DM5q3VKPAoWYhggBXgG4dVR0a8gkHsJZMNv2cQZLQ4WKwt
	BwcEOOCBWFjWosA4qFPS9DvfE7emiJnCoeO9lJkT+gjZpdPY/psrssJjuzilj0LXLn9TSwGHW7P
	IE9kEucqwM/xrKxOBsjAAdmJE4Aol6zgR/ZNHaQfVOcXYkVzl06cUtew2lmfSs2iXoI1dJx78dL
	IaaJGSx6oO6mzrvhajcSx3rjyqX9WJbdDeigUIBSKieKEsZkAcrD6t81PddXkjehe1eRcWBC5gI
	SCONptKtxPdMiyZuT9oB8ot1LmyYAsxkNyRgSPgtyFLUeKQZkwa7sw0b7A+B9zyl1pbO95nPQlL
	J3kw3tITIKpV7zDJ+wodx/41R1uYvWHm4SZBcK5S8JXb0LX9vfUsFcgzyKx69aZ9MEi3Hkz+SzA
	v6DQj/3mHMKBvDyTNQoZHcQ3eDsS1/VUZvgHXPKxBZbsMbeRMw6zVCfFAoN7/Uu+RLdxu2fxw5K
	1jlA3fK4tQXOPHkiHkjbQVclz0y9//1RRwhFjH7BFfxx5rYXXzLsb9nMSl1WBYaR7GIEtsqk7xg
	todvL6A=
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id EBE667829502;
	Sun, 22 Nov 2026 10:38:41 +0100 (CET)
Message-ID: <263913c0-3bd6-44c9-a6c3-566f53013996@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 10:38:41 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/tegra/soctherm: Program throttrip with
 hot trip temperature
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>,
 stable@vger.kernel.org
References: <20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Hi Daniel,

gentle ping on this fix. It has Reviewed-by from Mikko and Tested-by
from Svyatoslav, and it still applies cleanly to 7.4-rc3. Is there
anything I should change, or could it go in as a fix for 7.4?

Thanks,
Patrick
