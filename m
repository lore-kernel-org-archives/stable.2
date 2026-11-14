Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616562;
	b=LPV+6DS+NqluQjyeE74pIF1wuhbBO9gcXTCRKlQ5XwdA06FOxKSA2o3dFltIu2Vq83Pg
	 AxxSEL9MjArQluJp1X16oWG6D9cwdRpQ2+NZOgcxKgoZ2xPW/T2taMdkapYhOqkrLNcDY
	 rE2X+6LtZxyb9UUChdD1Hv4G0Eh2L69i2NJJexOidi0izsZ57I2ugRk4XyPgcrNGh7YAp
	 dLALXORcThe87MluJqRQF6YG4Rdr9GkzGJzR4QcSwT5d4zvc8ARtNKCihdM3OQ/WD/Db5
	 2/rZw/PYhl3DdXSsetf9nrekBXVGtqYd1m2hRp2JBrHIA6d8OA2whXZ+lOaAxDLnr9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616562;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KOIAIMFn214socxnffYVdJ7zS1ew3mG2V4IXKS4HuBA=;
	b=i5zfav9IlvJd4jYRZM6IIyVu9PM+dnjKm/W4Bo47w18l0ngsHfJgNoHTb1QXi3RRcEP8
	 azIuegjZr0wgB6TvflcQMMp9zYO6m96dyoc1fC/F5M0DiJsKaec0b2FCNX7uaOBc3QZnE
	 50YVppSwLeCbw436rAzr9NyefipCInI/YYGr0o5ulLx3B4fdA6vO1YwTXH0cRZXGdZ4Kz
	 frj/YYtxYzqoUasufUxqVIjUeiQL03Zs62bBscu8QEyKSdWA4Bvy9+rti7GYSUpCZCagW
	 QO0tzJsBd/ea0Z//Whfut4zjvWEBBcJnL7wJ0t5MUdiZ+5CczWqKboU/ztk9rwYANyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=kMqTfZNM;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE179606A339;
	Sat, 14 Nov 2026 00:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE179606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=kMqTfZNM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=KOIAIMFn214socxnffYVdJ7zS1ew3mG2V4IXKS4HuBA=; 
	b=kMqTfZNMYkY5uQSGht0xtivQyXS4QQYoNSceVBFK1CvvkabGipzhTwJsc6Rk6KweVag5r30lQLX
	f5FqHMgKzTUXSXgu/URhmW4370HBoDNxwLyou0DSaM4yOBm6gmep8MsiiaQBJUJudY5zi4+0HBXDk
	1Kx+5/4xRPi/PL6I2kp4CqizB86M1pDdYdSdaJU6vpQoMQGvlq+zebkCTsONBLZ5eGYN00EiH6m8j
	Tj9CWZtvMpu8Dhb+FDbFaD3JkiV0SJFfIXB5dfbfDmVDpLE3l37MqwJ4dx7DwU9t1iUO7/rnB3uaA
	wbe3ZMbrVghNJa+HHSiTV9WVD/pzWQk36a/Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xS1k6-0000000ExD5-0nuj;
	Sat, 14 Nov 2026 08:35:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Nov 2026 08:35:42 +0800
Date: Sat, 14 Nov 2026 08:35:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH] mm: kvmalloc: Bail if called with soft or hard IRQs
 disabled
Message-ID: <aves3p5vrqqAuHma@gondor.apana.org.au>
References: <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
 <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
 <auy-7TvVzJ-VCrG4@milan>
 <avcKfEvln8_2a7fJ@gondor.apana.org.au>
 <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>

On Fri, Nov 13, 2026 at 09:47:13AM -0800, Linus Torvalds wrote:
> 
> I don't think this is wrong, but I do wonder if we should at least
> have *some* way to detect these cases and report them.

That would make sense for direct vmalloc calls.  But this is
kvmalloc, which is supposed to choose automatically between
kmalloc and vmalloc.

It was you who suggested moving this check from the caller into
kvmalloc (2018):

https://lore.kernel.org/all/CA+55aFxvNCEBQsxfr=yL3jgxiC8M8wY2MHwVBH+T8qSWyP-WPg@mail.gmail.com/

That worked perfectly until kvmalloc started allowing vmalloc for
non-blocking callers (2025):

https://lore.kernel.org/all/20251007122035.56347-1-urezki@gmail.com/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
