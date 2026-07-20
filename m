Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4B41735B;
	Mon, 20 Jul 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559175; cv=none; b=emzY1dM8fJEWOvQ5GlZhtFFkyff+x0O++M3QRCaHqrT/FlZsRoeQHN9SNrXTtBxrwF3SKM1KPpT/y3H+jtjVfLwNoBAyyb0yp22nOWJa+Pork8xwAgsTfYX3g8dMB9NSTtfj8OEjnos0EqHrgj55wkQP414GFeXrzqOiq1e6e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559175; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q75FPg5Z80Szf00IUwJZ9PrsZzG9lGYRlL72W85nNPuKLq0sNyVt02u01zyedjQd000yZaw3tFVof4o2IEsckwdMztHgd/Xqi1hUHAo1TY5Wa7XBvXjUOrjUhPGrItXNU9OrLyxnUtYKOvZxQ84NdG3K7hnPhIiJPPS6A8yMWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4B7468C4E; Mon, 20 Jul 2026 16:52:49 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:52:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] nvme-pci: disable controller on admin queue IRQ setup
 failure
Message-ID: <20260720145249.GA17728@lst.de>
References: <20260715074459.50760-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715074459.50760-1-mhun512@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

