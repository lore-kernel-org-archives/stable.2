Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B65382397;
	Mon, 13 Jul 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925050; cv=none; b=Eo3BcMXtOaESUind6ueh8TlNeoUNVsSI35Xk8alcdpZzMSzsnVkL5kMSxW5oI3gevu1/WXX5DNIQ6RFMP7hgJr8fYHv0wek7ihBMfuIqu/5/zsg33UE9f45Ib0iXrRLbHhBYX7zOtKaZOmU4gTwMfKcb4gFDfh+0+mZxQlMcwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925050; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnVJGQWKKUiIJc+RPEtteq4T6vGbUU4NnqzPlDbmkSwXNZSDr/oAIc2MeW5u+LyPFSW2BRlZCneUC+o/TmS6yLfGHsSkCpYPCzn5wHermQTj1Bn0mASrvyGDccickAWH+ehFDnB6Xo8mpkxe8U1MsPOl/oXKsqvI6Dpfx3LkGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A47E68BEB; Mon, 13 Jul 2026 08:44:06 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:44:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: bound SGL data length before allocating
 command buffers
Message-ID: <20260713064405.GE29416@lst.de>
References: <20260709132533.44195-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709132533.44195-1-security@auditcode.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
