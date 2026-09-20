Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C19332EBC
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895252; cv=none; b=tIX3q2H2WkaZrfS/X9O0Y5XbaABzRUc2vhjH3fyF5zheYn6Ztf9vlgpX/WuxUZGinEMHasyBy1uz8Lz6hRrYrPZtqxMqz993vpuwbwgw+b1pJNtmVLrajHgiNgr5gQ4dMB1ptwWWYcHbRgvFIxZuzwJ92CSWFcc9woS6x5HbJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895252; c=relaxed/simple;
	bh=kweyCHjSRKSsBODDFc3szHop9BuWVtjvhas8CVH1EN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnLx+DcqKpF6f6AhjMaPyB7LQ9sxnn2YBU9fyaWqQKPjYwkMmlJjAaREnd7Iwvu9633Skp0IWrBSzR1OoGGTpQKL3FmzvuITvM0bVVeZDY/ioKhvF3vTsDbZxv4KslpTTDDRrki3rkGneyK80F3fTsgOAjl9vH7pKTRVfokgMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naboEf9H; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naboEf9H"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso19886335ad.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789895249; x=1790500049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXCcn+GJ+ZcNcE/i0kBtIoCDO7yf3ooucIgFoFAv2Pc=;
        b=naboEf9HWE9Jl/fuVEMcsmi4Kx1QDY1gA5g/uFYPLEezDGeTm7CL9h7D6Zk6L7RFUW
         xLsk+bEBO4uwR99PN5L+tz1/woh1YUuzymH3dsg5z9Te6yD92WeAeP7P3balv0mAH6tb
         zfl1ZbHCUIjp//An8ElHUlN3yxR1ml107Mbk0j0sTrc2Ce6A+JNaUjyHW++2QzHyMQ1b
         Pj8CAfDoLqeoeIfFWltNmaOIbwH6eeDafNGKWhRFyaK4JtXNrmWuvkE0zzZLbrfXeHh0
         jUI1rmo3JDA5un65Ssuz5DPAfnGKR2qBLXWlfPosZqhmwikpQs1MUt3QsMP9S0blATGD
         cy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789895249; x=1790500049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXCcn+GJ+ZcNcE/i0kBtIoCDO7yf3ooucIgFoFAv2Pc=;
        b=Q+1C+gbc/wDcUnqEZN6au26rX57h8e8kcQiM/8WCDm1ZhsLyPXCI9yXAjnaR6xPN+h
         PQ/XBHVE6LI8KXpzanylKbueFC8YnSqfjm5BjIZPkFErcgq9v3ZB4kmRob0Alg1Jos2w
         WiH7K04BZp2IsxACeXYDuSKCJdqDPZ7hZT8fVdCNS/WkIiwIzfTN8A6h4Fd+cA8S66dg
         CripprHkISQZPAT2Cs4t5hF2Wfbn9g8ZpB0ClcZ1APZDjgP8EA+Vr/kQCM60i9WJ+Eue
         cdAXyQWumbt1uyCOsscG/xojDfxeyxoZfLAF31nJantUOXPQb9LrS5ujLeShmADz6qRY
         ZhFw==
X-Forwarded-Encrypted: i=1; AKwUvBwnp/4sVLnGwI4etQ8HIPIIJNWOrs1k+sCyDkHYyE1V2n5WAQr1pL9GKI2NNwbnvfVrMX+0gMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++llPVOfRGLHgSXsnl2S1eIPRNPHXnv8SouVd/gUD5CXCQSDO36A
	jmrWWbXehJo+tNYxpV+RzrJIeaCs7HJvOl5y7sVJGaf+e1OJqlAQ37TO
