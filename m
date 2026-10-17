Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AC3ACF15
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255310; cv=none; b=qJKjxRWGoZ7HGZQrmPW5IBuVUycK2n8m/ZK0M8HhQrEDTmZf/dabD1/N7MyA0hH870FGEsaP6cxq0ckUi6rVBTEEBb6Lkv1PxQXxzx9gX318f7kI50H98JkGhEQP79spiC+/stwzMIJF3Tg5TXv1HC9uJ/hoBMxMJE8B+ZI0yO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255310; c=relaxed/simple;
	bh=f0oOwJ99ASBwohPnUw6E+rSWJn8E7P22P3UNI/krsOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBjXwDztnbqmjOZFvOZLtXQwU9hWU3V15HS+pDchexlAgspP9iIFr8s/i/BK1GJm7KdF9F7x4UuIGnv5CfDEBYiNuoWVq0S2MvVvu4mup4DcJmtC6nqi6ktqOXl1R9prjsKgeX824fPNFMoLLatq4NKEPu5P5baX97fb0zqf400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaqPQQaB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaqPQQaB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b52ba422cso11840606d6.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255308; x=1792860108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJIcl5oLftMCiRZNmyVUnJAZje8wxQdTARXgo+oxa1E=;
        b=eaqPQQaBtGDG4Hzd2VZQKPEnLDGwTroNn+VSySiQssXijYvMQmXTzNeIgSkJxWK2d3
         PbDSaNgAagAzegi2jRxPuIHJ4LPUwpA2EA+aMJgZHDQbzi2BpFjz9a9xVPWIR0sW+O3C
         A+brrb1J15bXvwwugKD+DouyK5VjA6664zHiwsXeeQDygIxntBTwU24M+owZHOe5aQwq
         nOun5yHsz0zeYJE3sxRQBrGIq5YPOW1vgqX58VKuRevXLH/8hv4b6bFCWHzo/cVR8XDw
         gXIpsqwoRG6WzSiFrEEhLtZzMFSmEVuN0pbRDM/ReQjKkRm96Sf0z9tPTdVGrV8IK63L
         nICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255308; x=1792860108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJIcl5oLftMCiRZNmyVUnJAZje8wxQdTARXgo+oxa1E=;
        b=vPo7FCJergHhfqUO41g+qCd2vfj96YW6F3+zE5NMGCsFzaegZs2erjJT7Ak5mDP6fK
         fxgbR9lH04xDdeFjK+CvK/S1Es/7fhpGpkqBto1ORN/2vUF8NqaqX8Sv3IoVVr0JxZr3
         jcK+R16ajaZ0gFBfft3yVZOo7rwTivZA3qYqwWPfLuWrRRcGRVchCCmaNKOrSveGsJry
         VmKXbH+yy/gO6dtsasuxubZ0BHS8iE2hyHf/ys0F6SSyaQeStDV/16+lpKF5t2aZWaiE
         mmDO//MLZcOFOCDP+p8aC2n4U13Lg3p6TPUJuw1cj2uiT35KtonWptOyr6CriQ8S5P4Y
         ZqTA==
X-Forwarded-Encrypted: i=1; AKwUvBwN6ro4OSHd+d5jUVX1OdmFqTMsf+aqa+l8qUEva7IJ8BXEYkefwShpV5/ofnLK4YPDVyf2b54=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX72GTopnoty5YpTUu1frBemSlxj+LSza1uigFI1ve0xCnZ4Tv
	1Qf7CbGv0d0WgLsAP5PSmiIlTaVGJzbE17fZ6+EdoiNKYE1JhokUHrN3fiD+tpJn
X-Gm-Gg: AYBFou0n0Z0VzmH3CImN5nGGseQ4rOVUZ1Bi7VSffYPWN0mpZVIX9bvKDkPdpjXs1wv
	mkWLZT23TMVAEJ5PEUY+xWPIAYlDfBYoZApqK9YIiqajI9URxosiKLfFr6XV4hYMyt7yStG+pFR
	uRWSCNOskUoUA/M8YCNwEs6obYzsc8+g44a7WFyqsLxtk5DabkQyh0xytL8+mzaHoAIjrM/seey
	RdvvcPHCwYTS7o/jl3hBC00vyH9f9iy+VaHczc1xd42O8eHtcYLn8gp+o4yOBaY6UU255gyLSR+
	xMON9fpNzLeQI8UFovGQkwdTSb1iHIXFddEmpayt/KcYBQVWzTtkHWzXdDJ4R/KLhT4XD5a7ScV
	NgjVVrN+/iFQpXOedl0hH8U4SddmFlLDUCFGOPOb/5sxbkWdqsZDeGIzFyv/dJrQe1KBOVqO//n
	sI5K9eYCXtPNkf/HhKM5UbTPnt9QJhXVgfJgxGJmRkBUhm5uV85YDcUrXHKcDPMF/C
X-Received: by 2002:a05:6214:3b89:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-91bdf17e317mr60816536d6.30.1792255308456;
        Sat, 17 Oct 2026 09:41:48 -0700 (PDT)
Received: from beelink ([187.15.140.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm51061296d6.1.2026.10.17.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:48 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v11 0/2] HID: multitouch: fix haptic lifetime on delayed input release
Date: Sat, 17 Oct 2026 13:41:37 -0300
Message-ID: <20261017164139.1791033-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v10 review found that the multitouch slot setup ran before validating
the haptic class and selecting the input that owns FF. This could set
INPUT_MT_TOTAL_FORCE on an input without haptics. If no multitouch
touchpad input was found, haptic mode could remain enabled.

Patch 2 now validates the class and attaches FF before setting up MT
slots. It selects the input where multitouch touchpad pressure was
mapped with gram or newton units, so an earlier multitouch report
without haptic pressure cannot take the sole FF instance. Only that
input gets pointer emulation, total force and haptic pressure
accounting. Haptic mode is disabled if no input receives FF. Patch 1
is unchanged from v10.

Tested on x86_64 with W=1. The HID multitouch module compiled, and
QEMU/KVM with KASAN completed 10 virtual UHID haptic cycles and 10
multi-input cycles with a non-multitouch report before the multitouch
report. The tests checked FF_HAPTIC, effect upload and playback, HID
removal with an open evdev fd, and final release. Two negative fixtures
had gram pressure but either no haptic reports or no touchpad report.
With two contacts, v10 summed ABS_PRESSURE to 30 in both cases; v11
reported the oldest contact's pressure of 10. A split-report fixture
placed a multitouch report without pressure before the pressure-bearing
one; FF, INPUT_PROP_POINTER and ABS_PRESSURE were on the latter input.
No KASAN report was emitted. Physical hardware was not tested.

Base: 58161ead29e50d70a317ea26b472e0c7508e69da
v9: https://lore.kernel.org/linux-input/20261017140332.1480375-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: make FF creation the last fallible init step
  HID: multitouch: give FF core ownership of haptic state

 drivers/hid/hid-haptic.c     | 161 +++++++++++++++++------------------
 drivers/hid/hid-haptic.h     |   6 +-
 drivers/hid/hid-multitouch.c |  59 ++++++++++---
 3 files changed, 125 insertions(+), 101 deletions(-)

-- 
2.53.0

