Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8052CCFA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689574; cv=none; b=kkB0YM2g0eCvVbXLrejv+bnK5AbpVYQ92MFDWBkSJJLoIcihJylyzQYYUYPMMGFj4IXgUsdIYJXVW5Iqf+zzizV2v0e3oXDpb0Ie48uKvb9O9jyH9pu/n/pFzd/ppI9Ud8vp081QA191zxVIEf8PCwBhdZ2fyYGMhwbO05HsdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689574; c=relaxed/simple;
	bh=tSBbNhJVVisi1uW+AHXxElgkpdjNniSA5QGoDkH9ivY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ylq3iDdW3lJ/LHdyLcc2lp/ugwGgLQ+yJFZIOcvAjgKARaYAy4eE9A+SCR7Cd9DA8cHDiOcQUKQjn/UC/1WJwIRz7j9qOruwzAr8YJylwhRl1oS7ElLRDP8RenjJv9aJ6kQ3mZUGLDXCWR88V9dwTl2eUF421T/5QIh0KaRVJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5qMv/EN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5qMv/EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E0D1F00893;
	Tue, 29 Sep 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689571;
	bh=PUeKhSUp0PamZyF7oH3/ndT/MHd6VhElYvzJzzLOaY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5qMv/ENddbFcrX6mWmzEbpN2O+kxWZOORNdJGbqJjTly6lxfisIW/W9SgoD7m58Q
	 vWkgh+1D6BDUCfYRqkdDn02C4jJFPbYGxk/o+9QsdlKLR8ZF2UN8y/gF7qNBmBzt4A
	 pVjXHpwK/MoWlPob9XUt1uAQUtmRWtdWwoO5r6W5kGY7M954AGlVOSVkAH2yTgSndK
	 Cea0Yf5FV8iaaeqD+cTZpYwM8SnLj5tJYjozY+KFOWDjQuoL6el9R6kRTt5st+vbBD
	 3gEqe79PSLW9u1P8SCRPz1MTt3v7AW5N7lp5PvdUEP1NLmz7KQ5FSCk3QktJZf7kz7
	 DuiArNEtlwavw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/5] landlock: Work around gcc-16 -Wuninitialized warning
Date: Tue, 29 Sep 2026 09:46:05 -0400
Message-ID: <20260929134605.3516662-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929134605.3516662-1-sashal@kernel.org>
References: <2026092944-secrecy-crouch-5bf3@gregkh>
 <20260929134605.3516662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c4e941bb7654bcbdfb0b6f3341dc2acfdf235c8d ]

gcc has a bug with -ftrivial-auto-var-init=pattern that produces a
warning for correct code that uses sparse bitfields:

security/landlock/fs.c: In function 'is_access_to_paths_allowed.isra':
security/landlock/fs.c:767:28: error: '_layer_masks_child1' is used uninitialized [-Werror=uninitialized]
  767 |         struct layer_masks _layer_masks_child1, _layer_masks_child2;
      |                            ^~~~~~~~~~~~~~~~~~~
security/landlock/fs.c:767:28: note: '_layer_masks_child1' declared here
  767 |         struct layer_masks _layer_masks_child1, _layer_masks_child2;
      |                            ^~~~~~~~~~~~~~~~~~~
security/landlock/fs.c: In function 'hook_unix_find':
security/landlock/fs.c:1649:28: error: 'layer_masks' is used uninitialized [-Werror=uninitialized]
 1649 |         struct layer_masks layer_masks;
      |                            ^~~~~~~~~~~
security/landlock/fs.c:1649:28: note: 'layer_masks' declared here
 1649 |         struct layer_masks layer_masks;
      |                            ^~~~~~~~~~~

To work around this, change the definition of struct layer_mask to
use an explictit padding field.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
Link: https://lore.kernel.org/all/20260619082133.3504146-1-arnd@kernel.org/
Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20260915201036.3527935-1-arnd@kernel.org
[mic: Use BITS_PER_TYPE(), fix kdoc warnings, fix commit message
according to v2 changes]
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/access.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index bbbb41f41147c..f843835851d01 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -61,6 +61,10 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+#define _LANDLOCK_LAYER_MASK_PADDING                              \
+	(BITS_PER_TYPE(access_mask_t) - LANDLOCK_NUM_ACCESS_MAX - \
+	 IS_ENABLED(CONFIG_SECURITY_LANDLOCK_LOG))
+
 /**
  * struct layer_mask - The access rights and rule flags for a layer.
  *
@@ -81,6 +85,10 @@ struct layer_mask {
 	 */
 	access_mask_t quiet : 1;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+	/**
+	 * @__pad: Padding for the compiler's bitfield initialization.
+	 */
+	access_mask_t __pad : _LANDLOCK_LAYER_MASK_PADDING;
 } __packed __aligned(sizeof(access_mask_t));
 
 /*
-- 
2.53.0

