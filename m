Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6030FC0F;
	Fri, 31 Jul 2026 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465590; cv=none; b=f6HF2xEajlK+NFYXDd/YywE34epAw4KwHBk/wDWrmnBbFlLHdV27M6QgWBWt2RIqpNgPzwfmdHjsyzjGywjYvOoJ+2D5/oiDagtIaqyWuuRUeVLyPaKxsCW+uCkS7oQdnGTmqau37N2PrHBKaaGfh+K36C5KTlMYAQDaghsluU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465590; c=relaxed/simple;
	bh=8vs6V+I8Xr7JQuXQZpV9qNBWPW4vnJnAQiByi7xwfdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH7wsVkSv4GUChSgANzYfhGkpv5AVFlC7lqYBUSB4iW812DnpX458oSkbXuwOz3PGFyXG4plC9+c2Z3U+p2DevZy1VVij2nNFKe6FMk6zm/FO0LPyOyDXjt142w+eLMozJ79Axl86rs8kh8BP5EOE+eoV944/ENo3wqqL6bO0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox0QHB8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox0QHB8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BE51F00A3A;
	Fri, 31 Jul 2026 02:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465589;
	bh=FQ7WzvW6dIv6uvvSGUc89KTl6IJVGc/frz1FvYCaOxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ox0QHB8NaM+7ewrew3XQC2kLDz/fIUP3cxXMC4Bcbjv6e3W2J/Um14chDx71WPVi/
	 fEf6b8XuKFsf19U7j7lI+sZaxWV3Z42c8TvUMC2a5v3Dcqo1503jDbd5haeeLAiaSA
	 ilSqv8pQfXf3wPJBa30xmTlrA6Hle25kxf6ANPQNZZdzrGObJ7M7vzOSyn+WkJ2bNw
	 hj4OVexloHpBPAZwFqpGE4g6XLHLil6Tx7IfqJw1FaNK6ypBb355r5uPuPbPy8AuBq
	 xsEYD4ZUW9kJCjgBP9Pd9djcEccmAb7btK+i310gfqw0WkXKQd90XJ6xWXnx8iPavF
	 XkzKWHeQhMZsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Yang yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Thu, 30 Jul 2026 22:39:41 -0400
Message-ID: <20260730203610.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010151.119009-1-sj@kernel.org>
References: <2026072901-stapling-parkway-4887@gregkh> <20260730010151.119009-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 06:01:51PM -0700, SJ Park wrote:
>All DAMON API callers eventually use damon_set_regions() to setup the
>regions.  Add the validation logic in the function.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
