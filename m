Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273897;
	b=PV4287B+0Kk3rt0UYwgIWQ14d9HJVAKf4/tu80VtYZXjoWhGpA88pTMZfSI+gEg4Ovxl
	 n1KU6UcLyUZhDiVAVsgtfOBD0Rz3gv8CICglfCyDOMPiQ+lScO8GGBWdmead/6GV6V9RS
	 INccw9cHL8IagmnMbEpdM+s/1waQo9MLXGoyBs+W5526XkbGRjMDS/lHT1Z5ga2yOiE7s
	 /zxrjai6+022venPtLOdVqRZWSk7q0dVRl/3oaXhk3+Xub0fPk0Yx8+cngzOFhe1m/oB1
	 LE044YM8tRYAHG+O5qiXXHen8UHzPNIY++Jb53OYlEjUlXigeA6/TpSf7omHscxWs2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2s8YHg1znASwwqBROh724q8iLsHdN8CQA0eBPfGHhjw=;
	b=L0xCRGxWt2uvT51nn3z/vfMQ69k/PzLgp1Y08t/7iHgsQ4MPu/MS89NTXiXdCmgYunuH
	 a9RriF0XySen/Xzm7fFzzLAQPzdQtPv0QImjMezFWa8flLUI26PLs96EZkOHOcZ9y2yzL
	 BSKee+kARKnoNTDqhJENgRyUHHTAkTTgW7xGYliaQYJh89vVot2QMBx8t0Rsh13mIVx87
	 I9vpy2+yUfP72Onm5XBl2Ooxl/d8Oh3vLJrwIvLrHb0IQHDc/cqzk+Lncj1RJjRozHOCH
	 pqPMjzOB1m4wMmcwXOOPsygO9TOegiGW5Mf0Xhb1Vw3NnXYBvv/9iTLLnuFlnsDqw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihpuVI55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54B6071840
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihpuVI55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DE61F0089F;
	Tue, 10 Nov 2026 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273896;
	bh=2s8YHg1znASwwqBROh724q8iLsHdN8CQA0eBPfGHhjw=;
	h=From:To:Cc:Subject:Date;
	b=ihpuVI55mcS5HwMjrkUaExSV4QDrHl4dlFt4hO2BOnI50Wvs0LWMjeaE52Rv9udD2
	 pG1BMdG5bbwbL7+nIVBXPw/54MUULhEsmsSBhkafXDRLq59QwtXeR1Uyf7l2NVJO8O
	 Bpzj7t8H5RErF0cKFLB0hnAngk9xkSiAJsDQxxZfxQcOOk4FSBN9E8JR6l52ybraHt
	 YQ2NQxKxEAGy7Ct9rn4ZSuCzeUdmlxIPNnC2FakNmHngTm6Y45DwtXrJqkP0V5R5sL
	 JvrIa1WzDEOX4vWb5kqfgAknf7Gv+9ZLjs4ZN6uLhJHSFrJMTvvaf8yCVpdIDnmA36
	 02qT8oVSdYr4A==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: fix preallocation discarding before an empty allocation extent" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:55 -0500
Message-ID: <20261109202455-failed-5.15-0c52750caaac@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0c52750caaaccee8b0e929450fe6538ec4985722
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202455-failed-5.15-0c52750caaac@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0c52750caaaccee8b0e929450fe6538ec4985722 Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Fri, 30 Oct 2026 22:05:36 +0800
Subject: [PATCH] udf: fix preallocation discarding before an empty allocation
 extent

udf_discard_prealloc() finds the last extent of a file by peeking at
the next one with udf_next_aext() and stopping when that returns 0.
The peek reads into eloc and elen, and the code then uses them as the
last extent.  But when udf_next_aext() returns 0 they hold no defined
value: if the extent list ends in a continuation descriptor that leads
to an empty allocation extent, they describe that continuation, i.e.
the block of the empty allocation extent, one block long.

The kernel creates such lists itself: when udf_delete_aext() removes
the only descriptor of the last allocation extent in a list, it leaves
that allocation extent empty and the continuation to it in place.

If the last extent is a preallocation, udf_discard_prealloc() deletes
it with udf_delete_aext(), which finds the following allocation extent
empty, so it also removes the continuation and frees that allocation
extent's block.  udf_discard_prealloc() then frees eloc and elen: that
block a second time, instead of the preallocated blocks.  On a space
bitmap the preallocated blocks leak and the free block count drifts.
On an unallocated space table the second free adds a second free
extent for the same block, which is later handed out twice: fsx as run
by generic/091 and generic/263 ends up with two parts of its test file
in one block and reads back bad data.

Peek into separate variables, so that eloc and elen keep the last
extent that udf_next_aext() returned with 1.

Fixes: cfe4c1b25dd6 ("udf: Fix preallocation discarding at indirect extent boundary")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/480eccd1264a4cea5226fc36ed108931b2c403fb.1793349907.git.matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 0990f94b85518..75151a59f0da6 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -124,8 +124,8 @@ void udf_discard_prealloc(struct inode *inode)
 {
 	struct extent_position epos = {};
 	struct extent_position prev_epos = {};
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
+	struct kernel_lb_addr eloc, tmpeloc;
+	uint32_t elen, tmpelen;
 	uint64_t lbcount = 0;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -141,7 +141,8 @@ void udf_discard_prealloc(struct inode *inode)
 
 	/* Find the last extent in the file */
 	while (1) {
-		ret = udf_next_aext(inode, &epos, &eloc, &elen, &tmpetype, 0);
+		ret = udf_next_aext(inode, &epos, &tmpeloc, &tmpelen,
+				    &tmpetype, 0);
 		if (ret < 0)
 			goto out;
 		if (ret == 0)
-- 
2.53.0




