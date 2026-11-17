Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938227;
	b=jh1loKnqTwVetVS36aEmtSJP/z6nIXkn2iDSCVNvwmjuco4B3gkMmUixE22qSJpQCNYJ
	 z8FsHVTRwfYnSL8QCbyw1UNLhfPA9KD8J52eWR0c5WIuZPIULrsZdO7kpicz+Wv1J8bmo
	 NCd4ZBL6ErtUHmaZ+wM/3qlmLKKr0MOZNmfb06ZZRPCS88xKXI2iYpNuryBlKlsAjVEG1
	 WKQD0EO4ofoTk1S+dWEZpsh0Y3ZrZelAm2FCpxtm9g6FxJZLAmxPY2X+fcexd6jq4FOr8
	 D9g6UUkDnEufLm959GDxrS2BTDx4eo21LsneaaTLkzweLqGQ4eieYuWtKKej2hZrVPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938227;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hC5KEawRSACiOVREXaGZTEtrXa+nWN81A4O1kNUKIpM=;
	b=5izWkcMOCfOfo82aIo2vkebyVZCggiX4I8CKKRP+QajFz5tg36Oq6KMGRXMXfznHnKbW
	 PV+M4QiSuDQSY2TByNO3g/K+3jpMily1eRjHXe1MWvKTVWECDJ6dmLzXRiSmZN1wHLctJ
	 WORb5n20G8pTZnxao3auZXUdg+T1TkJ1bDyddyUcQeShavCvyYerxvUQMOI5Qp0qLEsUl
	 zKMHBwoNq2PZ8PBLdgV6xpZeIjGRWXLmkiKEfcYXGlTbH4VAqssHPT8XA2yg+jJwjs8mZ
	 AnVRt2XqEwUxr1DQ1wjZLJVXfepL0kx/YfmEzONvkDGl0mZLT/zc5+YnQJA9QUqZVng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf9cqvoE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B0606A331;
	Tue, 17 Nov 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf9cqvoE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938227;
	b=WgqREqMj4+t1w1BwZQw25iNATnXVtYP1VBxrMAx1qcLXF6IQTJOAmUtd5Y1eoDkFlIOw
	 zdGXFyAugf37yBDr8TJ40tafRFg+xs7c4JELSZnFarbG6XfetD76ruU22BHyzTULQZj2D
	 jaC9txqm3gsQiLlze+ODrIIJvZmYNwxa0GLi6hWJPbmlherg8TIZkgfsKz0sET+C4AVMq
	 naz7IM+MNPirdGc9pxg+Q0qJ7D7409rccD40ooAUjlsFxUR+5xE9r3YVw0Bin22IZNx6l
	 l3xa7JwJPPPZyT+g0oVtiVEk4U4NegUS7tWqLzSMd1EEVhOTB70E+QkAKdcWCAtXVug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938227;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hC5KEawRSACiOVREXaGZTEtrXa+nWN81A4O1kNUKIpM=;
	b=WocTgkUD8GGDvSqdEB3l+tWBC+5wyTfXBBT6PdiCsr+av6NTcThYy0QMtMeyBW0Mqt41
	 VUm9zUWYCVb7xyaRMTW9wf6rswQipBAZZ57T/UIKxHyGM9S7upljeWDRjnBDwPS+VPVj1
	 s3NncrJxu3OJ2PuoSEpC8bGslY73HgwO8RwbYFYHuokrjdudjtu90eHdPuffqWd5xxPxH
	 dQ4g7uwYSap6qeAUlkWEbHLu6qBhAMwU9Ol6fGbEyOl5R0o6KlqPcgJK0x3/jqPrgEgnn
	 OqFL1ZLVZ3NveuwHCk77DwxZcGn5Ca7hjzgJaEmuFyLBbfYoSHfmlhTZxb3p0xPF8+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 54E061F000C9;
	Tue, 17 Nov 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938226;
	bh=hC5KEawRSACiOVREXaGZTEtrXa+nWN81A4O1kNUKIpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nf9cqvoESUTWYJ1HBE6isP52hxwrzSL7fwr1PtU7xzzPHLND/lusQUuTM4BQqzAx0
	 SMoUas/0PMO7r2knddS9caXHXqEFmHMXkcUKiATYl54PFlxruhGqJ7q76cUYk6WV9k
	 2DSf3T0KWQJlIymiOgj+Cyg5XRX6p/HV9NZedTH9oLTDpqGsAQUcBDYd1FZ3Muk3Eh
	 6sHUAYQ6DoSfe1In82HtO/YEMI+ro4Wc3AP0VFvTBkSXQTbN/K5GJ8u0ncc4q0gOgn
	 j0K+lrZhC+A9EFxMXos6nZNKJTTdZl8YOqzRRV+7/tRCbU9Ecn80zdDpNqqCxlJDiv
	 Q6TcagP+pvTcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D544B4AA34;
	Tue, 17 Nov 2026 17:57:05 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 18:57:06 +0100
Subject: [PATCH v2 1/2] rust: str: tie Formatter to its backing buffer
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
Message-Id: <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Georgios Androutsopoulos <georgeandrout13@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938225; l=1630;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=pk/XTxsT2Cck/gs1Jsjp5EjCnE+z6vFIFe6DZRaRaow=;
 b=UoEl7Jj1iJ543UmZ3DLnqWPw6c1Qv4seKjCgdMzsZgxf7j+C+CMr64hZ+7DDXKBoYx7hRigaY
 L0xurLXmFn6C9QfFLvxg2XjC4XUGNfPCGKUGgU4BUqAmz3L4JsVmBxm
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

Formatter::new() returns a Formatter whose lifetime is independent of the
borrow of its backing buffer. Safe code can therefore drop the buffer and
then write through the formatter, causing a use-after-free.

Tie the buffer borrow to the formatter's lifetime so that the borrow
checker rejects such callers and prevents overlapping mutable access.

Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&mut [u8]`.")
Cc: stable@vger.kernel.org
Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1261
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
 rust/kernel/str.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 644b4279a..e5fe84eeb 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -645,7 +645,7 @@ impl fmt::Write for RawFormatter {
 /// Fails if callers attempt to write more than will fit in the buffer.
 pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
 
-impl Formatter<'_> {
+impl<'a> Formatter<'a> {
     /// Creates a new instance of [`Formatter`] with the given buffer.
     ///
     /// # Safety
@@ -658,7 +658,7 @@ impl Formatter<'_> {
     }
 
     /// Create a new [`Self`] instance.
-    pub fn new(buffer: &mut [u8]) -> Self {
+    pub fn new(buffer: &'a mut [u8]) -> Self {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.
         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }

-- 
2.56.1


