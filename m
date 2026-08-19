Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FF38E8CA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110360; cv=none; b=Krxa95toUfumSjZxWQ3j/IO+RNxah+uUY2vidvzdNzMVXZ+xbW/BBKRljcAfuAKFhx2tDvniA6so5/lLlVz8gOI0AOS1lCCyrBHM2ZJ2igso9yFGKVlY5Rxh+Lytm7NHkNvjnIUJfiD2JZrLSMIpHlt12h+kIQoHVq68SiKPYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110360; c=relaxed/simple;
	bh=ReB5Js7IbNU8jxA+qRAIg1/ggLPsqDK63aOeW4ZzJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHrJDLVQgejxlbQEZeZ1q54tS2cw9sN4DkDJ2KzW2MGgs7JGpM45EKJw9kSDbSr/JYda1B3tduT53975OHnrEe/ccYj2RxUYyRc34Tl2+uFWrlpCzjVFNmzPiotd3EPySSB/sBMEN9PiLMQtM7tdePFkkrNSMPTCdXvQV5b8D34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTyx8Ady; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTyx8Ady"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B2B1F000E9;
	Wed, 19 Aug 2026 03:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110359;
	bh=c1IRWpE+ad027NE/Fy5Ka1QLPBuzBDStGwoX8WLthjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTyx8AdyybwNxD+SH/mn/qDqGI5grxGOL6LLD/KaZeq980FqU2kxlqbIeuo7+LwNr
	 nnhWQpbgc1hz4i36pX+pebQ6kkib6nGpqqksh5F7GT+N6YVs6lKOt6z/QF8lQDaN6C
	 NGpZ3708C3JWfqkUx0sIdnYpnAh76IYnP4P2jjxB1x3i5NGBZyXD5HofcZ9J5j+dlb
	 2pKwUOG2SxVreFfNt/l1SDKczWjq4AplXB5QV8iB0TO+hLzJBP7Rq962W2IhtKRORZ
	 6ss6mgFyb37SBta6ZvmHBdRVQKRCgMOVKplU+ZRZhIMWxxRADqLHcShBuLq1tQsKQ8
	 GY+/UIWJ/zDJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Subject: Re: [PATCH 5.15.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Date: Tue, 18 Aug 2026 23:32:21 -0400
Message-ID: <20260818220420.7@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818-origin-linux-5-15-y-v1-1-aa5e9c007ce2@amlogic.com>
References: <20260818-origin-linux-5-15-y-v1-1-aa5e9c007ce2@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:40:05PM +0800, Jiucheng Xu wrote:
> [PATCH 5.15.y] f2fs: fix UAF issue in f2fs_merge_page_bio()

Queued for 5.15, thanks.

5.10 is affected too - the Fixes: commit 0b20fcec8651 ("f2fs: cache
global IPU bio") is v5.5, and f2fs_merge_page_bio() there is the same
as 5.15's. Could you send a 5.10.y patch as well?

-- 
Thanks,
Sasha
