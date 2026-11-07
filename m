Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048108;
	b=PeofCa1/m1AgzPSZWtu0phIn4g+i0tfZD9Nbj4XbvTQd9T2LIMIrwbGyPG3G/azazncy
	 5OHsZAAFxYUMxKmWpJIRIIntKPrUT/PivwWBwffkfjG2BSGrcQ/KHJFr62ogr3vN/9KWx
	 i3UlAktNo9RvIMPZURZVLux/p1ANl+Yk4v8OYd1G+76cNuHNv6sIZNxQz8zntXaqZZsyP
	 FTTnFJ0fBEkbTLMseCUofhRmQaSFJheJi9OEQdUiX7V2+HYZmTve38HJ3jj54CGhNSEhF
	 f9se/5wYeWat1ut//KxnsKtBABdbNJnjF00xYxbkYcXyPnz1M9dDlCMeafiCedHWPRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=z3fp1Oy9QcgNzbfGA7ucxY/kB983Gz5FuNjKXvxzspk=;
	b=gbRvlyK1ZmuuXLRuSppmOV9d+JkKLqmOV08yCYYvKIpAQ4hDrlGwD5A2b9E+wOs0visR
	 cFY81XvI3RelgM4L5nlNtVSbH+BHvz0SxuNAySBgE9YS2oveAuyLoCic5sN1i8FMCaOIy
	 Vi2yOw77j9AyF4CGsUcCCYQVu/dnxHGsoEF5T1dcuBzIy4eNeG77uS4Gjq8rfqYkeHASL
	 Ih5zOQDdom+qKkJs2D1jesdtnf1sK/afHU4H2ppCp9/VvjjgXxJxefdekamLF08CaSWsy
	 RmtPHhSfm/98Igi13nLLss/2w9eKVLV7uvIqnLbELCscxaXfaIz5tcVeO/2JNC4FNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTz3AeS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTz3AeS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451DD1F0089F;
	Sat,  7 Nov 2026 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048107;
	bh=z3fp1Oy9QcgNzbfGA7ucxY/kB983Gz5FuNjKXvxzspk=;
	h=From:To:Cc:Subject:Date;
	b=kTz3AeS8YrniDttK0dura8LKEM/pFB521g1yDU4LmV7b4B6AdOT/+dTrTkZfGoPkR
	 hPSy/NASNcBZZNaniPGdwBUCUceoJ/TDzqFJ/aPcNCtzs4aDhdvvfFj/N7PmQCNi7p
	 4VEBS4onp3Lef3GyKAq0eT0lBjLP5hC98k1fx4G5OtUP68RHOGzrDJ3danypDljNE7
	 5dQ9arDVSAYIfMNjqg70InO/KQ6u20ilQ5GnbQcVg5+g5G+IzRPRelWAG3qO9RAbIc
	 noKP3EnXmCxpd9/xmH//PlgiuCNdCprm5ttzvHNuxvUGskqoGazcMOsge41ODyr6Ql
	 ik+2Obanr/wHg==
From: Sasha Levin <sashal@kernel.org>
To: r772577952@gmail.com,
	agruenba@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gfs2: reject invalid inode sizes" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:46 -0500
Message-ID: <20261107054146-failed-6.1-33ed0a0567e0@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 33ed0a0567e0abe66ea65e89dad2e35082890fbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054146-failed-6.1-33ed0a0567e0@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33ed0a0567e0abe66ea65e89dad2e35082890fbe Mon Sep 17 00:00:00 2001
From: Jiaming Zhang <r772577952@gmail.com>
Date: Mon, 31 Aug 2026 18:54:25 +0800
Subject: [PATCH] gfs2: reject invalid inode sizes

A corrupted GFS2 image can store a dinode size that is larger than what VFS
i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
writes it directly into inode->i_size. If the value is larger than S64_MAX, the
incore i_size becomes negative. That negative value can bypass the existing
stuffed inode size check:

inode->i_size > gfs2_max_stuffed_size(ip)

Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
passes it to memcpy(), turning it into a huge copy size and triggering a
out-of-bound issue.

Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
inode->i_size. Also make the stuffed inode check use the raw on-disk size while
it is still unsigned.

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 662d033fd2caf..2597e1cf2315c 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,6 +393,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode_state_read_once(inode) & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -418,7 +419,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(inode, be32_to_cpu(str->di_uid));
 	i_gid_write(inode, be32_to_cpu(str->di_gid));
 	set_nlink(inode, be32_to_cpu(str->di_nlink));
-	i_size_write(inode, be64_to_cpu(str->di_size));
+	size = be64_to_cpu(str->di_size);
+	if (unlikely(size > inode->i_sb->s_maxbytes)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	i_size_write(inode, size);
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +468,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		return -EIO;
 	}
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0




