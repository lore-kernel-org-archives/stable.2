Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513022;
	b=IXVgJTNHesRCDMAKQuoLEFylU/Hb52k5hrf5snQ3vQcyTqP9FwYpbX6dkwMuhfplyrvN
	 koVlrdo8QdVgtwM22CEFzFoylxUAadYssEJM4LYANqLHykX2qK8P95gg6MQfUeC8/Ac8v
	 DM57cq6X+HATveabKeWCbuX/itBOeFIeFNmQ5C8wWm7BOSQ8+a/gInJd97vkVLtpqfNKw
	 VI8xqYoHNC7wPYOs0Ov9bOwR48VIx+g2YHxoEl2oYpDzVby0TVLkM0NC1aQ0+tJjF0vsg
	 Joe6+VknAlm+1+1sQ3Xm8jEW0Mnpnki6h2T8gZXWAJ+HM35wZ6golU1irCJ6KNByC8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513022;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-MBO-RS-META:X-MBO-RS-ID;
	bh=T7fBFAi48Jpe/1qjrxvC0HFG/rWwyy7tZrlV1oBmXk4=;
	b=rDMjVrIGao1x0TjLqvxAjiMeCg/oFWH3oNachgwRZta4mkVR7ZjTyr3pMlk+3UZxryR7
	 NTTAnWftp+w87fAW5Su89GS0uO5ujS6UQdIOlnYajhRCwcIGbY0b92lTWHSyrsNCad1cz
	 pj21TBBEbd+i6bNKUJFCtU0fVlbDI9ItptBQL5i74TdIwy5kWPFPkyTiWkgMFN4SsZUMV
	 9hbBUvsGLF43ZesqGxESNatIZVMfcYRiqb5CatmD5yhkQw9uXP6IYJKetjkLLeFHgCkGx
	 QWhhoUc2jeyOH70pKnYeiiGkd7LrPefidAY5tRil+LSNklBO+XryoEg4XehtOHHAMuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=t4iYIl17;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009A606A31C;
	Thu, 12 Nov 2026 19:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E009A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=t4iYIl17
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jQWFj6FqtzMlDH;
	Thu, 12 Nov 2026 20:50:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794513017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T7fBFAi48Jpe/1qjrxvC0HFG/rWwyy7tZrlV1oBmXk4=;
	b=t4iYIl17g6rcxN876yxnVNt7yj+xP4QGHu+w5kLPmkxA/xxA4vrQ5iZlPsOXjk6aCjAwt/
	4F7YU1WTt8y/rVNLIzOcHFLXTJjjxCE9L1O4Go29UC3ZdNC2V3m+xANAg4ivj6L2v+MrK1
	mLUYgiWD0JAxjDqSF1pLWQsb8Qtn5MLihmbzpfWdtGOBsxYuI7t8KkR31PLkIMR03FbjcE
	0HOaYMWDHk6KDM3o1x40RWoomssXPlQ/rjFWlS6CSxn1vB0Ahk/M5oOLpKXjZ2A4XoGOPO
	G8ccULunsLc/WnzAt+JShfJYMflos/2Q9myZmvmdtETDTHA7sLzKbInHVyah8g==
From: Lukas Beckmann <lbckmnn@mailbox.org>
Date: Thu, 12 Nov 2026 20:49:16 +0100
Subject: [PATCH] cpupower: fix use-after-free and stale limits in
 frequency-set
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
Message-Id: <20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ7CIBCE4Vdp9uwmUJKa+CrGA6WDrocWWVCTp
 u8utcdvDv+spMgCpUu3UsZbVJa5wZ46Cg8/38EyNVNv+sFaazikmpYPMseMFysKVwX7WI4J7Ay
 cO0c/hTFSy6SMKN//xfV2WOv4RCh7l7btB+btgmyEAAAA
X-Change-ID: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>
X-Mailer: b4 0.15.2
X-MBO-RS-META: tye31kzbtj5duxydch81mgdu6fyeipyo
X-MBO-RS-ID: 1d53627933377cc6e02

cmd_freq_set() currently has two issues:

1. use-after-free

When cmd_freq_set() is invoked with --max and --min, it eventually calls
do_new_policy() for every selected CPU with the same cpufreq_policy
struct. do_new_policy() first retrieves the current policy and copies
the governor pointer to new_pol.governor. After that the policy is
applied and cur_pol (including the string to which new_pol.governor is
pointing) is freed. For the next CPU, cpufreq_set_policy() reads that
already freed memory leading to an error message (because verify_gov()
fails).

