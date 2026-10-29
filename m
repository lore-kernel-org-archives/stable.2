Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793298769;
	b=hnZZKxzYEDKh80o89x3lSlEqfml3S7Px5RrWvHIUErAyrx7UhIoIQgxMsHGi188wH5LA
	 oUgSk9cRZhjw7SVyorVkfUp/6f+6c0duPIdK+NBmT1kUdBCC+kjn9CdQ+sKjLTNBqA3Q7
	 QDqlP5FzMkIAFarmPLD95p8WaY+yxHEoyaH2+jHsYlm4hpdzp0+UJm6E6m+XajvJF+6j6
	 j3JY5pOHH7DnoyEMyPd4HNn7/q8W3huqFaQqbgMhDJhzeFQBwk2WVq4j4cxrD150KAX8s
	 KP5iUuC2imxlRco5x3Y+tDvPuhbm/Q1ZCZ6omaGJOx7jzuCEq85+GfMbyO6NyRkBX0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298769;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wp6+XwXTd4L8v9EYFAYebKPgpODdcdORb1VRJJaJilI=;
	b=nDmUkUoT9B7ayOsFYvSL4qzlASY9ZzQ2iTmcHUd2OSlxP/7xyWBTffzyH/zNFWzll5Io
	 9gxSECR6Uv8XyGVp8je69+XniqMkt/XMm8S44YU8AAADsDDCdlmMOo4ndfCQtLphQI/6Q
	 vj3FkIWkeSCjCS/hrns9LGM2e4A6/zp9ND6bAUNgN5omnFtVnv3foZ0349K73FNVJVQrW
	 ZlAprgumbQPGfWFbFoCp8HdGpORwKPOVFDklNICxpo6mdV7zzkMgqyTkqdCBQDeNVA7KG
	 6rUHvQMevlFLQeeB4YcqfLa0KmWj9x6YkLkGl7n8KsBnFJEjEiaAxgpwLqYkgBZTJyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIZtMquo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E071606A31F;
	Thu, 29 Oct 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIZtMquo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793298769;
	b=UfzzSA6h3AmI8B9bwMxClevpWToSuQqbXJiBDyzHZ1QCoqfJnoLNgKs42Cqrn1KWHP/U
	 dE0yy+hor3Hr12QGLyDx2a0EY7wu07J6zqFFKbNJ2zA7RzAGEq5njsSJ+hcvj+Jn8vHny
	 OVLWqiCYS7NihwBsT0OakZwu4reFN8+G3xIyV5u5p0/nV6OLlMkIQNfWxof12eIsJf8Qi
	 vWQnHXkj1kz40PjEbdsZDVWopjQ4JOxutHbu6lZptDlQMwiH9qjdgXc4TJO0IFtx1ZrhO
	 CMNj2lmfGTuMnpEFSszwbVasAGq6kPenTkEUAcFKMKevMJEpeAkm9TWxKeUOM25Q42Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793298769;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wp6+XwXTd4L8v9EYFAYebKPgpODdcdORb1VRJJaJilI=;
	b=Y8zUMZn2z8FmFJs8N+UuxYwZTYatVNR9R2Nv+ZqLs5OjiorhftwN+7oRhW65fEQpt90T
	 q15PlSPUDejYybAQcNbYb59MhPmoWAiR+shX3cDtF/rzzcIGhimzDBk3DoPP2yMVEfojx
	 fkz1sZEdl6Mw9ub4nnZHPP0lTmYMGFRhDa0RSLgQcHpANWeQ5Sdbhh7tKrTf77AR2+JBE
	 4GVnaxpdzdxWY3d/MExlzK+/ziucbD7ptpKWJLGDpG32v9zBrapZ4iAutjdKMqblAOL7T
	 DZS9dmB0ByqC+rtRkHzvm0Ty4h3eYw4bVQB8w13YZRlXHOHuaEYkBC7Ya6sqIdcjwkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A0B4C1F01816;
	Thu, 29 Oct 2026 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298768;
	bh=wp6+XwXTd4L8v9EYFAYebKPgpODdcdORb1VRJJaJilI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=iIZtMquoEj7VeVqxmdSumgtN1S18W9+BjSOSJF5yXV97GPDhTL8zBgO/7LENNde7N
	 U5AKZDWnKkWm7KLPw/o3kP0FnRzSsIptPFCxow4dM7etrIFfC0X/4Z1+wfOCO/CFGC
	 kBFChpWeZCL+9iULkQeP1FyvkQS4+e6Vge2WrJQ9No/SouEzCXFDhQTUv9qCfKZ81m
	 YIkPa1tDNoHMgmnYpEy7BqQAPvU8is+bL1mKmkD+KrgUGM2vRYr03LSBtGzYobzBWV
	 i+vviaEafPbyEuPfWjUxHSZXBgM3bHgYYhlagDsnsOj2EciJrR4tTVwuRqtOeqIzC+
	 sty5VvQPi6kJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F0D6645958;
	Thu, 29 Oct 2026 18:32:46 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH 0/3] mm/swap, zswap: fix stale zswap data and swap-in bugs
Date: Fri, 30 Oct 2026 02:31:40 +0800
Message-Id: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqAIBAG4KvErBPUwKirRAuzqaZFhdMLxLtnt
 fz4HwEYPSFDnQXweBLTuiSoPAM32WVEQX0yaKmNkoUUfNlNDHQjC2WtcdopLIcK0mDz+AWp37S
 /+ehmdPv7ADE+X7ruZW4AAAA=
X-Change-ID: 20261030-swap-fixes-1aa6c2c1e7f9
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Yosry Ahmed <yosry@kernel.org>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793298765; l=1904;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=wv3cCqMTcjfUYGycGHsVPNfiqXd3kdzJNqs56uK6eQQ=;
 b=H4nxBiyeHaeYaXxggD0n6aJqOAp/dzE0sKP5vEjlbXqvHybzWiKKiK4xx6FXElidAiRXbZqgv
 vJspPul7updDHMMeyka+FAn9lnBoH3tWJNG/rm6XNfePr1wMD0atdSU
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
kept.  I've reviewed them and they all look good to me, so please help
have a look and we can get them merged soon, they are pretty simple and
clean bug fixes patching real issues.

The zswap bug can return stale data instead of the zeroes that were
written, so it is data corruption and seems critical.  The extent fix is
more urgent than it might look, as it can also read in unexpected data,
but the setup could be really rare. The accounting fix is minor.
The zswap and extent fixes affect stable kernels (v6.12+) and are marked
for stable. The accounting fix only affects v7.3+.

For the extent fix, in the long term we might actually want to detect
extent contiguity and allow mTHP swap-in for single-extent swap files.
We already disable mTHP allocation for swap files, so the current fix is
trivial. It seems the most minimal and correct one for now.
Optimization and cleanups can come later.

Link: https://lore.kernel.org/linux-mm/20261026-swapoff-writeok-v1-1-4f4cd420aa33@columbia.edu/ [1]
Link: https://lore.kernel.org/linux-mm/20260811132209.2862708-3-youngjun.park@lge.com/ [2]

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Chris Mason (1):
      mm, swap: fix large swap-in across swap file extents

Josef Bacik (2):
      mm/zswap: drop the stale zswap entry of a zero folio
      mm/swap: account synchronous swap reads as memory stall

 mm/memory.c  | 16 +++++++++++++---
 mm/page_io.c | 17 +++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)
---
base-commit: 24d45a1475dd4c671feb1df705f67ef2fc293969
change-id: 20261030-swap-fixes-1aa6c2c1e7f9

Best regards,
--  
Kairui Song <kasong@tencent.com>


