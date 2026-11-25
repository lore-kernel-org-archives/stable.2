Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611614;
	b=33Ge43GV3rylxYIvNMmepzd1XsECWFh1ThMsg9K7k+/UK5XknORPgs80wA7wSAVx17BS
	 JNNoavJYWrJJwMkRfmGxy7XhfwHtuvg3rdswnCchX/5KtVTDqshDa8cR33zsyIG1h+bPj
	 q/gOYkUoFlwj1NhPngPhg1Z1k2D1Nod6ki3jipvkrJN+e5GEO+ss/gbtll0EYpBhGiCAG
	 3DMxR8mReUfVi/oy+gsdcMLlSD6eBxfFTwxlgHt7Rx6sY3zOA+K054EhHlARz61oA/ODX
	 IuvGLZ1E165AsfYJeZgokO7mViu4Q5WrPM3KJQminrWV2WUKvCCkL4/uoyJidW55glQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611614;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kB6sssdQqvpTBWbjUpzu/3jhiDUw/0nRaqYiBZB4vY8=;
	b=s8wS4zSvPd+n8kQX7uaknG9yg+FF8D+5LElc9f4Z6ZSG7uAiwactO1TDbGxzSw96uOFw
	 WPsf4UXps9d9dEZJ2oHfIQGz9rHPohmg0liMIa8d4+MqfheKgQdmHh4ysXohYkHfqySKp
	 R7gPUxfc6MSWPoTutjsG8dNB/SM+yKY5g8SWwl8K+tPqcatkOLAo3tTBCuJAyr76u5DHA
	 MTaoooYbs8xJAN9RNogF4POEdj6G75yNzDF9O/6FgPOUd/SITETW6EzeeNiwgz2BckrZj
	 X4e2jsImEM2oylDwD37YKiMAc4a1OIaSv9u2gBEUMTmA+/c+h5XQJ6Gatrs8aMoIvdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VA+JuJjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CF606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VA+JuJjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C588C1F000E1;
	Wed, 25 Nov 2026 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795611614;
	bh=kB6sssdQqvpTBWbjUpzu/3jhiDUw/0nRaqYiBZB4vY8=;
	h=Subject:To:Cc:From:Date;
	b=VA+JuJjLpU0Sp0VJ4rTnBlGYCfeHzF9Vc7F40pmyABrkjfVH9Y2I76LGti/IJh0zD
	 7qhQWFpilHjWI8zhABR0Ci/eUUqjTEz126BWAx06vIaokENL/K8dt2R1tQ3rLvvDfL
	 qURFKeCiV7eU8bJUkFDbku9P4Tq27ajLVHJdppUk=
Subject: FAILED: patch "[PATCH] drm: xe: select configfs" failed to apply to 7.3-stable tree
To: arnd@arndb.de,matthew.brost@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:56:16 +0100
Message-ID: <2026112516-kinfolk-cozy-4aea@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x c1234293de147949bf9cf06e3ed59ad8766e29a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112516-kinfolk-cozy-4aea@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1234293de147949bf9cf06e3ed59ad8766e29a0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Oct 2026 11:25:50 +0100
Subject: [PATCH] drm: xe: select configfs

The original addition of configfs to xe missed a compile-time dependency,
which leads to a link failure when configfs is enabled as a loadable module:

ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
>>> referenced by xe_survivability_mode.c:224
>>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a

A recent workaround added a 'IS_REACHABLE()' check around the calls into
configfs, which makes it link in this configuration, but this is generally
a bad idea because it makes the actual behavior inconsistent and confusing
to users that expect configfs to work if both xe and configfs are enabled.

Use 'select CONFIGFS_FS' instead, like every other configfs user does,
and remove the unnecessary stub functions. There is little practical
difference here as anyone using XE graphics is likely to have a complex
configuration that already selects configfs anyway, and the link error
or the IS_REACHABLE() would only manifest during randconfig testing.

Fixes: da475c094342 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20261026102603.2045493-1-arnd@kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit be73339dd9d70623b7dbc9c4e3b966824b771069)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 502c7b3c1f16..049d2f25d0e6 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -10,6 +10,7 @@ config DRM_XE
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
 	select TMPFS
+	select CONFIGFS_FS
 	select DRM_BUDDY
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
index 327b648944ff..d726800de26a 100644
--- a/drivers/gpu/drm/xe/xe_configfs.h
+++ b/drivers/gpu/drm/xe/xe_configfs.h
@@ -14,7 +14,6 @@
 
 struct pci_dev;
 
-#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
 int xe_configfs_init(void);
 void xe_configfs_exit(void);
 void xe_configfs_check_device(struct pci_dev *pdev);
@@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
 unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
 bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
 #endif
-#else
-static inline int xe_configfs_init(void) { return 0; }
-static inline void xe_configfs_exit(void) { }
-static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
-static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
-static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
-static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
-static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
-static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
-static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
-static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
-static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
-static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
-						     enum xe_engine_class class,
-						     const u32 **cs) { return 0; }
-static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
-						      enum xe_engine_class class,
-						      const u32 **cs) { return 0; }
-#ifdef CONFIG_PCI_IOV
-static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
-{
-	return xe_modparam.max_vfs;
-}
-static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
-{
-	return XE_DEFAULT_ADMIN_ONLY_PF;
-}
-#endif
-#endif
 
 #endif

