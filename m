Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622443;
	b=ejZm1Z7v+wPJkvMNXYmuDxla7jbIyeRWZZR6NP3+lYGnEpBZayxNk2QUtUKBuFETDUlM
	 xskZOGjOgghnt8VVNwH3/E0S1SbRZbkwsZ4XrXIRXQDvzw4CI5GR3noix/SehZ7ORKEKi
	 G0dHVSO/5dz3FENQVOBwmcRVWxbsDPG0bkRld1fhbwcdKKdrISGCtc6HkVdujeWYBDgAg
	 LM3GvEuK+9HYdr3GjvrIcq1UN5WZPzY6LXC63zwVVK2yWGdOx5swuJFL8uZMpgzL5qYOw
	 2geaK1zGtVfTAfeD3D5OEJQ9jr1RbtBu5gM1IEC/p34cym7xDa4/Vrj87OMxxVipQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TydKDuDtGKdVdGp3jYNg3T/lR1FW/iYXf4FIDnTGMxY=;
	b=KEjTOG9S2VvAPq7tCADzxguaBnpIDRBGIGhfz/ZI246b6wYp/QDMMiXCXreHlIdDA4OT
	 IUlPlcYH95cE5jYhUpmrs6xdsglazMPKOOZCDfuuhsMr5VBztEe6v7kokqNN55T9xjsH0
	 Vo3jI0dV+mglp8rZypc5W/5bX9y+CjZaY9gm+nLLMumQIuHJpoEkEMAPqyMMVDwxnShP5
	 pDE82xWiG6lHSvFxRx1T39oWduSV3QpNBjWUmfhaa1e8OLlFLoX5k4Svfn4/IqgGjNbod
	 Os8Y3HaN5972WPPUst6Kz3oWxI4dxWeQiD1pk7nLPTHAnVy+xGl5PdDoWa7t0S20OpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOrBJwHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52494606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOrBJwHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0966E1F000CA;
	Wed, 25 Nov 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622442;
	bh=TydKDuDtGKdVdGp3jYNg3T/lR1FW/iYXf4FIDnTGMxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOrBJwHY6ayo7ybmtSRx4E4min1rbGGFMxH2lYtom8YeKdhbVhzNfn/ur9+vmi6/Q
	 LpWUe5ZeAsyv1/80oW5HJxIRrl5Ty1244XT8XBv5RUb//eZddAGqrKDDTTzzeanSTE
	 mb8QjzsDZ0B0MQuFKl+83JBzzwaZ8ajjBmU9AZNrFBCm0A0fYBkX+3B0P1wrUX0QYH
	 EQfIYe79TpgHmLFn7ZrhCK1/Yf+avydcBodXrLYUV5Z7Wf59doRTcKj9mm0eVfh21M
	 wxjdPkpbXI5EN6LyDakuDGH/dvCXm9sDhB7ZkYXnYeW3RiIuLBEQQD8q5q9fjpc15B
	 X5joCkxRrEKDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pin-yen Lin <treapking@google.com>,
	Joshua Washington <joshwash@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gve: Block invalid ring sizes when device options are 0
Date: Wed, 25 Nov 2026 11:00:40 -0500
Message-ID: <20261125160021.616799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-engaging-jailbreak-1e71@gregkh>
References: <2026112543-engaging-jailbreak-1e71@gregkh>
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

From: Pin-yen Lin <treapking@google.com>

[ Upstream commit edc9a730ad3c98662047a76db2d7f26ea4350b2e ]

On older device versions, minimum ring sizes in the device option are
reported as 0. The driver imports these 0 values, allowing userspace
(`ethtool -G`) to request invalidly small ring sizes.

This issue was discovered and actually triggered by the
drivers/net/ring_reconfig.py selftest (ringparam test case). Halving the
ring size down to 1 triggered a kernel NULL pointer dereference in
gve_tx_alloc_rings_dqo():

  BUG: kernel NULL pointer dereference, address: 0000000000000002
  RIP: 0010:gve_tx_alloc_rings_dqo+0x1c4/0x510 [gve]
  Call Trace:
   <TASK>
   gve_queues_mem_alloc+0x29/0xa0 [gve]
   gve_adjust_config+0x1b/0x140 [gve]
   gve_set_ringparam+0x1f4/0x250 [gve]
   ethnl_set_rings+0x260/0x440
   ...

Fix this by falling back to the driver's default minimum ring sizes
(GVE_DEFAULT_MIN_RX_RING_SIZE and GVE_DEFAULT_MIN_TX_RING_SIZE) whenever
the device option reports minimum ring sizes as 0.
The device reports either both minimum ring sizes or neither, so a
single fallback for both is sufficient.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20261109182036.2910559-4-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Backport adapts the field path to the flat priv->default_min_ring_size and uses option_length < sizeof(**dev_op_modify_ring) instead of == 8 to avoid reading truncated option fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 36acbcd8f62a4..579c66aae1c70 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -188,7 +188,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length < sizeof(**dev_op_modify_ring) ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.53.0

