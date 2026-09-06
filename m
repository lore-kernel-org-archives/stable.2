Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93B33A6E2
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707023; cv=none; b=aXY5WTaeI3Qv7R9yMuEHG5cwQeKnJ3+KlCDdbvZzJ1sy4wvWe94idSkovfm2/27zyBtt4usl14k7w/FoW2w+OthrFQZUFGH/OqugQGZoEIRQ/syQMdB44yUShGzBB3bUI7Q1VL2JvdAX1LJiPShgXFwKYKDfeV7PPaF+NWS8HpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707023; c=relaxed/simple;
	bh=2sv5M7kgCHLo/qMwgeYzKFA5IjGeEmQQOuDiHP7xCgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UagApBEBe+GW5z9hv8Wss7UEutreNKguqbF+QITWU51aXM34zSD97XZFy2B3V2HTbEGkkCylKSVdywqL4IsfzYWA0/wqGUlTVDSn6yHztsjhwT+EcC438a2uLeYiTeXcFD6JYsQd5uEHDNXLbWg/NWsaPdYMGFI8XWErB5Dpdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VixLFNFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VixLFNFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E8B1F00A3A;
	Sun,  6 Sep 2026 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707021;
	bh=lNxlHm9NrVjiM3hIdPwj2HFh/cg5XuXbatu1vcw4RxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VixLFNFIvWkNkk6nqQsYbyNkadxzyY+4fphGRou2tMY2a7+gvk0c6N+TEzNnXagPs
	 W77d4MYuYUdz4gzparYuydgftiXNFHrt3pS7rwY1WFLi4dDfLHP+/8Po+9j8WUPpK5
	 r3b/00SudjVGgo+hW2sn7j83uLufHKn96UAS12v43pf5LCpeUlylt5fBOy8db8I+4L
	 jIF/6IDRsxKG21E9XNPF0UXQV9daj9tugrUpXlL3flFC1G54S3TArAkuzzTz5v9KE2
	 +Tm70pTOAhVjynn60kfBr3Ww+acB/bEg7LkcmE33D6ffmWFrb02k7B5c9eRnjzkxhc
	 TphXsfEeaUqug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ceph: bound copied dentry name length in NFS export get_name
Date: Sun,  6 Sep 2026 11:03:39 -0400
Message-ID: <20260906150339.1333795-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-commotion-aged-5be7@gregkh>
References: <2026090318-commotion-aged-5be7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit eff8013c5a8916613c742ae5a2cc341cb605c0ae ]

ceph_get_name() copies the MDS-supplied name into the caller's
NAME_MAX-sized buffer with memcpy(name, rinfo->dname, rinfo->dname_len)
and then writes name[rinfo->dname_len] = 0, without checking dname_len
against NAME_MAX. A malicious or buggy MDS that returns a LOOKUPNAME reply
with dname_len > NAME_MAX overflows the buffer. __get_snap_name() copies
rde->name / rde->name_len the same unchecked way.

Impact: a malicious or compromised Ceph MDS overflows the NAME_MAX name
buffer in a client's NFS-export get_name path, a slab out-of-bounds write
reported by KASAN. Reachable when a CephFS mount is re-exported over NFS.

Add ceph_export_copy_name(), which rejects lengths above NAME_MAX with
-ENAMETOOLONG before the copy, and use it in both ceph_get_name() and
__get_snap_name().

Cc: stable@vger.kernel.org
Fixes: 19913b4eac4a ("ceph: add get_name() NFS export callback")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ adapted the bounds check to the older ceph_get_name() flow without encrypted-name handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/export.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 66d8afdd417d1..f68fbc152441f 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -421,6 +421,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return dentry;
 }
 
+static int ceph_export_copy_name(char *name, const char *src, u32 len)
+{
+	if (len > NAME_MAX)
+		return -ENAMETOOLONG;
+
+	memcpy(name, src, len);
+	name[len] = '\0';
+	return 0;
+}
+
 static int __get_snap_name(struct dentry *parent, char *name,
 			   struct dentry *child)
 {
@@ -486,9 +496,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 			BUG_ON(!rde->inode.in);
 			if (ceph_snap(inode) ==
 			    le64_to_cpu(rde->inode.in->snapid)) {
-				memcpy(name, rde->name, rde->name_len);
-				name[rde->name_len] = '\0';
-				err = 0;
+				err = ceph_export_copy_name(name, rde->name,
+							    rde->name_len);
 				goto out;
 			}
 		}
@@ -549,8 +558,12 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
 	if (!err) {
 		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
-		memcpy(name, rinfo->dname, rinfo->dname_len);
-		name[rinfo->dname_len] = 0;
+
+		err = ceph_export_copy_name(name, rinfo->dname,
+					    rinfo->dname_len);
+	}
+
+	if (!err) {
 		dout("get_name %p ino %llx.%llx name %s\n",
 		     child, ceph_vinop(inode), name);
 	} else {
-- 
2.53.0

