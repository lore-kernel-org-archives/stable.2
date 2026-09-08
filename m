Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DF2459CF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828852; cv=none; b=ArfM2RaUKaP3FpWKoqzpsvLxmcDWn40eHniwKyzOLOI54MrKmUgnODuHAexGD1gzEWLH048HtVpphubMaE9bDU5WhTzBakXXDIS0h7UaZpfVk/Ktfc/AQdKA9YVeJv9n9hIvB4f3hSBuB7otMO1G657BtWBk7W+hdFRrpihNoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828852; c=relaxed/simple;
	bh=kiWVSFpOVPSwZFEbeKUKTPrHor1V3ToMoDSyaEsDebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgGtKRQAJ2HpEI4+x+57hHxk86rcPog8YinB3UF6UEFd/luZexTlEewzdQYQ2LJFypSxyoWpe1ebKaF/zAmwtBHExiHZY8vyExQe9NAXJLCTYbIGlpTpkNhhSC88MENfeUOx7IkKMAHTJxENmKJYaVkn8p6/vdYhX/BgqxFoPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSgEhx4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSgEhx4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889C1F00A3E;
	Tue,  8 Sep 2026 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828851;
	bh=ELAW/rMzArYuOYeWArvE2ApzuUE/RSX3Wp9Z5jeOwSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSgEhx4jI1OPPiaF3l4wVS1cCAVA8QdTKvvpOXDqAuUn4Uj8VDC6a1lfqLLugkJT6
	 cPdrHixlAWRcAF+I2UCg8aMwm+i47H6vJqki0oW6kJPkSGxa0sBj7744CzTC//1zsL
	 iggnvPQ36juxGXBXsTZSH1AfYpqURSGCWGtSlDMwy10O5mQuGEqKhQpw78xcmKEsVN
	 El7v/7ohZ14G0hVHwV0SA9CE5Hh7CjIvQkO7OuPP4qMSz3roywUAJZyxaIa4P4H+0g
	 keBKUuPvl3Fjua2j2Oz57GV/r1FfgFsaLIC9pKxzdQ62hsNs0C08llnsg8yuHKdOGt
	 nXD0XmLlhdi/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 20:53:47 -0400
Message-ID: <2026-09-07-daily-reply-0008-ntb-netdev-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907025904.469166-1-den@valinux.co.jp>
References: <20260907025904.469166-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 upstream.
>
> Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
> also increments the drop and error counters while leaving the skb owned
> by the qdisc, and may return BUSY with the subqueue still awake.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
