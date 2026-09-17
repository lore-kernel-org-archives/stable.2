Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4094ABBB0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671798; cv=none; b=NI70zu7HtOiBV05Vu/omhjEyRguwmW5hW0j531T7MtUk455UAdPBhwWyqfDb/H+ZW4QyxZZbSIG+sQDEPXPvgFfnKnuZblCBE7tlWRHgKPOVbfCJWbKwzcilKps99VaAi9h8+oarQwWmOHgs3vuiKGlp8ui7Ol1JG0ZvL/0NbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671798; c=relaxed/simple;
	bh=YuTxLUECdgv8wQnjykfLiiSbljluWKlJs1FuE2fg9ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P01KRYDA98KA8+jXwGsGrlZ0ZEBwcSM9iqca+YRyEtlDpzJo46pEpk0HCAyyqW1x0LmorlGuF4a49abTGV2lPxUxitHPF3vk0pVlr8XFvBBlJwPPa8qejNKx+vqsEB6RE/Pu/jBIxCUqwPDfuaEf6y4Xd3BRHYMsVpVtvRaSVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVf7P2gP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVf7P2gP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789671795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUesHNqg+ZVQdyp3TqOiMgGR4RIEF42DCBqJOEUMffo=;
	b=CVf7P2gPOAVgdP+dUxlJ9Xa2iF21ArdSmAQHZ8Nm0z0teqQyCwk9mz2VjejwPs8mWoxN0n
	mYO7L1f/ZXdhwfFsyIP3MUs2QVdTWerOFaLnrbmEYTd1Km6VG8z6mTkuDEvg5PmCxP1haE
	ITF6ZB4BDxpSJZDE303Z/7v5v4/Vens=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-iDK-JP4kO3WRna3BMUBTAQ-1; Thu,
 17 Sep 2026 15:03:11 -0400
X-MC-Unique: iDK-JP4kO3WRna3BMUBTAQ-1
X-Mimecast-MFC-AGG-ID: iDK-JP4kO3WRna3BMUBTAQ_1789671789
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F4A4195C26B;
	Thu, 17 Sep 2026 19:03:08 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF81819AC047;
	Thu, 17 Sep 2026 19:03:04 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	stable@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without the SMA clock mux
Date: Thu, 17 Sep 2026 21:02:57 +0200
Message-ID: <20260917190258.3239282-2-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-1-poros@redhat.com>
References: <20260917190258.3239282-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The SMA and U.FL connectors of an E810-C timing board are routed by a
PCA9575 GPIO expander, and ice_dpll_init_info_sw_pins() reaches it
through ice_read_sma_ctrl(). On a board that carries a CGU but no such
expander the netlist lookup fails with -ENXIO, which aborts
ice_dpll_init_info() and with it the whole DPLL registration:

  ice 0000:cc:00.0: ice_dpll_init_info - fail: d->inputs:...
  ice 0000:cc:00.0: DPLLs init failure err:-6

Userspace loses the EEC and PPS devices, every CGU pin and the recovered
clock pin.

The netlist describes the mux with a clock mux node, which
ice_init_feature_support() already turns into ICE_F_SMA_CTRL. Key the
software controlled pins on that flag. Without the mux the SMA wrappers
stay inputs, the state the mux path programs at init anyway, and do not
advertise DIRECTION_CAN_CHANGE. The U.FL pins are the other leg of the
mux, so they are hidden, and the outgoing CGU pins stay visible as
REF-SMA1 and REF-SMA2/U.FL2.

The layout is not exotic, the E810_C827_SyncE_SFP_SEC configuration in
Intel's 4.80 NVM package has no clock mux node either. Such boards
worked until the SMA and U.FL redesign moved the expander access into
the DPLL init path.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 85a74cd6ea1f3e..e0362b6bf332e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -107,6 +107,9 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
  */
 static bool ice_dpll_is_sw_pin(struct ice_pf *pf, u8 index, bool input)
 {
+	if (!input && !ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
+		return false;
+
 	if (input && pf->hw.device_id == ICE_DEV_ID_E810C_QSFP)
 		index -= ICE_DPLL_SW_PIN_INPUT_BASE_QSFP -
 			 ICE_DPLL_SW_PIN_INPUT_BASE_SFP;
@@ -1213,6 +1216,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 
 	if (p->direction == direction && p->active)
 		return 0;
+	if (!ice_is_feature_supported(p->pf, ICE_F_SMA_CTRL))
+		return -EOPNOTSUPP;
 	ret = ice_read_sma_ctrl(&p->pf->hw, &data);
 	if (ret)
 		return ret;
@@ -4510,9 +4515,14 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 						  true, &freq_supp_num);
 		pin->prop.freq_supported_num = freq_supp_num;
 		pin->prop.capabilities =
-			(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE |
-			 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
-			 caps);
+			(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | caps);
+		if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
+			pin->prop.capabilities |=
+				DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
+		} else {
+			pin->active = true;
+			pin->direction = DPLL_PIN_DIRECTION_INPUT;
+		}
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_sma[i];
 		pin->input = &d->inputs[pin_abs_idx];
@@ -4526,6 +4536,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->idx = i;
 		pin->prop.type = DPLL_PIN_TYPE_EXT;
 		pin->prop.capabilities = caps;
+		pin->hidden = !ice_is_feature_supported(pf, ICE_F_SMA_CTRL);
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
 		if (i == ICE_DPLL_PIN_SW_1_IDX) {
@@ -4555,6 +4566,9 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
+	if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
+		return 0;
+
 	/* Initialize the SMA control register to a known-good default state.
 	 * Without this write the PCA9575 GPIO expander retains its power-on
 	 * default (all outputs high) which makes all SW pins appear inactive.
-- 
2.55.0

