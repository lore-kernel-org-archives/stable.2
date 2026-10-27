Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105658;
	b=Bt2pARfMfm8kr6gm9HoVSqE3OZb2mZXKPid0RCr+/a6nLWf3RAVlMzRTp/qfJffyt61Y
	 CxlUx3zgwyM70p9Zfw6sk2ku4zRM7j1bQr5Hh6nE0hwJct0SzO96LzMmCVFKlEZIMO37l
	 4PaqQ55WBOMzqOWIzPQ4Ljz0Dqm1WT4Y8PhwY+1ehHA/1zUFOAl2Chj9lnyooNCfHGQrH
	 hEykhGQnZDhv4Aj0n6jn7DQujHfeXf6/WOhVCJEknxrofg1gR2FpAZIxAbMIqlU8ex6MX
	 punreOYXXM+bSMf7ANFUz4xFGUfHkfVmeq1Boyc27IiACpmnm7IhZYTV5bnHxFNPFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105658;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ajhi3IASz6j1nsG+aKk5gHIR6odA67bemeXJatpjIoM=;
	b=tezNs7GHzVlzvVcNOeMPH7v1zss8CluRnHTCvwN1QAcnuxxhB7VpTTKhWndu59ltgyfg
	 Rsf7p3+a/Y+Fi6zLQbHOdjqHK75AhS673bKo1v6V2IgK9u7p7vq7QOuKwTg1cJrH71aWA
	 cInsZSK++gAY8+Fp3UCcws/P284Rk0y6uaU1jiRaCOnQhLg8ZN4F+el7mK23b2rP9pm98
	 4PxTLKkw1gtr5hL/luyyHeQ6REn7OCHu4ACus19ECteE6IxoWelX5FZQ/5d6cUEOnhX0V
	 2ooYqPb2/fcy6bdDY4VuQzYG0ZmgJdoznOSFtgIfkFBZN+HX5jHLUMiCmJgl/8fBdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=it6BDLel;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C1606A31F;
	Tue, 27 Oct 2026 12:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B7C1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=it6BDLel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793105657; x=1824641657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sBltcqNZmwTxjonR9sdBB+Igk0tLqgp0m8kQbwTLzAY=;
  b=it6BDLelAnaA0NLb9h6JHQ/ZhoOmRTyaGBBKfpMtKJCmX8aGpZWKnjnC
   uzm2mdvMS7k3KWu5oI0B6woorSq/oPHX2W8JfBysiCoXgvOEDHli0sYaq
   P1BKjmQMvekN5TUJ1ye+ONzhU1klXbVU1vrkIxNjdHJK16uahDzqCjG8q
   QKxNW26f3BPsTFothor9dqDxLThUlMEYYFbwllkJW3xIHYBMoFMYLxvXQ
   J1SOQHszGPyzjvA2mt4DKvOXb6m3DaiclFJ0JM+wjn6gOLN79C3VCSNg2
   LOSb8o009g6+JfgI3c2Bno3my7a8XN+GKfVIb2V10JtYdBvs/QSAkiM47
   g==;
X-CSE-ConnectionGUID: Ib71TJPpRPm8qXjGuMuUlA==
X-CSE-MsgGUID: JvGkUJJqSNCsw2rZAxflqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1684658"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1684658"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:16 -0700
X-CSE-ConnectionGUID: pMG6J01BQtC0kiIpUxeLUg==
X-CSE-MsgGUID: sjbQ3zMBRpmgdGpa41Pk/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6294843"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:15 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH v2 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
Date: Tue, 27 Oct 2026 14:54:45 +0200
Message-ID: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
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

Changes since v1:
- Add pm_runtime_set_active() after snd_hda_codec_device_new() in
  hdac_hda_codec_probe() function as reported and suggested by
  Sashiko Bot.

Expanded test plan run on the device to cover the previously missed
scenario.

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
  ASoC: hdac_hda: Fix codec runtime PM across remove and probe

 sound/soc/codecs/hdac_hda.c     | 36 ++++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda-codec.c | 23 ++++-----------------
 2 files changed, 39 insertions(+), 20 deletions(-)

-- 
2.56.0

