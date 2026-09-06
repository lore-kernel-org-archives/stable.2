Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2481FB1
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705473; cv=none; b=nQrPay13EgkAJtgDz3wVnBAzFZ/xX2XCOhHyJf/JXCRl2MdCfhCKsakM8Utfh30t3dybwDoZSUY/IvjXFXbErmfAl287xGvR2zyzm+10Y+O6k7awuRTQpotbBgjw0p5EZB18OZum7ISLncKT40GsnEILswXf+woTJYV+n3dfvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705473; c=relaxed/simple;
	bh=Co4iRWbp/4qzXsEnXLaW1cg+9m+me57632rljKkiIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec6OgCmazv1ExkmYbvPTgfbQEsZs1BqXAnIAlDiuSEwFh7YjPD+hxfbYf9uilGMt+DoNsNLoIpJ/Ap5/0syIZH0YGh10iTUbKseuyCK/CCWeSDNskjl3sxGKan3FfSeUvakn6guLNz7GGixi2UY0aL2x4iW2t20sQuyrmN51YzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZSoUl2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZSoUl2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FF1F00A3A;
	Sun,  6 Sep 2026 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788705471;
	bh=5Y8Udd51FmJnvZBP9TXlECA0cBSckrezYaYeaLm7Smo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZSoUl2N61GXvXL6cnO0NIaPjgo24ZSwVB7tinS8RtTmwqvm9Nk4oFerMisvAIVZA
	 7omnGwN0ttIH2f0KLrnl5NSK/sy2AVp801qBawpe5MS3k1dxHmA5vgvlkg5ZZQiiN5
	 sXVmdnxdZvIRj+7m/MfT6nD6JS+37xLyRacTcgkON1r1cC9x2gSAqNmFrUhI61tJm2
	 YdLSTZilqK9Olf3rev379wIdLL3ELsmXOllu74dAMHsb3/7jG5pmOipv15cwL/Ic4O
	 I3+CLIt7Xot3PGusKn8TGZMv1925mEHH2qPC8gI5A3mV+BGYrB9kBXPKkAbytLxiuj
	 WOldV7EybM2iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ceph: bound copied dentry name length in NFS export get_name
Date: Sun,  6 Sep 2026 10:37:49 -0400
Message-ID: <20260906143749.1258861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090317-designing-flagstone-ad4f@gregkh>
References: <2026090317-designing-flagstone-ad4f@gregkh>
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
index 23b945320c554..c2d3ca5417e9c 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -433,6 +433,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
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
@@ -498,9 +508,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
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
@@ -562,8 +571,12 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
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

