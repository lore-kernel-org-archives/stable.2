Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722707;
	b=ZTglVgfGzG6k1+TjuaoA9nAnXTk79ro9haRtu0D7dE2HI+2CUz+hspnTGqErdXk08DKg
	 5OjFw5KgcvBWI7T/nIA1n9rGLBxiEFrhemVNDuqg669liho8nrI4H+KnNOJOoc0yX4VYz
	 mhaFvaR+hDued8Xkc9rbloMoH15FbhfdGSfqDyeBSuEt19FmqD+Yb1jvrv5takTbYrxJ/
	 qZPNUDYay6fLyZGIbiBKccBMR3RODjOusonnQ7l8GkLN0dpmB8P2B8JnAEVxO924+2y9R
	 ydmvX0qIkahQNgIrnTRPd/2StLd4z0sPBTPLUTbp3rn2LysgOpgBNx6OYMKuHZ15SRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722707;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=dQIeRuBzui31wbj4eqUyrFMPovSWupke/iiwgt/DWGU=;
	b=jnH0zzvX/ymJerNiOGGJ2cImqXeNcHbc6JtavojJ0uU8SDvpYIPk9MdLNz4uV1hHfc6+
	 ktB8nlW0AByRQQl5O1zntanVrWRSijDh12RZqmdTtiPN0mxMMuuaVSC9w8hNMMtnI4Eji
	 9DYFxPz45olXUBeaAIaulgykqM5y8nKf3w0WBQAV8lti645EaB/RK0AFzPbg4ACT0BR54
	 RJIdN+Ko7N+YxedDF+YKvD2cp6SC8mVyU6gEQ6vC0EI/WajrGNGze8jfi2LaY1/ql26iN
	 HUAgPsmuWAqw1g0i29osMZb/zRYRtEE4zfWbGDjLlpvGfQkCBPZRXv+GE+rMnuXVkWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGs90L2h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C2606D830;
	Tue,  3 Nov 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGs90L2h
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793722706;
	b=dqmQYEgayejhLZs5LR4A8kGi6B8RoAh23yauWT9YPttgWdXI7Vzf7htftGScbQT4qIMr
	 UzrLKFlqJG/H027i2waMxxwcFFZR8Eiz0DZ/uycHbLHgNg49aeaAeuIuphMK3utO6EykS
	 1jtWU91y8IkUAcRjRwYPKI2uHJ4xBHueSTE8q/B9zULWrLerwd1XcTIqQu4nt5rCAo0it
	 2ZRVWDn8tVvOseQM0NVt8Im1wgSvAF76EC+Jk2enEZB0Ci9jJj13mn2URzUlw3O+OL1b2
	 1rnKIKqGYUMJNhOWPxfhIQrBfcN4TgcnlU+T1JLq4U58rLHKTGPWMlUH7Ek/0766fXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722706;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=dQIeRuBzui31wbj4eqUyrFMPovSWupke/iiwgt/DWGU=;
	b=RPBc7T0MxYAK2lYKvIQMGJIhe6XJ6y+Vs2W+EyTVCtQPGt2curMY0/kVfyC8UoyOYdHL
	 PhmQENa1bp8hd2v2j5dT8e3wwxy1evj+diAmwQDMULnfKiKkcibPQRlqP4UWJaK4F+Mw/
	 GicQ621Oj3Y2VIMRplsc4232VeTUAi9kga3V8KvmlpVL8xd4nHa6jZXg8+6biJ/sVNfiy
	 RlwejQxm+sGRAyHkmCOVVtQyhG0R9xZFl+fkOKRpW/ZMz01tffb/YoA9bfW0Lb3nr+Ops
	 TqOZYIM1FcnVT9PZNF8X3nS7ON+I+Cl2qRbkhwDeDmCXQ+RyeHZ9AdH1/9BpBCkQfuA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F14C61F000C1;
	Tue,  3 Nov 2026 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722706;
	bh=dQIeRuBzui31wbj4eqUyrFMPovSWupke/iiwgt/DWGU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OGs90L2hzATcXQP2/bW5+tIP/v9edzhaR7G25KCA14bv9XsL+RBM8oGK2tmj0ZNyc
	 Jq9s+IXMpevV2gItKxcmYozbQ1vS0b/gl0KMiVDW3/ae+plK6nQ65Vg0W4ykP5zMKB
	 oE/9LyLcG6h8lQWHDKG9oP/xnPtXd4Q3lTfmtEH/BZgkdR7ddERa8OHHNQhlFXxsxt
	 bunX7p+lpxYUB+HpNA6Xkgp4Tq8PDYX1nFtUAy61TeIA1k2qKhzjLv7YXJDPROIAeJ
	 MslP9X1HdgfRCSZkFKtMW5zOgmBS1ET/XBNfkd+qwQoTbImQkCw0ZIGSEg5jCJagWy
	 5xEn1dNtrFrJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4BDB446A07;
	Tue,  3 Nov 2026 16:18:23 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH v2 0/4] mm/swap, zswap: fix stale zswap data and swap-in
 bugs
