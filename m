Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C422689C
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338420; cv=none; b=Ksm7/7ZbOMUID3OpWWVp6h9f7zP2+HWy/G9MGqUybniYI9/yOYyD43tuTRMdgdo8LVgxjoWCyqI7rpF7pk9xrV0ng+U/KTnpSWmtk7Vp4svoDCALp6XPQUTgDnHr08RFdbsyyvzPV3i7R7WcCBv1i+Kh68gOnOoU1h0f5OVjaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338420; c=relaxed/simple;
	bh=AJgf2kNOkQCiqAfUH42yWm60zMKHUwqJSzE8oga5UVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBR3e65F1Anp9UsFPnjjIjngyI57Sasfzc6hUs2XOXupz/TLVxmzhDvYYCXFWNbSDiKnUJRLnyUF08i5UhaYuXmJS75cC3hBTQakHbCfTd/ZeQ+8wKkqJGqX1EPMRbkyIzoOi5Rwne4e4te3dO/d7qwdlPcqUNe+E69lr1yhs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkamrmhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkamrmhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AD71F00A3F;
	Sat, 18 Jul 2026 01:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338419;
	bh=cRzjSXHoZYPANYZOqvJH52f0+I4gqyX+O3voU5ORLK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkamrmhWTS49AuE8fF7EHNqYCGw1q92Swu+x3KCBiiV++L8CxpZjjO2y03m1ze3BC
	 olEvEGNXMvour61aGRGd8HJHiHXEaDHZwLTDHiPSt1/H133I7/VJAyKG/kYpCoY39j
	 +FkX0sdiT1+9u4BQF5lLshv36nlYQwDs9EBX8dYZwxbGva8XgJjFaasMf97jSQvwMd
	 +ZSBOaHPq5qkxfkulg9IWLNIVJrKEdk9AA+LM+nhou1BkbXIAoBfygWsN4mDhMOEgQ
	 cXpfLqe9V92XIb0LlVTjSIF/Ofj9XHbDQpmPRb58R0AKokFIMCxwTb3Ukw60wZvuxu
	 lC+S0m5k48NTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yousef Alhouseen <alhouseenyousef@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] xfs: use null daddr for unset first bad log block
Date: Fri, 17 Jul 2026 21:33:35 -0400
Message-ID: <20260718013335.2621394-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718013335.2621394-1-sashal@kernel.org>
References: <2026071429-showdown-footpad-d6da@gregkh>
 <20260718013335.2621394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yousef Alhouseen <alhouseenyousef@gmail.com>

[ Upstream commit cc9af5e461ea5f6e37738f3f1e41c45a9b7f45d6 ]

xlog_do_recovery_pass() may return before setting first_bad.  The caller
must distinguish that case from an error at a valid log block, including
block zero after the log wraps.

Initialize first_bad to XFS_BUF_DADDR_NULL and test it explicitly before
treating the error as a torn write.

Fixes: 7088c4136fa1 ("xfs: detect and trim torn writes during log recovery")
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b7dfbed0c6c2b5e9fd34
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index c439afb7a7aced..4c9c06d6021ab1 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1028,7 +1028,7 @@ xlog_verify_head(
 {
 	struct xlog_rec_header	*tmp_rhead;
 	char			*tmp_buffer;
-	xfs_daddr_t		first_bad;
+	xfs_daddr_t		first_bad = XFS_BUF_DADDR_NULL;
 	xfs_daddr_t		tmp_rhead_blk;
 	int			found;
 	int			error;
@@ -1057,7 +1057,8 @@ xlog_verify_head(
 	 */
 	error = xlog_do_recovery_pass(log, *head_blk, tmp_rhead_blk,
 				      XLOG_RECOVER_CRCPASS, &first_bad);
-	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) && first_bad) {
+	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) &&
+	    first_bad != XFS_BUF_DADDR_NULL) {
 		/*
 		 * We've hit a potential torn write. Reset the error and warn
 		 * about it.
@@ -3540,4 +3541,3 @@ xlog_recover_cancel(
 	if (xlog_recovery_needed(log))
 		xlog_recover_cancel_intents(log);
 }
-
-- 
2.53.0

