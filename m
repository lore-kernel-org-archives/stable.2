Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B712EEE97;
	Fri,  3 Jul 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.14.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783121419; cv=none; b=Yja5dryXgRKJuMNX+1cXWw99e8HDinqIhSdCB20NkopsL7QsFjAmq+J8oA79S6yv/kRuv+88gJQ+ao9v8nFl5X306dHwyGVGhYJeYFrEOVVQBcxRe84OdVvvesGSIokF6/soUcyYi2L6W+MnShiJDFH0kmZPJLwDDSCzdrhdsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783121419; c=relaxed/simple;
	bh=SzB9tZyiwbNsckTsGonX6QEORzbCNDmomg4Mtmkw7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9eAhYXNby1Dq43ofBW9gBkIhr2ldrO0oinLf5hqS9rsfONXcW0R5CqBvXRAYPiIH1iXD62ipCUhM5YRH0w6bG4lzdeFRWsh8gQ7AS8i3O+yyN010/E/YcvVWNllNIMYtoOgrd7wiPavSG815H5/yeJI+RfAan5GBWQQVZerKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=KMS73Smv; arc=none smtp.client-ip=178.63.14.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="KMS73Smv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1783121094;
	bh=SzB9tZyiwbNsckTsGonX6QEORzbCNDmomg4Mtmkw7Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMS73SmvuZ8fc/oEl+SSPz44MR4d/gM0pOSe3hvQ9X//VbMDgNZSc0x0+Ce2RKVpo
	 IL2jtZCetHc0D2QlJ25TikwgQ4vysW3ZYeFv8URUc/GKfURldhWTKwv1Lc8YZkXCpv
	 1UkXhacLC2BxusvWfdU7sP4nn2yx++cEj4hH+Ubc6KeYGk9OnbRuFcu5fNigGQjkxD
	 CfqRp0ZA3M1HWgs2orJ7TYTS/DS9bi1jVvbc5AUynufZ9Ou/jx2TEh62Ckj0PyQ1J4
	 OSuRoaeTk5wJ4MtZx5Jwtiy+4MgEmsn99nvckV5vVKyrQvSZO3EzT/d9BrnGqsKSwj
	 3T1LZv8ld38HQ==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id 437EF18787;
	Sat,  4 Jul 2026 01:24:54 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Sat, 4 Jul 2026 01:24:52 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	stable@vger.kernel.org,
	Uma Shankar <uma.shankar@intel.com>,
	alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
Date: Sat,  4 Jul 2026 01:24:51 +0200
Message-ID: <20260703232451.4315-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
References: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 01/07/2026 01:45, Kai Vehmanen wrote:
> some progress with this. I attached a work-in-progress patch that fixes
> the issue with at least one setup using Club3D CAC-2505 DP-alt HDMI
> converter to the bug at:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412#note_3543741
>
> Needs more work still, but if this approach works, I'll send a proper
> patch later to the list.

Hi Kai,

sorry for the late reply, a busy stretch at work kept me away from
this.

I tested the second, more generic patch from the work item (disable
keep-alive before audio format change) on the Panther Lake NUC.
Base was 7.1.2 with my KAE disable patch removed, so the KAE path is
active again (PTL on MODEL_ADLP), and your patch on top.

Results with two Synaptics VMM7100 based converters:

- Club3D CAC-2505 (SYNAq 7.1 firmware)
- Cable Matters USB-C to HDMI (7.02.123 firmware)

Test sequence on each, from a fresh boot:

- 2ch baseline, 6ch speaker-test, back to 2ch
- 5 rapid 6ch/2ch cycles
- PipeWire card profile switching between stereo, 5.1 and 7.1

Audio stayed audible through every step on both converters.
The register fingerprint I used during the original debugging
(AUD_DP_2DOT0_CTRL low bits sticking at 0x4a1 after the first
multichannel stream) now stays at the healthy 0x482 value
throughout.

So the reordering fixes the issue on my setups as well, and with that
my KAE disable patch can be dropped in favor of your fix.
Feel free to add, once you post the proper patch:

Tested-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>

One note, unrelated to your patch: the roughly 200 ms display
blanking on an audio channel count down transition (6ch to 2ch) is
still there.
That one sits downstream of the host (converter firmware or TV
resync) and behaves the same before and after the patch.

Thanks,
Alex

