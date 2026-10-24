Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029590;
	b=DpcG3TeukfOeK88VJ4ZkaoGDd7yxyPucu1yDHfOUtzgIhCS1uQj1Fq/VP9uuJUOL2Krq
	 0Z+NZzc5w+j+mbTo+o+oAjyHx1OmHqm5Bck7B+4YK9EGJnT6F/lrhdY2xHjfKpyvl52iA
	 fm7UFchgjIZYppDb3xVS8B3GVfCrBWvVUNTdSOQCcHcjiGL3mgfSrkAIk0YvO2tvrqKfP
	 Pjx8Vu/roDcuW6uSKovEhsTbsRflBusqu5r+XcMWM5NhlfvAtvRMbvBS34wYAZlHY/E7L
	 UkafyjDX598EZuIGJTCaAPlOi3GWc9vhvMV6DZYk4c2Ir8y4Z7S2BZskzRHPqaGEG+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029590;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wktuot9z7JC9HEjcECCdAGMLANdxTN2IQX/B0C8sBvY=;
	b=3YGP0RDQDLwYVQ6v8va2CdLv5Guep+BNqYajYe8MIsWY9QNadL6lhEqEWL2NlulLXfKE
	 DR9aTgg3YIGyNlwGihOb5ZSix7TDjkgc+64JaG00t87OGAhtzp/f8arIKsPEFaSiFrd45
	 yDQZ7m0/AwsFQYAp/sP2zgHFtq9yXv9ytwkv1A4/jDLBGtaCLKaVluYg2K3Jsq3GA4JIJ
	 E1Yf/JKG+j1SCZrIMfCsyDXeDoGJfw/9xTMPFUbpRUuDeBNZN8SBXtiV7ZwHMck9Y5JFF
	 ofXypd2rlZ/Mae1jQoBe4aMfI0lG6oCZ+hjYSCRQ/ZxoJ8hKZbdaKzETwqCbijM0pjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGH6xZ5O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9528606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGH6xZ5O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029589;
	b=z8zTJg8ry6DQVI4l9t5x+qSY6Rz1EeWGHherIxlgAajiQDsLOjYyYfyuu3ItBGKBSlBU
	 2PBCvEgJSEi0DYjjRNqfaKztPCqMOdmfb6IEzzAJH9rRTqlnKW/UGCNadNl3BvQoc03/I
	 0MRruF403fz8E5QWeI9SRPgx0Jy0JYpv8i2orjFPo/+CduBcElvuzYnV4SWmm8EYHFcr9
	 XY6phU1P1orUQmM48MqCXipp+gL95bhGKfsPqLceIepYYkn3+6DHHtysSEOm8dOXVZvUN
	 wbI/5dfkoV2PwbglnEGfknI86KxgQ/xPdrqebhLpq5INCAZdFhvepyDynvJRLWPCGgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029589;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wktuot9z7JC9HEjcECCdAGMLANdxTN2IQX/B0C8sBvY=;
	b=jYW+Sy63TjjMoY7PPU96m3xgjJssi5C/g9vkTHtQil57oJWHXgNQzTggRfj7SYRt0Ed6
	 Tu7lk/q9Oh2ktGQdQcPNpNFkEZ+MQEApkT4OsBHOf65GydqxrlayBMpyxDB89PH+tcpDc
	 x4Ld7GbrSQoRz8bU0u943QkvZ5gMQUiyIiR7Zr00o0cjBq7KB9TQQxeP6FAwHXFqOf5cn
	 Ds0nVgRiDtQr1QDxjNu7/U2XiwHmnq/Dp1YaEeZOVvWBVOAWY2Jv3TNXI7F/mv6OzniUQ
	 94Ukpaez8777yjxjmuPrQFJcAaXcj3Pjg6ffsUs+X4Nm+KRRb8UeB41ZstndELU9PDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F02721F031E2;
	Mon, 26 Oct 2026 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029589;
	bh=wktuot9z7JC9HEjcECCdAGMLANdxTN2IQX/B0C8sBvY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=gGH6xZ5OHQNK4aNX1yKwnRmy04RhN3FHkvcQ8VqNSfD9ox1XJmPIQtOA2XTGOvYx4
	 CHfStAD3dUhW6WdRwHXlh5gPXuhthGEX5rHRS/PmaieHzPxX2hcIKac6+oeDjx3wYw
	 cUl7H/ztPKrWXLEdSYXJJJqje4WsIdxm8q6zkXF646UsET4tpXh7sBhHMSVAci//sR
	 ShZoqUGlKLC5pFA7RWZ3AzY6Ngsz0rnFv+wU+jbgbuBhSIA8SNRV0cnYqZ2RCMsQCK
	 m5Olijwrm5KAs8eC/h99Z/bpB2/aEEndRdlM4efkLGC03QUo0+7xq0RLExIhZSney9
	 UQwv+OUIrZP5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5904444D5D;
	Mon, 26 Oct 2026 15:46:28 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Subject: [PATCH 6.12 0/2] mm: vmscan: fix dirty folios throttling on cgroup
 v1 for MGLRU
Date: Sat, 24 Oct 2026 13:35:02 +0800
Message-Id: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyMT3bTMCt3c9JyiUt0yM10z3TIj3RSLpGTLFBNDC+NkcyWgvoKiVKA
 isJnRSgGOIc4eCmZ6hkZKsRC54tKkrNTkEpChSrW1ALVCrAeBAAAA
X-Change-ID: 20261024-fix-mglru-v6-6-v2-d8bc9d4183c7
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820120; l=1731;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=StomykYfb3/sFZOdoTuIrIamn2Q34stb+/OsW4JO9BM=;
 b=8dvX07Tv7g/PTETOsReRAxCMP4HRJ1TsVn4CcloyMCIkQF1r0FLI09JMOl90IuscEc37Gi2G+
 1rvXY9RHt0TB6/7Rj/wOUZWilXfl1dnbDiNKAt2CoQtv2Rhbg1ApS+p
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
- Link to v1: https://patch.msgid.link/20261024-linux-6-1-y-v1-0-cf381365f30b@gmail.com

---
Leno Hou (2):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

 mm/vmscan.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)
---
base-commit: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
change-id: 20261024-fix-mglru-v6-6-v2-d8bc9d4183c7

Best regards,
--  
Leno Hou <lenohou@gmail.com>


