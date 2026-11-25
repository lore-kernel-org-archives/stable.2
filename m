Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626569;
	b=y44sUIjTMh58Byqlrz3lH2r9DseDKAY0q00iBKE1fja9c6ZXAB3MANUSmfMBeGTr0dnX
	 5YzmgEczvYbXc2pp2wtK4Z2fFpHWLLXlwH1LLU9Nv/+wSthfo3eoRI5FZvXuEp0t7M7Fw
	 wzB1ZuVtrWHsEhkoEY48J6ZqdhxS9ehRQvMpw4YsSKvpNvWX/SsYKMRxMn9Dh3cWph+QA
	 SE4mxAeIoY1VZ+Q7I3DZt3/4jaCRVzOx/zFNPL57oUkSiAutZCjcHj/Xhu4tm70BQO7L1
	 gEqq/VoC16CVmBfN1rExwZ3lsLPLwWUbARuQYaZQRobDbOOZejKyIXz36eyFz62s6hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626569;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QqNyLuqq7WdQMksouf7hJzcDjtuLotU6r6O5dnLigjk=;
	b=GErRrputjP8dPsWPcwDuDXe7BTHGpuMwUMZiUFJk39L0et7i15mMIl6Qg9Ot8dsGXl2s
	 oDZ2SH7UMlTXVxNMVBN9KP2VSSrmbUYXH1h6/bYIGOgPoUqXyMJxbrv8FUvrStknNDbH1
	 q54NTrZJFl8oQ/c37f+UTEN5NF0J1Kk/EW4N0QAgAE48yUW9Qd/OEV6jN4IC48L/mqo9H
	 NDe3Qc3sS6xtI7OPNobQ2R4JbGzQFXmQwM6Xng8Zr7juVvIEz7Cx3g/4tRmJADy1NQ1C5
	 ttCrva02yDsPx0U/LeVpgNrzca9gjZeU5iVuVcp28YYed9y6kjT4cnvrA+Ej5j9IbPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PnJEVc/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnJEVc/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28891F000D3;
	Wed, 25 Nov 2026 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626569;
	bh=QqNyLuqq7WdQMksouf7hJzcDjtuLotU6r6O5dnLigjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnJEVc/BzDdWSZ1zTa+FlRcUzD1vTQNC8TRY9jRoxXsR0lcobavCof2VNZr9iJzm8
	 akwa7Num2AS6gjntDyWoq76KCKwDXaty9Hi8Eqx4NRlpi98/Vs8hTf8Zwh5iAHfHbm
	 V0bhVl2IyY5pgBuS/HVicO0B/DbTRnlnjyADV3UOJvS2Zu+eLr/eCg+zKjH43XdEMY
	 npzT5xttCqLaifmoNGRmaPBZ7gshEcutJL/qPQKsRIQoq/t6ezZk0NeHKiEwiK1rxP
	 bV1hkPFu4TYRH4y2c4LvpzKbHa0eHpOeXK3MRkIW4GpH80fe5vTpbqt7vcKXOBbjjA
	 O0c3E5jd2AWTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] cpufreq: Introduce policy->boost_supported flag
Date: Wed, 25 Nov 2026 12:09:25 -0500
Message-ID: <20261125170915.923901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-unwomanly-unwrapped-9118@gregkh>
References: <2026112538-unwomanly-unwrapped-9118@gregkh>
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
index 178e17009a16e..9db21ffc11979 100644
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
index 1e87507ea16ff..3ad7964711cb2 100644
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

