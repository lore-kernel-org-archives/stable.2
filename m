Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE61B4156;
	Thu, 18 Jun 2026 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791656; cv=none; b=Ut9Ci0m56cdTvmaJTl/bos82gjfYZNmz3FmEu9rFU7pX7Hg9pxQo0YS5IPEsHVY/OEvJXyZIgS8UuWQLvC5cy36K9M1QMLhXwJI2Y9kfKxyo8zM2DSKg+mAX6eKcFcny/4v+XzCKd+ugLgc/5OC989zLU+bsQekGqKtNY+JMlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791656; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRawJlJFXwt1grWdTce9+51HRNf/7dKZoTLPk3b7SFc0Ncd7rN6OAfUDuJqK1fS4YLTJ2JiPRh22CAhaOkmN8fT5ukVciHlYESH3duX137laDrmgcsKMjXTt4jmrdhJ+h22rRv+BHHf8VzqgWt1eAOJOuQOIxuw6zObH+n3Mk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 557B668BEB; Thu, 18 Jun 2026 16:07:31 +0200 (CEST)
Date: Thu, 18 Jun 2026 16:07:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Connor Williamson <connordw@amazon.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	yukuai3@huawei.com, hch@lst.de, jack@suse.cz,
	nh-open-source@amazon.com
Subject: Re: [PATCH] block: remove redundant GD_NEED_PART_SCAN in
 add_disk_final()
Message-ID: <20260618140731.GA3395@lst.de>
References: <20260615130715.53693-1-connordw@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615130715.53693-1-connordw@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

