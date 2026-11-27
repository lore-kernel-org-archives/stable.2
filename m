Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799586;
	b=UrPSmmhRPBi4Q3DG+dJC2EEgaLfM7kvGzuiMAUKq1sW+EhhTWFovh9yDwhUhea40MyzH
	 C/u4ZCETaV59IW7Qt+kUsUGEUshFSnQv7E7PCYBif+9dUMya1IKfaonmc8ycKNFh9kHf6
	 +Vu5Ex2j81DtZo8elGyAiEUpQrJ0wfAkkK0jknA62K/Yuo48VdewkeF73T39WXdQ18m34
	 wy5dMwe69VT9TgMYwd0GIteMwvbAQoP5teBVGYgHQjKhh6WPtBkIiPR54OMxBrR4zJLPu
	 HBxJomjoBV5ARLkM0+WC+3QmjfgTvg4t0p0aZ+lKCWyr8+PfH/mlGa4xW27H7/7W67g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7S4J0Oj3sYJi1UqXP5r2+N/vXgyTszyUgul/cChtfHk=;
	b=saNuEsNfLC+D+1IYSYkjTRDoPgk1MCjju2meXVcO2RNsRO6lPIGIMfb8yAp42sAGdGi0
	 GUabN5rsJQHSFGQzhOLq/ZbIseVOYNrbcJ1fLU1xgNOQfsIetucs9qcPbVlcnSejryuva
	 El99FrsQ5CqDLwYvogyQnqgY5vDPtnui0BkTjnHD+JrQDHZEC/fzf5mj7KI2CSvFBVJ8d
	 PctYkUAu3rCjre0obM6nOCb88lfYY9Nyoo3ukLO5c2wbWTNe5rFCPKhv/mofAkVIRp1Wl
	 3rnxrg6vESz5jwdmkAq6FgjiOAPCWOEvjbcusTnBQB9TZQEmzkfgETQSNt4IWapASFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj7vH0m4;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEE606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6AEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj7vH0m4
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so3635903a12.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795799585; x=1796404385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7S4J0Oj3sYJi1UqXP5r2+N/vXgyTszyUgul/cChtfHk=;
        b=fj7vH0m4TeZVxSK8k5+Sz0uxrzg3f6k4UyMgACqdlY8cjUZo/6Vw64dAY+cCj8p6hp
         qJZMFHzUaWj11QpZHmyemfspjyUsV7SdGByfZPfNZ9pBVG0bEaCUp7j2xw0/KPrFXFTg
         JW9CWgxe4r+7O3oJbMpJT6sUt6Q/Hwzyur5mTQog7A6MM6zTF5Mhx6a9Etxm1eSZPzxY
         t/hi9LFoM9gFcRHYScoOsEZUlw5OWsUnc+WRVeQwBQHwB6lxQPmKtNgZ6mRoh/CqVkXi
         mWywp6E5Cd45e1sw3kU65/IWYgRbTYfUr5iSk9LULtwBEyvJHKhpWBtxpF64Af1+JfTs
         W0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799585; x=1796404385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7S4J0Oj3sYJi1UqXP5r2+N/vXgyTszyUgul/cChtfHk=;
        b=rSJr3Nrp3nvEKYBPTjgRqX4KvMhJBJmghmI6vj4uiSF1pOrq3sEFZitHtyPXpwfMLu
         YngDI4z3gFvPh247dvClpY3wnaMuX182qSCom6YSdNr6QGo5q+NYnddjb5bT9FtLLX2Z
         SOhdJRbPDkgxbROlElviW90pV4gSGtyKWFSW1K5Cr4EK71IVnHRveofy2Y8QVzQyGeIv
         RoWP4Tfc1k5FU02RlkCtGD4yDwURuF/hmTEv0T4C0Ecjeua3M8KxaTuIHpEbDoodNq8G
         fBHQg5gxgK155x5GvuSoJCpq2pwRQy1UH0Eos/JgXKGyOkwb3yMFGykksgkVa5O8u2Wu
         m+Hw==
X-Forwarded-Encrypted: i=1; AL+hErE4VDRKzZn5GS8Q9DI0bKThhvYAszVv6QOejDgKZbEe/1BJQcPErc7ei/GaRaGzDUvqixi1EhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6EsBaisxnVul+uoLR196B8AdtvBWPIbszmlFRkpiRlqsY/1hn
	uHI/j1JTgL7+OkG61HG27wphh5E0lGcg8XFYF3JG4ipUzFvYGwWaX+GO+MagItN9
