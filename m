Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564239;
	b=qipzoUDijegZ13okj39yxfYcPHfzW1YuzCjcNnBq4TnkzCi4fm/MEpf9nVsGLy5wkRlU
	 uoKH/pbgnQ7HPpV3DItwQW/9asSOIae8Kj43iVV5WBmUzoQKo1FP3oTxEpR94ifLD2f2/
	 r7R+sv3D2fb474DKFp+JL9cBLzkec5JA7fiLUVVw7oRe2rJ2XjZa1J/BMFjHZbBtV7t6T
	 XDvBopnkibji4pwq+55/8jGsP6FizdRGLupEFKvC6iJDOF76gKUjkWmcb4/3JJi63Y7Mx
	 YkHulVjlUagIJCWT3DdPiMPfM/QURtza80rL4EZg1TuaXKfj1bJ3uIKDpDy8zaZE2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8wlj5FpDeic+v8yxrZrAtSmK54+mvwJqssNV0e0k5U4=;
	b=miHTJ9nJXkkyHvPTbtNqYCQGgZo8Fe/NRgTbmbxO2oP6jJz3r3L11nZ28h6C6aHa+fiV
	 5D4O0jFkD+KHU4FAJKnx5vRpkj1Il/K62C+UtAyFshuPMMGYo0LWrfJCFEjkiibaUktpf
	 ZoOAPFAziiJOQJzTsdyabGBfHgo0/ucfsSNOM74VFBS5KARbgWvnucMnTF39Jc7CiKrwk
	 SvMgaSsMhrMJfjZg892fl1LlSkmU3MrXhHszwJrdCW75UJgKB2IrNlBRK2HiR1WPrC0yj
	 s/CWmOqxbp6WheSLRT/n9e7P+75IhoDczc4NHslA1emPSljKmKB23w/gmPQH0aPVsbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBdFyvU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E238606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBdFyvU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A841F000CF;
	Tue, 24 Nov 2026 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564239;
	bh=8wlj5FpDeic+v8yxrZrAtSmK54+mvwJqssNV0e0k5U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBdFyvU3YY6yTy62JaXGJjkBP1bvo44FDRYqHIs3pS4fGDYzqzQ9GpapGCRTXmi9F
	 xIwK1LmfRGY6y7hgGjZDFq281GMgy/Z9+1oNkdfn7jOadRxTFAxHY/UfvED09LBiR/
	 P4dnlXhSyYmsiU5qIUoCMYwDOiJnR9KUQE4YOXQeXFjL3v+RO+EgrZEnygrNPJ06M/
	 BApMSkAD/ygB8gJ5kdFf+vpbuTGanSbMDsnDTUD5on+VZ79pRxz0R3qBSvpCkPoVFF
	 pjbSAwH20P58OgKVBaqSICyJpZfGl3E+roB5x4FbcnVOC75Q5fv7+YQoLnXbbEeEIB
	 QFvwF2hWfMHbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiabin Deng <dengjiabin2023@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported
Date: Tue, 24 Nov 2026 18:50:35 -0500
Message-ID: <20261124235024.3360098-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124235024.3360098-1-sashal@kernel.org>
References: <2026112417-overrule-demeaning-63ab@gregkh>
 <20261124235024.3360098-1-sashal@kernel.org>
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

From: Jiabin Deng <dengjiabin2023@gmail.com>

[ Upstream commit 68c183619f24982a635930697bf8e148f2d78f71 ]

When SHAMPO and relaxed ordering writes are enabled, aligned RQ end
padding can corrupt received TCP data. Due to reordering, alignment
padding written at the end of one packet can overwrite data from the
next packet.

The current RQ end padding selection avoids alignment padding for LRO,
but not for SHAMPO. Extend the condition to SHAMPO to prevent this
corruption.

The issue was observed in a two-host test using a BlueField-3 NIC and
an NVIDIA H20 GPU. In the original test with MTU 1500, 354 of 400
transfers contained corrupted data before the fix. After applying this
change, all 400 transfers across eight message sizes from 32 KiB to
4 MiB, with 50 transfers per size, completed successfully, with no
incorrect bytes or corrupted intervals.

Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
Closes: https://lore.kernel.org/r/CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com
Link: https://lore.kernel.org/r/atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com
Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>
Link: https://patch.msgid.link/20261110035723.26587-1-dengjiabin2023@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 1b109a8499f2d..b8d5dd737920a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -867,10 +867,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
-	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
+	bool no_pad = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO ||
+		      params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO;
 	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
-	return ro && lro_en ?
+	return ro && no_pad ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
 }
 
-- 
2.53.0

