Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A24FC8C5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649371; cv=none; b=nTNsF7Up/nLbhcCU5ZA6Nzi5sL2jGOd76vPPfEByUIE46lDDTHM0JxjknqkBQcXH2MGxnfyz1l/a9k8JaFrr9+04cPNE83/ATZDxeuicYLVuG1HbsmEwukBPNHfi0Lnuu7oLfRheF2lr6OeEefEzpiW5EWutlE8zb5iCixXYEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649371; c=relaxed/simple;
	bh=VTcWUW2qqxEAusQ4HbpA2XvC9MXg3brRKD4ZHNXizl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViXMGyHlC2Sce1SzFoKC0X2QrqC0uE2Z5Xr6TEh/J/F7eQ9t2gtYiz7lYHVWX1NKa1pTgqge9oTEZ+M+euf3+PWBfgg/Dotdd/3xadbvfQgsyfMJsxrpZidiO0geYus+5HSaU57H5BR+tyTQC0Q8ol136iro7jRUKG2cJkpz9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkOxbVrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkOxbVrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CDD1F008A1;
	Thu, 17 Sep 2026 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649351;
	bh=f1xnq43/sSBCkmEBk8gQFiHEJJiZxRZGnhJb1TmlXZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkOxbVrj0i+gZM4Rsjx5Rt1yB5c0siO8dR4hbvyaWS6I/d+XhYiusJN/XlZRVwdVb
	 dXDa8TFymvqNA1oMbDawsjbUPOslEOjdlkmHWKaHOZ8quwESOBteJSXCnyFxPlJCyW
	 U1ocvZn88+l7h1pX+1FQGBhhyJ/pURcajr0T1anGBagjf4VXMqKF1H1cpQ2ONLrDXX
	 KX0nYmNGrAqlp6iDc+kj81LvpVTqdQdh+p0kDVIa0EzG/AJuriEYO72AbFMe0mVMAA
	 xc8T/dT2k0RhY4xLC4zffDhrT836JodowQQM4yF0B69ors3nFH+S8dphShl6kzMlev
	 wA/kue/2o3b9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] smb/client: rename cifs_sid to smb_sid
Date: Thu, 17 Sep 2026 08:49:06 -0400
Message-ID: <20260917124909.224558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091604-pug-prewashed-fdb3@gregkh>
References: <2026091604-pug-prewashed-fdb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 7f599d8fb3e087aff5be4e1392baaae3f8d42419 ]

Preparation for moving acl definitions to new common header file.

Use the following shell command to rename:

  find fs/smb/client -type f -exec sed -i \
    's/struct cifs_sid/struct smb_sid/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

Stable dependency adaptation for d05045177a855386bca5e1909e08d06290e6e3b3:

Apply the SID rename to the 6.1 implementation, including validate_dacl(),
without importing the absent cifs_open_info_data POSIX fields or the newer
compound-request control flow. Keep the stable security descriptor type
and existing validation.

Also prepare the exact ACL rewrite interfaces needed by the target: rename
cifs_acl/cifs_ace to smb_acl/smb_ace, use the upstream 16-bit ACE count and
reserved field, and thread the POSIX and ACL flag arguments through the
existing helpers. Both entry points pass false for POSIX mode ACE encoding
to preserve this branch's behavior. No functions are added.

Include the worst-case owner/group rewrite allocation from 0ee150794c75b:
the target checks the accumulated DACL size after copying an ACE, so the
allocation must already cover every expanded ACE plus its ACL header.
Zero-initialize the new descriptor so the split-out reserved field and
other unwritten descriptor bytes remain zero.

The target's overflow checks and error propagation remain in the target;
its unmodified patch applies cleanly after this preparation.

Stable-dep-of: d05045177a85 ("smb: client: fail DACL rewrite when the new DACL exceeds 64K")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c   | 298 ++++++++++++++++++++------------------
 fs/smb/client/cifsacl.h   |  17 ++-
 fs/smb/client/cifsglob.h  |   6 +-
 fs/smb/client/cifsproto.h |   9 +-
 fs/smb/client/smb2inode.c |   4 +-
 fs/smb/client/smb2pdu.c   |  10 +-
 fs/smb/client/smb2pdu.h   |   8 +-
 7 files changed, 185 insertions(+), 167 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 3dbc71556cb00..879dcd4b2f353 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -22,18 +22,18 @@
 #include "fs_context.h"
 
 /* security id for everyone/world system group */
