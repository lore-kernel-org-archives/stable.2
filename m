Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686831;
	b=Pm4O6qlXKm0HblsoGZm0lreF3sBt/RAgPRoTqLUB9YjGDRX5mk2Xt58qDDqcacQJaUUX
	 FHNApjznQFRrcl7eA1Z2lxTw7SBAWl/pOEcyv/HqLVvFCi3QgJdVokHjfAqgsDb2cQTq/
	 SjszAUmhHdIA89nocYQWyW3HuRcPZLZ04j3XXufxOTmDETiPhFP25YQgr2t80EL++Ti1j
	 NtRWNGhUIXXazlhSVS3urwwg79y4pqjEXuUSxWoHiEQ+zQ4FdeJ92o60iQld+vCworoer
	 YdENIHEtBCPVK9tVYrfneYV5X/5YVMBFhXype5bf04v+TeCTg3b6q4BE7oSkt2ZYE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4LB3yQ8An3Y0YBQjJWN7gTJw3a9Shu5jG0BjthZZNgs=;
	b=qu4N4KdfsIdJnjmziKyGccfAu1P1DvAw0NCw7noN+iy4ILu8mYaQOD4eFmLt9gmO4MgG
	 379ROCK7tz33i2ToiexY5ckREpS8OHY/Jll4RUyRg8BvM7+Grgf932mgfJcnSu/PiPZjp
	 3yCoXYYWZw82P41tkgrQQ1M7vzlley6UQvmH5l7xVYqSFy97ML2pUPNb/rE5dUAay0uUo
	 AFmEFYJFCRAuniUKI/FbvOtvKm4jx2m9/jjuGW85bxSMVplHtu5X+RaNDcUteUlzVQJ4c
	 OrfhjWWYWXPPON33G0DDkLw/Yxz1M7h/1iqRRc9tN4UtBKAoO4hI21lh47XzcmqMCZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XI499JC7;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B064606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B064606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XI499JC7
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso48075335e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795686829; x=1796291629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4LB3yQ8An3Y0YBQjJWN7gTJw3a9Shu5jG0BjthZZNgs=;
        b=XI499JC7QGhiiviqriPz02cY8H0QPRkH9lRmfXnNY6tIEKpIL1DtJU6JULMCmi/r9h
         GID5FFHreb5jJ9HZRQYN2zKfOCGSSMT3QkzdcT2tOpIIqyuTgtkQd9JBaarhvlOfRpua
         95nFIEBqrbFrdI5y6p9uM3NjleZNkTjqG5+itIo8eXlK3OqV5bqpLyJiesYtjiP9ANGw
         0aHS8pOFGwY/0VY597tl178kL8YqzeDHSW+cdV3z6uAP2FCwr8TpFOHhs4ABMeB88hqr
         JS4MFnuqZQFwm3CJuDXn1JMPVV6py8OA7DEdWUerWlD8XyvN10TRLcB0r7qUkJXCNOVx
         /Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686829; x=1796291629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LB3yQ8An3Y0YBQjJWN7gTJw3a9Shu5jG0BjthZZNgs=;
        b=c/4Q+c5eoGAN+hvJL8sTWu+izz3yt1nzZkAKG0kF/4VaCzs25y5slrgcyRR3PQX2oN
         2FMyqVVnlRypT9+a4A0uaxV69o+Sm9BPHxjTRxzuKrwCy0YK1RdGbBS9xPc1FPNxvuiG
         bvNDO/IrYAWe0E+A3P/Jg5rSkLZM6aXveq0UYWC/lIfZCb/WiOp6az4ewQolRoIMDeCv
         pHqQ4hFFgunO4XEeS7c05aIpJf5iw7YLkYT97epBWl4jsgeMnegVFk2KobkL31C/PJhy
         3C0fZovh/0YnuKfUsh+BRBQ9RrF7qdnXwTDmsR0zopThaM8rHB6awUYMxZ5ac4BCk2hG
         RJqw==
