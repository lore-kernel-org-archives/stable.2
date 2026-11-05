Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907624;
	b=CuUbduhTNGY+dwFPw5G4snmi7ry1bySt66ejsf9tx0do2aX2Qcd+bccoCxLdbp/E+mT3
	 mkPrJWKk05IK/9ZfjC53xGGYPb/1PPmmURg6ENngR6xPi8i6oISrTxGheGXldntkU0Gtg
	 VouFl6zuQRQarGWIb46aZAl4AKnWEAfRPzFcE7YPlOQF9TO2SBHKJlvLbW1EzQ0cIooJZ
	 R8LzUTWq3JVR0bpF14tjOoQQFzpxgABEYvFbmz3JY/lRRXZMtH3z1pKNRN/64hXgpjb35
	 3NmOoIytqTGr0lmFxX8GTeUdCxRC5EBprP9BMfRM2VRhTd1QRPBfzVmUg9csCHjXAzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BY1cbZir1gL24fI7pEkfFAh5fSX/P5MOZIZY/IqBzhw=;
	b=0G7fvWAm3p0sk9yVldeZ4xZV1HirXOCCQ0x5/xCevZBlfoNsG+tc/vxU5+nIXPouPfiU
	 SqZeK+PueNVRWAuDyHOt6SEcUSvEgQiri1a0xseQvc+4wkND8EtIjwMtXRYDv7+Qh82xL
	 mx9Ez39+Wq5phix/91eJrkMf3mj7knERXguEiC71vlYA2V9G7Nc8Bg8CLhWcOWK2NZljg
	 /QOpsQbK1FwsyzNIIdykROK0sTEslvGx66AGfWFdS6VKSX79AcvAL5zZfdhOm8v3q2237
	 CGcPMgCzO+HkjsfkoDtr4D77ZESM+fauwf3PQhLjM/6lDisvKt+kCwKAMI4Nhq0tMjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A7n21SI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A956072C78
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7n21SI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D321F0089F;
	Thu,  5 Nov 2026 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907623;
	bh=BY1cbZir1gL24fI7pEkfFAh5fSX/P5MOZIZY/IqBzhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7n21SI/VqNifkZ7j7JKYpQteUY+zvUakDQBpr3SQQ78tXOKM/f8qNhFypFrLCM2W
	 hHPUoHaLRYyY/RpO2JJ+nuXt5HHzqzCEVrN6fGtPj+Y7yPJaBr4Oz42oyH2gMEBrbn
	 C5NVdlMvcxoxNk27exS+Lh+3SLgPFOJXZ/hsAJjW2B19i74gTTBkG+wcCE3FRriMSc
	 TLLNMYs+PktvtlwyqOiZPjVGiDe+Em0LWK/lv6G9R1WoXrjtvuHK8R+ZihY8Z1tPs+
	 B0sM6dkmxkPKCsx0rL2P0Tixjxe33LfCRBWjYa6cPXrw3z8aEtc85cBzvknd0S8dwT
	 +XzHVun1E0XWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diego Oliva <diego@bynar.io>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
Date: Thu,  5 Nov 2026 14:40:22 -0500
Message-ID: <20261105193923.2631077-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-cosmetics-ideology-ed29@gregkh>
References: <2026110439-cosmetics-ideology-ed29@gregkh>
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

From: Diego Oliva <diego@bynar.io>

[ Upstream commit f8171804a39ee89a11cd462f67862899de9c6b10 ]

