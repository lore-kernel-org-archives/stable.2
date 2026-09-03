Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A740B0F7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429339; cv=none; b=SecN81uBNhkm0taKJlh/z0IViyOdTfGIQhKy8CrzC7AqoDH85vdzPgv0MN2mMNMdVjOLE69LQy9sM0QvnmaCvVb0Oz9rvEZxqXIJjSl3QIDxwhyqVz+O8nX2+YlQJviN18B5+3kGMBiC1J+YTd8NS2N43P7ExOX+k5HJoQ+Swzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429339; c=relaxed/simple;
	bh=jP54k6PzlRcR+eQsqwjgc7LBmXVU5GoCm2g+bDN+j2I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dIBw9muMmNBagvipP7ZbxYs8pt5hPQWpmhauPJ8Fi/mctVI0GdMtQcB+inOk0UJFsLaEZ7Vkx0hHH542NsIwhnkY6qxZprXGk/tgs6tbggpMjJOhuQABg4tNhj6YoRz7sboFfuTI1ecqEEqUR2ZXhyOIGmAUs3m0/xNp7wJ+MQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSAQDg6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSAQDg6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D13C1F000E9;
	Thu,  3 Sep 2026 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788429337;
	bh=clAp/Z0Y/hN7RVOoSE3eNbBFX0aFFSf02zpXBvq1WFo=;
	h=Subject:To:Cc:From:Date;
	b=DSAQDg6J9TRCNwMG7sOofAtzBsmbjCJ/i7ri92tt3/Y/+6P7SRYNPiEvKe6ro4tsU
	 DsUBWhkJ0zfR+zvBw8a6itJO2lPFeCYuODYf4q6mgwMf5Dx8EMKrm5Zs4qdIdShCbJ
	 UqF1Y/7kfdwHlEpqplDRlM6Pmb2g0o+NgdXvm2qY=
Subject: FAILED: patch "[PATCH] rust: num: reject Bounded::shr overshifts at build time" failed to apply to 7.2-stable tree
To: ecourtney@nvidia.com,acourbot@nvidia.com,dakr@kernel.org,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 11:55:32 +0200
Message-ID: <2026090332-lazy-chirpy-4151@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 223aa25aee82e188ddf043a8703b16e5fdfc37d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-lazy-chirpy-4151@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 223aa25aee82e188ddf043a8703b16e5fdfc37d8 Mon Sep 17 00:00:00 2001
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:24 +0900
Subject: [PATCH] rust: num: reject Bounded::shr overshifts at build time

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

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 9ad7df1a243d..90483d2c5374 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -485,6 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
     /// assert_eq!(v_shifted.get(), 0xff);
     /// ```
     pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
+        const_assert!(SHIFT < T::BITS);
         const_assert!(RES + SHIFT >= N);
 
         // SAFETY: We shift the value right by `SHIFT`, reducing the number of bits needed to

