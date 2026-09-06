Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656135474E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706597; cv=none; b=dnEH5Dt04z7HW2dnsYud9i3AeF0F1EiQg9ZRWlCOpvbx6I0Sf+kBuydcKlG/xHSMwNjrlhZQuUlOEKDtibIKkDgYVoHEdeb0VNJSgP/+bFq/DkuWiQdLsnHkiThTT9blh9b6ze8j8Mpz++d2ALseIJxTZU8NZ4Q7MgTdB4cs78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706597; c=relaxed/simple;
	bh=a4pzztyq/iuGdLP26U4DI1eb6AlgaS0jf8myfXm669M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5dvDViQCCm+kAlIDlhOECpNkX0MUmZ50T+CMlRROP9XvLJIB3RjoCJ0+S3y45GF3jP4KWhdFkXKAjFTToe/UsYROs7CsHrMpUmmkR+o/CwaXGtG2Cbq0ci0AGXLPfTh4gD11eZSzpayDSgq12yuKWBDIWV9XnbTx0I1BJeEWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq4fd8Jf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq4fd8Jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603191F00A3A;
	Sun,  6 Sep 2026 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788706595;
	bh=3c8j10GWp6FT+p0WcZsmptj/pz6OU3jvHS31m4zQ1dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mq4fd8Jf8sFHTxj5yplUKDXQyS/h40G3UfYdCsRenI5+n5RuPys+zw4B637TiPtV6
	 +CClQ0q58U22yCg648hzFrJ+fwRON65AVPjYOwc4m4ZeWhUQt2DHNILf7yyK+D551g
	 muodpNbIrxcPOWmcwLnGldY23YO+Ceiz73QCSwaIMss/qLPLZP3YPvWGFafCT3ywcv
	 tlbBQwLw4vNBS+pQX1PL5sK6lRzpNekFWUOUR9yhHAN2HtM744u1TYTBhKCoVJ0lqI
	 kSUdaOkJS0kLuSiAU60lv9uSmmcwsVe3z3O8E7Lt+gYfQK+bwgowN0ue7f5J9U70KW
	 UIIFwo9woAjnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ceph: bound copied dentry name length in NFS export get_name
Date: Sun,  6 Sep 2026 10:56:33 -0400
Message-ID: <20260906145633.1312830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-makeover-speller-4b35@gregkh>
References: <2026090318-makeover-speller-4b35@gregkh>
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
index 466af8e0cbce1..ba2b918a5dfe6 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -422,6 +422,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
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
@@ -487,9 +497,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
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
@@ -551,8 +560,12 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
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