-static const struct cifs_sid sid_everyone = {
+static const struct smb_sid sid_everyone = {
 	1, 1, {0, 0, 0, 0, 0, 1}, {0} };
 /* security id for Authenticated Users system group */
-static const struct cifs_sid sid_authusers = {
+static const struct smb_sid sid_authusers = {
 	1, 1, {0, 0, 0, 0, 0, 5}, {cpu_to_le32(11)} };
 
 /* S-1-22-1 Unmapped Unix users */
-static const struct cifs_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
+static const struct smb_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
 		{cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-22-2 Unmapped Unix groups */
-static const struct cifs_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
+static const struct smb_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
 		{cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /*
@@ -43,17 +43,17 @@ static const struct cifs_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
 /* S-1-5-88 MS NFS and Apple style UID/GID/mode */
 
 /* S-1-5-88-1 Unix uid */
-static const struct cifs_sid sid_unix_NFS_users = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_users = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-5-88-2 Unix gid */
-static const struct cifs_sid sid_unix_NFS_groups = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_groups = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-5-88-3 Unix mode */
-static const struct cifs_sid sid_unix_NFS_mode = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_mode = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
@@ -101,7 +101,7 @@ static struct key_type cifs_idmap_key_type = {
 };
 
 static char *
-sid_to_key_str(struct cifs_sid *sidptr, unsigned int type)
+sid_to_key_str(struct smb_sid *sidptr, unsigned int type)
 {
 	int i, len;
 	unsigned int saval;
@@ -153,7 +153,7 @@ sid_to_key_str(struct cifs_sid *sidptr, unsigned int type)
  * the same returns zero, if they do not match returns non-zero.
  */
 static int
-compare_sids(const struct cifs_sid *ctsid, const struct cifs_sid *cwsid)
+compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 {
 	int i;
 	int num_subauth, num_sat, num_saw;
@@ -199,11 +199,11 @@ compare_sids(const struct cifs_sid *ctsid, const struct cifs_sid *cwsid)
 }
 
 static bool
-is_well_known_sid(const struct cifs_sid *psid, uint32_t *puid, bool is_group)
+is_well_known_sid(const struct smb_sid *psid, uint32_t *puid, bool is_group)
 {
 	int i;
 	int num_subauth;
-	const struct cifs_sid *pwell_known_sid;
+	const struct smb_sid *pwell_known_sid;
 
 	if (!psid || (puid == NULL))
 		return false;
@@ -255,7 +255,7 @@ is_well_known_sid(const struct cifs_sid *psid, uint32_t *puid, bool is_group)
 }
 
 static __u16
-cifs_copy_sid(struct cifs_sid *dst, const struct cifs_sid *src)
+cifs_copy_sid(struct smb_sid *dst, const struct smb_sid *src)
 {
 	int i;
 	__u16 size = 1 + 1 + 6;
@@ -272,11 +272,11 @@ cifs_copy_sid(struct cifs_sid *dst, const struct cifs_sid *src)
 }
 
 static int
-id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
+id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 {
 	int rc;
 	struct key *sidkey;
-	struct cifs_sid *ksid;
+	struct smb_sid *ksid;
 	unsigned int ksid_size;
 	char desc[3 + 10 + 1]; /* 3 byte prefix + 10 bytes for value + NULL */
 	const struct cred *saved_cred;
@@ -307,8 +307,8 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 	 * it could be.
 	 */
 	ksid = sidkey->datalen <= sizeof(sidkey->payload) ?
-		(struct cifs_sid *)&sidkey->payload :
-		(struct cifs_sid *)sidkey->payload.data[0];
+		(struct smb_sid *)&sidkey->payload :
+		(struct smb_sid *)sidkey->payload.data[0];
 
 	ksid_size = CIFS_SID_BASE_SIZE + (ksid->num_subauth * sizeof(__le32));
 	if (ksid_size > sidkey->datalen) {
@@ -331,7 +331,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 }
 
 int
-sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
+sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 		struct cifs_fattr *fattr, uint sidtype)
 {
 	int rc = 0;
@@ -513,11 +513,11 @@ exit_cifs_idmap(void)
 static __u32 copy_sec_desc(const struct cifs_ntsd *pntsd,
 				struct cifs_ntsd *pnntsd,
 				__u32 sidsoffset,
-				struct cifs_sid *pownersid,
-				struct cifs_sid *pgrpsid)
+				struct smb_sid *pownersid,
+				struct smb_sid *pgrpsid)
 {
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_sid *nowner_sid_ptr, *ngroup_sid_ptr;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *nowner_sid_ptr, *ngroup_sid_ptr;
 
 	/* copy security descriptor control portion */
 	pnntsd->revision = pntsd->revision;
@@ -525,28 +525,28 @@ static __u32 copy_sec_desc(const struct cifs_ntsd *pntsd,
 	pnntsd->dacloffset = cpu_to_le32(sizeof(struct cifs_ntsd));
 	pnntsd->sacloffset = 0;
 	pnntsd->osidoffset = cpu_to_le32(sidsoffset);
-	pnntsd->gsidoffset = cpu_to_le32(sidsoffset + sizeof(struct cifs_sid));
+	pnntsd->gsidoffset = cpu_to_le32(sidsoffset + sizeof(struct smb_sid));
 
 	/* copy owner sid */
 	if (pownersid)
 		owner_sid_ptr = pownersid;
 	else
-		owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+		owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->osidoffset));
-	nowner_sid_ptr = (struct cifs_sid *)((char *)pnntsd + sidsoffset);
+	nowner_sid_ptr = (struct smb_sid *)((char *)pnntsd + sidsoffset);
 	cifs_copy_sid(nowner_sid_ptr, owner_sid_ptr);
 
 	/* copy group sid */
 	if (pgrpsid)
 		group_sid_ptr = pgrpsid;
 	else
-		group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+		group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
-	ngroup_sid_ptr = (struct cifs_sid *)((char *)pnntsd + sidsoffset +
-					sizeof(struct cifs_sid));
+	ngroup_sid_ptr = (struct smb_sid *)((char *)pnntsd + sidsoffset +
+					sizeof(struct smb_sid));
 	cifs_copy_sid(ngroup_sid_ptr, group_sid_ptr);
 
-	return sidsoffset + (2 * sizeof(struct cifs_sid));
+	return sidsoffset + (2 * sizeof(struct smb_sid));
 }
 
 
@@ -661,7 +661,7 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	return;
 }
 
-static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct cifs_sid *psid)
+static __u16 cifs_copy_ace(struct smb_ace *dst, struct smb_ace *src, struct smb_sid *psid)
 {
 	__u16 size = 1 + 1 + 2 + 4;
 
@@ -680,8 +680,8 @@ static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct ci
 	return size;
 }
 
-static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
-			const struct cifs_sid *psid, __u64 nmode,
+static __u16 fill_ace_for_sid(struct smb_ace *pntace,
+			const struct smb_sid *psid, __u64 nmode,
 			umode_t bits, __u8 access_type,
 			bool allow_delete_child)
 {
@@ -718,7 +718,7 @@ static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
 
 
 #ifdef CONFIG_CIFS_DEBUG2
-static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
+static void dump_ace(struct smb_ace *pace, char *end_of_acl)
 {
 	int num_subauth;
 
@@ -753,44 +753,44 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 }
 #endif
 
-static int validate_dacl(struct cifs_acl *pdacl, char *end_of_acl)
+static int validate_dacl(struct smb_acl *pdacl, char *end_of_acl)
 {
 	int i, ace_hdr_size, ace_size, min_ace_size;
 	u16 dacl_size;
 	u32 num_aces;
 	char *acl_base, *end_of_dacl;
-	struct cifs_ace *pace;
+	struct smb_ace *pace;
 
 	if (!pdacl)
 		return 0;
 
-	if (end_of_acl < (char *)pdacl + sizeof(struct cifs_acl)) {
+	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl)) {
 		cifs_dbg(VFS, "ACL too small to parse DACL\n");
 		return -EINVAL;
 	}
 
 	dacl_size = le16_to_cpu(pdacl->size);
-	if (dacl_size < sizeof(struct cifs_acl) ||
+	if (dacl_size < sizeof(struct smb_acl) ||
 	    end_of_acl < (char *)pdacl + dacl_size) {
 		cifs_dbg(VFS, "ACL too small to parse DACL\n");
 		return -EINVAL;
 	}
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (!num_aces)
 		return 0;
 
-	ace_hdr_size = offsetof(struct cifs_ace, sid) +
-		offsetof(struct cifs_sid, sub_auth);
+	ace_hdr_size = offsetof(struct smb_ace, sid) +
+		offsetof(struct smb_sid, sub_auth);
 	min_ace_size = ace_hdr_size + sizeof(__le32);
-	if (num_aces > (dacl_size - sizeof(struct cifs_acl)) / min_ace_size) {
+	if (num_aces > (dacl_size - sizeof(struct smb_acl)) / min_ace_size) {
 		cifs_dbg(VFS, "ACL too small to parse DACL\n");
 		return -EINVAL;
 	}
 
 	end_of_dacl = (char *)pdacl + dacl_size;
 	acl_base = (char *)pdacl;
-	ace_size = sizeof(struct cifs_acl);
+	ace_size = sizeof(struct smb_acl);
 
 	for (i = 0; i < num_aces; ++i) {
 		if (end_of_dacl - acl_base < ace_size) {
@@ -798,7 +798,7 @@ static int validate_dacl(struct cifs_acl *pdacl, char *end_of_acl)
 			return -EINVAL;
 		}
 
-		pace = (struct cifs_ace *)(acl_base + ace_size);
+		pace = (struct smb_ace *)(acl_base + ace_size);
 		acl_base = (char *)pace;
 
 		if (end_of_dacl - acl_base < ace_hdr_size ||
@@ -825,15 +825,15 @@ static int validate_dacl(struct cifs_acl *pdacl, char *end_of_acl)
 	return 0;
 }
 
-static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
-		       struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
+static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
+		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
 	int i;
 	int num_aces = 0;
 	int acl_size;
 	char *acl_base, *end_of_dacl;
-	struct cifs_ace **ppace;
+	struct smb_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
 
@@ -849,7 +849,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
-		 le32_to_cpu(pdacl->num_aces));
+		 le16_to_cpu(pdacl->num_aces));
 
 	/* reset rwx permissions for user/group/other.
 	   Also, if num_aces is 0 i.e. DACL has no ACEs,
@@ -858,21 +858,21 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 
 	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
-	acl_size = sizeof(struct cifs_acl);
+	acl_size = sizeof(struct smb_acl);
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > ULONG_MAX / sizeof(struct cifs_ace *))
+		if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 			return;
-		ppace = kmalloc_array(num_aces, sizeof(struct cifs_ace *),
+		ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *),
 				      GFP_KERNEL);
 		if (!ppace)
 			return;
 
 		for (i = 0; i < num_aces; ++i) {
-			ppace[i] = (struct cifs_ace *) (acl_base + acl_size);
+			ppace[i] = (struct smb_ace *) (acl_base + acl_size);
 #ifdef CONFIG_CIFS_DEBUG2
 			dump_ace(ppace[i], end_of_dacl);
 #endif
@@ -915,7 +915,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 
 /*			memcpy((void *)(&(cifscred->aces[i])),
 				(void *)ppace[i],
-				sizeof(struct cifs_ace)); */
+				sizeof(struct smb_ace)); */
 
 			acl_base = (char *)ppace[i];
 			acl_size = le16_to_cpu(ppace[i]->size);
@@ -927,7 +927,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	return;
 }
 
-unsigned int setup_authusers_ACE(struct cifs_ace *pntace)
+unsigned int setup_authusers_ACE(struct smb_ace *pntace)
 {
 	int i;
 	unsigned int ace_size = 20;
@@ -951,12 +951,17 @@ unsigned int setup_authusers_ACE(struct cifs_ace *pntace)
  * Fill in the special SID based on the mode. See
  * https://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx
  */
-unsigned int setup_special_mode_ACE(struct cifs_ace *pntace, __u64 nmode)
+unsigned int setup_special_mode_ACE(struct smb_ace *pntace,
+				    bool posix,
+				    __u64 nmode)
 {
 	int i;
 	unsigned int ace_size = 28;
 
-	pntace->type = ACCESS_DENIED_ACE_TYPE;
+	if (posix)
+		pntace->type = ACCESS_ALLOWED_ACE_TYPE;
+	else
+		pntace->type = ACCESS_DENIED_ACE_TYPE;
 	pntace->flags = 0x0;
 	pntace->access_req = 0;
 	pntace->sid.num_subauth = 3;
@@ -973,7 +978,7 @@ unsigned int setup_special_mode_ACE(struct cifs_ace *pntace, __u64 nmode)
 	return ace_size;
 }
 
-unsigned int setup_special_user_owner_ACE(struct cifs_ace *pntace)
+unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
 {
 	int i;
 	unsigned int ace_size = 28;
@@ -996,13 +1001,14 @@ unsigned int setup_special_user_owner_ACE(struct cifs_ace *pntace)
 }
 
 static void populate_new_aces(char *nacl_base,
-		struct cifs_sid *pownersid,
-		struct cifs_sid *pgrpsid,
-		__u64 *pnmode, u32 *pnum_aces, u16 *pnsize,
-		bool modefromsid)
+		struct smb_sid *pownersid,
+		struct smb_sid *pgrpsid,
+		__u64 *pnmode, u16 *pnum_aces, u16 *pnsize,
+		bool modefromsid,
+		bool posix)
 {
 	__u64 nmode;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	u16 nsize = 0;
 	__u64 user_mode;
 	__u64 group_mode;
@@ -1010,19 +1016,21 @@ static void populate_new_aces(char *nacl_base,
 	__u64 deny_user_mode = 0;
 	__u64 deny_group_mode = 0;
 	bool sticky_set = false;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 
 	nmode = *pnmode;
 	num_aces = *pnum_aces;
 	nsize = *pnsize;
 
-	if (modefromsid) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
-		nsize += setup_special_mode_ACE(pnntace, nmode);
-		num_aces++;
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
-		nsize += setup_authusers_ACE(pnntace);
+	if (modefromsid || posix) {
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
+		nsize += setup_special_mode_ACE(pnntace, posix, nmode);
 		num_aces++;
+		if (modefromsid) {
+			pnntace = (struct smb_ace *) (nacl_base + nsize);
+			nsize += setup_authusers_ACE(pnntace);
+			num_aces++;
+		}
 		goto set_size;
 	}
 
@@ -1033,7 +1041,7 @@ static void populate_new_aces(char *nacl_base,
 	 * updated in the inode.
 	 */
 
-	if (!memcmp(pownersid, pgrpsid, sizeof(struct cifs_sid))) {
+	if (!memcmp(pownersid, pgrpsid, sizeof(struct smb_sid))) {
 		/*
 		 * Case when owner and group SIDs are the same.
 		 * Set the more restrictive of the two modes.
@@ -1058,7 +1066,7 @@ static void populate_new_aces(char *nacl_base,
 		sticky_set = true;
 
 	if (deny_user_mode) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pownersid, deny_user_mode,
 				0700, ACCESS_DENIED, false);
 		num_aces++;
@@ -1066,31 +1074,31 @@ static void populate_new_aces(char *nacl_base,
 
 	/* Group DENY ACE does not conflict with owner ALLOW ACE. Keep in preferred order*/
 	if (deny_group_mode && !(deny_group_mode & (user_mode >> 3))) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pgrpsid, deny_group_mode,
 				0070, ACCESS_DENIED, false);
 		num_aces++;
 	}
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, pownersid, user_mode,
 			0700, ACCESS_ALLOWED, true);
 	num_aces++;
 
 	/* Group DENY ACE conflicts with owner ALLOW ACE. So keep it after. */
 	if (deny_group_mode && (deny_group_mode & (user_mode >> 3))) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pgrpsid, deny_group_mode,
 				0070, ACCESS_DENIED, false);
 		num_aces++;
 	}
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, pgrpsid, group_mode,
 			0070, ACCESS_ALLOWED, !sticky_set);
 	num_aces++;
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, &sid_everyone, other_mode,
 			0007, ACCESS_ALLOWED, !sticky_set);
 	num_aces++;
