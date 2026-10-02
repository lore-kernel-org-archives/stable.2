Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F2218E91;
	Fri,  2 Oct 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790910861; cv=pass; b=g6JwXsTDqwb8OqyFc/OpH2eR709iriAkMhGNFiCCTLs/xjD6a06ty9EBwxfeqKSvFMNNQ0OF8+7zLL5o9SDJfe6ZjZ9+G5ZmtZtYiL6kgrumtLkiHjLuMP4XO7sMKQuaqsZSICKL8vtSh3gPI/E/7tWuLHRhJlAkerMkSj7Chts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790910861; c=relaxed/simple;
	bh=KlrddkAcL21CT1wP62gBt1iMn6oQ2zZqlsf1KLKmYnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxSYY9NCkfHL5+khREvR6kD61KA9HN3N+WXshVR7dM7KppRRJXeFbh+Rr7P8iYEuOHh3KFlDQWPGRNRGHOe4o5gpH3ZNjg4V13E98Srywm8nttc7LnS4JYmHrh2LaZE7EGU1q/cKuuyriulXxcqRoaCLZIUoNNjgM3m27RYDtOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=L97ni+Tu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="L97ni+Tu"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hwv5N3W6FzyQx;
	Fri, 02 Oct 2026 06:14:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1790910857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGtpNYTGgdhHAMQPlGNIxETemobEG42tGUoZ+XyGJ6M=;
	b=L97ni+Tuvgtdn1n8cyEprtGXX8cJf5lXvGPcjhW8b2wfDgvyyXYFyok1m9F3XOuUw/sfNG
	Ax3oZumKsFx1L7+TYPMgQIJr65PSvYRGGzt5l5SEmyl4hymiWb6EEuseUESV7S9xFLdmn9
	wxb7kUf9RRn3Z4Ae/exLbF7t9woiLfk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1790910857;
	b=GAd/XBED5cYKd6dW3fp/en4dm5XyhHSz26DeptxMNEs9CaXlFkKSfbMDkek+3QfhemHFqu
	2+7Ig803ulJ9uzTABBG7WB4YhdUN85pIIS5DnT3CKShRl9smOLx/+AociOTwMOLXyBYJAG
	rnWC6TLq9RufV9/WQOvqz2eG8f7mJO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1790910857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGtpNYTGgdhHAMQPlGNIxETemobEG42tGUoZ+XyGJ6M=;
	b=WIGcc1R0oGWx5M87ACjCdULKBI64JI2xZTVOPJg+nv00Niw+hWPh652mw9Z7icvdP5KB0G
	73H2/dGYZrmyjzw/Qcy2yRVq5gSY7IoJqAuXG6jA6QlyuAdiSIa/0ubfB6kPQC9jx8wdEB
	Ceu91KkFnAL5Hp47kQPSTKIz11jG7bg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Fri, 2 Oct 2026 06:14:14 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
Message-ID: <ar8hhrjQQw_yfghj@iki.fi>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org>
 <arw9CHc4mIOm5C6Q@kernel.org>
 <20260930033300.30295-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930033300.30295-1-xuyuqiabc@gmail.com>

On Wed, Sep 30, 2026 at 11:33:00AM +0800, Yuqi Xu wrote:
> On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
> > No need to resend a new version but I'd need a link to the *report* to
> > retain reported-by tag here.
> 
> https://bugtracker.nebusec.ai/f/675
> 
> This is the report. The page requires a sign-in or registration
> before it opens.

For me this is good enough given that there is nothing unclear in the
bug fix itself.

Thanks.

> 
> Thanks,
> Yuqi Xu

Br, Jarkko
