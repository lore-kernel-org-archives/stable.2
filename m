Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745184963B3;
	Tue,  4 Aug 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873194; cv=none; b=DJWeOUqSAMupd0Aicx47h8sMyuIl7YJ58AHdVcngIZeDXNf/SdLS5qR2VA/uUx5JOosFBcUWyZelQBKHPov2M22C7DXf52RHj969NA7JiKBba7piq4E88fD9oUOkpX9kWx2JzDkyZZBwAZEDNprAcqWzfO730G50QJDmcXZuMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873194; c=relaxed/simple;
	bh=pWsl4wIOasafXl2iumEbjwMBKmBMIj6G01xeOHJLIyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7zj1WCsLZW/xDAHZM3Nr/gGysvbzfX2hXBeYFuCaMoXRKoX/7TMArcBpsH+XVF8F9L/Sp+sKmxIgzWJqteXd2q22Giq6I3FEo8/Ye3aOSx5FE9D0sBsPxbLy4+ohLqzFwv4Y9/CHHPT19iT4PKMsThe4BuCUw8sGImvrschfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd4Fm1Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd4Fm1Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3791C1F000E9;
	Tue,  4 Aug 2026 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873193;
	bh=LVA/ugoXbVOHA1IF3EQPW02kykwSaxCdXKTd5z8a1N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kd4Fm1HhCwDC70iMv21OF8BUGt/B8s3f+VK3jtAJ2vOKKB2HNOKeGD2Q1/+wMQFY+
	 yF2kyGNf+kzlTIQY2oCr2hdQFOYYoKtPJUIhF2DuS8eg7brvNautvGxc+bKKtyh4/4
	 PceHnrAhyVDPBTZ7j2hTPLBf3gExmFVWcTWlrL090GJwHRw6hhmqZ7oojGwLPd+fXP
	 UzCMtuQkdXCOyoQM+GROtmSLuypC8JnhQCKEip/jDZ1Q4YrxfRCpbjBVAe0pcewORX
	 IK+55WXsqxU+Cwz23lp547q0EPCPM3eliOuLFgJe7ZbwRylormMy44lEJyadLFjXY1
	 CksOLUfjZYHeA==
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
Subject: [PATCH 2/7] rust: workqueue: restrict delayed work to global wqs
Date: Tue,  4 Aug 2026 21:52:04 +0200
Message-ID: <20260804195248.665636-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804195248.665636-1-dakr@kernel.org>
References: <20260804195248.665636-1-dakr@kernel.org>
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
index 3194b9c441aa..b6e02ba427b3 100644
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

