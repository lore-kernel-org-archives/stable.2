Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318757;
	b=NM178gAgYEo1UH9DLEvFx+euwSYecffcGyqG7S9VRZ2d/FAKTlqW4MYZyMxtp7tjIhCt
	 ehzeUaRtKYSgroxhd6kxBpCNttBnxItwG4OQTlZubFafwsfvLILfVdP58aLC8XhzGtog6
	 JPVLaIlfFsROx6MDYoTSo9nN9Q4j7j8K7B2kqoHqiG7Kf5xgSQxWI4XCPw7NQpSgqL4dH
	 Hy4EmbGH4pcgKaLE3v3PxhmhqhACDlBquhPOLCyGFw1f5TLzv/BEg1jlEb3IwI/nFqu4S
	 Q2CfofZh1lLLHoMXuft35rT4tRjMflUuLqWF9H39fnigM83JUXinYmye4jsYp0zgp4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ah2S13I6dvYjeJxPZDK/Y5vxjy7FggIcKH/GV749Hn0=;
	b=Wl4yKcG/UcYl1pNGeUJGOSKv0pBTJPqQOynpdhkktq14ToSgeEtYsIl6Yj0B1RrM4vYu
	 ThJdNUOiVpZHitS13nBOmqrfih6ZlmShnBGHdSYcv6bdUDjJiopHGMlOGIW3yJ4BcqylE
	 aWp1G1Jwwc8x2Rllc7Lhfc4NWlXmuVbGMjldm3mpSktfP2IR72xAhpg0L7aaDU+hnThCn
	 5KfFNGgri3H1kSZzuHu+Gx/7wt26PoZo9WsN3cG7/stIF7tDW3fZM7Gl6ELBuqKxLml0n
	 pjcD3uFyOoVdgmfsfQp9yvmC+DvAd4cop0Wz5sgOHuJ8ZAEoSqcqkSvnf5rG2AuWZkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGSPNM5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFE606A338
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGSPNM5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A5C1F000C0;
	Sun, 22 Nov 2026 03:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318756;
	bh=Ah2S13I6dvYjeJxPZDK/Y5vxjy7FggIcKH/GV749Hn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGSPNM5eGOxPNhUcErC4OgUjCh8BPOj11MlOwlujH5morGzUW2aDCxRxjQLc8NYrA
	 1KUqDGDrZNjLt/RdEETkjnp7frFSOorh6wYxDHD/evujUSjBUK2uFg3+/G5Wi8R9v9
	 VE8gm1ViYak2svZ4/DkoiUwaIGEhuv6S/hAWpTLnrALATFiVyPlzpydEI9LZXJFdIc
	 Z6702cOm2kUrtx42FQgtP2Btpr5i428cz4DHTlrFBBAXIxwCBgBnoWJWrqHJ9n9o3l
	 ZNbpwYnqCFgqT9hxnPhdSmgf5ELf4KuubWKacssCNJt3WOfLw/wIpTo2ULyk1d6AV+
	 WdvcnrjFwk5SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Brian Geffon <bgeffon@google.com>,
	Denis Plotnikov <dplotnikov@virtuozzo.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Martin Cracauer <cracauer@cons.org>,
	Marty McFadden <mcfadden8@llnl.gov>,
	Maya Gokhale <gokhale2@llnl.gov>,
	Pavel Emelyanov <xemul@openvz.org>,
	Rik van Riel <riel@surriel.com>,
	Shaohua Li <shli@fb.com>,
	James Houghton <jthoughton@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	SJ Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6.1.y v2 0/3] mm/ksm: fix userfaultfd protection on 6.1
Date: Sat, 21 Nov 2026 22:38:44 -0500
Message-ID: <2026-11-21-2-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121135653.3466-1-lance.yang@linux.dev>
References: <20261121135653.3466-1-lance.yang@linux.dev>
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

> Could we take David's two KSM patches first for 6.1.y? Both cherry-pick
> cleanly. 6.1 already has FAULT_FLAG_UNSHARE, but KSM still breaks COW with
> a fake write fault.
>
> Patch 2 needs patch 1, and patch 3 needs both.

Queued the series for 6.1, and the v2 patches for 6.18, 6.12 and 6.6,
thanks.

-- 
Thanks,
Sasha
