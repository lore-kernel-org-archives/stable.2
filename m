Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC424A0F1B;
	Wed,  7 Oct 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379511; cv=none; b=ksg0SFXSAOwAJAlPrAN7bWRumk+VIQaPmi7IQgKKO/+umNhDeDgGE9wjGqxg9bM5Q1u/AUrOojYkbAozruq9DRHTQhrOCpLOvqTvdFkRjiG/zAmSWonuaJLP+UbhSssYxFURa4/rw6ejcd0Y5Inef+g8EiWOTLZuTkacxCWry90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379511; c=relaxed/simple;
	bh=Ebbi0htb8yIB1ZzQdzmh8eB+vZipNKO7Y+vqzpAuYGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6unqfgObU86r3A1+cI/RpO/+GpccOaAxpvsnAqcglVl4M54pP9cEnQUJa10W9CtiouLabjKQuPYB+Uzpr8Zpm7c7TpSmuCmszTerRFgqdipAV3rBzANXtdXM+zLlPoIsoNz4YsAHj99vtE/ml4nyGnuzwIIuGMhYXafIUp+3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2HeEkSf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2HeEkSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791379495; x=1822915495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ebbi0htb8yIB1ZzQdzmh8eB+vZipNKO7Y+vqzpAuYGw=;
  b=A2HeEkSfNbw+uRfnzAEcY/EMmvrZVC5+5bdmWMppuMmyM3UCS0AdiUvc
   FZh2pvt9tCheeA6bJZb+9/n1kFdooS7Molv3E5WHmRH2xHvhLnXGmovNA
   VnzZtepMQNDbwXhSnpq3XqZ2nuxjIiJU7Nv2xH2sKjdkSbkV3Di0icSBK
   /9e5mR3p+CktdAiaMk6W43nokXD2EqHcc8tzBE7bEPVNuRqkQCAlhvwq4
   h41NZyJDOvoMpdcDfnpocHwI7Yy7FsfBACGHAik8K2jwkDGcbpKrSER0z
   ajonoc4l2l5DRaiVmOyAd1tVCyLTwPt9Fv2RpML0UufAUqabGJ5TtcLvW
   A==;
X-CSE-ConnectionGUID: T895SEjdQMKNJHiYTWhpPg==
X-CSE-MsgGUID: lklnrKf3REK7stpZur281A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39769"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39769"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:54 -0700
X-CSE-ConnectionGUID: AnmYwgGERGKf6Uqh38P61w==
X-CSE-MsgGUID: M0sdPxqPQ368zNgireixVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305434450"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:52 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ALSA: compress: reject buffer geometry change on gapless next_track
Date: Wed,  7 Oct 2026 16:25:07 +0300
Message-ID: <20261007132509.18237-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_compr_set_params() is invoked from the gapless next_track
re-entry path, which calls snd_compr_allocate_buffer() again and lets
buffer_size change while total_bytes_available and
total_bytes_transferred still hold values computed for the previous
buffer. snd_compr_calc_avail() then derives an avail/count value from
those stale counters against the new buffer_size, and
snd_compr_write_data() copy_from_user()s that many bytes into the
new, potentially smaller buffer, overflowing it with user-controlled
length and content.

Reject a next_track SET_PARAMS that changes the buffer geometry
instead of reallocating, since total_bytes_available/transferred are
only valid for the buffer sized during the initial SET_PARAMS.

Fixes: 9727b490e543 ("ALSA: compress: add support for gapless playback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index c0ed76e1c844..e1cc34ba2c2c 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -673,9 +673,20 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			return retval;
 
-		retval = snd_compr_allocate_buffer(stream, params);
-		if (retval)
-			return -ENOMEM;
+		if (stream->next_track) {
+			/*
+			 * total_bytes_available/transferred still refer to the
+			 * buffer allocated for the current track; the geometry
+			 * must not change underneath them.
+			 */
+			if (params->buffer.fragment_size != stream->runtime->fragment_size ||
+			    params->buffer.fragments != stream->runtime->fragments)
+				return -EINVAL;
+		} else {
+			retval = snd_compr_allocate_buffer(stream, params);
+			if (retval)
+				return -ENOMEM;
+		}
 
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
-- 
2.56.0

