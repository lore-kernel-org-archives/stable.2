Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719244;
	b=H0mJeEDXBAXCZxT8FixHzDg5LVIkF/VXM5wkM9aYnU8wbfRSZiNSMPTgSDwhW81EgsYh
	 oU5kS3AmG6ROWN2qZBVIjk6LUev+OHTZxRcaSMHqOQkyfG7WgnfH2Z9np+5kk9JkMm5yw
	 d+CDiB+F3wX5uOnUAizRnb1qC5mYXy5or/pqRPEqCCHkHMywECOCbTj3tgalziYLnumO5
	 acOzwRxKNfVzQl0VEo9muOu/VywN9WxuneWggxg7V1N/FaSUgYH53Vai7iBSznbQv9St5
	 gF77mWdzTBECGy3KKh1+2kqh7d69E2etwQMVvOKohS0TLhcgpvFYQIuvqB/mox/n9+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719244;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbMRgdcMaqEPX9VxUTealMfsTX85mg1h68JYcuFLpL4=;
	b=cOeJ9LyG05vOlv4brCXcMtIOt+kRrHvVtu1tthPTsD8qIfENJi5ACYfjnJ/JDp57p4qA
	 Em+vxBcOUKJ7aWDVEOsGAEK0+DtcVGCXb56/V5D5dziBIIO5xdTtHFM0fOkHqlVsC3OnS
	 PghClYZf1mNyTohva4rpuNpdq3qRf4gXsEePdU1sLIw96XS4kDrqRmz2kEakkTwsnKra0
	 Gr0VmUMh0VmEEEHXQebURcCjwMtRDeoebEgtaiqTodJNy++eDsOxSeY7mJQ2+o42NkNO6
	 Urb4MFWn22aEmYplcfkCiTMNd0ncHoOBqNPmnlegLFNZKumW09cCwrgAJre3CqCJEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOCFMgj3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BE606A79F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOCFMgj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2151F01806;
	Tue,  3 Nov 2026 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719244;
	bh=WbMRgdcMaqEPX9VxUTealMfsTX85mg1h68JYcuFLpL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MOCFMgj3bvs6n+FFGDYKXLyp1wLK5Vvb518iKfYYto1pXHOk3wIRB+dkPd1QpzGj/
	 OPtFOXnpIxsymB16JAuEG0PiCEK6Ta593E6a45AW/spgdsMWVq/uDZ5kKn1Zwqpye0
	 l+O+6pF6zb1Z/4QkvlciubZ7vTk9g5e/JcneXcSqRUXhhij1vlGAfWRmd4dkFbILKl
	 kduoUGhLPlKoBYqkm1yz8ACF0BwO2lomdRC9g+kfEGbplySaA9d4STyuzLsCy216UE
	 RP9zl5pmhAnWaB2mzOgh7ShPn3fkxip98sxrEiS9iV/lJBh3H9/+6AL3jxZqdhlMJ0
	 lhjHxDbTREg6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: fix parent dentry lifetime in directory enumeration
Date: Tue,  3 Nov 2026 10:20:42 -0500
Message-ID: <20261103152020.246425-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110303-stress-stardom-c27a@gregkh>
References: <2026110303-stress-stardom-c27a@gregkh>
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

From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>

[ Upstream commit 171df27077fb49b4af2c53ad2cedcd0e39664fe8 ]

ksmbd_populate_dot_dotdot_entries() builds the ".." entry from
the open directory's d_parent and passes that pointer to
ksmbd_vfs_fill_dentry_attrs() without taking a reference. That pointer
is only valid while the directory stays under this parent. If a
concurrent rename moves the directory elsewhere, the old parent loses
its last reference; a following rmdir then turns it into a negative
dentry with d_inode cleared, and after the RCU grace period the dentry
itself is freed. The worker still holds the raw pointer and
dereferences d_inode through vfs_getattr() and vfs_getxattr().

A remote SMB client, authenticated or guest, triggers this by listing
a directory while that directory is moved under a new parent and the
old parent is deleted. It can be done by the client itself with write
access or by other concurrent writers, triggering null-ptr-deref and
slab-use-after-free on a KASAN build.

  KASAN: null-ptr-deref in range
      [0x0000000000000000-0x0000000000000007]
  Workqueue: ksmbd-io handle_ksmbd_work
  RIP: 0010:xattr_permission+0x9d/0x160
  Call Trace:
   vfs_getxattr+0x9c/0x1b0
   ksmbd_vfs_getxattr+0x82/0x100
   ksmbd_vfs_get_dos_attrib_xattr+0x7f/0x130
   ksmbd_vfs_fill_dentry_attrs+0x435/0x650
   ksmbd_populate_dot_dotdot_entries+0x25e/0x630
   smb2_query_dir+0xcf9/0x1a20
   handle_ksmbd_work+0x5f1/0x1c80
   process_one_work+0x90b/0x19d0

Fix by using the dentry reference counting APIs: take the parent with
dget_parent(), take a matching dget() on ".", and dput() the dentry
once ksmbd_vfs_fill_dentry_attrs() has returned or the pattern does
not match.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adjusted context for the existing ksmbd_vfs_fill_dentry_attrs() call using user_ns without a return-value check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 0350697c9093b..d30547f656ccd 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -447,16 +447,17 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 			if (i == 0) {
 				d_info->name = ".";
 				d_info->name_len = 1;
-				dentry = dir->filp->f_path.dentry;
+				dentry = dget(dir->filp->f_path.dentry);
 			} else {
 				d_info->name = "..";
 				d_info->name_len = 2;
-				dentry = dir->filp->f_path.dentry->d_parent;
+				dentry = dget_parent(dir->filp->f_path.dentry);
 			}
 
 			if (!match_pattern(d_info->name, d_info->name_len,
 					   search_pattern)) {
 				dir->dot_dotdot[i] = 1;
+				dput(dentry);
 				continue;
 			}
 
@@ -465,6 +466,7 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 						    user_ns,
 						    dentry,
 						    &ksmbd_kstat);
+			dput(dentry);
 			rc = fn(conn, info_level, d_info, &ksmbd_kstat);
 			if (rc)
 				break;
-- 
2.53.0

