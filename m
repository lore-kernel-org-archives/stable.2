Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA0367B74
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074401; cv=none; b=mFxr8gGKKLHlK5aACUBZOL6kNN8zMFP6rVv6ZLjdTg4pm7NE5KhA+qAYnJSLI2tCPTiLQ3rtuTN5tozkFAtW5QIihLc6RvDz13cBc0I0rIgHi3R+1huWsnZnjLqqZb5w05PkmCC40P9H/Gpe++ihouIyZLdityyk3mkgYjUrB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074401; c=relaxed/simple;
	bh=KlSTnEQn5Oq7pwTBx9/JUyi7deyLPshFy5+Tx8osfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4pmnzlJvseUVr5xExEPvkf5aIDlVSwQ1aEkw3SYFnIke+TTgH78mcpgveZP+gNNn08LQEjgGL1JQ8RPqtwLv06pUpTPCRESyJMWms4gwRua9+80uNJm3Vol4HpKGEv42HSwPkYo+aLl8Jvh4opuN1eFlsJGk3ujx1jqupmBXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvQbjgrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvQbjgrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589ED1F00A3E;
	Sun, 26 Jul 2026 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074399;
	bh=WK8FoT6vmPOGqwwA2QLfX7uUQztTNgkCCjYmbU0wboo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvQbjgrCOexNnpX/cI7fIavIUj/QCrh9KMJKSWC/henOGT8xJ6fJL6FsY01D9NWNV
	 3VmBOCTJyQ35VO/gLWApnh7XFpBiH5eWr1hYREL4TEELTx8w4abdX68eMtrLe3DHF1
	 BCC2x2FKacV+vdgVNjQYeFO0ceQ7xe9s4MUnaLrOjM7sxKRpmPUi3QZLqwssE92HKs
	 7bxP/ADS0xyQSCN1ig+z6C7E2qtbNkLj/ZeOap6cWWHbkZepwtXxWnU7QfilbYhos/
	 ovGH4AUBDCz2bfDBJGracGf7Bp1P/iQbR177zKgiHxJHaL2WslnONR9HRh/Oln1bNr
	 fAbvGDLccRH1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] thunderbolt: Update property.c function documentation
Date: Sun, 26 Jul 2026 09:59:51 -0400
Message-ID: <20260726135955.668115-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726135955.668115-1-sashal@kernel.org>
References: <2026072000-womb-upturned-7ecf@gregkh>
 <20260726135955.668115-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

[ Upstream commit d015642ad36d78e6eba12d8ab96cea6fd4602b49 ]

Make property.c function documentation compliant with current kernel-doc
standards. No functional changes.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/property.c | 38 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index d7598df98b7d0a..dc6fde468722da 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -231,11 +231,13 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
  *
  * This function parses the XDomain properties data block into format that
  * can be traversed using the helper functions provided by this module.
- * Upon success returns the parsed directory. In case of error returns
- * %NULL. The resulting &struct tb_property_dir needs to be released by
+ *
+ * The resulting &struct tb_property_dir needs to be released by
  * calling tb_property_free_dir() when not needed anymore.
  *
  * The @block is expected to be root directory.
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 					      size_t block_len)
@@ -258,6 +260,8 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
  *
  * Creates new, empty property directory. If @uuid is %NULL then the
  * directory is assumed to be root directory.
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_create_dir(const uuid_t *uuid)
 {
@@ -501,9 +505,11 @@ static ssize_t __tb_property_format_dir(const struct tb_property_dir *dir,
  * @block_len: Length of the property block
  *
  * This function formats the directory to the packed format that can be
- * then send over the thunderbolt fabric to receiving host. Returns %0 in
- * case of success and negative errno on faulure. Passing %NULL in @block
- * returns number of entries the block takes.
+ * then sent over the thunderbolt fabric to receiving host.
+ *
+ * Passing %NULL in @block returns number of entries the block takes.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
 			       size_t block_len)
@@ -525,9 +531,9 @@ ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
  * tb_property_copy_dir() - Take a deep copy of directory
  * @dir: Directory to copy
  *
- * This function takes a deep copy of @dir and returns back the copy. In
- * case of error returns %NULL. The resulting directory needs to be
- * released by calling tb_property_free_dir().
+ * The resulting directory needs to be released by calling tb_property_free_dir().
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
 {
@@ -597,6 +603,8 @@ struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
  * @parent: Directory to add the property
  * @key: Key for the property
  * @value: Immediate value to store with the property
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_immediate(struct tb_property_dir *parent, const char *key,
 			      u32 value)
@@ -626,6 +634,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_immediate);
  * @buflen: Number of bytes in the data buffer
  *
  * Function takes a copy of @buf and adds it to the directory.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_data(struct tb_property_dir *parent, const char *key,
 			 const void *buf, size_t buflen)
@@ -662,6 +672,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_data);
  * @text: String to add
  *
  * Function takes a copy of @text and adds it to the directory.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 			 const char *text)
@@ -696,6 +708,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_text);
  * @parent: Directory to add the property
  * @key: Key for the property
  * @dir: Directory to add
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_dir(struct tb_property_dir *parent, const char *key,
 			struct tb_property_dir *dir)
@@ -736,8 +750,10 @@ EXPORT_SYMBOL_GPL(tb_property_remove);
  * @key: Key to look for
  * @type: Type of the property
  *
- * Finds and returns property from the given directory. Does not recurse
- * into sub-directories. Returns %NULL if the property was not found.
+ * Finds and returns property from the given directory. Does not
+ * recurse into sub-directories.
+ *
+ * Return: Pointer to &struct tb_property, %NULL if the property was not found.
  */
 struct tb_property *tb_property_find(struct tb_property_dir *dir,
 	const char *key, enum tb_property_type type)
@@ -757,6 +773,8 @@ EXPORT_SYMBOL_GPL(tb_property_find);
  * tb_property_get_next() - Get next property from directory
  * @dir: Directory holding properties
  * @prev: Previous property in the directory (%NULL returns the first)
+ *
+ * Return: Pointer to &struct tb_property, %NULL if property was not found.
  */
 struct tb_property *tb_property_get_next(struct tb_property_dir *dir,
 					 struct tb_property *prev)
-- 
2.53.0

