Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4173F484D;
	Wed, 14 Oct 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792021255; cv=none; b=WQ2nMWb1fk4fUYXZ5u5ofq+DbIWyfUfeFdNpH1wHrnNh+oYJGFUmShRhUGdGj7reRoE99r3uswQ1O3YhrFqIH4CEUDmnCBcbzcyKfvplLM6yt0TPTswWwdgvYscZ4tFfKbrMXUUKviqR54gZ3brxuMicFjXte6liGLtJNOLfMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792021255; c=relaxed/simple;
	bh=MmzEic1vGQalXK+eC2lDyxARwtfmb2P9EnE3nl4JYvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J3g2F9MBxi3kutrruqaub8nNFauzeOZsg7PdKz1Joue2o3HiuhgKgB53QEkCfSmf42yuVZSWkfmg+8fk+TBFFkmTSWUZs09jkY1pXqjJKpBg2YJpMmF1pE5F0QJ7JwIltpekroS/ZBacKaoHzVmg3Ayf1ApkYeFLMiPV/L//vrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv5EZTHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv5EZTHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6DF1F000C4;
	Wed, 14 Oct 2026 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792021254;
	bh=fRQ0+2806AA81UAOzmZj275ai5p+lqeuEOsdRUnRN10=;
	h=From:Date:Subject:To:Cc;
	b=bv5EZTHhOmPcRh7ejM8hfDL7+iXERHhKRows1r1zBUgoGxm8/uB8aADkwth/ru36E
	 4PS/W59USSlLIbgXkZthv+5algk8oIVmiXBAFHRh5/nCuqTOUL7/+mX2My4FLKvjbd
	 1Oq8VU4hhIPw/Pg0aQgfW1sxyMn6jhuzuzZff0EtbBK4NF9frEeZXFSPO8JojNMjKl
	 sWMs5W+PgTB+ss0g5fp4Pi2va4guPRFoOfETHp6CWFjfHnDFBKxkbiQVdSUqXiQhVN
	 cK41prePvyxTkYbL4lw1tm1FqviSNMagu5bPrRGzszCIUEHEgHLxvI1x33sQ3s0WKC
	 DzhMibSpsp7jw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 14 Oct 2026 16:40:41 -0700
Subject: [PATCH] kbuild: AutoFDO: Update split machine function argument
 for upstream rename
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-update-autofdo-split-machine-function-option-v1-1-5c71b3005e89@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywqDMBAAf0X23IVEpYX+SukhZjd1S5uEPKQg/
 nujnoa5zKyQOQlnuHcrJF4kS/BN9KUDOxv/YhRqDr3qr1rpEWskUxhNLcFRwBw/UvBr7Cye0VV
 vSytgiAdoZJrUQMNNWWjJmNjJ79g9nqfnOr3Zlv0B2/YH14hXF5AAAAA=
X-Change-ID: 20261014-update-autofdo-split-machine-function-option-d4edb03d370c
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; i=nathan@kernel.org;
 h=from:subject:message-id; bh=MmzEic1vGQalXK+eC2lDyxARwtfmb2P9EnE3nl4JYvo=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkXhBn7H/zoO7Hk2raKG3pTGSv1zjkvzXsfobS3dwnj/
 WfmPB/edZSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJ3Ohm+F9aezrO6XvZ6qNN
 5VPiT3Id4kxInGhwdavp3yK7Ai97x25GhtYt/rLRR/fXLhStyVDqTNO7NPVb7Oeae7eYrTPbUqZ
 Y8wEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent LLVM commit [1] renamed the internal LLVM plugin option
'-split-machine-functions' to '-function-splitting=all', breaking the
AutoFDO + ThinLTO build with:

  ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument '-split-machine-functions'.  Try: 'ld.lld --help'

The plugin option is needed for in-process ThinLTO, so handle the rename
accordingly using ld-option.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2186
Fixes: 2fd65f7afd5a ("AutoFDO: Enable machine function split optimization for AutoFDO")
Link: https://github.com/llvm/llvm-project/commit/3e6acc87c58843e551d6e8e4bf06c26712b04622 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Makefile.autofdo | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 1442043da139..57a3aba6ffc2 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -22,7 +22,7 @@ ifdef CONFIG_LTO_CLANG_THIN
     KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
   endif
   KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
-  KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
+  KBUILD_LDFLAGS += $(call ld-option,-plugin-opt=-function-splitting=all,-plugin-opt=-split-machine-functions)
 endif
 
 export CFLAGS_AUTOFDO_CLANG RUSTFLAGS_AUTOFDO_CLANG

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-update-autofdo-split-machine-function-option-d4edb03d370c

Best regards,
--  
Cheers,
Nathan

