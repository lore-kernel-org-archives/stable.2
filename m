Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783019;
	b=vZGcasP7FVpAX6BQY0SMhEB4GCO6M30yyzd5SudmcMeCxjXadPHXHC7LIbbqcETlDRYw
	 KYSJbGZwPmM5tTxBMvhC7L65AHi+9+tCgOjHZREN9L8M8UG71By+hzTMo7vOhBrsXwPfr
	 3J+wRDyuW1DNqLxcCHSoCJ89Y+FaQBJtr6go2+o5Pz5+LLFG+QIDKCB8Cj+SxlLkgOhQd
	 sM+PUKLL9zGohIM+4UMTVUk7lRzxp/FUt5Lj6Ruq+Xkgq9NV3A50LgE22oot5osd3pWl8
	 3pR58yMNHKXBxSsWVn40CMmiamKaC9bI/cjRoKAWWoiWnFjl5Pbf92QvnhPFgkWsKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783019;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=DEBevRNOcYMuj6l5g+4qkrZH9IigR+qd570WgCXwR/A=;
	b=GkExejqvrW2yUHDWIsPpIniZQD4duURpbQ9USfFKpRN+fCuRNaJx1aG7qnmgX0+Qa1a/
	 xfRAHktxuCeurzRsRjX3RO14DfzpgAcgG/ZSukxqAcNaPvPoR0mRp4bw7cxHi3PR/P0E8
	 NAxGhSG6r44QN4YLBFKOHlnKNk0h1K+XEqAAg33DLeI/UPuQh5Eh+56+YvPC3RZUw+mLd
	 iGPdXzi7IndEgrhDKlnPfYZ2Xr88jb4BDX/EbAyNWfh6iBR0rLSQaVSx3lim1WoE1fBsT
	 eHnT32prweept+3xTRc4lfM00u3ccV2RxSdhVu3QxKUbxVqI+4HP55MPaXhmIvfXAjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C66606A328;
	Wed,  4 Nov 2026 09:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C66606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C611D68BEB; Wed,  4 Nov 2026 10:03:32 +0100 (CET)
Date: Wed, 4 Nov 2026 10:03:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA
 XG10d
Message-ID: <20261104090332.GB30750@lst.de>
References: <20261103224114.1657779-1-sashal@kernel.org>
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
In-Reply-To: <20261103224114.1657779-1-sashal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Meh, more broken devices.

Can you please provide a smaller, to the point humand written commit
log?

