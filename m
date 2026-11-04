Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783086;
	b=T6+bdBsqsbziO2SWc6ki0ogy2RrVgfcYfFa3oq5C3C8y9FwoHgbtqTsI/DUXddB3fFgY
	 NDsFyOGa4k7muhwkHdaIxidZ0i3ZPccTtqW6ucVUz3nOI4TNmU4N1WzrJbofWnrsu3Lzu
	 gmeEljRA97K6kVVt8DFHc2rZI4/E6mtPcFkL3kjVkVH2iQV5CFjqv+fNFS69kWiABE227
	 ZEEmeVry1JDRjhRLwMc8E0n+gu5lQ7coWFo5sFHvbq4OqUShy5Xtc35MAgE32/il+Xrs5
	 lxb1iIfcBWUnFpkwNhVodqWp9ULt73HdgNg7BWyxGKJ2EG10ySpZL5eYHG3oLVlK4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783086;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=tcFCvk5dy/5nZvQXEyJVg4b960/R9SgdjtGuBESCiW4=;
	b=c27ANWOeqvfcrDf1q1uQ85ViJfinIEuEP+fNRYlck2hxyNsUYkNHXKzduL/FodkTTpBF
	 0MCxAlpR3PW2TcqO1Qsn2j1b0zpFooH6Tl6vcKq9toaleR5HTH2rs4JY4Bqn3ESLNGrQX
	 ai1ybJYeT14jevCxXmaGik3SZ6aflVjKx7M88kxh1x30h9V+z8PuJgLVGKAAZ1x1HotwP
	 mLpL1iY5ifvCb/01cQtHHQoU5iH9WW3aCDEZfJ7Dl3QEGGlwDo09+erok2cXUqEUTlWht
	 O007ljC1r2LLrnVEggsiYFpWMNYEcMSpOfWBVNIdF2G5tjIA/5xAIWPYQLh779jyQbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB312606A32E;
	Wed,  4 Nov 2026 09:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB312606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2B4E68BEB; Wed,  4 Nov 2026 10:04:40 +0100 (CET)
Date: Wed, 4 Nov 2026 10:04:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put()
 call to nvme_tls_key_lookup()
Message-ID: <20261104090440.GA30968@lst.de>
References: <20261103030226.2685251-1-jarkko@kernel.org> <20261103030226.2685251-3-jarkko@kernel.org> <20261103053303.GA1382@lst.de> <aunTlxXbRJ6ZP63h@kernel.org>
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
In-Reply-To: <aunTlxXbRJ6ZP63h@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> And essentially what I would want is key_type_dead not to exist.
> 
> This version is based on module pinning, and  thus not having that
> key_put() would keep key type module alive in that case. However, it
> turned out this approach will not fly as AF_RXRPC and DNS resolver will
> hit the wall given e.g., the remote pinnings.
> 
> The approach I'm going for next is to have a type registry instead,
> which is independent of the module system (to put story really short).
> I think I'm doing this with right process as this really needs a few
> trials in order to find patterns that stick.

So what's the plan here.  Should we merge this standalone as a fix,
or are you trying to get an entire series in?

If it's useful as a standalone fix, please resend it standalone.
