Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0546AA6B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193672; cv=none; b=TQjkZAZp7kmZSARrdss8gGIZzi3kF5I2WfLKFAlMgN2qSEz3hgkBRTV8FjBBUzw3OMNPktaRdqNHYeomyD9ej1Aervuoih3jkTCkjIXnEIoU0+lC3q+rCH3+Vekn65S70VbSJOAU9wMSMnjwqTb5k1nbez3lrQGUX9jRiqEtQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193672; c=relaxed/simple;
	bh=C/HalkpVc/aaLPRcuY8K3fmDX5xNBnpE2HlADon4V+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nljiTf/eh6XSQVKdiPS7QttB1vLh6wApX5ksCeeHsStUSzPn1id4q4piGkhlRJDdidzqwS9ZgC+do6PEknQdernCd6WACzGQoTDBwRJLihw0YO3ylhDceOel2kK2w6BxIxjlcyfT6bIeXSuDy6C3EUqkLp/o+VWcmIGJCWRZ9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBf94Xq3; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBf94Xq3"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so13921175e9.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193664; x=1791798464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbsBB7teGYK9VKfbxNuqfeRouM1sExnVepBnTLGc54E=;
        b=SBf94Xq3RDkh/2auYXT3fbWcadjJC6vDOa82FcbqK9VBd85xGBwwdDVJ26VbHZu1hD
         cAveRO9FJMVjUISgtHFrJivbhF3N2KGmnKsdTquGdLbzF8pwAdTRmFpBvQYUh1Q/5eVP
         18jFn7cK3O5Y4v5xdXUwndbVAcZb7E1Uglx9jYCVVZV624uf5XHs7oQlcPgsqHkbbf/a
         UjenayaNSCfLX56ZJuSQLMu90o2c2gZJdvQjgpMfMF7D4gj0RD7d/R7o8eUYlxjxWHVH
         hEaxFQVMeY+I8S1iyPiPZmRZu6+qZYwo6Qnl/mGLpzRQ5UDcGuLBiEK3ZG0OTJmCTGtQ
         29nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193664; x=1791798464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbsBB7teGYK9VKfbxNuqfeRouM1sExnVepBnTLGc54E=;
        b=GrMcREytKKR9hNvIIgDaeHqZ70g6ZwKw2PBhCQ/jUgXkqW7cC4zYOgviM6y/oyMGAo
         Fk3n8PhPQ/9HvxTKwS9NBg8P0JZowItrdCY3StZSQarqk9ZXBi3vMBVmvr4gGY6ZeciZ
         V/5bV3P9Us7h7RsjcVzZjqm8vNSk8ElRGYhtmjvrHTNb9uCzCfRNHPE8L41olXAwxa0P
         5hsV2D616VXDxjo+2aiTAKiI7+tmH+wK2JC56BZp232BeVo/3l/ydNYG03YYeQD/yVH2
         qdjGamm4Unw1xgKAGxkz3f3m+1snz5+hnKw45goVNWC9n0Z717b/cvmqEGm5nCapAgDg
         lODQ==
X-Gm-Message-State: AFuF++mNe5mJLoXt/QQo9A2YzG9jx91WAJ3aq93K9bWC7D0FRGFAG1fb
	WiAZXracYRGABXkGri2mXPXGitjk3hNcdx8hkpTQp2IsE4RU1i43bo5Pzew+COHoT298bRBOUVt
	AZTxhDve0lgI5SDHR8r1n+4dnMgmzdGNtjDVxPneDsRWFR2IpDUVIYm+7+j4tduaqkSjtNlNqwy
	bXxfqQ0TSjMv1FqjsVF1/A7ifsn0qUvxVc05am8eBBVKhQCDTwcJpN
X-Received: from wmpl19.prod.google.com ([2002:a05:600c:893:b0:4a1:6fa9:2d03])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6215:b0:49d:1fd8:b874 with SMTP id 5b1f17b1804b1-4a027564c86mr168001755e9.19.1791193663635;
 Mon, 05 Oct 2026 02:47:43 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:27 +0000