X-Forwarded-Encrypted: i=1; AL+hErFnvv7h6ZD1UKWxcTXvuHnoy1nxNAh7QdMcGndA6tVHO8ya9qqo87ZAlDUlXIAinMCL4l0K4VA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BJ4pUEweiCuxIAgfDTQXCSdwij3XsgdKkFTQwMccNJPRWqqY5
	RkEObDGY7EjhjD/eIubMm5yWAjyr08dUNDRN2+kgse3Lc+AftBnEfdShjOLiEXCklFHJYdlt7hu
	etCbkdqzUqODd+wd/4A==
X-Received: from wmfq11.prod.google.com ([2002:a05:600c:2e4b:b0:4a3:5dec:ff72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:18:b0:4bb:9001:1aa with SMTP id 5b1f17b1804b1-4bb900102b8mr290353945e9.10.1795686828817;
 Thu, 26 Nov 2026 01:53:48 -0800 (PST)
Date: Thu, 26 Nov 2026 09:53:40 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+DbkYXvml6s4B9GdpXkb+BI+SGj5nNXm1abdMi6aNsA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCAGp5pHSSaJHP6p5NnJfT3tuspVzoxpjamyaH
 aDAPOkd0o6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgBqQAKCRAEWL7uWMY5
 RvI1EACNCl09Z4znAbCNhyokO33ghP0zKUfMQmPSpNUfP3nlY/7v8VxmUMeWd3Ph8t6++iQRT87
 nd+kjy5B9+NUPeFLhSZoBYlYGrcQfYUPLz9ZPHmDjWoiZGXS/5TplPPcT29VeXHeb463/GRQpKt
 i0jVDNsjX3kLBhOl2xM+1hsv1MYQKig/qZ15WPbpGGcvwPZX4ZB+FyKSrWhMwEnu2yviUJbOxrp
 ep7Gf/T/xmCrGAY34w/phyqjHkMIIW8oEMe6SI5P7zkd5tXk8FhE/RXbMCY0jvarmXD+6WFXVeS
 2Q8MIXLzxn5QDUhRkmKeURNoJGaXrAHp1jrGtdENze3JpmywJLgwz0W0YUvf6O7g9250kEEdbBw
 Xew+p706BEkBUjpoOYZ3cPW/8dYNRvN1aQPvv4DnnEDvebhl+Aranoiab74M41d0XmXuaUz/wTH
 2sGehTMYcE2DuVYYRemUHO5AJm4Tup1fbz8IcVfRFEbJuqyxe0rAx1gNAqiVQ7T5NcwtYrk9sIK
 JVIjIIAdN8U7Zpupltd33spmTWwibYI4oYR3R4BnIcM1QH4aSTKP4F8X94Lu8hZhi6OiyC6Ax7A
 F9tVIc3yLO0kP5a8lZFhNy2sN31Ogcw/qJt6tAEeLSeQ7zgz+3pu/K9IbSbSsmd2bfKKD8PiRpz B2hGtqpgmY0hsnA==
X-Mailer: b4 0.14.3
Message-ID: <20261126-binder-32bit-fixes-v1-1-22fc21baf6f8@google.com>
Subject: [PATCH 1/5] rust_binder: read u64 pointer in BC_FREE_BUFFER
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

On 32-bit kernels, BC_FREE_BUFFER reads a usize instead of a 64-bit
binder_uintptr_t from userspace. This desynchronizes the command stream
and misinterprets the remaining bytes, causing subsequent commands to
fail or leaking the buffer. Thus, read a u64 pointer on all platforms.

To match legacy C Binder behavior, out of range pointer values are
ignored, rather than reported as an error.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index e97213250beb..f23dbe98d688 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1125,7 +1125,8 @@ pub(crate) fn buffer_alloc(
         Ok(NewAllocation(res))
     }
 
-    pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
+    pub(crate) fn buffer_get(self: &Arc<Self>, ptr: u64) -> Option<Allocation> {
+        let ptr = usize::try_from(ptr).ok()?;
         let mut inner = self.inner.lock();
         let mapping = inner.mapping.as_mut()?;
         let offset = ptr.checked_sub(mapping.address)?;

-- 
2.56.1.839.g22a8290db9-goog

