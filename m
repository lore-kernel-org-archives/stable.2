Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76AFBE1;
	Thu, 11 Jun 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.14.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189063; cv=none; b=pSo2UTDGMIkK3xLPcnI5n4GvoRrhwd3Gelwbc3I67TLtoHy7EWg8EEc9GWEEbtENom3FpvSrPnxJONT9NufcfbX02EblvUIcZbelVf/YIq765B6+9MWoNaZ/EMgk1Ua76g7ZjRQ2GUQOZ4TmhLsWQ919CT3HAx+gJsQ6ckpMNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189063; c=relaxed/simple;
	bh=ale706WJrCqHRFPgGjzouIqQ7wD2DgR0VSWvuZ0duAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeTiZTaXaJ29MOj1iQE6nhpN/1PdtIv0ttRRqsqkjV8ZQeWIpW/ocjOjWwJgJmLBxsEWo3UUgfNGpTe3SQRndKaEClguwxYUENGb+xKZJ0oc5iuh557malZtJ5ILHZYq8yf06qzXwamWOfTi8ePixFyhMI1sfaZxwqv9BsKbDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=U9ta5I9Y; arc=none smtp.client-ip=178.63.14.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="U9ta5I9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1781189059;
	bh=ale706WJrCqHRFPgGjzouIqQ7wD2DgR0VSWvuZ0duAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9ta5I9YwZ5n1BpVehDDJWHG4U+DZWJGQlZFJdzZAYOoFDtPlcvmmnI9nIsywgoVv
	 E7Wgs/SFFETTUGaMqt1yEo946jazVuEobl5ozN2n/BDATn2QJfiLVJVWm8MVtOuPqq
	 UqqIhUIsogHhOft7YkFYI2dnPPk9fBzgFFlxrVg74QH6d9WFS4WRuilbRXMpGvE9N/
	 xhn3kZub3c3NHl0GtuRqp8tPp5rZ/F1IkgEtCr2dfxcbEvIkgsRgUCHecQfm/rky1X
	 EwE+NLqWr4pAxaP/+Ik6v+7PlvMtJhsoY5czNG9JHMcUKb/A9LHuuS5a1K/GDzZesw
	 FU0uQsCQEUOFg==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id AF42215132;
	Thu, 11 Jun 2026 16:44:19 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Thu, 11 Jun 2026 16:44:19 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	stable@vger.kernel.org,
	Uma Shankar <uma.shankar@intel.com>,
	alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
Date: Thu, 11 Jun 2026 16:44:18 +0200
Message-ID: <20260611144418.23640-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ec0d51a0-a31d-4c06-92f6-e38c408884b9@linux.intel.com>
References: <ec0d51a0-a31d-4c06-92f6-e38c408884b9@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/06/2026 12:33, Péter Ujfalusi wrote:
>> My setup is: laptop HDMI -> SYNIC HDMI audio extractor -> HDMI KVM ->
>> monitor w/o speakers.
>> I use the extractor to grab the audio and it is clean every time I play
>> audio to HDMI.
>
> Just to rule out iffy equipment on my side, I have connected the PTL
> laptop to my Denon AVR both in SOF and legacy HDA mode. I cannot hear
> any issue regarding to audio on my 5.1 speaker set.

Hi Péter,

thanks for testing this and for pulling in Uma.

Your two setups have one thing in common.
Both use the native HDMI port of the laptop.
That turned out to be the missing piece.
I spent the day on a discrimination matrix here and your result now fits the picture exactly.

This machine also has a native HDMI port next to the USB-C ports.
On native HDMI the wedge does not reproduce at all.
With KAE enabled the same stereo to 6 and 8 channel transitions play fine on the same TV.

>> Can this be somehow related to the DP-to-HDMI converter? Have you tested
>> that with other machine?
>> Or a combination of xe2+DP-to-HDMI?

I only have this one PTL machine, so no cross machine data from me.
But the converter question was the right direction, with one important refinement.
The DP path is required to trigger the wedge, while the stuck state itself sits on the host side.

The wedge reproduces on all three DP-alt to HDMI converters I have.
A Club3D CAC-2505 with Synaptics VMM7100 firmware 7.1, a Cable Matters adapter on the VMM7100 7.2 firmware line and a Thunderbolt 4 dock with an integrated Synaptics converter.

Once wedged, the state survives a converter replug, a move to the other USB-C port and a full TV power cycle (forced reboot of the TV over the network while everything stayed connected).
Only a host suspend cycle or reboot clears it.
While wedged on the converter path, moving the TV cable to the native HDMI port plays immediately.
Moving it back to the converter wedges again.
So nothing downstream of the host holds the state.
It lives in the display side of the PTL audio path and only shows on DP.

Some register level observations from the wedged state, maybe they help locating it internally.
During the wedged silent playback the sample counters in the display audio register block at 0x65e04 and 0x650d0 keep advancing at the expected rate for the stream format.
So the samples still arrive at the display side and the stream dies further down, behind the audio converter.
There is also a register at 0x65f20 in that block which the driver does not define anywhere, directly behind AUD_CHICKENBIT_REG3 at 0x65f1c.
With a 2 channel stream running its low bits read 0x482 in the healthy state and 0x4a1 in the wedged state.
The same readback shows 0x4a1 as the normal value while a 6 channel stream plays, so it has to be sampled with a stereo stream.
That readback follows the wedge through everything that does not power cycle the display.
And 0x65e04 only counts at all while KAE is enabled, with this patch applied it stays at zero, so it seems to belong to the keep-alive machinery itself.

There are also visible display side effects while KAE is in use, maybe interesting for Uma.
Starting a 6 channel stream through the converter makes the TV drop from HDR to SDR.
Starting an 8 channel stream blanks the picture for a moment and HDR survives.
Stereo does neither.
Both effects are gone with the patch applied.
So the KAE to stream transition seems to disturb more of the SDP transmission on the DP path than just the audio samples.

Two caveats I want to be transparent about.
All my DP sinks are Synaptics protocol converters and I have no plain DP monitor here.
So I cannot tell whether plain DP audio is affected or only the DP plus PCON combination.
That should be quick to check on your side.
And the native HDMI immunity is based on this one machine and one TV.

For completeness, the sink does not explain the split.
The TV advertises 2 channel LPCM only, on the converter path and on native HDMI alike, and native HDMI still plays every format.

One unrelated observation from the native HDMI tests, in case someone trips over it while reproducing.
This TV takes anywhere between a second and a few minutes to lock onto a new channel layout on native HDMI.
The delay is the same with KAE enabled and with this patch applied, so KAE plays no role in it.
During that time the host output is provably healthy, the PCM keeps running and the audio infoframe is correct for the new layout.
Stopping the player for a few seconds and starting it again makes the TV lock immediately.
That is a sink quirk.

On the patch form.
I am aware the model change gives up the KAE power benefit for the whole platform, like the DG2 change did, and PTL is mostly a mobile platform.
If you prefer a narrower fix I can gate the silent stream type on the ELD connection type instead, so native HDMI pins keep KAE and only DP pins fall back to the older method.
Given that the HDMI immunity rests on a single machine I did not want to make that call unilaterally.

If you want to reproduce, a VMM7100 based USB-C to HDMI adapter plus one multichannel PCM stream should show it within a minute.

Should the Battlemage boards drive their HDMI ports through an onboard protocol converter like the DG2 boards did, the TrueHD report in issue 7515 would fit this same pattern.

Regards,
Alexander

