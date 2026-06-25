Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81B32B105
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384136; cv=none; b=hgkQsz4bc2iWdVqzf7tH8XVkDPSX9Njdmetd1n8Vwwd+QnUc5RU29fMdhVMZsCdl07/k0m2/9tc/HvkDs03EZ+r2VgXFWpgNj4QJIki9EHTScRxzZV3y1aRn2ztXDgsJhlEyAxnSQcQd5Ze1pX1OesAizJun0nzXYGMpbu7DrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384136; c=relaxed/simple;
	bh=HeWsHnUuP/mR/NVQGuV840EwwXStyGoCTkZxDW9u4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmEUuGDf8xU8OwzZuttEPpafUtEhtus1xPFewxy6gadzJTjgOANOIn+oCKduzbMCds0n3/DPkYdhVUrxIPqiLaJNtZbaUBRGIvC4PcjrTED6xvwY/9CTkt4lhj9+RCquBmcq7cypg91H4HK1mK7NIxWviNspQHUVXAd/VeGymTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/y4bhVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/y4bhVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873FE1F00A3D;
	Thu, 25 Jun 2026 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384135;
	bh=HeWsHnUuP/mR/NVQGuV840EwwXStyGoCTkZxDW9u4R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/y4bhVUDEHtMPgFFdPIeXstpZxdT30vVTDGqi1Dm4Gvv5vwY5Fkm9zP5xR1Xp4gE
	 w8QRnin0uue6HiX2QZo2K+mA/MghJh9Dv3VAF3eXUZXXlqO7pZtyuWHte61LjeIXp+
	 IpclJwCq8ztNtZoJEOfBWlG71A/qfgxaHqh2IJiOvuIhRC0syEUhsNExKcCtZBXLZk
	 V435hWJ0kaTwSbCuw6pzOeZCJ2QDm0eLC6igKmfX4pCInyNVzzyVjROBIvozxgdwTm
	 6TyJFqEeIj+wxAHcsAz+5rKISktcz1SZIonaI3lBtS9pcRKjqik5ywkzfhiUbMViyL
	 16dGCNpdLhE2A==
From: Sasha Levin <sashal@kernel.org>
To: guanwentao@uniontech.com
Cc: Sasha Levin <sashal@kernel.org>,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 25 Jun 2026 06:41:55 -0400
Message-ID: <20260625054005.0011.act-pedit-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623100141.2383966-1-guanwentao@uniontech.com>
References: <20260623100141.2383966-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please add net/sched: act_pedit: fix action bind logic (upstream
> e9e42292ea76) as a 10th patch to the 5.10.y pedit series - it also
> fixes the tcfp_keys_ex memleak on the if (bind) early-return path.

It doesn't apply cleanly. Could you send a backport please?

--
Thanks,
Sasha
