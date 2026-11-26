Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682984;
	b=bwrPmeQVjsgSjlOJCMEZZ9UZgfMLlaij1STqFRmDw9/uI1eAnRQbUvSV10RoComd1foG
	 hkCrgqQg2ElSZTyWVKSkGa+0lJmYmAjui2iNaLFOOtyRcnaqaNKW3AuZkAyp1o/NwgguQ
	 FWkhFJPh1E4wUKq5x8MU2W4kyZCMI8Pszlwk4uGPI2rCMbN4/HcdW9t/A/NEa2+SRG7e2
	 mMdX7TiIHofhfubu2mkXrINi42g/Rg9oitjY9PBSkYcuWz8vWC6EmbduAxn7vzEzKTChS
	 fa70GM2/3ZTudrTKBmoPGDOMYf/wViqiOlnPLEW+cQLRBTd91t2Bp2OT+Zf/1Kw9TAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682984;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=N3Y48PDt/S2NTmnraWPbJvR68Y4n4vtu/MCvSlr+RjUtAz+8MM1j2Aop07JVycwd4D4i
	 M9bs6/tFXsBS/967HqxvDSErr3g63/j3fUXOqbNF8qdJflqJqOiuEUBsuKcL8HwX2LjLI
	 +8uPe4+ycD9T5s1ZVwE8249HIa5utRwjCPQiOVYbi2b52aIXLSWQvV3Bg0MW8nnrXvQ92
	 +DopFTt2KQAenzE7qM0V5pQnZjKm8JGOvfzxNGKnqnNWvWwO8WWH/XOWvw9CWsVZKDpP/
	 3aV6255gwx2nKMSJpz2g/UEb540H2CxCEOB3bBAfbg4oP8vhr9mjaDzz1mqvxg1f/lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8D606A31E;
	Thu, 26 Nov 2026 08:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F8D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6F8668B05; Thu, 26 Nov 2026 09:49:40 +0100 (CET)
Date: Thu, 26 Nov 2026 09:49:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>, co+018500376d4b835e@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: reserve connect header digest and align PDUs
Message-ID: <20261126084940.GB7617@lst.de>
References: <20261125160418.1518007-3-bestswngs@gmail.com>
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
In-Reply-To: <20261125160418.1518007-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

