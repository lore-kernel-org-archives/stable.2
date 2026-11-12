Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518290;
	b=2bbxydEFkCeFVkucnT+DbGxC/D6xaVPenTozVqoUlMAgxCPh5GH9RN2ELTGbJc5iEDrC
	 TKxPUFtErwki7XGMNDmMar09Bsb3H1PXnifKTz8B2QKw1H1U6a57ASJArBqR6xXwnpCbi
	 3PU3DaKaooQ2Y89uGneQlYrMawpMrtwrHXZsorQd68Wx81n/KNq8qPv20QI9QSjXM9cmV
	 URzpjwi6kOo1GCEhLFjvapdeVYa+3xshePbTkYmjCulZBUI0eSINgLGTlStQsOUWK9U6q
	 uvtx61hNE7nkgQh5ZVaL8ELzZH6S/Db2X0P84KOaokwnSlyMN5lxarzkOdVmyBwpM/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518290;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=NCRRIk6QFs7+stGd08Mge5VwEkBcIUHDmfHke5BR7zV/6riG59BaXZ3FsucAQB7soSjA
	 C94h09D5XkowXFXQaJsi6mdOWkyTDILTXLJTXfgj2CcJwcjSeeTnumaEvDq6T0cbO/+e/
	 SDgw3/AKiverYzvCR1S5d8A/rLnhq7mKZYmsjZHT0Ga0cAV1E0R9VK0Mf6byQvU4SA/2l
	 jPHXWwO2ew+GfuWQe1iYMNqZxw6hdpfcn1voU+CHctloyDsARc28hHi6qWPXoZRVAnj2j
	 sYoRNQsUHpJo4i8sO4mAZNs5OYuOykNiV/ahKXwCJA164Y+CAmDNrD8snoIQ6Eer6Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D88606A31C;
	Thu, 12 Nov 2026 21:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 860D768D0E; Thu, 12 Nov 2026 22:18:06 +0100 (CET)
Date: Thu, 12 Nov 2026 22:18:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hare@suse.de,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet-auth: store the DH-CHAP key offset instead
 of hardcoding it
Message-ID: <20261112211806.GC11315@lst.de>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn> <20261109225921056-4eg0BGEufMgtHypJbPmM@zte.com.cn>
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
In-Reply-To: <20261109225921056-4eg0BGEufMgtHypJbPmM@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