In-Reply-To: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/W9/p/qUlI7c+Vp8Q94K4vcY+BU6ZQPqrD1mg6wzcFI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I6RxE3WbmZPE+KA8VBS08Df1RqphB6A+wPj
 scmipIk34iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyOgAKCRAEWL7uWMY5
 RkT2D/4lM2bD7ln830RsI8zOjVjIR67yUnU1DOiP9PrXWtmyiLUgjij5MZRBRIFuxJ9MaXwC747
 mV7kskmGyj9uvZFKnJvyzRUYg4t/1zG45ODmg1PwVqaAHElsUhsSqC/vhurzgOE3P7k/UdqHRB1
 5xuLtTCsYG2ZM9fhMNXCcpHnySjRrAHLuv16C7LfEG9tULS6gRbxa77D+znu8NeBYFdofyrWMkZ
 wIOv6cCyulWeWtOY8ptqMLgxI/lmevH+lQyE7vlEUW4cutcS5Xg0geBO9p1u9ifKkk+SP39gu7m
 dVJG/yw5yYWS3tC2NeCBGalAafbmhlcqwLn5eEQNm0E23dbMfp+1hoi+spu0AeZSF4IDmeUaQla
 OnI5/sxYs342CQgdxiq8IlQZTMDnkrXjkXc9Tylyl7kh1pjyeX8cRPCl4usrCHbmDaA943Qp6ZE
 PYRmxGGBI1RKy817zvidz9/AuaUfBLLIFAnuUB1/hQWI6lWLt4cq9yoP6BmUu126iNH8nAYSGtX
 F7w44ofCMUPStjRl0gggtKU3fBe3NY4mtT6+pSOVR7Z+/v03P7ObrTDZs9q0KOW83F5a84QZS0f
 81CirftdX1+uJMqIe4Kd9EUMxel7HntoeH+Jofo+eVsZqNOeFcc2r5gMQZlQnRFK6t5tjw5W0Y9 j7QQ147Cn4UOvcw==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-2-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 2/5] rust: devres: add 'static bound to Devres<T>
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Danilo Krummrich <dakr@kernel.org>

commit 016267b521b18529c977c9eca9597a1669c3d73c upstream.

Devres::new() registers a callback with the C devres subsystem via
devres_node_add(). If the Devres is leaked (e.g. via
core::mem::forget(), which is safe), its Drop impl never runs, and the
devres release callback will revoke the inner Revocable on device
unbind, which drops T in place. If T contains non-'static references,
those may be dangling by that point.

Add a 'static bound to prevent storing types with borrowed data in
Devres.

Fixes: 76c01ded724b ("rust: add devres abstraction")
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Link: https://patch.msgid.link/20260526000447.350558-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 562dd54fbe43..0fea4f2844a5 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -97,7 +97,7 @@
 /// # Ok(())
 /// # }
 /// ```
-pub struct Devres<T: Send> {
+pub struct Devres<T: Send + 'static> {
     dev: ARef<Device>,
     /// Pointer to [`Self::devres_callback`].
     ///
@@ -107,7 +107,7 @@ pub struct Devres<T: Send> {
     data: Arc<Revocable<T>>,
 }
 
-impl<T: Send> Devres<T> {
+impl<T: Send + 'static> Devres<T> {
     /// Creates a new [`Devres`] instance of the given `data`.
     ///
     /// The `data` encapsulated within the returned `Devres` instance' `data` will be
@@ -236,7 +236,7 @@ unsafe impl<T: Send> Send for Devres<T> {}
 // SAFETY: `Devres` can be shared with any task, if `T: Sync`.
 unsafe impl<T: Send + Sync> Sync for Devres<T> {}
 
-impl<T: Send> Drop for Devres<T> {
+impl<T: Send + 'static> Drop for Devres<T> {
     fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.

-- 
2.56.0.360.g66cac248cb-goog

