Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864788;
	b=y6SAAcQPJwAqg8sx1KM09UxuQKwkwABDQkHF0jmhp6dtXI0LOQITa7Julft+1CXKHhCU
	 kz6ILR9gySo5NW2S+YfLh3ILKt6OT6LyzC7Oy+HST552HvMeCsAE4n8aWp2wwHSuN0QpL
	 Tma/A1QHCH+9BWVgqaLyRGFh3lcWXI4vy9DttEDeyDeP05wBQ8ZfkP4XzxhOrMO6og5IK
	 fDT6qhSHW3P6m25/NASGeG5W+d9fxITUaEhwehUwJWr0ZxQfccoZ07cTgbzbnRvKIb7f+
	 3uDFuxWkVf9WL6IPJGx33c3fRqwnMkbpCUs8dcEFG1tIgpg+aFKo0MUMHovaNOm1JEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864788;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=mXJce5vEAzGUl2Ybd8o69nN9IdF7nrmIhQ9qLRJcNQBYyFgh3BSeoEkFG+vN1gbST6v8
	 DY7BedT0JfRPS84JYCDwCvNg74Hep/132GoU1JTT3BxNOS+W56NtkuShgp7aOHRHj6JB3
	 +VDZUv4AxLGaaeHZGXWYNBo1SD1cJ9VLvn1m9kv1u2v/gdnAQz6Ifjd3LVcmtOKiE1mAg
	 tR43wFye/7ydsZoN6iT4OUYblpbNfshjURcKRAqezeLNnhLVaBC+/0RnUPrXniRUeHJGu
	 KM9kSLKACZeaVrHFPry+nvpIHQKAzhwpacsgkU/mpmqqKpUD4Wzna9eSrGPlKOBN83w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50D606A338;
	Thu,  5 Nov 2026 07:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E50D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A08D568BEB; Thu,  5 Nov 2026 08:46:22 +0100 (CET)
Date: Thu, 5 Nov 2026 08:46:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <20261105074621.GB17781@lst.de>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
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
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

