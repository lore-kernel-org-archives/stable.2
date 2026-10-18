Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05228030E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320385; cv=none; b=jg7Hk9tDA68mQwzUuS4Kg8s0HcpUmyamGUWP1vu6VDVN+95skUbvViGhNtF47K8vRxqrGYwcRPZKKUDkAgnk3lXi4ra4mMyG7No4r7oWOzSwy2gSMnFis/bkauX5muc6UzEMLU8ATJc7m4E/IokJvf7frQ2MvDr397aWjFS2y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320385; c=relaxed/simple;
	bh=kEWxDoymA7MHszQKrmZjRfLNtr2Di+jrlgc4xNhUAG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwCKIK8/cfNdCvZxLnrpbh3SDs0tn/Bvg2DDv/7dVm9rhXfhLujWYuRuZI4W4KNk6povdWC3Q+IOqX437r46aJO1hmUvNRGk2FYi+ttUvuVNxibw2KRbPfhFt2JGvF1INf3ayWRQOLHSvn9yxRJJSqOiNKC2ErXRvgswsPpUFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6CnJ+yy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6CnJ+yy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so166393a12.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320383; x=1792925183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDzT7tmYvszUfdQMD+ETbxumnaTj0Q1RZIImeY9qlcA=;
        b=T6CnJ+yyrmUBYqj1LyDWTEjptLTfUjoPYPmWrjXrAbLgw8eOGkEmJTbrOh/mvx5f4S
         HWfAsRZgxr1J+IcsGva7CogW570a7Qbj6RrOI4su11YbSY+vCc5S4Qxq1de1YbpqD9Fg
         FVi7UvOJQ+1C2ssz4ZwLxHL/6ENZBWphDDYHRId01zVDZdcT3U8JvU0L4ZJsMz9qX9uA
         B9cULbcJ3qVj5qCpfxD1/JBBkhWf6o61us6l565OC/+MXWekWjz5F0tBObTliBa9+mJN
         +oFsF5Xb98HB9tDdmxzs1kaHqKfSG//WioNgKWw8QW6iU+bHZ5oGpjThooQMQhCMK7LA
         64Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320383; x=1792925183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDzT7tmYvszUfdQMD+ETbxumnaTj0Q1RZIImeY9qlcA=;
        b=Z0u1roN9d8VDyU1AXvWEmfADmcGIUsAmEbopkg9QGe6+3QNUh+oLH4kGPT0/a6my81
         ip9LtVUdvD3/fNIwfuj6s+xBmn7ORcQKoxmkfpxhXaJH0Gufkd+ByqS0NHDqe9mBOfkR
         Rp1GlZFNh2VMVzuIyJb6CNaAIISf9j/ylECgdV7zxR9kFzf6O2LNmjNbvm65rOSYOYjp
         d9GRivmVy2FZvdmoAToQGsFjUZiEOg1bs71tOzHBQbcVGLj9x2cdeC5LTx+hbaHrhRja
         O4cGpVmRRY1ruqlOn74w4llYogR6cbJHOR57mti+n8U/nzCqez2sIGZJN7dqjGPUjm2M
         VASg==
X-Forwarded-Encrypted: i=1; AKwUvBxbLGPELBGCv4UtnGnjcou8Wf8YK60SlD/gKwmt1JsvFzeTwh2nwjX8RVASfWcYf1RK0nB4zVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYInBRKsqQfUQA0f2Q1vHg1iJFSgSISR1OxZva7l0KOm/Xk5JDZm
	mf/398etw7Qk1SYZJOaMpNwVwv3lV+MBZQFWwvpW7HvpDZRveeQ3bNIS
X-Gm-Gg: AYBFou3gy81uGLvgFS6VGoPgMb5CwATeraEIa9BEBg91t7i15a7wpdLx1Ev2fdymSKn
	ehTE/2iS43lubw9MiIftdDa6OSzTrV6LfTAp7DHoGRtS/2VlNfU3+Euj8mT+gnm+3G9l6AG2lPq
	8NTzsa6k0dj45UQT5PjNefL136Kce6JaJj0c01r81/FO+n6BgNt4iYSWmygyFGCNfhKNxmGHqxH
	YjZ1SL/tSW+HTKoOAHQBikVvV//Oh24neyt0qMMgc0cRvwxD4qcdPvMox1/XLIujdhf1sxACA4x
	QZLvTrBJY7hzMNl5qZ7pJq0NyZxX9rssnNn23UzLSKoYwDCPGQM14rWzZPch8rzCKlgveuA1B01
	Ko1oA1JINPx/KwJYDCzhNW96/FQsMZRmEu7xDjdEUZLsm3AD2GYLytQw5IhMxBmTtCQ2TWauJXz
	1gAkT0kS53tsAQbYiRt/pkBQwViZIZr7PRGdSy3LGiwrDMgFn1wVXHX/pXAkn3N67h46KpznA1S
	PSz+0moKICshtUcDSqRwH4=
X-Received: by 2002:a05:6a20:3d07:b0:3e2:490d:511b with SMTP id adf61e73a8af0-3e2490d5900mr777312637.20.1792320382944;
        Sun, 18 Oct 2026 03:46:22 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:21 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 0/5] HID: wacom: guard against NULL input devices on successful probe
Date: Sun, 18 Oct 2026 19:46:12 +0900
Message-ID: <20261018104617.743771-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

Changes in v2:
  - Restructured per Jason Gerecke's review: replaced per-branch checks
    with per-function checks for dtus_irq, graphire_irq, and the Bamboo
    handlers — simpler and matches what each function actually requires.
  - wacom_intuos_pad() now returns 1 (not 0) when pad_input is NULL, so
    the report is consumed and does not fall through to
    wacom_intuos_inout() which would misparse a pad packet as a pen
    event (sashiko-bot).
  - wacom_intuos_bt_irq() now guards both pen_input and pad_input, since
    INTUOS4WL always has both on a single interface.
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Tested with uhid across 27 Wacom device types (spoofed bus):
                   unpatched  patched
  KASAN crashes          17        0
  probe failures          0        0
  hidraw nodes           26       26
  input registrations    25       25

Jinmo Yang (5):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo touch/button handlers

 drivers/hid/wacom_wac.c | 90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

-- 
2.53.0

