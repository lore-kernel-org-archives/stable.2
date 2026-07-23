Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429F443AA2;
	Thu, 23 Jul 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804406; cv=none; b=n2YB2KN5Vf7UGeGI/CjAvQABIgg0/LHkid/U3h7Q4isxpRCViOxBvAPHGPI6DDD0wVqNX4zMoRWcEYwL+t/xw0g0Yp7HPDghBwhmmxny9GEAxfN5CfcUb4/+3VcMk7o2X3cJ83ypNvksKxOnxGqoh0umKCnF2FlpSrlbXAwN1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804406; c=relaxed/simple;
	bh=a6LBrgzIH3ROQLscRbq6mc7UZcOs6FqbJZxL8SLFRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0Q3RdqeiAPJKeCpFOBlOktLF8gHmuXwcvZ+uGB56v19I16AiF8F6o1W4jE6B+k2ygG3jlMI2nawmepGbVSDJHjmn4Q/HPFiAQDJb4odIEDN6c2NwPqfUbgS5CHwk5h0q5a7i139h4AUeg5hYLPHEK3FBFfyw4C+YJIYlui7X2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 799331F000E9;
	Thu, 23 Jul 2026 10:59:59 +0000 (UTC)
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anish Rashinkar <rashinkar.anish@gmail.com>,
	stable@vger.kernel.org,
	Philipp Hahn <p.hahn@avm.de>,
	Nicolas Schier <n.schier@fritz.com>
Subject: [PATCH RESEND] kbuild: Stop modifying $(objtree)/Makefile when building oot-kmods oos
Date: Thu, 23 Jul 2026 12:58:45 +0200
Message-ID: <20260723105845.1704689-2-nsc@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Schier <n.schier@fritz.com>

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
Signed-off-by: Nicolas Schier <nsc@kernel.org>
---
 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 11539c3fd405..17d34968b7f0 100644
--- a/Makefile
+++ b/Makefile
@@ -695,13 +695,11 @@ filechk_makefile = { \
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
-- 
2.47.3

