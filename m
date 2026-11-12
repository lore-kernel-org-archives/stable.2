Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492748;
	b=KxC4y2GW3iYgtUrTPfzSP4FrOqvHNg57LpxS1P5hM0LhVEALH8Z7a96PjC8mrUiBusSY
	 tqe75u0On2j2X+IyVDoKJ3V7hyO0sIfV8vumPqOUarzDs6OXK/Wxj61tA+MG6XUICzQF4
	 EqHW7L9cbJ+LRiwI3RDmeEf5Z8YRY1v3KPKB/MW/GZDGVfjZEinaU/XhbpxjPUsT4kVT5
	 rhs/UcHpH5zuMF8dPkOBFyMIe1PxETpH12vHFJtLDDH0cKR4Iku2OsgiL9WulpITJb0TP
	 i6LUTgWmlDup4TQGO5JExDEqk4Q+GDaDQWCNsTiXvv2eqsidC+WhGV0qVVtsh2ZC67A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492748;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LLgepSpmTFKlnz1y/yhLoyuPFm3/4g3SJxDL0aIX9Js=;
	b=QU/lJYcSP2+a/lb0lI1JbWxexXoQA+qqUjxrXYg2T8oVwMjyyOPqqZS/5SUyV/gg9wjb
	 kzg0e40O9TTn3ZWiV3FICWC0nfZ7mApXkbP9+Ncfl/F41eypk/rGUQkMPi6Iu9BWxdhRb
	 LNGmpDAwDeFsXntRKCouHVx7hJYlCMTdd9oXtPsU23aZzfDrpJt6BS/6Ty3RrAEudXCiX
	 AKreOxcPVCaXe3+JPvDnOUXe9l3YBFtrGB+eSk68xnAdoXv/38uKmsvx8IRpV53CGs65b
	 xiPoRAb6PUPaEOX4PGhq5ASsL/xtzsidABShaMqemujZjnkxCQ3eaNJAZvDg0iXOI2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbUv2Bdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5154606A31C;
	Thu, 12 Nov 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbUv2Bdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310C31F00A05;
	Thu, 12 Nov 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492748;
	bh=LLgepSpmTFKlnz1y/yhLoyuPFm3/4g3SJxDL0aIX9Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BbUv2BdguZCP3qKWTVs4X2hEbpYe5LftvnZVtHAJSag7IUmxIi1F3uLofwtRQodXa
	 cHMylkh2Ehxhbu/lhSDiBE3UZ7Y4cPnWlvpvPjPmdNl92d+5DVryFIw2vGpVGQJOVt
	 aOH3DcBHUTTb8OIHl6geEgQ8siBzrfZF4pddRQ4DYju0/EnBRGqS1PjHqK8gAqp32/
	 USdzgTD+grb2FekH2CPFWpVcnmzH6yuIJc5F1HDHrOpWlSR3JEMkqXRcMWAVVwn4It
	 hpVdE3pMIirn9HdaWMIwuKICKXMi2aVL7ljtZGPX2TTxykprori1a4MpTe+9NKOJHg
	 S0RxDjO/5XTSg==
Date: Thu, 12 Nov 2026 09:12:26 -0500
From: Sasha Levin <sashal@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, workflows@vger.kernel.org,
	ksummit@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/6] agents: add skills for Fixes tags, stable tags,
 similar bugs, and commit messages
Message-ID: <avXJSt_3DYx6aQsD@laps>
References: <20261111225940.1573565-1-tytso@mit.edu>
 <9c5f5976-ebed-48f3-94ab-1121231af6e1@kernel.org>
 <avXCcPYM9VAP0JHf@mit.edu>
 <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org>

On Thu, Nov 12, 2026 at 02:49:09PM +0100, Krzysztof Kozlowski wrote:
>On 12/11/2026 14:46, Theodore Tso wrote:
>> On Thu, Nov 12, 2026 at 09:26:09AM -0500, Krzysztof Kozlowski wrote:
>>>
>>> All these are docs (even if you call them as a skill, it's the same),
>>> therefore they should be placed in Documentation, not in top-level. We
>>> should not create one documentation for humans and another for agents.
>>> It's just one documentation.

Right. The idea here is that agent skills will mostly refer to our existing
Documentation/ and will only act as a glue layer to make agents behave better.

Consider, for example, one of the most common feedback points we have to AI
users: "make your commit message way less verbose". This is the type of things
that would make sense as an agent-only instruction.

>> Skills aren't necessarily *just* documentation.  The skills
>> specification[1] also defines a structured location in the skill's
>> directory hierarchy for Python scripts or other executables.
>
>Specification is also documentation, just like for example specification
>for our ABI. It's also located in Documentation directory.

One of the reasons to keep it out of Documentation/ was that it doesn't mesh
with the infrastructure Documentation/ uses. For example, Documentation/ is all
.rst, while the agents.md spec specifically calls out for markdown, and a very
particular construction of that file.

>Agents supposedly "are just tools", thus just as sparse, smatch and
>compilers such tools do not get another top-level directory.

I'm a bit confused by this... the original reasoning was the it doesn't really
fit into either Documentation/ , scripts/, or tools/, so we just gave it it's
own home. Why does it matter if it's a top-level dir or not?

It's something we can always move around later - agents don't care where it
lives as long as it's refered to by the main AGENTS.md, so if we later come to
the conclusion that it makes sense to move it, for example, under scripts/,
then we can easily do that.

-- 
Thanks,
Sasha
