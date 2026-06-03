Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489446AF25;
	Wed,  3 Jun 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488549; cv=none; b=kVyRjGyttfuKuBiAoekuTE0VqR/sjFBl1kqyeoAGS3eN0bunKwUtT0QccnD5btzVgylLwhjWEczuoMUdGe0pYmHvog/TLwyGZcrB6+i8UJweAbNjiqed6DyH6zEXl335EVJKoUQa5XC1lDrcuTaGW7IIFuV0c0uR4X8g/q4uTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488549; c=relaxed/simple;
	bh=TURbif7gWNaDDF3klfoXuexBKsR0D79kAq7JnNnfcwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P06ZQY6Y/uZa4qG+WGzGyiuVxL0v+IcnrWbnZh527yvWSDUt9pUizUSqY3yxf+57MGDRyKq4HknnBWVBi+kwK9c3JAV2GuxcJuQk2UCnGL6jzpETSroSyZwpIhAc5wkEtocZz4kFi1pUxYeJfIKZP0xRcbQxTFvB8pXLfPuHyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KaDAE/br; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KaDAE/br"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TURbif7gWNaDDF3klfoXuexBKsR0D79kAq7JnNnfcwk=;
	t=1780488548; x=1781698148; b=KaDAE/brexMWhBvutk1AT2zitW4vSJy3sPeFfVakHEfrnwx
	Ww0yJe5d3c0N8unG1fAFJcdWkq05pWsYlz99DMcHMuuOrnbeQ7qNjvlj/3QCZiiFDAuu8WjRwpKjC
	/uNF8/pRGI82EhSOyITScPYEiY9Rgt2UgGmt1OU5LnXQHaRt7GMqqpEQfX4chrpCfhrJoKFnTN2k4
	8bqn7R6cgSGWU6I4Klt8TKpEbiKNjclYWoohqUj8p/uRaB3eNGDywci0RPtvebE27hdgpVhyz6f/K
	0iYTn/OM2vEInjoFUY0VmVLoUeKYE8YdBEqqfacPP+KWD8X0jTTe3f9tW1iqKiWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUkPB-0000000H6Yu-076l;
	Wed, 03 Jun 2026 14:09:05 +0200
Message-ID: <734be1c57f6739e9bae6f049074a16503734b17c.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?=D3scar?= Alfonso =?ISO-8859-1?Q?D=EDaz?=
	 <oscar.alfonso.diaz@gmail.com>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi	 <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	fjhhz1997@gmail.com, Brite
 <brite.airgeddon@gmail.com>
Date: Wed, 03 Jun 2026 14:09:04 +0200
In-Reply-To: <CA+bbHrUqv=4y7OUQuaheLuoBjp9hnaxw_8WwFOY0o8J4xm-K0Q@mail.gmail.com> (sfid-20260603_135443_011740_B393183F)
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
	 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
	 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
	 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
	 <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
	 <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
	 <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
	 <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com>
	 <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
	 <CA+bbHrUqv=4y7OUQuaheLuoBjp9hnaxw_8WwFOY0o8J4xm-K0Q@mail.gmail.com>
	 (sfid-20260603_135443_011740_B393183F)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-06-03 at 13:54 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> Hi, after my yesterday's email with the tests results. As you can see,
> all the cases are working but the 5ghz+VIF+DoS. Will this patch be
> added anyway while looking for a fix for this specific case? if so,
> from what kernel version will it be available? 7.0 I guess, just to
> confirm and update airgeddon wiki-docs.
>=20

Thanks for testing. I really don't want to have stable for this since
it's known to crash on some versions, so it'll be 7.2.

That's assuming I get a new version soon, because this one doesn't build
cleanly.

johannes
