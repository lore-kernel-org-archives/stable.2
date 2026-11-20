Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196634;
	b=UW8U+aL3G7P4eBbGrXtA1Yg2L3vfeVUc1TLLUPYdYmO8JaOn2YGUdhVXOFlb/lNqxVz2
	 Fm5GPV9LcdbWQFKOb3tPvGW+FIHUWhiAI+yRUbrFee/JQKxJukxqNQCYgpnF5ATHAtFmV
	 24uI7w5KPnpN5Anjv0pNwH2sdGaNJwDWMWLZvmuGCtVJhQ9m38xAlPl/HzmLsYtONrfkg
	 bf8K0Op4QVjwCCOvR6DmwN0BvGakluuNoTEpuV4f9FUyoTsOdkPiPK1oonKvs5SXeuuBr
	 RFD38vWxdjy7Uskcu06es+un6lbgX33K/e7aa/KYZzzruhDBrFo6qdh2EMlKz9APDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196634;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=qOnt9ClbqLNPJTnzjMhCommftoZFNIRnVghtzBdBnPFm0QXU0jmXyRhnEZadLdfso6S+
	 7nU2Ykk/jovMna20q73n5LX0zZIpGR2R0td656p1LcQti1wD0mcQ0x4Enqlcl0a0/EPDu
	 3H6cz+FvoPLckVACuT6GOK6H5W+EpR3WxeavBJ2LJ+YrdRmAZt6cooQv90arbctFtz8pY
	 0D9w6Gcq7NA+xNRaMl8xkgmo8elSq9gdtzJc/yGcjjqy3hm+cuHsC5OXSiLWZl+d5oLSB
	 tKYwiHj+muUBJy/JHMZu/ePc+x48rjN5qgCOAJcavKg4Cs4r3Xn9CMaQSZejeS3rFKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941560A380B;
	Fri, 20 Nov 2026 17:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B941560A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 750AC6732A; Fri, 20 Nov 2026 18:43:49 +0100 (CET)
Date: Fri, 20 Nov 2026 18:43:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com
Subject: Re: [PATCH] nvme-fc: initialize I/O queues added during reconnect
Message-ID: <20261120174349.GB1408@lst.de>
References: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
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
In-Reply-To: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

