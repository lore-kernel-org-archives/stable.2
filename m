Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032449;
	b=gtmJmkPufCGSph6tb1esFq/iVZPe6N11O5JqnvkJmYl2vFQE+oB1MukI33PrcyZQp5SQ
	 J8dxIC74jJ43UHGXxt5w2ihXNFRwPsvJhHwhYaCjfFfTmbQpPYAylaG+LccDle5X4lZ1n
	 kUbU0WzaCJ5Lx0NjrpsNJcZWHjrdSZxg4fMI6C0zpO2NC6jaudEaq8BlPDEkp1zkihV8C
	 wQlPcsu0UcaW6EyjHL98J/5N/rcXe0g1pA/Hoh76mHn985z+vyVWR4vEIkFaUJ5Z882cV
	 2C+eJa9D1xF286fDZCTM+ikRTdDu7vS2UKaOp8ihlvrRFrPcmXFuBHopaP1iPgxFBsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032449;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-MBO-RS-ID:X-MBO-RS-META;
	bh=grrGjUVJwV0CXcLKlYEe48Qw43rd0brUV0hYKxU47Xk=;
	b=B5qS5lrdHx40wiPuciyQQLtlXSbM4fEmVxWT3oLvklokskfjJjbJzw8VJlMMHoVcTDth
	 Bebf2mcyQatQgebx4HhYAMcthIYdczzDKD/DtzxwkXlF16LQfJOgMcdifh0YBkcneqf07
	 5y2icYEUI6hHqbWQH0jv6IFIli9PFCaiIfqv9dfU4Keka1beTwEHdGXXqVM0xzoGPpD7Y
	 mzbFvTRgNxP8Y9vQVSG62MLv7v4PoGOAJzmnPnPRny3qI5nvamhfgbDaNXvfCiIbPJAP2
	 VnZ6u9dqa9SWCN0Bni41HvN1R/f4I3ufcX8ovz6wAhCbPfZf8iVdCOoWSlVq1wS81rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jUj2cQi1;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB56606CB2C;
	Wed, 18 Nov 2026 20:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB56606CB2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jUj2cQi1
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jVCLZ5YDLzKnTb;
	Wed, 18 Nov 2026 21:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795032438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=grrGjUVJwV0CXcLKlYEe48Qw43rd0brUV0hYKxU47Xk=;
	b=jUj2cQi1TjvAlAigsWByFQtLeRYFuCgFzYQW71NHtfFhDAr9MppM/OKgIIiiZOhntd72Da
	MxBvYFDQ9XSaLsYHNMiZlA6EOMNTMYWTqNxfRUQfX6IDpbpdzyB9eqYlFpF0Ke0P1XtyFX
	AXVpG1p+HmpZjPqGVVcLUB1VcbvLX459NRjxOTQKvyYGhxyIc5F7x+qpCkgKNYCa3n7YF6
	OsV50NQAAVhsv3r3bKCC2fxTP97ADE2jKxBTWBaMK5bHbwvQ4cXzpxQPgSkd5nMJYwNsCJ
	EjuMYO5jZpx8vHPMzIlYrnjnPGoZtejgyHafUM99n7mdqC//P3dFMMZU4CTEBQ==
From: Lukas Beckmann <lbckmnn@mailbox.org>
Date: Wed, 18 Nov 2026 21:06:42 +0100
Subject: [PATCH v3] cpupower: fix use-after-free and stale limits in
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
Message-Id: <20261118-cpupower-freq-set-use-after-free-v3-1-3e021315b579@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw6CMBBFf4V07ZhOyyO48j+MCwpTqFGKLSCG8
 O/yiImudHkmN+fMyDw5Q54dgpE56o03tp5B7gKWV1ldEphiZia4iBGRQ950jX2QA+3oDp5a6Dx
 BptvtRCA5SZnorMiVZrOmcaTNsCZO5419py6Ut4t3WVTGt9Y91x96XHbvnPid6xEQQuJchqlIl
 NTHW2auyg5760q2BHvxqYz+UIpZGasUNcaSYxx9K6dpegHVDValNwEAAA==
X-Change-ID: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>
X-Mailer: b4 0.15.2
X-MBO-RS-ID: 4a0eb06593f6e9ff584
X-MBO-RS-META: ftnuf1a7g68bqj75hgs7idewd41dkfb5

do_new_policy() directly fills the unset fields of new_pol from the
current CPU's policy. This is problematic because do_new_policy() is
called with the same new_pol for multiple CPUs by do_one_cpu() in the
slow path. This results in stale values in new_pol being applied
(starting from the second CPU that should be changed), and even a
use-after-free (for the governor string).

Fix this by building the target policy from new_pol and the current
policy in do_new_policy() instead of filling the missing values into
new_pol.

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
Testing and minimal reproducer:

Running the command

    ./cpupower frequency-set --max 2500MHz --min 2500MHz

with ASAN reports the use-after-free before, but not after the patch.

Run the following commands:

    # set CPU 0 to a different maximum than CPU 1
    echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq

    # Change min and governor (but not max) of CPU 0 and 1
    ./cpupower -c 0,1 frequency-set --min 1GHz -g performance

    # See if max got changed
    cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq

This shows that the stale maximum of CPU0 is used for CPU1 before the
patch, but not after the patch.
---
Changes in v3:
- Keep the original if conditions (no functional change)
- Link to v2: https://patch.msgid.link/20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org

Changes in v2:
- use a shorter changelog and testing section
- build temp_pol from new_pol and cur_pol instead of copying new_pol
- Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
---
 tools/power/cpupower/utils/cpufreq-set.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 06cd4b280132..0bbf303d3317 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
 	}
 }
 
-static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
+static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
 {
 	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
+	struct cpufreq_policy temp_pol;
 	int ret;
 
 	if (!cur_pol) {
@@ -152,15 +153,21 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
 	}
 
 	if (!new_pol->min)
-		new_pol->min = cur_pol->min;
+		temp_pol.min = cur_pol->min;
+	else
+		temp_pol.min = new_pol->min;
 
 	if (!new_pol->max)
-		new_pol->max = cur_pol->max;
+		temp_pol.max = cur_pol->max;
+	else
+		temp_pol.max = new_pol->max;
 
 	if (!new_pol->governor)
-		new_pol->governor = cur_pol->governor;
+		temp_pol.governor = cur_pol->governor;
+	else
+		temp_pol.governor = new_pol->governor;
 
-	ret = cpufreq_set_policy(cpu, new_pol);
+	ret = cpufreq_set_policy(cpu, &temp_pol);
 
 	cpufreq_put_policy(cur_pol);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf

Best regards,
--  
Lukas Beckmann <lbckmnn@mailbox.org>

