Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418431;
	b=Ckwpg+PRcoU15KSUuZj7R7aC7xP4YaPCkRpb+PmmhrRi8tnGzhZ8K8JvPJM9Gl2k/JQ+
	 Shu19kCCYacEonq33y8b96H7rqj2DTFi663ei4nJji6PGQPBU2LQnxjBAJG8MZwtUWrif
	 uLyGZLfF8SvOz1mT4dhH53qBm7Bq+EKtz8/Pk4hoHlqZhoShcN7tFBfrULnoN9OnD6/eY
	 R+nskGuI7JoItvP+ZYvOGogEp2jbiZtKmucbq9HDRPZWuQiKkKk2pyYWuT5y/k3OgF0xm
	 aABSZmTjRnDlT1bVhiESbH1b/SxxyrGUf3PmC3WPG0vNnawXJmitUxB2SzTJK3gfe7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
	b=ZkGBapBG1FdGzQy5745ulzkM4XJ5kW9/PgLk0z6CLgo8lqKOK0OP23CstMIGsFk1qYd6
	 D61jQG4E+IvQJt6oZWuN8a16KXv/AHBEWFOUJNj1IhaHF7EP4W5TjV1L+MD54zyfZB/8k
	 fZueU0BUWyV9TdovcLLQCNTfukeoWWPu62YxG4NqvTzWcOrYInrJV3IJcbeokfc/MM8Wt
	 anuE8bA9GU743HegGlKc+W5tjSMaZ4HqK/wVByjWpZqMcw/tEYQDp7psKjZ2mA243lYvK
	 fYsiA1OqWdIW2iaVP7hVUNLZHxgekaCVTerVX7UC7eT2l0Q74VdBjWjshHE8052ROKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=inicpcHI;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=inicpcHI
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso32656565e9.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794418429; x=1795023229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
        b=inicpcHIZnCmcEzzbQ3MmS+YvAq5Scx+eJ9EP0DS5vSfJefOX+7im3R61WEtmbEGl+
         dQYNLm4/6io+doNd9QANIQ6WylX4hduah5G4JDStbFnEWoV7P84iUQF85tuo0xJNCzNw
         aN3V9JTnWA60LAX3s+/huqc4XN5Ns1yt4BpdYMf8A0yraHLiQTVM47EhyXSISbGtnFBD
         yHlXYVmCDGP3L3un4HqqS8xbEzkjU/Iq6t3mMA2sgks6KILzghfpJ9AblOFId4RbNlm9
         uAlIC0j7fn+700Zw+nQvMXzWSW9GLuHq2IuV6bR8sm70AUw5ZcaB+j09j1imryd9SPzk
         gPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418429; x=1795023229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
        b=1RWgmmd2EnNa+2WlfpGx2IUlQhKclEKTadYhpqGdHBeKd3kumMfsZwmnPHol+fXMlz
         LAFYetgDvMYm/gD0d/4gZUThGu1PM/j6QcsYEL9hpEJVhJBJTdJRL+jmvRdbuxciC/EA
         nmfA4bDDxaUTZOIorWy0Fhi4EFxoKYKnA48RSWEuoL5t2JM8WlrkZbtyCAG/VZnesob9
         XM+d+DJtO1ujSJDruzLaEMrUf+Ojv3pSapliGbBtwfE/ajYj69LzCwal4ay0If97ckmi
         SAXs4oLXv7S4uwcpXGb2KGxf7lgGgGjS57/s8brWnlyD5Kt62X5Yd/8OGs943O/l5G/I
         1Bcg==
X-Forwarded-Encrypted: i=1; AL+hErG8cY/Z95SFTSv17VTKc8xN8/f9FPfy+gwYjmOE2YSs+DOensxPKWBdXtwmSoVU7zTsXGDwdnU=@vger.kernel.org
X-Gm-Message-State: APuU4Z841w8EAqNLEOGyBPRsFVVs6dBuUvJS9kJi4mv5YmCxGQwBizZL
	ttqTFErp1p2WBsDmYvT8rszUSRFwCcvmmuKTxJKpYTMPrHLDUKlnccAQyDp6bZuiVdA=
