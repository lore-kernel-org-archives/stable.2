Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B03C0A01
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170071; cv=none; b=YonRum/PRj5NsrmBzrqArhAHk9ie8E1wlrv+2HsyEfoKhvWaLeOrWRcBtu9svXcADwYr5wgP/BjRS8vhXZAHPsZ3rQLcJ7E56/3YfWbClMmUzI7wEktDPfcEUmXAmniJmK8QYu+T3Qp06ESF58roilqbcV6o/JGRXJxc3LAiPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170071; c=relaxed/simple;
	bh=rFwoxfML7MeaUO/r/csw16dOZ/Xg3fvknMP2ZXrerZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNFbe+XfVqPRJteZOYeSRUPQcC9OQcWxHSw3liMuz5BlhL5JCWGMxPmCAK3iHUbFngTbOn1FrL0NIP3FgVs+RVx0FGXm8wfrOcekDxp7Usfwh9lFEqGuPzc4oVQj/q4rQoIokBstUNNJNRi4jE4Yauob/hkX7HyUhOL/7WPvokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orZLl4cf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orZLl4cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D861F00A3D;
	Sat,  4 Jul 2026 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170070;
	bh=LnLxIea7IXYOSlaNBvxhruvp6R8QM01V7sXO35nALi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orZLl4cfHWMSmfov1lMM0f6aBsOtm0KFnwzli5+XRCmOrUurT2s9VopQXYyKrzH+X
	 lTsbw+rlhlBR0mZ08Jl6FI0fqBAYxNB9BxlXrbZod482rXz3OlOU4RkdNNdrqmI5o2
	 yY5p89lWv52nZSl+ayP1n67Bwu86AKhybTvpka5d+uj3aM1OYbNDFAzkJwqYZap3T9
	 tMQ49x0/V4+YV4aavwxQ7XCQYhk9cbQqhaDfOGkKFU+DUp5oXRaP/XX503l/74ztNJ
	 3pQJ5zdj7L1CCEYFyCTZIsmLWKiXKCcgZrdkze6e+bFOYV839VfogiF17Ac8vzgZtG
	 4R2/BClPh9AuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YH Lin <yhli@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] f2fs: optimize trace_f2fs_write_checkpoint with enums
Date: Sat,  4 Jul 2026 09:01:04 -0400
Message-ID: <20260704130106.828918-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704130106.828918-1-sashal@kernel.org>
References: <2026070234-outdated-refutable-f834@gregkh>
 <20260704130106.828918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: YH Lin <yhli@google.com>

[ Upstream commit 8d1cb17aca466b361cca17834b8bb1cf3e3d1818 ]

This patch optimizes the tracepoint by replacing these hardcoded strings
with a new enumeration f2fs_cp_phase.

1.Defines enum f2fs_cp_phase with values for each checkpoint phase.
2.Updates trace_f2fs_write_checkpoint to accept a u16 phase argument
instead of a string pointer.
3.Uses __print_symbolic in TP_printk to convert the enum values
back to their corresponding strings for human-readable trace output.

This change reduces the storage overhead for each trace event
by replacing a variable-length string with a 2-byte integer,
while maintaining the same readable output in ftrace.

Signed-off-by: YH Lin <yhli@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8712353ed80f ("f2fs: fix to do sanity check on f2fs_get_node_folio_ra()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c        |  6 +++---
 fs/f2fs/f2fs.h              |  6 ++++++
 include/trace/events/f2fs.h | 19 ++++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4c401b5b29336b..300664269eb624 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1673,7 +1673,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		goto out;
 	}
 
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_START_BLOCK_OPS);
 
 	err = block_operations(sbi);
 	if (err)
@@ -1681,7 +1681,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	stat_cp_time(cpc, CP_TIME_OP_LOCK);
 
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_FINISH_BLOCK_OPS);
 
 	f2fs_flush_merged_writes(sbi);
 
@@ -1747,7 +1747,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* update CP_TIME to trigger checkpoint periodically */
 	f2fs_update_time(sbi, CP_TIME);
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_FINISH_CHECKPOINT);
 out:
 	if (cpc->reason != CP_RESIZE)
 		f2fs_up_write(&sbi->cp_global_sem);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ef1a3861b0bf5c..31252fb1b06bd1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -319,6 +319,12 @@ struct cp_control {
 	struct cp_stats stats;
 };
 
+enum f2fs_cp_phase {
+	CP_PHASE_START_BLOCK_OPS,
+	CP_PHASE_FINISH_BLOCK_OPS,
+	CP_PHASE_FINISH_CHECKPOINT,
+};
+
 /*
  * indicate meta/data type
  */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index edbbd869078f06..abf5bc7dad9a0b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -50,6 +50,9 @@ TRACE_DEFINE_ENUM(CP_PAUSE);
 TRACE_DEFINE_ENUM(CP_RESIZE);
 TRACE_DEFINE_ENUM(EX_READ);
 TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
+TRACE_DEFINE_ENUM(CP_PHASE_START_BLOCK_OPS);
+TRACE_DEFINE_ENUM(CP_PHASE_FINISH_BLOCK_OPS);
+TRACE_DEFINE_ENUM(CP_PHASE_FINISH_CHECKPOINT);
 
 #define show_block_type(type)						\
 	__print_symbolic(type,						\
@@ -175,6 +178,12 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 #define S_ALL_PERM	(S_ISUID | S_ISGID | S_ISVTX |	\
 			S_IRWXU | S_IRWXG | S_IRWXO)
 
+#define show_cp_phase(phase)					\
+	__print_symbolic(phase,						\
+		{ CP_PHASE_START_BLOCK_OPS,		"start block_ops" },			\
+		{ CP_PHASE_FINISH_BLOCK_OPS,	"finish block_ops" },			\
+		{ CP_PHASE_FINISH_CHECKPOINT,	"finish checkpoint" })
+
 struct f2fs_sb_info;
 struct f2fs_io_info;
 struct extent_info;
@@ -1541,26 +1550,26 @@ TRACE_EVENT(f2fs_readpages,
 
 TRACE_EVENT(f2fs_write_checkpoint,
 
-	TP_PROTO(struct super_block *sb, int reason, const char *msg),
+	TP_PROTO(struct super_block *sb, int reason, u16 phase),
 
-	TP_ARGS(sb, reason, msg),
+	TP_ARGS(sb, reason, phase),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(int,	reason)
-		__string(dest_msg, msg)
+		__field(u16, phase)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
 		__entry->reason		= reason;
-		__assign_str(dest_msg);
+		__entry->phase		= phase;
 	),
 
 	TP_printk("dev = (%d,%d), checkpoint for %s, state = %s",
 		show_dev(__entry->dev),
 		show_cpreason(__entry->reason),
-		__get_str(dest_msg))
+		show_cp_phase(__entry->phase))
 );
 
 DECLARE_EVENT_CLASS(f2fs_discard,
-- 
2.53.0

