Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566537BE72;
	Fri, 12 Jun 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.14.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288005; cv=none; b=lM5aIR6zh6PSSyMMhATmg+yjXBGFz8QcQubKQxQu1+6U3ter1S8ZSg+unOTFx3Vry453BkSImXShK9GOfB0liejqZaIu14LzoWcZJFyLZFp3gb2H71ysgYi3mNVSNTzcEBQN6ezgyzS1u4+ioAfOJ7SN9X4a8IfWyNleYz9+pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288005; c=relaxed/simple;
	bh=4hmfCa69JxyzZZIANSUHJYAKlUF4kWc7qLqjKGtdKvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPbSPcvtw0h8aOdjjUgmBrp0XIYUArNDKjeXMMOkb40ZWRUDKgWI8YDvxmWuP8IZIROfcvEHyoR0PksyBVP8uy/pXXE3KiAOHJJ1+dAGi3AsfRnA5ZrKEvk9qM1/HErDcLeIs5S4ItgX0dnScgF4YAs6AYCAHvhRhryOFmDGV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=HpnHGUpk; arc=none smtp.client-ip=178.63.14.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="HpnHGUpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1781287995;
	bh=4hmfCa69JxyzZZIANSUHJYAKlUF4kWc7qLqjKGtdKvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpnHGUpkvfuf1McF5x/LqPb+DNE9MyNlo3qdsGNr5Rbb+eupTAldTn1l67Ha86IhP
	 MoOQ+o3mhtByyc/rWiFY730vHHvkdu/hX/6OzomLats6Ipv9RhIolO/8/V8SRpOmrR
	 3VDbbBaU9isIrM8LlbjCSFTLW9j2Hto2qb43d0txhVmekhmazboT2QJOYr4cTGNLwS
	 NqNp+ZwaBJEgWkuVaD8hTFCyOXRe5KZAELHgVn7zbGbZGuTQ3NGP5Td/bJYfmt3DnV
	 Ocz3VBVlUj/qVxmPSiNv48GooYDCaUf9IqW3ZpcNybbOzCMkvj/Sazc8fyhbGv1Xx5
	 IQhbZJLPX0HtA==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id 9653418801;
	Fri, 12 Jun 2026 20:13:15 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Fri, 12 Jun 2026 20:13:15 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	stable@vger.kernel.org,
	Uma Shankar <uma.shankar@intel.com>,
	alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
Date: Fri, 12 Jun 2026 20:13:14 +0200
Message-ID: <20260612181314.5577-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2026 15:45, Péter Ujfalusi wrote:
> I did not had too much time to test this, but I did found an old Dell
> TB16 Dock stashed away.
> With that I can reproduce the same issue on my PTL laptop. Out of
> curiosity I gave this a try on an LNL laptop and the same thing happens.

Hi Péter,

thanks for digging out the dock.
The LNL result is the important one.
It shows this is not Panther Lake specific and points at the KAE plus DP combination as the trigger.
It might also explain the Battlemage TrueHD report.

> Note: via TB16 dock I can _never_ hear 6ch audio, it is always silent,
> only stereo goes through:

That is probably just the sink.
As long as KAE was never active in the display power cycle, my TV plays multichannel LPCM audibly on the front pair, even though its ELD advertises 2 channel LPCM only.
The bug signal is the switch to multichannel itself.
The first 6 or 8 channel stream after KAE activity plays silent, wedges the pin and everything after it stays silent.

> I'm not sure where the bug is and I'm not sure how a fix would look
> like, this needs help from the display guys, but globally disabling
> silent stream for PTL is most likely not the right track.

One small clarification on what the patch does.
It does not disable silent stream globally.
It falls back from SILENT_STREAM_KAE to SILENT_STREAM_I915, so the silent stream keeps running through the regular stream path, exactly like the DG2 change did.
What is lost is the KAE power benefit, not the feature.

That said, after your LNL result I agree a PTL only model change is the wrong shape.
I can gate the silent stream type per pin on the ELD connection type instead.
DP pins fall back to the SILENT_STREAM_I915 path and native HDMI pins keep KAE, on all KAE platforms.
That matches the failure boundary on both of our machines and keeps the power benefit where it works.
If that shape works for you I will send it as v2.

Of course a real fix from someone who can look behind these registers would be better than any variant of my patch.
I have no access to that side, so working around KAE from the codec driver is the only lever I have.

If Uma or the display folks want data from the wedged state, the reproducer here is deterministic and takes under a minute.

Regards,
Alexander

