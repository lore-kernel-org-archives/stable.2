Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754833;
	b=Ax665tNoHOAnzBg4k7tVMrxMTfgj0JblkdxWPkEh+2BgJdJSHj9Bz1dlKQQE9LrLm8Q1
	 EuQbtP/R8u554Je/4sveW3Bes6GiwwqEaPXXcb7aklXm4eE7vo0zchICLeBHK9o5//wqq
	 lxQCSFqniJ5PUpv+bLop9XUVyLjdP97THCHI2hcrzPo46H8MtUdTluvTTfCzio865rxkK
	 1lJzg0/2lgo6UsSZ06dLbTpz1cZTxWi8ysu71a9NoKLGPcylhKpW0oqw/tnEUaJWf0dcp
	 Mw9kfSm1TwAT6brx1hJJPlI0d/ufw6TDCoelt843t5HF3FvYSYr9gYvP+ZaSK1olNuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754833;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8gBECNNavqWMHTVGwaggiwhsm+PHe1W66rn7d6q2lN8=;
	b=JogGRHJfhdpHaP6P4YTv88mmoOHZ3P4wOBsWqyZ4bkmzm+GMM/ph0Sgi9eVIlg95UJAu
	 LyqsW9KXcIwALSxyuME6Sju+cD6TKychrq1aDlv9oKhjiWf7bieYvyXn2ymiEZrsAqufO
	 IXERc/1n1qbflaTOCn3LiMFEN5Yc70p+14ilJhzWHo01ixEfaxT0LHSaZQt5ypZZChNsT
	 lBx+u1gx8DMTJCs55+IoLqFh7a6thpk25WmKPCyiUSMi29c6HTG0QFJfriib4xAVsAQk/
	 AtPjPamAfjubXNefYMBYNaxZmFqrRp3U6POwLuENoyJ/6H3sbv0wMukLwDm678m5Rkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgWKT+XS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC5606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgWKT+XS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8AC1F000C6;
	Sun, 15 Nov 2026 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794754833;
	bh=8gBECNNavqWMHTVGwaggiwhsm+PHe1W66rn7d6q2lN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgWKT+XSK0eiydUcs9290n6XBqH9EDZ+6HUPgY14GfP5bkBUW0G+98E4M1Pcope9+
	 nzOh6Iub3hXN/h2tMhd6ca9e6/PnhBeL5kqSLVpLABgYTU2MkaOexqHORKnooadoBo
	 KKyTpegK/67yjPtUIz58KCTQB6I8wCkV+2Fihgt1vr6pw3HG+08v/Obo5IkB/ygtme
	 CEaomcLDHfLxK/qEXX0cBZiRE/Z6fnge10ZuofSlL7T645JM+QbwX5s75RdrM0V+cV
	 /feXlQOo2U6ELRQtiy6wDMhMqD5c/KfY1sUqX3QacN4JcGE9fnNnPfmF5wFe7fp2lu
	 ySX4KnXHETcLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Changwei Ge <gechangwei@live.cn>,
	Joel Becker <jlbec@evilplan.org>,
	Jun Piao <piaojun@huawei.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Mark Fasheh <mark@fasheh.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ocfs2: add extra flags check in ocfs2_ioctl_move_extents()
Date: Sun, 15 Nov 2026 10:00:28 -0500
Message-ID: <20261115144803.1196375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115144803.1196375-1-sashal@kernel.org>
References: <20261109202709-failed-5.10-84db6619cb70@kernel.org>
 <20261115144803.1196375-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 41a5e8777093f7946fade3737363ef045303b8dc ]

In 'ocfs2_ioctl_move_extents()', add extra check whether only actually
supported flags are passed via 'ioctl(..., OCFS2_IOC_MOVE_EXT, ...)',
and reject anything beyond OCFS2_MOVE_EXT_FL_AUTO_DEFRAG and
OCFS2_MOVE_EXT_FL_PART_DEFRAG with -EINVAL. In particular,
OCFS2_MOVE_EXT_FL_COMPLETE may be set by the kernel only and
should never be passed from userspace.

Link: https://lkml.kernel.org/r/20251009102349.181126-1-dmantipov@yandex.ru
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Mark Fasheh <mark@fasheh.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 84db6619cb70 ("ocfs2: validate move extents against a stable EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index ef5ad7a04f643..f75fec5e1f6ca 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -1047,6 +1047,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 	if (range.me_threshold > i_size_read(inode))
 		range.me_threshold = i_size_read(inode);
 
+	if (range.me_flags & ~(OCFS2_MOVE_EXT_FL_AUTO_DEFRAG |
+			       OCFS2_MOVE_EXT_FL_PART_DEFRAG)) {
+		status = -EINVAL;
+		goto out_free;
+	}
+
 	if (range.me_flags & OCFS2_MOVE_EXT_FL_AUTO_DEFRAG) {
 		context->auto_defrag = 1;
 
-- 
2.53.0

