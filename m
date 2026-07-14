Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B833594A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003622; cv=none; b=TbbNDizbXtqut8c8BU8i2Dn+cpOR6xsqhXMIoXYLeetTm/+JiFA8VCPY2HxjkOFSVNcFoZPeICyRieI9yDFK6L+9VCa5KyYkI7ZM/vfMwpVmkJyTUBMgr/k7/VE5Ca8gxr+9TpVrvia4ZY7lbm7Vb3oDdjHWrx7Y8TpIV3AxBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003622; c=relaxed/simple;
	bh=M1Mn3+9Uy7M5AanOhNkzLOnh/dVP9q+Y4eLQaskJ6oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d366nbhOb0CBUTLSFXJnZEs/vszOvGSJUeZzq7r82UWuWvgKZDScnmA4SohRclQpHLNuexobWf4vrHjYBs81w2hi2LVLkxBFh5afey8Uwfkzex3x/x56O8wzjULyFVnajNEeo6TW/j1uCXVIGxHvQm9SyWjj92gKjXhk4vrTqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9SolEhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9SolEhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529B81F000E9;
	Tue, 14 Jul 2026 04:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003620;
	bh=nA4UPwrFeP8KV4xaf9d1nDWJ59NZopciHR5+2yKHs0I=;
	h=From:To:Cc:Subject:Date;
	b=N9SolEhcJjKszrhJ0QrCC+5QzBKUaI4WALp7fF79H2cRi5xQuuE0F5+GveMzAtusa
	 EhqLcbP+L0H2WiI5yBWwxmZEg87kgS8/AuIMaIxYsMhjmGGfpFvdAuhH8zONXgfvSg
	 M+evAc/zdkU916QYmp7YKx18SnRMsNTOeovhNTmv8QKhH8E4XWF7DxtiQHEapIn7jv
	 0WOTx8c+D5jwF2EDo/G9CoaM6gBIxZevoVY+3je6dfPW/fGJL6FPOcza6dbVYeuWQ5
	 NoRz1Wm+Mb9qwSCWi6MKz5/RwBudGibWJzxQ9n1l4F2sbfQOqIT9+2f+qYQu93aBAI
	 GudQolqXM90kg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Anisse Astier <an.astier@criteo.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y] efivarfs: expose used and total size
Date: Mon, 13 Jul 2026 23:33:29 -0500
Message-ID: <20260714043329.3510162-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisse Astier <an.astier@criteo.com>

When writing EFI variables, one might get errors with no other message
on why it fails. Being able to see how much is used by EFI variables
helps analyzing such issues.

Since this is not a conventional filesystem, block size is intentionally
set to 1 instead of PAGE_SIZE.

x86 quirks of reserved size are taken into account; so that available
and free size can be different, further helping debugging space issues.

With this patch, one can see the remaining space in EFI variable storage
via efivarfs, like this:

   $ df -h /sys/firmware/efi/efivars/
   Filesystem      Size  Used Avail Use% Mounted on
   efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars

Signed-off-by: Anisse Astier <an.astier@criteo.com>
[ardb: - rename efi_reserved_space() to efivar_reserved_space()
       - whitespace/coding style tweaks]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
(cherry-picked from d86ff3333cb1 ("efivarfs: expose used and total size"))
Adjusted for headers in linux-6.1.y
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc:Steve McIntyre <steve@einval.com> 
Cc:Richard Hughes <richard@hughsie.com>

Background for this backport is that fwupd needs to be able to do CA
updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
process checks for free storage, and needs this function to do it.
 arch/x86/platform/efi/quirks.c |  8 +++++++
 drivers/firmware/efi/efi.c     |  1 +
 drivers/firmware/efi/vars.c    | 12 +++++++++++
 fs/efivarfs/super.c            | 39 +++++++++++++++++++++++++++++++++-
 include/linux/efi.h            | 11 ++++++++++
 5 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933a..f0cc00032751 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
 				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
+u64 efivar_reserved_space(void)
+{
+	if (efi_no_storage_paranoia)
+		return 0;
+	return EFI_MIN_RESERVE;
+}
+EXPORT_SYMBOL_GPL(efivar_reserved_space);
+
 /*
  * In the nonblocking case we do not attempt to perform garbage
  * collection if we do not have enough free space. Rather, we do the
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9786dfff9f84..83b63dd2de9b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -211,6 +211,7 @@ static int generic_ops_register(void)
 	generic_ops.get_variable = efi.get_variable;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
+	generic_ops.query_variable_info = efi.query_variable_info;
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
 		generic_ops.set_variable = efi.set_variable;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 4ca256bcd697..d22160e7c785 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -250,3 +250,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	return status;
 }
 EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
+
+efi_status_t efivar_query_variable_info(u32 attr,
+					u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size)
+{
+	if (!__efivars->ops->query_variable_info)
+		return EFI_UNSUPPORTED;
+	return __efivars->ops->query_variable_info(attr, storage_space,
+			remaining_space, max_variable_size);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b8c4641ed152..6bd100f03aa5 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/printk.h>
+#include <linux/statfs.h>
 
 #include "internal.h"
 
@@ -24,8 +25,44 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	const u32 attr = EFI_VARIABLE_NON_VOLATILE |
+			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			 EFI_VARIABLE_RUNTIME_ACCESS;
+	u64 storage_space, remaining_space, max_variable_size;
+	efi_status_t status;
+
+	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
+					    &max_variable_size);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+
+	/*
+	 * This is not a normal filesystem, so no point in pretending it has a block
+	 * size; we declare f_bsize to 1, so that we can then report the exact value
+	 * sent by EFI QueryVariableInfo in f_blocks and f_bfree
+	 */
+	buf->f_bsize	= 1;
+	buf->f_namelen	= NAME_MAX;
+	buf->f_blocks	= storage_space;
+	buf->f_bfree	= remaining_space;
+	buf->f_type	= dentry->d_sb->s_magic;
+
+	/*
+	 * In f_bavail we declare the free space that the kernel will allow writing
+	 * when the storage_paranoia x86 quirk is active. To use more, users
+	 * should boot the kernel with efi_no_storage_paranoia.
+	 */
+	if (remaining_space > efivar_reserved_space())
+		buf->f_bavail = remaining_space - efivar_reserved_space();
+	else
+		buf->f_bavail = 0;
+
+	return 0;
+}
 static const struct super_operations efivarfs_ops = {
-	.statfs = simple_statfs,
+	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
 };
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1d73c77051c0..5868c4b29332 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1039,6 +1039,7 @@ struct efivar_operations {
 	efi_set_variable_t *set_variable;
 	efi_set_variable_t *set_variable_nonblocking;
 	efi_query_variable_store_t *query_variable_store;
+	efi_query_variable_info_t *query_variable_info;
 };
 
 struct efivars {
@@ -1047,6 +1048,12 @@ struct efivars {
 	const struct efivar_operations *ops;
 };
 
+#ifdef CONFIG_X86
+u64 __attribute_const__ efivar_reserved_space(void);
+#else
+static inline u64 efivar_reserved_space(void) { return 0; }
+#endif
+
 /*
  * The maximum size of VariableName + Data = 1024
  * Therefore, it's reasonable to save that much
@@ -1081,6 +1088,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 				 u32 attr, unsigned long data_size, void *data);
 
+efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size);
+
 #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.53.0

