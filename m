Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410285;
	b=OaQHDvUOXuF/rbaVG4f6flxY77ha1amDTIzKW5YXWYrppizYARyKIwm4uq8lINvRa3uW
	 fhs0/a3+y/+iY6Zo67MaLtuBzq+HvZet0DmrQviAv3O45me7BxM9rvuG2LCU0e+v9odxS
	 VhHGST0AJrF/zmRUStuzry7hI+sPgY627k/5wtboVmiW88Je8NlIzDMXmw6jJw+LRwrMo
	 Sr75Yrsui/SNTBxLJnyi+oCLTKMkq8DfRlqPx2HqtSdHFqmXs4mDgcFRcGOQzUzOVC4//
	 Qz+chx2bqbDjxynHSLdCIChbG4RnjutVHXs4p8fNsUgCZVhvzLqNxg9u+e6K3QmrgsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410285;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=O/WvR1B87Com9dQTuPn0T9+nOV9gjfSm+t3dBhNg+MM=;
	b=yncWtyXjXZuKKd2N8mhqQHrlHMFelj7BRYfFFy1r6eseSeAm9KCvAYOvaNTQqwA9FXbO
	 IySeIiN4kfLDpTcryNjLxGikWIBBYm3m9NG2lcudgCL+++ulfgAb9OqEHxXw7PWKcnjmA
	 UhxRvAGjh8CFcxADqGM2w/5mKlM5eXyWaqxsxsZObgmWi86WSWij4A9M1lsZ8JkEUx4Wi
	 r/x7yc4327M6zL4zryHAPJ0A/hGbN3ZlwJTqPOsIbr/4Re0y1S0IC7h4Us09efTB4GSlJ
	 2vSwNN6cONqr8r8q2OJq8un7k6aY3yZpysDJ+8xUSpPNubSfWrIlipfTXsVYbn5EonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3H9ZU3H;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D09606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D09606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3H9ZU3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795410284; x=1826946284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tcrMtoWPqRZ3VwHw5W4Cyd40df7ekHLTZcJ3oc8DTaA=;
  b=W3H9ZU3HlxJ4exQ62Xa7AVetpBAR5FT/06M0Rs/5Fde5nxMn+tuI5OYK
   f0LHcLhRIeOvlpug+hwKeGL6ggcA1Y5SCsWtSISaOmGC535I/MUnz9fx2
   aJWag8WJ/4poXdurBJOFAFU+ws2eixtNgi+QCZILRStKor5Mpcpzw7ZAa
   +64ktpXOGPn1s7jwroIh4Gs8WGpvCAbQ0UcsEYyusBrhZ2OY7yRw9VbJW
   OlKQ93yTO7WyOeJLCBv6zh60xvHAfyfhJFz3UZNDsWdw0EGPOL18QYsnW
   6+5s3MxtHK7kedROSUPDnvTN/P4ZooxBi+szroPzQLnp+sPU2KoXCPi/q
   Q==;
X-CSE-ConnectionGUID: Y1HTqXF4REyhW5qY7U9S3A==
X-CSE-MsgGUID: 5cDEuqb9ST+TzvrgroB0Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4198061"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4198061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 21:04:43 -0800
X-CSE-ConnectionGUID: W6XyZj+OTc2/U95XXbPVaA==
X-CSE-MsgGUID: 4+bWwf2aQs2yAl80o9Qd9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11409762"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2026 21:04:41 -0800
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: imre.deak@intel.com,
	mika.kahola@intel.com,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port sharing the PPS
Date: Mon, 23 Nov 2026 10:34:23 +0530
Message-Id: <20261123050422.3130438-1-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Some VBTs declare an unpopulated eDP port next to the real panel and
assign both the same PPS. The ghost port adopts the VDD bit the real
port turned on, and when its DPCD read fails it clears EDP_FORCE_VDD
underneath the real port. The real port's VDD reference is then never
released, leaking an AUX power domain reference and a runtime PM
wakelock:

  drm_WARN_ON(intel_dp->pps.vdd_wakeref)
  i915 raw-wakerefs=1 wakelocks=1 on cleanup

Don't adopt or turn off VDD owned by another eDP port on the same PPS.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17232
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_pps.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index 442b00491a88..653b8bf7ec6d 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -570,6 +570,30 @@ static bool edp_have_panel_vdd(struct intel_dp *intel_dp)
 	return intel_de_read(display, _pp_ctrl_reg(intel_dp)) & EDP_FORCE_VDD;
 }
 
+static bool pps_vdd_owned_by_other_port(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_encoder *encoder;
+
+	lockdep_assert_held(&display->pps.mutex);
+
+	if (display->platform.valleyview || display->platform.cherryview)
+		return false;
+
+	for_each_intel_dp(display->drm, encoder) {
+		struct intel_dp *dp = enc_to_intel_dp(encoder);
+
+		if (dp == intel_dp || encoder->type != INTEL_OUTPUT_EDP)
+			continue;
+
+		if (dp->pps.pps_idx == intel_dp->pps.pps_idx &&
+		    dp->pps.vdd_wakeref)
+			return true;
+	}
+
+	return false;
+}
+
 void intel_pps_check_power_unlocked(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
@@ -839,6 +863,9 @@ static void intel_pps_vdd_off_sync_unlocked(struct intel_dp *intel_dp)
 	if (!edp_have_panel_vdd(intel_dp))
 		return;
 
+	if (!intel_dp->pps.vdd_wakeref && pps_vdd_owned_by_other_port(intel_dp))
+		return;
+
 	drm_dbg_kms(display->drm, "[ENCODER:%d:%s] %s turning VDD off\n",
 		    dig_port->base.base.base.id, dig_port->base.base.name,
 		    pps_name(intel_dp));
@@ -1334,6 +1361,14 @@ static void pps_vdd_init(struct intel_dp *intel_dp)
 	if (!edp_have_panel_vdd(intel_dp))
 		return;
 
+	if (pps_vdd_owned_by_other_port(intel_dp)) {
+		drm_dbg_kms(display->drm,
+			    "[ENCODER:%d:%s] %s VDD owned by another eDP port, not adopting it\n",
+			    dig_port->base.base.base.id, dig_port->base.base.name,
+			    pps_name(intel_dp));
+		return;
+	}
+
 	/*
 	 * The VDD bit needs a power domain reference, so if the bit is
 	 * already enabled when we boot or resume, grab this reference and
-- 
2.34.1

