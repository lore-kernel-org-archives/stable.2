Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633276;
	b=tXNXRH8ErPDvGg7O9IbOUN+6bAKGSyoDXEJOnrhxo7Bg4DaIREl/dyF4suaFm4CsL4NI
	 Q+tZYsHKLTVs07ea2rA8Fstp5cknbK9Wtiw/vdjMFRZoStdv0W2MbOTmYf/Hj3TbyVzoO
	 TXlx+G7UKYSF8xEX1+47pErZUx7p0pw9/8gtQcsSLDjl4/ErniQ2XS3YnUpHgVQcrD6vg
	 i+2+NwpGRpUlWQMHUYrZaHbzsLf4jkknkivtpZMHNkXR2viTJjI7y427dDJuk/srIPYNe
	 2rWdtQ1QiVHegc8IfMwINcx4JfRfnnIvLngKKLtTgduOCRoPDR/gEVb/VLn18jehucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=le3Ad/W7wMBCh88fVeWo5fzPhFSsiH0B5r7LM417gRg=;
	b=XvLWEDWeGJmHIZiZ6u2fd2noXw/g48KveekleNTxio9AN2yLursZGG38BwITig565rEV
	 Z98odQkoRfzGUghoWOAptPuAJBdnPsHuCzVv607Ro3jHvtrKArQNH3VhTFmwuC8CJt1zn
	 yrWCgMnXVxhRWouDezQ7AbOgS+fS8PyduuH63395ierA7spjsrOOAwO/+vtsOeXcP0fU+
	 1Kwr0XNoH1KKB3SipGSiRWir+2M5s9i3kvciTvUfO90qTA1j5Lok2jFnr+ZVdK2154JMO
	 15ovHZVRywPo2jlTaN3JdlpfPSDbll2ytvfrAERn61emFaA7lKrFMy8K/y76snSAtog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS7VcYbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715F606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS7VcYbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2362D1F000C4;
	Sat, 14 Nov 2026 05:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633275;
	bh=le3Ad/W7wMBCh88fVeWo5fzPhFSsiH0B5r7LM417gRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DS7VcYbOhcoDX3ovFa4dr35y6kzYmuXm/xb7U2B/FxANQwP6IySwMuJjTchUuswJ2
	 TBVS7BfHJoOxigJ6NgJ+SG2mYyGVqechTI8xPfB1NETKcG/WVsneYNQ66s10nHdoBF
	 0H5UPHvxV9NZPny0a23DYbqB3Rq2oFtuwym9j/8nToV6ZKrrrsPXrt3SfzHwB87HaF
	 DuQi6z60iB9tzKmqGGgqF3iIEI9KRfZWeajgLx9rm8N8krz9FYevH+ooY8I1gCgSnt
	 0WD6CJ1vjNy7S1RXMWewtwj4L8d241AhaXLzIEvdIBKTaYk8n34RLPt+OJkcUUaaWq
	 u8eeKzNoPtZsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinliang Zheng <alexjlzheng@gmail.com>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mm: fix outdated incorrect code comments for handle_mm_fault()
Date: Sat, 14 Nov 2026 00:14:31 -0500
Message-ID: <20261114051414.3056118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200745-failed-6.12-f681d4580d5c@kernel.org>
References: <20261109200745-failed-6.12-f681d4580d5c@kernel.org>
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

From: Jinliang Zheng <alexjlzheng@gmail.com>

[ Upstream commit 8e6173ccf7b87c1f855e1ad3d94fd50c51d1f46b ]

[akpm@linux-foundation.org: s/mmap_Lock/mmap_lock/, per Liam]
Link: https://lkml.kernel.org/r/20241213031820.778342-1-alexjlzheng@tencent.com
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f681d4580d5c ("mm: fix address wraparound when scanning large folio PTEs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 38019497d8d4f..4e6c893b18b38 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6071,7 +6071,8 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 }
 
 /*
- * By the time we get here, we already hold the mm semaphore
+ * By the time we get here, we already hold either the VMA lock or the
+ * mmap_lock (FAULT_FLAG_VMA_LOCK tells you which).
  *
  * The mmap_lock may have been released depending on flags and our
  * return value.  See filemap_fault() and __folio_lock_or_retry().
-- 
2.53.0

