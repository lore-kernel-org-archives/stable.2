Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376053C9EE7;
	Thu, 23 Jul 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800761; cv=none; b=cqKq6882Ux+pl3j7M6iCi5Osaak9GkjuvYfMAt2zVMJ3hafcU07cgwac6JOQdSHGah+6kT746/jIEa2QKVJCIB9wO7QSTvoVxm1v3hswAjk1w45MxaDE94VJI5ELGyVK6KqL9N3Qvlk6csqhv6h3aboiaNdIeRvL8PJu1rhmAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800761; c=relaxed/simple;
	bh=yKhjLW1ejSTaVutm2g54PYrE8nQpzfdPQX3BYTBR54M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V7PVFLl5lowi8mCMKZ4tXheShkaz74uHAy1gb6OP9REGLNMvCzDODsEXXeli8qPViWL533rWq0dWzcw9LkyCNRSE48dsmcpIBPP4q4h1WVDHRN5f8x5xMWCcv4kdWlQUkHiXDVDRoxVcLYZq2FqjYMOPoaZLNyXjCeow78fJqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [2001:bf0:244:244::78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6a61e5f2-0463-7f0000032729-7f000001d7d6-1
	for <multiple-recipients>; Thu, 23 Jul 2026 11:59:14 +0200
Received: from mail-auth.fritz.com (unknown [IPv6:2001:bf0:244:244::78])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 11:59:14 +0200 (CEST)
From: Nicolas Schier <n.schier@fritz.com>
Date: Thu, 23 Jul 2026 11:59:04 +0200
Subject: [PATCH] kbuild: Stop modifying $(objtree)/Makefile when building
 oot-kmods oos
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-kbuild-do-not-modify-build-tree-makefile-with-mo-v1-1-ea6d386c5057@fritz.com>
X-B4-Tracking: v=1; b=H4sIAOflYWoC/y2OwQ6CMBBEf4Xs2TWloER+xXCAdpEVSrEtqCH8u
 1U8vpnJzKzgyTF5KJMVHC3s2Y4R0kMCqqvHGyHryCCFPItCZtg3Mw8atcXRBjRWc/vGXQuOCE3
 dU8sD4ZNDF33M20yIy4lSSRnE2slF//WbvFY7+7m5kwrfnX/C0WOOX8Ieg6b2hMoaw6FMluIo0
 akcqm37AFCXLRzAAAAA
X-Change-ID: 20260723-kbuild-do-not-modify-build-tree-makefile-with-mo-4f30095e12e3
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anish Rashinkar <rashinkar.anish@gmail.com>, stable@vger.kernel.org, 
 Philipp Hahn <p.hahn@avm.de>, Nicolas Schier <n.schier@fritz.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=n.schier@fritz.com;
 h=from:subject:message-id; bh=yKhjLW1ejSTaVutm2g54PYrE8nQpzfdPQX3BYTBR54M=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBqYeXxIHK8NqwQpBEfVk2qJ9kDLNaA9KtfSwy/j
 ZWxJlHiqdiJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCamHl8QAKCRCIxryciJpt
 uLxsEACJ1S18xX5tdHTrBD04fwZ6/6robfgZNo6hDCUfu7g4Cm8g6TKpYmJbFwOyNyHyWK7xmIg
 diBFpyfKtfIOFExpvDT+510t9gdolrw6k1Mq0nVeo/lV3Atqn1WiuWnUHtGACOVCclZHs8Z7Kr0
 xkOCOqZ+nxTiBFyM/bPmXu0LDihVnjrMq2SHeXzwlvpN6C/4HDnV/CIyv7E9nn4kD/uwsdHQPO6
 dvk7FXfq8pUTNyfEXzYpgrnUojwigKi2IXl8R3nqhsoR6yuAEUOw+5ikkQreRdUNR2yKDjBVMQy
 taXtNmIbwH0f/pCO/Z+Sng4KNieAnQKoM3zn60MZjlXoCeTMKegInUq8bK7bOw9LlPTYbNYiWJQ
 N3YiCQB/u69zfXY/oDjeFNDTVlaEjvAH8HDAnIucHW+ZfSSo4vmeuJdHTtWOS89pPydXD4UeemY
 wUPKDh5oPxYFnQAFoiE6GRIlcPp+j0iD4EbF1egz/rFXXzV5Jb0g8vOal5j38QdgnlWtugDNZLw
 FY9OCMtkfSYc+YJDUT6BOYQRknsT83YO1HAPq8MAtJS1Ewzt4R90CeAzFNBgEiQ0CvfUNY33MXs
 Cy9WIj+5Yd4I+PlCF38u45H0Vjmnx22WmE3VqkUH+O62kCSaPQ7SS3z5kfJ/V0ctHLGcQ9vrg5a
 uWWaR/WnAoJhg6A==
X-Developer-Key: i=n.schier@fritz.com; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1784800754-F17F894F-86AD06CF/0/0
X-purgate-type: clean
X-purgate-size: 3078
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: queueID: 3332EA04FA

Update output Makefile in the corresponding tree only: for out-of-source
in-tree builds update $(objtree)/Makefile, for out-of-source out-of-tree
module builds update $(KBUILD_EXTMOD_OUTPUT)/Makefile instead.

In-source builds are not affected.

Since commit c9bb03ac2c66 ("kbuild: reduce output spam when building out
of tree"), building out-of-tree kernel modules out-of-source (make M=...
MO=...) causes a rewrite of $(objtree)/Makefile with KBUILD_EXTMOD and
KBUILD_EXTMOD_OUTPUT being set.  That is problematic:

 * $(objtree)/ must not be changed in any way when building out-of-tree
   modules as it breaks other uses of $(objtree).

 * Setting KBUILD_EXTMOD and KBUILD_EXTMOD_OUTPUT in $(objtree)/Makefile
   kills the tree for incremental builds that start right there
   ('make -C $(objtree)'); builds starting in $(srctree) reset
   $(objtree)/Makefile to its original content.

Further, $(KBUILD_EXTMOD_OUTPUT)/Makefile was not generated any more at
all.

This commit restores the previous kbuild behaviour prior to commit
c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
but leaves in-place the use of filechk for output spam reduction.

Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
Reported-by: Anish Rashinkar <rashinkar.anish@gmail.com>
Closes: https://lore.kernel.org/r/CAOESE2Q2-0KUDaM0mUo+c_F-tMaUsBZ-gpnhdoe0rmYdgnnuJQ@mail.gmail.com
Cc: stable@vger.kernel.org
Tested-by: Philipp Hahn <p.hahn@avm.de>
Reviewed-by: Philipp Hahn <p.hahn@avm.de>
Signed-off-by: Nicolas Schier <n.schier@fritz.com>
---
Anish Rashinkar reported that building external kmods out-of-source
caused modifications of the build tree's Makefile (cp. Closes-link).

Anish, thanks for the well-detailed report!
---
A simple reproducer:

make O="${buildtree}" allnoconfig
scripts/config --file "${buildtree}"/.config --enable modules
make -C "${buildtree}" olddefconfig all
chmod u-w "${buildtree}"/Makefile "${buildtree}"
tempdir=$(mktemp -d -t kmod-oos-build.XXXX)
make O="${buildtree}" M=samples/kobject CONFIG_SAMPLE_KOBJECT=m MO="${tempdir}"
make -C "${tempdir}/" clean
make -C "${tempdir}/" CONFIG_SAMPLE_KOBJECT=m
---
 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a8d8ed711f9b..b2ad52f6719d 100644
--- a/Makefile
+++ b/Makefile
@@ -681,13 +681,11 @@ filechk_makefile = { \
 	echo "include $(abs_srctree)/Makefile"; \
 	}
 
-$(objtree)/Makefile: FORCE
+PHONY += $(CURDIR)/Makefile
+$(CURDIR)/Makefile: FORCE
 	$(call filechk,makefile)
 
-# Prevent $(srcroot)/Makefile from inhibiting the rule to run.
-PHONY += $(objtree)/Makefile
-
-outputmakefile: $(objtree)/Makefile
+outputmakefile: $(CURDIR)/Makefile
 ifeq ($(KBUILD_EXTMOD),)
 	@if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \

---
base-commit: 6946cd5d0aa4dd10a414ddcb7a10844fdb0ad345
change-id: 20260723-kbuild-do-not-modify-build-tree-makefile-with-mo-4f30095e12e3

Best regards,
--  
Nicolas Schier

