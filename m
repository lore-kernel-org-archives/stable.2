Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538757;
	b=VoCbMOzjpZIKoMq2bDqlxovoxhNvjTsmATj0+XuePCIgMjed3USMb4BCo/JkmfSiO127
	 JSEt1dAkczeyL5M5SEul8c3MqYf8zx76MB9vPOWp67BKmEpPg5620/TxA4JNt2MUAMdww
	 IxIdwUPgGmoot1UqqfsscduOejl0Aj6Ud4uoSLACbeknG2hoXJkXE13IRVZyUcDgMDzK7
	 nYD8+fTluo2ov+5so1ZDVJRXcTvPBmC+2Y62FNKvuj6WCmWiRkO7J5labfp9ukUmMAvMI
	 Vz9Z5aRivh49A0CbxmF1svTq0autnYCAmSanafqprjeZMvUpGAobjJsVpKgemCG5xGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538757;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lH7DmMO6CmdhGISA9x27XFuIHI2B/YXr7/wtN78ZNko=;
	b=Llf5kGaodRnid2GnvizMMutVMiQWai4C0g6qe3mTVNMdisBI3UROvAKOQjS+xnXDPbQ/
	 THt2To0/maXfMidlQD6kmEdIXZ9J7DyIDFoMWdekYB8/aKfur5/Qp3y5uxLCLrcg3P/Qd
	 twlqdSzpAuiDcqUIEmXHfHKL7MZLaNxSTPWvUBX5JGMEOpv7UeyaIYGja/4mq+uCY/Bja
	 DrTz0HHQBGp9uFccD4DpamMH/GKMRBxMj8R0eeFFVlnaB8XD5nH0K7Ju3A/t9T5R5JZui
	 I2BlsT/mTz9sqJaXSL2cbNXOUBHiFpL5OwH5oH/WHks8Siu+bh6q6My1gXoZzOu9CAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=f3Ua6Ks9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB0606A33B
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=f3Ua6Ks9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE6C1F000ED;
	Tue, 24 Nov 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795538756;
	bh=lH7DmMO6CmdhGISA9x27XFuIHI2B/YXr7/wtN78ZNko=;
	h=Subject:To:Cc:From:Date;
	b=f3Ua6Ks9uZTJcy8h7DtPcLLGEQylqayDue4lVheZZHZbSvLPDTzGfW8RjUHtEGCwz
	 XV2qm7ObHfjNij5pnvpSJvJV1xC96NiW4FGtV5Mbk/6RTbJ4jaMN+IRnTHAMvSwSb0
	 zwR+v8FttkjxNS2Rzwh28nJdsaC/iuI8jNdt4y+w=
Subject: FAILED: patch "[PATCH] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering" failed to apply to 6.1-stable tree
To: dengjiabin2023@gmail.com,dtatulea@nvidia.com,kuba@kernel.org,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:46:17 +0100
Message-ID: <2026112417-overrule-demeaning-63ab@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 68c183619f24982a635930697bf8e148f2d78f71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112417-overrule-demeaning-63ab@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68c183619f24982a635930697bf8e148f2d78f71 Mon Sep 17 00:00:00 2001
From: Jiabin Deng <dengjiabin2023@gmail.com>
Date: Tue, 10 Nov 2026 11:57:23 +0800
Subject: [PATCH] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering
 is supported

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5caf7820a136..159f79302a08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 
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
 

