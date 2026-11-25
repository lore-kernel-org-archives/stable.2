Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606018;
	b=qGN3jnl0vwPl7Yv6PIYA/DnqbfY3n1tH/0abpZbaUkP6QJ7jN3OxxZDQ0pONDe4r4sbq
	 k6e4LT1pOD/6HiSU331TkIxDcx2L81O+e4QZ7bYEeEE3DHcfXJLor1xA4AFkpLMocdeC+
	 dquxUCCEDKi2qqwLnEjNG5WIJKCAflKaYHqUDT+jW26Tn9/zbr0QqTGNgJiARNU/yOfuu
	 lQb7FGZhwxEpltEQIOVWDdHNvcqaEN6PQJSnBtPGHWxMbEKDwqDzmDUURlDW4L7K68pN1
	 3YofUX39gjBB95pqvvEwhAA/3P0IhOs8oqT4eRS/5I0ZUmfQdMo7gjRY/54ePCIkoxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606018;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A8+h92oUd43kUhEVeFJGr+xwdx3Cf2xbB0NaIsaUK+Q=;
	b=5Mw+E8930fGQ80BXWhX/g1tnnfp4u7LxpGMw3jbUxEtjeQjwunnCjN/tUkpUBufDc368
	 owiKipV15a1gBR0y3IHlIwd6XsocwxLNTFQg6Gpk6psANC2e4XITWgXxxpSii/GpRzyJo
	 +xiaDmlo6hSVObAgLco6BjQ9o+HS4JSQD1I3K8wGWVXCkEoK0CzH0nyCFW9pl4bQbIPJ2
	 /wI+3TNepZYZhMsL0emcYP1bbidrnxefh5wptw//jjQWAgjWMcwfXGGWO0LV/wyC8o43J
	 +HfdDJgYiwGOYCC6w0vU20D8n5swocIUcUm/MDqKQubMPuYojAftq5+rpFgOKgr/MNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="ZZ/SRP6F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BC606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZZ/SRP6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E2D1F000D4;
	Wed, 25 Nov 2026 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606018;
	bh=A8+h92oUd43kUhEVeFJGr+xwdx3Cf2xbB0NaIsaUK+Q=;
	h=Subject:To:Cc:From:Date;
	b=ZZ/SRP6F6wjaO4GxOCasGIaiPja1Wk1zqGtRk/N2eCbkI6LfofEa/cjVBCxXPQlRq
	 cq1YR+AwZtSD/Lpqcm3vWDIPT7d8uVNcO2MWX137hbmQtP/vTPfJkFAj8nrdxbbZup
	 dj1SxboscYyrLIKU6+eyHx7Yr5QWpNr6XEG7two8=
Subject: FAILED: patch "[PATCH] smb: client: validate descriptor headers before query result" failed to apply to 6.12-stable tree
To: pkfxxxing@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:13:06 +0100
Message-ID: <2026112506-zipfile-subpanel-c0d3@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ffb59029c0d52bf76fdd2678f5d6fd13e26220dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112506-zipfile-subpanel-c0d3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffb59029c0d52bf76fdd2678f5d6fd13e26220dd Mon Sep 17 00:00:00 2001
From: liuyong <pkfxxxing@gmail.com>
Date: Fri, 6 Nov 2026 18:48:35 +0800
Subject: [PATCH] smb: client: validate descriptor headers before query result
 allocation

query_info() uses the server's returned length instead of the caller's
minimum when a dynamic result is requested. A zero-length ACL response
can therefore return ZERO_SIZE_PTR to id_mode_to_cifs_acl(), whose
ownership-change path reads dacloffset before checking the header size.
A KASAN-enabled test shows a read at address 0x20 and a kernel Oops.

Validate the returned range and the caller's minimum before allocating
the dynamic result. Keep the reported length zero if validation fails.

Use the security descriptor header size as the minimum in SMB2_query_acl().
DACL-only and SACL-only xattr queries do not require owner and group SIDs,
so enforcing MIN_SEC_DESC_LEN would reject short descriptors that these
queries could previously return. The rewrite paths validate the required
owner/group SIDs and DACL separately before using their contents.

These issues were discovered and fixed by Qihoo 360's Tulongfeng
multi-agent system.

Fixes: 9ee2afe5207b ("cifs: prevent copying past input buffer boundaries")
Cc: stable@vger.kernel.org
Signed-off-by: liuyong <pkfxxxing@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 31b51a8fc256..ebc1b7c08c6a 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -93,18 +93,4 @@ struct owner_group_sids {
 	struct owner_sid group;
 } __packed;
 
-/*
- * Minimum security identifier can be one for system defined Users
- * and Groups such as NULL SID and World or Built-in accounts such
- * as Administrator and Guest and consists of
- * Revision + Num (Sub)Auths + Authority + Domain (one Subauthority)
- */
-#define MIN_SID_LEN  (1 + 1 + 6 + 4) /* in bytes */
-
-/*
- * Minimum security descriptor can be one without any SACL and DACL and can
- * consist of revision, type, and two sids of minimum size for owner and group
- */
-#define MIN_SEC_DESC_LEN  (sizeof(struct smb_ntsd) + (2 * MIN_SID_LEN))
-
 #endif /* _CIFSACL_H */
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index da2cf8fcee87..7de6b0b2d116 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4027,6 +4027,14 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 				ses->Suid, info_class, (__u32)info_type);
 
 	if (dlen) {
+		rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
+				       le32_to_cpu(rsp->OutputBufferLength),
+				       &rsp_iov, min_len);
+		if (rc) {
+			*dlen = 0;
+			goto qinf_exit;
+		}
+
 		*dlen = le32_to_cpu(rsp->OutputBufferLength);
 		if (!*data) {
 			*data = kmalloc(*dlen, GFP_KERNEL);
@@ -4081,7 +4089,8 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
 			  0, SMB2_O_INFO_SECURITY, extra_info,
-			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
+			  SMB2_MAX_BUFFER_SIZE, sizeof(struct smb_ntsd),
+			  data, plen);
 }
 
 int

