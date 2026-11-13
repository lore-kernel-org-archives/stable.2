Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589149;
	b=udfSBzaVqwmrrAC5ZzPKtP0EfhGhzP8RtHRYn4GLVBdx/JPstI/jHQL05WAzsqg0g9jS
	 nXK8Uwiqj+gofFZbCvWVNSiCFJioOD9cEvxtpZQHeFf4XNYbT77xdt45UQXr4yAa5wib8
	 j00lDJcnNzspakOFb8DVaxYIe56L+aRCG1GX/1WxzDQTYd7XiguOKkb3ol+9V/9CO+g26
	 9M6RGi4oHg85po5jZgujo/WZAhC3xaXDtSjIkT0SJicRkVZJKtkFLD4ktiXsEFiurlMSG
	 5elOPC8aeaQIDCGlQF97O3Mtt2Fig6FPfty0ZdlXdtYbEZUWJh1PI/fjOF7wG4bVS7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=wWKLrEWMGJV5gAaQRsC+1zZYCzBP812But2325DrUA8=;
	b=hwfd3jv1Py2fUFj5HyNNPcakFVoB9GuXD2EJucATVsbQVMKYsXitzdeTTPkz6+b/MDUd
	 Hd19GXNCW4TYk8onmfKCgo9nStGO6LVFUrdcb4cdy/gtL6R3cJuZ8snX4+yPInhmpEJGt
	 2Uo95KsxuGY8GW8aYXH0XMNBUaH55oEfJCbOVYHOnnLlWktrMxsBP3tsSBAVi0UdXfKWp
	 KHu9sX+Rh+aM4h3UfyErCnJIpyPIM2NKf0nG8HGUEUnTUxnooE0jm/lyqwdozLZ8Ek8g+
	 fCKOxqyaLQyxCwmrSbas4wEDAFYMZtwZ10WVjozeHY7P7Kizx36I7h0TnHTf75tU4iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QrDwwJDO;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CF606A8BC
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747CF606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QrDwwJDO
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1281796c88.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794589148; x=1795193948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWKLrEWMGJV5gAaQRsC+1zZYCzBP812But2325DrUA8=;
        b=QrDwwJDOKRtLbXSnaDJzY8XMaJzZIUE2M2WVP7+Npbxk8150MXK5/ViY9uGelT9kZT
         KkRwH9sVgiZibXNcJ/XPxdJVytXKuDxntXNy10d7lz3XCM8L9rGM5XUfSXENFmV7mOif
         aoYiYEBbAB2Wq4lE9USkdn8+4ZYttt6E6d4Teyy30e/5lbKgJZ3utr0lpmP2z4Viz4D9
         m0Z/khf1zBfHOQd8eu/mOxOXC/UTbmBh19CgIdxRXC6PGmZQIP3lV91kvIyn8dGdAZVT
         w963isxsAAhoh2BvGYO9EQyOSmjRXJDGIn/TgBycPCU5SPvWvxSRu777x16cd9ZyTEy/
         en+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589148; x=1795193948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWKLrEWMGJV5gAaQRsC+1zZYCzBP812But2325DrUA8=;
        b=xw42dKVBhGr50wfZ7ZetC5klMYu4DolX4maRojz4jApwBdbKiYk38rngsGdUzwaFNb
         IhQT2bU6G4qD1Anuugn3ABEz5Y3ZEDSOKyJfGlGLCBRX/f13SGY3Yu5dhAB0f+F6yTwZ
         VTx1TgZJ/GtXYI3QcO6pj5VCDEJLvSuenuJwu/rhUmsf03QQZGCZ3lNeRojxKWWUxWk/
         vqDh5u+GHVH2ZbH5YrOjDnrXoSpJgghgGxingAfADU2+yXXfEgL6RY+/z1fWdoJ14+uL
         qfqGMEbGZFKpx8aXlziADA6JQt4e5jA5NJqajPLpKoAm2V+/VXWeFTIMNK7KheZ0gPDm
         y91w==
X-Gm-Message-State: APuU4Z+b5Z0mZtOrwa9bcRqkNQOv5k7rPSkDaP+uvKYnosU3piK0z8Af
	IEQoNEpknpavwXamk+rUXCcHmiblLyjZft3DJCcyaiBV92KNWw7Uvgo8uyLcNHAq3Gfif5lYJ9J
	hj4/D
X-Gm-Gg: AYBFou0qjotL/WqRv6TZHF+seDVOANh0JcfNSwnttN3R1LHk7lfhm0EkgOTl9+SQWMY
	6JfLuOzYODvUFTLoIzOFs+mCKAgzMGY5Nh23wqMSEghknyAIjT9IVbMMTAc/SUxlPrH66BskdMr
	NfMr5Ro4E2AkPrQSqfMeDS08iocqN6cINKtVj1EVdzIiNMML4Tv2IYIvt2cbi9P87ovhqyij6Km
	4fCERYtLOVwCtUeot/XYcLOnUI5NTIUhcwK0UEX4tX4a1SkjYx5peYessnBphTNoieQZhGhqCKo
	yLWw2R90qEozI8JjslLm8CqZEgB1ivGg8UC8M3iWpFMBs7dSqQsGHh7GEgJuM2DUSDerEU7fMiG
	suvLxKWja1622aTWowRSLtc3ChbzcYw19qDGL0beYIOUFPDwuS/bBNbcCEuB7EcYtiO1KYroaed
	wM/RRGnJH5IY7FcvORFtd84wtkOO/ig28LQ3BqTQDA5HH6JQ9JgHYsZB4iZV7xTSEjwNcYQZqAa
	DQ2xCKTftFbx6UoQDJqxANa1BcRrUsQzIij9cBy+O9ivYD2Pk5M5EEPqgaIdL7j5zm0KrMBlHp0
	zZlfi+6rguEDqg2gIDOnTg==
X-Received: by 2002:a05:701b:290a:b0:151:6e80:ba7e with SMTP id a92af1059eb24-1b503055016mr2597391c88.4.1794589148398;
        Fri, 13 Nov 2026 08:59:08 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm9575018eec.28.2026.11.13.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCnigJhj?=
 =?utf-8?b?b25zdCBzdHJ1Y3QgdGltaW5nX2dlbmVyYXRvcl9mdW5jc+KAmSBoYXMgbm8gbWVt?=
 =?utf-8?b?YmVyIG5hbWVkIOKAmHNldF92dG90Li4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 13 Nov 2026 16:59:07 -0000
Message-ID: <179458914687.43517.5782814715256884169@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
‘const struct timing_generator_funcs’ has no member named ‘set_vtotal_min_max’ in drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:389:28: error: ‘const struct timing_generator_funcs’ has no member named ‘set_vtotal_min_max’
  389 |                 optc->funcs->set_vtotal_min_max(optc, v_total, v_total);
      |                            ^~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d72c27ecd45b038815c219703c7953b8d449eefe
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a320864dd7e3be8aba44919f934c03e20b015e0a

# Builds where the incident occurred:

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6af738a65b429d354e4ddb13

#kernelci issue maestro:d72c27ecd45b038815c219703c7953b8d449eefe

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
