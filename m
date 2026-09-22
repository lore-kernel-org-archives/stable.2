Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF353E304;
	Tue, 22 Sep 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083789; cv=none; b=XJUgy8aWdBTilBoqLGHMca0NW3lnFKcXHZJNpcga1WIwZbKB0q/nLIcGOGv6tTY3q8wIDHYSlsr1SdTJ8jZx2adJgZZLOkK4ImUMS2sJJvWufNHanQIzC3iQDiV/TJGa0k2LYJ/9Wf7prJ034EP1rdmc0LpGCq5IrJjgLEAKak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083789; c=relaxed/simple;
	bh=n6udlaVha/mEfMWD3+/SNvpOjIVH8c/UGyrEsbyGN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRcLmbj7Ex+0O/q2t5av5gMsY2M7mwKj5M8vlVPVfqNaM9jnZOZKYYPWUw+oNLe4QJD3MfCaRv9PKqsYvoFN5F4OdETwzVcnKluEe6JoWIr//YYrTofPcWQ/UkUVp6+z7IhfGcuXfgr65JJeFK0Gj+ot67bhC80RSQvx3JWC4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 717B468BFE; Tue, 22 Sep 2026 15:29:44 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:29:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 3/3] nvmet: avoid recursive configfs open for
 passthru
Message-ID: <20260922132944.GC31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-4-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921090559.41364-4-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Didn't you also have patches for drivers/target/ that should use
the new helper?
