Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581371;
	b=Vr+DHX2yg6e2zsyJADPlfmKT2Xn6UNjAdjz73d7vMYjCCw57dRo/wlaH72WO8fOe4dNB
	 ds8A1IpKcamf+NVc0OC6hqSePbO3KF3hnkwq9c7JZEjDWDn1FApafrFRw/53TaFRaGW/i
	 O8sfLbTJNEpS9c8EIHYnfkrV1LgvQk4Fo2CW/oeA6T8FspwQHQI21pyDAls2Hv5JnRg2T
	 tiT9kAy/WYcRaH0LlVLtGK/AOR/SV7xIuBOnCuozAiXjA1h3DxV+c5yIHj2PZdhRcwIf+
	 l/Z4mWQFi9/zyRnaAaMhybXB8BINQPT1dm23IVzi0sGq3giUk17+KBlHr+bNkEw0S4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+MEiDVDJQ9/X1ABzsySyUhN0JtjMH/LDWixekK6xAj0=;
	b=4Y2Iuvk2u2Y/j4hw7hQi+Q0vP9dDZwVj6+SQabPRi50lcbKsYpzETEHWnKw1JP4mq22d
	 uT9deSzYXoPCyOYMF11NhBkWDbeVsqRWXwTqdUY4TOx9ubp3cSjFt0C++OLOKWXjuX10s
	 wH2TF+mp23sLwcFoWAogytf1YWw7//Mk/rJdTROE4IRfmvSXJk9hnlTMXAIilCbnJVIUl
	 PzB+lH2xQcPtNseohgkZUK/orVfyBJ3kPB0uhfDGi7k5jaM4l620qjlDm1MJa6HcEk0Fy
	 bCnzgEX/QHa0dDSdTDw19/jQoOWrCtULIgVJWX5fdlaiRl1obAOcQ7c7hqGRJe76x8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DprEdvRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46329606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DprEdvRW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2CA1F000C4;
	Fri, 13 Nov 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581370;
	bh=+MEiDVDJQ9/X1ABzsySyUhN0JtjMH/LDWixekK6xAj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DprEdvRWZNXHGkFP5NhxrHVY+lhhx0c4BvD93VKBPjrAsa+tneup/TjD9VcoyBkGQ
	 apx/nichzUq8+aOs7a2tCQI7+rIuCCf+TzA8aK0Qshijsfpq3vqLr9R7J7iG0G0FZL
	 4OEPO9GzR32sW4ksjBYjhqRDgaLnCnWjPfsfWX5jZwvZ3bpTDSsjA45KqTUDBuJliP
	 dqcfAO6CaKPsjwQMzmIkhPizWq5I3eyBsTxxadPdO96LtVs4iQcvc65LrU4QF+VIva
	 xXGnWjAWqnNFyP6ZZT2xbM3DDoAIQqJDDO+80F62NLLC3VdduJQsXZmt5T7jnqdQW3
	 T0OygiwxSeJPw==
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
Subject: [PATCH 6.18.y 1/2] ocfs2: add extra flags check in ocfs2_ioctl_move_extents()
Date: Fri, 13 Nov 2026 09:49:27 -0500
Message-ID: <20261113144806.1427542-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200438-failed-6.18-84db6619cb70@kernel.org>
References: <20261109200438-failed-6.18-84db6619cb70@kernel.org>
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
index 831c6c648f04f..f599978cbb9b1 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -1044,6 +1044,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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

