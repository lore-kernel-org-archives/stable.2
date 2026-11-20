Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197015;
	b=RTCHXew0hIkLzIhSOFuDOnioDwjDFCw7nEjg/twqnK+uCi8aUfuoiS2O5kWBDr6XXfMn
	 aTjr4QSGq7hfii0WNw6lsJ35aastO1FfS3wbKFn7s599D+Mvbc0JyKViZCVonDxAGKQA5
	 Wvp8OdHXpSfPcQ5YmSbZ2s+K0fvYh5dvwhTDJtr0d+yywpqMPKkQUcdQQPHN1aEShqZFC
	 7ySvjypnSpqXFiwW+uezu646r+oiTu655m75IXgjdmlo8jvJVxvoDcYcdhAk2aG7pO6YE
	 SSIqwTBUXStsFkZJtA5sy8qto4ri337hIhOzweBfb7YZycImJXnP0hyWo7Ier7EilAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197015;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=aNyF2q9Wc/8WQ4DNL69oak0j8y5HHhZmxtuskZCcTKkAPP9mxIopTnpLjKpNsQbl3w6a
	 8IwHKFivvY6+nIPKDmuc3pKwuJXYN3Ct1sKVrMUUj9CI5qgIDsp0zHJYR2ixSMocrYSQX
	 lrLIWqD3Mp3ENAjGEW44B/th2dgSznqXmr6BYr1tQs9mV4N6mTlta9+Ab2kOMVh/g31NI
	 bMRzqOJq5qaIPjXzAxOGEdMUnumFOj4HRb9RMbW6hLEpiTn+askG50Bd/CF4wyYQUCEcI
	 Azml3h9FRzIRcDtNyZpdZEmM4ENF+OxhCenUf4EMBCe+bnnyiCpHF5sS8aopFAF2ZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B514606A33B;
	Fri, 20 Nov 2026 17:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B514606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3110068AFE; Fri, 20 Nov 2026 18:50:10 +0100 (CET)
Date: Fri, 20 Nov 2026 18:50:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme: map passthrough data when the length is
 nonzero
Message-ID: <20261120175009.GB1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
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
In-Reply-To: <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

