Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08FE35028D
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045130; cv=none; b=XO8ASKt7OmD7NRcArcPm0w8oHOQvLubzTNzIiDML7ZifWarfNrXa0crd3bTbppw9gVYiv3wflKR3KkadtyqtlI61v14ArCmv3UaEiffcX3oPwQGAObnN7ki+6m1GcEprZTCfQn8HJqgh20zukCaSzzEIqeieIOqmJlDtlhx+jDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045130; c=relaxed/simple;
	bh=IhE3164pqnwDVlrLYLS5DuRzJZYRQk1UwOmjjl318Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iChwhK08kDdZ6myPZg5WfxHtgvbpY2LO0YRo4B5EDGetgEfTX3gWSnJR9Je5dtgMDsogUN/lwduNvSlrb9lebVUATbE3OySIdnrX4+40/2zlvyvMxuvOcRgoUVSqDE/2uNWzT0grxyx7UrWVikLTNEHx5bNKodSz78lijOrW+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzDPfKwu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzDPfKwu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so2271385e9.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791045127; x=1791649927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArphHShfkBLQGM2MhWD9bg0FR3KYRMbbt9Y3FJHC1jU=;
        b=QzDPfKwutN48jYPIWv8nCEEFmyln03RYaeOVha34Z9E2j+8Us+7OlSHhJuqnOYbkLR
         MXB3w72Uaj8MxkPAw/ttTV4Qqt+zUyAgmIFVqVx7XHVzRNcR7E4K9nVDhkGHL1tuuF6y
         gwGifsvmBGH3y5A8ip9s1RiEd4pg70nx1l02ewCU7zof5W40xvL9+fZ4DLPNlrESB4dz
         nsbsKv4VBYvM0bmhoBJJEyCEMl94jZrYmhdlV2cs3dP86LtiZ41MW5ABrwsF/msa3nXC
         mCa0BGl0KSQsvwySlSqHyE0SpqmtOJ7veN010p6dDziGvmjTZaN+7t+T9D0BzuFArLcM
         zcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791045127; x=1791649927;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ArphHShfkBLQGM2MhWD9bg0FR3KYRMbbt9Y3FJHC1jU=;
        b=Z5GxC+/oen9l1jY1rD57tdwU268pzrkS7ukwC2fMVjaRhZIc4xI+6+ast/fJt50Cma
         0Y1hlyqiifQul267AesC86IRilM3svwPCJqHoBoCJaj6zfQ72VnTGrErh3o03gqCzBgp
         UiecfnluvVfw9lk8wdcB5hwj26rL4WZFlz5lkOcsOR/+52kOhomS0plaBWsiLX445fkk
         KOZ+mYtRxkKZkNtc/zsoNc6vZSFG8p43Mw7/baWKpRvM3wPhGZc6IgnJXW4J8gT0WA/4
         lcNujR5IA/H926LmOTtc880N/QttDH+0h8V8/xs8hJon8d1zqQbzOYtI5+EFdIIacILc
         f9xQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIi7Zkt/gw4a736EUt4rJsJK7VFnesHyJPr3DcnJuPFCJdaQPg4krfeEah0UWaIw7l7CII4Tw=@vger.kernel.org
X-Gm-Message-State: AFuF++lRNbEoJOXo1WelMMSVb98095KlozKRN99OQOclPrfIVQ16yyZW
	UNZZ1CxwvNVJc2IDBJAQSfyWOlfuIJaOawzHtH/GlV9jNk2CWf8P+NoX
X-Gm-Gg: AYBFou3eDKs+uv1cSkzB+N91h31iu8bMTsKbejI2cZDZG6hp59qLqZpp7XQFQwveZVw
	0HPXHFy6oJErCpz6de+TVbB+is/UVzkrTiKOgrwoh93V+kSpFUTqxK9ggtotyIubiAdJ8ACUBb/
	EdaeXMnuDJDJBv3Zb3EOb14H2OoicCJBYdOxzJ4ayDyqYDzUXCsHGGas/8Wpi6g88FbvzmpIdNM
	AM7ZUx02vjV/pFIfso7k6gkxiP0TWIoi8qLQLT4VYs6YBYLo5WFxqbhS+7TStFzCAkxtiH8iElj
	7ltWooVuErTMy+h3xAeg7E55XxtgPD4T53nUMtm5tH/soX4hAcKYUVG3KopGxkgTl1MIWf4Ifdj
	3Qn7ljvKeVfmsxq0YK/JElWnaIyqGtIAB9O6uwjr85U6midZTMBk216UuzEQ+m6JeaN+mubjmC5
	DQCS/W93xrg85YBJ0VEWE8YqKNDATp1IjpTxvz740hUlKaZKsgOPMRSW8MwTUzjQFpmw==
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr105166935e9.3.1791045126570;
        Sat, 03 Oct 2026 09:32:06 -0700 (PDT)
