Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518554;
	b=ns/lckd/rUziHM3uzEbVVHPosvIy+GpT84ogwONDiBlPBrSO1Z5VsNdr3yMPVN+2JeqN
	 /Lq0FP/Gdzpg82Ik1umUFf1onUdqeeR/xCkwsWomrb09uHdAmeMjTlYMlVXScH3/c9GPe
	 NNnNR1s6EntqXR9DPGE8X0TbvfCDnFsLf9yEZGMJxHxq3U79rPHm3i/SIyCK0vUAWmBv5
	 sdGGA/QOIBzH31jG6UHyHp7NeMIasBAg42mfIN7LoDFFXUe74pM6XuLRn87uRSSzInOnx
	 x4CHa+ep6VSdN0+pi1Cpf+o8aUpunlrT3yaMBPGvX4B5ADJErlbPACRIfrDp6bReavg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518554;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=XxYNPTGW2l+Ijo2ZCxIqtU+khXZHSndmmLntHZmGjAjJ8VGcvUiM0W7mBnCMPIjabjAY
	 Vvx8JYE0K5Lu1ISF3J2+gK/bW5snB90AG4eXzmjI7FQmiDZBrjGt/pY4T9MLoHBKc0V8W
	 AoaYz4b8Sa1IDUmfF25/JeGiwMXpMmbdChEcU+gh0lkmxjL7tKu5E2r4tdNmT28zlyvnE
	 NPAsxnsT0mA8ZQVxnpvsCBHeYXhtBYWfVURwT4xRi5zU3oaDnzCT5TlxWvAczZGPJEOYU
	 lvy6G3v8sZ0e9EoxfHRBwFJjyUsyoaNhVmqSmrnnHDyaMEWq3arvzlEAZ/eUuQwRSpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318C606A332;
	Thu, 12 Nov 2026 21:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1318C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BEB5868D12; Thu, 12 Nov 2026 22:22:30 +0100 (CET)
Date: Thu, 12 Nov 2026 22:22:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmet: zero the entire Get Log Page transfer
 buffer
Message-ID: <20261112212230.GB11411@lst.de>
References: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn> <20261106230019343v9OWwbe7yzjYZeoO4htcW@zte.com.cn>
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
In-Reply-To: <20261106230019343v9OWwbe7yzjYZeoO4htcW@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

