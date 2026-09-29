Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A653FD49
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706582; cv=none; b=F+d69mvUAQzdlvCNbt1U8WdiLU9xett97IHkyfTVjfGjU2fbIvVE7+Eya2vDfarnCKnJ56b/TfOU2Ap9uB1UTaoFl8IogQaTqvfoioPHlh/d9q2AurlZUtSqBvgNqbX8qA7ghwJDGHenM6mRG01IfWbPHc+PXdWWhR/bu9jbckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706582; c=relaxed/simple;
	bh=3uXvIBeGYaHJgEcoFG1CYMQJlT9oabXDpZn3Z0W4/PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3bcWlqGzv8dQVN1GiefH+QM5vNntaYfE3otRGUCIZmqJfUDlVFrX6mDgGxG0zJnUMLrVSWQfD5j09Lf2Fq94n8eqygN3k3LbJLMZ5PpDPZ4+rxpz5g8LY0IHKsqZTzv2vWEz4Ji/ngh00hVo/kGunbFr6rLJmMKqNDc+aeXusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xB4DWspP; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xB4DWspP"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hvRXq4Ww4zcGf;
	Tue, 29 Sep 2026 20:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790706571;
	bh=a5EcACj5N/wxwRYhW3TNKZfQg7iyQ0Uf6WQv67IagnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xB4DWspPAY78EnmU1ZavKaavQSKnlbBkQ6dOH7upMlKDOCaMujebpDioqZSqGhlr7
	 xScdPcs/ipROV3G2yRSp09W95aB1gmVbtilHXhPumH2Rfz6fAm7927LdihmPYWf2+8
	 ui5oTyhRH3CgOe2wgXq83NOzBk1ZvIR7XGOsJ2mU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hvRXg2js2zbSG;
	Tue, 29 Sep 2026 20:29:23 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7.2.y v2] landlock: Work around gcc-16 -Wuninitialized warning
Date: Tue, 29 Sep 2026 20:29:12 +0200
Message-ID: <234ba89bbb9aeb202024b1d3e2e51bb0b52c475e.1790706324.git.mic@digikod.net>
In-Reply-To: <20260929134605.3516662-1-sashal@kernel.org>
References: <20260929134605.3516662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

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
[mic: Backport: use CONFIG_AUDIT to calculate the padding width]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20260929134605.3516662-5-sashal@kernel.org
- Drop the four context-only prerequisite backports and use CONFIG_AUDIT
  to calculate the target's padding width.
---
 security/landlock/access.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index d926078bf0a5..a0fa1009ccdb 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -61,6 +61,10 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+#define _LANDLOCK_LAYER_MASK_PADDING                              \
+	(BITS_PER_TYPE(access_mask_t) - LANDLOCK_NUM_ACCESS_MAX - \
+	 IS_ENABLED(CONFIG_AUDIT))
+
 /**
  * struct layer_mask - The access rights and rule flags for a layer.
  *
@@ -81,6 +85,10 @@ struct layer_mask {
 	 */
 	access_mask_t quiet : 1;
 #endif /* CONFIG_AUDIT */
+	/**
+	 * @__pad: Padding for the compiler's bitfield initialization.
+	 */
+	access_mask_t __pad : _LANDLOCK_LAYER_MASK_PADDING;
 } __packed __aligned(sizeof(access_mask_t));
 
 /*
