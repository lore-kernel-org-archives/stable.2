Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFF37C11C;
	Fri,  7 Aug 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121592; cv=none; b=otyAIYLOdzNSc5+H2yeoPHr6RrvfzwJHHxj28YMzlzhpmcW2z8NoBRefMrrSFRPhhZeaJq/Jjl0oL+0+3C00H2kZas388ClvPFAgXKYdUmSpQnGVSAvOBnQ2uEIQN/rjoDxj3mxi02skL09YwOpzC7jD/wIZN8FjwE+KW7QLaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121592; c=relaxed/simple;
	bh=PCxHtdmeKUBVXjZ6z/+UpqGA8bi2tfy2YstFfqIzA28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi8mjYQ+npHjr9/C89xciCk7XLz2Uf4KBkclnD772GVkq0OQWIDlcrOCiDhsm4Lf8RrfwejbugURMdf5AF8BYXjIOps6bjglMoqw5uAiexqyBID2obdeFnq4l2vPl0aQH2PjsrCk63xhNGUusysMs8XHt4tW9yHON/md6imiG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg0Lw/QX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg0Lw/QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B85F1F000E9;
	Fri,  7 Aug 2026 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786121590;
	bh=TuCyYKvBUtBSmQ9IKU9O1/6HYi2d9Xj+Lt3PXMMi62g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fg0Lw/QXoVNJ0XJK2StKNtliv8gkWxtKvDCYg9qUgvVFOA5RStpf8o/qe/QVgy6qK
	 sZoe0xKnVf4WFkyTQ5oEI+CSpWF5y8ROSJFfh3Bnu6/n3tWCql2o3oSDaO6Pye7Ub9
	 e760Mp/R9KNuhSxQ8LH+zlIT5G/V/+pblYczQ4lRXft7z/UaLkTmkFC3JtjGKtWl2F
	 bP3eRaLxkz21HScdsKAbtuFPQi/SImL2dpuhtR+Scjl5nOyiuKU4Ab9hBFb+DyQzM7
	 LApTs0p3FnCBYfbpWD0gNyxG0TheN34kE0TmLXIuFeeN8Xb4lFQFzP0byTbKx7nhQ/
	 j0rGMDgB8gs+g==
From: Danilo Krummrich <dakr@kernel.org>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	stable@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/6] rust: workqueue: restrict delayed work to global wqs
Date: Fri,  7 Aug 2026 18:52:45 +0200
Message-ID: <20260807165252.3849875-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807165252.3849875-1-dakr@kernel.org>
References: <20260807165252.3849875-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

When a workqueue is shut down, delayed work that is pending but not
scheduled does not get properly cleaned up, so it's not safe to use
`enqueue_delayed` on a workqueue that might be destroyed. To fix this,
restricted `enqueue_delayed` to static queues.

This may be fixed in the future by an approach along the lines of [1].

Cc: stable@vger.kernel.org
Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/workqueue.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7bc07ccd1ebb..399d2ed24135 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -302,8 +302,15 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
     ///
     /// This may fail if the work item is already enqueued in a workqueue.
     ///
+    /// This is only valid for global workqueues (with static lifetimes) because those are the only
+    /// ones that outlive all possible delayed work items.
+    ///
     /// The work item will be submitted using `WORK_CPU_UNBOUND`.
-    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::EnqueueOutput
+    pub fn enqueue_delayed<W, const ID: u64>(
+        &'static self,
+        w: W,
+        delay: Jiffies,
+    ) -> W::EnqueueOutput
     where
         W: RawDelayedWorkItem<ID> + Send + 'static,
     {
-- 
2.55.0

