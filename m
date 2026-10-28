Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200179;
	b=qAwA63b1fZYeYa6zNgnZQY38iLoccPiUi3VyDgPqomnf+7SYk1fu4W29C62PZ6yMXcHH
	 HD6KsHpr/Yysa/rqhCqPn66McpO1a16RkMH3VmYEswTnlsQn0i4T05UWX27YRbQ7IOgOC
	 KNFUn+RHfpE4TWNujPZbCbnJelVUWEz7lJUDQEYzre6NRq9jp49yZboO1lzgvF3diAx4/
	 FfmL+rN2WbuhjvGnzb4N38nCK+flL/OaOfG5Yiwenqd/P83R9gx1rTAw8z+lWjDDBZitw
	 L2zv483rg79iJJqdot+oL06jxe0wWm23CYZul1pXIsOP/CCFwQtt3boRCApu6rhfnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200179;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=D/WLINQI9hqucdU67Ie7pAW99vbrLA9LadowPMJpUa1gNHsLKhtOVpcwHVUsiOr2CzEP
	 bup+HxJlpLXPnhLUfr8sLgl4+9wTRvKmeynjXal6zEpom9e+KTjvhOG61z4oY+QwVheZz
	 9xpnuU2KT3Zp2UodnRujHk2TG8PnXr90GjG9EWw0f2Bp51u8MS6/o3IUgjAJivItBn7hC
	 GgGQ3QwIw4PoP1kfdCZiwyw3J8TsMgh3wkqM86SMEf/fo70akjknfGtpo6zFMKYw0ZFSO
	 DMrfP5QEwXNsOafPdjtQZ112ZuM12Wd2GGVlcpIhi8inRp2pumMcAJjf8RrfZwHABHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAA606A31C;
	Wed, 28 Oct 2026 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C10A68AFE; Wed, 28 Oct 2026 16:09:35 +0100 (CET)
Date: Wed, 28 Oct 2026 16:09:34 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/4] nvme: report synchronous passthrough copyback
 failures
Message-ID: <20261028150934.GC16374@lst.de>
References: <cover.1792118770.git.x-professor@outlook.com> <da6955f4e5702e9322cf639f108be66e0ee49863.1792118770.git.x-professor@outlook.com>
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
In-Reply-To: <da6955f4e5702e9322cf639f108be66e0ee49863.1792118770.git.x-professor@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

