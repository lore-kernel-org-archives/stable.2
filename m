Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584301;
	b=l/LKJ4CXgT5wUTwUcTJz5xr5XO9wqTg6hdKybnSqLwJAEj/2wxfB/TkzooDTq2lBA2Y1
	 aM0JSSvVF6X3UpkNu0DyGTw624tUMHU8Kcsz122UALxgJyL59xrRzZ8oKrQEfg2sGK8z2
	 WZn0DrNyJAj3PQQR9abPKBMzSa9L4mugEawQcEAe1iI1RPzpPQP8RhGYjUC1hare++mui
	 MDv4yrXcYx5DEeDZz9fmVV73/SheX3a98UjDoTf6HqYQ9DbKsSWCwA0UvBrT8kQu8sXaE
	 UuV44FHncHUn15yJRfTRZIi4QvYpISEg4EOmS5pYHHbfuCglzSqG3O+9875iU4ttdBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584301;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=1ww3WU4EQ5fYRS8jz3r2m6ao0w5x9rKAb96iDO/vFa5K4xa1pLtO71+q1GscFkZw9I7W
	 kqpHGTpfqrSZ2B+lYtV5k5nH1RK8fE+sGq6Z2UASOXV3h6b8Gu6BymWFSC1vWbhYQHxz/
	 6/ASmaDP1EjDwHWjgRz+V1wmBSsrE3pREXmXw5mSrsbFrajGJqyrnvxr7X07nr419VRKL
	 AWrLIdET0bUMbXEYi+4Cc3wf1GBusuJ6B62hTfJcZpMw9iNXJHpHw9gweBIm6tbHF/EFT
	 XvmEPSRBWkTnAL5tM8uWcpvPt3a/Zn9p0jN6u66sHWqHjqe2UgrvDzmBNH8vIasX/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD34606A31E;
	Wed, 25 Nov 2026 05:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD34606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 047EF68AFE; Wed, 25 Nov 2026 06:24:58 +0100 (CET)
Date: Wed, 25 Nov 2026 06:24:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme: decode the FDP Get Features result as a
 dword
Message-ID: <20261125052457.GB20248@lst.de>
References: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn> <20261122224834044bbU8YIyVINFDqdSezEwkG@zte.com.cn>
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
In-Reply-To: <20261122224834044bbU8YIyVINFDqdSezEwkG@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