@@ -1100,38 +1108,42 @@ static void populate_new_aces(char *nacl_base,
 	*pnsize = nsize;
 }
 
-static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
-		struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
-		struct cifs_sid *pnownersid, struct cifs_sid *pngrpsid)
+static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
+		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
+		struct smb_sid *pnownersid, struct smb_sid *pngrpsid,
+		int *aclflag)
 {
 	int i;
 	u16 size = 0;
-	struct cifs_ace *pntace = NULL;
+	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u16 ace_size = 0;
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	size = sizeof(struct smb_acl);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* Go through all the ACEs */
 	for (i = 0; i < src_num_aces; ++i) {
-		pntace = (struct cifs_ace *) (acl_base + size);
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pntace = (struct smb_ace *) (acl_base + size);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 
-		if (pnownersid && compare_sids(&pntace->sid, pownersid) == 0)
+		if (pnownersid && compare_sids(&pntace->sid, pownersid) == 0) {
 			ace_size = cifs_copy_ace(pnntace, pntace, pnownersid);
-		else if (pngrpsid && compare_sids(&pntace->sid, pgrpsid) == 0)
+			*aclflag |= CIFS_ACL_DACL;
+		} else if (pngrpsid && compare_sids(&pntace->sid, pgrpsid) == 0) {
 			ace_size = cifs_copy_ace(pnntace, pntace, pngrpsid);
-		else
+			*aclflag |= CIFS_ACL_DACL;
+		} else {
 			ace_size = cifs_copy_ace(pnntace, pntace, NULL);
+		}
 
 		size += le16_to_cpu(pntace->size);
 		nsize += ace_size;
@@ -1140,48 +1152,48 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 	return nsize;
 }
 
-static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
-		struct cifs_sid *pownersid,	struct cifs_sid *pgrpsid,
-		__u64 *pnmode, bool mode_from_sid)
+static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
+		struct smb_sid *pownersid,	struct smb_sid *pgrpsid,
+		__u64 *pnmode, bool mode_from_sid, bool posix)
 {
 	int i;
 	u16 size = 0;
-	struct cifs_ace *pntace = NULL;
+	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	bool new_aces_set = false;
 
 	/* Assuming that pndacl and pnmode are never NULL */
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* If pdacl is NULL, we don't have a src. Simply populate new ACL. */
-	if (!pdacl) {
+	if (!pdacl || posix) {
 		populate_new_aces(nacl_base,
 				pownersid, pgrpsid,
 				pnmode, &num_aces, &nsize,
-				mode_from_sid);
+				mode_from_sid, posix);
 		goto finalize_dacl;
 	}
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	size = sizeof(struct smb_acl);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	/* Retain old ACEs which we can retain */
 	for (i = 0; i < src_num_aces; ++i) {
-		pntace = (struct cifs_ace *) (acl_base + size);
+		pntace = (struct smb_ace *) (acl_base + size);
 
 		if (!new_aces_set && (pntace->flags & INHERITED_ACE)) {
 			/* Place the new ACEs in between existing explicit and inherited */
 			populate_new_aces(nacl_base,
 					pownersid, pgrpsid,
 					pnmode, &num_aces, &nsize,
-					mode_from_sid);
+					mode_from_sid, posix);
 
 			new_aces_set = true;
 		}
@@ -1196,7 +1208,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 		}
 
 		/* update the pointer to the next ACE to populate*/
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 
 		nsize += cifs_copy_ace(pnntace, pntace, NULL);
 		num_aces++;
