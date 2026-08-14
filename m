Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D4355F4E;
	Fri, 14 Aug 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729668; cv=none; b=oqr7xB2w/Q0xsUzmPwkldOjhqozQYECeqcCD1XZpVAHfNchl5KDclDc1Udvh8RRuv3OfcO07HvdCvf/05YtJIo0mOYe8hlxGol5APAoxEhJgvX3yyUJqODARUmsy54SUY60pQtnDWHpySbOQXDChtxvr26l9z9U2226yye2sXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729668; c=relaxed/simple;
	bh=Ti+67Hxiw77h9Es+P+8Om0zeKJisy5kVHWR1LACZGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sO47VChZbfwGfb5q2RUuIsHmPUFhAF+Ophej/bjMqBdKjeux+bQdyrEYS5u7nAirENX8ZSdcqMHfbGvlgjISbanKgLRR/s+nZtCXmvzgG6ZefV83FF9A74WAnkgRsVwzzmed0GIf/XqAQI20s/nMTJ4tWDB3O9mhCR4bGc7WLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nixPe1BN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nixPe1BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB1E1F000E9;
	Fri, 14 Aug 2026 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729666;
	bh=xLPe8VRG6qzAPIS5aCOep25c4TtO0QbreSEawFo9jAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nixPe1BNdFMPGGMu9KGSC9EyXD80VzkrMsO3KCL82pPmkWrFNWtLFm4MGp+lmuAdf
	 mYU+czWTfSQ6/6De2FUTW6hcMHVLT1bvmFKLOzDV4B2QkoprVj8NTeFC97ITNzKOVS
	 hOuWW+lZNcES9LUc8SMTdF5t2bwDoe47asd5VEhT79P8IOX3v5S6QG8J62V09CPXsj
	 v1CBeTQNw6i52ueAfM8hQWaYNassna7RsA8xI9e841LjqHFcgLLEOaFVcNRUetAnQJ
	 keaZhF32DhFQkPMFUSvm0pn1ZUZhPzT9EmG0OqZw+f3mkOPmjoKBFJc5qw/32G9qVh
	 oa9RxNYjUmSzw==
Date: Fri, 14 Aug 2026 18:47:41 +0100
From: Simon Horman <horms@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Shannon Nelson <sln@onemain.com>, Leon Romanovsky <leon@kernel.org>,
	Eric Joyner <eric.joyner@amd.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kees Cook <kees@kernel.org>, Mohammad Heib <mheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
Message-ID: <20260814174741.GT265046@horms.kernel.org>
References: <20260813083705.454897-1-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813083705.454897-1-anand.a.khoje@oracle.com>

On Thu, Aug 13, 2026 at 08:37:05AM +0000, Anand Khoje wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
> 
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> Cc: stable@vger.kernel.org
> ---
> v3:
>  Use dev_err() and return -ENXIO for a missing normal TX partner.
> 
> v2:
>  Correct the Fixes tag.

Reviewed-by: Simon Horman <horms@kernel.org>

