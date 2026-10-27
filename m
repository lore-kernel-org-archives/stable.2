Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111940;
	b=IQVK39++ygzhAeB5lvhM10Xv02FcgZxn1FvpTCPrLSKgn+s/R1jmQkI1MaGjyudRRVY8
	 uwnW8hrlLVz94MNIm3IHUu8Ho29sc/1Y1yoRKYgqNasO9Fn8X9TpkLO7ngAb26r1++zAF
	 ofp14Euxn9xAL2Su1gqORXvjNskQlyycEoYDDvgdYVb1w1uJroKfg3vQucIO8M13Cfz6D
	 snEy4luRahd394ro4Pqp8S0dgNG1uiEUjx29HZ2uLqJvnFRv31sC5hMU5yE7HMVZ4N9lq
	 s81B3tjd4eZUsnxWDCLWvTyrAnzDetwSTAmX/jZZfsW/gRiW5EjWZDI49a+pueFJWXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
	b=HmzjzfANw3C3AhZh5KpSCdIxRK3BN+7PzzRYS0Q0RFcP+wGZ8Ev+vLfHGh1SpgrXdGRk
	 gzgnOztH6/tc0ve0NU/m092btqu8nwIBVmuJHyLVruqKsa5TZ8CtTIayYy2ypjRK8+gT0
	 8G9C5i69/9LEGVZkJygsecv9NKBpCB41dYwj60VmNUpq4HdSBoIlVUrTQzNTdHMRDLLWO
	 hOeOvVH1biLuBcCvuSUwCXLfyigmFK86+mdegiIJxnNmhSWCezvCamfhfxmNiKAhQMcYj
	 TY6ooZ57L55K/8CcK+2hurZRI4DqntoxnvW58JJe0mMmfphwFpIl8bdqTrOYJFv8Wvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DBPs7ajY;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93351606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93351606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DBPs7ajY
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so7830835e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111938; x=1793716738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
        b=DBPs7ajYm++LSNGtV/1lJbK9KACWDdjd/H0//J5qmRVq//bULWBYP6ZkAS1EBZr46p
         dejtR1DDCrqEdbDX+FtL13P34SDd12km84ilKQpX2rdWIz6t8UQ9v1AUlW4clv0puLjE
         O6faV8Uq4m/w+VPx0qcsyytFyAWfX9/XFPDwwWB2UuO8aJiqiiNjmJkunbm4eZ6XY+84
         1WWUFVycHgMoubIzapAJ1fuO+jLchIXXZ1ApfN5JLXRMN0D3iPIaTUwLAHFQgQgLJd8F
         WZ/6dDyzhenBMPJXm4KHl/rQhKU4DjgGUjn4Xi2YG/CtuP7f9zbMkCNbWpyQvuMwczz7
         wB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111938; x=1793716738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
        b=icChtYqUY3AqXsmewxqVWkWkaHmXM9yffEa9lUG0gIMIOMivnWPamksyTrE+aNvzbx
         +WHpuiK+ZnZevBnJSFFLzHmYMU4512oZLQ+rE8AFSCT2SnVHSEm3NG2X86tEdFczzA6d
         nsEQGRG6E1uIm1tAcPO2t/3zwEby+9edZblIZNZ2+dFxemCRhiE5BekFF/CLLGT9W+fK
         vliKLUijBJ39fpN4j49FrEIoNEI1wGl2mUYpV/eW6lp5icgGRpe75ykxvefhZZeZqjIm
         0zaqEvt1EzCJnz+dQVAr1G0RIzby6MROsuaryEyGQgI+K/p4oHO/+GXG16bBXRUgd8+j
         EBeA==
X-Forwarded-Encrypted: i=1; AKwUvBwYbWm5OmlzqIyXgJNVJc/CeIPUUipKYK39WUigPrQFhDFN8Ri/B0IMe5Qb8NOxVgsoiUS3XMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG0yuHj7FQhSTfqD3QkUBlE1BRhm8oNrFe8fYll73MqckEBwBV
	lcyDZLzrWd/AMWgKR4exMTbK7v+aTwGrffDLGfzaTMxvY+9D2dezTGGe
