Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FA3B42C2;
	Fri, 19 Jun 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887080; cv=none; b=uK1nosoJxHAsyVS1iWrEObkoZ4Q+bI5u0Roycct+NrOJZ2xFaUSzONs0rjV3ZGD8mzt5+ctIDE05Ko31biNiC6yOY3MTQsza71BizPdyNDoswGOUPDCyCiKJBuWhLdjlXA4Non0w/6t3H6GNBv2Aze5iZ7JAK8dCqpcNJqx8rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887080; c=relaxed/simple;
	bh=ZskmbQGX+wTrTq4oL6kwkAKc9As0FGX9OjT1UNB/0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU5SRLuBJQvTmfLSop845wzroNX/yPLyqjJUV42Qq7Ymnxybnc2NMtOHQTlwYvDl5iDeO0ryyFlNy75APAZ8VpoRBNneZtbY6vFlwURBh4+VVcqYsVN8axuqK3Kh96kwNEVTvkpIablgrPuVzCP/bqSMKigbM5g75zCsoR77Ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=kXR/6eg/; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="kXR/6eg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781887075;
	bh=4eKcsr+UzJ7qj5Jrxlc7lgXi8XIpKkEBQv5p5NC2Gjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXR/6eg/ArhsZTTjfyILfGroWjV+fetVxYz3k2a57vAJ5gtbF1M0oXhxCQWggkw1t
	 XcSp2ukDMLk//ODE3n0MCAqen6CFAhMKaVuDhygV/L5iqxTElMd8CMYYxSNkotJupX
	 4KtqaD8kIAngNsxWYSEmCOHfQP6zn79/juaJUrx4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghjv76zLTz115H;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghjv73k17z114y;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cpu: hotplug: bound hotplug states sysfs output
Date: Fri, 19 Jun 2026 16:37:18 +0000
Message-ID: <20260619163719.12103-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619163719.12103-1-include@grrlz.net>
References: <20260619163719.12103-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

states_show() adds CPU hotplug state names into a single sysfs buffer
using sprintf(). With enough registered states, this can write past the
end of the PAGE_SIZE buffer.

Use sysfs_emit_at() so output is bounded.

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0f32086f9ed4..dec58e19329b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2857,7 +2857,7 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 static ssize_t states_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	ssize_t cur, res = 0;
+	ssize_t res = 0;
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
@@ -2865,9 +2865,8 @@ static ssize_t states_show(struct device *dev,
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
 		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
-			res += cur;
+			res += sysfs_emit_at(buf, res, "%3d: %s\n",
+					     i, sp->name);
 		}
 	}
 	mutex_unlock(&cpuhp_state_mutex);
-- 
2.53.0

