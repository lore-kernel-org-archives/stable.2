Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606022;
	b=t8VzmHyZfVYofH8mEB+q6NibF5fQsOPEtVbq5KUUpOtvzX6gkcYOpM3D4/4o2m8Wpt8O
	 tb1RinZN9i2spatoQCBbIdAFgdtsYKh7gH8D9zJMWbg4Fn4eNY3Hq7lKWK2/N7iju84bm
	 ZJ/3hv331HdVSNg/PfAvNR2qxBMwqDcdYRisU+qoYopvltyhTUx7nbd2BJxyH59eTouYl
	 d3p2mb6TfG8xEQAoHVZ0HHsRNHEqmaS0m3ZqGAT6uVDxUD8jMZ3xN/4TU9hvml2zJLJW1
	 tqq9oY+kCgCVlB3Nx8DnBHywiuedxdoZ23mYHUc9f8biR2YV0UEGZ4VpROLMca7GggQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606022;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dfqMWvoAFGxzoTXDbFGsnL6to6CDX0mAmgFYxlAxSf0=;
	b=Ar2RkWm4hujHS7auJiGQNj3XUJJtfWJpMQtkKZaF9K+QCi9OeqnmGVcexPL2/J4m1q+9
	 Eg5e1LRPvyvlU2gbBmeBXc2QEzbpyRDXJpbKGwMbZY/twlNvfgv8xpBQ59PoI587oPASl
	 5CWs7twtDY/ouDccptYFA0u7cfW9OnPmI4TRn4t1yegl4PvCztp5noAgGoJcRyy3ewaNr
	 /MMr0WK1Lck6XmkqzOSCKWDvzk+L2k0HmXyKtLAi939uK6qTTewrzJMsWXAs7TbARQOyH
	 HaLuI9ItTWmooGlZRtV4Uh3bV03aPvHIMxrMELtAk8pOSCdSxlhQzxPVmqowgr0/5lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Lct26Ion;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA499606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Lct26Ion
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC8C1F00A01;
	Wed, 25 Nov 2026 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606021;
	bh=dfqMWvoAFGxzoTXDbFGsnL6to6CDX0mAmgFYxlAxSf0=;
	h=Subject:To:Cc:From:Date;
	b=Lct26IongB+lvFYomvihGxxIvKP1eqwbRtaL6tUuODVXwzC7UwR0VyQH2miAlC2mw
	 8Kl3fov6YIdl8Kcci2wW7mOBf2OcGjHXihkv+onAARLgCa7Q5RdLCk6cpvP0TTCtg/
	 daZjXaqgUCs3AenGI2SwK3i7GU/7DnbbFjVMqnjo=
Subject: FAILED: patch "[PATCH] smb: client: validate descriptor headers before query result" failed to apply to 6.1-stable tree
To: pkfxxxing@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:13:07 +0100
Message-ID: <2026112507-oxidation-disperser-b8d1@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ffb59029c0d52bf76fdd2678f5d6fd13e26220dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112507-oxidation-disperser-b8d1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

