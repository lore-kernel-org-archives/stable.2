Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578818;
	b=3q+R0FNhsd2O5xM1ovQoAC9NKJfJvmgwKWPpnMc/Pk2ipgSAu6HTFUteGGNXjKNUFj8Y
	 EhFtV4ycFKECPcbZIij2CmoceUI/MD2Z0aoO8IofwFg6KIpyKVaAX6Tx9+FkyK1SYlDPA
	 i7M/mZzRgZuPIoBD5mrnb2eJ359WMif4WyLQlpIUQa7biImTF+zir1oleuW7g99fsZ+Dn
	 BT5GhDXwAksgJtzl1xqAWaOrSXiIn2q7HUsZoEYThmWhcHyrJuom5aHUUbm+fwZe718RL
	 L7DX8hjABs6/uUuqsO0r8VVAvkGsQFItDXgTTh1Eh+cspmN2fnzdqhW+QkJ5WN2wl6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578818;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=4YqDcGEuaSb36r316ZVwy5FGXCUyHgkV+c2OUEDcpEA=;
	b=mm+ziKaXyLa+qjFh074ie+jH7258BXtLmwj5Bd23Y7Wq0txZKeBzr8w/0NVVeCqx72Ge
	 X15w+KxPPTd8opRRIbvNwObqQI/Uqh/ZY3CGKRuNqHgaG13P2lKeumgMH/CCv+slRKuOM
	 CzB78jIHcSPP2qdxLf0lrBYW3EsZqUCjNy5sA98/1/kq0BEKYJtyl/qBBSu+43Tm5pxVL
	 xBPQYqfc8lFxX/ibrdotaliN1L3HA0yffgsCT9RS+6aSxh4wFj3YaE623Q6G42U8BR29C
	 hKud+yHNLwMVTQqJhENw4nSty699yjeL24KXDSsMzqavHiG2Jx+TnCoTuYajy6wwKFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=WJI3udqY;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE63606A331;
	Fri, 13 Nov 2026 14:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE63606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=WJI3udqY
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 549b5a705;
	Fri, 13 Nov 2026 22:06:50 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] stm: Fix potential policy leak after device unregistration
Date: Fri, 13 Nov 2026 22:06:49 +0800
Message-ID: <20261113-4e14e563a1-stm@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa1d53b880f03a1kunm77b03e6248228
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUofVkhLQx4ZThpOH0geHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=WJI3udqYZzLZBQrdGbwBFX1jaUAYOIeLQHYmOg67TZS5luFWKQhwT6KysuieUWezg4T41ZjJC2zxQvSnOqbnK/nHQH4e1xeDmYWzXGLMFW8w6Frry66850NH9qaLgym92lMiT5o+pz0mQUR0ue7NunJKrwNZuomN1AkOq4SvWww=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=4YqDcGEuaSb36r316ZVwy5FGXCUyHgkV+c2OUEDcpEA=;
	h=date:mime-version:subject:message-id:from;

A policy can outlive its STM device. When that happens, device teardown
has already cleared policy->stm and stp_policy_release() returns without
freeing the policy.

Only skip unbinding an already unbound policy; always free its memory.

This issue was found by our static analysis tool under development.

Fixes: 4c127fd16e6b ("stm class: Fix locking in unbinding policy path")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/hwtracing/stm/policy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index fabaf4b14889..ec0c9f4d693e 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -354,12 +354,11 @@ static void stp_policy_release(struct config_item *item)
 	struct stm_device *stm = policy->stm;
 
 	/* a policy *can* be unbound and still exist in configfs tree */
-	if (!stm)
-		return;
-
-	mutex_lock(&stm->policy_mutex);
-	stp_policy_unbind(policy);
-	mutex_unlock(&stm->policy_mutex);
+	if (stm) {
+		mutex_lock(&stm->policy_mutex);
+		stp_policy_unbind(policy);
+		mutex_unlock(&stm->policy_mutex);
+	}
 
 	kfree(policy);
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
