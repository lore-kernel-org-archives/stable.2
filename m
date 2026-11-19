Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078356;
	b=vqBQQ021kQbK5ca98Zn5HHPXmJBTp2SvZFMoHi4RYPWtO6GEwvqk2l4HiN9YjkezRKt7
	 0phUFi18xiIN39kALMZ4oTjeh46FEwrLxjFfFb6NeHK7adbESXcDftc2IHk1qSSkx+ahv
	 xnrRVaSkCm78xxZFiFQ43iG3TbsqDBbvu0nFnKj73ZsN1UZRLNb0kOpvG17bCWcF1FcJ+
	 8prNpv1C0qgW74I6ZKb87tpqvnDzkQ60DH2eVTyc8GMa0BvUBUmp4LnIw4qyR1jE/LXLK
	 T752WnrlXK7JLay6hGiHkGn4YSw0fQMuQkWJPZ6lMBSUkEA4MW1d6CH+B7GP9jDutBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078356;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IPndn90TrWiuxkQkUrYep5mzt6mXRFlXBfoASzSRQGU=;
	b=HckjKOtvL9F+G5LRSF4Hep4Xtime03pWItqLFyrii7/rcNlhDW5z6henGRbAxEy95+UY
	 nrG4lsv+5fdISssaEd6FiHtPZzXgY1P2S+v7IlV9lJ+9l1Cg7YfXBWAsW3ibljgfJjbEw
	 +m2hVIWUtnne7RU0NA+PpB0mq7vpCBBe+0lNfU2HKVgJ7ac+8mHycvhvjSQLM5XqVy7ng
	 Lvv0ddGfw/tJRxRz+T4RnrE2t9X7pySDq+qFPmjgVeuZro/6zMq4NKQhWjXQnqja4Hwip
	 JojKv+K8S2oKEBX6gxWpy1eeDiZ+D9qsCamsQgvUYEWs1nQfmh34DkAoPPHLYpj6o4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1Nz+8cR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793C606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1Nz+8cR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE001F000C4;
	Thu, 19 Nov 2026 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078355;
	bh=IPndn90TrWiuxkQkUrYep5mzt6mXRFlXBfoASzSRQGU=;
	h=From:Subject:Date:To:Cc;
	b=j1Nz+8cR0jTce7Lp+aDCmO2fQowwUJsL1pf8Qlim9IPCU5cSF9GJDtXCEhrOFoGx2
	 j1QZyZsXieQmfRHnwmre7bjUH7/mRoJWdXGYPmuzoqjhjHQ8IAw+g+NuVicE2HsgsB
	 MarSJWRIFV4o2pte5enKAV5QrizPpKEtCcykq1M/0xJzL/o7pa/5q0UfOKHnBEf9hT
	 aSExsypAUGBR7OTzqNq/MTVjl8laEYCAtfG8gQldsH2vBoHIUgpCUDGqUOHhVJDxXw
	 XWNtIvzvxLXYauMlcTju6j4Pd4tVD3f1FC6xCWgGn4ExBG+beaCsHId1qfl/r+ADwa
	 g5MYsDz4abbTA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/3] alloc_tag: two fixes and one cleanup
Date: Thu, 19 Nov 2026 09:52:19 +0100
Message-Id: <20261119-alloc_tag-v1-0-efcccfd3a9c9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXM0QqCQBAF0F8Z7rMLzoZa+ysRsU2zOiEauxaB+
 O9SPZ6Xs6JoNi0ItCLr24rNEwJxRZAhTr06uyMQfO1bZj65OI6zXJfYu6Y7+DZxEjk2qAjPrMk
 +v+t8+bu8bg+V5Rtg23ZSZGd0bQAAAA==
X-Change-ID: 20261119-alloc_tag-57326f1fcc85
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Usama Arif <usamaarif642@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=david@kernel.org;
 h=from:subject:message-id; bh=pTjq0ySpnKkGB96QfwvsYQaekk2YVWDvbC/xe0dtpSY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+7TjhMY9nipNo7srX+5Ov2c6RiDDZepnxXTnjF+20/
 272P6KVOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIgivD/3LRO8tiHh63iFpa
 efzgHrGD6Qc/KWn6v3vsW1grnVt37hwjQ9euXI8qntVm5sfbdpZvbn+UXH+7InVl2zQHP6fPk6e
 JMQEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

two fixes (one for alloc_tag as triggered by slab, one for mempool) and
one related cleanup to make things consistent.

Quickly reproduced and tested the warnings in a x86-64 VM.

This should go through Andrew's tree. No need to rush, it can wait until
the next merge window.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Chris Mason (1):
      mempool: fix missing alloc tagging in mempool_resize()

David Hildenbrand (Arm) (2):
      alloc_tag: handle a NULL tag in alloc_tag_set_inaccurate()
      mempool: account the element array to the caller

 include/linux/alloc_tag.h |  3 ++-
 include/linux/mempool.h   |  7 +++----
 mm/mempool.c              | 23 ++++++++++++-----------
 mm/page_alloc.c           |  3 +--
 4 files changed, 18 insertions(+), 18 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-alloc_tag-57326f1fcc85

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

