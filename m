Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0573DB62B;
	Mon, 21 Sep 2026 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979264; cv=none; b=AkjxkaIpPgpKM4vkMu+ZlLdicEORBz7Y6tPuwyM0kPWS71PzacXMxbJBIt58a+POvgrwKf4u+UBoNDu0w8u2MeP1RFA9Bh6mWmDNipaXl/H+pSgIHxZEwFxc3Ae8MzdDtZccyeO/nlu/AUAxXTDGVfkqaSVpxrUEiKFXZRN7Qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979264; c=relaxed/simple;
	bh=Ka8UYFubLO+5sv72IXG5mLm8Ypn9O0Je7nBCz/yK93I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+Mq6Cc3YRvdAxCezxslrYFB8gGAK2bH9by3iYPGO4YNjHBnNsbbEvtcpmpf742Kw/ZqqXSXCA7/7oOGwa3NbnIQIrx11KTYML69MeEHxG4mRaS6GM2WRKem5y+33MLcvzhOeaJP9qMKNn3HKvCcuI1yGiZjTxr+W33bC2c5A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6308568B05; Mon, 21 Sep 2026 10:27:37 +0200 (CEST)
Date: Mon, 21 Sep 2026 10:27:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260921082736.GA20060@lst.de>
References: <20260902103202.GB8095@lst.de> <20260910045400.1201582-1-runyu.xiao@seu.edu.cn> <20260910045400.1201582-3-runyu.xiao@seu.edu.cn> <20260910052604.GC27133@lst.de> <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 21, 2026 at 04:17:45PM +0800, Runyu Xiao wrote:
> I will send v4 in this thread.

Please always send new version in separate threads.

