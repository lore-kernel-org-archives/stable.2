Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840C4746C6;
	Thu,  8 Oct 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449468; cv=none; b=fmxxfA42T55qYi1tzzIN1Am/hABiY0Q1OF13+xBWFVN1bmcdIuGN9G1OwuzEeDgFNDoHJWLRtms2iMJSsmZNyzp8DTyRKPXgr3OJwFqWWlmQgpa5tdme9fMlRbQ4GByBrvRjvguwx7d3D1eahW/p3v/kpUdl3QUZC3kvrxjdTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449468; c=relaxed/simple;
	bh=KfmAPk4DfpBYk17Ub1fvKdfBvamkfS9XYREF+HPFWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVUCQ9mLsM3cXVyD3WirfAAlf1eSAuSAKpgI+8UYZYhGmm47wWpKLZuCuQ9EOlrGLXFWheJbkjwCwuy/uwBNnUtrqpJm2u9Y74B4ky4j3hGt4wwBraM11BOSmkRep2bZcO8N4X+F7FyE+UgmYCpBqS4SMgsEfGA+aYlcr59D0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEKZMfoT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEKZMfoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791449463; x=1822985463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KfmAPk4DfpBYk17Ub1fvKdfBvamkfS9XYREF+HPFWj4=;
  b=nEKZMfoTL7EJGGt3BaQsUrE7OR+zzXJ7lGclSAwqjX8pyw2nbNiSMyPQ
   heStXA6JPxbEUEmyJGo99VHfzwnLO8dZT0+6a70HLxKCHYoxxvQ4+o+cU
   75mhZfMqa9xuoVquVcb1ztNEkhqApVa7D94JFohd8ae4/Xsc37Mz6uj20
   k/yf9esCyfl3ADG9r3O04rmMM/VPx3moGKla7dItO0EBTfxsUEfWTRQwO
   KzcLxurzn2v5y20q07ErQ1wmG/8XVZzugHknYFz/gVemP7BsMgDwAWDQn
   vp/gVLqqsgEFRQkMbSrwqGm71L1YyhuuWM/mwFz/sFXax4VFXUVXgPMEt
   Q==;
X-CSE-ConnectionGUID: o87djxTqS9STIaPUH6rZZw==
X-CSE-MsgGUID: XACXdg6FSe+TU50b6r/w0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="129160"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="129160"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:51:02 -0700
X-CSE-ConnectionGUID: VW0s5IHuS6+bGUZZEkzNWw==
X-CSE-MsgGUID: uoGb48TxQIKneRd676kcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1812345"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:51:00 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Thu,  8 Oct 2026 11:51:22 +0300
Message-ID: <20261008085122.9442-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hdmi_add_cvt() stores each converter's NID into the fixed-size
spec->cvt_nids[] array (used only by the Intel Haswell pin-connection
fixup), but only when spec->num_cvts is still within
ARRAY_SIZE(cvt_nids); the num_cvts counter itself is incremented
unconditionally regardless of whether the store happened. A codec
that reports more converters than cvt_nids[] can hold therefore ends
up with num_cvts > ARRAY_SIZE(cvt_nids).

hdmi_read_pin_conn(), on the intel_hsw_fixup path, copies num_cvts
elements from cvt_nids[] with memcpy(), so once num_cvts exceeds the
array size this reads past cvt_nids[] and writes the resulting
garbage NIDs into per_pin->mux_nids[].

Clamp the copy length to the actual size of cvt_nids[] instead of
trusting num_cvts, which is also used unbounded as the size of the
separate, dynamically-sized spec->cvts array and must not be
truncated at the source.

Fixes: bce0d2a80e42 ("ALSA: hda - Allow unlimited pins and converters in patch_hdmi.c")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/hda/codecs/hdmi/hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index a8aac0b36c73..355fd3e73183 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -983,7 +983,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	snd_hda_set_dev_select(codec, pin_nid, dev_id);
 
 	if (spec->intel_hsw_fixup) {
-		conns = spec->num_cvts;
+		/* spec->cvt_nids[] only has ARRAY_SIZE(spec->cvt_nids) slots */
+		conns = min_t(int, spec->num_cvts, ARRAY_SIZE(spec->cvt_nids));
 		memcpy(per_pin->mux_nids, spec->cvt_nids,
 		       sizeof(hda_nid_t) * conns);
 	} else {
-- 
2.56.0