X-Gm-Gg: AYBFou0Ce+M5/enbTFSHpTo8+MpKvEO/VjrDqTkvGKzweZu0w/ZUOe7hbVPigECGnGp
	GTYe1CM2VKNqlZwkVQCckoPlR6ZSEBEWVLN2IcLvpVbxjT+838aTQjJNnxA92+VTt5GmqQkiKzN
	w75OL00pgMrCOgcIblrDT9RwdXDGXe/lhL9hdUJ0srmcUc0TXHre2zdBVcMvZ20VRBlJSQo9Ohb
	XR1v470+nn2bW8wSNTKu/kdUaXGBMl34w2Tt1+lFxmYKrLDP/aKOraqj8qLkPdfjH6P7h++blIE
	m1y0ionHEKQrlcM2bWk0qmlSyJNU4ERMoq9pINTQQ0WZM6sDbUbM9joMfNHjI5W8wr0bQrVMVJ5
	LHNyc7f4p04HQ5f2nt+jroBQByh0EeSOcuM8cezYZv6v5dgtJjLDxAM1GNxm61dz0zDSt2zJLq6
	W1LOQo6ZXvyDi5ZwblMd3rnSZ/WZEQYHcnph3yLhENV01alRcrlA0akNBsJM7JIH7pXmJsp34S7
	ntPVzHBx08WZ33+uBqrkUWBFlw2ag7Cw64Q9M9WdnSEo+bvPavrrRx9PiZXeVhzyGtgA/NQnmUa
	OxFQV2QfSeQ=
X-Received: by 2002:a05:600c:3d08:b0:4a2:1960:6fa with SMTP id 5b1f17b1804b1-4a7bfec49damr64723785e9.4.1793111937376;
        Tue, 27 Oct 2026 07:38:57 -0700 (PDT)
Received: from gandalf.magpie-herring.ts.net ([90.251.75.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm279495975e9.2.2026.10.27.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:38:56 -0700 (PDT)
From: Zak <zakbrightonknight@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Tue, 27 Oct 2026 14:37:25 +0000
Message-ID: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Zak Brighton Knight <zakbrightonknight@gmail.com>

On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
the CPUs stop using turbo after every suspend to RAM when intel_pstate
is in passive mode with the performance governor: they stay at the
2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
policy limits change or the system is rebooted.

During resume, the firmware sets each CPU's P-state request register,
MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
the requested turbo ratio (38) again.  Without hardware-managed
P-states (HWP), intel_pstate caches the last P-state it wrote and
skips writes that would not change it.  In passive mode the cpufreq
core also skips requests for the frequency it believes is already set
(policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
only with HWP.  Neither cached value is updated across suspend and
resume, so as long as the governor keeps requesting the same P-state,
as the performance governor always does, the register is never
rewritten.  Governors that change the request often, such as
schedutil, mostly hide the problem.

Fix this by writing the cached P-state back to the register in
intel_pstate_resume() when HWP is not used, as is already done for
the HWP request when it is.

The problem was found and root-caused, and this patch was drafted, with
the help of an AI coding assistant (Claude, by Anthropic) during a
performance review of the machine described above.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Cc: stable@vger.kernel.org
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
with v7.3 plus this patch and a temporary module parameter, not part
of this patch, to turn the fix off.  intel_pstate.c is the same in
v7.3 and in the base commit below.

Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
"Request" is the P-state read back from PERF_CTL on all eight CPUs
5 and 17 seconds after resume; "clock" is the measured speed of a
single-threaded busy loop.  Before every suspend, all CPUs requested
38 and the clock was about 3.8 GHz.

  mode     governor     fix  request after resume  clock
  passive  performance  on   38 on all CPUs        3.8 GHz
  passive  performance  off  28 on all CPUs        2.8 GHz
  active   performance  off  38 on all CPUs        3.8 GHz
  active   performance  on   38 on all CPUs        3.8 GHz

The passive-mode failure was also reproduced twice on Fedora's 7.2.11
kernel.  In active mode the request was back at 38 after resume even
without the fix, so on this machine the fix only makes a difference in
passive mode, the default without HWP.

Not tested: systems with HWP (their code path is unchanged, only
restructured), other machines and firmware, and suspend-to-idle.  The
patch adds no warnings with W=1; sparse was not run.  The tests were
scripted and run by the same AI assistant.

 drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb..53db91a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
 }
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
 
 static void intel_pstate_hwp_reenable(struct cpudata *cpu)
 {
@@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
 	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
 		set_power_ctl_ee_state(false);
 
-	if (cpu->suspended && hwp_active) {
+	if (cpu->suspended) {
 		mutex_lock(&intel_pstate_limits_lock);
 
-		/* Re-enable HWP, because "online" has not done that. */
-		intel_pstate_hwp_reenable(cpu);
+		if (hwp_active) {
+			/* Re-enable HWP, because "online" has not done that. */
+			intel_pstate_hwp_reenable(cpu);
+		} else {
+			/*
+			 * PERF_CTL may have been changed by the platform
+			 * firmware, but it is only written when the requested
+			 * P-state changes, so restore it explicitly.
+			 */
+			intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate);
+		}
 
 		mutex_unlock(&intel_pstate_limits_lock);
 	}

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.56.0

