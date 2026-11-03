Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741879;
	b=19l+fLA8b5E3iDCDnuVInxpFnlkb6wuGR2X6Cr6rkHNNyhCY5/z7i6PFJxaWVvZXvpKi
	 mxskdtUipYnc9kUHRsO++5Lm3gP6+v/9VGkQLfKQOgGfxXuNSV6NduHrH0sdYDXhyBaBq
	 F5UFtj/W/b3eTRDAajko6KMFJzpoAIshUbE0qnY+K4Pe1wdyc5Ah9uFDygL8zdDLIVYiW
	 PRAU3kjtthvfZ28GhHqsJjWDmHdMTBU7/rjTV0JOD3YG1uGFoxqDbKI+9i0jWZiIFMGDB
	 uCIUVcPzAkakR4gCoiTKmZ3EAifUOlNPv1OdElTP4Nrg3D7Xse2C6LsGi/AZEyXuIPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nSZwr+HKaLvm4IscPo+xQuDnY2rW9t3+dND+RSgEuqE=;
	b=EY18K+rMJ1M9ELP9gx5yaT9b9C5jOUWCe+AAEKKcuxhfuYuHvNPnm4TIBGFD0VRRKvP0
	 K2hK9tyN1Flbc0seYaAmbWuwSWy3srXMuu9XT1N0lhmmuQz2/nyrQWw3zPkn9jgUVvyX0
	 IpuNvWiO/dzNaEcouZYXZzKdN89WiGITEtdaG00NLL6uqeaxNK1t5X8vX4zBobNtgowqN
	 9zIl2+KeBsQ+UO05Pm2B3tFoEN510DWwOpgVK6GLc3d30aq6s8x47vRcMtbik/D90ACiQ
	 lsGK3mx90RVoQjrXOlevS3s0HRMhaeVZ+B6/nRboQ3P02ehEi0MA/PtUUqazjRJK+Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwgglRRs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D2606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwgglRRs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F7A1F00919;
	Tue,  3 Nov 2026 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741879;
	bh=nSZwr+HKaLvm4IscPo+xQuDnY2rW9t3+dND+RSgEuqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iwgglRRsep07MZ/Mxc6i0TwW1K/35vfA5hrj+LiviAh7qLcXP5KX089mKxQGLy73a
	 pW6aJ/g6UYQuSgmwA89af3lGTwb8eE0n9iB7FeVFU4Ffw+UCBM52r19wOG9ZtqR11U
	 7v9DTBpNqCFIpzjJPrTQQXysMPq+eFcue9VH4dU8fslFFRXlkjexp0Eap2tiR11vR9
	 fFXd5JAzzG36jpgUeT/3MkovqbZOadbi1KOWc2vk2R1xrQVDQODMILbUqZKwmqsG1H
	 ymzkqF9B2eX9Zw3/GQBhHgh+GDEHA576hlHdK7R/DP01QVI+hOUUJMZWO0jRxk80m8
	 JPaLzCruJiKDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: use the existing xattr name for a named stream
Date: Tue,  3 Nov 2026 16:37:57 -0500
Message-ID: <20261103213707.1422742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110359-giver-antarctic-bc20@gregkh>
References: <2026110359-giver-antarctic-bc20@gregkh>
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

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit a7d1d52748e0fe4d06fdb871fc9899904fbba93f ]

SMB stream names are case-insensitive, but ksmbd stores each named
stream in an xattr whose name is case-sensitive. Opening an existing
stream finds its xattr with a case-insensitive match, yet the handle
keeps the name as the client spelled it, and every later operation that
needs an exact name uses that spelling:

 - a WRITE or an end-of-file change creates a second xattr, so a stream
   created as "Foo" and written through "foo" ends up stored twice, and
   which value a later lookup returns depends on xattr list order;
 - delete-on-close and delete-pending removal can fail with -ENODATA,
   or remove only a case-variant copy and leave the original;
 - the share mode check compares stream names with strcmp(), so two
   opens of the same stream that differ only in case do not conflict.

Have ksmbd_vfs_casexattr_len() copy the matching xattr's name into the
handle when the stream is opened, so later operations use the name
already on disk. The match must have the same length as the name it
replaces; the stream lookup passes a length that includes the
terminating NUL, which already guarantees that, and the check makes the
copy safe for any caller. A stream that does not exist yet keeps the
client's spelling, as before.

smb2_rename() compares and looks up fp->stream.name case-insensitively,
so it behaves the same with either spelling.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adapted the ksmbd_vfs_casexattr_len() call-site update to get_file_stream_info() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 fs/smb/server/vfs.c     | 7 ++++++-
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..b171404c6aff0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2469,7 +2469,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -2541,11 +2541,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	fp->stream.name = xattr_stream_name;
 	fp->stream.size = xattr_stream_size;
 
-	/* Check if there is stream prefix in xattr space */
+	/* Keep the existing xattr's case for subsequent writes and removal. */
 	rc = ksmbd_vfs_casexattr_len(idmap,
 				     path->dentry,
 				     xattr_stream_name,
-				     xattr_stream_size);
+				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
 	if (rc != -ENOENT && rc != -ENODATA)
@@ -5243,7 +5243,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		 */
 		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 						path->dentry, stream_name,
-						strlen(stream_name) + 1);
+						strlen(stream_name) + 1, NULL);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 2ec2c90aa7248..21ae65b2d3e4b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1812,7 +1812,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1830,8 +1830,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
+		if (actual_name && strlen(name) + 1 != attr_name_len)
+			continue;
 
 		value_len = ksmbd_vfs_xattr_len(idmap, dentry, name);
+		/* The caller provides attr_name_len bytes for the actual name. */
+		if (value_len >= 0 && actual_name)
+			memcpy(actual_name, name, attr_name_len);
 		break;
 	}
 
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 06903024a2d88..d0e05eca8616e 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -107,7 +107,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   char **xattr_buf);
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len);
+				int attr_name_len, char *actual_name);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags,
-- 
2.53.0

