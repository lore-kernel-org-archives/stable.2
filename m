Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A1175A80;
	Sat, 20 Jun 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.14.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968109; cv=none; b=Xx4cJ5SEasBU/0ORbJ1gsKJB41d7pnrwUkWO87i0HtNCL2VvQyaE8gINFjpqfm5CTBtetnsrlXqJNrty5iyAQu/eOR/A3Kp9TrwlnZ3kNbTdXE3BV+g0fBxFTNxxdLdYDpqYcjYMAp3OcDyYU4xNM5rrB4FFW7P99WVTm5X4PRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968109; c=relaxed/simple;
	bh=zI13xUnlPnpM851u8Q8Bu9sOy0qWjbzApzWw+QaAZhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=hqoma56eH7ckmqmFUHO7ttsffDK9PNELtv38ZrpXn5kFBF+HOOgBS1MC1ualg8LgzqrG1M9MUUIduap6s/4STjuR6Du8rehYEM+4ryzb3Gd4EoPRbyTLv5YdqIWqk1NLJAWDyIVTbKw1Oto4mrBnxlmDxAg5ofCx8LbZsXe8gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=Furb76f+; arc=none smtp.client-ip=178.63.14.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="Furb76f+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1781967654;
	bh=U+rwt1T045xVY5C0HHurrVZiSxSN5tJa6Ef1GWN+HxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Furb76f+DQsUWUrGUW14tqHBn7oTUjMgP/cGBQKuVZgVwXeKQxSBIKfnInsEyRE5b
	 UbWAk+aE1tI4+1s9Vo8+a5ns8t+jtQzUuk/MLzAK8GUCfW1tqRoWhPWdKEdsrqKZae
	 hrqnoCTjvpzVlVNrLy+F34Ak+gOwgKRO/GjJKk9i30uWNfIwWe0JQeu8SmNcixwJa9
	 ExBVutcgF4dIMpwunTvbSHwYavl3wXnEiiloeZoVVrHWiBvMocGphEujfaqG8cYhg0
	 9wYHVgeElwxYmDqMHYI0Lzabvnhc567rVP9uDTumgpoI9JoL18hiyVVuQLLOD/I4i5
	 C8KvYA+dBikJg==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id D458CD02A;
	Sat, 20 Jun 2026 17:00:53 +0200 (CEST)
Received: from [127.0.1.1] ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Sat, 20 Jun 2026 17:00:52 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: =?utf-8?q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@intel.com>,
 =?utf-8?q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, stable@vger.kernel.org,
 Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
In-Reply-To: <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com>
 <20260612181314.5577-1-alexander.kaplan@sms-medipool.de>
 <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com>
Date: Sat, 20 Jun 2026 17:00:35 +0200
Message-ID: <178196763509.3248.8656978100050911066@sms-medipool.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kai,

thanks for the quick test patch.

I ran it on Panther Lake with PTL kept at MODEL_ADLP so the KAE path is
active.
The codec debug log confirms your hunk is in and fires only on the
multichannel stream.
Full sequence, one speaker-test run per format, codec dynamic debug on:

  # speaker-test -D hw:0,3 -c2   (plays, front pair audible)
  HDMI: KAE 0 cvt-NID=0x3
  hdmi_pin_hbr_setup: NID=0xa, pinctl=0x40
  HDMI: KAE 1 cvt-NID=0x3

  # speaker-test -D hw:0,3 -c6   (silent)
  hdmi_pin_setup_infoframe: pin NID=0xa channels=6 ca=0x0b
  HDMI: KAE 0 cvt-NID=0x3
  hdmi_pin_hbr_setup: NID=0xa, pinctl=0x40
  i915_hsw_setup_stream: HDMI: multichannel stream, disable KAE

  # speaker-test -D hw:0,3 -c2   (stays silent)
  hdmi_pin_setup_infoframe: pin NID=0xa channels=2 ca=0x00
  HDMI: KAE 0 cvt-NID=0x3
  hdmi_pin_hbr_setup: NID=0xa, pinctl=0x40
  HDMI: KAE 1 cvt-NID=0x3

On the 6 channel stream KAE is disabled and not re-armed, exactly as
your patch intends.
On the following 2 channel stream the driver re-arms KAE as usual.
The kernel side state machine looks correct throughout, yet the audio is
dead from the 6 channel stream onward.

The sink is my LG TV with LPCM limited to 2 channels, on a fresh boot.
The first 2 channel stream after the 6 channel run is silent and every
following stream stays silent until a display power cycle.

This matches an earlier experiment where I cleared the KAE bit before the
multichannel stream and skipped the re-arm by hand, with the same result.
Fully quiescing the converter before the stream (KAE bit, stream id and
format cleared, then a wait) did not help either.

So the wedge happens earlier in the sequence, as you suspected, not at
the re-arm.
The trigger looks like the multichannel DMA start itself once the KAE
block has been active in the running power cycle, below the codec verb
level.

That is the same failure class as commit 6ab6f98fcdc9 on DG2, which is
why the patch falls back to the i915 silent stream method for the whole
platform instead of gating per pin.
I agree the DP pin gating shape was wrong for the dock case.

Happy to run more tests if your internal results point at a narrower
condition.

Br,
Alexander