Date: Wed, 04 Nov 2026 00:18:13 +0800
Message-Id: <20261104-swap-fixes-v2-0-204be064be5b@tencent.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NOw7CMBBErxJtjZE/IlaouAdKYZY1MRJO5DUGF
 OXuOKGlfJo3MzMwpUAMx2aGRCVwGGMFvWsABxdvJMK1MmipWyWNFPxyk/DhTSyUcy1qVGR9B7U
 wJdqC6p/7H/PzcifM68JqDIHzmD7bW1Gr93e4KCGFNd4ad+i89njKFJFi3uP4gH5Zli/tnpAxu
 AAAAA==
X-Change-ID: 20261030-swap-fixes-1aa6c2c1e7f9
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Usama Arif <usamaarif642@gmail.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosry@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, Mani Tofigh <mt4022@columbia.edu>, 
 NeilBrown <neil@brown.name>, Christoph Hellwig <hch@lst.de>, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793722701; l=3669;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=1IXCDeRv/bOKH81RaUG8b0PYhXau5ZH24z8Ggh2fGYw=;
 b=72fU0+BSPT24/wFgiMMSDPMJtafBrwKYZufCn/PCHxqYJt/BKlSgQzT1KxbY9WpmInfMdUr8U
 xXQf2kIoV1rDbmcMdT2xv3OSdvIpPAxQKzxGdJFhIcjGi+xEuUMjuBf
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

Hi all,

There are some bug fixes found by AI and collected by David, mostly
originally from Anthropic.  After filtering and dropping a few that are
already being patched up by the community [1] [2], these are the 3 we
kept.  The accounting fix is in two patches now, the second one from
Johannes to cover asynchronous devices too.

Patches 1 and 2 are marked for stable, they affect v6.12 and later.
Patches 3 and 4 only affect v7.3 and later, so they are not marked for
stable.

The zswap bug in patch 1 can return stale data instead of the zeroes that
were written, so it is data corruption and seems critical.  The extent
fix in patch 2 is more urgent than it might look, as it can also read in
unexpected data, but the setup could be really rare.

For the extent fix, in the long term we might actually want to detect
extent contiguity and allow mTHP swap-in for single-extent swap files.
We already disable mTHP allocation for swap files, so the current fix is
trivial. It seems the most minimal and correct one for now.
Optimization and cleanups can come later.

Patch 3 gives up readahead batching for synchronous devices, as its
changelog says; that only affects the MADV_WILLNEED and swapoff walks,
the fault path never batched.

Testing: tested on arm64 with both zram and swap file over sync device
and async device, everything works as expected, no content mismatch.

Link: https://lore.kernel.org/linux-mm/20261026-swapoff-writeok-v1-1-4f4cd420aa33@columbia.edu/ [1]
Link: https://lore.kernel.org/linux-mm/20260811132209.2862708-3-youngjun.park@lge.com/ [2]
---
Changes in v2:
- The zswap and accounting fixes are unchanged from v1.
- Patch 2 simplifies the known-gap note about the unmerged xswap patch, per
  Nhat.
- New patch 4 from Johannes keeps the swap-in pressure window open across
  a batch so that asynchronous submission is counted as well.
- Link to v1: https://patch.msgid.link/20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com

To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Barry Song <baohua@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosry@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: Mani Tofigh <mt4022@columbia.edu>
Cc: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org

---
Chris Mason (1):
      mm, swap: fix large swap-in across swap file extents

Johannes Weiner (1):
      mm/swap: keep the swap-in pressure window open across a batch

Josef Bacik (2):
      mm/zswap: drop the stale zswap entry of a zero folio
      mm/swap: account synchronous swap reads as memory stall

 include/linux/swap_ops.h | 10 ++++++
 mm/memory.c              | 16 +++++++--
 mm/page_io.c             | 94 +++++++++++++++++++++++++++++++++---------------
 3 files changed, 89 insertions(+), 31 deletions(-)
---
base-commit: 0ea6dc8c4a2192227ec25768625686b8fcd5cb09
change-id: 20261030-swap-fixes-1aa6c2c1e7f9

Best regards,
--  
Kairui Song <kasong@tencent.com>


