Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7E37757C;
	Tue,  4 Aug 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847001; cv=none; b=GdJhcAi2wa4vhBqllPBQct2wb9W+KHdqMGdM7iIK43ffEl/WAX8682RSY43Zg4sOi2VtQv2XJqhBt6cQJ1esuyUYefpstL4OS5RDxYOaeOHQ9nT3JqNcB5nzukNUO3bHKPZW0L/3ufn8+fl2iPgsKUZGY3Yt6uhVnl5gqaGMG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847001; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6uBBEilGKdw9b+P045oh7HNu+nmfz2WcYB6Ill1Xn0ft2G3yazok2eRtzh7G52jTNiLSS5HVFNhdCTo7iTknxFOa+TfEoru6rH55s4jCndcIDQYYj8aUd3sAaF/ZxuQFbi9M0xhQCTMf0PaHjQYDBmxSb3TrF/f4e2d/bjRspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 091266732A; Tue,  4 Aug 2026 14:36:28 +0200 (CEST)
Date: Tue, 4 Aug 2026 14:36:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: dlemoal@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] zloop: truncate finished zones to zone capacity
Message-ID: <20260804123627.GA6661@lst.de>
References: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org> <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