@@ -1210,19 +1222,19 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 		populate_new_aces(nacl_base,
 				pownersid, pgrpsid,
 				pnmode, &num_aces, &nsize,
-				mode_from_sid);
+				mode_from_sid, posix);
 
 		new_aces_set = true;
 	}
 
 finalize_dacl:
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(nsize);
 
 	return 0;
 }
 
-static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
+static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 {
 	/* BB need to add parm so we can store the SID BB */
 
@@ -1256,13 +1268,13 @@ static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
 
 static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
 {
-	if (acl_len < sizeof(struct cifs_acl))
+	if (acl_len < sizeof(struct smb_acl))
 		return false;
 
 	if (dacloffset < sizeof(struct cifs_ntsd))
 		return false;
 
-	return dacloffset <= acl_len - sizeof(struct cifs_acl);
+	return dacloffset <= acl_len - sizeof(struct smb_acl);
 }
 
 
@@ -1272,17 +1284,17 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		bool get_mode_from_special_sid)
 {
 	int rc = 0;
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
 
 	if (pntsd == NULL)
 		return -EIO;
 
-	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->osidoffset));
-	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
@@ -1321,7 +1333,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 			return -EINVAL;
 		}
 
-		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
 	} else {
@@ -1334,16 +1346,16 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 /* Convert permission bits from mode to equivalent CIFS ACL */
 static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 	__u32 secdesclen, __u32 *pnsecdesclen, __u64 *pnmode, kuid_t uid, kgid_t gid,
-	bool mode_from_sid, bool id_from_sid, int *aclflag)
+	bool mode_from_sid, bool id_from_sid, bool posix, int *aclflag)
 {
 	int rc = 0;
 	__u32 dacloffset;
 	__u32 ndacloffset;
 	__u32 sidsoffset;
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
-	struct cifs_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
-	struct cifs_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
+	struct smb_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
+	struct smb_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + secdesclen;
 	u16 size = 0;
 
@@ -1354,28 +1366,28 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 			return -EINVAL;
 		}
 
