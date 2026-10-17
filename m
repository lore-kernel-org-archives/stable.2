Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973503C09EF;
	Sat, 17 Oct 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206036; cv=none; b=dIpJLAUXK5KdE2aONuuM3IEMwved04+svwqaFGUjTHjBDbBtNzZx4EKKnWLkcYBz9geNdPV/0OWpei/dl1ogPKu+w15Xq+O33U86qbHCx4dzzRvBnNfWhyFk/kgbfbK8DO2D/FhgTvhrpVxUxJ2oRYOV0Rd3MJcO34Xzp7rQJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206036; c=relaxed/simple;
	bh=mWrENTQ5kvxg3hMNodYeKHDlsST656+QDnn7gz1rWC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNXR+pNy6VE8XFyIEK3nwTcVkOlv/uoB5OvDEBVVXaG5aY/u4VrDCMViv63OusBv3aCId9bAr/ILHMsFX2iJvNM+6OK3quaguoSGMN1hJBPWAiRmVW3feGWARxbb251pxGUIp9BtDLGk8CcdsYIKbNmv64WTWhRVw6B0XqN0Dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKodG6hA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKodG6hA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13401F000C6;
	Sat, 17 Oct 2026 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206032;
	bh=4gPD4L+1sL7lcR7Sr+sUtlwsiz4IzVaXbBWYT1gM/BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKodG6hAiv2w/UYLm8dntBehfWN2gSw6KN4E3bgeQz6DO3k4tsRvXIKM1NB75M72m
	 vDFjd8tywIbIEjX28rnO7nDo86AqONkd5zzN72z9LPmjuwb49wOqgSWWHLgIgX2QxP
	 wePTn0T8y1WVxDsbn/2NZviXB9toH8Uho8xhU6QdQgYmuoQLWi57CrhaZwf/Uh8cjB
	 JQaFwtpMHIkS7fJPBl731fAD6Qi+ColDdjO2sqfPSEr7VfnZlm3WwHi4/4h8JvOqXs
	 t9oPOTr6lwFHdRIpuSdmCj0bpi04Av90SrcG5qzvYghwXJuO7iU6p0mLctlxPxPpQC
	 rcLywbeZS3GZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com,
	edumazet@google.com,
	pabeni@redhat.com,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Re: [PATCH 5.15.y] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Fri, 16 Oct 2026 23:00:11 -0400
Message-ID: <2026-10-16-1-daily-reply-0006-xfrm-policy-hthresh-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015230634.2364063-1-taherafahimi@linux.microsoft.com>
References: <20261015230634.2364063-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An XFRM_MSG_NEWSPDINFO request can queue the per-net work item
> policy_hthresh.work onto the system workqueue. xfrm_hash_rebuild()
> retrieves the enclosing struct net from the work item, so the callback

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