cifs_fill_dirent() reads the fixed part of a directory entry and the
name length it holds, or for SMB_FIND_FILE_UNIX scans the name for its
terminating NUL, without knowing where the response ends.
cifs_save_resume_key() calls it for the entry at the LastNameOffset the
server chose, after every FindNext and after the FindFirst of a search
rewind, and records the name it returns as the resume name of the
search without bounding it; the next CIFSFindNext() copies up to
PATH_MAX - 1 bytes from that name into its request and sends them to
the server. cifs_filldir() bounds
the name against the end of the response since
commit f8cf09a53a0d ("smb: client: bound dirent name against end of
SMB response in cifs_filldir"), but only after cifs_fill_dirent() has
read the entry, and nxt_dir_entry() checks the entries it walks only
against sizeof(FILE_DIRECTORY_INFO), for every level but
SMB_FIND_FILE_INFO_STANDARD, and never sees the first entry of a
response.

Bounding where last_entry starts, as the preceding patch does, does
not bound the read. A last entry that starts within the final bytes of
the response still has its fixed part read past the end of the
received data, and the name length it declares, a __le32 for every
level but SMB_FIND_FILE_INFO_STANDARD and SMB_FIND_FILE_UNIX, is
recorded without being checked against anything. CIFSFindNext()
rejects only a length of PATH_MAX or more, then copies the name, up to
4095 bytes, into its request and sends it, and as the report below
shows that copy can run past the end of the cifs_request allocation
that holds the response. For SMB_FIND_FILE_UNIX the name is in
addition scanned for its terminating NUL over up to PATH_MAX + 1
UTF-16 units, or PATH_MAX bytes, before any check. The FindNext that
carries the name is only sent by the SMB1 dialect, which is not
negotiated by default; reaching it requires an explicit vers=1.0
mount.

With KASAN enabled, a response whose last entry declares a name
longer than the bytes that follow it gives:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in CIFSFindNext+0x8ca/0x14c0
 Read of size 4080 at addr ffff88807c823f98 by task ls/83

 CPU: 0 UID: 0 PID: 83 Comm: ls Not tainted 7.3.0-rc4-00457-gf14572c203d5 #69 PREEMPT(lazy)
 Call Trace:
  <TASK>
  kasan_report+0xdf/0x1a0
  kasan_check_range+0x10f/0x1e0
  __asan_memcpy+0x23/0x60
  CIFSFindNext+0x8ca/0x14c0
  cifs_readdir+0xf51/0x29c0
  iterate_dir+0x1c0/0x570
  __x64_sys_getdents64+0x133/0x270
  do_syscall_64+0x109/0x5d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 Allocated by task 83 on cpu 1 at 13.497119s:
  cifs_buf_get+0x36/0x90
  smb_init+0x4f/0x110
  CIFSFindNext+0xf7/0x14c0
  cifs_readdir+0xf51/0x29c0

 The buggy address belongs to the object at ffff88807c820000
  which belongs to the cache cifs_request of size 16588
 The buggy address is located 16280 bytes inside of
  allocated 16588-byte region [ffff88807c820000, ffff88807c8240cc)
 ==================================================================

The read is the memcpy() that copies the recorded name into the next
request, so those bytes go to the server.

Pass the end of the response to cifs_fill_dirent() and have it reject
an entry whose fixed part does not fit or whose name extends past the
end, before either is used, so that both callers are covered;
cifs_save_resume_key() computes the end the same way cifs_readdir()
does. The name bound compares the bytes left between the name and the
end with the name length rather than adding the length to the name
pointer, since the length is a 32-bit value taken from the entry and
the sum could wrap on 32-bit systems. cifs_fill_dirent() is also used
on the SMB2 readdir path; there smb2_parse_query_directory() has
already checked every entry against the end of the response, so a
valid SMB2 response is not rejected by the new checks. The check
cifs_filldir() applies after the parse is left in place. The NUL scan
for SMB_FIND_FILE_UNIX names is capped by a separate patch.

An entry and its name lie inside the data area of the response, so a
server that points LastNameOffset at the entry is not affected. One
that points it at the file name, as MS-CIFS 2.2.6.2.2 describes, has
its last entry rejected here; the listing is unaffected, because
cifs_readdir() records the resume name from an entry it emitted, and
before this series such a response could instead end the listing early,
since a name length read from the wrong place is usually PATH_MAX or
more, which CIFSFindNext() rejects with -EINVAL.

On trees before v6.19 the type for the level 0x105 fixed part is
spelled SEARCH_ID_FULL_DIR_INFO; adjust when backporting.

Fixes: 0752f1522a91 ("[CIFS] make sure we have the right resume info before calling CIFSFindNext")
Cc: stable@vger.kernel.org # 6.1.x: f8cf09a53a0d: smb: client: bound dirent name against end of SMB response in cifs_filldir
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Replaced FILE_ID_FULL_DIR_INFO with SEARCH_ID_FULL_DIR_INFO in the offsetof() check to match the existing type name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/readdir.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 458569bbfe9e1..135cbd833e47b 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -584,30 +584,46 @@ static void cifs_fill_dirent_std(struct cifs_dirent *de,
 }
 
 static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
-		u16 level, bool is_unicode)
+			    const char *end, u16 level, bool is_unicode)
 {
+	size_t len = end > (const char *)info ? end - (const char *)info : 0;
+
 	memset(de, 0, sizeof(*de));
 
 	switch (level) {
 	case SMB_FIND_FILE_POSIX_INFO:
+		if (len < sizeof(struct smb2_posix_info))
+			goto too_short;
 		cifs_fill_dirent_posix(de, info);
 		break;
 	case SMB_FIND_FILE_UNIX:
+		if (len < offsetof(FILE_UNIX_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_unix(de, info, is_unicode);
 		break;
 	case SMB_FIND_FILE_DIRECTORY_INFO:
+		if (len < offsetof(FILE_DIRECTORY_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_dir(de, info);
 		break;
 	case SMB_FIND_FILE_FULL_DIRECTORY_INFO:
+		if (len < offsetof(FILE_FULL_DIRECTORY_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_full(de, info);
 		break;
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
+		if (len < offsetof(SEARCH_ID_FULL_DIR_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_search(de, info);
 		break;
 	case SMB_FIND_FILE_BOTH_DIRECTORY_INFO:
+		if (len < offsetof(FILE_BOTH_DIRECTORY_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_both(de, info);
 		break;
 	case SMB_FIND_FILE_INFO_STANDARD:
+		if (len < offsetof(FIND_FILE_STANDARD_INFO, FileName))
+			goto too_short;
 		cifs_fill_dirent_std(de, info);
 		break;
 	default:
@@ -615,7 +631,19 @@ static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
 		return -EINVAL;
 	}
 
+	if (de->name &&
+	    (end < de->name || (size_t)(end - de->name) < de->namelen)) {
+		cifs_dbg(VFS, "%s: search entry name extends past end of SMB\n",
+			 __func__);
+		return -EINVAL;
+	}
+
 	return 0;
+
+too_short:
+	cifs_dbg(VFS, "%s: search entry extends past end of SMB\n",
+		 __func__);
+	return -EINVAL;
 }
 
 #define UNICODE_DOT cpu_to_le16(0x2e)
@@ -670,10 +698,14 @@ static int is_dir_changed(struct file *file)
 static int cifs_save_resume_key(const char *current_entry,
 	struct cifsFileInfo *file_info)
 {
+	struct TCP_Server_Info *server = tlink_tcon(file_info->tlink)->ses->server;
+	char *buf = file_info->srch_inf.ntwrk_buf_start;
+	const char *end = buf + server->ops->calc_smb_size(buf);
 	struct cifs_dirent de;
 	int rc;
 
-	rc = cifs_fill_dirent(&de, current_entry, file_info->srch_inf.info_level,
+	rc = cifs_fill_dirent(&de, current_entry, end,
+			      file_info->srch_inf.info_level,
 			      file_info->srch_inf.unicode);
 	if (!rc) {
 		file_info->srch_inf.presume_name = de.name;
@@ -958,7 +990,8 @@ static int cifs_filldir(char *find_entry, struct file *file,
 	struct qstr name;
 	int rc = 0;
 
-	rc = cifs_fill_dirent(&de, find_entry, file_info->srch_inf.info_level,
+	rc = cifs_fill_dirent(&de, find_entry, end_of_smb,
+			      file_info->srch_inf.info_level,
 			      file_info->srch_inf.unicode);
 	if (rc)
 		return rc;
-- 
2.53.0

