Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DBE3FA5E7;
	Wed, 19 Aug 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126694; cv=none; b=Ly9Uvwn1B5Hy9vAkbs6ldgZxKhGmWCgCUlwaeefLxMztTyrCyj2t1NLjTdUdWp0ifxGWGDQEpoguVnVwz39ByMqKfLp+iWMSHqOfSnb1nCVzSM1FT8+QkphRh3rp/59x7VzccikjwBom7VeTNedTqKOoRRY0oxDHodl+Fe7xX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126694; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEMaYM+vrZ6UZMmhub47kl5ZhyorTbE2fVZEmY/AG3e1TR2tIEMJtjilemSt2axmmwvI5nN0yehr6fNsI/y2M2PbOIag7KA4m7cCw4n3cia4mAvGbsgRr7Dv8crLxKuZ9kGdZDOwd+WAswAZpJIkVtdufEzMIXgOPwAyfRa3Bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3369268C7B; Wed, 19 Aug 2026 10:04:48 +0200 (CEST)
Date: Wed, 19 Aug 2026 10:04:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
Message-ID: <20260819080448.GA4797@lst.de>
References: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

