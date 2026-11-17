Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915933;
	b=Ulee8w+LU9Jm7ro8jdWbWIwdzK68j4spNQ3T/TfBGdtlebIjEPqc35RQWtouKEkyEEBc
	 s7hjAGmnwFEY3tLvpRCBgoBgLia+9qPIFPnifASBHcTmO+X17f3AbcmNPdTUiFbqj8Ho4
	 +ND4J89Olhk8OsinMNZCBbrlnL77ywCcn7VaNT7Cq0SkRhI2kKyNyLXfVNtsGZDbqOe6j
	 lP4UpdCJaUtv3vTJZOXXr04C7XjtyKlb7hWavmEuDEjk0TWN/flQgDnc0bWS7voMoDeVM
	 LKN2uVq5xLvksZHxXckmjfOrWXFGodIfFMO+TvgyXccxdiwd+tReBq4RtKnglSyaY0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=17Of1ohVlTnK3P4A9jeZWTwwsZHNP9e2kxpo4Cftll0=;
	b=EWc2GC4rND6g5xuaJZo58mHoX0iMenIF4qzXkSVaYKuHm6+QygP6N9yClTE8NNlx3lKT
	 VRl3M6JQBBLPgSVCNovlMyodhZpMgkCpiJMeAFc3HI9x6DjOb79SiIBYrs81VQLe6+Zud
	 y0owNkfrCLzX6hV7r0s0Z3o527bjPurwbYzu3FjiMyw1i7YunzPXYiGgbaSmbaMzqoe4j
	 akIQH5ooOyXB/PzPeMMeb34OPuc/cVqlrQNY4umiyDbFDxkyj5+qbj7394yZs5fbpMSEu
	 lB5I5rI9rYzIs2tS+IVxOkp/VGJfCFn4xr7gEh3r0uvxrhiGOf7N9L7y0zw7HCO4/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=S8I8RmoN;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4844606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4844606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=S8I8RmoN
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c17a1775fcso2908971e87.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794915931; x=1795520731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=17Of1ohVlTnK3P4A9jeZWTwwsZHNP9e2kxpo4Cftll0=;
        b=S8I8RmoNLJKbPWlBsMnp6qxBDKnOAimv5Lv4AbuMtxCxxooienFAIRt7stT2m/7d/l
         5ze9aOCWZ8EMaQOAEdq7w2cEApjUiek0Z4C0RKeamBqE4dR0DY2pKdgGVhUzGxjW/Ucs
         kf1NaE84PL3nA1NwPC82stJux+MbGzMluAmW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915931; x=1795520731;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=17Of1ohVlTnK3P4A9jeZWTwwsZHNP9e2kxpo4Cftll0=;
        b=O6tT1rAtmiCQkdKFzW0BEB+uIJZcHQN6JnfgO2XtK93LaJfRnW2zXm6yL0768fO+Lq
         CxkaO9HAsD4kke0v2aHBWSAAZOIhGct9GHJmAyYf39uEU3DpRUhBrH3K+GVIGiNQ+09T
         wXVPuNYsh5DxNUJ3N/WUb08NYueSBtKabSXwQxp12a8TnyZ/H3d7JPg8/B3r2KKLXUAu
         NnsNIyzaMrF/p0CrCu95te62Gnii5AaYaS9Ju2yw9lX4QZ8nIxfRFvKRowj6/us8XsuZ
         G6rj/R+IUo5GygKGlvjeupVLJ/IkvN1exN0otdJrFs/WqIbfwOTNl1ApnOaca0uejx5R
         tIWg==
X-Forwarded-Encrypted: i=1; AL+hErGCJIW6b9Xo5dr6JP/xQgFnxmdHwh2AYRBTbSk53xM/bRekEf5rYbhWXM5Y84UVLfM3ISx+dbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jxR/C7myPLObXl9qyRkDSBZtlgEer3FY0uDaxnQezu0RHCDpv
	M49Sd5YoyjqHKjYlGiC44XPBLWIp3oRHs8bnRPQCG1x/az1GgMpc12n389MsekAI7+TrNqd7rSr
	snVYKVT10
X-Gm-Gg: AYBFou0+AFjVE4wnyhlu8D3L6K7L2UpTTocK8WNiteVBk0sdU2J6YSXHxG3QjFUKzqH
	6zetDBXaOthkALCyeasSoKB922e0O/8TgW2ejhdVtq9DPztNulKHezRnVyQ2Q3gD0z7r3mmylWI
	Tb+S4c5rVAZySeqWZ+w6rTy22L7eFsqCgLUt5QF+CurI9XEQwtwuA+hDn062wbgHrh6z2Mwd/EO
	mMXatSTnn6NgiqYmLU7zKps4pmT2vS2bpE9JLMXX6GT1Tcdc4s2T2BR0P8iALpgYrv1scVXqIkD
	Yoy3KL9XVmChsM6zdDL6c1yc/hSlskGd8KO/axtsEDbgGLMKoSB2tXTkJHimtlUFRCOxGwKZBDE
	k+Vi/uaaDpDx88q/1Xs450xYm7EzxaaHjJC+u8kIz5DyAC3s1wJLsGCUnQ2ekTc6dcI89RES8Dt
	qGtzMIMfQt3alIvD8BRXj8tYsNbxBKCd5Q8VieInLJb46KG+j3vhJdWS3pQac89RPCDQUzzPROH
	aSt5t1SA6XeJWtlL7/N4sWlXCUL0hSNcMP8GhEQm6j2v3hOECsbBY3005bPptKzSJrAfTgeKJgH
	teCBIKfVJ5yYC05MhjHlIHkb1+LY/4oo7Z0CDIv+rWIphYpKzxMLKFjHd1cN9nvUe57iFQBbTvW
	4JxEoCaW8FQ==
X-Received: by 2002:a05:6512:3182:b0:5c1:5bcc:bf0e with SMTP id 2adb3069b0e04-5c170b1c308mr5151649e87.14.1794915930932;
        Tue, 17 Nov 2026 03:45:30 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712d9dd4sm3955141e87.7.2026.11.17.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:45:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: uvcvideo: Fix HEVC formats for DJI cameras
Date: Tue, 17 Nov 2026 11:45:24 +0000
Message-Id: <20261117-uvc-dji-v1-0-7cb3cf3b4b5a@chromium.org>
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
X-B4-Tracking: v=1; b=H4sIAFQ+/GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nz3dKyZN2UrExd88Q0C6PERFNzIKEEVF1QlJqWWQE2KTq2thYASjd
 ud1kAAAA=
X-Change-ID: 20261117-uvc-dji-7af82aa572aa
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Jordan Moormann <service@jordan-systems.de>
X-Mailer: b4 0.14.3

DJI cameras seem to have incorrect descriptors that do not set the
compressed flag for HEVC formats. Fix that.

While at it, fix a nasty warning when the buffersize is 0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: uvcvideo: Do not setup queues with buffersize 0
      media: uvcvideo: Force the COMPRESSED flag for compressed formats

 drivers/media/usb/uvc/uvc_driver.c | 20 +++++++++++++++++++-
 drivers/media/usb/uvc/uvc_queue.c  |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)
---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261117-uvc-dji-7af82aa572aa

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

