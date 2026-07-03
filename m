Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942ED2F39C2
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099415; cv=none; b=QAVIKl+cLvKmCBkKVg6BLB0ZLCdubk8WGaptXqQawkqwTuVFykJ/nm0hfHsSngJAexMGrGMIWQ7w/qxNjIgNY+33P8pF+uYqiiy3BO4Bk8oTwu4JtHKGv/nAFlW0sZFYWiXkm/cxk0NSTTs3oHdLSeRmcEfM8X5Ji+nIZLcqGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099415; c=relaxed/simple;
	bh=xmKlrc7d1HKMVV88bng+H4A1GhSTzkA1lPEahMkJSdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CbVUP08AxSPlZWBwIn+rCbRB8ijW6f+jjTuY6/XZDZhG009W40VRHapnYbLpprfFdnbQx+e4UFxg+IqmlOfrJicG/tX28kmWQaitmqpszjMWUHWPUYMY3VdIvQmj6RVcAWquu2pl/TgFmtLOsJE80I9D6Vk7gPPwurynZAJyisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUylmdo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUylmdo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c96c92c0980so410701a12.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099414; x=1783704214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jGWPqmaXNVBnCqPFIOavEqxkjqjQO61YLrLNd1b9aA=;
        b=ZqUylmdoODQL58EsANQ0vW0+FyxnZVckLX/v7JUFzTGUchClltkXEYTNVHhbshu/zi
         cM3OIJLCTeBpe4+7xZBxuXkU2T7xnmlqlMnrLLxrGP0srH0Ln4CZ4FAS8PqI+aFiMPz3
         zGtDOTTjHV/qGqI3+wWZF5B/WBFQEd2QjBy1UmrpQw4yOpJvMFl5uYrMs/2ujmLiet7N
         WRq2ha8fxh5RyvQBX1rsEuz+PDU8VrLkLbmREebi78cAtvZLw5b8ECijiiS+ecQ7uvA+
         DIUGG16sChfT8SNeejFdq0995ZfUo01WxCfGF2uDKRqbd1aIjDwHfogxeaLftyXkS0jW
         NGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099414; x=1783704214;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7jGWPqmaXNVBnCqPFIOavEqxkjqjQO61YLrLNd1b9aA=;
        b=JmhqAz8YdXLc5Z1chFnZRjk6fbptgvjZJtPJaslTCZtRgO2KQ/YOEUTSvr/1hQdr/P
         IfUcoRHjbHACnm4TQ/1pkYLFjKTCDZKK9MJGvdBpvaPxdqrOqaDOSLMSurTP73dWXWUb
         fUIYSeZWH4AwA7/u6Z7+fbNMI60wtgSR8etmBOXss/wytTHXi/ZSOrmgNg61yOW6CgWi
         BA70/GTGZOp949MSTclu1eIhzzG2Xgp7jOxYYu9zxjahmXSBhkyAVyI3pMTuaxKS69K6
         /amgkFBKUfI3c+unR+d5ALyjyhu9qKqwzIgFTCDcr3dPXdDrwBH80Ds8V2mWH8A6W1C8
         BT3A==
X-Forwarded-Encrypted: i=1; AFNElJ/WHsSmgHdlFkg3xRYzjZElaCy3Jc6Qd/x4LyHHJS3dUE/N1lmnuKtg4oxFEGYSzZVkJQL5zQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKZ7dFxRGlV9zivlUVm7l9bWDj24qpYZfoVBnU7u9MNnledOt
	6Z6B/nns9rdCHSmbpxeYKLzNSJ4A5QEMcAnegUoFqZ9JnotDakwq8hmqajj7oH+V
X-Gm-Gg: AfdE7cmru5bD3s+Su8P4Lian9YkPzFA6FHE/OIoxHAb3MvNHuMqmi7VL8gqXQFHm7g1
	gsdyOnVJQhu7smLsXwrvUQJY5rZckyRZGXKgWlFsh70ABSPrGShv4X5Hx1/yHx3FQY/lVnfMhbH
	4eEw35FvYH4t0g3H+XFdtI1o5hJOoK0KDkSWMyODqPn/yHkxk3a10T70BE42/AfcnXXhLtlMNnl
	vYPINNzjeXQ219MC5SCEAPZz+qdrZiEzAM/BDKtRrbBxLyFpeLhGfG5kKogvS+WBHQTrSMUN5BT
	i7IJTvC5VNopPH+rmTgUz9BgnFgypeloPBhM8azz9UcJNaxCBvB/m9SIbqhFg6mMUibq3pumaJy
	YW5vRjyi0VPeNJYC/1d5IjA7gpVF3L9flwF7aAcFu/DzWn02egUfxh/py+JhatZDKGopgwaUMJ7
	6n7Qba+8sBeLh5LrnKe1twg+WB7HfAVXWImPuwsR+pp97kcw8=
X-Received: by 2002:a05:6a20:9f96:b0:3bf:bde7:d679 with SMTP id adf61e73a8af0-3c03e572be8mr276253637.40.1783099413818;
        Fri, 03 Jul 2026 10:23:33 -0700 (PDT)
Received: from birens-macbook-air.local ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb843fasm22278176eec.18.2026.07.03.10.23.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2026 10:23:33 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH 0/2] iio: accel: kxsd9: fix use-after-free and PM leaks
Date: Fri, 03 Jul 2026 22:53:21 +0530
Message-Id: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnwR2oC/yXMQQ5EQBBA0atIrVXSjTYxVxELWhk1k9CpQiTi7
 ppZvsX/BygJk8I7OUBoY+V5irBpAn5spw8h99GQmaw0L5Pjb9e+wi3HIHMgQWdbOxjni8pZiFU
 QGnh/jnXzt67dl/xyb+A8L7G+hRpzAAAA
X-Change-ID: 20260703-kxsd9-v3-proper-51a1f05c4951
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Biren Pandya <birenpandya@gmail.com>
X-Mailer: b4 0.15.2

This series fixes a use-after-free during device removal and resolves 
multiple runtime PM reference leaks.

Changes in v3:
- Split the fixes into two patches (UAF fix and PM leaks fix) as 
  requested by Jonathan Cameron.
- remove(): Dropped the early return on PM resume failure. The driver now 
  makes a best-effort attempt to power down the device unconditionally, 
  addressing feedback from Andy Shevchenko and Jonathan Cameron.
- read_raw(): Mirrored the -EINVAL reset fix from write_raw() to ensure 
  symmetric error handling on invalid masks.
- Dropped redundant pm_runtime_mark_last_busy() calls, relying instead
  on pm_runtime_put_autosuspend().

Link to v2: https://lore.kernel.org/linux-iio/20260621193036.78549-2-birenpandya@gmail.com/

---
Biren Pandya (2):
      iio: accel: kxsd9: fix use-after-free on remove
      iio: accel: kxsd9: fix runtime PM leaks and unchecked returns

 drivers/iio/accel/kxsd9.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260703-kxsd9-v3-proper-51a1f05c4951

Best regards,
--  
Biren Pandya <birenpandya@gmail.com>

