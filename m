Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999623;
	b=aDL4eA1eSaTc4QQpZW8AHLOkOkWmiTAgPe8d3klNYGuKpma1DVDk7cIeSrRqhXkwiO1V
	 2sJys0T3O+yfddOtBxgTQwu1ONVy5yapwVBvhZzCRRrl9wK1j8wN8uAzSzFvdis3hPajr
	 kDUlSSHbrAqcwsabgDIRZnq/6SIDB5D+bdO3MzA9xqDQmX6PNemahBs9CT9L+gJbGgvPm
	 8/u/26omvTuF6E6Lomq2TLh4Kaat6byel0eVTdUvOQrwcYp1hwICEaEsHJz5UbZ4gMJaQ
	 GGlmTiULAx7f1UYTxwa3YuS6lWFW3ZNJMZiZ7oBiqYLxEdV++w9DLmspQ+YUWaoEURw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999623;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+1ciOGSireqcvR0HMuZkvDnNvS7YZiFFHtIfRN2UnTg=;
	b=J/5SgxDowS09rN6Imf4/JyD1qt/B647XYzG3CUlA2HWRXKhNhEcZnhpEhe+/+TsqD2pe
	 3WiOmAuL9v04jKkzlKg43DrY0+o3uqDv/W3orQ6MImp2pI101flq61k5+KNPZ0Jy+LFt0
	 ZtkBu/MDv+Th4dsyTji7rSfZQ5P7DBmTFPHNnjmGFmaOJsoeqrGYvj9sCbLRbLdRT738J
	 wvmEVUOBmDEirfIqHqJKKbN6xGkBX3OLyHWWoBKBtJKQfcqMWhrMiO+rnVU1Els+osrFO
	 BUJ8Cw+xQAemFD1bOcyNzQIbP7gaYnKq8O+TVUIX94ou1Y/5YlpB/XrzU970MjPvtMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MlCK7JpP;
	arc=none smtp.remote-ip=115.124.28.123
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87557606A31A;
	Mon, 26 Oct 2026 07:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87557606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MlCK7JpP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792999612; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=+1ciOGSireqcvR0HMuZkvDnNvS7YZiFFHtIfRN2UnTg=;
	b=MlCK7JpP83YzsQOt2v0+NzkEENBdUIQBdbci98kzTjOXXg0q5TMlSPyFs+NoxIbtoxtEx30n/+jOpvBBXW7HZaCSrqPtEdncBAwl/TI4WPVuqfjnmlQzfq30N8qdXENHsYNk6h4OjGbSNGq1qvOrcqlqmRkpG77ZNaQhEh14tPQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2937401|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.482125-0.00228683-0.515588;FP=10231587737892487229|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jpqJ2bM_1792999610;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jpqJ2bM_1792999610 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 15:26:51 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhugl3@xiaopeng.com
Subject: Re: [PATCH] usb: dwc2: gadget: fix off-by-one in ep_from_windex bounds check
Date: Mon, 26 Oct 2026 15:26:50 +0800
Message-ID: <20261026072650.5732-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026031138.35911-1-fangxy@xiaopeng.com>
References: <20261026031138.35911-1-fangxy@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding Thinh Nguyen to the discussion as the DWC2 maintainer.

The original email to Minas Harutyunyan's address was bounced.
