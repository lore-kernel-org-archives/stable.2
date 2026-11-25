Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627961;
	b=mpCgpLaNJfqwUsczvA7CEhnLINtk8B5tgo4DezZ79R0brFfvyID1dBMVHaXPaFoW4ccg
	 SVf1Mn2CfWLkkZUwNafHG3X2Md4qw5MZ2pH2c8cu2gKdGZTPRdw5ST12YsrKr3fuKIOzW
	 9Epc4GeZPL3acL8C61q1JJJd9hEjVQkBb77aW/77lFBBs7ZyUAtvKItY9l/umPpZfQPsl
	 rQSw2lB/DOpnfD9gYWgNH7rBkerwCsl2yACwbUKvhw6b/ihqS72FdavQ0MaE665VeEcHS
	 gNhDi0gSsIYqXETg6L+5fZU2gFV36yqX8mFfiEHo/m87HhqAqMIEhiDVLIm9vgfz4Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LwG7310mT62woZnR5H0Qer45gIC5/pILPZ7xJQoCaBg=;
	b=D28TiZ1yXnVS6vSqxPS45mPESe90XEBsV65rItCD6HCK2L375wOSXHF9aJSvLXmdCLuE
	 +LOhK/UYyARJr4k/5iPciCLVTQYqOWOHw5ip2sb+gDeOIdmUAmM1fImGgtyBLIUC5feaS
	 hbAV7Cs6sEHht7efXYX7pElaNj5eXeOEW6cyyPXUzLIZaogcmBEK30zLONoh9cmW1xLtz
	 dqQOF8Vk1FqOjeHJMHCYK7KYVgqcYw7/AQbpABpyREEdJdMyoiEV5e/ZfgoacXT1uhcfR
	 g0cPusUMpMl+cycPrV8L/fGGAXWvh9sF3GTdTZK/Nf/k7o9tV08LrKUjbSdZ939dzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUFlVu8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10765606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUFlVu8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1DD1F000C4;
	Wed, 25 Nov 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627960;
	bh=LwG7310mT62woZnR5H0Qer45gIC5/pILPZ7xJQoCaBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UUFlVu8MKToTV+JcETJ41T/t/6xEx32fqhYvfI4KH/nJnerlZuekG3UZUfkYzSfiX
	 P3pO6rVZWdSPFXKBpFGi7S6FFJBjuILgqJW7bdPKyYDi9VRXxGTnzRqFEFNob6cNDf
	 4wuDvUAsg8x5IT428NLXQgj8vPIQuoFU0er2Hz6HxvmnqTOZk+lZuLINFykT1P/nXM
	 KpbMYYqgWQKGbgoGO6YZkC2RdNr9hlFAM/tg6kBs6x9wc29cLCj6op2y7XHQ4bVFtH
	 A33jvz77GsKEBCBlK7ZAYZ+Iwm4KR0oXRfjwvojWmLw7irxg2903eVFGsA1b65CKhh
	 l5i7cxplFam5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] jump_label: Define guard() for jump_label_lock
Date: Wed, 25 Nov 2026 12:32:34 -0500
Message-ID: <20261125173227.966424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125173227.966424-1-sashal@kernel.org>
References: <2026112527-vengeful-handrail-9419@gregkh>
 <20261125173227.966424-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit e2b6e5e4877ac898b61338dc20491cd837af79b2 ]

Link: https://lore.kernel.org/all/173371207108.480397.12818384744149153972.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: f60f98881b54 ("kprobes: Switch ftrace ops when adding probe with post_handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/jump_label.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f5a2727ca4a9a..fdb79dd1ebd8c 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -75,6 +75,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 
 extern bool static_key_initialized;
 
@@ -347,6 +348,8 @@ static inline void static_key_disable(struct static_key *key)
 
 #endif	/* CONFIG_JUMP_LABEL */
 
+DEFINE_LOCK_GUARD_0(jump_label_lock, jump_label_lock(), jump_label_unlock())
+
 #define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
 #define jump_label_enabled static_key_enabled
 
-- 
2.53.0

