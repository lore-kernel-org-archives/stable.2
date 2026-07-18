Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA943207A20
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373664; cv=none; b=rT9Ga6qhTPUYEv53iKOLQOTpwA89Eg8xS9Amp2HZ4avQa9mD/+pzc+ij0Qbk+0Km1k7rF8GKabW2HpW9JPRgRqQk+gvhrlLL9iFWsNHgEkSZSsrfMP0V13/yEVLPkgAfDlNyWGGLRb2MbR2aBDAbXxFeZzAfAOhvAUZhDKEBVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373664; c=relaxed/simple;
	bh=tYWdO0NoKP4oLMpV0JjPyN8vmRFD5US/VLJQ0iXJdQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbe8fhgbbzt2fWrqOLSsmSuSSjE6zKAwh0CMrfOkMAk9NoRW/hCjchqmDqVZafR5rRG32yVd5N/NSQj2VX7CW8VXjIaavPdWNePEzYr4+V1SY9RCGiokJhMduUKFFqnLZdn8zEi9jyZrGRErCx2q0WTe3da6cxVcDHIouS47u68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFTczWmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFTczWmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183C1F000E9;
	Sat, 18 Jul 2026 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784373663;
	bh=v6yFpgJchAczlSnHTdMML5t+xEZQf7UtNHN4vyyb7hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFTczWmtZjipmnggPzGChV9wHoas40C+hZKIoznE0Gogd9NoFyW53fRGvxeI4tr5R
	 pM74yB5OOcQ2l5CYQb/v2KOBcxS+h4P/sRcAd/pePaxinBYjauYZURU66TiVH6r71F
	 758eKXHBts0d+wvICrlR3t8zzis6Fx1jyU87KlW7cccWmb4jGugn0djS1UnTLQTWGc
	 8fGlV6Ftbl4yyHwWfj9QnS7xYYWksp4hXMOuDodmAelzQMthGghS+hn7/TtvNQ1aZY
	 zNxslKfSgtI3Yf4yT2pyy1E6rWQ13olaBWzA1jqmQDr6Uv/yL1/pf1rgZbR1tOFMB1
	 h2N6K6V/0zmqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yousef Alhouseen <alhouseenyousef@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: use null daddr for unset first bad log block
Date: Sat, 18 Jul 2026 07:21:01 -0400
Message-ID: <20260718112101.2964955-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071429-resilient-tidy-1cad@gregkh>
References: <2026071429-resilient-tidy-1cad@gregkh>
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
[ adjusted hunk offsets for context drift and dropped an inapplicable whitespace-only end-of-file hunk whose context doesn't exist in 5.10 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e61f28ce3e44e0..86831b1bbf58fe 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1034,7 +1034,7 @@ xlog_verify_head(
 {
 	struct xlog_rec_header	*tmp_rhead;
 	char			*tmp_buffer;
-	xfs_daddr_t		first_bad;
+	xfs_daddr_t		first_bad = XFS_BUF_DADDR_NULL;
 	xfs_daddr_t		tmp_rhead_blk;
 	int			found;
 	int			error;
@@ -1063,7 +1063,8 @@ xlog_verify_head(
 	 */
 	error = xlog_do_recovery_pass(log, *head_blk, tmp_rhead_blk,
 				      XLOG_RECOVER_CRCPASS, &first_bad);
-	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) && first_bad) {
+	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) &&
+	    first_bad != XFS_BUF_DADDR_NULL) {
 		/*
 		 * We've hit a potential torn write. Reset the error and warn
 		 * about it.
-- 
2.53.0

