Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528729;
	b=woyORmHBIWk/9kiE9jEKXVtqOEqCw7FBYD6xeaTn/xuyRQf4RBTeaDgQQM3eVOUjgzXE
	 vppDhpPa0AuNekadBh33us0Kywy+flXshI7AQ+gJI6owHlqfziwDaZusjuiCHwgGjARFV
	 59AAC8EM8WtfrHGgffqx8IY+vtCWHo+J5OTRt9ujtCqlEB21gkpreYEjbcvRVEif9UCEW
	 z/dE8pKiOUXf1TTFaOZqr/8OzKZDWH2cYAO6izlpMwIXar70bw/ddjYZB8lmQ1YWGduJJ
	 9KXQ2snrIrANS52KhYz1nyIUBUF7xUfxwQhsm2+OdbuibvLrpP9BMpCea36S/dbQgJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528729;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=5gSfmSe2FFDhLwZ91DEm5hYRWAqljw8ghWO0ejwJl7w=;
	b=HVoh+dFhJVhcEn7vP+XIAfjTUACPjRhQQsjMKa1vZu703UnGwiy+9UztJQVHBJpFkI4D
	 QYz2srbHKgT4SC2x1iQVAMfR693Z2jGW29eHWCk3TWrYVeR/iUjPcEhIXuRtNVBWrCGW8
	 qfgXMO7IBz84axWCKuhRzzQqwRhOSDjC+sNI8kDAQARKjuqEnYf/t2uQypEaWIXCTLfyT
	 s9eaSWyq4c1j7mzJu/W14Ffh0Yfm2qvtt1j7ApAXl8KBKkAodYkYKSVU11r2vuorgEzuh
	 pgNZDX1KQ0PSl2PwcYxXH3kaP6T6Iznl/VGrjV4t+b6xThWZJPbCxTRyUtnCaLmGXjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PGm67Vz3;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAC606A333;
	Tue, 24 Nov 2026 13:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EAC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PGm67Vz3
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdba2;
	Tue, 24 Nov 2026 21:58:44 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm_mpam: Fix potential per-CPU memory leak on probe failure
Date: Tue, 24 Nov 2026 21:58:43 +0800
Message-ID: <20261124135843.2276437-1-liguangshuo@mail.sdu.edu.cn>
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
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa20dda106e03a1kunm0af25ebf3424bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUJPVhlOS04ZHUtPSE4dGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=PGm67Vz3wVI0Vuw8LDonjTVzkmI8dWN0bbNybxX45V1nTloqfY6ELKSKYURkWiYCQXKnXAbRsUim/7pm4ptsSYN3Wi/sHUaU4wLuaNvklMY9FJQg36bzvgLLmj2ZqF+TEtuKe5SSQofEiVQHWGKDEiff6ZkjsKzlRRoqcmzu4d0=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=5gSfmSe2FFDhLwZ91DEm5hYRWAqljw8ghWO0ejwJl7w=;
	h=date:mime-version:subject:message-id:from;

The PPI device IDs are allocated separately from the MSC. If subsequent
resource discovery fails, probe destroys the MSC without freeing its
per-CPU allocation.

Use devm_alloc_percpu() so the device releases the allocation when probe
fails. Its cleanup remains valid even if the MSC is freed beforehand.

This issue was found by our static analysis tool under development.

Fixes: 49aa621c4dca ("arm_mpam: Register and enable IRQs")
Cc: stable@vger.kernel.org
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Use the arm_mpam subject prefix and describe a memory leak.
  - Add Fenghua Yu's Reviewed-by. No code changes from v1.

 drivers/resctrl/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 27abf60f4d67..ba341a6a59ce 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2351,7 +2351,7 @@ static int __setup_ppi(struct mpam_msc *msc)
 {
 	int cpu;
 
-	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
+	msc->error_dev_id = devm_alloc_percpu(&msc->pdev->dev, struct mpam_msc *);
 	if (!msc->error_dev_id)
 		return -ENOMEM;
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

