Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087851B163
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862773; cv=none; b=ZjeBf5iNjeeL5f6VgPxNfM2kltxT7E150Ck+ByuRHwzAJMfXHn6HIZa4os7Wna4fpIRTaY9QVpNV6rTt/H98QthFsISEixIsUENgPcSgz+/sHPjza/g4O9Nf/8bvQilvla90HZoXOnhkWRAPB2O+WsIAIu8RAO7iiqWAZD3a3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862773; c=relaxed/simple;
	bh=2Ss4zu6zkDbiXevqT0NAP3m9yXElqJg+rtkf+6T8SGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfOSn5xlmRoOvE65W12Blymxmpd9ThSQ8c6GRJPrwT6uzrv6ARJSE4/DahJlKvGzPgqZwTH5tKRJjiikm9d6AxOs17+wJnC5Bxb7HQMIv+g9C78yEg1pv93BKiBhSG7Ni89pMcRNlQiKdq6fj7ib1WMz8bkuI3ytYKVzeBjgSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hptBiT+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hptBiT+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56C1F0089C;
	Thu,  1 Oct 2026 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862768;
	bh=GPgZFVkpjopSUfl8peyB3/X3TVbCIth8bafld1V2uKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hptBiT+Dbzs/RmU02gpNcmRW+BzUNutADOI03nXjoTgy4xEUkT2w14YrQRVW4+AqT
	 uhBna99cD/tcHc+QIoW5OGhVFETtitRaCvSq3yQrHmNn+I8R8cLYxAA4z+bFi7WLf1
	 ufkfx2MnQEBS1dwUHouyLznJzCyQ4ZE4AtSRTuqRd7RXszGb+CjuZbqeGRFcEgmDBT
	 a/FDMgzoG1/sFh3Ley4D9WOqPi2i/AsiNI52dD+N//W/WKQwzdTor8Fkba3sTNVJ7N
	 XkvuhGoA+/Y1IFC1HkBmfI9uUkrA6V/y1/janoQF70TOAdPmn5AD+ft04qVGNwaj3D
	 Ppo33Wsbyosjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Krush Chavan <krushchavan@outlook.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 7.2.y] selftests/cgroup: account for zswap shrinker writeback
Date: Thu,  1 Oct 2026 09:52:20 -0400
Message-ID: <2026-09-30-1-daily-reply-0016-cgroup-zswap-shrinker-selftest-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930133550.2071552-1-joshua.hahnjy@gmail.com>
References: <2026092910-trash-gossip-19f6@gregkh> <20260930133550.2071552-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> However, when the zswap shrinker is enabled, the victim cgroup can see
> legitimate writebacks not triggered by the aggressor.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
