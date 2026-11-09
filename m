Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239625;
	b=IesH0AL9YyE585BDDZi6sXaYCEZsQoaP9ZfhNFAJ83LW9JCDDlDlScy/SDHJhPOwb9bz
	 Edv13MYVNIDOvcW0EAWhMtRKdsk8LDAck1Ahp495puCXl2OzqeyTAlN2ZnnciiB5QSwO3
	 kVLWyGHfjGz1PEabLeNc8TzmtaD0RsGGBgYXGDwDzRAp3XdQSLW0RqK7L8Fi3QBowD7VV
	 lbTaKOgNodas3wDZRzNU/lSy8MRcTnrQ4WNaceqXlq0p7aHdiV5IpiSYb6G2X1bYzOBdl
	 ke/grU0lf+glz2sn0XddV+e93u/lWx/QXWWCrp7birA+DJLXV1fnyoNUaqaNa1LcIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rf8AntPX3WqlUbvgwucrt3jJs7bv4gnXIOSK+1100ms=;
	b=tYPkF0+sGU0TR8qQhqyHox9yJaz769gfCShKf5jH6C+3thnuQqRzFE4aZMZpFUpZ7v7C
	 bCzk2KPQ3y94FTG49ioK7P4BRdBWoCTBCBWTc48tSUqPdOYrbtCeYCao34iqD8oDH/beg
	 NSQVBG8d9XYPsAeyf2Dkc1gj59exoVOAwOj277Y5hJ4clu/N6MVhIxZdA3l3tpUzcQGHG
	 1s9z1s7fnKxp1cksdEIuQzD8KC8UPzHcnSPaxKkCAM0QweCAo4H2J15U7Kas8ZhRaphjG
	 X92JX6Ugqm761r77faCMqk51r3Og9OyqmIBBeS4/YsjSSRKumRjb4rB/nARGXdbZeWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpVtYECE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814B606A33B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpVtYECE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532741F008A1;
	Mon,  9 Nov 2026 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239624;
	bh=Rf8AntPX3WqlUbvgwucrt3jJs7bv4gnXIOSK+1100ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpVtYECE3LFG5CwWATm5QrZKVun33VjyAvJLZ5SlDnGmCfPok0XEzfTuPpnM0yVgN
	 ybE7M2orM8UxLRRj8Iv4JZs97GivvFcr3JMQb/+MWd8SOhJlnvrsBj5/nn6rBMCKSH
	 VqVz1SUHNfkMPyDlSvG2dpsWokTdrgp8MJ1lv6j/WcJeI66Xyov2/VrBxf9k1nIgIP
	 6HU4Z5tpSUaUzeMZcColybRRm27j/332W0vxGpKXh2qWnj+4f5QpMAfi9cMRPeWpKt
	 Hz2lrVWSZy3bEhWifcw10lyzFzJ0Xu1m1SVQT9ieZ7DXxA2GL0+szJiveWDlsJtRhx
	 AsIfhzV73hrNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 5.15.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 10:53:00 -0500
Message-ID: <2026-11-09-1-daily-reply-0018-bcm-qspi-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030620.419512-1-zhugl3@xiaopeng.com>
References: <20261109030620.419512-1-zhugl3@xiaopeng.com>
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

> spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
