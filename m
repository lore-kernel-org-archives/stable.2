Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029702;
	b=2/w99kJWvk1uK4QF3+IDisw7o3pgFEMzBUciUO/Vo1cO7PWNDM0WcwYxSlvZsE5MfmnJ
	 oUJUUq5oA/BuN95X9trBPn39MzXPelwo3tWlKHA7RSxtmOgIktD/QSsj+Rm0I2lO++Uw4
	 YZTpWEjkYiUSQ+gYrPbLRO+/9JiPmqNpincH7hfwHcvuB4/g1Gz5qtNzpW0AJ6WDQTTMn
	 x+L34L6wv7I63wGYa3TtN52+bVQIyquZXtJM10MtIZAFHYElxGAOIo3snrF5VsoWDBsfW
	 8OyzEdDmNtGiIze9LKW5mr7GaiK7uN0HsWdidb+G/mLx3apglOQmIRURzypvlicfRJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029702;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=a3Ye9mFb7l6D+kBdJ+R5ToGzjjZYmuGyh5Co4IecQd4=;
	b=XnZQEkhERfvKnUuB7TXQ0wVEHJySCQ/VSjRvYSJY1E6VMqhhhKWl1CbYb2vak52A3988
	 TyxvpFn1gcgkHaIbzd5TN2CtvxzziTRg3NsayzZCDenFB9u32SXIUORfJ4yCZhxHpbq8Y
	 LdkHVCxalQkWrcBLnELFaXIgCQhTlBa/5ILmQlHQsVkkAubcrSz3BhB0Cx5XeIRqWInPR
	 IIleBSN3hlH0WpKN0IGT5IoFjbsPp6UDy5L73XRu7D+3xGvx6wwGf8WjhUajEH4Fq0xUm
	 TAw/YN2wxcRGzvbA4Sj6pZQVeYs1yhOvy/ooQwK0IZfH9CEpTGhSM2qpcZFcvjSBpwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq9ENChn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4F606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq9ENChn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029702;
	b=OFxrG8hN5RsnNuI/6tlLdBci1Y6o4/t3hCytKG6ajBE+IvfxgC/nzRN1Op3d8f1U+wLJ
	 FzS/r1lLmpMza01y8utYlr/wchUtFNORxlZ8Yuc182jTDEuiYsEKwek6vNLkgOniTGOl4
	 BpDYNgvyt3K4NAff4tZWRO2YOyQHwf8ElcxncoOwHWhPxfqlXkp4iPNhhNLVE5Lqs5939
	 twuhKV45tgdCtBQv1jO5SMkRYfezxZnE/V5v/9jqrZ9cvOE4mOWu+4OH6j4C0ppBv33lK
	 C2P8UW2VyiJedEsofMGlSDpFp7/GRyuwR0FfmVlJLk2HHRor48DJe0s647eusqGn7+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029702;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a3Ye9mFb7l6D+kBdJ+R5ToGzjjZYmuGyh5Co4IecQd4=;
	b=2vEQnJPBtfRPovTaBJUOSqnbG7wruQLIUPcAuiSfylf9mLRs1MKpWPq5VXUJlqt0q+a0
	 6u8J4CCfJNv69TPwB6COnSYxpeAKl23pU4pQ6LXZEJRhiA47Jwq8OjXuD41JnSnHwhHwA
	 9qMrUYorhBKun8+uvBKRTDJemGPU108v/Zgy4olWVcYIjt30jNZ0H3xNNMj4sbt3DBC/t
	 SeI7RH7+h13PqnLZeUFjw2YAmIL1nZPLs2b7JgKa7b+Hco+ElO+I99MACgdP3Gw9zT8hQ
	 0mT/dZWDc0BSgdKTLJyND1DxPGinMcr5dkym16PSpYJDlK64pMgz+r5o8AIzHQyu/bw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7279A1F01825;
	Mon, 26 Oct 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029702;
	bh=a3Ye9mFb7l6D+kBdJ+R5ToGzjjZYmuGyh5Co4IecQd4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=nq9ENChn9SQwOXy8QmScu57CkxMpPoplT14SmU6vlC77z9558rRmJI9X5aLT/xe00
	 KV3kX3NZGY7jcnxAXUmyPgLiFBrjyHPB7m98sPQTwri8QHxHbvahWJM3syS7CSgUcA
	 s4M7gmBWA0VkkopwHHCIylTZ0zUy5Kxo9FTKQm9aHsmfxxvqYyKSGHfLkEAyeCtp88
	 rfztBLqgeg78HXQjeLX5DsQolGPNP3rJpst1PPp5U+FClC0oZZJQMK7kQtvV/4tXPN
	 jzwdAjiNLLNAiA1SGSOzxfmhNp4txLyH0FPYJl7GSs7OpJa52+ZpTJG2i8FlwwNFg/
	 50mrm5s280dzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E4DD644D5B;
	Mon, 26 Oct 2026 15:48:20 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Subject: [PATCH 6.6 v2 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
Date: Sat, 24 Oct 2026 13:37:24 +0800
Message-Id: <20261024-fix-mglru-v6-6-v2-v2-0-6ca69ba6e9ae@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NPQ+CMBRF/wp5s4+0tangpHFxdHAzDFAKPMOHa
 aHREP67BXfHm3vuuTM4Y8k4OEYzWOPJ0dCHIHYR6Cbva4NUhgyCCcWZkFjRG7u6tRN6hQq9wDI
 pdFpKnuz1AcLuZU2ANucDbuf75RqpWEH2q9xUPI0eV+cKN+TGwX62f8+3yZ8rz5FhotNCsiqtt
 JCnusupjfXQQbYsyxc2lMWFzwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820248; l=1953;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=wiZH6EVRwOnlRNo/NR8UbS+l5zDK/ZcJVhP21ClK39A=;
 b=ZGFg42OPIZfhyJigfHjgwxQ/nUqvy1DR+EVehQetAL/Niv952Bzc+JW9rpl2Uq2ZxTHfhXEVB
 +f6amc7smXBBdbgn+jbYhFvXHQ8TRE+z/MKez7Q76Cfc7g9lLj6XQci
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
- Link to v1: https://patch.msgid.link/20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com

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


