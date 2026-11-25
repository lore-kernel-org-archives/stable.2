Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620401;
	b=BtPcvtC/mEXW0mSVvXkZV9R9cmEB+qNwuX+vDugT/ZtnLRP9QOFWAyoWdujwQBOl1aFW
	 5b0jBjStJ8NqyARcaT9o0Y/1HVRlBBKwOWafdRxcGwCSC2OrKG2D0ypMPV4JiR4KbOvtr
	 ngf/Bn03Vl8kxTTSGhlwvLQrKAvFTA/cGVQyO84UH7COj13qV6xRe4GbumrWEEkJkQuNK
	 CiLrkZ3TNKhHc7EkpXG6Zwj0ZavUOzJzd7bacyhbirWVHfagiLmE4Ywtx2+Q9yhG8XiGK
	 VqUxpa29SEj/CR1i2eHE39b12zRyXPa2yyja98glaajryYOy0FkO5nlRGs/+AVh6mTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BsCMgQGhs0/Dhh1RaH2Nu1Tb+PmBiyBpcRJ7csQ/LjQ=;
	b=RtExfgx5E+ixdZGvH91IZhhBPGTKfk4WIplawP8cqGtXHQyD03zKhhbB9QP2d8egNvsm
	 FgV9DzCEaH/R8h1SzmD/oM0LReirLJsOUjjhGptoxLHtJ3TVmi+XEmpu5nsF/tiSGlzX1
	 N5LoctPSWg8XawqabG3mlRNIJYXhn6Vez5f8Vg6wozDm0PjP6O2BHnJYcCs/+LPba/TvP
	 tJ4v8pxCW0xT2sfeFXa3myXdbnl0YN8kOw4RXsPGR88i6Kdbsi9r6YEc9SisLkUkeoHia
	 yT+7NZvcOivRXwSz4eFnwLO1eoCSR3lSCGvSvxhroNmW1lU+OKilXJYWA/utSCOpCKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MgbOqB/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE11606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgbOqB/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C41F000C0;
	Wed, 25 Nov 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620400;
	bh=BsCMgQGhs0/Dhh1RaH2Nu1Tb+PmBiyBpcRJ7csQ/LjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgbOqB/YWwgRInOsnFTvfvPGn3EDC854B0R6PXkituYfAc/BdDVjfnOZnK8pEbP1/
	 f0QyYZcWFmX3ipsukRNEqlsliY2sxzoD7wYOu14paf0bv2yrwHw1adgPCblNewhGeb
	 le+yQ4VeZmGWEgQZVAcbqlIufX1/kLntaVR2HS7XGZtZSpzWG4xwni8vXACvTEj0yW
	 KZKekjDo8chg+8wSbYGYrb5buTI58KYpnBYV4Fme10MUvX38ghx7twY345iag2sVO/
	 REdlSzUaFTwNInI2eMdiPeYOrS6l/GFkftGhBObPq5HDwksRoxpM59u1tfq6+FpxGm
	 7A8zby8VEVX2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pin-yen Lin <treapking@google.com>,
	Joshua Washington <joshwash@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] gve: Block invalid ring sizes when device options are 0
Date: Wed, 25 Nov 2026 10:26:37 -0500
Message-ID: <20261125151435.4180011-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151435.4180011-1-sashal@kernel.org>
References: <2026112542-ethanol-oasis-b0ce@gregkh>
 <20261125151435.4180011-1-sashal@kernel.org>
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
index 512349c5517f4..2ff652cae0ef1 100644
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

