Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858929;
	b=Ttya8mKLF3GMJ8vfE/LMg3unKnELVcg35Jh+NdV9hCeczuwF5XNlyfk9jNIyXuoA3TLf
	 /gUGIhSx+Dy29LDM30hh+3dHh8RNyQBIu21fBgjA26xMSQB/ku6/wIFl5k8ucRyXm5y0W
	 K8b6DJakHYRO/xM3MCcsPm4XcQgVW+09afW+pEaRJIl0pi25mLBs3+QvZlYlAwDeDyQ2/
	 J3mhG9G7nGH+MayAodRDw9maP+vFMbwghkZQPwHEsOa9ATQakeRDjsVVrKVc8sHOalzJd
	 xZ2L0Q6hfwWAFzxOF2NbDSmcURB+8oxIbPSEFWIYjlmh6viXVd5p5BgbnojknHtNDtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
	b=oXCmXVYKho+uOW57drBNw8C8IXs1mf+DTeK+zEW793MrvaKXpVLdneLVy5cslTY8ZldO
	 rN9xSIgs3vqjbaREY1rlYgpl+l0NLVF2kmHUvP/ASXqOaxFqJaXNy6sXoe0Rym48PnYRH
	 OSA6TIv0T9cqeAh5Qvq+5OJsiRzc32hSdaog555O+U6hNEORAvNMZ/xjzKKbVS8mReLqv
	 cSRHiJdmxiQ16c8NOpKgdIzcfEH1qBhn7NW7K0gc2m5f/cWwb+R06iRkyDUG3IcmSxgf2
	 smU/p3nOKek0Qw9zkkuXUOVm3gMSunWflwm1DGdKW9/iRhS5HCiwKDJwdr3NZZ1qpPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OePMjijy;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFC606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BFC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OePMjijy
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so162325e0c.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858928; x=1795463728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
        b=OePMjijyJ15gubJKFAW+vUGCzLIYnT4IOOfJ+548xdDhlEwkw4AY3KHK4QXTEWcAsK
         RYO4U5wH3R17WxYKwcS/KtIHQJX7lJpJhJamOl1Ezn+p+MPp5JpfizpmaaWNwoCIwA8T
         psXxdIt+xkMy4gxffbkFkPkZsM73/TyWUGeyfMykJGFogsmJyMjVQCxrZzax/g+cNMkq
         0tTpGarBb6B6DlI414Hu9iMsEFEOVhrUB8ZDjo83iX+Zvse//Mjo3gI+S2afsM0g/LUa
         HTMlZ4doMwtM6Df0LYVIQjrAZ+1benWSjGmbnGShvD5iSiAEu1N53rRRHafCDv23jE//
         G8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858928; x=1795463728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
        b=WJUa/aZsux4RkpMeQLmLT29t3O4BSLQ91Zv9iHxv8V7SPyYEz7mxDuK8yZLInjwDfP
         8KQF6bgysf2Dj3e3onSlYcQd7ohn7z5xwgCOLjZDNBWLJ/WJhaNUO/XWZnvlZeOIjocJ
         jVz6doaOYGZXNKuBwv1bFSuBFTEoAojiwMxzfMj99/WSh7O1XFeMBaOZWUf7hJEEoePu
         yj7qC14ARN52aHwZem+rXAep/vV+QECDK15g96oYuDHhnBI1jh2zi7xUacTqm55jqAvV
         YLobHGGDsdxPri4u5fHTTF1V20v60XEBVucd/e/l347JU/MOR1HeXsy0w3MoWnfbgS2r
         dc1Q==
X-Forwarded-Encrypted: i=1; AL+hErEpmFeqj+IcGfunz8IUXGQj1K2qy+XGDfz19CG0qzfl9MRXJKfto2Z4IxysWOyqZlxbQqaepsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Db/gNNJFJyW/BSscKGecZleU3diaL3SFXkbquvMUTyal8TgEG
	0Sg9KXNKjQAIuSPZFoVwuMrWXPwPCcjMHHKLUk5o4r6GrGPM10Nn8cXH
X-Gm-Gg: AYBFou2x6vdt5PV0zGSluApKaAZXhMF7T3JD4dqiLFXWhTSyu/S4T5l28ISKBkLh2K0
	JTS3pnTa03Pk8FaThlk9z9k0H+K0xMWiTVE7ePuBh7MJlqC1NBjxRXHlAWCg1FmsBrd3/QJXU2B
	zH6U+QWl2By0TWEn1asfogEaMUOsfQYIGOYP315JloFq0sKpE39Nc4ouWgz7VYDKguHx+t3kjAA
	eeiSZPPz+6LMrNHKgWDTDWJgnHRImrFRZTS29FwdDfRXjMagEQqjCEc+ml8CNG0mErcTAV1YYzr
	REuEG7vbSTRK3Vw5LlmtzvFiY8qYnv2bE4tCnt3z1Nxuc1t1ILQAw2tP5F1EnIMN37DlHzNZ8Qi
	0Yu/4n6Ui768QhdPDHOcpO4R+StpAGdWELworWXrp9pj8XBhJTtRGTZLJLJuNhPg0JBCSKQE4dj
	cGq34kanzK06QuFX2rZz35y7caQm3bf45rFfwd0MWYZw9KaNDsK1DO2z0QwsQvStXnaikQIMLCu
	K3uLbD/BQO7xfWrUXHW3sHr9L5urBwu8ZPo6VCls66HYQeEQSFi3R7vAPHgwlT/9j7W73UNrh4H
	3r8qcNJhGJiMQV5HN12Ljj0oPfR1Sb0gwzaItn2ufw==
