Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390072F549C;
	Mon, 20 Jul 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553162; cv=none; b=vAT3REPQCGAfjBVmYmw64LAt5pVyzRHP6/R4+CoNQkMdbh8nJ5Gs3G4fCYcy/Z6e9S4p4aZKRmmaOntupzRn2O7KELBiXdGI2Uz4axrffKSi3S5Y67ffEBFh7ScZISu0oPMR7LMjJfHXD38uWVuT9zxynumXrBBIFExXoTf5Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553162; c=relaxed/simple;
	bh=V8olBzgCWnDgRVd8UWAEEhSxw3do8AuI47mFJfafZ40=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s6SqnSteGprRi6xJBKPMK3CfBKTWmpjSbqjXPW1rFak7DjusbCVjMx4l3PVDLBvCGXqRuDNBY0i48obgKFA0adkrzyx8ui4I5ILttB4VwrXXwL9pQnMKvA+bE3UtVJFdT/LZ5Bog6LsBdZrbiMSRcoylLFrVvxsSKebbIX6FPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rxte0Yb2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B42pDmYI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rxte0Yb2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B42pDmYI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 496C4EC008C;
	Mon, 20 Jul 2026 09:12:39 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jul 2026 09:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784553159;
	 x=1784639559; bh=ukg+w52uf91GxZwsFjJ7xU4HY7tCe9szRVM4fgfKbmU=; b=
	rxte0Yb2XsgVoklBDdxDsNdNSfQxstQG7Smv6PXtQd48QsoapLrEDL8JLxU103gb
	pN88jT9KjtnuSncuqFtYBeOeFMrryUvoepoAHavST5K3SY7aEBVwX/CazkybMpm3
	DgdIVzBiaeGaUzmpL06wir2RExeFvSzMeFnIWbSr79sq8ML7P+q1FArGAB/zSwXb
	MXR7jew1zfzk4xwanT0+7YFOSNagmEqnt24YiDUAaXhanQDfiwYaZkZiuEaJyt0I
	jHsGcTnigskRsjthFNLqTsNclUtxYIBnhNCxthcG99aF16yNnXPzjmvgbSuqnuro
	8U1FZwBXIFQa9ZyMTVlXiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784553159; x=
	1784639559; bh=ukg+w52uf91GxZwsFjJ7xU4HY7tCe9szRVM4fgfKbmU=; b=B
	42pDmYI3yGg5WoDkb2mBufUdX4h55PhUtKF7nZSU9lZypEekwBTy4Yt4ZLeDHOCn
	26Aj0oiBIDnL+8T3T1i4crorLk1GJ/HlBqmiCpbUlaUB4ztTk0O6oiJ9EfOjkbaN
	8VAzlbF0gs6zBl9VXPd3w/5dFvU/Gv93pP4LPUwoeYlDssuIGvnzgcpvr6g/wUG2
	yPmfvcsM0A9hI1ZvaNBP6wxZnG4e5GEa84kkSoVBwzZe17LRFHcasf/Z2+9JcAtG
	B2ncc/iTUUq/xe1IdNEegJ1HSoJo2v35EMWlIiIHFThsdYt+Fb7BkfpWvvGj2vHn
	qHkA3E6G5moBbXrJMOvRw==
X-ME-Sender: <xms:xh5eaiaMAT3PbaioMLBasxhWOBKmqhT6x0Q7N8zojBZP7RGfNmoxbA>
    <xme:xh5eagOkKWBpGAH9IWHmtz0YBqcJXLeiMFTs0PD49tTxRWk5eKsqANu4XiZagQ4KB
    SNuHLIUDBAPXZJbFimDBOcLOIyTvJB0iGOC66sS4-bwGHonJhP6Sw>
X-ME-Proxy-Cause: dmFkZTG0tkMvWsOTcph4MYSTqJPwtrt9IGpyB53DWtHx1ycp+tCdqyiVpVwAoTviyn+6OG
    47E/nNXjBjcMXFqxyNvIGHv322haTn7R2/8GkjQevga9zPLfAcwqEzX4gjbf+uUouo3kdi
    bC1T3CrMBPXTgZpOLAo5NTbUvDCooKDmcgF2G+SNz6Ea0ki6ecUWR5G4kbpoy9Ly7qaHCn
    osUPQLzRsfnn0JaYDqNx/tyXCgPg/R0RXzCu+3itNF2iLVV/JIX2ZXuBUc6WtMPAsQek7e
    iEwXtPHctHLbcEnQEy3AKNa36IF0/sQFgxHh0gmFSHsS4K3i45cja8mQMrT6GJ99SUUUWT
    3nIleir6HQUOhj+//H+DYpn45uRyTFlZunbi2oywydiqYdB8q7duNHFqKn1ZOD2W9yfKGS
    wbiJuBUyvGZrzjSDEdKNpt53waGAMaVkpvz9Pr1erP6Bko839WxQf1026+dQ6WDpuVXXk8
    2tCYPkjfA2dsPuCIGKoOiw58hfROTkxYrXmO88XHGa7IvMGgXRtDWFkoNm7Fk2o0SiT0EZ
    JIpfuRumM+RR7wD8R/wSYfwSp5i4D6qGlxH14PUGc83BTvgU+xZKlq8D8u6Mn3LWveURi6
    R0znZMc9Y/VmNYdl5XV3QTa0Dm4bjdP5hD0ST9HE/bYZGZF2UnEIsji727bw
X-ME-Proxy: <xmx:xh5earYGIpzc-6MEIAMALNGj25Wgdj8hHtM5hNN0K7t8Wh8f_UpwMw>
    <xmx:xh5ealV-fJ-iGXnV56Af-mv5dxkSrcNcmzvIki8uQw3YMAWC3WqyCQ>
    <xmx:xh5eas-e5vuHJbHn_SVU55QxjVPpT5w5dMZ4KRTvQMKcdKF7x8nJfA>
    <xmx:xh5eam-cgVuOdrsUbxipgNMb42d1NpxXHMnM9HlbGoVqQQB0Sge-6Q>
    <xmx:xx5ear_NqZ3bhJejMBRSxFvtBtWs-mZf23swNhA67lpU7V8M0O055xmy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA83A182007E; Mon, 20 Jul 2026 09:12:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgK4b-lwe6sJ
Date: Mon, 20 Jul 2026 15:12:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Hannes Reinecke" <hare@suse.com>
Message-Id: <11842725-e747-4502-953c-996bb8d24da8@app.fastmail.com>
In-Reply-To: <20260720104750.157926-1-sashal@kernel.org>
References: <20260720104750.157926-1-sashal@kernel.org>
Subject: Re: Patch "scsi: advansys: Drop ISA_DMA_API remnants" has been added to the
 7.1-stable tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2026, at 12:47, Sasha Levin wrote:
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This is only a cleanup, not a bugfix.

     Arnd
