Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6F17BB21;
	Tue, 25 Aug 2026 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619245; cv=none; b=GfDJjglTkUWy4NFK7114jcCgQD80KaA7rHtvaMcTTtrWzIR4WseHhYt3pU8Jdy6mIrrj2+OticaQPQdB2DOqD3ggb6t0OIkIC7TOCOvfqCoYy25HhWwrhXYks3yzkbvdIxq7H87KFVEB3upSkMwzJpIvCd2i+oAA98bOHBlRHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619245; c=relaxed/simple;
	bh=CID/2xA0nAj+58hlpKv1Y4aOlMXw+yM8eTTXlJcqaUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+0w68J3juZVdoc9eGIOQSQwfixOi48zGIXYGX2eXNVjPTvj1kyZAnx7+wMSS8VIyoJYz9aPD/W/Jhp9jSuOE+hm5Kaymwk+Rix02gXjLfT7N2jmEvFlK0wsp9vYoh+HDuqkhy3b0157zb1K6sxwgvIkkud8rsZuyMhxtD4d1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1y8xfgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1y8xfgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9711F000E9;
	Tue, 25 Aug 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619243;
	bh=DoRjtfqDYasI1Rj/OxHe/CkU7sDiOoID0tyV4HOchxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1y8xfgqqk1mkjZ5HxVS4hMkg/mabEwXB5KEkYmrryvmLpbQhwByDZ0/y6wmoQIjj
	 lz70aMgmr/Xt/9WbwPNqw0tOeSS+TookcaJn+dLxG9Fa10IWoReNll3jfZAlz5C3ez
	 K+SczZV3a4kHJsP0BVIijg2mPAt8qgOxfHZ0AHBxMsE1reFJa3ZUuAZrYd8/dNN85s
	 gDPlfcGd845ymPvM5vMEKW7A+BoAl3jbgbjgVHgTTw9v9ZEgiQliep2Ppmu8S31AdJ
	 er7JaqOcjX/jtVFEqcuDepaW5vXPptnOPIzQibeKvykhjOPj0P5ZbDXOAg+VkROxfF
	 vFfxA4H3Tsz4Q==
Date: Mon, 24 Aug 2026 18:54:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander <csander@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
Message-ID: <aoznqfUpR3t-GpgE@kbusch-mbp>
References: <20260815001427.3148050-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815001427.3148050-1-tristmd@gmail.com>

On Sat, Aug 15, 2026 at 12:14:27AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> nvme_alloc_ns() error path at out_unlink_ns removes ns from the
> namespace head siblings list with list_del_rcu(&ns->siblings) but
> does not wait for SRCU readers before freeing the namespace struct.
> Multipath code iterates the head->list under srcu_read_lock() in
> nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
> reader can still hold a reference to ns when kfree(ns) runs.
> 
> The normal removal path in nvme_ns_remove() correctly calls
> synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
> in-progress readers. Add the same grace period in the error path.

Thanks, applied to nvme-7.3.
