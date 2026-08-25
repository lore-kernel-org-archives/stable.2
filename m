Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787C4908BE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671997; cv=none; b=bYe1xxzzPHXxbBIAbZDdHVxCQMzfMI/DIwoPCXWqkh6pBZDIzaupgv7xOmq2IDUTdAYUNKzaxZfxGVlDN/GfXxGMgH1Wnveg8Siqvbj3zR4Lnfvg1v8N8AjNDpvCntLeRXfxbTJVNPsYXX6I59fU2v4Hn7meROTJ/X07tAYVySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671997; c=relaxed/simple;
	bh=gd2im6qVHNIYPYPVwmA/HSX+dgKTmzcAkQcCUzCyPvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovVP9r6T+W2PL238hWLfBKvgeGu+tU5AaEQakuolnEv6a6sJ7JJnVSodTpTzB3SPE7iw+ADzgvhK3S/5Or4M3DiYwBRE4bScqnegtRvjE2HjmVD786yOxif32EtIc7FbcRXDcAeelv4nUiLll7V3Lc5/4XyuhMO4ADxxqvyUevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHQNKQ2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHQNKQ2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC04F1F00A3E;
	Tue, 25 Aug 2026 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671996;
	bh=Wu6UI2AiLa1+8sbPPWf39gn2KwUDFmN4iIQdW5YE6Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHQNKQ2/rrhApeXx3NxYT4NL3izZneBviDzhxN4ZVlJC+laE1B1UKvKURzCLWZ2Sa
	 LiGYnn0MUagNlK0aHG/l/Kgp8EkPRB2C+v6TTcZ+7Z8VOyfm9+VgIzJEmjVx+sqoxF
	 6DqKHsHogtCowTonlgV4m8fqOiizSEL0oq6X66RYdltd/qEhlvKwUOQZr1Nq2ka/wo
	 hH+CR4DSHEgUJW7TGUNsmTP/NF9XHgrhZrrlVatbSwaNV6HLw+NpGVDAjBSUtTdtDi
	 cQkS2AOQ/idt1KUxd+WSzfHVo3kyW3EsK2h2rSE12Ol/QcExOnbLPPSzyGSJ+h8CXb
	 r5TApYQyV0XMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Hoffmann <f3lix.dev@gmx.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] futex: Avoid private hash use-after-free on final put
Date: Tue, 25 Aug 2026 11:33:13 -0400
Message-ID: <20260825153313.4066171-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825153313.4066171-1-sashal@kernel.org>
References: <2026082454-obligate-cultivate-908c@gregkh>
 <20260825153313.4066171-1-sashal@kernel.org>
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
index f43d8c9e28a66..cf9a11c763c6d 100644
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

