Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683988;
	b=QlCGGjgtnxcPga0y2yHG9wuvlrV3mxG//7LqBBtm3Cxh/yKhw7tzyAKaub8oFhz6VP8J
	 fqS4fUYHqKlHYEGe4ENpYBMLZ5qqM+TkLliFcoFlkaiAP8OurqPXe5lw5zV0/fuKgDaoj
	 VaCmMikc4Z3Nfj7nupstza7PVJUmeJvFs70Ueuhqahfl6WPbvxQizswWJTjg8ZlnSQxzl
	 AFs/Rci1aw6bv/oZopgd9JrPkJtdPBq1yOOd7j5f1xmfCBqqVlw+ANctA7TIcjvvvPnN3
	 ezCdNzh8eiaD+81AQ0cPu9rDeKZCdYjC8yAl8LV/1C0dxPFRoJDa7qFPlVaP9qQPN9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683988;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=vFZEO4zt4w8Z9j01sARfz1D8Tc/oYb3BjXxwvZoWoFQ=;
	b=SKh0AmbZs+zCL1MUze1Zv0GQDvmDW22L3X7XqmBslabnk64FeMkB5YJRMMi+V/Sc2xnD
	 uBDVMqOezHVfEzcXOCWnXv9HE3CLL6t63Vqj61RtcnQYXZDsg6VOq8KqpStLaJtJ0O7hk
	 MKo6NfCG/7vhRZs6Yx8udsEiRxe77mL8B6HyiXjtpIaT52P6akQ23/qAW6UQZqc3DB92m
	 v55ywYUrkcs7h8Eo10gztiWv7IyQnf+pSc7aDZvCsQZIXXqVnj9wC/iI7RnA+oBTVaycY
	 3gmjEM6SgoAjMrF9n57QDPZbeua4ndaWpXDOHB7ewmNgx5LPAcSSZEajnvmJKtmXfBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E7606A324;
	Tue,  3 Nov 2026 05:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5781568AFE; Tue,  3 Nov 2026 06:33:03 +0100 (CET)
Date: Tue, 3 Nov 2026 06:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <20261103053303.GA1382@lst.de>
References: <20261103030226.2685251-1-jarkko@kernel.org> <20261103030226.2685251-3-jarkko@kernel.org>
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
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 05:02:07AM +0200, Jarkko Sakkinen wrote:
> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().

Looks good, but I only got this one patch out of a 11 patch series,
so without the full context it's hard to fully review it.