Received: from fedora ([77.92.21.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm174308795e9.4.2026.10.03.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:32:06 -0700 (PDT)
From: =?UTF-8?q?Alperen=20K=C4=B1l=C4=B1=C3=A7?= <sabri.alperen03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alperen=20K=C4=B1l=C4=B1=C3=A7?= <sabri.alperen03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: class: Do not inject sleep time without a suspend snapshot
Date: Sat,  3 Oct 2026 19:31:38 +0300
Message-ID: <20261003163138.14221-1-sabri.alperen03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rtc_suspend() returns early when timekeeping_rtc_skipsuspend() is true,
which is the case on every system with a persistent clock. old_rtc and
old_system are then never written and stay zero.

rtc_resume() is skipped under a different condition,
timekeeping_rtc_skipresume(), which is only true once
timekeeping_resume() has injected sleep time. timekeeping_resume() does
that if a nonstop clocksource reports elapsed time or if the persistent
clock is ahead of timekeeping_suspend_time. If neither holds, it injects
nothing and rtc_resume() runs. With old_rtc and old_system being zero,
rtc_resume() computes

	sleep_time = new_rtc - new_system

and injects it when it is not negative. For an RTC kept in UTC this is
about zero. For an RTC kept in local time east of UTC it is the UTC
offset, so CLOCK_REALTIME and CLOCK_BOOTTIME jump ahead by that amount.

This happens with suspend-to-idle on x86. The persistent clock is the
CMOS RTC with a resolution of one second, and the TSC is only flagged
CLOCK_SOURCE_SUSPEND_NONSTOP on CPUs with X86_FEATURE_NONSTOP_TSC_S3.
timekeeping_suspend() and timekeeping_resume() are called for every pass
through the s2idle loop, and when the last pass freezes timekeeping for
less than a second, the persistent clock may not have advanced past
timekeeping_suspend_time.

Seen on a Lenovo ThinkBook 16p G5 (Core i9-14900HX, s2idle only) with the
RTC in local time at UTC+3: on some resumes the system clock jumped
three hours ahead and chronyd then slewed it back for more than a day.
A kprobe on timekeeping_inject_sleeptime64() shows the call coming from
rtc_resume() with a delta of 10798 seconds.

Record in rtc_suspend() whether the snapshot was taken and return early
from rtc_resume() when it was not. This also covers the case where
rtc_suspend() failed to read the RTC. The device name check moves in
front of timekeeping_rtc_skipsuspend() so that the flag is cleared on
every suspend of the hctosys device.

A freeze too short to be seen by the persistent clock is not accounted
after this change. With the RTC in UTC the injected value used to be the
sub-second difference between the RTC and the system time, not the time
spent suspended.

Tested on v7.3-rc5 with a script that shifts the system clock by less
than a second relative to the RTC and then suspends to idle with a wake
alarm a few seconds ahead, 30 times. Unpatched, 4 cycles jumped by the
UTC offset, each of them with timekeeping frozen for less than 0.9
seconds. Patched, no cycle jumped although 6 of them met that condition.

Fixes: 0fa88cb4b82b ("time, drivers/rtc: Don't bother with rtc_resume() for the nonstop clocksource")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2543517
Cc: stable@vger.kernel.org
Signed-off-by: Alperen Kılıç <sabri.alperen03@gmail.com>
---

Notes:
    The jump was found and measured on my own laptop (suspend hook log in
    the Bugzilla report). An LLM assisted in analyzing the RTC and timekeeping
    resume path, writing the reproducer script and drafting this patch and
    its changelog. I reviewed the change and ran the reproducer on unpatched
    and patched v7.3-rc5 builds myself.

 drivers/rtc/class.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 01ba04028..c1a949252 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -96,6 +96,8 @@ static void rtc_hctosys(struct rtc_device *rtc)
  */
 
 static struct timespec64 old_rtc, old_system, old_delta;
+/* Set when rtc_suspend() took the snapshot rtc_resume() relies on */
+static bool old_rtc_valid;
 
 static int rtc_suspend(struct device *dev)
 {
@@ -104,10 +106,12 @@ static int rtc_suspend(struct device *dev)
 	struct timespec64	delta, delta_delta;
 	int err;
 
-	if (timekeeping_rtc_skipsuspend())
+	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
 		return 0;
 
-	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
+	old_rtc_valid = false;
+
+	if (timekeeping_rtc_skipsuspend())
 		return 0;
 
 	/* snapshot the current RTC and system time at suspend*/
@@ -119,6 +123,7 @@ static int rtc_suspend(struct device *dev)
 
 	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
+	old_rtc_valid = true;
 
 	/*
 	 * To avoid drift caused by repeated suspend/resumes,
@@ -153,6 +158,18 @@ static int rtc_resume(struct device *dev)
 	if (timekeeping_rtc_skipresume())
 		return 0;
 
+	/*
+	 * rtc_suspend() takes no snapshot when the persistent clock is in
+	 * charge of the sleep time or when the RTC could not be read. The
+	 * timekeeping core still asks for sleep time if the persistent clock
+	 * did not advance, which happens when the system was suspended for
+	 * less than a second. Without a snapshot there is nothing to compute
+	 * the sleep time from. Using the stale old_rtc and old_system would
+	 * inject the offset between the RTC and system time.
+	 */
+	if (!old_rtc_valid)
+		return 0;
+
 	rtc_hctosys_ret = -ENODEV;
 	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
 		return 0;

base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.55.0

