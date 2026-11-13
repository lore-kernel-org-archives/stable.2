Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599197;
	b=mqB7+AJzxSHgxwHluXwC6Bndsx9qNN8Ovv4pUJKhL6Y7MiZEIPKRT/cOiaPTMIQuD1q4
	 4xYXTrcxnUMnM1GUEpGLmhedpuNwhoxRZ5DODUv6YPjNt77vwnTzUVMNCbaKpSUBpJO26
	 DInu8C8E5CdgZZEHfv3h3mP6nJWmquXB2Y0A6ry46pIoQe4tr6ixv0vluh0lNfZ0LWPJr
	 rZO25N9AUwCOLLqf9Z9PBL5Wu/TFJw1dbn6n4jDCQqBA01I3hKIbpmK6+sU+lftTuQhZ6
	 ZCcFUIpwwSLstufPFHwSUVbFr08slz0nQusuQvyuQFjDFWzfOYu4X81AYvRsGFIcpAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OYoxHJH29SsRfHJjV0cuPqXqeENRX3UmPzflshvlgGM=;
	b=IQTO3rd9E0hf/WQ6YB0xSetGUVFDByOVw1mKRhxvC49jZmo49Q0fqkUI8HhalNpl0G7W
	 jMkgNfXzP7fIJyVc+r5M25CO5kb2koGk9Y6nWWoC3365iN3d0BRtM7U9//Sjn0hRldNWD
	 Lo3JMvrfdq3aseANjmHgSeeoXd/9E+hXZDP5alMwiPrIC87cgj99rLerC0fuzUb2IE966
	 eb6I6SXPe7IDb/TSCMTy+Pk12bQxupp2w82dxOmva74JQ+2O+twTcc5k4AkXBGWPc36e6
	 XGnfbluv/JPvToY6ZuzzPbTX46WRWe69q597EZQ9r7/WuVXVTX06L8ERHaJJKf87sgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXKC0+Kd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6710606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXKC0+Kd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E308C1F000C8;
	Fri, 13 Nov 2026 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599197;
	bh=OYoxHJH29SsRfHJjV0cuPqXqeENRX3UmPzflshvlgGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXKC0+KdirZ8y9zufYyLaNX8k2zJKD4QgGljopU65K+7gvVbeeHcwpKm1n16H3nWI
	 WyU50CKRCzpo0HvesmxvE/hlsIi+Ma4anr+NheIC48fXzszfoU5Alpf33yYe3L3uiH
	 XwOy1KlusPPTrUWlgDRzFmnrGAIgqjvIB8gqHftyVwVRjJQ2ElD4LTfZc4546z2Qux
	 WU6MHJETe+YPD+GDeR5/toY3W9+2jZZK+r2xd0NRkvi0z9bED4tR5Ibc8wkYFfDsnD
	 xBdsFFWhNoOaK9LJQ4+LD3Nje6OA/HLaJK5YeDg7d1TwAAvSlW+qvGVptb3Nr63rIc
	 I/jl3Xs6ZzPfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shubham Antil <shubham@octane.security>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] vhost-scsi: zero misaligned I/O bounce pages
Date: Fri, 13 Nov 2026 14:46:33 -0500
Message-ID: <20261113194602.2463861-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113194602.2463861-1-sashal@kernel.org>
References: <20261109200826-failed-6.12-01c3a5fa6d64@kernel.org>
 <20261113194602.2463861-1-sashal@kernel.org>
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
[ sashal: Adjusted context to retain the existing indexed scatterlist loop in place of for_each_sgtable_sg(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4e1b5184cf36b..5a904241f6311 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -771,7 +771,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
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

