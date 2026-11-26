Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686836;
	b=TrDU5/96o/Vy3ysgmmGfWm6ed3OpIKNpAWk/k1QwEp3jEstCuyPMy7SVEh6lWiC5CawX
	 UuEkjQO60eZSzo6doYIrZAQ/hjjzS2+X09eNOq62xW25TLTAJqG0DE0YzgsA7egKAvcmy
	 EezpQueS+SI9b2j45wGn/MYq0jXRd85GfoLi6Vgr4DP9wORYsj5t/OV8VP8TAV2t9VR+S
	 TxNk6KV1/YflJUHbBKQTlsiOGChDyle4uXxwXmmszDt0mn5nHqWQ0gPmNnprZQT3iYk36
	 v5HgNRD3UE2rfzbti+hCe6XeLaOU3CR2uvXsjRF1WJvbqE02s9NKWVikeTTuKga4I6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IDO1DgpI9APARYzCkaQJADrFHOCUunA8Ak8bWMqr3po=;
	b=NIVDkM4k2W/4SdA3vFXsdYAwZr1zh1ZXx3K3IwAzcKtPoDnBQGPzTnAlYmwC+AQqyNe4
	 n6UpRGXNrlRMM/tydbff6Efj+aKtGrfPFnZBNV6x7aE91uKKcSRixCwg9SebtYT+T1bLK
	 Vpgm3J20CdPjvC2Z/9QHB6fQSD+JluCxkAnnNOE3BL7NaV75rC6nR4EoPCz69aA8poJ3M
	 cQf8WbRJD5gU0PMyVFBHT40d3j8p966XnyR+SCzEF8eRQ6zgDd7ywy0ioB7K4W6Q4tKbz
	 TUMGuMQ6nos9wCbNi7fTRcUUlodo+GW+BcEORq1/MfE1j+V/4NShZuHKTse4nWho4RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NfvjOA8w;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179160A2608
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C179160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NfvjOA8w
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso3801857f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795686834; x=1796291634; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDO1DgpI9APARYzCkaQJADrFHOCUunA8Ak8bWMqr3po=;
        b=NfvjOA8wEAHYiegdnotBllqpNt8s1Il/Ck4TpJ0zeoo+EQoO8l/6S/4pRWWPLlQ2Fb
         XFXWkGo2ImKch9h2IdNdh3SaQjX35h29awQbp5ALXJ71vFMDsaCwZQTEVPLCTwbU/boj
         E8R1TU0ketVkEuagKrd9eBopHKGSTxeZaF2XAg3z0eTxU8c4Yp4NlGiZ7n/KC5tEqh0L
         fCpFL/6cGvL7V7R9cYb7MQgxg71txIIlRSSeUr8NX56aFKZhx+o3gjp2Uc13Q9tfROqc
         6n1IxKhA+AZowNBy4ZtDbNty4fbVCKV56uLYOO5qnJqKeqsXzQzyeJfAUfoiZv6ep8c0
         61jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686834; x=1796291634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDO1DgpI9APARYzCkaQJADrFHOCUunA8Ak8bWMqr3po=;
        b=Jf2KHQjgoilkqjXmXulPMifZO5MnebpRL9boxO9P14GmqY+BGxSSaJD/eJ+eyuc8ib
         PO0UM+bUBOHPM/7AkOh9TglBVcmP5ebd5+7L9v0R512AQKuQ+1T5wVauB1b4JOxKYbuq
         ls+aPhAVvdGLk+j6YDcvvMKX5Vht5ZtQCjnuoQ27C0V90Bn3gBqNagtr+AwbqVUSENIQ
         rac6Fp3M68QS87q7K9srgxoBHrIe9R7a4y6w1+7DMo4HUXlJibGcsfGkdXAcpqEbe2Xr
         XMgdkBERdPJiaSrJdxTPtLUFCo2+js5xl/KgtHn83oYg5lawqisX63KljS33al1Mo2wn
         w0pA==
X-Forwarded-Encrypted: i=1; AL+hErGek0zT6Bv/owLmLHTNAuwswyOp4T1TcgNW9CioROczOpdAyXI9fCNanLvT4TEPNzEBx0KyBdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bpX82/yf+V8c8F6MMq+PUMqA/38CbimBr/UtZYCPtIbIBC6sZ
	Isnqcmkmpx54riQm5j6xKKOQ/qMOeKcWbS+yH5qUiRKEW4Yky7ESPkhZzU/Jrrv6u5qnQdlKGZt
	2eUx5hrJLXG1bJjvYRA==
