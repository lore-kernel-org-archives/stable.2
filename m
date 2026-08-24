Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8846378D98;
	Mon, 24 Aug 2026 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547943; cv=none; b=lR0oUG0lKAgdbjdlUXSKPvlEI4wrPaRVC60N2YWu+cVPbNaDfJixKaZUn+l+Ow3RdgqOEVGQ2Su6Zt1bdQFGVUOLm63X9/669RwsKQKfxk5NRNMrki89zbYUpTtDuFslwQpIU1Lmr6xoAaT0rxmYwXDPwgRpNp+3PREWp52lG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547943; c=relaxed/simple;
	bh=V80Uc8n1PO/ju4JB7OQwFSSeT4GJePKFqw+nngzT99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBoFKxNah4zmGNbgVjWbVtgVHW4b75dKshvDx1Ge2txJaOTz/GB9wC8DZEqbukTikjP3sXEkeF+GDZtL1RFEQYj2Cz/30RhEttQHO6em/98e8YwJBKWr7FwranKJKQIVioHPK7GkO2mymEizr4ja5n7yVL3HU7ZhBtb/EfBorRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yj7nsiZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yj7nsiZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC14E1F000E9;
	Mon, 24 Aug 2026 05:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787547941;
	bh=vzADkwVeNrRDejbuF+iKh8EcjjRx8SxMZb8ZTjAtSPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yj7nsiZ0CV6L2mPOtn4D4QrWIOcSm4Gi6J1/VmtfcpJgLBEWuM/+DI6BQiXHToZzv
	 tJu2Q3Il7U/iqdUfRawfAFNZaKnS7T7j42D0QyHbNJHhPeCFe4dgFlfvDpD1Hyl0ep
	 pNQOqqY5SIgMkB1u4VeR2U8D6cB6zeWYjrXsTeeU=
Date: Mon, 24 Aug 2026 07:05:37 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] misc: mei: fix race condition between client teardown
 and read completion
Message-ID: <2026082413-heritage-creamlike-4cee@gregkh>
References: <C3Rme4R7BxcZVE877gMzMhltbPTsvsMjN39D1qWG_5JYO1-l0OphcpyU-XbPGQTMlPuZDV5Dzgn09MOdFBChmprsrpVlp27eAxmZpzV9Ays=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3Rme4R7BxcZVE877gMzMhltbPTsvsMjN39D1qWG_5JYO1-l0OphcpyU-XbPGQTMlPuZDV5Dzgn09MOdFBChmprsrpVlp27eAxmZpzV9Ays=@proton.me>

On Mon, Aug 24, 2026 at 02:32:20AM +0000, nirbhayykumarr@proton.me wrote:
> Helped-by: Willy Tarreau <w@1wt.eu>
> Helped-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

While kind, these are not real tags.  See the submitting-patches.rst
file in the kerneln tree for how to do this properly.

Also, you forgot the Assisted-by: tag, right?

thanks,

greg k-h
