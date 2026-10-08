Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF64E06D5
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473171; cv=none; b=JqcwlfZ9t60WxbrmsC0N86tYOWBx3Adt93ApbsdMxGaTQomBSAJsvg+cfPEc52tOM/1if1MNF6+OmTHriLZjMcgmjW5hnv/4vyaYbbzNH37+ui8CFYZz+kZysqPbtMxuF0/CJAkvKD0iplf3tarOnPwA+8TKTbNhLaAnMh+02KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473171; c=relaxed/simple;
	bh=SJ9KJpodhwEYTk19NTjove+q80LlRP2MkrvZiq9WY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txGCeamNSquSwReNCiwtFQidtLD8d74ujoKILZDvSf4tcrjXTuIoKogZLD5rKkQkGCo68qt8h7CV2/+maNPIuIS+8gVR7r5uApzmuNrm8n04jj8ujMgvLXADN65E3ysm7tDItMzHDKjHt2Tlr99HkM+Tq5Uj2s6/mzS5vNXi6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OittZr9n; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OittZr9n"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc74881317bso112855a12.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473160; x=1792077960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vUlfKA23oQppqoRycgB2o9KkYLVdkjzS/q54uEzSfY=;
        b=OittZr9nShm/8m17ed2N2njJckSkke6793j1iIErq2OMbRQ9FB9xTNmh8kHBIMGBkL
         iYVkcztqbtS8LN6u47qY84ZmwAluun4wc2xpxW1QOWWXqdb1GL9qVJKH1LZFeyewDmLS
         ttvfv8qEVQe/DXHC7Z80Vn6f1n6dtVwyMLpfqwnJuSX29CzVGaVjWEzODZ1CaWPzY1xG
         DziMDDINLXcHrqWRGpIclXDu5df2YiQn4AkNZ9nhuGuBZYyaHhRTU1WBPPejxIa5Ip6m
         5itgqC83JbqgiS9EQxKAcTpZ1pHWbxzIrVvMCMdCbBuM/Y9pM57LcOvvmjc3ypEopnEe
         itpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473160; x=1792077960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vUlfKA23oQppqoRycgB2o9KkYLVdkjzS/q54uEzSfY=;
        b=lIhI50aRnugDC7TemmGqTkpT2XSTkyEEiCGIMihXvSZuioTl+KhALoMGnNXeE7AQTE
         mL4FWuc8uQWRk4zadp6mMKeAkYHX9jNa9T52M8DffC24kegnEFt2ikT1k8PhgyaDbusW
         2ko0ZvkjyDQ99UqfgOjK7DSuhn0HBFgV8zRUg1/0UGeP1uvfMRKBWfeHvnDeya3azZB4
         efwpeIGW9KYGMv8phhMwAkzlv8Yez+D5LHKtYPYDvWj9A/pKvSI/dwvoOIGxgDBOP6tl
         oRkEB7SLVtAtUF1Qgi4dhh96ZB2yH6sFlPP9a/cx7ogw+5YaXJzRoek6B7CWeGP+U8Xg
         uOiw==
X-Forwarded-Encrypted: i=1; AKwUvBwwxGzI2U7Hs4Dm+mEPVx9aYxgi+tKMiw+Z4gItYlj8HhXrjWqaGLIHW4hctiGXIuXqnTY/Q2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU21hEZDUDMwiqtRjAs6TuV35KWMrpfcRLDv4idDmbKqkIlPhr
	ug3khkS25q5JlcjB78DFW+c16X7HodstPHF87gzCq5MTQlbDM51gVfxc
X-Gm-Gg: AYBFou296euGxZLWNVI8NTtPkE8sfv4C6aPeMprfLynsIGEIPeCzszXpjExn8OHU4+D
	8J5nMDvL6mS6VYPJBaZuJOtUECCXd8X8B949BRZCefgcd65xQBcfhimiNpa/2Hz/F7QWMDTGxGQ
	60v6NG0FVpgxE4GA1DSklxEY/z47VldfJQnh2P7uEZleYtPOJm3EGY7sQEoXA7yZZgLSnIIcAcg
	jqZ2/BU/BEtvLNDA5zc2LWNI7Gq94xakkDPgSQ559wEd47raBq//8+1JV8VZ1/ZUYI/4/jyet3q
	eypVJrTRYnkSob5N4djDDtBUdYonOk0Nt/AjH3NsDDMjeSPhVM961AKCDBR7hQ4HRFvRPcDHbci
	bn+ITcZjA4h7nGxgM0ESk3GveMVjbDgBvmTnH15BQqe0/tx2Ib2/PJzP7qDFJn7klNT0JYUshJq
	tReydGJhWQzK/ACJRnKjyZpVtlHYEilsneR9ARZMez17d+LyzcnYLfEJupRrvGPDQ=
X-Received: by 2002:a17:90b:4d84:b0:3a0:7d5b:8d3e with SMTP id 98e67ed59e1d1-3aa8f85f446mr4223589a91.1.1791473160361;
        Thu, 08 Oct 2026 08:26:00 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1c17b63sm5554792a91.12.2026.10.08.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:25:59 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ksmbd: use the existing xattr name for a named stream
Date: Fri,  9 Oct 2026 00:25:36 +0900
Message-ID: <20261008152537.4147299-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008152537.4147299-1-charsyam@gmail.com>
References: <20261008152537.4147299-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 fs/smb/server/vfs.c     | 9 +++++++--
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 12a43efdb..4d43de74f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3341,7 +3341,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -3413,11 +3413,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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
 
@@ -3469,7 +3469,7 @@ static loff_t ksmbd_stream_eof(struct ksmbd_file *fp)
 	ssize_t slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 					       fp->filp->f_path.dentry,
 					       fp->stream.name,
-					       fp->stream.size);
+					       fp->stream.size, NULL);
 	return slen < 0 ? 0 : (loff_t)slen;
 }
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index ae9f9a693..7020b7de3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1946,7 +1946,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1960,8 +1960,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
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
 
@@ -2116,7 +2121,7 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 		src_file_size = ksmbd_vfs_casexattr_len(
 				file_mnt_idmap(src_fp->filp),
 				src_fp->filp->f_path.dentry,
-				src_fp->stream.name, src_fp->stream.size);
+				src_fp->stream.name, src_fp->stream.size, NULL);
 		revert_creds(saved_cred);
 		if (src_file_size < 0)
 			return src_file_size;
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index ef3ab3f18..dedb10331 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -116,7 +116,7 @@ ssize_t ksmbd_vfs_getcasexattr(struct mnt_idmap *idmap,
 			       int attr_name_len, char **attr_value);
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len);
+				int attr_name_len, char *actual_name);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags,
-- 
2.43.0

