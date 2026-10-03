Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830135CB60
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036576; cv=none; b=tqDi+KuT8We3EDDXKibPdhQRFovZ6t3+8YU+Ly040krNvIZd8duwegfT2LsIbb0Y4ZOUgqQjjDm4ME4zzboScQx7228N059NbkVkP860sYjwT9x/FVWcmQ3wpNsGJAgSOCZEXuwrbepnyZoovBgAVs+16VPrAmPWFKfEOvIux6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036576; c=relaxed/simple;
	bh=1XZ7TNWfgxPyHv3AyteAH4oittq3DzFQwUq/QtfpCP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOCyykA261jZEaq699/LJ2vcOvUSMwVr7Xyv/GL4txEz8Alh/2MoGEx6jJYlwo2d0XukzKDkeT8gFRdFCjWP3eQICQVi0G0egOPP0hNuT/9HcxoNftU6Vi7CmHlbO68y7Kvf9/b6RxXeZ5XhKHLKFD+08w3attuJjXbzcuJ3cRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEDRruvp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEDRruvp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so5858605e9.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036571; x=1791641371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUswOxapHow0y3byrU/sf0EaKU74JMXEcnoMlCfceto=;
        b=kEDRruvp7vLoG4+NDDl8Nb3gOSNj7Bemy8+9rXKyBwh3XjrajR0aAFGdxO64tzgXJ8
         YsCz4Y4Z3ceKbxS/WHU93mI0fcQTX3YujeWxOJ+GYD4DASann1VHX4ZfbWTg1FPAaHdS
         YbOsyJn4co20tK04HHn+5TJW3vUWSS9nqYxcEruD+j3tFfv6IOs6DuU2bm1qLOD38nkG
         L0OzXRw/KlzwwfTl9qzaMiIRHHwSJnh74xsq4hUexN40omxtIyJholpgGvAnFLzXa5Qy
         fDOA1kstYZUqi7oqtVkZO9fYzr8tXEn3j8jRZ1AyDwbxDVzC0UjOG9UcuRlGhoG5KpbH
         kyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036571; x=1791641371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUswOxapHow0y3byrU/sf0EaKU74JMXEcnoMlCfceto=;
        b=2EHNxLJTiPhK0N8+Is2wg8dB/tvWlhQsodrVcsHPULiM6XRTp3PIUjFrI02JIEQ2B0
         RXwMtuRRJ6Mx/YqitE0NILl7cGA+See/61cEGtDd6FSltfmGA0hjt65EL3bY1BPyUTVE
         09Vu0W0kFjeaNrvyTtMtZYplh/G2X6siS3Bm/jCtvjUiZCsjr32+f6gE6XUp4fbGPYAQ
         NlBjQ1sEQqf5f112APQKH9+ngCUlDT/wWhl1x4pVsMBtT9pBIl84xKTGgliPELp4xOjW
         loJFg+vwWQTqqk95ySuh8t59xqYdJqJr9ZruFxtqRwh57ZzEd0PpiCjEakarkKSoQEBj
         VO8g==
X-Forwarded-Encrypted: i=1; AKwUvBx7TmtaPiTwo6bVKywuCm2esEdSihAZGjs/PYdQVkNCuG+a0mJ5g9m3O9HJsy8gUrUDdJyhkbw=@vger.kernel.org
X-Gm-Message-State: AFuF++k6dCHDeC2xP8nLrvyQ1TPP6O2LJxy725l9AwUm4KKV+NCOVpxq
	v4z87Z7z3qED+i20Q2UaouFZHF7U2v1UMFav6T9BGaidr4IXlh/2eEzfrOWOJwjO
