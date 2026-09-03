Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E040DB53
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433306; cv=none; b=W4a0yW6JjHr/uFbUVPmx0HhCRq848wcdFMrlrenliK/8zDnFPuRGfhSfIch/BajXmOR81fkhXRp3PInUabhT0CdTGGWTRrUxFpU/LwBd6N7eEjzCk5CRJDz7Kfmvbumx5m2gfc2OMBlgcB2LMRzEEXQIa5Z9SQYn/tAEqKqsxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433306; c=relaxed/simple;
	bh=ZkzBXGWWz7vC0qNfBRdAIRYr1bxJAHhMyDWB9nSkmeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9rvlnc4/Xw1dr3hvTCTbUr1uazYKMNqqIawuQMoYd+rghEhaXHRgBLrYkffvKIUCkV/lujZhz3eIuLM+xb2QuNUF1+BqJKkkC35XQ1tXtgjp1vQkp61dOWsl0JFW2wVezEwS+tcE98rDK4LieyWiuMw06kbjQtUPe63X4FBKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt4/WOg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt4/WOg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CEB1F00A3A;
	Thu,  3 Sep 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788433305;
	bh=iZQNkB3CyvDCN6HDxdFwdNsGrnv+JbP3pcBBkYt8nCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zt4/WOg+dKiELkehwmsY2LyT0NNMt3YaPJW8yHEABdcoJ2CLlHu1znrKV9RA8aZqS
	 nseXmQlkonhqRHC7j6mdTI0xOK7fM94OBu7/eraBU3PdrwSLzMqssxfEWPa2v/QqIg
	 FkGjAvgqVo6bV+ICHZGzK9qgFpYYBFs8kKtNv0fqtUmw9baCOGHSk5IXiliNth+va8
	 gUBtc26wuNy54zhiH4ovur5E9e9jJCPzsc9CN6IkknPCmJH3RdBuNB67AnBFqh885f
	 vu1qrq3jhPDGrEw4LqxNfcjZY4dJ5H3bNtSLpRLJ5JOLisrtrqsXAwqsnQ2s0y7lUM
	 rNaNOrVoH7Y/g==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Eliot Courtney <ecourtney@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Gary Guo <gary@garyguo.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 7.2.y] rust: num: reject Bounded::shr overshifts at build time
Date: Thu,  3 Sep 2026 13:01:33 +0200
Message-ID: <20260903110133.87260-1-ojeda@kernel.org>
In-Reply-To: <2026090332-lazy-chirpy-4151@gregkh>
References: <2026090332-lazy-chirpy-4151@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eliot Courtney <ecourtney@nvidia.com>

Make `shr` reject shifts of at least the type's bit width at build
time, instead of panicking or masking the shift amount at runtime.

[ This implies we can break the type invariant, which in turn means
  we can trigger UB via `Deref`, e.g.:

      rust_kernel: panicked at rust/kernel/num/bounded.rs:528:22:
      unsafe precondition(s) violated: hint::unreachable_unchecked must never be reached

    - Miguel ]

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org
Fixes: c59a2d14cd24 ("rust: num: add `shr` and `shl` methods to `Bounded`")
Link: https://patch.msgid.link/20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 223aa25aee82e188ddf043a8703b16e5fdfc37d8)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/num/bounded.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index dafe77782d79..92a17d5aec32 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -485,6 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
     /// assert_eq!(v_shifted.get(), 0xff);
     /// ```
     pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
+        const_assert!(SHIFT < T::BITS);
         const { assert!(RES + SHIFT >= N) }
 
         // SAFETY: We shift the value right by `SHIFT`, reducing the number of bits needed to
-- 
2.55.0

