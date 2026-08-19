Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A313C1D42;
	Wed, 19 Aug 2026 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110368; cv=none; b=LyKX0HInQrodgEGHVYLq7/CrYwoARA4H6410CzIlJc8kXM3p30sprCMzhYZdza2M5d1fqXC1qR3Ip3m5dcB1dQS73V/xxIc99RjYAo9oJJ1/M5jnSJi0pgQXh3DiQs/brjre5U+UWKQ8eDpeM46zEpArb2augO+g7rlGVuJ7Ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110368; c=relaxed/simple;
	bh=r1kiJWqSNxCtbj258NTVXEY09WGI1c+N+MH6Avj/Ovo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uue/liDoeKh8sI8N6beIq5q2TNVKbv8LeGJ2dH9BUKUM+VM0M968DVMYBtFBVLC8rX4AEb6DuY8K6OeSlxyEj0azM69Tiow81eqxC+l9suI1lJ2NPAjE+9aLu15g/H4QU4DYdcPVe0HroAgxPRBKoUdU0aqUEmWFtgUo6vtoiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B86NO73+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B86NO73+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5021F00A3D;
	Wed, 19 Aug 2026 03:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110367;
	bh=qMZhJQ1b1KdtqXy3RBQjD6zbWLJZVodgX7F9Yn4Bpzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B86NO73+fUoDF3J6in9PHbkR/RkMrQt3iYHBTersOZ4DTfeL01+AXkSVTL2xSz2nn
	 eLRSIbxGokE3ipXh9VxT639fUpZNS5XNUZ8lYH2prkdF1naKE737fI/0tnTgN4HqP6
	 h8pa+ZdvemESku2gNluynV67hGdH4oYWQo8miUAKxbn36kbvMa87ZyGHdCpMOoc7rd
	 oAG7QFyl4tS0zj56KnIF5P0br8Ae1dKk4G/lFBpb7tlF0/iMMBJYJROILNrkeSWMbA
	 mfr/vQ7pJdwn4TlPujW8R6UDj3VpnR6sIanmVkV07eNm5We99Y5L4XeLSf1L5AccoT
	 0OSrzK1gXmS6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: Backport xfrm race condition fix to stable kernel version 6.6.y
Date: Tue, 18 Aug 2026 23:32:28 -0400
Message-ID: <20260818220420.14@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817221108.778584-2-taherafahimi@linux.microsoft.com>
References: <20260817221108.778584-2-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 03:10:09PM -0700, Tahera Fahimi wrote:
> I am writing to request the backport of the following patch to stable kernel versions 6.6.y,
> addressing CVE-2026-31516.
>
> Patch to Apply:
>     Subject: xfrm: prevent policy_hthresh.work from racing with netns teardown
>     Commit ID: 29fe3a61bcdce398ee3955101c39f89c01a8a77e

This one is already in 7.1.y, 6.18.y and 6.12.y, but it can't be taken
as-is on 6.6 and older: the line it adds calls disable_work_sync(), which
only exists from v6.10 onwards, 86898fa6b8cd ("workqueue: Implement
disable/enable for (delayed) work items"). The cherry-pick applies
cleanly and then fails to build.

Substituting cancel_work_sync() compiles, but it drops the re-queue
prevention the commit exists to add, and I'd rather not make that
substitution silently on a CVE fix.

Could you send a tested backport for the pre-6.10 trees (6.6, 6.1, 5.15,
5.10)? Netdev folks Cc'd in case they'd rather do it.

-- 
Thanks,
Sasha
