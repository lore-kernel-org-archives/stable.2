Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF22332637;
	Tue, 30 Jun 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858204; cv=none; b=JkYBz0hgMIfR1QyICdQarsz2hgc2gWIMSExC4ZEamG5lAtx7AXPCKHiFUCKlhTncPoBEGtjI0JrGpcyBgKjFhdPT21P0tTKziYFtHp16tppB8+n8jSXBWbsJxh8Y+6dmfSeOpRMNsTKg56/YjuhGPRWUwQz83QWfdd8vqVcD/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858204; c=relaxed/simple;
	bh=zKfguz4lcFr+3KOsdj/LrnWXbUA+NghHWZNldyGXDOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJPOJ2vz0be5LnccUhbjbvPhSKMY4f678fss5AXLapXE3lLq7Rfw5Tu2Zh6WCTmA5CLGYGV5p47iQ1pjKqgRgx6/ZJFxFAYrB1ZkWLZXoCM8tLgHXjAIl2zCjIF3OYw3fuDV8Q7lB7usUTaNaIJbdeE9onAvjHvkAaYfzQDqaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9HRfHYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9HRfHYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427591F00A3E;
	Tue, 30 Jun 2026 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858202;
	bh=zKfguz4lcFr+3KOsdj/LrnWXbUA+NghHWZNldyGXDOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9HRfHYOY1HGLnS2ddRqZLksAs3+VwPA3DDldc+Cvu94qbUIL/T75Z/uN11ZSBjnl
	 kQJ/LDFJJrBwrh2GIbz87iMJ70yNO09ogtc8Q+5jlfYaotlEHN5hhH583FU9N22U17
	 UizAk7pXoD84ICjdkssVgqrYGIdarlz7+vtBB9+6UHjbLGxlo/VeDo7pt07kel8gh5
	 bZzQJ8v/fwe8OdgntHHY05Veb5aIg3/xq5toTfcd7t0I2zuUIXk+VYfTMVhQ58uI0g
	 S0+yovvcZhC9vAiD8Dmrk4Cx+vAyG/gd1QnnsW7r28AreUQDQbqpsBvoL/oyUeISxe
	 lV1yMdmo3RHaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: Re: [PATCH 6.6.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Tue, 30 Jun 2026 18:23:13 -0400
Message-ID: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629093954.195016-1-sysroot314@gmail.com>
References: <20260629093954.195016-1-sysroot314@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]

Dropping the set from unix_gc() and doing it in the work function is fine
upstream, but only because later refactors made wait_for_unix_gc() gate
flush_work() on unix_graph_cyclic_sccs. On these trees it still gates on
gc_in_progress, so this brings back a window where the over-limit throttle
stops waiting for GC.

Can you respin keeping gc_in_progress set in unix_gc() before queue_work()?
The code is identical across all three, so one version covers them.

--
Thanks,
Sasha