2. max/min is not retrieved for each individual CPU:

If cmd_freq_set() is invoked with e.g. --min and --governor, max is set
by do_new_policy() on the first selected CPU by retrieving it from the
current policy. Since the same struct is passed to the next selected
CPU, it is not retrieved again, resulting in writing the first CPU's
max to all selected CPUs.

Fix both issues by using a local copy in do_new_policy().

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
Testing:

Issue 1:
ASAN run of the (unpatched) cpupower example:

./cpupower frequency-set -d 2500MHz -u 2500MHz
Setting cpu: 0
Setting cpu: 1
=================================================================
==386949==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c17340e0350 at pc 0x7ff73559241c bp 0x7fff5d8114a0 sp 0x7fff5d810c58
READ of size 2 at 0x7c17340e0350 thread T0
    #0 0x7ff73559241b  (/usr/lib/libasan.so.8+0x8841b) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
    #1 0x7ff7353cb475 in verify_gov lib/cpufreq.c:585
    #2 0x7ff7353cc0dd in cpufreq_set_policy lib/cpufreq.c:631
    #3 0x55f590fb79ab in do_new_policy utils/cpufreq-set.c:163
    #4 0x55f590fb79ab in do_one_cpu utils/cpufreq-set.c:192
    #5 0x55f590fb79ab in cmd_freq_set utils/cpufreq-set.c:327
    #6 0x55f590fb3ee6 in main utils/cpupower.c:235
    ...

0x7c17340e0350 is located 0 bytes inside of 11-byte region [0x7c17340e0350,0x7c17340e035b)
freed by thread T0 here:
    #0 0x7ff735634e91  (/usr/lib/libasan.so.8+0x12ae91) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
    #1 0x7ff7353cb8ef in cpufreq_put_policy lib/cpufreq.c:283
    #2 0x55f590fb79b6 in do_new_policy utils/cpufreq-set.c:165
    #3 0x55f590fb79b6 in do_one_cpu utils/cpufreq-set.c:192
    #4 0x55f590fb79b6 in cmd_freq_set utils/cpufreq-set.c:327

previously allocated by thread T0 here:
    #0 0x7ff73562efce in strdup (/usr/lib/libasan.so.8+0x124fce) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
    #1 0x7ff7353cb1c8 in sysfs_cpufreq_get_one_string lib/cpufreq.c:156
    #2 0x7ff7353cb845 in cpufreq_get_policy lib/cpufreq.c:262
    #3 0x55f590fb7a4f in do_new_policy utils/cpufreq-set.c:146
    #4 0x55f590fb7a4f in do_one_cpu utils/cpufreq-set.c:192
    #5 0x55f590fb7a4f in cmd_freq_set utils/cpufreq-set.c:327

Running ASAN with the patch shows only an unrelated memory leak which
was already reported in [1]. I can fix that in another patch if needed.

Issue 2:
Minimal example without the patch:

    echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
    cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
    2000000
    3000000

    ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
    Setting cpu: 0
    Setting cpu: 1

    cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
    2000000
    2000000

The maximum of CPU1 is set to the one of CPU0.

Minimal example with the patch:

    echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
    cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
    2000000
    3000000

    ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
    Setting cpu: 0
    Setting cpu: 1

    cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
    2000000
    3000000

The maximum of CPU1 is no longer set to the maximum of CPU0.

[1] https://lore.kernel.org/all/20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com/
---
 tools/power/cpupower/utils/cpufreq-set.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 06cd4b280132..d9f6ca522fe5 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
 	}
 }
 
-static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
+static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
 {
 	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
+	struct cpufreq_policy pol = *new_pol;
 	int ret;
 
 	if (!cur_pol) {
@@ -151,16 +152,16 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
 		return -EINVAL;
 	}
 
-	if (!new_pol->min)
-		new_pol->min = cur_pol->min;
+	if (!pol.min)
+		pol.min = cur_pol->min;
 
-	if (!new_pol->max)
-		new_pol->max = cur_pol->max;
+	if (!pol.max)
+		pol.max = cur_pol->max;
 
-	if (!new_pol->governor)
-		new_pol->governor = cur_pol->governor;
+	if (!pol.governor)
+		pol.governor = cur_pol->governor;
 
-	ret = cpufreq_set_policy(cpu, new_pol);
+	ret = cpufreq_set_policy(cpu, &pol);
 
 	cpufreq_put_policy(cur_pol);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf

Best regards,
--  
Lukas Beckmann <lbckmnn@mailbox.org>

