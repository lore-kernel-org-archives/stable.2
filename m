Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578991;
	b=BQn0fJUkU2RScP4BjT/zQnCwpK2L0e/XHEpKjdtaGOAHL5p19UerpkUJFl4ASTlon39H
	 KkB3zyoLnVDp7UHqqgpWJZuO6k2byucqpcD/lp+2zpRv3KJD1lIDodGuDQwOo7T68oq/e
	 AyPWKagd3czJzIP1WnNbCn7wo2W3IzuUhcejelZOFXgt7mcRtS9AN6v+ha6W64LdGQHAs
	 gcO36NxWt9iRKbLVX9VOJtntzR8yUZ+UXvUCjR0lx+q6+2zwDz/CA4dphgmHfnTAARAsW
	 sv8N2ue0mEk/g0e4XdzaxmMC0e6CFgsQJC1kpoD8QjGV07/fe8FkzDVKFiPSRjlkhuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578991;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=91M3ZRzTa6r+vtYF4xUq8fttGYwuNmT1C5OHT99A86Q=;
	b=2csjLfEAA/wtB/uUP0NNxPABQfHShjH4NR1wUuMzUwWswhtCCLVGj812hGIRKRWTwb3w
	 WRI5I6BpCn2GHwqo7UCmnhaZPLX6OS1rQxzuos7lK3pkArXuKu89F6Grc3+pPr15Srm/W
	 S/tMdUjFblQCA5k9C+Y5is0J6xAUmUA7rHw1SV/c+KJ+DQ0EoW7ylh41w0yIUDVzDG/92
	 I0CcK8XDPOucb4hiutCVfOA8dqyQ/fEO/UwmR5XNsDd3ttuDmnbvu5bYsmKBs0enrS76p
	 CwkxTCQM9Zm+t8tcI8TcWF0IigCp5gStUQceZR/m6n5OpamvbHidvLFZ6ZVJbMomhrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HG4M0Kco;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84227606A323;
	Fri, 13 Nov 2026 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84227606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HG4M0Kco
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 549b5a75f;
	Fri, 13 Nov 2026 22:09:37 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powercap: arm_scmi: Fix potential stale zones after a skipped leaf
Date: Fri, 13 Nov 2026 22:09:35 +0800
Message-ID: <20261113-4e14e563a1-powercap-scmi@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d53e10eb03a1kunmfd39574c48410
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUoYVhlNT0kZS05MSkpLSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HG4M0KcoHMatbqoiBpR5vaR5b1PH1rT1sVRJEI7eCjcJqQFgIjdk1BkdbWdLItdQjr8b6kvfwtV/3DzoavR66zUWjZ1ACPpOoQHf0yDXQAWjnvg12Q4WBdrXJWR6eFRjmTm/AqHQvxaa1wlJZPVgGXUk0kj6wQ9wrP6bu8KGVqQ=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=91M3ZRzTa6r+vtYF4xUq8fttGYwuNmT1C5OHT99A86Q=;
	h=date:mime-version:subject:message-id:from;

scmi_zones_register() skips leaf zones that cannot be registered, but
returns the last leaf error when that leaf ends the traversal. Probe
then fails without unregistering the successfully registered zones,
whose private data is device-managed.

Return success after completing the traversal. Keep the existing error
return and full rollback for a failed non-leaf zone.

This issue was found by our static analysis tool under development.

Fixes: 3e767d6850f8 ("powercap: arm_scmi: Remove recursion while parsing zones")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/powercap/arm_scmi_powercap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..edc1e2823ec3 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -407,6 +407,7 @@ static int scmi_zones_register(struct device *dev,
 							       node);
 		}
 	}
+	ret = 0;
 
 out:
 	kfree(zones_stack);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
