Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047971;
	b=mZJBg3PVHb5VnTCpWrie6N7ZYnjvPY/Rjr1uLWi/Gd+MgfeAGTsMjez35lYzzTaRauOL
	 KAg4E6fVecWV3FqrmpbUqtDg7VUn1nI+qZq5Qhxe9uSm8TEHwZ+eA/ftLRfqrivRydrPo
	 kI3a6yeHN0f+Y6WmltLurqRM4dfemiThMWw+dCFZDIU4IkzdVeRv+6VWtvTjO/QKNPeG5
	 q7/ssni96keqj9/1KOfDEOnYk0ugz8ksWtCmAvW6OEXHNWIYNaXFY7BPcI7IxtBjZaE8W
	 Bwxvbj0pu7L0UwPNGB/QvP0gExOEFlReNdQxW+W2djn16KSCxR4/xbxGgoo7l63H6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lWxyRsVxPZiUYAWVsvK2C9cOFo5ZLS+pk4xlbq/6ZSE=;
	b=O3bIu9yVz5ezoBecjFAGohXPi5JMxeH5KMYxPAy2QDmO56EY8bqohrL2F1pzVe9/laqb
	 FSmTRiEDg/7OmUjkr8fxWyl557v3s9NP6XCS6pyxydR0YhRNfkVuW/zBHNGKneO5Mzhi4
	 sCcW6GKrwYkQFwLlvfa/upPBCDnWoaMc+oHYbaDRWf0fE9ydF/w4bpHDlTmXyt3iSrMOo
	 2BCgxMpQP3fTEVZ64Hb9XKiLAj6WLFhqBWq/buKgsoye/0JaDImNUWI+h4aPoOTjoU4IK
	 f1q943bJRiW69l27cEXDwiqCmmkUi8GqtpzmIRyhQjCKSe/WdQ5xZnwsbcGz1gI8mZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKXIIOJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKXIIOJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFB41F0089F;
	Sat,  7 Nov 2026 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047970;
	bh=lWxyRsVxPZiUYAWVsvK2C9cOFo5ZLS+pk4xlbq/6ZSE=;
	h=From:To:Cc:Subject:Date;
	b=AKXIIOJ+8/VNtyC+W4PysRzIVjg4Dmp3DOKpyZUIDgbam74MryGwgw4EqiT0DZbrt
	 BL/m+gmh17kojXG/wuaZG3YZ+MCmrZZADZSNfO7DGf1dijn+BLBxlXAWYzxktEcLue
	 9LcIwYVOdWo2GnhhGgJI6MKWquMSSTRYfLFDrvn/8AfwxSn12RFZpd+fso1NR1+y23
	 G3J4TQ86OQFX8BPALWUvyX/sQbirhBZT9gLSKuxmQ/bakr6ws0MpQR6mMrXR+eD7Oj
	 5hSkuDtfSgOk+EZvHbx7/CFniemiUCEl0HJAI7Q7Na/nE02HvnxyiBJeDYpF4UYuCs
	 l0DeN0YH+0Vdg==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:29 -0500
Message-ID: <20261107053929-failed-6.6-9c1d14d3b66b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053929-failed-6.6-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52 Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Thu, 10 Sep 2026 11:00:35 +0800
Subject: [PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single folio
with no length check, so a malicious or buggy MDS returning more
inline data than the folio can hold writes past its end.

Clamp the length to folio_size() so both callers, handle_cap_grant()
and fill_inode(), are covered.

Cc: stable@vger.kernel.org
Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ae6aa9db5eb24..86fe0e76cdf07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2245,6 +2245,12 @@ void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
 	      ceph_vinop(inode), len, locked_folio);
 
+	if (len > folio_size(folio)) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = folio_size(folio);
+	}
+
 	if (len > 0)
 		memcpy_to_folio(folio, 0, data, len);
 
-- 
2.53.0




