Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8435DA41;
	Mon, 17 Aug 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950021; cv=none; b=jLG9OJDc3Gh3EXiwZHhmUZsWrfBtsBZmPb4GajxdLiuFzCg/sgEe9obppqf5NFswCrAaIBRHHtOjfL3wwMsuDdGppwRNyYzyknwDX5/Dr6s5tnY5nrnpwqEkqQ0gvvH/V08Oyt82AE92wGIG5RCi5JANzq3GAqGzyjySuNUZHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950021; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seF89CS3fXYAxcVyIrrVAqAkdAKd9zffSYXgqQ9LoKr7632lBj1wBLiEdJY3GPK89EfRIjnrfCFWR1ifcE+goeiw4CWj+KdL8hQ+NIpUSj86mtjXrMt8AbN0o5ukxWDxiUdbu5+A/5BEcvVxC7Wqd6bya4JC9KDn5ccJwl3rXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A18A368CFE; Mon, 17 Aug 2026 09:00:13 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:00:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tristan Madani <tristmd@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander <csander@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
Message-ID: <20260817070013.GE16255@lst.de>
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
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

