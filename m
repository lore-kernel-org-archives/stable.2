Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FE38DC65;
	Sat, 29 Aug 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787990931; cv=none; b=rtHvdBc24ZkIFsXfgZbg5EaBbUWyU0swXRdvalx5854QLeef/tcpqLO/Q9LmwRTebcHvbNldcOnG1gLCyWamBfeXJFt61FLcgONiC7Div3ghvBNPeoAVE7vJ0ioxcPvKgzXNrItoEapIe+brb4MxfMfA8KB3+PfmDyJvvoyRm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787990931; c=relaxed/simple;
	bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNqk4nMECVbCvBwFMXHjD4s+CiffKrCOEHrcjBDFLPDvLbVAFwFdplTL6dVzmY8Axa4Ws2RfbBDbdRPPT7Lx7grNvPGhvKMumKnlA03LbApnHfbUn4ft7p/W1kwWPp1w/gwCfxbsduPxvqFAz6pcjNXV+xvfQee9+M7w8Viyv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZPWzYiS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZPWzYiS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99786C2BD05;
	Sat, 29 Aug 2026 08:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787990930;
	bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZPWzYiS4u8sGNqQNT/Sl3/DEpq+Zq21qrhp/D5HwecLaMHfCE891mGIEP/finNkQ
	 y6ac8dA06WSzjDutIJOMZafVUg74u/bQ50/9TbEaOxUF/fGG3zueNpAGyua3/H5Czo
	 kx/pac0J3A4VTuU9FAh7+7XnMSV5waXrjTU/hhnPFM2dSqOiSDoJassHPIEvYSXb+W
	 iQzPNosHpCsgDF9TpzwX6k8ZVEcjaIW8SEFzIi8t106QSBIQQdEFHZbRrSZF2egL1V
	 kXvfbhEcPJwLpibj3cUMZZxWp4oBfSVYOqjQio7RI37cS/iYO6SELyDxwKrCe5u5M4
	 tAR7y+p6GAMsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364EC61DDD;
	Sat, 29 Aug 2026 08:08:50 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 29 Aug 2026 10:08:37 +0200
Subject: [PATCH v3 5/7] thunderbolt: Mark discovered tunnels as active
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-b4-tbt-fixes-v3-5-e1fab6ac54fe@kernel.org>
References: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>
In-Reply-To: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ9akyX0SGz9emhE/54XywU+PLC45Pp8cei7vwrZTqacfT
 vxzsv+ZV0cpC4MYF4OsmCLL9v32pk8evhFcuunSe5g5rEwgQxi4OAVgIs+5Gf7ZZao8ShY5GXjV
 UnDv0xMOEfFi177r+lY4MHyd5nXtnfsHhn9mc3OWS2QUuS5ap98q9eXwTc8WkeOZ/s/nztwouWt
 BXicLAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Discovered tunnels that have been activated by whatever was running
before us stay in TB_TUNNEL_INACTIVE until hibernation restore such that
anything depending on tb_tunnel_is_active() skips them. Mark them active
during discovery instead. These now also emit TUNNEL_EVENT=activated
uevents during discovery.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/thunderbolt/tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 5f536635908f..3785e29cf92b 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -507,6 +507,7 @@ struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down,
 		goto err_deactivate;
 	}
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 
@@ -1671,6 +1672,7 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 
 	tb_dp_dump(tunnel);
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 
@@ -2299,6 +2301,7 @@ struct tb_tunnel *tb_tunnel_discover_usb3(struct tb *tb, struct tb_port *down,
 			tb_usb3_reclaim_available_bandwidth;
 	}
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 

-- 
2.55.0


