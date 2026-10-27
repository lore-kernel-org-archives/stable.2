Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090289;
	b=FAWZdB+lvbioeqB1uRb/QBuIpCtTDQAJWTohzAY6mq+MRS45MK5Q3cfqFIzQ0ffyYaVs
	 f78MXimIeGtY1UvGdgktMFXC447oXVINQMFCnO1BrRMyonTD+Ss5QaKniyUiBNQY8pr9C
	 E+0wFZtjePP4x7rS/I2qxXnrDIXKVKgnaneYRWKrW6/Fll6Afuzip6WgSr4EbplNqgCA5
	 oq091cQATwX+34FfYG8GFItGxtqU3WydZL4r6Lw1STNXGdZ5NESrnLgolprPWE3n/Ky0/
	 2nqOX0Z3WjmQ+VlYgXoktQ/XkxxHRqUI6Oi1Ix1ehRJpbyYq5Af1bj3MpI5S6pUdN4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090289;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jelzCIJWdhjVx6nrXnvzhRfginKwOd34PJhJ6YdscOM=;
	b=q4+NfGQ9xieMEumUEm1z8bIrWKaXyQjcDgPdd1UsTAwxNE4GVmbDuN8jjc1RCHw4q1Xe
	 cICDnrat2v1xHfAxYyw1aGXu/hh/YYZ3L+k/NYQZ87nVqPjoUF77aHYdTnyueQhrkoabo
	 MMBhWSSdJ7W7LZK15b3h5ndIyrSQZrjOV2V+efmTS3TQgamOKI0qAkX1BtifjeaO6qUcr
	 Shz0ywtwS4ZBXff79/D0m3B66OjhxuHs0LZKErwx/0XkU5pN93VTQEc+otedmpihY6+vv
	 p47hjjIZ0t9gGycyBMZ/Rs6iZwgA6HeTb4f/8ZIcRhvXEjHrDCeQYN7s1SeuizWNXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UHpIFOTI;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126C606A31E;
	Tue, 27 Oct 2026 08:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A126C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UHpIFOTI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793090288; x=1824626288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f+ACxmwWlztbLOqiMhH6E0ePDfrfYELcqnuxvCStSAM=;
  b=UHpIFOTIojAFRt1mrdvupkvpWL7GiJAvKY77JfBqO62rX4FCOkGroz3L
   0feUQOAzCUyA0Xv2KAUPkDTPgTjkSiPX8HtofQxtaQTAGq/xsLLBLyGLT
   r2rlRhZ74PAaK5D4YDgyiB7RPuwcKNQFfDQaeQfRVTW5CY5NJBjQ5f7qh
   JgTr+ReJ5Hj2oDicMBgEVIwtZcn6AXP4AuI8/y/RLrpquaTGOSzNc7sMq
   MTMkC78M8ZnYGIPz+iZuYUmvwoyMK7O/CFg5hlqe0QZJvXzTeofD1WgPY
   JECMiAFKMSSGdn/vX7puyiGRJJ/oZLhaW94/T+pQ/hbjVuONVdWoPQtaq
   A==;
X-CSE-ConnectionGUID: LKDtDJKSSRqJwQeMFM0TCw==
X-CSE-MsgGUID: +t2pnUM7R0K5l0fep0ftVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672388"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:08 -0700
X-CSE-ConnectionGUID: jIIpvgXGRJKX4sU87lfEgw==
X-CSE-MsgGUID: mbFrv7RhS9+EV5UGEql3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4570789"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:06 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
Date: Tue, 27 Oct 2026 10:38:37 +0200
Message-ID: <20261027083840.28813-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
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

Hi,

While looking at the reconfig lockup reported in
https://bugzilla.kernel.org/show_bug.cgi?id=222182
I checked whether the same can be done by unbinding and binding the HDA
codec driver via sysfs:

  echo -n ehdaudio0D0 > /sys/bus/hdaudio/drivers/snd_hda_codec_alc882/unbind
  echo -n ehdaudio0D0 > /sys/bus/hdaudio/drivers/snd_hda_codec_alc882/bind

The unbind works and the SOF card is removed, but the codec cannot be
bound again. This has been broken for a long time with hdac_hda; the
reconfig lockup itself is addressed by a separate patch.

Patch 1 and 2 fix the bind: the codec private data was lost on unbind
and the codec device type was left as HDA_DEV_ASOC, so no HDA codec
driver could match it anymore. Patch 2 depends on patch 1, otherwise
the bind would dereference NULL drvdata instead of failing.

Patch 3 fixes an unbalanced runtime PM disable in the component remove,
which leaves the codec with runtime PM disabled after the card is
re-created. This is also visible with machine driver unbind/bind.

Tested on PTL (ALC888 + iDisp): repeated codec and machine driver
unbind/bind, playback/capture, runtime suspend and module reload.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: hdac_hda: Allocate the private data at codec driver bind
  ASoC: hdac_hda: Restore the codec device type on unbind
  ASoC: hdac_hda: Balance the runtime PM disable in codec remove

 sound/soc/codecs/hdac_hda.c     | 29 ++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda-codec.c | 23 ++++-------------------
 2 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.56.0

