Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537218;
	b=B0cJ1FGY4MwFyRQhutpFkim4OZwW0h+lrrQMRuIFIoCn6Gol5yWT3U9iue/Eooj7BKC8
	 ztjAkT1g4N4cHU9mqPY46AfL9J3HF5uQghJTU9+wh6IcQD8h6EDtSjOaWwXvl19c1vvgO
	 JGUddpZRlvaKpWupSaPzrq3dWV+hBBC4VE+cKU20apkIXEIwnYcA3eZVp3HeJCcxo+eDg
	 QMeple/WhKEcXsiV4ldJWxUop9YqzHDlVS2lqAh7M+otB9qyavlaxqyO3iqUgmubjatWv
	 X5lXyI3qJkWAQV2asHTH/ZTITtmVTQPOFFZRxl977rnAMgbNw6PLKgeYARsLtZw5sRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Om+sqyZwKIbEaJ0stEUHeYfxsuzE7LgXzEm6tuaymLc=;
	b=IGl4jOjgJDTl1LxcGurcSxVfUgOzmEqGHLIblzqWJaowDYVUdvYSExvnp8C/fASKlsHN
	 +Ct+cgyGsqGTfxWMg0/KRN5V6iWMZhzD8mtldW6dvpSuDD8NPs+TVaYdE1vQB9F1snfg7
	 la8o5rdHOlpDGsfCXH8tULJb6dsHgEuFOwBYrMcTTqpLJGxTYbJO/n4MTm923IfQEt/Mc
	 qebKwxB7EC18eV9mWIusHWvayMrzyRNx977WW5xozSgj7X5w9DUm9Z4gkIrTkiJGZcfZD
	 cfbiX4l+0VVzxqYCqKk9+yWRM8NC1uayRcvr+vV8bwFjkRloEk0dfNf/CDyD+GRmpOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpB8bzVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA1606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpB8bzVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C61F000C4;
	Fri, 13 Nov 2026 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537217;
	bh=Om+sqyZwKIbEaJ0stEUHeYfxsuzE7LgXzEm6tuaymLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpB8bzVQmA6hmIsVyNTWjRuJQ+g8heN8TXG3qSmuOzOXDURC81tL7ZAMR9PKXqdAR
	 QhcS+i1+C5arvnrlkZokouwSa43GLsb+hjHIVT3ThgPh2r42FCI9/BVqfghxIzceah
	 c9X1BdkICj8JVRYw3TD7dcMEzP6vMxonA3W3i2VQQyuDKOGZsj8Jde9QxeWl4QBHNg
	 9tRWKJLu7PxeQK7kdYcIAPQmSQi7a2YFiFZuLepOsQJq1pr2qJwEPhftqM7ejyRUB7
	 vpjDyyEQplV/nxCWpYAZrSQm4mzZBiiC5qDzJaT/pS+ZRG84C5PbFtbTAJ8MtB8Gx8
	 ck5qBb5ZRD1NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 6.12.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Thu, 12 Nov 2026 21:33:17 -0500
Message-ID: <daily-reply-2026-11-12-6442443928@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132605.88959-1-lance.yang@linux.dev>
References: <20261111132605.88959-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-11, Lance Yang wrote:
> [PATCH 6.12.y] khugepaged: fix readahead lock inversion in collapse_file()
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for

The 6.18 and 6.12 backports replace filemap_invalidate_lock_shared() with a
trylock plus rollback, which mainline doesn't have, and the
reviewed-by/acked-by tags from eadce52a9ef6 ("khugepaged: fix readahead lock
inversion in collapse_file()") only cover the mainline patch.

David, Zi: could you ack this change?


-- 
Thanks,
Sasha
