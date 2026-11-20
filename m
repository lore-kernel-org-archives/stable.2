Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213109;
	b=ud9nJU/tGxm0yb2LFqhQQ27TZRESrhI60JG/yEILt1Wdrhvxq9kcUAmv4zNPZyJkOqjD
	 yngnCeF1OO8m9RMSsRjx5Rx3sV0QFVPVTwmOjA5UXIKJOGY5qwzPXbJoV9k3e/LTkxxkH
	 g3Q5O3EgWuyCYKq+aut1FaE8LXI2yqxG9NYjueawr/F1cO7SG7mLzO+Iz+dVnBuGR7/Ot
	 6SlisajVolv5Cp5D7Qvg+HL6iZhiTF9jtDPCCpAtb5gX+T2LmBYvwwoZ/kKu3KZmfb04h
	 qZx5jEcB9DM61f4HjnJd+Wc8+NkjNP0cCnHAQdjvqDmx7GwqyvuE+7YWi/6+yldTdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213109;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-MBO-RS-META:X-MBO-RS-ID;
	bh=vp+/Jvx8ZdX5MQTGDvK8fK5XF90fdpcAWl4Gm05qZB8=;
	b=gbU8qM6DeAOExESZA9aOOwgqxVTZ9ceaoF5IZ5R6ySfnM6gtu2u66C0m5cmx4U/5jLz6
	 9lzq5BLLj9InhDAVpt/CiTP4ixNJwnrDjp8IGTH0x9Vtnh/BdA7qjuyXdMkC4XLMJmDqs
	 6XuOJMywby7ymFuHLNn/iv8jSHhXUUVdTpGBaVbJ+1+qt0g9BfwvxUqFx12v2S7hWU8QN
	 lQcYmoWHWwQGkRvRkaCVFwKiKRljXTPc3ozLejIJ7VVklD9xKXkm8IsG8E14DFve2VnOl
	 jmHkTmMVe5fqD5T56ZTT28e69kkGkBCYI/Yg1BFEsDs20H/RtgT6UCjIFD7Je3KEDsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Qu7M20cz;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5598606A698;
	Fri, 20 Nov 2026 22:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5598606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Qu7M20cz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jWV8k0PRwzKr4t;
	Fri, 20 Nov 2026 23:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795213094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vp+/Jvx8ZdX5MQTGDvK8fK5XF90fdpcAWl4Gm05qZB8=;
	b=Qu7M20czGbdezICHUhD+vh7X4JmGAm6n/LHLmfp7eXETSqgbvSUHv3LvIUoB62Dio0GlTv
	gGqkU1L5/XmWvu/qjNP8eIjwDvBk0i82blfok6taxMHkEN94fLR1kMGUC+e+ILMuB5K+dy
	E/LcQQ8mA93NRbeDe9iYC7GOlJLEloDAFWNVl/jOWfuoHqfOG1jp51JcnHgWRHaKlZDxZO
	YxqYtAphXq29521Rm6euC0DsZYHzJh0HDxKJGEsQgb0lGUPFCPtfWKvns5t1ZyOqE1SmKB
	QfXTuNjmibajk7UDvvF1QTu3fZ1hr6eN6hpXykDKAyT7N4YBm0uU4L/Cqo6Lwg==
From: Lukas Beckmann <lbckmnn@mailbox.org>
Date: Fri, 20 Nov 2026 23:17:57 +0100
Subject: [PATCH v4] cpupower: fix use-after-free and stale limits in
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
Message-Id: <20261120-cpupower-freq-set-use-after-free-v4-1-928675d53a23@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQrCMBAF4KtI1o5kMv2xrryHuGjqRCPa1KSti
 vTupoqguNDlGx7fm5sI7C0HsZjchOfeBuvqGJLpRFS7st4y2E3MQkmVIaKEqukad2YPxvMJArf
 QBYbStM8TA0kmyk25qbQRkWk8G3t5TKzWzxw6veeqHd2xsbOhdf76+KHHsfeaU7/negSEhKWkp
 FC5JrM8lvag3WXm/FaMg716J9M/SBXJTBdoMCOJWfpN0js5/4OkSBJLhYSpTvPikxyG4Q4hBHv
 figEAAA==
X-Change-ID: 20261110-cpupower-freq-set-use-after-free-30e337fadcbf
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>
X-Mailer: b4 0.15.2
X-MBO-RS-META: feg7ddw56xmg4qqco8m9mgq8c3iasaa5
X-MBO-RS-ID: 4624b0631c338ab02a3

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
Changes in v4:
- Do not qualify new_pol as const (not needed for the fix)
- Link to v3: https://patch.msgid.link/20261118-cpupower-freq-set-use-after-free-v3-1-3e021315b579@mailbox.org

Changes in v3:
- Keep the original if conditions (no functional change)
- Link to v2: https://patch.msgid.link/20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org

Changes in v2:
- use a shorter changelog and testing section
- build temp_pol from new_pol and cur_pol instead of copying new_pol
- Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
---
 tools/power/cpupower/utils/cpufreq-set.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 06cd4b280132..0808f1f384b5 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -144,6 +144,7 @@ static unsigned long string_to_frequency(const char *str)
 static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
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

