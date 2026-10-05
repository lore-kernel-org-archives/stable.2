Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194F374A0E;
	Mon,  5 Oct 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189825; cv=none; b=Wi9b1KZt7VAufUe9uDkt78Gb2oybYKLByVs3BHweOM0t68DmokusIGKvm1rkY/NjvUruObzDr5dUeFWQDihKwP7BiNfOPxiyvzynQQFZ3kaRcX1LYCmrhQNwogfWnzpCSSsz16K0WQFQVp56IpCRX7MmU0Sigk4/VxecJUo9lnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189825; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaJJe7fRNf22CX4v7HhugcfLK162Qu/MuwfiCB7yMQ7RjnHy3uwnteSbH9gE0zpXuFv/pRsqoA/SOHngGoOSbWcIYwXy5l73QI6vV2qcgYjp8akmSBSj78+o/GfDqcqsfYnjLCISr7p2UxUV6X0LRKULM4RDw1JH1XQhB6//hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C6C268BFE; Mon,  5 Oct 2026 10:43:40 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:43:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: RCU-delay the freeing of struct fsverity_info
Message-ID: <20261005084340.GB8692@lst.de>
References: <20261001171349.81454-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001171349.81454-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
