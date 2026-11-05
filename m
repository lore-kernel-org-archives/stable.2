Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864801;
	b=bVIcAsLVPnyNu6Du0KyRElayNXyqn43egJbWcoE2qPWqOfhey5CT7UysVqa5K1rm9xRs
	 pD9ptj1Kyn1eXf/s4jUV6gZZiO8dHeoR7uOO2xlx4C/PMuxJ9DflaSzp1LmXv2OsuVL8r
	 XQMchKZJv0ZqW2NbMAqEHceBaaMsgqP5VuZOL6miKmrJ6VxMTCTi+HmrbpbJ4/81vT2hZ
	 UErIsg4D6HD54k02r6BGIDuaJRK2nzLvpCBvaVKBOvL5G+ZCxiESGl3jE5Nav5iAiBDMk
	 KKTOEyyFMULu1jvcUcN1CIAVtWHUUtiRD/otP3GvIqJ8ja8tDv4tq9d5TxLhSxpttmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864801;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=araKTA5VpvYK+bG1ImmRrlat9c910N/JA9xPYF6yJPu5Hux+WOxVLyyDY8BP+uDsKRjB
	 45rktznbSAdn9xGwaS5zNj6I06Wo0cDJK8Ukv+riBMCi0MpgvxoHDl3IyBCt4md4N8+YW
	 9R8abvxoglJZczzttPzYyZwzSK42dEPDv72ThOErrG6AbN+BkmUiymb+2e2GENRGdurkO
	 QDQxC2HLr9wNTYZf5kEu0YwwwanUeCXDZYO0OZSgaTkMrXGWoKmHltWZp45FEBDOa9f2z
	 J1sJwnib15wPlOLjKYes5ZYGFc4N9/bsHYA3urTrCjcek67Iu9b2Fd1LKlVFSPP8nRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F59606A31B;
	Thu,  5 Nov 2026 07:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F59606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 988D168B05; Thu,  5 Nov 2026 08:46:36 +0100 (CET)
Date: Thu, 5 Nov 2026 08:46:36 +0100
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
Subject: Re: [PATCH v2 2/2] nvme: wait for SRCU readers before splicing the
 namespace list
Message-ID: <20261105074636.GC17781@lst.de>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-2-feb64ecb96ca@gmail.com>
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
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-2-feb64ecb96ca@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

