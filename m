Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628042;
	b=pMQziWax7S6w2e+UOFf/atGHQzyoH/6KYX95TOdk+aeI5WcYbU+dKo4LeHd5PqvgKvTn
	 xgTy8gIvZ8QdSlamfcTEY2dx1DKJTRitalRi+NwmIbuFpcthNXM+1A22qUSYQd3JeT82V
	 E1e8zJI1XcQscmv7xRoNjM+wrdmgDWEByUUHHKISscvutT4a0fMNeRNrzMwxuk3UjNchQ
	 C9NG6vywJcIqSn5TavUb1jGlG84AyixhhWwWH7jE5dQvEsxyTsKo9CCc7p1bNgBMztM2q
	 MI8ISi1PDUXAZMAF+OfgZbzu4qakqAoCIn0OR4VKkAG66Yae2tQS8815k3blgz65wMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Smxbm6QE4n1/G4iGpmQVSDHCv4BKF83CRlkTj6yhEJI=;
	b=Y9mcDkfYLMZ4952cyUUtyucdll3ujmGrDUrmMHsm8IxP7PBqP61gji/m4Oxx0ZrFibiF
	 CxGAOOb4OoQqsG84zm4tAGQcJz6LZ1IcunD1e2xzdTs5tvP/pj9pk61a/FHNIAT3s6tqi
	 r540fG/+MCUGUMHuEw/goGAyhArPqXd3cLqVA8tDcIrRHdYYO5oVVRY51tCwaQRwPVbmV
	 frVRNRBJa8Tg87NWI13RwB6gSlrA9b0PpIKVtUr5YPE7z9h0WqpG5IOuTta0NR2OgYL6F
	 9ssy8aQgYM8VJCN8Ba4R0CXlkDbfgohBFaqRtlQhtWEiON724B7Vkr66eZH2bnF1spg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUqmA28l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUqmA28l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2701F000C0;
	Wed, 25 Nov 2026 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628042;
	bh=Smxbm6QE4n1/G4iGpmQVSDHCv4BKF83CRlkTj6yhEJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUqmA28lhbFxT6O0p7XieGJdwn+7mc/gNNah1Zgfx8RDvTuQRUQKTW1AqIatjyn50
	 IioONB6SyMvDKr+YGnq35RsTOhXharuqMU9Sprc/DcnZIOLohP/dXfFLGUODx/WbuG
	 rcsX/+KVhAnelz10prUfcfQ4I1LOKs2Y3QXkFbaYGrfo783mPyXZx0HIR9/QsK5XSa
	 yZ+j29hFiNaXykspThHnHrw7utHO0xfAAVSVshRkARfjzgVQ6iEUxwmEhsv8dUCSXs
	 KoQUg7uMHgPmyg7iO77gD2InXWmBhZqBL0k7SqVFduxUAmlW7VxECHesxT5i7D1Bg0
	 RqCtZpwkrGw8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] cpufreq: Introduce policy->boost_supported flag
Date: Wed, 25 Nov 2026 12:33:57 -0500
Message-ID: <20261125173332.948887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-twine-magnify-87fa@gregkh>
References: <2026112539-twine-magnify-87fa@gregkh>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 1f7d1bab50e6ae517f8b6699e56d709d61ae13e5 ]

It is possible to have a scenario where not all cpufreq policies support
boost frequencies. And letting sysfs (or other parts of the kernel)
enable boost feature for that policy isn't correct.

Add a new flag, boost_supported, which will be set to true by the
cpufreq core only if the freq table contains valid boost frequencies.

Some cpufreq drivers though don't have boost frequencies in the
freq-table, they can set this flag from their ->init() callbacks.

Once all the drivers are updated to set the flag correctly, we can check
it before enabling boost feature for a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Stable-dep-of: 75120f31aed0 ("cpufreq: Fix updates of cached resolved frequency and index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/freq_table.c | 4 ++++
 include/linux/cpufreq.h      | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 94de089b14539..14584d0ba8530 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -367,6 +367,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+	/* Driver's may have set this field already */
+	if (policy_has_boost_freq(policy))
+		policy->boost_supported = true;
+
 	return set_freq_table_sorted(policy);
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a77efb227bc27..1416d3a005430 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -147,6 +147,9 @@ struct cpufreq_policy {
 	/* Per policy boost enabled flag. */
 	bool			boost_enabled;
 
+	/* Per policy boost supported flag. */
+	bool			boost_supported;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.53.0

