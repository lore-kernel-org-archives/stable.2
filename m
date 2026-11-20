Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196699;
	b=I9JSERrSuARVOy8e/XX09XbwXcr+4XfL5RhMTuWkj9uqBMmBOfOuHrk7eSk09/EkTJQx
	 PpPU72CLFT7Pl0C4p/voG8ZhPRkoDJfSP6RbcdsFz/Lqm4cdgv/a18uYXMO+if/sBnFS1
	 1pO7WJf0LejJna4Q23YqQjpUNiNEaZy4VXgJLB3LzYWHcAVCAW79mgfWYjrCr4syNSOja
	 UBvgyRolsq+Ol886FQDZxrOlAYhc1oBVQ3P598B+Rth5hhmeF9DGZEcwglp93+FQn89KR
	 2W4z++XijfdJ0K/PfMoE55TpRvIHqXcLVPxuqRhfApchuwOMGijky5fhPM3wmMlr+TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196699;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=zuNJ/xWjJVU28dp2tLOHK9BNXVSa5ubb+Huela4KopW0C/cEet/xHKJBncFuteTXko8D
	 BpmJDbZpsvd64r3d1Nj/seWbP5iURPMRsEJvjccbZnzWGlkhHwX7ro0pVK33/oG5EzvtZ
	 ho6qSpqb1ixJYvW2SRB2zdDTIG6Zk0AeFctFQKeNchcMqfDM3Bkv37LC9mtJgDFPBelRR
	 7IoXtLgQfgCMdwrImJ/WiRDxq8E7Ha/zOvwi3WqYGoO76oO0zAUicl4flbU4ZP8mpYOLv
	 BXy/agzN/fW7HJkv49yNFXcLAa4Utk3gu+GSCs4WDgQxEuhrJdN9FJnm3+Y5vOrN51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EB606A337;
	Fri, 20 Nov 2026 17:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B23EB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76A9A6732A; Fri, 20 Nov 2026 18:44:53 +0100 (CET)
Date: Fri, 20 Nov 2026 18:44:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix the CSTS state iteration in debugfs
Message-ID: <20261120174453.GC1408@lst.de>
References: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
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
In-Reply-To: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

