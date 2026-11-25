Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621680;
	b=lnevj0BJAq12CHrUIfO9qTm/NcEInjH0fWiiQDrLxNVDss8TxLShDlK1gwYj/3p5slW9
	 hZ+Kmfu4/pJxk9j8DHJt/+GPORvA6lQ/xRn/ye2ayCq3hdvL7NhjCdafan8eN/g0A47fk
	 luz9kDfE9oIgC+s1SC4RIODYc5Dmi+WbZvfcDVF1d9/4idGbhFt0UE4PcIi7CjIn+/v3G
	 UODNpGSlE0WhsTg1dEOnCNDcDz1NJXn1nhsbHdgekQ7ZEFxMqDdIWIuYfN8/1iMyryboC
	 2H/o7bYCSwbSahJgkZJpxng7ZrMXq7QM2PIyNeowjBA/IgmMLrrXZ/pQ7dGRUQJhoMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621680;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AmrXcOtQTZ3dJ8hbccwBiwEUXvN2h4Y9W76fA+R80B8=;
	b=OZ/gcSSgixnRN3kI+9GWAbeh8HcRJIM1JpJJZqcoqmVii1c/U+nlcTOD1EWV9Gs/S4Is
	 /GCPp7K90PJkjAkIMVvcLF5ffD/k5bGX1rCBgQlbDNE/geMXeoYtZwdwZB38b7WZUNRB+
	 e6yVJ26dHCxHaWu+nI7gkJQ+bxH+wqyy9oEOZVCOUmh88dMas+Z5ybIOnm0cm/ICEdX6P
	 lc/8VWRMaag7OfyDh4YzAPVsnX+02kIzeS6AcRGSAFypmls7GbfdRFhwGmlBpXyQNqRjY
	 ccaxzRxY3+giGPKtHJePHWnfkiMoz3bDGmaDni3+F9+KSAOr9p0YJodUxdLhuzN8QtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhlRYzsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1F606A33E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhlRYzsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF9E1F000C6;
	Wed, 25 Nov 2026 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621680;
	bh=AmrXcOtQTZ3dJ8hbccwBiwEUXvN2h4Y9W76fA+R80B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhlRYzsyJuf5HDmgC9qreULEB8rn596KtdS734QUs0tDgvA2DdMMaI6dYKEYd1nTH
	 SH017DhxbgjfHrpyAg7hZZ9FbvQawNygZOu13d8oVw67iBobZqQzcodH0KthNsygMg
	 ZwFJ/TWCcrV/NB7ws33iapn+IMIjT2yON8W8kxU3EGIUaNIzCKH8/x7pkf0QTo+9sX
	 YmjKVqSuxbyO69nqNYkrvxV1bngEh091s7kauD9hS1Xt6GB/NGF8lnrPFWDHVO0vfD
	 +RQnvINPIS3DWhhRSwYSnBmP9fHqeUNtRFULdV0XwTO5zBLT2laTmJm5stSV+P3Y6g
	 DN3cO7pChwQfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pin-yen Lin <treapking@google.com>,
	Joshua Washington <joshwash@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] gve: Block invalid ring sizes when device options are 0
Date: Wed, 25 Nov 2026 10:47:50 -0500
Message-ID: <20261125154711.373322-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125154711.373322-1-sashal@kernel.org>
References: <2026112542-scrunch-president-9d95@gregkh>
 <20261125154711.373322-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 863e67e2fa437..e23b9f8325d5d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->device_info.default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.53.0

