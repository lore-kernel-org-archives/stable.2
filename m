Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898662E7F39
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217862; cv=none; b=NPysopTv2w7EnyVpnkurTvLskfLiupCwnop8dsIj2SvH/Se6NBZ2pA76GcgKCSdcbBI9Ms97JlK5zYXGVvjWALyRno4BDreafd1OBjpJXqCWKptvLG/1cnDOEqYdrlf0oHS2GWbyxW/KP6IWW2+9fnzdaD7WRd0webH6nx2dU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217862; c=relaxed/simple;
	bh=HYAPqraxn+fIsm+6mr9QOFCCG3RpTz7a7cvGvERlYz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt7mK1Q2MYPRfB/tRnLWmLlu86rE71G3wvKqR7s3cI4rxdM2PL3kxFyXbo99TGD2qGXDFbJhaLGUEkIdZS86uomX5bOyUEYTC7YkAjKMaBEUrQ6y+EBw8MstnZ6NaAdBTmtz/9f+dJrBppZlXiiYiYuv3zVV7/fOySrKxzwpr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEW1Th7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEW1Th7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA0D1F000E9;
	Thu, 16 Jul 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217861;
	bh=+ukzTUp9H1TUAuRXRwAWCPlX4yMeQEC91hMBBjnlq48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEW1Th7Yrg1rkB1HG9OxxTY4tFj7xllSfJrROPxLtNdr7nmfmFN3PeOIlifuDR/on
	 oygmsYZtRHNKJ2cA355S9r/3eR1l4LpkzkWdGuMFInIssK6IbLYK7KwuUIpEF7tnXN
	 gemXO9X4jstVH6wHJ1rI5w83P/2MXy0AFgYLAd76fzgytw71XbWb3dnjalIDRWj21u
	 EgC38OrVXLic/9UsQTcRkYgzTCsqStuQ0LXZz+d0nUlKEx1lAIHX4l+Te4YXd3qUgR
	 KCJgC92Idy66UgUXmSAUsltVdjpAnFJ3B59VTlF7C+r3XkIw8KvU+YYjSsKQIuMlQh
	 QNS3dBOVl7VQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <xizh2024@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: use unaligned reads in parse_posix_ctxt()
Date: Thu, 16 Jul 2026 12:04:19 -0400
Message-ID: <20260716160419.619801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071412-jester-ashamed-7c2e@gregkh>
References: <2026071412-jester-ashamed-7c2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

[ Upstream commit b86467cd2691192ad4809a5a6e922fc24b8e9839 ]

The server controls create-context DataOffset, so the POSIX context data
pointer may be misaligned on strict-alignment architectures. Use
get_unaligned_le32() when reading nlink, reparse_tag, and mode.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 302c08dfb686dc..e1aa3529e54529 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2039,9 +2039,9 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 
 	memset(posix, 0, sizeof(*posix));
 
-	posix->nlink = le32_to_cpu(*(__le32 *)(beg + 0));
-	posix->reparse_tag = le32_to_cpu(*(__le32 *)(beg + 4));
-	posix->mode = le32_to_cpu(*(__le32 *)(beg + 8));
+	posix->nlink = get_unaligned_le32(beg);
+	posix->reparse_tag = get_unaligned_le32(beg + 4);
+	posix->mode = get_unaligned_le32(beg + 8);
 
 	sid = beg + 12;
 	sid_len = posix_info_sid_size(sid, end);
-- 
2.53.0

