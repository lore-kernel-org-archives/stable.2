Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF14483A1;
	Tue, 22 Sep 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083763; cv=none; b=H75p5zMVVaASNXQ8n4i7MkQboIVjaagXCCsAW95oyphBdTqhVs127JF60CKMNcOpOAiIH2qkUGArnWQq4DDk8z/LelcizXSpzIb7Z8Caig1usJBWcCnR+6hGMYW+hidOyBzoRdPte89tdKlAF5jLTUPbDnhRSQHYIz89P2yTfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083763; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh0d8DGcRZJq5xZSdBf2pR0on57FmR69qm1UEmfTtC4bjfYmKdIFeIe9oDY0GQ89CnaaYTrjumqzGW4hlsyeuvVTWuwwfgMVX3iUzMWD3dWj4ntgKUhLx5rioJTyg6SSSshLwXB+tCENmhJAZp1wlzsHLbK3NI4uv6NeHRlRAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7F7468BFE; Tue, 22 Sep 2026 15:29:18 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:29:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260922132918.GB31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-3-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921090559.41364-3-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

