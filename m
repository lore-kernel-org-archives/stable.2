Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785778;
	b=5TNxcTDaRLYyHB+I0RESSZ0nq4/XdX4uhXM9yvkloE2GN2up3f5AJLr4ZEisxKtMJkR1
	 hspygDKOzic4L2QoJGoP0doEgNI983ZF7A1FqZQYxNe3843baX2O3HRU5sKmK22xdHHVs
	 CQCjtDMPfDP4k8ygonZaC4OCtHOvsgfvm1Pot/yDByBg40yVPhoJuCgFyJ1Gf3VnCtk//
	 sFkaGPkYHX1ipPJfp2pLWrrb3R6uR0NIpcRRfcNXJiMLwqdm+kQpyTxSceRZHmKCzOTmf
	 U4SyrnzWpE4BRKYq/mOAT2l6yao8YvtEqUEDBQpXd9rU9ZEcyqtoigB7nhyvZuekg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OD338waUSCeNJpnAXk8wSkpFYtrrS7rEfKNs2s75ZoU=;
	b=Cfdbc50IUylynhDg3EcjO9mLaITzjXhu6bKB5c9Nfmlsv5yHF4BkDSnlNR3cmTw99ZKa
	 MG77/HkGmnxYEPMo2IlqLx08LN9pc4gA/xrZY6ZHTriHBhw5U8C4LUhyY85U6hdG/8UIO
	 So1oualg22ecXs/R09CEnSUKK6AXDV0Ai0Gzj6hA0Kbe7D741SJl6MjVjrL2OQhQDb2TJ
	 ducw8mDYCf8e8lSeprwVT0I0U4dfHU6bI7u41AKrRygq56zDnvZv8JbGCgUtwOeDg7H3O
	 M9rLplMLkCHybzFETLnBU0VYizw2Mm83EnfUZNlygI/k8/Cea14N3VArOHdC3bAN6mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpK7jrEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17802606A321
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpK7jrEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484DA1F031E4;
	Fri, 23 Oct 2026 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785777;
	bh=OD338waUSCeNJpnAXk8wSkpFYtrrS7rEfKNs2s75ZoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpK7jrEssofc9zXPuQxKGNcpBt+nxJicSZVZIoWfYn1HpXa30xKeLzXIDWRMy12rT
	 m59CnuEtz0cJ+lFwbQxkFhtJ8lgr4IEVTZGNykYH/69m71vh8SjyYfIkoZHEP7Hq7B
	 MmRQHg12TOaXKy8O8WkzhOEnZbxbocsehf+ZNLkqu3O1I/Nwgp4buYEKI8PNQ2eeTW
	 +c1H0vebxXeWMnx7exum8QpqH5rQjGBT73qrtDqXB3tsa2v9GGJT6mm98ViRrumZPN
	 yIOVOZ0JoMPraqN+pLpJdTBV7Fs+smngTO7E/lk/uXDIU7VHi+4C0EYB7wxmm5JoOm
	 Qr+0NM0gV2TYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 6.6.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Fri, 23 Oct 2026 16:02:38 -0400
Message-ID: <2026-10-23-1-daily-reply-0002-scsi-st-uaf-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155602.2740437-1-loberman@redhat.com>
References: <20261021155602.2740437-1-loberman@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> st_remove() drops the probe reference on the scsi_tape with kref_put()
> and only afterwards removes its index from st_index_idr. If that was the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