X-Received: by 2002:a05:6102:84c2:b0:7cb:bb7b:77e4 with SMTP id ada2fe7eead31-7d69f60aa43mr133060137.3.1794858927558;
        Mon, 16 Nov 2026 11:55:27 -0800 (PST)
Received: from budget-pc-cachyos ([37.19.211.133])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69dfe6e71sm720482137.6.2026.11.16.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:55:27 -0800 (PST)
From: Elliott Tyson <planetlinux98@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Elliott Tyson <planetlinux98@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: xpad - scale Xbox One rumble to the 0-100 GIP range
Date: Mon, 16 Nov 2026 14:53:58 -0500
Message-ID: <20261116195500.107990-1-planetlinux98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The GIP rumble command takes actuator levels from 0 to 100, but
xpad_play_effect() converts the 16-bit FF_RUMBLE magnitudes by dividing
by 512, which yields levels up to 127.

Not all pads handle out-of-range levels. On a PowerA XBX Spectra
Enhanced Wired Controller (20d6:4002), levels 1 to 100 produce
proportional rumble, 101 produces almost none, and 110 to 127 produce
only weak rumble. Any effect above about 78% of full magnitude,
including full-strength rumble, is therefore barely noticeable on this
pad.

Scale the magnitudes to 0-100 instead. This is the range used by SDL's
HIDAPI Xbox One driver and by the xbox_gip driver currently under
review on linux-input. Intermediate magnitudes now map to
proportionally lower levels than before; for example, half magnitude
sends 50 instead of 64.

The problem was diagnosed and this patch written with the help of an AI
coding assistant (Claude). The submitter tested it on the hardware
above and reviewed the change.

Fixes: 2a6d7527b35c ("Input: xpad - update Xbox One Force Feedback Support")
Cc: stable@vger.kernel.org
Signed-off-by: Elliott Tyson <planetlinux98@gmail.com>
---

Notes:
    Testing:
    - Built as a module against 7.3.4 (Clang, W=1) with no warnings and
      loaded on that kernel. A GCC/allmodconfig build was not done.
    - Hardware: PowerA XBX Spectra Enhanced Wired Controller (20d6:4002).
      FF_RUMBLE effects were uploaded directly with EVIOCSFF. Before the
      patch, full magnitude on both motors barely rumbled and half
      magnitude felt stronger; with the patch, rumble strength increases
      with magnitude all the way to full.
    - Not tested on a Microsoft-made controller or on other architectures.
    
    Behavior change for pads that already worked: below the old maximum,
    the same magnitude now gives a level about 22% lower (half magnitude
    sends 50 instead of 64). If you would rather keep those levels,
    clamping instead (min(strong / 512, 100)) also fixes this pad. I chose
    rescaling to match SDL and xbox_gip.
    
    The pending xbox_gip series (v7, patch 2 "Input: xpad - Remove Xbox One
    support") removes this code. This fix is meant for current and stable
    kernels in the meantime; please drop it if that series lands first.
    
    AI assistance: Claude Code (Claude Opus 5.5) found the cause using
    userspace FF_RUMBLE tests, wrote the code change and the commit
    message, and built the test module. I ran the hardware tests and
    reviewed the change and the description before submitting.

 drivers/input/joystick/xpad.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d98fea..6cb3be9845fb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1606,8 +1606,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		packet->data[5] = GIP_MOTOR_ALL;
 		packet->data[6] = 0x00; /* left trigger */
 		packet->data[7] = 0x00; /* right trigger */
-		packet->data[8] = strong / 512;	/* left actuator */
-		packet->data[9] = weak / 512;	/* right actuator */
+		/* GIP actuator levels range from 0 to 100 */
+		packet->data[8] = strong * 100 / 0xffff;	/* left actuator */
+		packet->data[9] = weak * 100 / 0xffff;	/* right actuator */
 		packet->data[10] = 0xFF; /* on period */
 		packet->data[11] = 0x00; /* off period */
 		packet->data[12] = 0xFF; /* repeat count */

base-commit: ab13b5fc808e043a13f861a7c1c2ba8173c22b84
-- 
2.56.1

