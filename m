Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597014;
	b=KexWX7kToRFjg28X78mrSOG5sn8xSzXvpZS+GMuv61J++fDYfBLocRUJaS1YRHuxVbJ0
	 X7pjzHoAeDYMzshE3c2QoEpM72Q/3aJfzVewvQSM11o3Pc87C9WPVjc1Pc8FQr9RBS1Jk
	 x90qbG8ZD0BX0EsY3kyUUa4C81na0jTtqN59h7NumvzvqPLqACBPJ5O+Q1GrAhkdCxT95
	 w6uE+Bx3i+4XhSolsRUUus70F4Zv3wHVXYMm81kyG5rAJvfMV9qticbl8T/KvxXtj8/45
	 7+sKCv7GS6v8Wn/L8Y9uQExuSWhxMKPuGHzm96s6IoPQKjw+wNd8s7bGL8b6dGiVc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	b=CfX/Sqi1vOqDjBgq0nF3/toq/Er7/5ds6AdeH17sORCH7scSxsOmUm2jnBaI+o8TLYJM
	 Ijz6jBab7I7P4qjhgmLU+3xIpoVeRRXot47N9C+N4+oU8qagtmFngSWsLH+SJxrYrroB+
	 Ui2Rx+RCEYCBbU/liGMUH1iC2JYRWgYyDxtgQ+L3TOucSqU1kJ7GxF3iHquNoTM+sVDrD
	 21HbIkE3v9kKQYNtr1oHM64EDhccIX1zz642vy6sL6do1KgX8Dj/xfBjt1cbxq2gymj31
	 w9af94xV3nRvuP94gOdGRIX/bTPhrlS0SXjowIhvbj2RMgEdCNPf8DDTbUav8iZUp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KCX1va/U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67B60A2606
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCX1va/U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94C01F000D0;
	Fri, 13 Nov 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597014;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KCX1va/URfwUs92ucMZeW+ZxpuGSLntx5JR7cSSzNgN7pZFK/p4mUcpxeb4ZIFbL2
	 5/r9NLLjtrUyhmNRtchf6LK0ZANGxvWLoUfJvgTDxvvLMLb5VcsQJq/kVavVoVUFS/
	 9stWE15Ffk6SUoRNX1sb+U5GTmcGOzm85LRYnG/pt/i7G1FOas0+R9qXHLADijOHmT
	 xOXlm1/sQuibQ7LjqtXwvnYPCLaq1q4HI8RkckqbuhIrJK/sXJsI0EwQqRYCSKAxs/
	 xAWjyqiE6bSy+wh7ZEQ778IzdleKaREycr95c6bwBxUPkb/L8i7vDOVXn7i6slu3qR
	 kaZ/Ed+R7xi0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [PATCH 6.12.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 14:09:58 -0500
Message-ID: <draft-0008-redipietropagealloc6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110611.2915381-1-dipiets@amazon.it>
References: <20261113110611.2915381-1-dipiets@amazon.it>
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

On Fri, Nov 13, 2026, Salvatore Dipietro wrote:
> Patches 1-2 are its prerequisites from the same mainline merge (Cc:
> stable), only moved from mm/page_alloc.h to mm/internal.h. Patch 3 is
> adjusted for this tree, see its changelog.

Patches 1/3 (6ee3d87b9408 ("mm: page_alloc: do not give all non-blocking
requests reserve access")) and 2/3 (fe21f930d1e6 ("mm: page_alloc: remove
ALLOC_NON_BLOCK from ALLOC_RESERVES")) only carry Johannes' and Andrew's
Signed-off-by. Since you are the one sending them, they need your Signed-off-by
as well; only 3/3 has it.

Could you resend the series with your Signed-off-by added to patches 1/3 and
2/3?

-- 
Thanks,
Sasha