X-Gm-Gg: AYBFou0lpojXlL4r9rcyXn1E9t8eZNBWBtwNE4c4nKt0f4Lxc445WjJPEuSIhV0190C
	ixT65DqfsnewmsRzpFKkXDQpM87GxXrkDsrOkCQKFQHBlbSnnq64bUatL/U2WU6lymWs66qhzG8
	JMJdI10Msh/Fva3eHjzuFoReYYVMpR4d1pAnhy1rMuawEhIy3AdPUdNU8uk0XmRZJhr/B1F6U6O
	Rtd99HFb2hORm3vbX6RfsqvwyB5V2u8Y9c/xoy5GSQkYiiqw4hJm1dLw7gQQW8X9ZIS9vXwvQPc
	fwEEjmLdRbC54Gtuz5KzA7zllvvRQmsQZHuO70Vp0wwBwMunEzzRPtSMEgN7/Qrjx8NaIzVGLYR
	wmiEssXFSDKoHfiqydRf0CT4gxQa4ByS4Ec7IKdqVZvbwKOISkMS4HoqdFQehKlZUUHEJ0WSiUE
	kY7JMLveMDfNLPYQwzRZz+FpB/VWyuAXrBi9VkYZeTItNc7rmw8fSs6+IWtcWZ0i2TeB8ge55dF
	KTsYZ22qQRfmkM+sCkqQKFpKJW1RfnHsu2GeDaUsNXNdu97eeE3PbZaNpfEN2vskxiKiRlzOiw1
	AKfhnyZAwCUPbv3GLC9gOFbLossQfWd2euR3QkqIGYEotpup1MlqslasoHKDTkIcmh6HSOrvZge
	sDQ==
X-Received: by 2002:a05:600c:4708:b0:4a0:dca:b78 with SMTP id 5b1f17b1804b1-4a1680f4165mr40509335e9.27.1791036570603;
        Sat, 03 Oct 2026 07:09:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Date: Sat,  3 Oct 2026 16:09:13 +0200
Message-Id: <cover.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting IRQs. A late
IRQ request failure leaves two lifetime problems in the probe error path:

  1. In dual-EMAC mode, the secondary netdev remains registered when devres
     calls free_netdev().
  2. A registered interface can queue rx_mode_work that survives the devm
     allocation holding its netdev and private data.

Patch 1 tracks successful secondary registration and unregisters the netdev
on the late error path. Patch 2 drains both interfaces' work after
unregistering them, as cpsw_remove() already does.

Runtime validation used a KASAN-enabled ARM kernel and a local QEMU
Arm virt CPSW probe stub. It provides one or two fixed-link ports. Its
device tree assigns the same non-shareable SPI to RX and TX. The TX request
therefore returns -EBUSY after registration. Test instrumentation opens the
relevant netdev and holds its real rx_mode_work until after the forced
failure.

Each result was reproduced twice:

  - Single EMAC, original cleanup: KASAN slab-use-after-free.
  - Single EMAC, work-cancel fix: clean poweroff.
  - Dual EMAC, original cleanup: free_netdev() reg_state BUG.
  - Dual EMAC, patch 1 only: KASAN slab-use-after-free in eth1's work.
  - Dual EMAC, both patches: clean poweroff.

Build testing used this series on the net tree at
6dc989ea46b96ce170840174b4a38c4a387fb005:

  make ARCH=arm LLVM=1 W=1 -j12 vmlinux modules

Clang/LLD 21.1.8 completed both ARM builds and all enabled modules with
configs derived from allyesconfig and allmodconfig. CONFIG_WERROR and
resource-heavy debug options (KASAN, UBSAN, KFENCE, KCOV/GCOV, KUnit,
kallsyms, KGDB/kmemleak, tracing, lock debugging, and allocation profiling)
were disabled. cpsw.c produced no warning. The literal allyesconfig build
first stopped on warnings in untouched files promoted by CONFIG_WERROR;
with WERROR disabled, its instrumented link exceeded the test host's memory.

Testing on real CPSW hardware would be welcome.

Karl Mehltretter (2):
  net: cpsw: unregister secondary netdev on probe failure
  net: cpsw: cancel RX mode work on probe failure

 drivers/net/ethernet/ti/cpsw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.53.0
