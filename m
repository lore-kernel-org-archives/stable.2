Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D546C826
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351730; cv=none; b=DOVgC6YWSFJk0gFrJ9nXc0uYzpjJsBNpDQyxZMa+k6B2ZNNUh594gpjArsPuUyKIUPI409EsiC8tKYQVIE9jxRuhDWqUAiLPk+w66EqfHB9KkE85Puk7OsJEI2NFe1OsrNOkyegdX4ltkFHDIHkwpNeZ0rU4l5CoZ3XWD/d03Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351730; c=relaxed/simple;
	bh=qOU/U4H1k8GACRfJ+18zmEkimFkhC/BmaDhJqVtWMfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4l7NTb53GD9JRvJwwjbCwTbVUzfROtELRNUPA2/sWic/7QDKzJYYeBvZmYqiXnH+r4zHA5d8B11Aj0kFgIqzvlJudzHBmLQfEsrnum8QN2dsK17cqOktq5nbCHxTO2YtPHFcnfO51eJDCAu7RykXMzo79AHDNpEY1bxZ6FiB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FbGfo/1S; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FbGfo/1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785351706;
	bh=7aZ1SevZiO9fxgtrLRpXjLTefTTvwnXp/HHk6vpyVlQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FbGfo/1S8hzNjZ18UuXQwYkoj5qB10PyDebAZjtQ35xNGAUjW7eoiHloPQdQUV4e7
	 2gR8H+h9einV4T68Uwx7nsiTUduxwBJla24P+Qr2+7D6a+gJvCdACehk8zsGe75oYi
	 H7DjGt3SO6xs2bOTfEthzkkyGwuPGq1YgIdEpzGw=
X-QQ-mid: zesmtpgz8t1785351700tcd7f6407
X-QQ-Originating-IP: bfZi0byFqAJB4wYzQHgU1Doy73rBu5im4uwJg9CWdj4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 03:01:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4593893312934473759
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 3/4] ksmbd: bound DACL dedup walk to copied ACEs
Date: Thu, 30 Jul 2026 03:00:26 +0800
Message-Id: <20260729190023.46584-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026072936-equipment-calculate-e753@gregkh>
References: <2026072936-equipment-calculate-e753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ORSIo7O5VipNlUnCuVfIyrctC8LU4o2BKQMBwS1G621YmtlNLZU10lxo
	9+rnmC85rwm5w7ROo/HrPtrk7y4IHaNROj2eMo3Dyv7vQaBfxAGb6yJynbmDmVAiLtHe9hH
	28k8YpauvLxNMFAY/6fxKzeLb697bN8RB7Gj0S1xMB4YaTSOLlS6HEEAhhnyl4b69f66kMb
	jd/HEyR7wrqUSn+Kn5mwAo9qWxwlZJWSiDvdE3Wf/su2Vmio/64f8JcX2bz1kXLnbo/1HRo
	mEs/TgCx62PbETKPOcseRC92KYqi16kkiRfKPXxL2kHVWYjGhTBgw4/8Q/A3VbsOANjd/Rk
	0ul5JneS8sk0GcT0LvbJi8VkO0hsnHyeyjF5856ol1pNX315FZ9ZbOMeSbE1h+sB+/YpxD+
	SDoAm2XJHQHHNnjFEv12tfJQp2ufFwWeecWGltLkI6OYB39QfhRwTAnGkB/HxXCdCuNzO1Z
	twl5nKq9ztIvE4rBPX+WrkXVQnVPoN7t9IuFuGyDsfOVbN4fjJCT/LfKi0vAvWh8/sRMwEX
	FC1K1vteEPxHq1MnsFtb/6Nl240dqyaTMhCjqMq1izAnbsmoZRwSrHfeMqXbcbRWJn+DU0f
	f9Fxil3ygc2aZ7s4k6+u/CfPEmWIG1uG3iN7xC66AHkdXTqqGtXNzDbV0xQkcFOYhp7p2Rt
	VViUbkUTp6rqq2tK97UJrSB4iT+zBjJIfM7nL6sEYVnkuQaqVsMNq+dYHHl/kpoJjG+ejzp
	zjYz2zOdRTniJ31qGQvuCGGl/YxqoWgUGEb80l52GCnNIIh79v1PnctytVcx/1XJTVvFEyi
	yfepXMorPeikzVQj1Uh3JomlsBTDHc19tshpVsFmsJokfOg9FfJ3zH2i0SnjlgcNEL3JNns
	99LUV3cJ8VycRSSMMjUqSu5KYOEdE7+eXkpes8rQRnQoW98/TIbNQrgpkScS+nULa1qca+h
	f8KML7RcXj/ieih1yp8rG41yFBNaDIK/5QKUa2nvqORgOBA/InVlEsz6he9X+npCdcHlyRH
	Ga42W5RywBpxnkiaWShSrV1aChTKDutkS9sBiUCFJ5w9KuKohw6oCwTOJJYlpTHfdr1R4+W
	4mqjDaXJzSn
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Namjae Jeon <linkinjeon@kernel.org>

