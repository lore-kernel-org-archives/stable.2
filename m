Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752356;
	b=FC2c6/qQQfF3M8u3PKRGL2kPBAmfb24g6zL5l/IZ4Am9if77lk6plYvgHhN82dCj+0MJ
	 veKMEYJUjqBqbVCSofnDvj4BWLsdToUV4Y3PFyMPM1iTwKtBP7Gr4P11BjVtFCALVNm8u
	 NzHSpf+6tcJmcJ0WmSsnrtSyIhCEXtfWJL+Lng51Pz5v2mFr+0hP7h4UV4MKiXwaid0lk
	 z5/Ryi4Yo6KQ81h6jEFAYPMgMKtcH0hhyznlHe4JOiS3fuEJwTYXnFA3djbuXx0NfWMdS
	 EVgOWoBPMzmouhc8g1OQIG8XBQoMfIzVN56x0lRnwEYP6ZTxv9o9EV5vOLAfXFF75sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Sy+hu38wW44MF1mFtyFNxF5IwrDSVwm/A6HAgQVP0E=;
	b=YhiVCq5A94st5SVE2ZspoeRpkGGDUQ427udAbrDWGEgp7OV8sRr958J6u/2ou3KJ907/
	 wNgU2qXvzGpJUncUi/JTLeHaD416caYtCHaXYZl36aBxlo4fnPy9AND9iBzVyh21HbNMY
	 L9Vi5HrVynzUYlidOuidDuC911tHtJyYTwmqPELkxU5v8FY5sbOc6J7zFIIRJxp/1PDi2
	 qAuUcyX4Omvv7K4zv2/TlWSzcv8rL1IIT81VBQ5qqFbionHqJfJCldqzwI8HbcrbqNhFv
	 SiVDlrmrTIZdVKr2g2uA2TOGPoyBSoQhjo4X+VLUu+Y9nXgypx+YKSu1BTw6qxynb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVQyGp6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D4606A32F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVQyGp6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0501F000C6;
	Sun, 15 Nov 2026 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752356;
	bh=2Sy+hu38wW44MF1mFtyFNxF5IwrDSVwm/A6HAgQVP0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVQyGp6KsKdjqftb7bqNo5KM2+Mw9pZix/yFSETgXAw+zyrXbgnXXHiR2zx2NMDxK
	 TRDDvPTOEOQHMcLfCxw16H1GiIsrhgR5N0IFeISR8RYCpT6m+4+bd9+HvXSfRbJA8X
	 FJXduKuLzZ7JYdsKyzwDYzck03IkliFEMnUyK0Tvbu7JUktKsGJT3+VU2aOYBcC7+8
	 YYTpu9ty+mS4VmSOBLw6BsE/M6zNkDcg2l7SM0R/t2+Pg3RrKsoABBP8FsjNFgCcLB
	 tIEzF5zrj5TJf8ETUS6vr8d+Rl2JWrSkn8hWIrPHLlFZlMnyTst1LcK4YqTiGYtLNI
	 Hb+rMgwh/4Tdw==
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
Subject: [PATCH 5.15.y 2/3] ocfs2: add extra flags check in ocfs2_ioctl_move_extents()
Date: Sun, 15 Nov 2026 09:19:11 -0500
Message-ID: <20261115013217.675970-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115013217.675970-1-sashal@kernel.org>
References: <20261109202229-failed-5.15-84db6619cb70@kernel.org>
 <20261115013217.675970-1-sashal@kernel.org>
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
index 3280e0d60f09e..32364234ae66d 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -1045,6 +1045,12 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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

