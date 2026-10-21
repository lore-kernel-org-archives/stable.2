Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568808;
	b=0B0IxN0IRaSSCSk9sDErnjCk2f98ZdvC2piGJ92qlHmBknhLf0uQKouYzKaoHHammZM3
	 tif3ju36/8wF5SCitsa9dScVCZJc7AhoUMFHIVAYf5r6YuFXiATonQ506EWhCw4xXen9A
	 h6/kQDmiIs0HbQmfMzdlByl5XqjvoKuO9YGCyC7J0xrrQtwSc0roWnW5ovypd1oTr/ins
	 8n9xoPH5LnX8dvr0BvhopF/kOyYmR5n/k+JzNoURiS10F2KLuIWlHfLKTLNQH9A/Tzbmc
	 eFzHYjvB4UchvkMYyPHo5JjCYfXHmIOBia5ooTvL4yb6LBJ2Th6XJJNjTykDk8QGIBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568808;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uqNA6UdvlKNzowUzrT4uwPygJKlqawV2mVUNB/VmOGE=;
	b=GN3gK2wKRPLiOmTIamra8+1s4kMWJTpbbNT3xbYNraiJep7vL/9x1p0050iP62NgZlZ0
	 9WiBAEI325bgNRi+zUNsUxiY7Ow70qvP1lbBXMp+N622W+ypSwf+Ap8JknciX+k2UuifJ
	 8grsidqcatqR2X9ZhruoM7GlSJsECT3q2HNmSEay97ONXQ5MDMRDyNP46WNzwjYdyGmLN
	 mpEOhfZGKwYZMAKG1MYPNZshD5LNsM1Z13S8YFBhRhIMSXxxCoBw407BSo7x8uaiMZ2up
	 AqR13oQL0/oT6XbDmQfOFTpx6Wm93xC31I2As/tpDvSq6i7Cqy41Nf7RgwONsmj9bEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/gGO+Yg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26497606A326;
	Wed, 21 Oct 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/gGO+Yg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792568807;
	b=LXt/VPFkkFL8M37HzHZY+3B5xlMolDUORMA/5uRYFX+TSyodB4ej7WHlWubQuakuC2nl
	 RKdeor7KTYUvOpRJLODkn3X04fMmvfatGnzAEkoTVVNy5xx4lP2oQpiap3j3csx11ViV3
	 PqJ7aePlLWvwfE2c/yVrNGJ8KQf7l29vrYsQwf+ddi9qSsRkS0oUsuuCWB3aureILui9m
	 SFtF/KXgOIbH9gNwmA2I12n4mh+CpMebFU+lQ2r4yD4aL9FpW15XQHpWTa04Sx8ms08hM
	 4xuY5WLG7FeEgSVIetA1tk5vM9iZdrN0REXxEmLxgHjoad6QO4VIDEooDdC/Seq93mA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792568807;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uqNA6UdvlKNzowUzrT4uwPygJKlqawV2mVUNB/VmOGE=;
	b=FzCVlFw5GUAnKItxOwvJ3AsjDbZQnRV04N1vTjiyZuJ+qsnntkWKBjexwrH33F4L8czh
	 DvGizOH11Tip7oPOWX13z80CCfVol3+NuFiGIC0g1VnspO+VaFmOQqwy+fEKxgROUUlqg
	 AvRiNdnYIB+l0LDGG2xN8V/r7/vj9oU1KyoaXWLKsy3jRZqrVQnUP5FcIfAyTwSbuS4TA
	 astAAH9plPiw9yNQsoszYfM9uSkFjzWNES6W9IM/IS13TZF7CdOvNpcqMpgax5AY9u1pz
	 ha2NwlX+fElJl8CUVZhxpunsybI7+hUXCqjw1kffWYt/WXABROFxNnGAEQLIuYa3TLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFEF61F000CA;
	Wed, 21 Oct 2026 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792568807;
	bh=uqNA6UdvlKNzowUzrT4uwPygJKlqawV2mVUNB/VmOGE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=N/gGO+Yg1nTOSG5oY9uyAOWw7mthkptlW8AbF/BgTOqUEYNYQV3LMo4UoNCTSK17R
	 yuj5vUmyDefjhweCu9qWM59gEJrdWR5Lw37YS1LxqqqbpqOvprhm9lJpZufFwuUYsR
	 ozwBkf5aDdzMRzJEqLOC0j8Sok+EneIMZfEudQY747QrdIl4H/TvcLx2g6vb03cFJX
	 Mxrse4x49tzO2Sr6sIXrsIUjVCqj/ho7bZlHXXnhN9UWgkog09yixGoAXQV+lvlSZu
	 xVks4KbwED1GIjL0Cx7/McMs4M+2hy+rFmTW+an8OuNqn4LZwSExEgHuheFyNu8C8T
	 zfz67upxZVePg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B39143312;
	Wed, 21 Oct 2026 07:46:45 +0000 (UTC)