-		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		rc = validate_dacl(dacl_ptr, end_of_acl);
 		if (rc)
 			return rc;
 	}
 
-	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 			le32_to_cpu(pntsd->osidoffset));
-	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 			le32_to_cpu(pntsd->gsidoffset));
 
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
 		ndacloffset = sizeof(struct cifs_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 
 		ndacl_ptr->size = cpu_to_le16(0);
-		ndacl_ptr->num_aces = cpu_to_le32(0);
+		ndacl_ptr->num_aces = cpu_to_le16(0);
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
-				    pnmode, mode_from_sid);
+				    pnmode, mode_from_sid, posix);
 
 		sidsoffset = ndacloffset + le16_to_cpu(ndacl_ptr->size);
 		/* copy the non-dacl portion of secdesc */
@@ -1385,14 +1397,14 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 		*aclflag |= CIFS_ACL_DACL;
 	} else {
 		ndacloffset = sizeof(struct cifs_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 		ndacl_ptr->num_aces = dacl_ptr ? dacl_ptr->num_aces : 0;
 
 		if (uid_valid(uid)) { /* chown */
 			uid_t id;
-			nowner_sid_ptr = kzalloc(sizeof(struct cifs_sid),
+			nowner_sid_ptr = kzalloc(sizeof(struct smb_sid),
 								GFP_KERNEL);
 			if (!nowner_sid_ptr) {
 				rc = -ENOMEM;
@@ -1421,7 +1433,7 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 		}
 		if (gid_valid(gid)) { /* chgrp */
 			gid_t id;
-			ngroup_sid_ptr = kzalloc(sizeof(struct cifs_sid),
+			ngroup_sid_ptr = kzalloc(sizeof(struct smb_sid),
 								GFP_KERNEL);
 			if (!ngroup_sid_ptr) {
 				rc = -ENOMEM;
@@ -1453,7 +1465,8 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 			/* Replace ACEs for old owner with new one */
 			size = replace_sids_and_copy_aces(dacl_ptr, ndacl_ptr,
 					owner_sid_ptr, group_sid_ptr,
-					nowner_sid_ptr, ngroup_sid_ptr);
+					nowner_sid_ptr, ngroup_sid_ptr,
+					aclflag);
 			ndacl_ptr->size = cpu_to_le16(size);
 		}
 
@@ -1667,7 +1680,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
-	struct cifs_acl *dacl_ptr = NULL;
+	struct smb_acl *dacl_ptr = NULL;
 	struct cifs_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct cifs_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -1712,12 +1725,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	nsecdesclen = secdesclen;
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
 		if (mode_from_sid)
-			nsecdesclen += 2 * sizeof(struct cifs_ace);
+			nsecdesclen += 2 * sizeof(struct smb_ace);
 		else /* cifsacl */
-			nsecdesclen += 5 * sizeof(struct cifs_ace);
+			nsecdesclen += 5 * sizeof(struct smb_ace);
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
-		nsecdesclen = sizeof(struct cifs_ntsd) + (sizeof(struct cifs_sid) * 2);
+		nsecdesclen = sizeof(struct cifs_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			if (!dacl_offset_valid(secdesclen, dacloffset)) {
@@ -1726,18 +1739,20 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 				goto id_mode_to_cifs_acl_exit;
 			}
 
-			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
 			if (rc) {
 				kfree(pntsd);
 				cifs_put_tlink(tlink);
 				return rc;
 			}
-			if (mode_from_sid)
-				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
-			else /* cifsacl */
-				nsecdesclen += le16_to_cpu(dacl_ptr->size);
+			/*
+			 * Worst case: every ACE is rewritten with a new SID of
+			 * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(smb_ace) each,
+			 * plus the smb_acl header replace_sids_and_copy_aces() emits.
+			 */
+			nsecdesclen += sizeof(struct smb_acl) +
+				le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 		}
 	}
 
@@ -1748,15 +1763,16 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	 * descriptor parameters, and security descriptor itself
 	 */
 	nsecdesclen = max_t(u32, nsecdesclen, DEFAULT_SEC_DESC_LEN);
-	pnntsd = kmalloc(nsecdesclen, GFP_KERNEL);
+	pnntsd = kzalloc(nsecdesclen, GFP_KERNEL);
 	if (!pnntsd) {
 		kfree(pntsd);
 		cifs_put_tlink(tlink);
 		return -ENOMEM;
 	}
 
+	/* Preserve the legacy mode ACE encoding on this stable branch. */
 	rc = build_sec_desc(pntsd, pnntsd, secdesclen, &nsecdesclen, pnmode, uid, gid,
-			    mode_from_sid, id_from_sid, &aclflag);
+			    mode_from_sid, id_from_sid, false, &aclflag);
 
 	cifs_dbg(NOISY, "build_sec_desc rc: %d\n", rc);
 
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index ccbfc754bd3c7..b925f13e552f7 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -34,8 +34,8 @@
  * owner, group and world).
  */
 #define DEFAULT_SEC_DESC_LEN (sizeof(struct cifs_ntsd) + \
-			      sizeof(struct cifs_acl) + \
-			      (sizeof(struct cifs_ace) * 4))
+			      sizeof(struct smb_acl) + \
+			      (sizeof(struct smb_ace) * 4))
 
 /*
  * Maximum size of a string representation of a SID:
@@ -64,20 +64,21 @@ struct cifs_ntsd {
 	__le32 dacloffset;
 } __attribute__((packed));
 
-struct cifs_sid {
+struct smb_sid {
 	__u8 revision; /* revision level */
 	__u8 num_subauth;
 	__u8 authority[NUM_AUTHS];
 	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
 } __attribute__((packed));
 
