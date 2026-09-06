Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891E3D5241;
	Sun,  6 Sep 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701633; cv=none; b=ARw/EoqqlF20btyS/yPvYCTn9mcb0Xd4rRr3P1j0T/CvSdSp2ss2tm52giPKhUIRp3t8Vtd2UOJOqyQYznP8twATea0XmowrgIvh+I32elt7ofjpq+8Hgm4XPOST0hbtmIbEZ4fOQyuFcLEDQGAZ/ItobVXqdqUJLvnijX7A/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701633; c=relaxed/simple;
	bh=v5Cmm4HKd07E8xmcmZlrRNkuesin1tN047/M3BTd/iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7fghC76N8wO7v2AvWgW5OL7JZKmvfPGNAXQUH23ydqyAigOUna8j/fNfn9cdTQ4p+xe1oZgkY4IdFL1p1k9z2/qN6IDd34zBqcuZ4Ci1ecGiJBI3PrEmFBes54kUtrMyZsy+xZ4zTwdcKDpRaJ0TZejPpg5l4hYt9N03GL6SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXY3Z1MR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXY3Z1MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28881F00ACA;
	Sun,  6 Sep 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701628;
	bh=QwzPbntWEQhpa2X35RldwG3rUsX2TQwN18soR5fZqrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXY3Z1MRIlNV3wafjzOJ2tcsFx9Ybm/7DV0AIwvEa8CQEVfjxAzaC7FsBIHtPzC7p
	 G7LXoYbhuD72uEdCf45Tws0a3PI4SigTunqV4Nr633pHa+FVK8M9TYU4ARb2F0P3H6
	 bAgmPpmaAvvRBwzqos3TDwZ9B3/V5trpuAfD+zoOJY46CnvX+5aFAHqnuAirk+UjT1
	 rAAvqZMs6Q6V7E7aFGHLbDFPUn5BHLO3jwZa7kIu5srOBba6+y0DUTnwkMcETmS3Jo
	 KZYQfHWxEzaLlKie/m/apXP/A23oFOFuyIXHudQUwvKYmwmZmSsY/BAr3gJ8bCWs3u
	 4Pb5tvkSB9Wdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: Re: [PATCH 6.12.y] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sun,  6 Sep 2026 09:32:54 -0400
Message-ID: <2026-09-05-daily-reply-0024-xsk-csum-toctou-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903221130.27316-1-surajjs@amazon.com>
References: <20260903221130.27316-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
