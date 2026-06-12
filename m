Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93A3644DB
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275287; cv=none; b=T1UtmErORHqHnqmDFgIDVlFSgCNjpBtDw0C1Jnkua0nywrbOoMGaOeEzrRxge82sNPSwi+eEWfp1YxPQHV58T3rdIDuM25QmdLTxqBYbi43H3gjss2FN7Sh4iorgrF6BnB/MZa92JF+ut8g4wsSGuGZT2o6Sp8vgasRit4EPtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275287; c=relaxed/simple;
	bh=w3g1VhNc3n/LCB2xfAbuWd51fsn1THMiYIqmouajrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX3lysw1lAiBCDN4djqTHtQbuAE2s9jkoXVNS0P/w2bF6mYn2V/B19kNKVpWkb54yjUKqH1rwz51JE8Sijvb8n9M89aGPSFoS8mO7RmO9tHC5pAcrBlkYI27muGAf9epuqJwTLwZZf6e2AH6do4U1wHlf5p3kTU5D1n32nlGn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QipHgQ5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QipHgQ5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572C51F00A3D;
	Fri, 12 Jun 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275285;
	bh=w3g1VhNc3n/LCB2xfAbuWd51fsn1THMiYIqmouajrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QipHgQ5X4uVKiXTroRYPj+UaVOqSL5ReGWVVKsFjmdrLrTqJJrPN2qSR7fIjWAynK
	 q+ZMcTrHcUULH8rU6YfQnpPi1Hck0CW22dSdwwkc78r8WayVJb+C9m8mkDAyDR8M40
	 JHiJcG3hwPUG8jHwltds0q/ObCbwYlM4AkMhYw8tCujRuwGc7D/m+ZT5PZ3f+NlLD7
	 fJRZbDy90GVnsplhTxRX3WIOgutFkt+ytfjDTB7agReAxqX5iRZR3p8zPmCS+e3JZA
	 SZGKg3b8t1gdht1bTdvq+o95ba+fAhED8XnnTudWBVh6WlOW1uPsXMQMqEzP3W+ccx
	 hGYEHzeMM54Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH 6.12.y] reiserfs: validate tail item bounds before conversion
Date: Fri, 12 Jun 2026 10:41:19 -0400
Message-ID: <20260612-stable-reply-reiserfs-tail-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611224027.74281-1-kylebot@openai.com>
References: <20260611224027.74281-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:40:27PM -0700, Kyle Zeng wrote:
> Validate the per-item page copy and aggregate tail length before calling
> reiserfs_delete_item(), and reject corrupt metadata with -EIO after
> reporting a filesystem error.

Thanks for the fix. Same as your other reiserfs patch: no upstream
commit (reiserfs was removed in 6.13) and no maintainer ack, so I can't
queue a stable-only change for a removed subsystem on my own.

If you can get subsystem review/ack, I'll reconsider. As before,
exploitation requires mounting a crafted image.

--
Thanks,
Sasha
