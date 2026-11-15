Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737051;
	b=uDRIQ7U6lfRXv0p2QMLbNq126+1zm+G8vKZHmLq0DbhAYROZ9TzohNrpcdRJ1rt/Fz8a
	 J3j1c9fzmMtu8I1jGAaGNtluApWwgM12eQdU31vGgObNhi/pR6yHOFiH1FQthiwV1ydqQ
	 k2AxYq1IAboW+UF/QwYp1SS/DhCfFSzCt9oaUzptp8I2f6ug8W7NLBEFlm93fPwc9FDob
	 LDrHVIrQpdomvMrCxSJjSZXAVKEp7lAQt/CsdYXBUzyD0/Ry5xrmFu5lL6vqnSuIA3akx
	 qT2PUR2Wp1Wn5AxtGIU812V+8XFmtNbqto108VrUtIcUveSS4sakTXGP67Vly38x+Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737051;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-MBO-RS-META:X-MBO-RS-ID;
	bh=r24sJ6EQjPki8A/OQvZW0k99xSlAnUGvDH3ZgagLA2A=;
	b=Yja+03623KIkaCOOqk811JHYR6G+/89NpwIQ+z0G9zdoMG03rPwOflLSpOkx7IskGzBu
	 lV52J3DWVib7WMty3sLH+aTNyMHwk6dm3ohlGGU0hzQpvLdEWBOWNOkTnkRWH5WiNX/Ck
	 TQ8bXeOhXUNJb0yC8+ZX6HOMThgJK0i7uAY514GTaPOLYs0kaXBF+rM0y6rnw610y6Y94
	 HcUXgYSFBmlkONiHWgDxc3Fu63+vBTTBT5NrYUMXMJ1R+BJ+1J5yA1jXs9g/v1iSmLecU
	 XSgac+IMYo0dd5n1bVbIwJ3+XskSJNSgNHJpV9cNJCvxLGCcox5l42alJFWtOGnlqhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cgAG6RG1;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109F606A31D;
	Sun, 15 Nov 2026 10:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2109F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cgAG6RG1
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jS65x2fDDzMlrh;
	Sun, 15 Nov 2026 11:04:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794737045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r24sJ6EQjPki8A/OQvZW0k99xSlAnUGvDH3ZgagLA2A=;
	b=cgAG6RG1MmxnQ7qYufT8zP/pO1XX4mdRONttnbdUcbw3xc1pdWpd9MOlwDTVWN27Uf4hYB
	7eOQg992B/xin7ty7z+KDYcAMzbFuT8bu795vJncLTOAuBCUu3tDfpG0fS/R3m05d4XkkT
	jmfMFNTTGaNLb1yS4V0LD0AIuf6CCSz7FzikNrSndeGcTar+l1K4f4F8Bd52Xt8a9kgX0P
	A5G4VObfNTVY03eP2NCLTflzOyMQ7p6zzwJY5vGfHJxJYYR8Vqy3McnHbqjTF0vHweqAjd
	YxH8hnlCcyy/3MvS4Gpw/SF/ZYx26D5FXkBsPSJnQ31CFSJUc+46j0qf9I0ngQ==
From: Lukas Beckmann <lbckmnn@mailbox.org>
Date: Sun, 15 Nov 2026 11:03:32 +0100
Subject: [PATCH v2] cpupower: fix use-after-free and stale limits in
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
Message-Id: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBREf4V07TV9EImu/A/Doi23UKMUewtiC
 P8uj7h2eSaTOTMxwuiR2CWbWMTBkw/tAvKQMdvotkbw1cJMcnkSQnCwXd+FN0ZwEV9AmKAnBO3
 SHiEojkoVTlfWOLbMdBGdHzfFrdyZenNHm9bdtdF4SiF+tg+DWHs/nfyvGwQIyJFzlZ9lYZS7P
 rV/mDAeQ6xZOc/zF1Gna8nkAAAA
X-Change-ID: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>
X-Mailer: b4 0.15.2
X-MBO-RS-META: 5f1aknyedm3kdg9ioidg6g197rmnyjpf
X-MBO-RS-ID: 26c9935a3721068b976

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
Changes in v2:
- use a shorter changelog and testing section
- build temp_pol from new_pol and cur_pol instead of copying new_pol
- Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
---
 tools/power/cpupower/utils/cpufreq-set.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 06cd4b280132..674e3aabd31d 100644
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
@@ -151,16 +152,22 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
 		return -EINVAL;
 	}
 
-	if (!new_pol->min)
-		new_pol->min = cur_pol->min;
+	if (new_pol->min)
+		temp_pol.min = new_pol->min;
+	else
+		temp_pol.min = cur_pol->min;
 
-	if (!new_pol->max)
-		new_pol->max = cur_pol->max;
+	if (new_pol->max)
+		temp_pol.max = new_pol->max;
+	else
+		temp_pol.max = cur_pol->max;
 
-	if (!new_pol->governor)
-		new_pol->governor = cur_pol->governor;
+	if (new_pol->governor)
+		temp_pol.governor = new_pol->governor;
+	else
+		temp_pol.governor = cur_pol->governor;
 
-	ret = cpufreq_set_policy(cpu, new_pol);
+	ret = cpufreq_set_policy(cpu, &temp_pol);
 
 	cpufreq_put_policy(cur_pol);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf

Best regards,
--  
Lukas Beckmann <lbckmnn@mailbox.org>

