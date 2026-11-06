Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961576;
	b=0SzZ1qJ4QPJxp8nmUuqFNApnturBQjk9iE9C7TGfPgQ6HYFxAvIa+HaLFYknvlaCLzRv
	 lewyCSIdBhX/P7A0mMJcCwaaisl1Q8MAsJ3zuVXgeQFcY3A0uP7iNNngw/SpKMWQ13Yfk
	 ChY3rM1i+TUA+TpbY0CkwHChcZ/ITaSbqN2q8AGr1/oNQdKcFcQgzF8mntvAApE6pTvMz
	 g2RY2WiWvnxB26/BsnVN6gNYhJPxZ/YvzGilQBiDc5MiTJ33iy4rodyXdgZ99H1XfToJJ
	 tmX3HLkGcKTyLamy5u6Gphl/Zm0kG7a1HhUVo6PqVx1NgsvceIuzastKKnCYBdMtH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961576;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=gaoHfM3wTtwoxj8HG7vLz81hToomm6xkkEefXaJGFa0=;
	b=zyQnC/WknG0X7IMz8/i+uxsp/papHGVzvhe6DPJVdWytZ9cxChbKXCTlcPHAstTUROKw
	 c+3i9QeKamVfCAXfp357qGtzva6BhDRqhq+J5WKJQ1XQ2EtfuC9d+Zetq7N0BAn67QHf0
	 tK2O3XEdI4dlmNtEF89JvQxDGEcCovflv89Nybb40GExzhfd/6LUEIFtTEMq5zo4Yg8mv
	 /LWR2spNoQNbb/UMyFQT5Korpoj5wDUA+u4FdWLDiz1J1YMM48x/RkwFfgEk4TylTOM1i
	 w52B2WP8QVzrvXegvO/uOaOt3l2laCUFnz46m+LJwVwvZnvMFpI0J6eoLMSNw4c+qQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224A606A329;
	Fri,  6 Nov 2026 10:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A224A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DBD168BEB; Fri,  6 Nov 2026 11:39:32 +0100 (CET)
Date: Fri, 6 Nov 2026 11:39:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmet: zero out unused data of fixed-size log pages
Message-ID: <20261106103932.GA5633@lst.de>
References: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn> <20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn>
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
In-Reply-To: <20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Given none of these are in a fast path, should we simply zero the
entire transfer length first?

Also please cut down the commit messages a bit to be on-point.
