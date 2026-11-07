Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047978;
	b=W3sVbPrTSAs/mW+cx2mvscML0zbPjnGrxAcieCqmhkvh+uEDYcIek2X4uDKZR5EGv8z7
	 hiJreOthEy409fBlJdRepRiYgmyPJ9vTl4d2enDBds+9o1wjWilsvqtELQnp9bcKlvetr
	 bHrVHCq6wsmF7900NzWrCy1j9S03Cl1Gl6pQf/EPUwjjHYa5qtZG+3xOtU9lUrTjnyZBa
	 T03W7uocQYl0ysZ8Tu1zt5obwL5Aorgv58Yf/ntmDrYNoXgPCEo4okXd8KeOoIGym4fBx
	 1FCQTzkAQ+DFqKqdOvz6ah02EkuNrKrdmcq3JipvhXVR6dCUXDzg0e8FOwYjiYUJ1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q8TyUl/n4NimrBICp/EHZxwQQUgQ9sBNNSaw58kW8wc=;
	b=rz0iEALUmn+Sp0wkOtZKp6wHZVgDtOHaSAT/IF+2Z3KdQjqLk4NwJQssYjRpRof/cXWD
	 qSqrERCjASiDtyk+ySqbbiYyQajWpx6/yF/ZUcIRp/CCACuj47ktucQh4JF55JUGJhDCy
	 IP7KFx2MWgoPHvR8WTJAAymlb3yMxEsxpShEBl2atjMlcDeCttBeYb/ArTg9Y1JtilmQF
	 ClixJIiqjsn5KIXJq97N4Y2KC9xW+Q4b7VDFO/R2rWUPPNNSVjLxejCAEQI1LzU4QTKvn
	 9ohVy3gvgJgi1W30wuzW2aM6jKaDfbPJExuBbStNaoWYpVbolpCn6p/febSEVGNU05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ocp2WNGn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ocp2WNGn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4C71F0089F;
	Sat,  7 Nov 2026 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047977;
	bh=q8TyUl/n4NimrBICp/EHZxwQQUgQ9sBNNSaw58kW8wc=;
	h=From:To:Cc:Subject:Date;
	b=Ocp2WNGnuH/EmsXW0eZqDxufmoxX5riU7a+5ovpU5uhWHqJCBlCzQrAGczgRdokWy
	 PWO4V0iA+9u78367P/5+IqxUCS3UaI8+bRtrZys/6JeinPM2/vJfhQ+Sy51UJz2By+
	 4w21iOxO5LLXfhl2xxYQZ7uqESOMNEqp6NkfwOAqb6PDK7JSvwYfcK60lcODjliIRp
	 eB88emW81jLraWW/FmHFdu6XJhSRa0dmySuH0UV9NAl81QeB99R7Bob3eH4xioNj3q
	 ydwUH5yCkzoY91LbGd+zZuqOUVF6zj3Or7w4BeRToDsZdq4+UnOVco8SKeKo/KKIpF
	 Ub+IL2yp0YI+Q==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to update superblock crc in sanity_check_area_boundary()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:35 -0500
Message-ID: <20261107053935-failed-6.6-f8f956c7ec8c@kernel.org>
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
git cherry-pick -x f8f956c7ec8c0285d7a80bed497d2f7adcbded15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053935-failed-6.6-f8f956c7ec8c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f8f956c7ec8c0285d7a80bed497d2f7adcbded15 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 08:23:50 +0800
Subject: [PATCH] f2fs: fix to update superblock crc in
 sanity_check_area_boundary()

This patch fixes the bug reported by Sashiko:

We should update superblock crc along w/ raw_super->segment_count in
sanity_check_area_boundary() if sb_checksum feature is enabled.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 857cc2b299464..1071059f2cc22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4084,6 +4084,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.53.0




