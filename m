Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB37349CD8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664529; cv=none; b=ljpp8YLAdE7fPDibVIogoe2q/i47htT+otny4XfxyWD9GBFnwqN31K+XOqpLqq+ANalQGzx2FXZif1IVWuyuE3DrL9zOA0LeoTEKpyB0r+e1/xOCM7RBjhapHyzW4TixN5ige13socixOUiwBL1sXx9IDT3zlYCUoFNjy63BZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664529; c=relaxed/simple;
	bh=1Phkk8+XzpLQHH1fIS/H9h7/u+LT38z4A7LdKpR39Oc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LXlD9RP7GlV0pTR3kAbs00Odd8kvdias/ToYQwtPOCnND0fZMmtVlRvBa/4pUIo2tu4sSeHtiV8JT1qeDymwh2NzusULAAHygJDsTNKtFVP0DSDefu5sLAyNOMoIbFY4JRdNIyfptN9bk6Sxcan9a8+q6JcbYGHkuk5navhzkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1PIY6Id; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1PIY6Id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A461F000FF;
	Tue, 29 Sep 2026 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664527;
	bh=X57z54hxNCfSjiX9+LKAX3UovwlWV0kIqvJc9EHXWcM=;
	h=Subject:To:Cc:From:Date;
	b=E1PIY6Id1FvTnWMbzkopzg6WoxGVtn9zhJXszyFXUMciQL6gYStIsIrTUE5GObFr4
	 TcQZc2EJDOiDJ9WyewYi4lXc9K+J4zhvrYs0kTy1AU4bOnnqFBu3yc9/fHVqp14f88
	 5MXZlha+JZoyy5/qxtZ7z4txTBaG/ZD6CErRI0R4=
Subject: FAILED: patch "[PATCH] landlock: Work around gcc-16 -Wuninitialized warning" failed to apply to 7.2-stable tree
To: arnd@arndb.de,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:48:44 +0200
Message-ID: <2026092944-secrecy-crouch-5bf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x c4e941bb7654bcbdfb0b6f3341dc2acfdf235c8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092944-secrecy-crouch-5bf3@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4e941bb7654bcbdfb0b6f3341dc2acfdf235c8d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Sep 2026 22:10:30 +0200
Subject: [PATCH] landlock: Work around gcc-16 -Wuninitialized warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/security/landlock/access.h b/security/landlock/access.h
index bbbb41f41147..f843835851d0 100644
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

