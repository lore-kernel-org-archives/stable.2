Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE934D4DE
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140375; cv=none; b=JtW5MN3AfUdmP7gN7JLjd9sO8FRlqTQOkr8XuHcJUr5z7DZFXDJOMu610YXoC4NaAIL5gW14IEPu2dDQOGLy6U3NYkzly0EOThI1UVolGFVl5j+8AF13zSLWzWmoi0lWtYlHvVtnfzjipv2IKdOK530Fr0tHE1tT1g5oeTHgQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140375; c=relaxed/simple;
	bh=ZU1iJqxO/ow7/qFIs7+knUHuXrObQaV1myTSAsYD2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYfl0rQdmYkS6QiYjH/QLyDT9Bu7oCQZz6mh+EbCi4yoDEtjKJTogKg67S2Urs3lO7btzlQ93jkTCuzD8/dz9slDJit9URy7hX/5UwkwHfTWdLDjJT7dSTkoAMDRf7O13FKtU4eNfVLUBHA3C60+BUIPKsHVrkD+XeT5uh7Gzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5FoUXhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5FoUXhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE7E1F00A3F;
	Mon, 31 Aug 2026 01:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788140374;
	bh=VkxHAPHUJw+4BRJjyiAGZYsU1OsNMNj0jfOsMr3dGg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5FoUXhYh/fI1553D+VumCvJETKZeo3ZwHBHurWg0K8uGAsnXyLzVULk5pT5LIsrN
	 EGhJnd+2OJcgpJyMszOmSoN4JplVw8EDo9n85TVRoXPboZd6VRqKek3PUQyKu6vDIc
	 h2JHXL3vVqNHXZGpd4SzqtV6pqyepSrRu68rTWegS5HQpnlsbDYsLObyFMsPCcINix
	 ji8xpHoszO1svFqwIW1jtjG0nNJOxfipA2WWsOrdxhXuh+WfiqD3vqh/95TNchkhkk
	 lzJJFojLFJ3lB4YHklFu4SRV0C6mYDyiI9AykHf3xO/uXymZMhj0Z6+xJ6fiBa1Vha
	 QXWTtBvhmVAuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.6.y
Date: Sun, 30 Aug 2026 21:39:16 -0400
Message-ID: <20260830195500.0011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830082733.35424-1-artem@trailofbits.com>
References: <20260830082733.35424-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for carrying the earlier 6.1.y fixes into the newer trees. After
> dropping them, these four mainline fixes remain absent from 6.6.y and its
> current stable queue. Linux CNA records mark v6.6.155 affected for each
> CVE. Every newer tree has the first three fixes. The last remains absent
> from 6.12.y and 6.18.y.

Queued the mirred deadlock fix and its noop_qdisc owner follow-up plus
the starfive fix for 6.6.y, and the hv-gpci fix for 6.18.y, 6.12.y and
6.6.y. Thanks.

Dropped the btrfs one - it doesn't build on 6.6 riscv, 1-byte cmpxchg
isn't supported there.

-- 
Thanks,
Sasha
