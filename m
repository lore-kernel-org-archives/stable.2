Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961616;
	b=MYZ4bprpJ1109QK56UOlfgvyic2i8uEzRiq3I7/JsM8eZmMJQTis8elSyMcBT9dfz1J9
	 oehbuLsI26pQOlER9Yo3lUk3IX0lwluwMLNygp9qMBCxEkco/1CMExAP10NtCXRXC276F
	 2zv56Ez7EsgEZ6qHOjMQKtQWTsbmWkeXHu1oEyHZMTlaksmr6zuMxxmWXqR2cxBDlCUQ7
	 NfXEByvDZw/Q9r30BqwKzh0367iraz4PMKm02Fy70jOFnkanTDtNJaRcNHqWIgR74Uv9s
	 HO7Bcb8o7iZum4KigZ5QSHZT3QpzyiG28ADJsbAyR/0KwfqBrixZasb3jyBan6H4KXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961616;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=5vpnBLuOZjS78HnWofolOcgvPkKmQfgic/XSefos49k=;
	b=B4I4Ap9ki2ZFSfd4RES77AfNmhwNjtTkr69XTcnIF3brqX5AFw6mlIxCLDna0eit/P8J
	 fWnILrR1IHDOk/bfT4lQa2uxSv2kI6I9VJnVH0UO+Jph0hgsNON1mDRBgL/7WCrCgw/wu
	 RDuFtb/0BJUGARzbtLHZKy9cfQ6++gvD8erljxjUI7QbUqv6Z0pPAxJ7iZb7ee+R2yfHW
	 c2CTOHJkvx8h5+0XbBt6vZSW4wVlW4/+Z4KgPgQnCI2OauejEVr17dMhQdX/2lbvmFsXq
	 8OhtvM9qBuFrfcGOJLbUVuJj3+A6U0+iITvzwwLOX9w93OVgjg1OCSHdQXsod6apWdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A32606A326;
	Fri,  6 Nov 2026 10:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A32606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4E8868BEB; Fri,  6 Nov 2026 11:40:12 +0100 (CET)
Date: Fri, 6 Nov 2026 11:40:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet: zns: return the namespace lookup error for
 Identify
Message-ID: <20261106104012.GB5633@lst.de>
References: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn> <20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn>
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
In-Reply-To: <20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

The fix looks good, but please write to the point commit logs instead
of detective novels.
