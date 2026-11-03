Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683945;
	b=tz39A+zFVsHTgAcoNYv+VAA6QTAOx8tjboSlladgSrvmpsneiYzm4TKjs8a4EJImDh5b
	 8FA17JWdqoNcF+nTLfS6Kgv18p7nmPM4NJul5zhnynYkyu0oG0ny19KzK049bpSjs229e
	 lv8pBqvgzhtBOsYAZb05fwyxFwgtsEg9//1Xs+WDv2f4TCoHjTdcA8wxPCjgWOZzl7cPz
	 NlmJ4CAqUwCeRHKYmzf6NPOi6Fa6ZJqWAIl71ywAm/jENWsMXta2VGEU7K0nnlS4pvY6C
	 H8+T+BcGf+ekYBXJ87mS31wFjdeM6ceK9ew5eMWIbUM1Du7DYhKq/G2ex4pxE8hB2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683945;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=mAh7L5B9mx6KtLyLl4KFGoNaSsAdv7Y6UcP3jAjFoiB2f3Gw3pJXLPuBje50JgCucN0n
	 65Z0LPGsXInDEAFc1yUE5+d24yLFl8m1Twn7w7xVNVucDMCTnA7D709ruTGrYcyJe4oly
	 wmCboOhCNg90uPO3dvqjx3hTOFchE25+c/QQK1OlC3vQg37DIv5Ir65F/DxFbcfVBvJES
	 M6+kROzVUGewjPlmgsw1MjrZlFfbF7C9c9ZSEOeDZvo2vyZFlJyDGlVhyFvZFMwXgF9dB
	 FBWZSCOYK9kJHoA582EjeALXcCPvUbf4ohL1ZLOBRL8nYQ/+X1uZ5k65efyJoI/zNrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E49606A329;
	Tue,  3 Nov 2026 05:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C67A68AFE; Tue,  3 Nov 2026 06:32:21 +0100 (CET)
Date: Tue, 3 Nov 2026 06:32:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
Message-ID: <20261103053220.GA1369@lst.de>
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