-/* size of a struct cifs_sid, sans sub_auth array */
+/* size of a struct smb_sid, sans sub_auth array */
 #define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
 
-struct cifs_acl {
+struct smb_acl {
 	__le16 revision; /* revision level */
 	__le16 size;
-	__le32 num_aces;
+	__le16 num_aces;
+	__le16 reserved;
 } __attribute__((packed));
 
 /* ACE types - see MS-DTYP 2.4.4.1 */
@@ -111,12 +112,12 @@ struct cifs_acl {
 #define SUCCESSFUL_ACCESS_ACE_FLAG 0x40
 #define FAILED_ACCESS_ACE_FLAG	0x80
 
-struct cifs_ace {
+struct smb_ace {
 	__u8 type; /* see above and MS-DTYP 2.4.4.1 */
 	__u8 flags;
 	__le16 size;
 	__le32 access_req;
-	struct cifs_sid sid; /* ie UUID of user or group who gets these perms */
+	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
 } __attribute__((packed));
 
 /*
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a5e9f79c10f90..efb41bee9c875 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -184,10 +184,10 @@ struct cifs_cred {
 	int gid;
 	int mode;
 	int cecount;
-	struct cifs_sid osid;
-	struct cifs_sid gsid;
+	struct smb_sid osid;
+	struct smb_sid gsid;
 	struct cifs_ntace *ntaces;
-	struct cifs_ace *aces;
+	struct smb_ace *aces;
 };
 
 struct cifs_open_info_data {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 8cfa504e6bd83..6e7bb63ef5d88 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -239,7 +239,7 @@ extern int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
 extern int cifs_rename_pending_delete(const char *full_path,
 				      struct dentry *dentry,
 				      const unsigned int xid);
-extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
+extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 				struct cifs_fattr *fattr, uint sidtype);
 extern int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb,
 			      struct cifs_fattr *fattr, struct inode *inode,
@@ -253,9 +253,10 @@ extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
 				const struct cifs_fid *, u32 *, u32);
 extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
 				const char *, int);
-extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
-extern unsigned int setup_special_mode_ACE(struct cifs_ace *pace, __u64 nmode);
-extern unsigned int setup_special_user_owner_ACE(struct cifs_ace *pace);
+extern unsigned int setup_authusers_ACE(struct smb_ace *pace);
+extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
+					   bool posix, __u64 nmode);
+extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
 extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 452a60e09cbed..c66a3b68abfa1 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -180,7 +180,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				SMB2_O_INFO_FILE, 0,
 				/* TBD: fix following to allow for longer SIDs */
 				sizeof(struct smb311_posix_qinfo *) + (PATH_MAX * 2) +
-				(sizeof(struct cifs_sid) * 2), 0, NULL);
+				(sizeof(struct smb_sid) * 2), 0, NULL);
 		else {
 			rc = SMB2_query_info_init(tcon, server,
 				&rqst[num_rqst],
@@ -189,7 +189,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				SMB_FIND_FILE_POSIX_INFO,
 				SMB2_O_INFO_FILE, 0,
 				sizeof(struct smb311_posix_qinfo *) + (PATH_MAX * 2) +
-				(sizeof(struct cifs_sid) * 2), 0, NULL);
+				(sizeof(struct smb_sid) * 2), 0, NULL);
 			if (!rc) {
 				smb2_set_next_command(tcon, &rqst[num_rqst]);
 				smb2_set_related(&rqst[num_rqst]);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 98d6fcdf22365..a1640521191b5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2549,7 +2549,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	unsigned int group_offset = 0;
 	struct smb3_acl acl = {};
 
-	*len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct cifs_ace) * 4), 8);
+	*len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4), 8);
 
 	if (set_owner) {
 		/* sizeof(struct owner_group_sids) is already multiple of 8 so no need to round */
@@ -2598,21 +2598,21 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	ptr += sizeof(struct smb3_acl);
 
 	/* create one ACE to hold the mode embedded in reserved special SID */
-	acelen = setup_special_mode_ACE((struct cifs_ace *)ptr, (__u64)mode);
+	acelen = setup_special_mode_ACE((struct smb_ace *)ptr, false, (__u64)mode);
 	ptr += acelen;
 	acl_size = acelen + sizeof(struct smb3_acl);
 	ace_count = 1;
 
 	if (set_owner) {
 		/* we do not need to reallocate buffer to add the two more ACEs. plenty of space */
-		acelen = setup_special_user_owner_ACE((struct cifs_ace *)ptr);
+		acelen = setup_special_user_owner_ACE((struct smb_ace *)ptr);
 		ptr += acelen;
 		acl_size += acelen;
 		ace_count += 1;
 	}
 
 	/* and one more ACE to allow access for authenticated users */
-	acelen = setup_authusers_ACE((struct cifs_ace *)ptr);
+	acelen = setup_authusers_ACE((struct smb_ace *)ptr);
 	ptr += acelen;
 	acl_size += acelen;
 	ace_count += 1;
@@ -3773,7 +3773,7 @@ SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
 		u64 persistent_fid, u64 volatile_fid, struct smb311_posix_qinfo *data, u32 *plen)
 {
 	size_t output_len = sizeof(struct smb311_posix_qinfo *) +
-			(sizeof(struct cifs_sid) * 2) + (PATH_MAX * 2);
+			(sizeof(struct smb_sid) * 2) + (PATH_MAX * 2);
 	*plen = 0;
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index d12ca9c7e62bc..f5578fac85d18 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -383,8 +383,8 @@ struct create_posix_rsp {
 	u32 nlink;
 	u32 reparse_tag;
 	u32 mode;
-	struct cifs_sid owner; /* var-sized on the wire */
-	struct cifs_sid group; /* var-sized on the wire */
+	struct smb_sid owner; /* var-sized on the wire */
+	struct smb_sid group; /* var-sized on the wire */
 } __packed;
 
 #define SMB2_QUERY_DIRECTORY_IOV_SIZE 2
@@ -427,8 +427,8 @@ struct smb2_posix_info {
 struct smb2_posix_info_parsed {
 	const struct smb2_posix_info *base;
 	size_t size;
-	struct cifs_sid owner;
-	struct cifs_sid group;
+	struct smb_sid owner;
+	struct smb_sid group;
 	int name_len;
 	const u8 *name;
 };
-- 
2.53.0