X-Received: from wmqj20.prod.google.com ([2002:a05:600c:1914:b0:4a1:f082:d6ca])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4bb8880ef6amr441983315e9.14.1795686834041;
 Thu, 26 Nov 2026 01:53:54 -0800 (PST)
Date: Thu, 26 Nov 2026 09:53:43 +0000
In-Reply-To: <20261126-binder-32bit-fixes-v1-0-22fc21baf6f8@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126-binder-32bit-fixes-v1-0-22fc21baf6f8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GGKpNFtdNjc+LcKkx0pTefXeHsYa4bGSJ2E6PL0JfXo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCAGqzXMj60HX+qzgp+9zDEB0bVzE84ilL5QNw
 5veUXMFCneJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgBqgAKCRAEWL7uWMY5
 RuogEACzWg9d5dXiuh3mK5TNy42Xp7PEM84elJE2waMbMHMTounbJfZLik8LqRrcXpChbG58qHk
 YSAQ34fd/nwROEAvn8ic9eIZrzGsv5JiSXHq0hdpTX5xBzrbJxZYsbasNfBzU9+WM2PLbvQc1a/
 ikRFCI7As6JuQiOsI2EPiJajE+pR9RiVRGoMZFZouCniK1C2UBvRFwYha8VeO97oOMEnnyQJBvx
 cSFh8CEgQnhtZ2EjICZ9c4Xm6wNkcWeNrV6vBlEYpj2bj3l5aLzjgdBjfLHX7WpUhSN6Oh+qcZ7
 VJdB2X596EvBSKQsnljsgY/CCovz+pxib6JX83wXcdzJynhVoV4yWGEivkpBNp56zLz8T9zT5HE
 wQZ+0TRMISXYyoSL+rYvAlAEtcbs9BACO/6Sr/ge2Y+mxetHT/OSC7Bv6KhXGjpzUaimPPHS3mt
 XNBl53bXaLT7GotyhTBlj1DYEe4huJLuj80vg6Ei8gc1hj6X7WwBYJ9mjqhzsAb15FMQBiZxz6L
 EW5+atUNVdG6hzj1APJ+yutbODVpzTA+ZyvtCWIiGpplA3OuIyF0oMc2HUe25VDSTo/Y2mXuo8w
 q56kBRYGfipM26dnvtHfqj4pgkMgsYf6hPs1hpiZBnYlAdN2Ze4ZRHwxuEUmhLRZc6TEEqH8lOx z4bJksbM7zZ0mNQ==
X-Mailer: b4 0.14.3
Message-ID: <20261126-binder-32bit-fixes-v1-4-22fc21baf6f8@google.com>
Subject: [PATCH 4/5] rust_binder: align scatter-gather buffers to u64
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Currently, claim_next() aligns scatter-gather buffer lengths using
ptr_align(), which is 4 bytes on 32-bit systems. However, when userspace
computes the buffers_size, it assumes the kernel will always use 8-byte
alignment. Thus, to align with userspace and C Binder on 32-bit
platforms, update this code to use 64-bit alignment always.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/rust_binder_main.rs | 5 +++++
 drivers/android/binder/thread.rs           | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 9070c1c46a5f..c143ca34b813 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -300,6 +300,11 @@ fn ptr_align(value: usize) -> Option<usize> {
     Some(value.checked_add(size)? & !size)
 }
 
+fn u64_align(value: usize) -> Option<usize> {
+    let size = size_of::<u64>() - 1;
+    Some(value.checked_add(size)? & !size)
+}
+
 // SAFETY: We call register in `init`.
 static BINDER_SHRINKER: Shrinker = unsafe { Shrinker::new() };
 
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 23367dfbf393..a36514e0760c 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -32,7 +32,7 @@
     stats::GLOBAL_STATS,
     trace::{trace_transaction_alloc_buf, trace_transaction_buffer_release},
     transaction::{Transaction, TransactionFlag, TransactionFlags, TransactionInfo},
-    BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
+    u64_align, BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
 };
 
 use core::mem::size_of;
@@ -213,7 +213,7 @@ impl UnusedBufferSpace {
     /// into the buffer is returned.
     fn claim_next(&mut self, size: usize) -> Result<usize> {
         // We require every chunk to be aligned.
-        let size = ptr_align(size).ok_or(EINVAL)?;
+        let size = u64_align(size).ok_or(EINVAL)?;
         let new_offset = self.offset.checked_add(size).ok_or(EINVAL)?;
 
         if new_offset <= self.limit {

-- 
2.56.1.839.g22a8290db9-goog

