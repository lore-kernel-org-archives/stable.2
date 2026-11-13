Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599594;
	b=xwrGD5RuHp5mTiEWET3Dyd62hNizv8gTzDH1GolxQNReshkjpPC3+M1xakRTHw6nFvaz
	 DFVDvz72OBH80uiS/zs6VXAvzWnFQJfWXPsfzh6HrhQRc4K1kkAIo8KAh+ohGJy9r+288
	 0I4IWz3AsvWRQLEZjQ709WENW5Tzr1bcL/R092FJQ9T239mND9WW6JAI9m3d1UW/5Yk6C
	 YkDTXsAKH60AWA9XzdsNp8L9FgXDRWfuLJLoLxEi0x7Z/4kbOnn81VHSZ+7Lg1kO8thwo
	 tA3Z0oLYyckuBHpc1rGRmnpFoHkx4bfCrAMQvZAaUhYdY2G5iSZowIAtpKu956qPO0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599594;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D9IFwLlcVpO7hDrzEhrmfOIIYMZ0YpVTzRkgyy0yotQ=;
	b=QIZhFWIgLt4zEL/cILcl7/XaoygdhCyILNX9BdpbgW+CvzVO1lB26T3NGJv2DW7p/WQG
	 6SkTBfbNXmf3GpP2BZC2zU037M5Qqi2qP3MewGlYSmdaf021yKIXXFD4LM1hSxImu/TBo
	 MyaK40AbPpiypAp1+gPTgMaIE/GsnNpVB9j+Wb25dXes6kguWkfrXYsGRWwZcOQ4ME6rD
	 c+Z4+gNGvKUWW7e12B5BgaxmEdwRxebSKZtg1K8KEPwQuk8DUlWCwHBJ6epCdfvYBrWJh
	 uA/MnelY3K14JkzsWLFtqxjmKP8JrUTPiQuq8x4nt1Yibypf/8f5SN5hvLRJ+qHwuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/v0NhtN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C0606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/v0NhtN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC51F000C4;
	Fri, 13 Nov 2026 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599594;
	bh=D9IFwLlcVpO7hDrzEhrmfOIIYMZ0YpVTzRkgyy0yotQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/v0NhtNN2XyLm+hMI+KhMZ2xpttKZobNVFqNqkGHT1u0jgM2bMNPZ3a5hAkP9Oeb
	 /AdVYZvitrPwKt9EYeKfpgbFk4w6FicK/tS9l6z4k9sXA/bvuV1cbGzHxB2BLnLhgT
	 POLalf6l61jT6ldH7VVfmCvMeNGV7onTWZIRGLK+GsNrlWUL7UGGQ/szCx4oFsuyNw
	 jCXQrM6vvgLEidK28jrhvH1sFOkk7Rypy5z0GqU1O+KeO4tkTekB3/G/vS7ozYzBtN
	 grjrnOhww1+zh6AKXcKGU7pc3F2K2soLQH+hr3PFa4JBs5HeqLfM+gprlOXEfkCA/6
	 fJuhN8zVyhWfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shubham Antil <shubham@octane.security>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] vhost-scsi: zero misaligned I/O bounce pages
Date: Fri, 13 Nov 2026 14:53:10 -0500
Message-ID: <20261113195222.2537874-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113195222.2537874-1-sashal@kernel.org>
References: <20261109201252-failed-6.6-01c3a5fa6d64@kernel.org>
 <20261113195222.2537874-1-sashal@kernel.org>
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

From: Shubham Antil <shubham@octane.security>

[ Upstream commit 01c3a5fa6d641c93c7cef4fb25c5f12938316e18 ]

The misaligned I/O fallback copies the full bounce scatterlist to the
request buffer during completion.  If a data-in command transfers less
than requested, part of a newly allocated bounce page can remain unwritten.

Allocate bounce pages with __GFP_ZERO so all bytes copied during completion
have a defined value.  This path is already the slow fallback for
misaligned I/O, so the added initialization cost is acceptable.

Found during an LLM-assisted source audit and validated with a QEMU/KVM
vhost-scsi target using misaligned data-in commands.

Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020105503.75904-1-shubham@octane.security>
[ sashal: adjusted context for the sg_count-based scatterlist loop ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index f03170888a896..8aecbc32350de 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -760,7 +760,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	for (i = 0; i < sg_count; i++) {
-		page = alloc_page(GFP_KERNEL);
+		/*
+		 * Completion copies the full bounce buffer, including bytes the
+		 * target did not write. This is already the slow fallback for
+		 * misaligned I/O, so zeroing is acceptable here.
+		 */
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			i--;
 			ret = -ENOMEM;
-- 
2.53.0

