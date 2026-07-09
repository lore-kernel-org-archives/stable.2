Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5634F474
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618604; cv=none; b=B8lKC0SLgBC3bDdFmkYhCTkcfCKY1ufCdHYYA28gk1hux6+LBHesYU9d8iOr+v5aWosBpTAadKCFCAliZiMn/aJzrCxMm718lQ+AEdFOGpd4ZY/MEnxnIttFg9Zv4T3vpCfGggumYTBty4ozyblyzUqnd9Gqjht1jmj9vrrF+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618604; c=relaxed/simple;
	bh=GzyvXXuwbUU+Ka6eSCfFdRnqiV+RI4xvFrDfnS6QXss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P2l3ilPA3UolabaHPbiIC0CiSfk/yHtRHWMYL7YDqa6zWTtpRHmp4FPGHuu2pswoQ0fx8/O0V4PmoyoDC4Ebr3iNif38O2A2n23CabK5IHxBwdq6zLXNiBeH7dN8wmcgJllr8fQUQOwd2++FS941yhc5pqORCMR9BWEXAp5TSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ppF/pmbO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ppF/pmbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A46D1F00A3A;
	Thu,  9 Jul 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618603;
	bh=7KcFejHH3NTW6t9OQ7pz7UaIURom07EIybFwPLGIkVo=;
	h=Subject:To:Cc:From:Date;
	b=ppF/pmbO/+YOwb01EzAhapb+MVUet0Dl31F3vzZtcq0K59HpbVeuowdq5WXRTMGDK
	 S39C94OfXS0MJmIHbcgjCtTwuSsP74MSsWXlVZvF9Ez9ARvjdwkjrKy9MEZbagasV7
	 vG1ixn8Lpzfz4kQlHcIJuwnjokMIVOr4I5Nut5ck=
Subject: FAILED: patch "[PATCH] rust: kasan: KASAN+RUST requires clang" failed to apply to 6.18-stable tree
To: aliceryhl@google.com,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:36:39 +0200
Message-ID: <2026070939-ranged-unmapped-3ab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5b271543d0f08e9733d4732721e960e285f6448f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070939-ranged-unmapped-3ab9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b271543d0f08e9733d4732721e960e285f6448f Mon Sep 17 00:00:00 2001
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Apr 2026 08:32:16 +0000
Subject: [PATCH] rust: kasan: KASAN+RUST requires clang

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

diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..826a7d768ca3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2198,6 +2198,7 @@ config RUST
 	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
+	depends on !KASAN || CC_IS_CLANG
 	depends on !KASAN_SW_TAGS
 	help
 	  Enables Rust support in the kernel.

