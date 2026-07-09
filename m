Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC363E3C76
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619998; cv=none; b=IDeaS8lo+dzJVrGUTH7Lnp84ipjm3RTUEN0HsT+8CCcP8TDlOcHcPOVRHI+r3esqLnnZ+LBfEj+f0ugZ4icibwwBHZARGvH3v4nR3EEOhoBbdR3tPGfTLTQUuLZ0RL2iv/MkrD5pf3roTE9fJgd1y2NYuNC/NcOlsrYjt7WAviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619998; c=relaxed/simple;
	bh=Dwnl/7hnYHKR4Q+/fzQRUr823KW7zDhCItM5EtKOhuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGPqrujICEzICUT7RjavEv7qdL4+EF7psHDD3ntQhZggDR41aYJGM64jQfYuS6lGD4Wl0VqXiClAtEGLQZ0h4aAE9SCMuIr16JD85K9gEuRCNkzh539DF3EfRkY7rjJzHyg8GU19jH39nqpP2bYGCTohCVYT3EDFvAFoG2Xuhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnAzZMGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnAzZMGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8051F000E9;
	Thu,  9 Jul 2026 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619997;
	bh=0zlHDmSJAMqrUMHLzeRxG2sbV9Yfgzz4XNx4wY3p8B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnAzZMGQScv5BEIJ6DoaN4eMvB+ZkiLSpJVIcPcqY4WaEB6gaanQcw4OVX1rn70eN
	 5FZhTPXt87/ozsilBJq0J5Jx0PkFbYCYi3blis6izR0HUW/YnBmXktnR80csySeBpo
	 dAJH1iCVXkUv9k6dONRqvhOBv1NHaWEkaeTWpGFsyN0qTEB0mKTi5NH251pl4NLA1B
	 3eqTClQBbQyKB9JJPmHkHVEn2zAe7PXrpVxQpkaI8rg6PaMLGACcLfpNEnKzNlE+ac
	 DtCAZ9zJsVxEpvNix903a1X0NMVGIs0hzVmdeZB+MC47/BHxIXNa9hwi3ox30QAU42
	 x4cbUlUeD51qw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18.y] rust: kasan: KASAN+RUST requires clang
Date: Thu,  9 Jul 2026 19:59:43 +0200
Message-ID: <20260709175943.129241-1-ojeda@kernel.org>
In-Reply-To: <2026070939-ranged-unmapped-3ab9@gregkh>
References: <2026070939-ranged-unmapped-3ab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Kernel KASAN involves passing various llvm/gcc specific arguments to
the C and Rust compiler. Since these arguments differ between llvm and
gcc, it's not safe to mix an llvm-based rustc with a gcc build when
kasan is enabled.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: stable@vger.kernel.org
Fixes: e3117404b411 ("kbuild: rust: Enable KASAN support")
Link: https://patch.msgid.link/20260408-kasan-rust-sw-tags-v3-1-e07964d14363@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 5b271543d0f08e9733d4732721e960e285f6448f)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..0c25e78e10f4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2096,6 +2096,7 @@ config RUST
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
 	depends on !CALL_PADDING || RUSTC_VERSION >= 108100
+	depends on !KASAN || CC_IS_CLANG
 	depends on !KASAN_SW_TAGS
 	depends on !(MITIGATION_RETHUNK && KASAN) || RUSTC_VERSION >= 108300
 	help
-- 
2.55.0

