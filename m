Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795153219;
	b=qLJwBHks6KJZS3OUlqa7/Ws3QRvBA+dCu8sXjbCucmumeI5Z/G/znOLQyqeh1PHg6Enl
	 6aNTmf883vB4CqWRWOSwg9tA2N3DiOz8c1Ljs1KrUfe5TEw6Veh7p4t7yyT7kg6boRrah
	 Fcr3MSWjL17np6wp7BVlDyeB/lQ2ofKLGY8ggcYrh/M2pjGNT7r7RQKE/g6sR9SvKd5TZ
	 XMbwjhq1HtVk/wnPU2vPdEB3My3yr2vi5tlfl+fS3kZbOSyYSP+WtKZPxUYFbfWvDE7hV
	 wRxHNl8VoJ8tzg56G1b+XcND3eufKzMgrvniIXu3B6tCezSKYHZzGqJHOfhzJF+HLkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153219;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BKaqvjvjPQDJFZ36/E4JBvN2auye4re/Ot2lelLQRo8=;
	b=n1ERcI/Oyl00w7xliJRHCaUPRDbTooaccvqA6Puuhb27mDV1kTOj4Xj+J0uCJmsKqVZV
	 pKxR3GrcUoH1EoVE4NvdkxRM8Q9g4aV9wVoQKIb7LWbZI8wvZVj41GMdLKaSe2aQaEgfs
	 LVjYNPgRO9El+HyVtpnngvwwYXhPO7Hr58tuTRefA95XpqNVKRpsl1di1R+czKZtIEyWk
	 AWl5WAjiaz8dbV4JHY3FlToIDFtwCKiooxQPES6MtJlnDU/CQN6VIuXYMGs87Ri9UwR0M
	 RH8k06nehbCbWHG9xZVKL/Jc+VtwFpMlek7JpfvbbaGsqXoJiMbZxV6jrQAlITxc+QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtP29c9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D637606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtP29c9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795153219;
	b=m8yldYxBtLDGIvcx9roaDOY2L+7Fucv2idquNwVu8OphVLj+D5k/K/pDGAZXgZ4Qb47H
	 czzlOXqsJIECLVKPzTHGKZ9VWhrFkphggy4qvgqjOlJ0j37l0W3pcFeNZRDC7BNVkJDdh
	 ZcuuEcYjGolV3GfmD8RJGpzZGfSXaV9nCLxxGgczz4NzT0Iw+Kq1uT9+PT8aSJgar6HYH
	 CO+LXhEPzZ2E1p+QS/sAj/cVZqloaCHFS4oosStVatmlKfp6G1IoAJhIy6YNYBNXepQFL
	 wb4Rbkq5Q2lL+sFErd/DOyPwcKDayoo4cAB0Z/qkx28m3/+gseynXGYmcRq1uidjLnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795153219;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BKaqvjvjPQDJFZ36/E4JBvN2auye4re/Ot2lelLQRo8=;
	b=3GZBM2BeNTIEgMkyV1/LEkkSKdHIL+odj/4zHYDldWFp4I8Tti6DHpWCJiYK5iV1z5Wv
	 jEt4JtmOuvqHVqXmvYNnz5g7UYGYs9kkRGAhjx9COfog1vtpiUAyeweGqTNjTNpynfdyv
	 4/S9ifjtBgz/XHjiLnk84913QvO8yO9TPa7qvhtdL4KM9T2z9g8MAri3qKFsry7dxDyq1
	 XERzrOZKkoF2zP16rEgdo/tNHVCFUv4WfzO7ttOtYSkR9Ja+4yIMhyt2DVRnVhybWh7CC
	 46VZh9RSnPSVodJB5mlwuTG8FK7ix0ncmoOillKjf8C6AaoiuNJEpum8phv+LnazaUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE8D11F000C4;
	Fri, 20 Nov 2026 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795153219;
	bh=BKaqvjvjPQDJFZ36/E4JBvN2auye4re/Ot2lelLQRo8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=grtP29c95gSYAx7K8lAPHtxkRZa/cp2Fbt45cH3764am3ebmMEb8BaUeKUC8wSn11
	 pfr3taZ/HffmG1vUpx5S6zAqMwTyUtKLqzhGQ3POQktvhsRM8uxsqUq2wBOOJEO4mX
	 RuoaPNoYpZ5UW8Pjwh9vf40bnOdneMSXHX4x5UQYoFqbgOtV7KPLTGRC7WSfBtUqgj
	 8v5Q8y1EyHSPxvlomAR4ueVltrog8BhGa4ggCmB/v7PXfGVrOUxFZBrNeDTjJtWeHQ
	 KXVGRdk2m4Ad5AaQF+3eH85fxrBr4YnEF28oGSG4TMFZ+HGAG4fzwIJ2+M4Pm98vyt
	 1zmLHu2+1+p+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FBB1496DF;
	Fri, 20 Nov 2026 05:40:18 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 20 Nov 2026 07:40:16 +0200
Subject: [PATCH] ceph: reject MDS dentry names longer than NAME_MAX
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTvQRAjWq4iLMfljR2gsEyuF0
 rsbdfkt3tuowhSVzt1GhrdWfZYGd+gojlLuYE3N5HsfnPM9R8wjGyQlNS4ygSdZ+RiGlN1pkBx
 ArZ0NWdff93L9uy63B+LrO6N9/wAqBeooeQAAAA==
