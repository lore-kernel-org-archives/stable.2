Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2C4052C4
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436436; cv=none; b=mZgmNP7Hj/XxEhYSwh95xuEP+6BlTS+a/OXNS0vmwf0EvaCVw4yBBH8hhUI077ajGg5uEdUOXeYLgqEHaaG+rixZw6rlTt8fT9bEHy/EcOl8xr1aIZaUb1IM+qPLJkBqokfamaZvfste1onFsFwIN2yXueljS8ZR0cXW6Thl33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436436; c=relaxed/simple;
	bh=KiI+7yTtZXTNC5p0uY3VvSYwS+CgALh6fHtg8zNJYXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoKWJ0Ov/DXCVRfkmWPhi+lez/xuarvsThfoOElGLLVM9etzE/yVKDWXu7PfHKyeytGQItiqzh9TBvIEZuPEv4b+fBaiQy6/cTdlnGUp29HQsFcs9Y9N4+bvCosy8IQuMaUInQ80qMcjuK+MeaYyqQ6k7b72osonpLYwhjo1jGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICsTU8v0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICsTU8v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134BF1F0089B;
	Sat, 26 Sep 2026 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436434;
	bh=1FxeVtfvJ4g1gCcn3MIfC9oAsRJ6UgT/o0WapXeWI54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICsTU8v0otN3tP/BJ98daoK8sqXQHTLzPvctD5z/IUnTQPK2uX8MocdqOKdX6rfrk
	 9l1g+z9AHD/tOVvVxNtMG2BtmWGIE9YQVhZ027+j49jqJ03edsyTfF9ZDEo4bgrlic
	 mNY8deUNUTFjMki7ZmM3VMvtlouZ3o09N1d6tBxwlLSMTekL4claBjkt9gkP4lsEyf
	 sCSKU2Y8R6slSu2gOo1t52N8plMhTYkcBvt+7RKjdGCls1+naCCR4yziDvZ34bl1Rv
	 0p5putshPiuAMM+SrVnBPxEz8Oca6qx2JAZOTKbL9pwiZ2K32MbrfwrC17IfgG2vwm
	 QDz+wS6bSjgnQ==
From: Sasha Levin <sashal@kernel.org>
To: Grische <opensource@grische.xyz>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.6.y 4/5] vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
Date: Sat, 26 Sep 2026 11:26:55 -0400
Message-ID: <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925180809.603571-1-opensource@grische.xyz>
References: <20260812091127.1349673-4-sashal@kernel.org> <20260925180809.603571-1-opensource@grische.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Without it, iptunnel_xmit_stats() keeps bumping the tstats syncp,
> which overlaps rx_drops in struct pcpu_dstats, so VXLAN's rx_dropped is
> corrupted on 32-bit kernels.

The reader side is missing too. 6.6 vxlan still uses dev_get_tstats64()
for .ndo_get_stats64, and 6.6 core has no dstats collection, so vxlan
drop counters always read 0. On 32-bit the tstats seqcount sits on
dstats->rx_drops, so once rx_drops is odd a stats read can spin forever.

> I can try to send a 6.6.y backport with the above in mind if that's easier.

Yes please.

-- 
Thanks,
Sasha
