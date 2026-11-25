Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601619;
	b=YGWtnf6sZ/CXu8QK8AWfWyXanSf8ccGeS+ynjnhOPt/Kem0dkOeD+7oJXu+ufwWiyDCi
	 CGA7A41Cbkj1M29luv7/kjwId671uL4PfWWikoN13bOXpfLF1VXP0+FGAInCh8SMHcBjD
	 BRnFG+hh3K6Rd7GCJkx8PF11btKyKohpwZlYcOkyF1SWeKU6G7QtLY/+RQggn5cHt0OSp
	 rYtrm2kADbOkhVfclnPRNGjdD6/WTsKAhdd4U5xaOAXoqjyTBGYxK5qpMhOKltpUKxhju
	 13gemvr1KlC0rBb+YL1MaW5kbZsIHQM2drGFyrUlZLO5cAz2YxNL8PmkVLKAggCEkZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601619;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xKLw0zaDk1jhPE/f6nS5k/jOHGF991f3PQ0trdONxFE=;
	b=gQeF8bXpmr8m90yQOfbkUY7CyHHn93xyKfNYJt8ccT3I3HH6A/qMIUmzyhIISqRLceDP
	 SwdMh1PoqaSFSjQSJ9KuPI+02XBvt7fBh9/nlbsTZ9eYI0GIOWt6cPTc+50De3ZIOm8Cj
	 Q12LuseFBMhVaNVyArzikmmNVNDFrqFRKgg9xrspnSrKMlmyohsU73bts9u0bVAuw2bc7
	 SCMnX9dEYkPxdWfBLuMSbOxejp7Zc5SSBkgV0w136+tNuUFdlOuXXDc/FWiX8RSjJAE4c
	 3OEZbqcXY1BOkQUijUkFSMuTPf3YMLpiaoRubeVKqFuZGlmF0hqijCMpH2oe32JjMPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=k6IyCytQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E37606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=k6IyCytQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B81F000C0;
	Wed, 25 Nov 2026 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601618;
	bh=xKLw0zaDk1jhPE/f6nS5k/jOHGF991f3PQ0trdONxFE=;
	h=Subject:To:Cc:From:Date;
	b=k6IyCytQdD7Mik2GkhoBaPvDwpoGtjuvRIvOHJ1gU5IPP++RpaUMVLIc8ARpGXRoR
	 U+fF8kcKouOWr2UJKvs4ncd57WdRX3ltorXjCIpDuQjTQDTeRm69I8yqL1n3y8v2tl
	 76BzVCl9WyM+xJv1NKR2ziTs/yPjEg7bIsEYDwXU=
Subject: FAILED: patch "[PATCH] cpufreq: Cache post-resolution target frequency in" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:10:28 +0100
Message-ID: <2026112528-unscrew-recall-9dd7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 166207cac45191637c47a457a5c16ca6b6773a16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112528-unscrew-recall-9dd7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 166207cac45191637c47a457a5c16ca6b6773a16 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 6 Nov 2026 16:04:05 +0100
Subject: [PATCH] cpufreq: Cache post-resolution target frequency in
 __resolve_freq()

get_next_freq() in the schedutil governor returns the resolved
frequency from cpufreq_driver_resolve_freq(), and that resolved value
is then passed to cpufreq_driver_fast_switch().  The only reader of
cached_target_freq, acpi_cpufreq_fast_switch(), compares it with the
post-resolution target frequency, but it holds the pre-resolution
clamped frequency, so any request that falls between table entries
misses the cache and falls back to a table scan.

Address this by making __resolve_freq() store the post-resolution
frequency in cached_target_freq.

Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/14161745.uLZWGnKmhe@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c246e5f7510d..6370d0e71331 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -488,8 +488,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = target_freq;
-	return policy->freq_table[idx].frequency;
+	policy->cached_target_freq = policy->freq_table[idx].frequency;
+	return policy->cached_target_freq;
 }
 
 /**

