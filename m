Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510245;
	b=34qdJv/kT7kJslhzd6bNOVgi8cKZYpICBSfumxfeN2szD5+hRuAuXlTS8Hhq1a5+6dIi
	 eVJ+q7OO9xD82U0PhOs/Y7EWEfLMYn+cFc6oSbHShqlgwbIPfD7b208EjsJJlLPl9jcBT
	 se2EsGMIlv2rp0/lXfKhHoOyHrGGxUAT/l90zFxPpMgFgd8YMlWN2rfNA7jF8UQ3jbUOo
	 nX6rsvVbPoDRq517n24nk9ZOaLfoKRU2nKOvDBH5kd/6h1c/f/Vpge5nkYRmEStFXi1Q2
	 hhh9FrRnchw3prrW8oKZByruYykyWKy4QTBXRbE4ah9XGr7zs9jSkoD7eDlWk93sZTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510245;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oXWaJS3BkUK5jnqvQMC49nKjAVFsdrkewucaeJa+GrY=;
	b=q/hJQGCHq8oAXHAECn3v4BwSyRtRdWMFDe5vMt1c+ci3piFyo+Bf0J1f2m4FBXsfs/4h
	 w2MR9Ur6IcKIYcYB0k1QYwQIXG6hGie8S7AIk6xB6KY4kEX5hzLCOIwVTRE6sNiDdHiVE
	 CdYANh01v65LOypAZbSLVWn5jmgPCdLPeSZsFKD3FuZS7t80XB4iL1Iz0zTTNx2mYj7ZQ
	 glY8n2kAvgE1jIyg/Ke9CFrwSKq++zYtijFPmKhWlBRI/Trixwo41hnhmKQB+F6DhhpUn
	 9vlj8vEEcZX4dzd7U5az/aLmv1qcEloU+XsukTmi5DOpINowr5z8MT4U2fqolgUY0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9DEE160A2625;
	Tue, 20 Oct 2026 15:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BB4FA1F000CB;
	Tue, 20 Oct 2026 15:30:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:30:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Yuqi Xu <xuyuqiabc@gmail.com>, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
Message-ID: <ateJA_WanjASrIUM@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org>
 <arw9CHc4mIOm5C6Q@kernel.org>
 <20260930033300.30295-1-xuyuqiabc@gmail.com>
 <ar8hhrjQQw_yfghj@iki.fi>
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
In-Reply-To: <ar8hhrjQQw_yfghj@iki.fi>

On Fri, Oct 02, 2026 at 06:14:14AM +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 30, 2026 at 11:33:00AM +0800, Yuqi Xu wrote:
> > On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
> > > No need to resend a new version but I'd need a link to the *report* to
> > > retain reported-by tag here.
> > 
> > https://bugtracker.nebusec.ai/f/675
> > 
> > This is the report. The page requires a sign-in or registration
> > before it opens.
> 
> For me this is good enough given that there is nothing unclear in the
> bug fix itself.
> 
> Thanks.

OK, so now that I was writing summary of TPM pull request changes, I
came into conclusion that this is not a bug fix, unless you can show
from TCG specifications that this is possible spec allowed behaviour.

So I can keep the commit but would remove fixes and bug related tags
from this. It is essentially hardening and safety measure but not a
bug fix.

Do you have something to say that I might have missed?

Br, Jarkko
