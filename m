Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700630;
	b=Dm32sfWSTKP3EsP/dTx182i54iOEchXxvcX1l7D8SocUq+BXJJz6aWz5Fe8JeCCN3gTF
	 HNR93v/k0n3oPAZVhv4v/sFsnYPnoa63DuY8X8hc+4fpLK+NHGAWTYqx8Nmn9W48EEVmm
	 hVURdemA1mhi8bI444HrD7rh0HaGQe+aNVJN792XXr9+1dLqZdDY6y57BteFere/yoedx
	 cEZTjzR56q8cPzRkiksyNiiiIiHg/Il3ZkW8usuxAV9I7kGlrLrx7ZCWCiS5hNHCqxMZm
	 TNAjXJ/bi1AuSCRvA61YiNzNZVxaW+MrjlOlE41frRb2GfzRot1FKPHVIF7K/y/05tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=zJUyjmQmBKyrXLXLxmgjcJJvM2eAHnqoUJZ1x8ZpfS4/mzynnvICK27LL9B1/6Zh8kGU
	 jQSN0bTd/fl86YRBUUJ8wqpPVBEKEfE1oETkEFWxusB5vyJ0WriL7S4WuB30MUDW0xR2s
	 I/5vZOgyu52nq5KCwXuSUU7qU9B6x9Q+gQkPUHwu0xJsdcWWsPGV9Eab0ggc+M6XVC2XL
	 c6kkdgFckyY3o6cBiCL1YPlwQCWTNpREKImLWbLX5MOfaph1Z9EiAPZNH4q00e9JXnkU/
	 8DI+AqnRi9X+eXZhlIyS+GhO3xBPHe8I1hP6+LoTStH9vb9cQF0SRyC51yDhtQAddVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QP+RRhC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D36606B122;
	Tue,  3 Nov 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QP+RRhC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1781F00A18;
	Tue,  3 Nov 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700629;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QP+RRhC/W4UZqSY4PiK1IEXOdqtTx70G+GFGuip7b+PtltMIYimWqcBOhH7eoqSzP
	 JyGGvo7wDHmPdewJTbZDT6WDb/aNNv7PvqxOKCaKKnkpWjKrVQK2FhK3WC13gPvrNH
	 Nf0QtCAFwwxX5GtKhUqSI4WgDLOO7WhgOTQUXJav94UtbKlEw71X92miXGRPfilsMM
	 YtjFLqwjGjnq91s224Edw6I1FN0N/C/914u8dxl8uokkspw24lMPPWKcFoWj5AbyDo
	 Kychd6JKF+YoGZBqLbHLQiZjlW/8yBjiEeXQcJBQ/48a8FpeS5W74Iol3ezkvp5MrE
	 Dlu4+KHKpBI8g==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is stopped
Date: Tue, 03 Nov 2026 10:10:28 +0000
Message-ID: <179370062811.488859.14852630470087836565@kernel.org>
In-Reply-To: <20261103100535.1310088-1-vulab@iscas.ac.cn>
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
