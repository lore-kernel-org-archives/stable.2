Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF23D9DC8
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670592; cv=none; b=g2y8cln6jBJPqfWtEocEjMep0swarDjZfTJ65/ft2Nexkf99F+DXdYr++HNnfvNO+z+hcBp39e4urahGTrx3w6KPD5L4XwfkkWIg22SzMVtJHlhdQc0YVd3hfO0Toxn/fSMp+LkVUEUrmlycrTpp8+RfLyUBy780Dx7NHCput54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670592; c=relaxed/simple;
	bh=tk/7WcPutfaFSxSjJwnjsrN07czUu7z6FgLO7FNodfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jl9Atja0/eugORoy2iHA6jVQk2ilMGrEpa2zSwvNoxNLED5n4T63PlHro98isc6Cpu0lW699JJMih7ej8JWKed5k3qwzxS9Fo62Y8YEPFKu/Bwqdbq86PeXI/9aU3f6KLqG4bPBlpR+rSpgKIYlev2FK7hqc52jVhV6BBFQH3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6gubTS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6gubTS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C01F00A3A;
	Tue, 25 Aug 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670590;
	bh=4i092qNvyr6LKXYtWxyZqygflcRNhhVHxnp8EuzwG6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6gubTS+U/Ow0PHyjQLEcHdh2YFe8xSY6mTLoZCPaexOTLrdkI/seYkJlpRxpRI41
	 Q5xYEwqWOK5g4Oh6R7j/WoK/MK9BJS5m8qjzrln/AgJBiKlGV3V8XeXidsm49spWdN
	 sQ+coC3vvWJ3mViCy9b6MkrXLKIdLpCKFpwO3on+CYaIsPlEDV3ADtCD7L9qIyooZb
	 XQSh9ERjseD6XPi5gQhudDsu58JfdN4gs6j3mhe4GX7CZ5t8a85vgzo2t4XFiUT+S7
	 JLPrA2EzDNM4kNw3PLCet44Xh974dG1wvKtiKbJpzvhTuX6fsB+7y3OORaG78LywO3
	 eYD3hHXd14Z9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Hoffmann <f3lix.dev@gmx.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] futex: Avoid private hash use-after-free on final put
Date: Tue, 25 Aug 2026 11:09:47 -0400
Message-ID: <20260825150947.4024767-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825150947.4024767-1-sashal@kernel.org>
References: <2026082454-wharf-swapping-5328@gregkh>
 <20260825150947.4024767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Hoffmann <f3lix.dev@gmx.de>

[ Upstream commit 1c7efabfbaf796f11000a46094a69955a01ec6cc ]

futex_private_hash_put() drops the reference to fph before evaluating
fph->mm for wake_up_var(). futex_ref_put() enables preemption again before
returning. If that put drops the final reference and the task is preempted,
another task can pivot to the replacement hash and free the old hash after
an RCU grace period. The first task then reads fph->mm from the freed
allocation when it resumes.

KASAN reports a slab-use-after-free in futex_private_hash_put(), with the
read at offset 24 in a freed kmalloc-512 allocation. The allocation and
free stacks point to futex_hash_allocate() and the RCU free path,
respectively.

Load the mm pointer while the fph reference is still held and pass the
saved value to wake_up_var(). wake_up_var() uses the pointer as a waitqueue
key and does not dereference the mm through it.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260731155024.1150011-1-f3lix.dev@gmx.de
[ dropped the `!fph` NULL guard since this tree's callers already check, keeping the existing `if (futex_ref_put(fph))` form ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cfaa96c009320..a68bbeb2db610 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -149,8 +149,10 @@ static bool futex_private_hash_get(struct futex_private_hash *fph)
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
+	struct mm_struct *mm = fph->mm;
+
 	if (futex_ref_put(fph))
-		wake_up_var(fph->mm);
+		wake_up_var(mm);
 }
 
 /**
-- 
2.53.0

