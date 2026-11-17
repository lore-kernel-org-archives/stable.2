Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938227;
	b=SnePY8x9MZZUXjE3aeJeydiAPHBvGN53DsZFs8AAAauqqKsG7DBOKOuw7IbARb97cKKg
	 B4mkZjVH4eGC7L1swpx2JGVbJ2ur3JXEmwRQx2adDoZxnsq2nMuHCvTJY0Z0zWlx1iUet
	 RSTxsq5tY6FPToDzPz85FroQ9pSmoTo4BSx91rFWLRSf5tQAsBkc2wxPgodnm0q23vNeK
	 AxV+wu+bptC8EQltQk2N1D865bd42sSXrBzHUnovSHZ2HmekHbVnhNwSGYZma2vfRUlgD
	 g2sAiuh2eiKo4S0enGa5LP3tdmQnZ041q2maXXqXxZ/Z/8YRwj/5EEpSpa6l2uohWoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938227;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iZm8gP5NtzWpDu5Ec9bghesRJyGcuypRk9ToYfTJBbQ=;
	b=zMzDU98YC1xp12MTqvDVkKX6pBE2ISuHa9FrnGBd8MD0OtRn8EaZxkFZ4p4+S5yJ7x8t
	 /LzikeMughkkYWN+8FRtdZybpnaMM7EPQWHi+8xgXJaO6hMNbfTm9x1ZuswphzffGMqCP
	 i+3pM1OP5urOdp77GgGnEk8wgC0XZOGAdgrLH1OX9RPtVxgFjpbPHCnkitWPnaeCTqHMI
	 8vi+56/IGgIkkm1UK4rA5VN7SkpooBPwyX5Ik0oozMVSB+L8JO5PAqMIuquW9Bw/PBut5
	 QAMuTporgL7i7h+z3Xlq463LKq9m4n78kij8wGQfFWUdPbX0umiJ/FU4ClOfT+j94jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnCknJVH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DA606A33A;
	Tue, 17 Nov 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnCknJVH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938227;
	b=I40bQVC3IsoyRHPyTKWNtyz3wcUuLqMh7AA3vQIOW8BeiSIn7+QL/lN9zGr4xeikZuy6
	 fWghAelu5D6opkRZs+ElnMovGzcejm5R49hizc+OySW2AA2lA3K1ZUG0jGOJ5midBqfxE
	 c/x+ia+Dzkv6jj+grzi+f7tdsl7hDSDzyEcyDdCYFKa4XPLMwb+Hm6AkxQBlEFXj9DeTL
	 gdowUh2yAU+r4iEgh1eY+RCoy1Rx9OcSGBZOYX8xrB7LN4KqU4pthOfSsinnCBOdfZmuQ
	 pEoEXAyivhqSIa4UEd7cV6EsEKukqS1QmJd2phCiPYnGONQ81G9sjEVSDdnLil5mFng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938227;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iZm8gP5NtzWpDu5Ec9bghesRJyGcuypRk9ToYfTJBbQ=;
	b=UVGDI/4UfzavKV9tfp96Y629sP68FwwM368zbA8T143hyG3zlSxzZmMULw2sDaGs2086
	 0FZ/IvNUzb+kO7d4AEt9VCzQsm7/rEVSr9s5OmkQbjAR/DH4NEAInOBERh8OYL29cTb51
	 5VTJEXnJt69GmqVVyftLge0J7poP9VijvRtRvkuKa6k3DDV7eIq3yQLS96I3S/yNynrqG
	 M9cD+3SsJSqw8jHhDbSZvWIFp8nqAoR4CYnLiFnOi5+0pXfsLN3i9kjF/DmvG/r+ozkYl
	 oSzpMDcZkXDF57CqXW+3OCbHaAfM4j0UVfDMbYuYu/RUDVw3I4j5w4HeWQOm3qDifVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6A0AF1F000C5;
	Tue, 17 Nov 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938227;
	bh=iZm8gP5NtzWpDu5Ec9bghesRJyGcuypRk9ToYfTJBbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OnCknJVHin6QecJz28X4FFapTRTEjGcyLiea8XvZyPjLbXPbr4XME/w6zWK1WgB58
	 WAAd8IwD4IglMaCzjrTDkSbx5rdVTnd0UcTPqJnaVpVV0qvlu9QYSeRS9JMwaGSHPk
	 yOre/e1Ewzr/6BBhbM1H5QuKUX5a3gheeAY8FxtOHAgmIkn0XD9VZ0i82wLPZpXVJY
	 r889Gk/e3TohsZDe53kdBcvt1Z7586HA4MpTcMlJqzt379ZPBz7Mg9lNjHVmSTYQlx
	 NgxtTG4Lx7T4EBkzFzBM3yNbsNl7Wp5hXjeL3utL1RToTJ/qJBnNtmgyHJNu9COEwA
	 7QySYf/I6h3ww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EBB7F4AA30;
	Tue, 17 Nov 2026 17:57:05 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 18:57:07 +0100
Subject: [PATCH v2 2/2] rust: str: add an example for Formatter::new
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
Message-Id: <20261117-formatter-lifetime-v2-2-e216d86ffb57@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938225; l=1243;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=cXnDKX6DUJYzotZgM4eodRj9988SY5vag/57CgAxefA=;
 b=ftlkleDiJFBrpP5Go7Zmk+scHV6bzIGVdtrSzMBuq71SDPvACTVvj4xa0XhOcRCoa6bVKLGMp
 tn8Qq+MxRm8A7huSNZqHvGsypCZTXzVQX9Iuo9O0dTqDGEF8niqOGRZ
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

Document the exclusive buffer borrow held by Formatter::new() and show
formatting into a live buffer. Check the number of bytes written and the
resulting buffer contents.

Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
 rust/kernel/str.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index e5fe84eeb..6222faacf 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -658,6 +658,22 @@ impl<'a> Formatter<'a> {
     }
 
     /// Create a new [`Self`] instance.
+    ///
+    /// The formatter exclusively borrows `buffer` for its lifetime.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::fmt::Write as _;
+    /// use kernel::str::Formatter;
+    ///
+    /// let mut buffer = [0; 4];
+    /// let mut formatter = Formatter::new(&mut buffer);
+    /// formatter.write_str("test")?;
+    /// assert_eq!(formatter.bytes_written(), 4);
+    /// assert_eq!(&buffer, b"test");
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
     pub fn new(buffer: &'a mut [u8]) -> Self {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.

-- 
2.56.1