From: Henrik Enquist via B4 Relay <devnull+henrik.enquist.gmail.com@kernel.org>
Subject: [PATCH 0/2] ALSA: aloop: Update the PCM Slave controls for a
 matching playback
Date: Wed, 21 Oct 2026 09:46:44 +0200
Message-Id: <20261021-aloop-slave-controls-v1-0-62297727177f@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtYehD1VcRDl2YaKc1o5hDG3
 n2dHr/D/6/gUlUcbt0KVRZ1tdJApw74FctTUFMzhD6cqQ+EMZtN6DkugmxlrpYdrwMz0SWlMUR
 o6VRl1O9ve3/87Z/hLTwfL9i2Hbo/dvJ4AAAA
X-Change-ID: 20261021-aloop-slave-controls-9bcc118ddf2a
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 Henrik Enquist <henrik.enquist@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792568804; l=2541;
 i=henrik.enquist@gmail.com; s=20261003; h=from:subject:message-id;
 bh=fYqwJhgziyigD6vhqDk4JUf6KAY1bq/UX5B5MmVYzUM=;
 b=1OFud9GDKIaNLquSWN+TQVtfX4rw1oiGbtrcC6NGzh+UNzu2hnMOAM+pHrZVDigf/OWBxxkGF
 uP1G65QXb8vCN2dQN+swkUhTq8jyrZ8QoBsq2uAE/FiomClRGHCpAXZ
X-Developer-Key: i=henrik.enquist@gmail.com; a=ed25519;
 pk=ctrSXwtuuiWIZbc1qNzu+n+1PkhB/a+2nlRyXd5j2pg=
X-Endpoint-Received: by B4 Relay for henrik.enquist@gmail.com/20261003 with
 auth_id=1105
X-Original-From: Henrik Enquist <henrik.enquist@gmail.com>
Reply-To: henrik.enquist@gmail.com

Hi,

One more aloop fix, after the notify mode one (ded1060369 "ALSA:
aloop: Don't constrain playback params in notify mode"). I ran into
this while working on a new CamillaDSP feature that uses notify mode.
The "PCM Slave" controls are meant to report the playback's
parameters, but often they don't. loopback_check_format() returns
early when a capture is open and the parameters match, before it
updates the controls. They then keep the module defaults, or the
values of an earlier stream.

This isn't specific to notify mode. Without notify, a playback that
joins a running capture always has matching parameters, so the controls
are never updated in that case. The early return has been there since
the driver was added, hence the Fixes tag on the 2010 commit.

Patch 1 skips only the capture stop when the parameters match, and
always updates the controls. A value event is still sent only for a
control whose value changes, so nothing new shows up except where a
stale value gets corrected.

Patch 2 adds a test for it to the aloop selftest. It doesn't need to go
to stable, so it can wait for the next merge window if that's easier.

Testing: for-linus at 443ed4edc2, arm64 VM, kernel with KASAN,
lockdep, DEBUG_ATOMIC_SLEEP and DEBUG_LIST, comparing the patched
driver with the unpatched one built from the same tree.
- The selftest passes 5 of 5 patched. Unpatched, only the new test
  fails: the controls keep the earlier stream's values (96000 Hz,
  S32_LE, 4 channels, non-interleaved) and no value events arrive.
- The reproducer in patch 1 reports 48000 unpatched and 44100 patched.
- No KASAN, lockdep or other warnings in dmesg.
Not tested: real hardware, other architectures.

AI disclosure: as with the notify series, I used Claude Code (Claude
Opus 5.5). It traced the bug through the driver and its history, wrote
both patches and their changelogs, built the test kernels and ran the
tests. I reviewed all of it.

Henrik

---
Henrik Enquist (2):
      ALSA: aloop: Update the PCM Slave controls for a matching playback
      selftests/alsa: Check the aloop PCM Slave controls for a matching playback

 sound/drivers/aloop.c                     | 11 +++++----
 tools/testing/selftests/alsa/aloop-test.c | 40 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 4 deletions(-)
---
base-commit: 443ed4edc2678cc51c5a01e7dffc4c890be40051
change-id: 20261021-aloop-slave-controls-9bcc118ddf2a

Best regards,
--  
Henrik Enquist <henrik.enquist@gmail.com>


