Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776772;
	b=fYIvXCVSpGMCRjl85vNpI0b0Qq4Ts6bwRvp1bAlF2fJSlUj2LL+B13GQ4Rmn7I6oua/D
	 ZaEmAQeSEY7V9gW2nw78wqdehJqcqgQSzqF0jMXsLun7AG+dwFWHJWI6vxRklMUKvwf3w
	 HA4bCDycYT527HsqgsWgy73cs5/GDsRlhHL6F3kb4IM0j2WVlVcb1jmvIWpO6MCvHhtbc
	 2izk69+RFlYhCMD5yhU8IOTw4dhbE5anBh32UH/GFHP6uDBNkDIyoo3K/IvuYSnHYORDk
	 HRd660iJAN/OOmCtJv4S6ic8mtdGdE38lTLCAioUZEsyhC9B2Ng4NPWDIVqAJ5DDc7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776772;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=aMCmPXQemvcodjrho5XGhFir3RF27/7DGeRxdTIbEsY=;
	b=oR0/awFXb0oURji7NbzmcyzLWMp7bwwKqhB/eXZSBY5J9Z0xu5V+uFDHMDA+GDU5yOHq
	 WcJkA+KIcUhUrtc6RA/Qm2a7VogzTEHpIg9GIcvQUd6q6wgdA0YOG4YJAxbQAeDmBPnWB
	 Vm5UzMpAIdbUYADvwXakRwe4vDxByd3gH8jB//B8SRStL4aEjUrAnGakwQ/x8h/5Qd2Mp
	 P6FCfUUfL0md4QqUy2B6QdZ26PIgUjD5GX5kG6FNMnpWxpdoQU93wvSR4PRR7gLk3bzOh
	 G6jorvMK9szybi7r1nZGOwKCJLDOFhGM8T/RS65zKToLO7DRZvIt+h4lp29IqmcVHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF9606A31B;
	Wed,  4 Nov 2026 07:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0343168C4E; Wed,  4 Nov 2026 08:19:27 +0100 (CET)
Date: Wed, 4 Nov 2026 08:19:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: mt4022@columbia.edu
Cc: Jens Axboe <axboe@kernel.dk>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: take quiesce_lock when removing a queue from
 the tag set
Message-ID: <20261104071926.GA29136@lst.de>
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
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
In-Reply-To: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good, but the note from Mohamed should be taken into account.

Or even better add a guarded_by so that clang catches this (requires
actualy compile testing with clang, though).