set_ntacl_dacl() can stop copying ACEs before consuming the full input
DACL when size accounting overflows.

When that happens, num_aces reflects only the ACEs that were actually
copied into the output DACL, but set_posix_acl_entries_dacl() still
receives nt_num_aces and uses it to walk the existing ACE array during
dedup.

That makes the dedup walk scan past the copied ACE array and inspect
buffer tail that does not contain valid ACEs.

Split the two meanings currently carried by the NT ACE count. Pass the
number of copied NT ACEs to bound the dedup walk, and preserve the
original "input DACL had NT ACEs" state separately for the
Everyone/default ACL fallback.

This keeps the dedup walk aligned with the ACEs that are actually
present in the rebuilt DACL.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit 58d97fcd0bf1aee694e244cc28635b9df95b543b)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/smb/server/smbacl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 5621c50a80571..f869639913088 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -595,7 +595,8 @@ static void parse_dacl(struct mnt_idmap *idmap,
 static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 				       struct smb_ace *pndace,
 				       struct smb_fattr *fattr, u16 *num_aces,
-				       u16 *size, u32 nt_aces_num)
+				       u16 *size, u16 existing_nt_aces,
+				       bool had_nt_aces)
 {
 	struct posix_acl_entry *pace;
 	struct smb_sid *sid;
@@ -627,14 +628,14 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 
 			gid = posix_acl_gid_translate(idmap, pace);
 			id_to_sid(gid, SIDUNIX_GROUP, sid);
-		} else if (pace->e_tag == ACL_OTHER && !nt_aces_num) {
+		} else if (pace->e_tag == ACL_OTHER && !had_nt_aces) {
 			smb_copy_sid(sid, &sid_everyone);
 		} else {
 			kfree(sid);
 			continue;
 		}
 		ntace = pndace;
-		for (j = 0; j < nt_aces_num; j++) {
+		for (j = 0; j < existing_nt_aces; j++) {
 			if (ntace->sid.sub_auth[ntace->sid.num_subauth - 1] ==
 					sid->sub_auth[sid->num_subauth - 1])
 				goto pass_same_sid;
@@ -678,7 +679,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		kfree(sid);
 	}
 
-	if (nt_aces_num)
+	if (had_nt_aces)
 		return;
 
 posix_default_acl:
@@ -732,6 +733,7 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 {
 	struct smb_ace *ntace, *pndace;
 	u16 nt_num_aces = le16_to_cpu(nt_dacl->num_aces), num_aces = 0;
+	u16 copied_nt_aces;
 	unsigned short size = 0;
 	int i;
 
@@ -765,8 +767,10 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 		}
 	}
 
+	copied_nt_aces = num_aces;
 	set_posix_acl_entries_dacl(idmap, pndace, fattr,
-				   &num_aces, &size, nt_num_aces);
+				   &num_aces, &size, copied_nt_aces,
+				   nt_num_aces != 0);
 	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
@@ -784,7 +788,7 @@ static void set_mode_dacl(struct mnt_idmap *idmap,
 
 	if (fattr->cf_acls) {
 		set_posix_acl_entries_dacl(idmap, pndace, fattr,
-					   &num_aces, &size, num_aces);
+					   &num_aces, &size, num_aces, false);
 		goto out;
 	}
 
-- 
2.30.2