X-Gm-Gg: AYBFou0nhIz/jeBi8SyHS3i+Z0yN/+B6TJTbapnPm/7b4IUBH0U3spCsMjJU8k/dK2H
	q5XreP3i9hnyqdbNa07+lXgWXybkdmhomnd/gqbg5KgHo4kd1UtsLaPH13BpwYbV2d+NRoed3vv
	Y6JyG6zt5Ti+0D4t321I5H+M/f13jaJAZwNi6tV1tFSunDKK4lNhyqbn+zbWYxsW3zCF3w7pScT
	0eYz/yDXpydvGMgJm8poibAe1qrr2NnHen2ltnhlCYNcxPiY8MtQs6RcxxPIyULAwaM0C1QAo57
	pW+lpTNTz0/vAEKG0m2RtykHhb0wVz6fHCVkno/pr2TjlKk4tcgM9sxUKNalJef4SJFKo6C1jsr
	s85vJVPn8SufKSwuhiPhXDjB5/ExclCs/XbppqjG3JgtcXq5T2GcxNqRSN1k/rLsruS6ZRZkPL0
	IVeTknXN4EfJjnRqupAEVfue+mOLaJqF96xHWFfJ/vcBs6tC2WRbnaVZqgykNEOUNn7/c0Ymznv
	8er5FQvVYXwuwax+OwtuYFx6/MYOK8BO3a/DY5CQJqeekgpklO/HZfPDlR/4p2df/maakq3mdOj
	eAMizVfE/9aa9IYOFXphgM05GzFdlnypKKJT3UXHb+0q2yWhTtL9XEaY6DQjHA2n/PMJZpi29O3
	jyBO2h/lRMH+ZC6D4UTIWlp69GtAUAf+/TMJLPw==
X-Received: by 2002:a05:600c:81c5:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4ba09376cc2mr50842555e9.18.1794418428621;
        Wed, 11 Nov 2026 09:33:48 -0800 (PST)
Received: from localhost (p200300f65f19a9045674a4e2f3db58c3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:5674:a4e2:f3db:58c3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4ba0951bf2asm51567095e9.4.2026.11.11.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:33:47 -0800 (PST)
Date: Wed, 11 Nov 2026 18:33:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <avSmq-LRKgRWDfxH@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
 <akfoYuyHMAxIfalD@monoceros>
 <al4lxVud4_6NTZQG@monoceros>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hfc67dntoyzrou5"
Content-Disposition: inline
In-Reply-To: <al4lxVud4_6NTZQG@monoceros>


--4hfc67dntoyzrou5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello,

On Mon, Jul 20, 2026 at 03:43:09PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Fri, Jul 03, 2026 at 06:53:16PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > On Thu, Jun 18, 2026 at 04:01:47PM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> > > When determining the device details was reworked in commit 5e6c3454b4=
05
> > > ("net: can: Use device_get_match_data()") there was no replacement for
> > > the previous handling of non-of instantiated devices via the device's
> > > id_entry which then results in a NULL pointer exception. The only
> > > in-tree provider of such a device is arch/m68k/coldfire/device.c.
> > >=20
> > > Given the id_table only contains a single entry just hardcode the res=
ult
> > > of `platform_get_device_id(pdev)->driver_data` and drop the unused
> > > assignment to .driver_data from the table.
> > >=20
> > > While touching the id table, drop the unusual comma after the termina=
tor
> > > entry.
> > >=20
> > > Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> >=20
> > Given this fixes a crash (NULL pointer exception), it would be great to
> > get this applied. The issue is already old (Sept 2023, v6.8-rc1), so
> > there is probably no urge to get this in before 7.2, but getting it into
> > next and then 7.3-rc1 would be good.
>=20
> This still stands. Marc, do you have this patch still on your radar?

For a fix it takes quite some time to get applied. The patch now missed
7.4-rc1 ...

Is someone reading this ping?

Best regards
Uwe

--4hfc67dntoyzrou5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0pvYACgkQj4D7WH0S
/k4bNwgAsQchSshsvcSs/c8msQEUeFLmy38NQ5NvYG9rkvtJ5DGZBJZCWbiMnvQN
UxxEUyz189PGDh41YHwkGDS1NMvdFvrl9uptRZGvbI/iB6fJP38y+ves8Dp1BBUQ
CiGoYQ2oqm2R2WnYwsUzdVL3E9R7zMvkueC0YW5h6BerQroVMVDLtclvQ8iXMMou
Ko+Dpwg76ba2xYTAHwNhyrNxQraVOp+o6+IlCIcKCK8hCwV7AFS6VU9zwEgLsUms
X3yeTFHRNc3aZGjulbY35I7d0ujF5iRrEFLzI8MIUcCUiIXqCkFSGGV9450s+uz9
RcNFp/Rrj1+U4tKfnch8QGtgmLvSRw==
=5KoS
-----END PGP SIGNATURE-----

--4hfc67dntoyzrou5--
