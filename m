Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537216;
	b=hlIaFl6vDGDPdKzFXcUbPNwWecqmFC7Jbdto/XO9y72ENexBKMKurba6JSwmvx8xFC7B
	 DemnpC1fnU5wcc0pq8MrbEpINzyJZGepqGgqfb74Oso6rRL2Q9GKHeiMo49aB3d0hxb8V
	 76PxzPecbw2dwjpu3J3k0N57aVpVtw7VFBEUK/F0WY8yNCgtYEN4MBETHsdH6JJUj7U2J
	 vwK275FAnEd4jTPxycEFTCAbpAyH7u8L3HITDZMXSrj+VZzi8zr3NRtJ/+HBXzn5wAd7J
	 /6uwdwROrOlbi2HvMFlkX6IpuGfxdX/WPUIxju7EI95WqXxK5t/zyL6QmcAFUxAYydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M3U2ulqhfAgoSKQ1Anyd4MMHq9nB8wShrWn1GSH0d0U=;
	b=Icn2eODf1G9T4PRNYwnkossnfZu6eAHGgbU37PIQeULgWLEvaeCRQwb6fKpgekK2yNIs
	 E3xDEoPo2VgKsxeROQJ6XNeYeWM0CS1HigAwIe3jO+0NUuuNMgoauDUYiL6d0l6E8/BD2
	 Sw9kstvTGUbB8gRHXdl/zRi9KuWjcCn5bfLj1PZAVr4G0kat+euZQ9eIgrgbrESTj50ye
	 sGC23Mm0YbgS5utF1p9E6HZGtzql/ebpyrUXRE2wUtDrHLXaJ8NnaTaq4XlxkSpye45re
	 bua5IOOxRjRkQt8vQhWLb/L94+ulmkhiMPhZBVzwoH/5scvAmDJjTk/xctcOHpu0PxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRpuL1MU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD0606A89B
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRpuL1MU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A30B1F000CB;
	Fri, 13 Nov 2026 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537216;
	bh=M3U2ulqhfAgoSKQ1Anyd4MMHq9nB8wShrWn1GSH0d0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRpuL1MUYhpK3z0v5e+sTUQYGwIhyH35IuLHHWDi8i0zD93XDDl1/u0x485sP8Wgw
	 HRhpN0IEA6fXIPUsRUw7trPstQaHtOPK5RD4JoXWga+a6RivkWl04706SIlxBp36Ab
	 tm75Mhreufjzgb54Zs3/FPqQXc59i5JusBBOyoYsDiml0vEVHpKYeCnSO5rvAcYveJ
	 rsH3X4E6YVmQ4o7WRIYofb8mIo46PSjS2Wli9EU3THxsnIvGVUKouUiUvuGLVJbfsl
	 cVNsDLF0Jn9tUl7mU7A0mfK3dnqcz/DyUS3bNxxvDGDk6zDbn1y+kFD5mp6U0YU/e7
	 nrm/EBtMFJGmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	john.johansen@canonical.com,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.12.y v4] apparmor: check accept index + 1 is in bounds
Date: Thu, 12 Nov 2026 21:33:16 -0500
Message-ID: <daily-reply-2026-11-12-9946148139@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112062916.663868-1-zhugl3@xiaopeng.com>
References: <20261112062916.663868-1-zhugl3@xiaopeng.com>
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

On 2026-11-12, Guanglei Zhu wrote:
> [PATCH 6.12.y v4] apparmor: check accept index + 1 is in bounds
> aa_lookup_fperms() returns perms[index + 1] when the current fsuid
> does not match cond->uid, so such an entry consumes two slots in the
> perms table.  But verify_dfa_accept_index() only checks that index is

Queued for 6.12 and 6.6, thanks.


-- 
Thanks,
Sasha
