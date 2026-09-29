Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D54F3903;
	Tue, 29 Sep 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674542; cv=none; b=K/4bycIkqstywEnWe3O18VPpTdD/DOcmseAWglGNAECh4MUhyPZ2LgxHgNqYyz5c9QjVNlOE/MpzYcIr00uw88BIvtlCwbIDmYIs3WJ7B/mmPbPKZpIbCqei8/tZbvBRKvT0Dese8ku2P/lzXa4VHE+jXCndCM6qnqK3zZnDYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674542; c=relaxed/simple;
	bh=9KoANYlYfsqLXg8+fT/yPciniNgSS5DAVHvviqRdjL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH82czFXJfA3R1acajrspu5PQ9QErP8tiO/1IDyqDcyre4Di3rRLKxUa7FkJnva4udLep0+Z8Rz3KCGn7DQkT44Y96JOv7zaQav5hli1AZ/FnPqySg9tcH6OiS54vtHdxa/f1ogKKuOtiVntlH7gPGlWbVbNVm15Q3mUT+55Jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYIuTTtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYIuTTtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040201F00893;
	Tue, 29 Sep 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674541;
	bh=7G1yc2zk7aOckaciqMEhzZRcM3Dglxw8s7cWqPZm7DY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XYIuTTtzd9D4RkkS95MjWS7WQoeyb0MD91iDGgd68gMAiFo9l/B1igcqcxLQpj1He
	 26h015tIXCoiyqjT6siWgcvJKPaiNM/+FigueLH634nQBVQUdGfeDWumMgHcJsSBwU
	 N7s8WTfyYxudh4XD+9LRWUBEOno7EpuxyDEu31DNEyKyTGbbnhj+RCYkvrdOqQAXs8
	 /EMBniIVgIskIML7sckVZX8mRKoEAvB+GcZT0dCKUXvKzAkbb00/+qBxL8LNbLmY9n
	 WxEL2klUzg2nS+n3atFmhgmj/uiQbypgNv61Tz2M6ahzOtdP5vcRrzt4GcMjczgXb6
	 LacKhK9HuWkWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:07 +0200
Subject: [PATCH GIT PULL 9/9] rust: block: require `Sync` for
 `Operations::QueueData`
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-9-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=9KoANYlYfsqLXg8+fT/yPciniNgSS5DAVHvviqRdjL8=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YbOffA3GVU8auETsDL17YVZTxd+s1QH7rWF
 dK3Lo0ORg6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGGwAKCRD6UCkIqsW9
 0IocD/9oclWsJ7Jt3CRC/AFEkvompw12XVFDBqyaYpSpCfd4c+JVENx3Lo4Q3iR2X66KCtPUt/v
 3LX1hA/Y1dpb7eCU7kU4z9LxtcCiusqS5uhyDjf3idp8UqBYzJTWMBfbkpqgnI+RN5/vTCl4yza
 TCB6fkDBsU7/tHdDG++AGSU6gAYfba7My7RxQrLt/g/dIY22PS6RVgkbGaylCJHXnSM597Q7f0i
 Sko9j51PRZgUf6hGSkbWFpgUZkoFKCLsnIeM+QLZ2tK+4Rgl1uusm+2PDQbTWNlzaiKrVhhvbza
 GgDmkz71bI/PBuMQf/7C844QcGc9t1Ev0hAP+mZklSoJM/PCxyiFnyYOoeDMKO7XLqQFlfirQOw
 3SsoUpi+4lMRwOGWzJUbSNGFprRZzyWOO8hoqSYf8fr9vLcYDtD0iDH18qj3rEDKhltEZCi5BCE
 XLiy8ouImNukGnarLui+aYgYLomep0cHloi6VNNKtJtuQ6sPB6nopw6MNYoe0w7CPkt0eezyRUL
 6ebhDmHaYsm+RpmR7/WEJrzmT/FoUmilFBixfnpJ4IwAHzLxr4zqh2Q2njo+W9vGGX/cDzP6qd6
 jjEiLEBPtRpipyg4B7N0/9Zscv55VmRAGSNg9VZf3I5AcxgZWOhheL+6nuUIC66AdVBzGBjwuWL
 HyuJOme/dKHT9Qw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The queue data installed in a `GenDisk` is stored in the request queue and
handed back to the driver as a shared borrow through the `queue_rq` and
`commit_rqs` callbacks. Both callbacks obtain that borrow via
`ForeignOwnable::borrow` and may execute concurrently on several CPUs,
since the block layer runs one hardware queue per CPU. That means a shared
reference to the same queue data can be live on multiple threads at once,
which is only sound when the referent is `Sync`.

The initial `GenDisk` private data support omitted this bound, so a
driver could install a non-`Sync` type as queue data and then access
it concurrently from multiple CPUs without synchronization. Add a
`Sync` bound to the `QueueData` associated type to rule that out.

Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")
Cc: stable@vger.kernel.org
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://msgid.link/20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index b9ab0e6102a4..08111d8368eb 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -36,7 +36,7 @@
 pub trait Operations: Sized {
     /// Data associated with the `struct request_queue` that is allocated for
     /// the `GenDisk` associated with this `Operations` implementation.
-    type QueueData: ForeignOwnable;
+    type QueueData: ForeignOwnable + Sync;
 
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.

-- 
2.54.0


