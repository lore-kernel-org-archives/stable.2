Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8752CCE5
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691171; cv=none; b=fWgGOXZg5eZbQKFhD+dBMIcWo5k4pQTUJpUvoJuRaXfkpB5wTsg4LYq9Sgq05JYP3JBDAyxANIWsL1cSqRCAqzcGTWfE299UGAFdKEFmnG0x31Ad4MK1ipj7C3pgAFpRyWYSFGZZ7gCiIVQr6ClD6OzyJOYrVEK0KJ6GGvSEMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691171; c=relaxed/simple;
	bh=9N1F5istDqE0mS50NCZTlPTLfHoRo2M0dglBEkrZFJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syLzeF+SdnUlC1koDDblSxFcQS+sx3UBYcbpwaYgFDpUGJY/WWjKXHMa29FSkxqUQ0pec2mwYF8N5D825t30R1+UWhHzSmrXUvd6rUs9CDBb0nwR77JtWE2Dyn9zbqOVIlW3DGYDyl/9OTfKyHoDr4HiKnbkGvCE+GD5uE2janc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUH9EtKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUH9EtKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D301F0089B;
	Tue, 29 Sep 2026 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691170;
	bh=N6l2gC1eBBXQSJyd7pwfY3Xx4lYy2EFO/kkUQO5vbuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUH9EtKjUMQztfU06EIjZfj10+Q2cuL9ir8FBBOt0pUYw1CCim8WqUH5HCL1BBAXB
	 b2Jd8QOMI+7GVH9CvqmCwLsAk6uZq1ff+XJmeqvA7OSmdvRvzBi9XoQhs5+nomysoK
	 YSCI4OWGvex+YFrO9eyu2pkEBzDLy8Wk0+IoohozROxMR4+1fhRHpSh63qEYEYKN+K
	 6sh5Vk9V/tGjKvnplTGU+JFF9T3Ty12fKEArBuRM6kt4GaKwmGPdc955189HRsPGkz
	 ArhVnf6llHn2zrgh9V5YwIKyoKfKr2bm7qxHXUNuyBl1FoY7289SOpHhFsv5R6WTkH
	 +EObzyMI+j6MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Annoy Cc <annoycc@gmail.com>,
	Nemesa Garg <nemesa.garg@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1
Date: Tue, 29 Sep 2026 10:12:45 -0400
Message-ID: <20260929141245.3537826-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929141245.3537826-1-sashal@kernel.org>
References: <2026092942-evaluator-keenness-e26b@gregkh>
 <20260929141245.3537826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

[ Upstream commit 5271d81f99dd01d983d439930eb056952485e15e ]

The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
while leaving the TPS4 support bit clear. The output however flickers, once
link is trained with HBR3.

Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
which incidentally kept this panel stable. That check was reverted because
other panels legitimately need HBR3 without advertising TPS4, and the
per-machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the affected
machines instead.

Add the machine to the list of devices that need the
QUIRK_EDP_LIMIT_RATE_HBR2.

Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
Reported-by: Annoy Cc <annoycc@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
Cc: <stable@vger.kernel.org> # v6.18+
Tested-by: Annoy Cc <annoycc@gmail.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>
Link: https://patch.msgid.link/20260907034555.2753846-1-ankit.k.nautiyal@intel.com
(cherry picked from commit 550b703fdbb2a2022faa75b4b11ab135241afbd9)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index d1c428eeb6083..988d0de8645cf 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] = {
 	/* Dell XPS 13 7390 2-in-1 */
 	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
 
+	/* HP Pavilion Plus Laptop 14-ew1xxx */
+	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
+
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
 };
-- 
2.53.0