X-Gm-Gg: AYBFou2rvNyiC1cAFB6bW8il/YtJJRKJlz4tnvvnxbPjMMSk68haf8ynbA8Ll2F8KKG
	vALNIhdXYFZGUnIOLcmzGHcML1nJNg++p9X26wh52PppI6Nr9pLIFExRHbCWfWOO54hLHd0s3Op
	d/paOjT/hAtnYfoKFkOvQzMsvE0T+YKyc5I9dq9qGQ3BuNQOpacXfYXJDd+2DOv/kW2XNo8gi6j
	vkW7tKz8RzFIzI2CFYyEXKPNV/XaqbhDSg7FB6pd7i+0MIi32z2fbUtWGmnJe0x5PWK1iSzCPkk
	TvOiNa7aXCH4TC2EAbcqU/BUA2ZkGea4KTDCDRtDBWEY9MErwQO2rnR38u1yW8gJZKsn3KiLbww
	G6xt444On/2vVWz4StoBgr0O0Qrhmsb+XDE4d41pzUfNA14udjosUfMKmbrETBsgtSCbkuqtTE0
	x4Gozp3xWB3kcearzYZm6O04YFuUj7Ogxw8XcFAFuySlnBax9lycRIM7UBfsCqod/RsdEqMzpwd
	ix0rsR/9z33piaAs7/iOuo=
X-Received: by 2002:a17:903:3c43:b0:2d1:134:b86e with SMTP id d9443c01a7336-2ddb1acac1dmr134634645ad.2.1789895248670;
        Sun, 20 Sep 2026 02:07:28 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.130.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17d712dsm18320445ad.64.2026.09.20.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 02:07:28 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+e7aa19176573a6992617@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: acpi: don't dereference a missing ACPI companion
Date: Sun, 20 Sep 2026 14:37:10 +0530
Message-ID: <20260920090711.300-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucsi_acpi_probe() reads adev->dep_unmet before it has established that
the platform device has an ACPI companion at all:

	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
	...
	if (adev->dep_unmet)
		return -EPROBE_DEFER;

ACPI_COMPANION() returns NULL for a platform device that was not
enumerated from an ACPI node. The driver only advertises an
acpi_match_table, so the bus-match path cannot reach the probe with a
NULL companion -- but the probe is also reachable from sysfs, and that
path does not consult a match table. Writing a device name to
/sys/bus/platform/drivers/ucsi_acpi/bind goes straight to
device_driver_attach() -> really_probe(), so any platform device in the
system can be handed to ucsi_acpi_probe(), including the many that have
no ACPI companion:

  Oops: general protection fault, probably for non-canonical address
        0xdffffc00000000fc: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x00000000000007e0-0x00000000000007e7]
  RIP: 0010:ucsi_acpi_probe+0x6c/0x4b0 drivers/usb/typec/ucsi/ucsi_acpi.c:199
  Call Trace:
   platform_probe+0xf9/0x190 drivers/base/platform.c:1507
   really_probe+0x254/0xae0 drivers/base/dd.c:706
   __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
   device_driver_attach+0xe0/0x1d0 drivers/base/dd.c:1203
   bind_store+0x1d3/0x220 drivers/base/bus.c:267
   kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
   vfs_write+0x61e/0xbb0 fs/read_write.c:687

The faulting address is the dep_unmet member read off a NULL
struct acpi_device.

Bail out with -ENODEV when there is no companion. Every other use of
the device in this probe goes through ACPI_HANDLE(), which tolerates a
missing companion and would just have failed later with a less useful
error, so rejecting the bind up front is both the smallest fix and the
honest answer: this driver cannot drive a non-ACPI device.

This is the only unchecked ACPI_COMPANION() in drivers/usb/typec/.

Fixes: 1f3546ff3f0a ("usb: typec: ucsi: acpi: Check the _DEP dependencies")
Reported-by: syzbot+e7aa19176573a6992617@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e7aa19176573a6992617
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 18286d3e9cc5..9fe4ba43afea 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -196,6 +196,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	acpi_status status;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (adev->dep_unmet)
 		return -EPROBE_DEFER;
 
-- 
2.55.0.windows.5

