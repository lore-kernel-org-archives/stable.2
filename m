Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5A4F85A1;
	Tue, 29 Sep 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674539; cv=none; b=e6dWYdr8PkB6krMCvTzxkFY+eCWCs4k6zmXra/edgr171C3rmmMsyv5pisxtnZJTJW99ohJUf6LdCnIuNheh/6E9rYDvoMwHcMHoDI29+yCXsR/hfRm6MIhFKd0IZqtSR3g5aFeD7Gmuz50bvPZD0pAu/xRoKf9GIfST4gHc6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674539; c=relaxed/simple;
	bh=lA/YsmZhNBagTiygPDyt9qWisD3Cz9W9tFj769pjKh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjW70+3BdtlklXrjFuakxjkCXjbPAIjyidapiGG6hVnj8jNwraZ1g9WNzyxgiQx/ntCFYIWUwDhRrVxUKtVpxtX9PGw6zpoLLgqGd+d6GZ66BcLsrj5RSLNcshgxENRkhIPSf0pqV2FQvJs378NFmd1o9dQiQXCmFU+/vY+6uAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVWHca/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVWHca/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BDC1F000FF;
	Tue, 29 Sep 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674537;
	bh=YDLdL3AeYK0kP5pzBOWUWz5EYeN/9rbmfQ0/zxJlErs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bVWHca/h+K+ogMOmHtvORaY/9lZ0+S8XG54zWQ1fZr59ZScQ5aYnTvzp5yvIqgQVG
	 T/ydg1tBCj0hJ3a6kQ5jdklZtArr32Yek8O8DGPuNlgY6CJlir6JB4oF67zHnIGVLj
	 D9Kwck9CfXlADMEhEJo4ySKWjJ0KcwWs/2V15USux3AIzq/BV3dbocLoH09pCKIuj2
	 psJfkZD+oYpEO/ominTqgkvZjCioqN7KweNbP+1JpCyNAD6azr2tAJbXbhVIWftVAi
	 8B5QPuqivTaEqt9vu7qkXjz3HxYb6JCpX6L40SWp8Ll8Cc8XZUX97Nu/gcZbuBj1r/
	 ZaHxU9HnZY0vg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:02 +0200
Subject: [PATCH GIT PULL 4/9] rust: block: fix `Send` bound for `GenDisk`
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-4-642a4c1aebd7@kernel.org>
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan" <ytan089@ucr.edu>, 
 Yuan Tan <ytan089@ucr.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lA/YsmZhNBagTiygPDyt9qWisD3Cz9W9tFj769pjKh8=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YWGgF6X86oXbFCnL/zxgIAZash9GSX91wbD
 28B2ZZ92aSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGFgAKCRD6UCkIqsW9
 0Of5D/9gr/bgIS+MD079aore4nslUdT74EXGIVMqu+MQz2N4tTwg24uKcXZslECOWgqpbcVsCFu
 ZLxieTc5NCZVSxJs6va7sHUrPct8BbM9JuoAO+RGY7SBqIMjJdqt7/9jVlEpM52sBfZraU3BNg1
 9eRkT+84p3wUUIfX3FroMjsi5FVpoRNxCJPvQjdVEJmvzENEnmWG6pTQ6fhMkEZkS6/AKdBcBym
 nQqALAMPUqzByhxEHvHLOaAXPRReHhup8EEa2qpGx5yzX97oywukoLfnikMjPgmgj+NZ5qTBJLu
 Z0kqmEa0k7PYpF0T+hEMlux9lumtTZmDDt4UEIr7QBOM2ForD3ZgiSQqdeegeKj+fywYOedmppw
 TIjU4Bs76vjBxwI4G2xr085WcQIN/BUMio4jL2AvayP6eb7uQFXTqInp73O72rZUwnoMExEFdPH
 vVi2ignDp/fCZoKW3jkKgmKQ5YchNbsgKVdngF1QaG4ZV9nEqXQgzqmaj5Q1x41JLrEE1ztqmZv
 4wbjV5HIZCjzrR6avZbEhDdHPb6Z+jPUOd5GRbo79jx/ilrqjrNPfqvwipxBfKSh/cKr8j1zlL+
 0S4iuOAJMXFgHJO19N+owJVQnxTYEBVRqSP8cp35uEhgAGLNfIvnkEwy7zzBRKQzNZJSAzQ/afg
 0Pqw9dBNXAhD8Kg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
This constrains the wrong type. `T` is the `Operations` implementation,
which is typically a zero-sized marker type that carries no data, so `T:
Send` says nothing about whether the data a `GenDisk` actually owns can be
moved to another thread.

A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
`gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
`Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is sent
across a thread boundary, so the `Send` bound must constrain exactly them.
Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Cc: stable@vger.kernel.org
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan <ytan089@ucr.edu>
Closes: https://lore.kernel.org/all/cover.1780633578.git.ytan089@ucr.edu
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
Link: https://msgid.link/20260709100100.604252-1-yuantan098@gmail.com
[ Andreas: Fix tags to make checkpatch happy. Change summary line. ]
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 8ec38a7b9815..080dedb5d5d9 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -224,8 +224,14 @@ pub struct GenDisk<T: Operations> {
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
-// `TagSet` It is safe to send this to other threads as long as T is Send.
-unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+// `TagSet`. It is safe to send this to other threads as long as these two are `Send`.
+unsafe impl<T> Send for GenDisk<T>
+where
+    T: Operations,
+    T::QueueData: Send,
+    Arc<TagSet<T>>: Send,
+{
+}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {

-- 
2.54.0


