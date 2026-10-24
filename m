Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029774;
	b=Xoskao2ZakJDgYZ8+Q+q/slNF1O5bDlWByiL/TaKeVLhPhpTWc1gP6P3o0zbbaMkZF8I
	 dyf+M9uYI9fzVwo9LKUyutcbL5oZAfHjw+DDfwg8oevYEO/TN9WMh1X0lBwoXakkSBs4K
	 f3Ecw0tKGxb+CoIrB0MTcEr7fRP0GvzkMbQvTyUXZUJtmJ/ilf1tiSjWl90oHMcGeGIjg
	 7nnMnW+DlUql9fAWoFTidU9M+dhpZ50/so8zMWwp+KnLzeAJcRRFSLUdWGVTXlxOUT8zq
	 aNunqBZWyBV2kkfSvN7DX6cvPa7Umv25RTyFvvTFRARoO37ci7JGOeDVNKmyniyaL5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029774;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=aI6gzj+iJZKlnopsi6+HmoOYr5YvkhXNqOY2PdAspmo=;
	b=Ilvdh/DmIDD2PMPY7ZKIb2W/QgPAV5IqDKqhtTqu5zpUcHo5tsTmY37wAhHm5GqZzNk6
	 dWEZZPcLEKcADPwMrM5gmpBxdZsXExxpcBkpwyPID+g5KATYmcKDMNMJFN8H8Hz8iFM+t
	 xzyoUFmGLCdiDrBQyeMa+t9z3AvCqdO/pit9PLE1D3H3kgb/oIDTkuTd90BKY5JAfrNKc
	 yLYLOi/j701ilFlTa9/VKJYNIsRMYkA6J4Q5uISRvkc8BIlNPNDuHWQxYJ5b5hH6SN0er
	 6eA9X0nZPe5zCAkg1tzskFEbXXay9j4HfXdd+V4oMv1POixZ4feKw1gnHTmvC3bjziQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN9Zy1Va;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2225606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN9Zy1Va
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029773;
	b=zgdigOxlCgFmLDsMmMOTKFyr2NiayUYePJmtiQ+CVVNei9grwQyCna8ZAohNSh3o8hTf
	 k8ka4BWnURK0wQ62XYWYbE1NZSSi5eKO+rsgdSOqSXJz7O6jj+XvtxPFe65Kw7q8hI5w5
	 9PQBisc9ZXYYnwRMrQ1MGwanxin+HI5FzDnVOrjssE9E+KZXevtNMhzASQr3CIzxSUyo/
	 6UPFRAVAOPKut7xn7b5tccsXd9foC5+DZMhqLsXdTa7Co1TuvjiKmFa7HrnjAkISSqE9b
	 8PmtNu2XZdPfUdCNYua2tDtOomrjNLJOZeNyS32fZygaqDJryqBt5oqQK5nPb88DH1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029773;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=aI6gzj+iJZKlnopsi6+HmoOYr5YvkhXNqOY2PdAspmo=;
	b=Ska59rfRzz/oHV1obtM41yCzx2fXr78fTafU/ZL0BWP1+jfVqw3rAS3snsiJJYcF0S8L
	 dnLXt46Pjz8hrZsZYdN/JapckBduPDk7QsCJEbHN65YWnZIq4IX4RVW3NoqGLDCp54iwd
	 iIG1LWsP+M6ctDaSmlP94jfBIY91cTb+jB5rmVKQyZAnQvsAHrNTvfDb0GkWR5Y7tu+XL
	 hmG/c3D/7o4tSu8WJiXgxsld/eAaJoeECAekwu3x46D85pwgL2SIY0qivFbWZR0BQaKv5
	 GPMBxtHc68L4NobY/H0ZkjA7R3v5gzFyg8YyLAYsimr82/zyLv80p5fFxVV64RqfgGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D54591F01825;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029773;
	bh=aI6gzj+iJZKlnopsi6+HmoOYr5YvkhXNqOY2PdAspmo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=gN9Zy1VahntbaB0uuMKHEXBmDdrn/s0iQw+mx5JjXCgggvCWPU3KkzrjJgPc9maPl
	 kaLsIkqrGjAAuVwGTrAnx0QhVgn4IZ3oyFzW7zDHhEOQlpWnEWPZ5d7F30sH5AiTtX
	 huTywQTusxoUm4IqHEgMjcbERzUo0wWH9Gd6EAMKb4Ro4Ahtad5yUjr278UV2ASnnH
	 y/GsCNVLBgOqG9I432I3bWVFxCIp6zV9mwoeqhUwutIwVt8Wc1IRpY1mB+l2OeVJVM
	 i+N7LTaCBY5Sp1mgygE/PTYfdXggJ3ve58t+TqlMZ70H/i8DvpO33SOBQIJK5vkKqD
	 IFB2yykv6R1ng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 656D544D5B;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Subject: [PATCH 6.1 v2 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
Date: Sat, 24 Oct 2026 13:38:43 +0800
Message-Id: <20261024-linux-6-1-y-v2-0-92958fc61228@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNuw6CQBREf4Xc2kv2oStYaWwsLewMBay7cA0Ps
 wsEQvh3ASvLycyZM4E3joyHUzCBMz15auoliF0Aukjr3CC9lgyCCcViHmNJdTegQo4jZkpoe1Q
 qSqWEhfg4Y2nY3p5wvzyut0CFHJJf5bvsbXS7vq3jgnzbuHEz93xDVglnYv8n6Tky1FZGXKqDl
 Sw751VKZaibCpJ5nr9U+kh1wwAAAA==
X-Change-ID: 20260919-linux-6-1-y-b62cf7668a33
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, Wei Xu <weixugc@google.com>, 
 Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, 
 Chris Li <chrisl@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Yuanchu Xie <yuanchu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820328; l=1839;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=7ZVbrrON3k4kx5LrBKVyBNgPO30Z2rlp/eRf3qHKhU0=;
 b=03h52asE15rJ3tWDBxJCnq0JqADUwRrZjN1Y/t3pYh9tv2ifjz7Qu1KOZWpRh2nqc8JxFdXOf
 VFT2E7KeCfwB0aw0729dJCQBhio62ZSmnw6UgeeEkA1JLDojl6cjXzp
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=
X-Endpoint-Received: by B4 Relay for lenohou@gmail.com/20260311 with
 auth_id=674
X-Original-From: Leno Hou <lenohou@gmail.com>
Reply-To: lenohou@gmail.com

The series backports the following upstream commits:

  1. 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to avoid cgroup OOM")
  2. 13b6b6209104 ("mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU")

Patch 1 wakes up flushers conditionally when a memcg is about to OOM due
to dirty caches.  It restores the flusher wakeup that was removed by
14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle").

Patch 2 handles cgroup v1, where balance_dirty_pages() does not throttle
dirty folios.  See 9badce000e2c ("cgroup, writeback: don't enable cgroup
writeback on traditional hierarchies").  After 6b0dfabb3555 ("fs: Remove
aops->writepage"), reclaim no longer writes back filesystem folios
directly.  On large memory systems, the flusher may not be able to write
back quickly enough, leaving many folios already under writeback.  Since
MGLRU cannot reclaim these dirty folios, the system may run out of memory
and trigger the OOM killer.  Patch 2 throttles reclaim after waking up
the flusher for cgroup v1, similar to 81a70c21d917
("mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1").

Signed-off-by: Leno Hou <lenohou@gmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20261024-linux-6-1-y-v1-0-cf381365f30b@gmail.com

---
Leno Hou (2):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

 mm/vmscan.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)
---
base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
change-id: 20260919-linux-6-1-y-b62cf7668a33

Best regards,
--  
Leno Hou <lenohou@gmail.com>


