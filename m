Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF147CA61;
	Thu,  8 Oct 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449474; cv=none; b=Hr6enQb6lPJHb7dy5A8IOEY3jl660C4WGTgRGgD/DXpXFVRxtztH+wBPOtRxXoYddx2dDIvKLmniAq4NHp7sfD2XlPLnjEekSeby5YP28NUBqTNuLye+h4adZ833D/Bx3BRAZEQS+1a8WDVF36I1AvEXUhbNiczrxRyYCRO8iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449474; c=relaxed/simple;
	bh=tBjZRLN3JZHuPwoLtXARPt+fhrvp3gen6BH0jgoC810=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1uoy7J/0WDg+/k+IFimx9JVZcoiP4YR56pjEs7EBLkbDybYXtpB8GhpJNPtYbkomS5q9LD3JSEEDH+n/grlFUq2ZnnNfSwoBKa8nMe6lKkiecj97eEVm690jcblacvff2cRBUk8m+1giD37p4obKkLkR0ipZ5PooE9xeAnk5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/Q2C09T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/Q2C09T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791449473; x=1822985473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tBjZRLN3JZHuPwoLtXARPt+fhrvp3gen6BH0jgoC810=;
  b=f/Q2C09TesPBwKYQDoNWc+fzPFtLn5kLARuSyv0mGd82+gJDOcpeeBy3
   rq6ipyq9L8gDbMDFk1sujTcKjDSj+kmT0n2yyXJgELnI1Y0abeoiBbT/z
   VwAdBrJ+D15PBF+cRho8CB47H/IoHgAbO0hOIpzDazR8vJP2xPb6XdSNs
   ZE9WmEsb/grdsaJQhgzImz1YpkW/CbdbYI6H4XlyRB93lQvEJVFjv/NnB
   dQrqvERGpikXBj+jCDrDaJleweXu68/lEPrrbpJ9AI0ugzQhTwgDCWfYK
   0KqfOqZT4Vh5mkmOPxIEtExFFa68xdSJtTQH/O6hkNr7GGSDWmUmd1DV9
   A==;
X-CSE-ConnectionGUID: XIzRs9NiREKi8vU5M2nGdA==
X-CSE-MsgGUID: oucYmOb9Rg2+DpFdwuoxjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="129177"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="129177"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:51:13 -0700
X-CSE-ConnectionGUID: OFyHsjTMTiKil9huWzelRQ==
X-CSE-MsgGUID: L7XvNOEYTUi98P0L3y1BkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1812418"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:51:11 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Thu,  8 Oct 2026 11:51:33 +0300
Message-ID: <20261008085133.9528-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_hdmi_write_eld_info() parses a "sad_count N" line from the
root-writable ELD proc interface and assigns N directly to
e->sad_count with no upper bound, unlike the per-index "sadN_*" lines
a few lines below which are already bounded to ELD_MAX_SAD.

snd_hdmi_eld_update_pcm_info() later iterates
"for (i = 0; i < e->sad_count; i++)" over the fixed
e->sad[ELD_MAX_SAD] array, so an oversized sad_count read from the
proc file causes it to walk past the array.

Reject sad_count values above ELD_MAX_SAD, matching the existing
per-index guard.

Fixes: acb059938810 ("ALSA: hda - ELD proc interface write updates")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/hda/codecs/hdmi/eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/hdmi/eld.c b/sound/hda/codecs/hdmi/eld.c
index 1464fd1c675b..fc6fe1b0873c 100644
--- a/sound/hda/codecs/hdmi/eld.c
+++ b/sound/hda/codecs/hdmi/eld.c
@@ -155,9 +155,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
 			e->aud_synch_delay = val;
 		else if (!strcmp(name, "speakers"))
 			e->spk_alloc = val;
-		else if (!strcmp(name, "sad_count"))
+		else if (!strcmp(name, "sad_count")) {
+			if (val > ELD_MAX_SAD)
+				continue;
 			e->sad_count = val;
-		else if (!strncmp(name, "sad", 3)) {
+		} else if (!strncmp(name, "sad", 3)) {
 			sname = name + 4;
 			n = name[3] - '0';
 			if (name[4] >= '0' && name[4] <= '9') {
-- 
2.56.0

