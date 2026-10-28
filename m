Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199261;
	b=dDAWNlNn+vZma0aJTzfv7azw5d/gBXuv3wluDPYOsxqvQkt0D13JExbxPLwyFMSBAvhh
	 ZXLLU52njOThKMJXHSUFBSelKxOjezNlW3v8JMq2GS8fdDahMB+2pgq2a3z7fdbb7OBa4
	 ribpzmVsgNcNyy8h/HN2Nnd0YUkQ52qQD8F9W1pKhUnANiyPKiDYHpgqiTFZrjPSGNQfW
	 COFMGfh8fvVxpsUV2ijjZD3kfOuqUAytbZVIO7r30o1hZlENGKWGTerFm5YBOqtLCazwK
	 BaJQdFS/hMRxP6+u/hFVxcRL/6ydHPIJ8gp720UNM8/HimSP7OVUCiTMsRMUuNzP6pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199261;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=sH/DRjRZZfFLDTthMF5TEdPD5zdYpn596SF0g6cKDYz5ZezFYvqI/HS4SsUWVXgiSDi6
	 2jdb9YBTkkuer2CFk4kzNPcbaAa8oTC9GB5XNpfd/jRU/rENLSfAPW+AMClZdBpG8rvwc
	 yeJc+ZBgJFvQwILEiG9OqVz6Ac+NgRViJVKiUIF+YrFDtNn9dhShxaA7rh6rYMMOCszf3
	 aQ5CoRGowyCuJjcMzaQjfO8PgvyJCQyZPamuoH0G7sYuvcQ8G/BZ2e/iZ5TpB231FluER
	 l+HSDEVVYvADf1dFM1I2cD3igbBuOIodVAs26kjrtKzEJ8AUKDEfH1M1Zv8Xj6wRcrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B013606A31A;
	Wed, 28 Oct 2026 14:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B013606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 321EC68D16; Wed, 28 Oct 2026 15:54:11 +0100 (CET)
Date: Wed, 28 Oct 2026 15:54:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Justin Tee <justintee8345@gmail.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	James Smart <jsmart833426@gmail.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] nvmet-fc: only send read data for successful
 commands
Message-ID: <20261028145409.GA14942@lst.de>
References: <20261022132934.3592924-1-parri.andrea@gmail.com> <20261022132934.3592924-2-parri.andrea@gmail.com>
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
In-Reply-To: <20261022132934.3592924-2-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

