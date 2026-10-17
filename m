Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FE47F784
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247913; cv=none; b=kKpYWNa8xYjtszqv30ofrupF2Oz43MEYCZPUu8gLF3Ibngbs/9XydoJLjHYzz2rSpkeJXy/rbzK4huEuF8cM9/H8DETr2NZpyI+CglMAeesQ7f/p1pZ8ngNJ27r9pevDm+XYBP7aQWqExnkXBr2vghApsdxhANANvMSL5m9UX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247913; c=relaxed/simple;
	bh=Z3NdKlWVlqAPME95Aop1Z/FVVgK4zViRb+bOxx34PFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D12CFWkhSwvXl3tU4mZo8Rno5ZDdQIiZo20IoCM9pCh5ikW1OcC56fzkXVYQ2nvpGQVCW+GVNBXqH3ht4IriPIbrySTNwauZjQUV3YkDoaPAxfFCQjc6Vgb/Qsc1Kltm+0MSCR73qQiDATidNXNALs4NcGQzX09XcWw3KFhf3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlkJVeV3; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlkJVeV3"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so2097891eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792247912; x=1792852712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=omiuJv8MmcCiww+ZKW5+WdH4aNs8y923/45k9gUA+w0=;
        b=BlkJVeV3eMuFKCt/XXbJy4lf36A39tyThlzudex+GVxyzqgJaSSGGzHWD6xNZ2v2IP
         aHy3ueNTjT5hq0RawjIqHzwiT09WYNOY7MhK5XBRodV/7o+V8cDIjsKJEjf4zORxp3qA
         awBXs744HsWNhW9dPa/wO/kVXaoFVTZmcx+EgEFmtgmKdVuZRZKM1+3dVrqVNu9sW1kO
         aiQ6bFpqw1Ylip2c/ZyTNDlrbD6LGaK9cEb70ZeNDkPVZ1+XRKp07V19tIDu6nXf+4vR
         f3bR5/lpmi2OfoNItNAH7pByaPOgd2KiWcbVA5bTBbcsbn/rvWpknSKN8ltCTz/L0gdt
         RpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792247912; x=1792852712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=omiuJv8MmcCiww+ZKW5+WdH4aNs8y923/45k9gUA+w0=;
        b=2UyLGxYJpuKJKjPIiM9W/c3yv+iODx+gIpLeaqoIgN1FaDTekHStfit2g9bXtzDt9Z
         63Cy6k4792WHKWTCYxbShO7Q8fiyqyWy/rPzsn/O4Bx3c28Q0XZySBEZIl1xcYCrLO8k
         h73TEa/CJimcr912jmkKSitI4+OkfcotBf4iHqAp01XUwEH4UWEPhj40NccDwS/TqsyO
         D0vx0A/JOavVZn/JzI6Ns3TIHyuqqcMgQqy/Itrr1xvAm9O5CDFUFZ4Fuze0tRVYmOnb
         Ny7gt+InCXpsYQDcdDOBrXqjj92yo4+wwDBh19E8BhJkHhkTvvPJ12m/0ES3561W/TNx
         qhlw==
X-Forwarded-Encrypted: i=1; AKwUvBzDppF5d0AkeDlR/nvrtoXjAjIoHbzx8O6OxU+784vPoQJp8AlJ0c7zwmM390kbhgaApFk8EQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJorE8MBR7LQGbdos2RgXxQ19iYma2nis3ISCAILsoZN7hH6jZ0
	84qxYBaMdaMsYGDYjHxE2E/zh/3EXgMvbCoo6x1P8fRC48v8BlMxHOrk
X-Gm-Gg: AYBFou2jsEKmPbNZVstgiYLn1KoRAwg0BdIsVWmYA3OvjSvc1Z96zePfacqgCxE0SWS
	skvYk6+zX1bLbDGgvvpnewfGNXKqq/ozmLPgsaXMyFPjegU78AeWtpx3aVLKUgRmgmnIfFbmm5v
	V89bFQQrvsn65O6/3WLKiNYzJazfNuHZQ6k0pI7g2X/znCH5KZ0K3fEgyu08qFAN7LIt+TCalcE
	GyFcp0InIEzLHcxCGXEhNyNAkuvyV4QV8dTivaGd4x7RLubBkBJNAD4Po60qiKis8fJbbGuLzEe
	WZPJ9EM3wIEJRlMff5Z6Guc+Ivo4+1ko41Ls+n0JdvE373XJF3BT9Kd9tVjYmATFV5KkYU6B7L+
	vEYWHaDNKSgLdqIPeoouZFRdVmVHLDSc8poi31EOzXa/gJeh5u/kCFNlkSsEh1E2T8lB+6CSQHJ
	sl9XlOTmpsrjmE9WmS7sLcFsw5n7f0Mb1Z2EZSt2s8r0tk+/AeAUSaHnakMkqw
X-Received: by 2002:a05:7300:880b:b0:361:7ab9:47b5 with SMTP id 5a478bee46e88-361a2e393c2mr5031610eec.36.1792247911459;
        Sat, 17 Oct 2026 07:38:31 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm26652075eec.12.2026.10.17.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:38:30 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v10 0/2] HID: multitouch: fix haptic lifetime on delayed input release
Date: Sat, 17 Oct 2026 11:38:08 -0300
Message-ID: <20261017143810.1567677-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9 review found that a non-multitouch touchpad report can precede
the actual multitouch input on devices using HID_QUIRK_MULTI_INPUT.
The first report could take the only FF instance and become populated
solely because FF was added. The multitouch input would then lack FF.

Patch 2 now waits until mt_input_configured() has identified a
multitouch touchpad report before initializing haptics. Only the input
that receives FF gets INPUT_PROP_PRESSUREPAD from the haptic setup.
Patch 2 also uses scope cleanup for the cloned state and all of its
subresources, removing the mixture of __free() and goto labels.
Patch 1 is unchanged from v9.

Tested on x86_64 with W=1: built-in HID objects, a minimal vmlinux
and modules build, and hid-multitouch.o with HID_HAPTIC=n. QEMU/KVM
with KASAN ran 10 virtual UHID haptic cycles and 10 multi-input cycles
with a non-multitouch report before the multitouch report. The tests
checked FF_HAPTIC, effect upload and playback, HID removal with an
open evdev fd, and final release. No KASAN report was emitted.
Physical hardware was not tested.

Base: 58161ead29e50d70a317ea26b472e0c7508e69da
v9: https://lore.kernel.org/linux-input/20261017140332.1480375-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: make FF creation the last fallible init step
  HID: multitouch: give FF core ownership of haptic state

 drivers/hid/hid-haptic.c     | 161 +++++++++++++++++------------------
 drivers/hid/hid-haptic.h     |   6 +-
 drivers/hid/hid-multitouch.c |  36 ++++++--
 3 files changed, 107 insertions(+), 96 deletions(-)

-- 
2.53.0

