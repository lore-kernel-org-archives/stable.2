Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517725;
	b=opzqGUx7dUkzNOwGr/sImLHYtLICqdqi2YhjDkwCWhNQ6sNqOk0gOybB8QMSuUmzlPAS
	 5najCkRIxKW26l3nHFmdASjA/awQ7JPw3tZOkRVT1gFa4vQ4Ef0Go7i+snkg2k06fbweq
	 wDm8lwnhRqyk9OCTye7aEqtfYcUL5NZv8Ig4KwIQyQXPAepzOc/Es9ZmAgvempXEzFpcI
	 gd4PaZ1ELbEW+oqVzDppDvELxiTPH+qzrXWY9Kac4YtknUAYp983Dh9NwtPzc38G4JxuA
	 pKW9WLOOtIDdoQTCwcz0WnWAeWX3W9+2e7Z9/0TlRUHDxsxJJeNipGnJGI4pAfGFu3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517725;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=W/XTz/USlWkAJ5Vlr1+ArNSzKLEydB4WJidPghIecDgTbFE7gSHNGWWxP7NugACrpXk9
	 g+RHAXoXx8wJnTKcd1qpnOw3Fq5fzJdr1P5KUXh3D9UJhiZt5rGyCNPhki9Cd0Ka/fFrg
	 UAAHsdwKSoNw0zuSmw0SXECTIvTIF02R7k7mYwobtU9m+e9WRQqiBf3W1fvZqL0baVOLL
	 fktJH6TU1lseWqESvF5MZ8KDEmH75X/CbRAX0cee7pQpqeoW2BCaAjKHrGw+Om6J8Fykq
	 zCKCqsEWztvRXwrjf+Q4QT/eOhDOobybTzNFKl8FqUI+OtdBkYxdwchaQqcrQ/DcXuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F30606A31C;
	Thu, 12 Nov 2026 21:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC2C16732A; Thu, 12 Nov 2026 22:08:41 +0100 (CET)
Date: Thu, 12 Nov 2026 22:08:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: mt4022@columbia.edu
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix deadlock on nvme_subsystems_lock in
 nvme_init_subsystem()
Message-ID: <20261112210841.GA11078@lst.de>
References: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
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
In-Reply-To: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