X-Gm-Gg: AZFdTZcPhM/gRHg18skHflsouTTa/NWsRoEsN4NoDR+vO1dYJcA+1EQAloSa4tokZtG
	+wUABaP8kl4V08aPnJQOOQI511mVC+Ctq1cWaG91hB2at2KuKjzuU82uwnwiKAQ2jsHPsoU+3wT
	aHHtl4FyEeNknZfxH7Bdm1nV9MjQ+akQT60zDQHQZcH5W3QEfaPzVbQIHePxKvRo9gfTBqrj4Ck
	eoAwWy2T3ydiXvgrGP4F5+cFtHqk7D5fJMv3OidcTII1l0fOdPz5nqyjlPKdg9td0LJQp/8I9/r
	9uyL72+bsdi3zLcMkJbmfAhMnHzGkTKWTN2WEPjjCDspkMtcLmvLhefE5vNTSD+GoEmXGhoUDaj
	nk65APj0lFEFOkTJSNya3L9RjFIlAu0BfopO3XZtzn+5JoywrAd9USHZ6edE8VxXgahwhzO0dr3
	80TqSjN3imp0dd7AoAC5FwWwW7xpSs/tYDOEflgWBbgK+7m8x1VcQ/0laGvVt8clqzsVWlKqmqP
	RIu/RkyhjLdzWXlcOjXC/8Yyq0giHlXwj+xa4NUpiLsHiVWmZXaqRi1cDSLvI7Th8+VxgzOI/BR
	rm1EEtsUNsaNmQaiz1kDmYSx+mVfoLtb0H/KviLNjhA2ojkkjRvvhbnrOM4kZg0PXQhtBe+0eW7
	6Jcb3xMGiSxgCqmIr2VMxhqINtMLIO8iOu0qMNTntO8MmvSWaxhK9ahzBE7IC7wU8IMh59mMpOe
	aeKukyN6OgV93YPKJvvWnV
X-Received: by 2002:a17:90b:2e49:b0:3ac:80dc:f419 with SMTP id 98e67ed59e1d1-3b41c90811fmr24324820a91.25.1795799584854;
        Fri, 27 Nov 2026 09:13:04 -0800 (PST)
Received: from fangorn.. (97-120-153-124.ptld.qwest.net. [97.120.153.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm38643445a91.3.2026.11.27.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:13:04 -0800 (PST)
From: Carl Egbert <egbertcarl@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Eric Naim <dnaim@cachyos.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Carl Egbert <egbertcarl@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix mute LED regression on ThinkPad T440/T450 family
Date: Fri, 27 Nov 2026 09:12:41 -0800
Message-ID: <20261127171241.1619113-1-egbertcarl@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Since commit 8a889cce1c6d ("ALSA: hda/realtek: Unchain
ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST"),
ThinkPads whose fixup chain goes through ALC292_FIXUP_TPT440_DOCK or
ALC283_FIXUP_INT_MIC no longer get their mute LEDs set up. On a ThinkPad
T450 (SSID 17aa:5034), the speaker mute LED no longer follows the mute
state: no mixer control gets the speaker LED access flag, so snd-ctl-led
is not loaded automatically and
/sys/class/sound/ctl-led/speaker/card1/list stays empty.

Commit b2d447288fa7 ("ALSA: hda/realtek: Add
ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST quirk") added a ThinkPad
variant of ALC269_FIXUP_LIMIT_INT_MIC_BOOST and switched the quirk table
entries that selected the plain fixup directly. Then
commit 8a889cce1c6d ("ALSA: hda/realtek: Unchain
ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST")
removed the chain to ALC269_FIXUP_THINKPAD_ACPI from the plain fixup.
However, two fixups reach the plain fixup through their own chain_id and
were not converted:

  - ALC292_FIXUP_TPT440_DOCK, used by the ThinkPad T440, T440p, T440s
    (via ALC292_FIXUP_TPT440), T540p, W541, X240, X1 Carbon 2nd, T550,
    X250, L440, T450, T450s, L450 and X260
  - ALC283_FIXUP_INT_MIC, used by a ThinkPad (17aa:501a), the IdeaPad
    S210 and the Lenovo 145 (via ALC236_FIXUP_LENOVO_INV_DMIC)

Their chains now end before alc_fixup_thinkpad_acpi(), so these machines
no longer get the mute LED setup for thinkpad_acpi, nor no_shutup_pins.

Point both fixups at ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST, which
restores the fixup chains these machines had before 8a889cce1c6d. On
the IdeaPad S210 and Lenovo 145, is_thinkpad() is false, so they only
get no_shutup_pins back, as before the regression.

Tested on a ThinkPad T450 on top of sound.git for-linus (e79163b531ec):
with this patch, snd-ctl-led is loaded automatically at boot, and the
speaker and mic mute LEDs follow the playback and capture mute state
again. Not tested on the machines using ALC283_FIXUP_INT_MIC.

The regression was bisected on the affected T450. An AI assistant
(Claude Code, using Claude Opus 5.5) was used throughout: it helped
diagnose the problem, plan the bisection and write the scripts used for
it, identify the cause, and drafted this patch and changelog. I ran the
bisection and the tests on the hardware and reviewed the change.

Fixes: 8a889cce1c6d ("ALSA: hda/realtek: Unchain ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST")
Cc: stable@vger.kernel.org
Signed-off-by: Carl Egbert <egbertcarl@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5c3b383bb618..003f5052a842 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -5246,7 +5246,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
+		.chain_id = ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST
 	},
 	[ALC290_FIXUP_SUBWOOFER_HSJACK] = {
 		.type = HDA_FIXUP_PINS,
@@ -5361,7 +5361,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_tpt440_dock,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
+		.chain_id = ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST
 	},
 	[ALC292_FIXUP_TPT440] = {
 		.type = HDA_FIXUP_FUNC,

base-commit: e79163b531eca7f3fdc05031f4b43b6f7c51d3bc
-- 
2.48.1

