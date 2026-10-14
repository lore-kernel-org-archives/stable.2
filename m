Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD423E325
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005580; cv=none; b=UMBuZKEiOO77vuj0C9Xl0dmxgGw+kyCmd+cRXFpIVXkf9Wr/ioUATivDxnTfU8pVdJJHGoQ3pqszaXLyBy/dn+ZMJnUfQDXjWAkop/G5Bimpbyqi1OrIblio2JUb2iqagl3wRl0Kg7u0yEFBI28nfz114BID/NbprXTjhDfW/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005580; c=relaxed/simple;
	bh=QLHD71bG8sWEFx+QTSTbN2i3igcwCws5mkcWYxMIzWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMNKl50e3Tj1G/3JXeHxIBUZioYlLsYlkk7pC0UaasPJGTXuKPjI76DtYrh8TV2hs13ucGXj71F5XNrmOmbZdhkYiM71+XPdwQRnB0Mu0tUE1DIlVEg4S38xoO1H72fQ9XMaefLZeatoTkyL0j5DPKejO0pnkgjwNgFumVdaz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YSqAXqtc; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YSqAXqtc"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so3743736c88.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005578; x=1792610378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EolNk2P8cfuJX7YBRRAXbmqx1FX42TwFCmuMkfr/YQE=;
        b=YSqAXqtcgt/BwzJe67UkG96OZH2R0ugMLGLyzn6UztMv9K9JCUSFErK+yEeNG0OaAW
         RvKUnmgZFpvsxsQz54VuczBDaLs0Nkcyz3e9XdQX/QJcbrXaF7Pelk4sL1v8vMWLeDPl
         867OxJwFrGEIyLO1BzaePuS/oz61rwXCp66XM7jkP4XHEIbv+f7z7vRJ6z4qX1uSxOrV
         Rq9OmfYDCwbsGGB1015wz6CJAeuWQNGgi4xEUkT1FkprWNTs3Xs4+O8VJ+4JZ3bSDzTs
         j/sUDPURMHf8hDBuFf0Ks/Jj68vxDg25DMxSf58mrnAyRzLlgE8VnT3VJOvHUXUI6Qib
         jRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005578; x=1792610378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EolNk2P8cfuJX7YBRRAXbmqx1FX42TwFCmuMkfr/YQE=;
        b=2iEhmAnHtQW2eGdHU/xyNxq1dsidzr01TN2QVTYPznD8B5/QpIlmzpfjNMoHXoi8zC
         g7ptrb2Z1238XzplRhO3ib6rajRppWtGSyGN7d/KaLePoG9hJxLrzaaLkQ0CSTXY/6oe
         so7ErmPlcA8q8EO8RUEniRYEF8A15f6htIq7vVg/slIZscudShhMiaw3O/G0L9tPwtT2
         MBC2COW6Y+0t2Zo8MNAAV0QzZlGd0cJUjTCcDkvoiBgO0CUVpmkNMHAy4RmLc7R3upBu
         Ojc+0ozUjaEkIFl3M9182T3it3ccFZtN6LamvHN1i4+blBBdxtbfrErcIM/TNpRXixnn
         GRUw==
X-Gm-Message-State: AFq9FYJl9DAKuJbSKV+JJVYRwViOKeRix9P12C6DVLHa9rF9RosLhF+9
	pCF5rU0crFXk8k8iEevZ1FeFOmLRwP5aG1dOG+B5qdXsEUVJedtvi1x/YBqVY5mbJvLUkA8rBPI
	kabrYi2Rung==
X-Gm-Gg: AYBFou3dU7WSaarhJIhkHknpibQClahGt/gefdRuLWuoKiO30INA5fq2b3C+ZhNfbJw
	3fn7wc9U/gR8diMwzhshhoaUyEk0CMQXJN0264hn9Ad5yh0NPYy4uyvfaQWN/mGej2Ra0vFc3PW
	ekJ8SW1m+1q6Hthd4SZTkT1TJcBkNJDhBUhh0DVsZkpD2++H2YpwUonsuYkfgZ/iV296HzdNV2O
	AvD/4zLiALj3wDz9b5VKOqxPrYgNuumS7iNPCR8GjiEwfpICML9eO5U3vErnlK/jVSE5SaXYgLa
	DOEINo7u+q84/kTkKiQVV1Ti2iPUbRGZz2DyjmBedgNMiFHuMXAGS50H4YR3o8kYW4SOjM/b6Rj
	w8s9N6wIGtIefO5NGhUU4R9FOyE7E1XZq/kZ9SyJAV1eIqBMJlPj66UDggGjMlyGfi18fjQCL6Y
	neAWiqws2iZrsd235XHnndHN/MHo7k58jEEngWIeScOJmfo4obgqZWA+IcBFiZYrKs9xVbEvl9I
	45CRgp8BqtqSrgxsmhrVY1saZK21pkfVkjNyTmWSQCTP4SHVPL159GSa1R2/f5BlVMnBnPs
X-Received: by 2002:a05:7022:7f05:b0:149:49c:22b with SMTP id a92af1059eb24-16a57733270mr21122525c88.1.1792005575832;
        Wed, 14 Oct 2026 12:19:35 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a620bdafsm65121744c88.23.2026.10.14.12.19.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:19:34 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: lenb@kernel.org,
	lihuisong@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lirongqing@baidu.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org
Subject: [PATCH 6.6.y] ACPI: processor_idle: Mark LPI enter functions as __cpuidle
Date: Wed, 14 Oct 2026 15:19:31 -0400
Message-ID: <20261014191932.24129-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 956ca5d72c76504824c8eb601879da9476973e15 ]

When function tracing or Kprobes is enabled, entering an ACPI Low
Power Idle (LPI) state triggers the following RCU splat:

  RCU not on for: acpi_idle_lpi_enter+0x4/0xd8
  WARNING: CPU: 8 PID: 0 at include/linux/trace_recursion.h:162 function_trace_call+0x1e8/0x228

The acpi_idle_lpi_enter() function is invoked within the cpuidle
path after RCU has already been disabled for the current local CPU.
Consequently, ftrace's function_trace_call() expects RCU to be
actively watching before recording trace data, emitting a warning
if it is not.

Fix this by annotating acpi_idle_lpi_enter(), the generic __weak
stub, and the RISC-V implementation of acpi_processor_ffh_lpi_enter()
with __cpuidle. This moves these functions into the '.cpuidle.text'
section, implicitly disabling ftrace instrumentation (notrace) along
this sensitive path and preventing trace-induced RCU warnings during
idle entry.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Acked-by: lihuisong@huawei.com
Link: https://patch.msgid.link/20260616072617.2272-1-lirongqing@baidu.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Assisted-by: LLM
[ Backport to 6.6.y: Omit the RISC-V hunk because this target has no
  RISC-V ACPI LPI implementation. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-80611 to 6.6.y.

The code changes are identical to upstream, except the absent RISC-V LPI
hunk is omitted. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: the x86_64 ACPI
processor-idle object (allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/acpi/processor_idle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d755c266e3586750968ad7c4e01c5538ceb631e3..5db34356328c7e4e62b30fb53fca375e9e7d972f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1175,7 +1175,7 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	return 0;
 }
 
-int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+int __weak __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return -ENODEV;
 }
@@ -1188,7 +1188,7 @@ int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
  *
  * Return: 0 for success or negative value for error
  */
-static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
+static int __cpuidle acpi_idle_lpi_enter(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
