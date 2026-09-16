Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321941BA77;
	Wed, 16 Sep 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586943; cv=none; b=PyWjSGOMNm/DsjrhFsYzSaw5dNt81+D5AyfGFNKdCHdOqBBCjazL2ZORZlLxfsplXSzdtiyjrZA35ACFDcYsfbAiKhKySpnHR04SbRlIMFe1wKhKUm7cayz5+mBld9RoGFLCLXRx72bxaZO/TytgiU7mGqwZ5dtr3aX7oKStU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586943; c=relaxed/simple;
	bh=k2WRkj8SWVykjQdgedUIsiIX+XkVRn9Yqh+BEsejjDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Irb5POEhPhbK+ai8V/KTGL3x72+xzue7MVFhcbryLywzdtmHAqAuYMNuFDkg2EV7jW1ct7lSXf2Aj1e3xbVP0AcWSZkzc5lvcdiW/KU9JhH8sSCKUNCMB4Axg6TEmOwN/7FoqF3Hf9Ga0nOwrD6vxuOa/Md0l0E+6PkY40alDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlB7w5nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlB7w5nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FE41F008A1;
	Wed, 16 Sep 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586915;
	bh=GvhbdK8ZcVLJK5U74dIkP1qNpkB1t+1sjVogZhS9BUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VlB7w5nr1V8O8g29xLMR3G/j8JFEobjFVvI9dg1u0TmPu0/ewiv+Pr31Eq981Okbz
	 EQIgG4PTx5rYKyaBKAZ89Pyj9pZ4Z3E1RImLU5W23cHsDaMtdjH9ulXB8oVUuU64fe
	 CLkKYjigZFHttwPz18TaQHuU8A74qX58CVdrHRElKY18tk4KpuIjlQcdRfJ8/XAcWa
	 OCfZo9lCR+wy/dgC4fWD+xGsU9ssHeRvT4Ldhk7UAsIJ4JsP2Lje3OeZ8dBZLxEOEq
	 zl7rBTLupqct0SPo8SNNH5LHSz8HajNmYyEelVh6Fjk6ClZTpDMHY7a1oUEqB/uQsP
	 2GX+1R9cSaRJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y] ipv6: mcast: extend RCU protection in igmp6_send()
Date: Wed, 16 Sep 2026 15:27:58 -0400
Message-ID: <daily-reply-20260916-0008-re-ipv6-mcast-rcu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916081232.326250-1-shun.ota@miraclelinux.com>
References: <20260916081232.326250-1-shun.ota@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
>
> igmp6_send() can be called without RTNL or RCU being held.
>
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
