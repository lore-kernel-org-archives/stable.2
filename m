Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06E1E5B68
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807890; cv=none; b=AnFPtjTOeAOIJ/Pi7D0iJMn/C72eBidWa8dURgQK4ZQNe/KkxpussN1L718pfz6VLrt8R2BIEO5AfHypLyW4fVRwcF0KcpH9LMrVPLcGg1gZ5+aALPPVR/Uk5WqaBjUoQLVR53CBX7MSxsNSNZlxiaHirKDnorGl1HqQsumMwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807890; c=relaxed/simple;
	bh=ML2LwIzGOG70YUAqiW2PZcqGzN7QuuZwkfSVia1K5HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5NQ3Ojwd/vCqqotex6piRuu3QdTRaYTlgt56slySy+tPveKu/0QXyqbfS36VJkNR3Ceg32UUmpSvxPuuK0Z9ZVixJatxDMYrck2AIJtkfTwrBlgR71ZUEQHg0kmbeI2EBYgMaLnt1aLLmAPEbrjOYjlnF6vGKS86q4PHHb0m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APCNtRvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APCNtRvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BE11F00A3A;
	Thu, 27 Aug 2026 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807889;
	bh=kMJ//ncsK9Ne4loUeHLcu4O+SP/N8HAzb86Gnh6jLzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APCNtRvXz0jv1LYgx98Kv49HEwhbCpMmhd1LjvjNZf7R67F9SObBDXYlmkQrJzHL4
	 ayZWWiZrVnI2K9J/adxxKbLqIS99kNp+FlCRAfl6JHVO7fiuRuQd1wXoYLBksNcErE
	 aV4LDKuaT3UaXJAsb1Qe/oXE3Dbteo+wPR+iZcMkMmIB4PQr0UcWTwq1FLrHwsiQwX
	 zce3B9IenWZ9t6CzMe5wG/gW+aC5+8p/qtD4PwdpL8YrtgyY23sKrDaXmxGmDvPo75
	 XaEM8omrg3jw/90S6VdW7jpndAFpxZ7C0SVs/1NfBzrZPD9ls7Exq5icglE9Tn2SIE
	 DNOrdOnSfHkBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.18.y 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Date: Thu, 27 Aug 2026 01:17:59 -0400
Message-ID: <20260827050834.10009.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825233053.1504506-1-jia.yao@intel.com>
References: <20260825233053.1504506-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
