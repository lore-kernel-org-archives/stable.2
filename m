Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E3A451F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268000; cv=none; b=QSzFOQ5oCpH4Y1Blh5aQ5B4R9zYyqbTxDRZZm5IPOhfk9Mjv1PhSv8TbSXVq4nc/dP/mSqXMw0UMjj3lDyB0BEja79rZzefB9lNXcVRdwejDkL7DBNOWKhGsIzCkVRu2zhQlCZpuq3QXtNVZhzQ+lareJ8Z/0gvH6jEZ7O0rdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268000; c=relaxed/simple;
	bh=P2zz5GWw5QOn8YaZoIVLc4DNYCylv7L4DbveOHsNUOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX3gWswcw71jGlW9Sztg5/GeFzijwXD70S5nLvLE5bFbA2MdB1llqY6Nf/bFR68csmA8dCNSI6/Jppp1HPkSxbzF0MyGuznuHD5prtacNOVE6+Izo3jjcmYpLdSCMDchFOBwPG4P5NarWXBy2mvIK1Geqjz9KqUH9plxpu1usNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXXf+Jb9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXXf+Jb9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-865bdc6ed72so35093177b3.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267997; x=1788872797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yfDIPBjmDhoPL2UJgt15HMxvXWs2DkCFmbgzNrEbnE=;
        b=jXXf+Jb9w2nG0z9AsmUV9dAvDyjXOKrAcjzL7xBAmHTOdwUZBrXwNwVw2ynJ5wRFkc
         J6/G7TCGLbS7KiGh+ouqNFGYbWqiOqMfQwXOvs04CoHOnYLS5yWVw35pIRzrB+sxpGY+
         5KFX22I16wAi97gkfM8aC5VGPRe2WIJt7Blw0eT83OtMwt+B4ciYce+BZQUvbwjkFHJ8
         5DCG6BLxSRFWE2WWP2/l8kVznLTZclvExZntdQSL9EpBM8+k8t8F+bPPnMFsJakMjS3B
         YkwtfdZHMdGp5e/8GgRR17xz5v535hhT40VS3i8pvaf8MlluUSLb+BgZaQcM/y0UnNb2
         7Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267997; x=1788872797;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yfDIPBjmDhoPL2UJgt15HMxvXWs2DkCFmbgzNrEbnE=;
        b=exxq7JZJtbgVWY3GmAP0fSN7jqbcbry7/zzejjTUl1aL15D+OFTnh9FK7LiiHH66MC
         onVpgdydqMH1eiZIXyqvniXMIOzDuFuXOWDorondxMWb3XHvT2YDgxoK+YAFpte9ezCR
         vj617oTw+CHbCxFRndNcPVWIjNr+hfdO4FqMO5dIeSQg6e212le0HmveWU3vOt+7QaZ6
         gvLssS1U9NsrWV8cR9VD070k+m7BEdTrj28mqmRJlelMB4E8vM66cJZnI22Cxs4zni36
         PAU7rKf9cfD84+2l2LC+czEXVLWwNCWdlv4zenVKyQ7X8VoOgqmCZYf9WHEZgsTbq9LP
         k9Hw==
X-Forwarded-Encrypted: i=1; AKwUvByw++sg7K9CB6l1U0W1TPMAwY23OyCHCyXllWjV3copnThrRUTCCyHJ566Skfz56yqfRXJHJzk=@vger.kernel.org
X-Gm-Message-State: AFuF++nvg5I75IHlLumsyDHuHEFX7ug+jLIb0hywuzeEvcHQglDQisbD
	YkUSYQGGNfdZrRDzX4OigSLPqOV7bRw1VrA7zkXPZ29ZFDpM3MZve2bR
X-Gm-Gg: AYBFou2WL6nMCUWvjItManuJfb3HjdhNl9B/H+UVG8KIkLAiStDv0jxPJMvPYoz7umS
	0qEV5YBv5h1blxRSXcB07RR392jsMJsJKSaNTcz+WhNawQ60UKcUdqipvWhwJm/x1+/z++HCcCo
	/N2Q5loP73b5b9Q+rrUNhSmnAtJODDHoQwywx2q9SGcjRT6LpgEcyRnet0c3S9kpSAyzNSTOSmN
	vbfgsnAUrWQVCAcCiFgwAa2ZqE8ioB8WzPhVWb9Dn8mk3YGYaf4+vAMByZlhXL1/mMyh+49FCE2
	ININlvzOKZ80lKWIP6nfEQU58qQCBpu6+Dkue0vnB/0R5QVSJf7jmRgaZ3AgGXLHkvNWa0/CDTp
	WGTB6wD8bVIwVxVMVvPABYwVfpthjWPUui6zbLy3LXZiWvURWfSV6WkJCO4kgFlzhjPtvY23gt3
	hzrUZhu0OYhzzFtYcS4333OEoEWD1oFMp/iqneQsbeaNGPTq20L0mEEaWV1bQTfLc4
X-Received: by 2002:a05:690c:e3c4:b0:814:7a54:3a93 with SMTP id 00721157ae682-86873382f72mr35758917b3.23.1788267997408;
        Tue, 01 Sep 2026 06:06:37 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm73290547b3.17.2026.09.01.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:06:36 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 1/2] Input: evdev: zero absinfo before partial copy in EVIOCSABS
Date: Tue,  1 Sep 2026 10:06:27 -0300
Message-ID: <20260901130629.24078-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901130629.24078-1-ivanrwcm25@gmail.com>
References: <20260901130629.24078-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The EVIOCSABS handler copies at most the user supplied ioctl size into
an uninitialized on-stack struct input_absinfo:

	if (copy_from_user(&abs, p, min_t(size_t,
			size, sizeof(struct input_absinfo))))

The size comes from _IOC_SIZE() of the ioctl command and is therefore
fully controlled by userspace. A short size leaves the trailing part of
the structure holding whatever was on the kernel stack, and the whole
structure is then stored into the device:

	dev->absinfo[t] = abs;

EVIOCGABS hands that back to userspace, disclosing the stale stack
bytes. Only the resolution field is currently cleared, which covers the
legacy struct layout but not an arbitrarily short size.

Zero the structure before the copy so any part not supplied by the
caller reads back as zero. The existing resolution fixup is kept, since
it also handles a size that partially overlaps that field.

Fixes: 448cd1664a57 ("Input: evdev - rearrange ioctl handling")
Cc: stable@vger.kernel.org
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/input/evdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 3a718d600006..8bfaaa45e0b9 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1229,6 +1229,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 			t = _IOC_NR(cmd) & ABS_MAX;
 
+			memset(&abs, 0, sizeof(abs));
+
 			if (copy_from_user(&abs, p, min_t(size_t,
 					size, sizeof(struct input_absinfo))))
 				return -EFAULT;
-- 
2.43.0