X-Change-ID: 20261120-ceph-readdir-name-max-369df189af6e
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Milind Changire <mchangir@redhat.com>
Cc: security@kernel.org, Quinn Grant <leograntquinn@gmail.com>, 
 stable@vger.kernel.org, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795153216; l=4641;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Mzi7+uGkMFdydRBmnsttKFo2kIPdjv5fz54lFeRyGSY=;
 b=bMnklu8ERyzSFdk0K+mTz8VYp5u9j1okB4ToSLdy0lys0y7jkYOXYYUiNgwxb+CkYRqaE2Puq
 aOaYIHhDYc0AnDTT4/aJc8nSVQRVhWOAzNZI7e8ui28ROEhZLHNDjIO
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

The MDS reply parsers bound a dentry name only by the remaining
payload, never by NAME_MAX.  With CONFIG_FS_ENCRYPTION=y that is
caught later, because ceph_fname_to_usr() refuses any name longer
than NAME_MAX, encrypted directory or not.  With
CONFIG_FS_ENCRYPTION=n, ceph_fname_to_usr() is a stub that passes the
name through, so a buggy or malicious MDS can hand the client an
overlong name, and two fixed size buffers then overflow:

 - ceph_readdir() keeps the last entry of a chunk in
   dfi->last_name, and the next READDIR request copies it into a
   NAME_MAX + 1 byte r_path2 buffer without a length check.

 - a dentry created from such a name (readdir prepopulate, or the
   LOOKUPNAME trace) is later sent back in a lease message whose
   front is sized for NAME_MAX bytes of name.

Reject a dentry name longer than NAME_MAX in both
parse_reply_info_readdir() and parse_reply_info_trace(), so an =n
build fails the reply with -EIO the same way an =y build already
does.  Also check the length at the two copy sites, so a long name
that gets there by any other way is refused instead of written past
the buffer.

Fixes: 8f2a98ef3c1a ("ceph: ensure d_name/d_parent stability in ceph_mdsc_lease_send_msg()")
Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted names")
Cc: stable@vger.kernel.org
Reported-by: Quinn Grant <leograntquinn@gmail.com>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
This is sent privately first, as a follow-up to Quinn's report to
security@kernel.org.  Please let me know if you see a need for
coordinated disclosure.  Otherwise I plan to post it to ceph-devel and
linux-kernel (with Cc: stable) in a few days.

On CONFIG_FS_ENCRYPTION=n builds a buggy or malicious MDS can send a
dentry name longer than NAME_MAX.  It then overflows the NAME_MAX + 1
byte readdir continuation buffer and the lease message front.  This
patch rejects such names when the MDS reply is parsed, and also checks
the length at both copy sites.

Tested on a KASAN kernel with CONFIG_FS_ENCRYPTION=n:
 - without the patch: FORTIFY reports a 512-byte memcpy into a 256-byte
   buffer in ceph_readdir(); KASAN reports a 512-byte write in
   ceph_mdsc_lease_send_msg(); a 256-byte name already makes
   ceph_encode_filepath() read out of bounds
 - with the patch: readdir returns -EIO and no dentry is created; a
   255-byte name works as before (listing, readdir continuation,
   lookup, lease renewal); readdir of a 3000-entry directory with
   several chunk sizes and fsstress show no regression
---
 fs/ceph/dir.c        |  5 +++++
 fs/ceph/mds_client.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c7e91f53e4b6..eae177dd5bcf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -460,6 +460,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		if (dfi->last_name) {
 			int len = strlen(dfi->last_name);
 
+			if (WARN_ON_ONCE(len > NAME_MAX)) {
+				ceph_mdsc_put_request(req);
+				ceph_blog_exit(&__ji);
+				return -EIO;
+			}
 			req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 15df9d22008d..3c1ba94fc621 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -450,6 +450,8 @@ static int parse_reply_info_trace(void **p, void *end,
 			goto out_bad;
 
 		ceph_decode_32_safe(p, end, info->dname_len, bad);
+		if (info->dname_len > NAME_MAX)
+			goto bad;
 		ceph_decode_need(p, end, info->dname_len, bad);
 		info->dname = *p;
 		*p += info->dname_len;
@@ -526,6 +528,11 @@ static int parse_reply_info_readdir(void **p, void *end,
 
 		/* dentry */
 		ceph_decode_32_safe(p, end, _name_len, bad);
+		if (_name_len > NAME_MAX) {
+			pr_err_client(cl, "dir entry name too long (%u)\n",
+				      _name_len);
+			goto bad;
+		}
 		ceph_decode_need(p, end, _name_len, bad);
 		_name = *p;
 		*p += _name_len;
@@ -6332,6 +6339,11 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 	lease->seq = cpu_to_le32(seq);
 
 	spin_lock(&dentry->d_lock);
+	if (WARN_ON_ONCE(dentry->d_name.len > NAME_MAX)) {
+		spin_unlock(&dentry->d_lock);
+		ceph_msg_put(msg);
+		return;
+	}
 	dir = d_inode(dentry->d_parent);
 	lease->ino = cpu_to_le64(ceph_ino(dir));
 	lease->first = lease->last = cpu_to_le64(ceph_snap(dir));

---
base-commit: 6a9830a8f414d3830c584782568d0233be969d09
change-id: 20261120-ceph-readdir-name-max-369df189af6e

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


