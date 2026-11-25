Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624712;
	b=D/zJLU9bRG4BrY66on6tR6JLRgvucjJpCmD3YoJ7dq0HuQ6lTx9cnZY74Q+1fWIEDQWV
	 6gCuN3hFiF6sc8Id1K1uHWTXpkEZJIoipqa3+6OQk4LusjnpV/wvzRY3JOxmEASWXMrbK
	 YS9BTSCnWgbZj0Jj9Zn+5PcQkaxyY3ldtF/31/88dUgAld/8/WbAxARnHWglj/QyfjzZI
	 sCkKGhvEVLsPA47nSiUL7H/POMFyXU5DfR80gjEz3RJmAT0NM0mVgSxL2Z+KGxdD5kRgK
	 qPH3l9oUwJpHvtNxLXnyI3DLUZf+HssLt1HFtsreICX4M1+MwgtcvtZra9OJbnU3VvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zQ/EUehyp4WebMyqGWAXQoMcdxZ51tO77kcC2LOQiOA=;
	b=d2CCRUpSMp4CQPmDKoYoMMp0Uqn01UjydWaxdR0nKTLedxtGEb+Ub7ARoAjW9VSwiF0f
	 kugdtB6c7Gst2EM6NmbqPHpPSWsJuu8/OFpgJmeXfUtPRFeCx7yE/UfJxMLVEFMKbcf7W
	 Z8K6OnRyXGekSPiNEPAG11zBFzf0D2b8/hO+EcJzOz4Ah7NCWyOSchHfbsuHR2B7sOCI2
	 eOQxgavhn9duL2ENa/OB2SdeyIYmeWf4PPvIsLExFrbpqX2qiQkQUlHzaUgpCa5oDX8Dr
	 bNmsh/oQdwF8yQz5pefCuwUiMb+kCx6CNJr662pNMPj26FeECLN34392PPPAmqzpDYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBt46S2U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF69606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBt46S2U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020531F000C6;
	Wed, 25 Nov 2026 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624711;
	bh=zQ/EUehyp4WebMyqGWAXQoMcdxZ51tO77kcC2LOQiOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBt46S2Um05UQ2wUmrkNiMb8B0dj89mJT1vtH9ln4bITLt7Gy7civhLO/Mj+8T1im
	 kcZe3Z187drSamM7E7QTLeUt9vK9Nm4IGtGciBRf6IHIGxotWfKiyo0BL5RGQgoKxh
	 NIYV9z2WyBgL8h37ZXjuG7i28ukKQMDU4c9aXxc4pKhd4WU9ZnsCTJg9cmyJ7wImod
	 06ICU1JvLL70PQLr4ed2rQJYztk+2Cp7pS5wCA6vucCIMizd3I3fgmnUq4K+I2Wcrx
	 Zrr/UwKyXuJ75yht8FvwC3Gvj73qYTs/haLy1g/sl+78JNGE5crma+POjJP6rPp9Ei
	 Ztzzkit9MlV7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] cpufreq: Cache post-resolution target frequency in __resolve_freq()
Date: Wed, 25 Nov 2026 11:38:25 -0500
Message-ID: <20261125163734.823203-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125163734.823203-1-sashal@kernel.org>
References: <2026112528-unscrew-recall-9dd7@gregkh>
 <20261125163734.823203-1-sashal@kernel.org>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 166207cac45191637c47a457a5c16ca6b6773a16 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 134e42091e677..3ac8936090d66 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -541,8 +541,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
 	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = target_freq;
-	return policy->freq_table[idx].frequency;
+	policy->cached_target_freq = policy->freq_table[idx].frequency;
+	return policy->cached_target_freq;
 }
 
 /**
-- 
2.53.0

