Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301100;
	b=yEyQtGtuDT/rQn0gLq1vpxIsX76ju01I6qb/SbxqJKnS2JklimS0u0uobRRk0VngqzS2
	 cM0mzLJLn6bea1QVrGJ2mc44nRqb1VydqhXyalc5yy6NgvdivaBdsYZw03zxlvh0Wg3mU
	 pcMON8ukhl7P+XzeuRjzREbzYU3FKOxaypVEfWJXSVnztr8WYBMaceYB5Cqo+/h7pFDiL
	 MDceLMQaHIyythPvhJl7ZV2/mwlQMN3PCjMqZg/WNFvDlEUY/a5GwGR/mGvPEYPCQf5pF
	 bUsaYNgwLKbk883Q3vK6Lalwc7GxvUATbU8OmR5WRz0gN0NXzIqtOtMpdwYR8HN2cbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301100;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RHZzSa8LRN5POIBifYmNxN50HUALunA8yewndzwP5vY=;
	b=ANH7PGgp8kH8AQXruGExvo1hNDvne55BCYlhns/ml00JzuajBuwziHBKIUKXCW8l6fx8
	 tokYleMLlpRDV2FLx02apZNsgd7dVDeigAeAKX4WcqRlnEY/EWeC8dZP9R58Bkl63+2Vw
	 wBaJOOO/e8/fQE9lZa1r6nb9nW56tFlG82d5exeB7OO8r+CJ8UFccjXKNVV1sg2OO6VjC
	 h+DQQQEfWkp7bhWoEcFdfR0x2/EjvUz5LoEa2hgKe4AWacbeKtt9r1C0woLOyftjTCFV6
	 q7LZk96aOh23Fo+ECN+waBl9j55iNePUnEmuQQGhW0a9UYKF8rDbbTO/9pxB72LIMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imyIu7jb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 16534606A321;
	Tue, 10 Nov 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imyIu7jb
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9F541F0089F;
	Tue, 10 Nov 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301099;
	bh=RHZzSa8LRN5POIBifYmNxN50HUALunA8yewndzwP5vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=imyIu7jbu2jI6lFLP4qylpkSOcEqCRcjPSM7h5xbuxQWEoYdhhqrLvokp1oL8eqcH
	 aWKUzSf1wJYixwmWWrZQs02FWenw86MTvpWe15pVrRnvjVwGUZNcDaTUte8IaZ1KbE
	 YNd8DytXbnK19t4K9nynnRyODa+Rg4pqYTcjpmMa9yDN2M+WDkFZunouaQMFf3stwh
	 XL7TssM35mcIFt60nHMDxnj5EbkM1izjYaiu5iSbaxEw0xbZjFWjHP9RjcljycQw6l
	 jQ6bCyfrquyibDPemfYAQS110t+DknznWxVmb4pi6WX1/JWlmeJlmXHAlci4FMbVW/
	 BzXvhJd/vWBmg==
Date: Tue, 10 Nov 2026 09:58:15 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: synchronize updates of descriptor labels
Message-ID: <trnf2aayrjdo2ks3ads4cuda4yen6qdvzvpmitktmzuggv5ix2@hjqcnfq4zo6a>
References: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
 <auyYVmSaLBS--52n@ashevche-desk.local>
 <zgvjoccnnhhjmlejoazmz7mpfmndbhi2filwbtudq5i6s46boy@szoywmokacny>
 <avILL4gd737gmDR2@ashevche-desk.local>
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
In-Reply-To: <avILL4gd737gmDR2@ashevche-desk.local>

On Mon, Nov 09, 2026 at 08:04:31PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 06, 2026 at 10:22:07AM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 05, 2026 at 04:53:10PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 05, 2026 at 02:23:45PM +0100, Bartosz Golaszewski wrote:
> > > > desc_set_label() swaps desc->label with rcu_replace_pointer() but
> > > > without any synchronization of concurrent updates. The swap is a plain
> > > > read + write: two threads can observe the same old label and then call
> > > 
> > > s/call//
> > 
> > Why? It's "call $function_name" which happens to be call_srcu().
> 
> Because with that kind of name it sounds not good (tautological).
>

Nah, this is fine, it's a function name alright. I'll allow myself to
keep the wording as is.

Bart
