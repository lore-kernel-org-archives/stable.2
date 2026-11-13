Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575177;
	b=fDE7VI74L2fBy5tQYNJ02UrmLX5pfmu9pMXWSAQDaw+R12N8TDkHjL9eKUXPdqy/b7CK
	 Ut2Wb+WJhxemCevwm6WpEq6XJaT5Qmu25Q9VSQu8EkaOoU/EHn1hmLNWJ7oIHKVpo6NXf
	 oa0xNPbGZs8iaqRBAYZbJi/Xw/r7O1y2SV2AAznZ6HRTzi1njJ497rSXmCOVUzigDvchL
	 sfTAaiIb0sV5cwrAOk88K5jkasjMJbbtElNOZTxQd5PABV1RSYC93NdaaUgSgGH3h12Yh
	 RcYAp2gPOlQPzPiFW6g304MnI/WYynYUs3+mjOxM+Yczw8gzGoFnh69DFO5wdK9BJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IEx4WFv5zRyoef/ZWpcPGipQSPgKlCPIgV9QMGzoM7o=;
	b=yDjhxhBwYTm++1o083TteHr8ELHjM6jB1MNl6DyfVS2bXnUQOBHCnUyJ8cSlhjrVYguQ
	 ANt7qZpoR8fkJiEX0AuL44jZx8cqDqFYBTdZy2hTZrzXQnPvAZo4lCasNhuB/xmodlhFP
	 JUEc3dGGEclvPG2YZhLCvIzH5VPgQ7R62C7hflGKIN8ZOeAGQJavYX8u0yGY/Rpt9FV3d
	 dWjjSwQUbelcnVQhWWTxUziGoMY2DyMua623/glY2dCYTFstjyBSsupsYe7KX10xnS7BT
	 uh53mbkO65E/KyUIKEtcWNFRA/mkEpgxTF8iHJouF9PRK8xWoNvdZSWgDLuEygCIy1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a+/IHOBT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FD606A897
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+/IHOBT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9761F000C5;
	Fri, 13 Nov 2026 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575176;
	bh=IEx4WFv5zRyoef/ZWpcPGipQSPgKlCPIgV9QMGzoM7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+/IHOBTolNLx8d4gvUiy/SbzM2U4+yfsnvjOog6U4iZFpk/gjnG3m4DseyHC4mvc
	 KWBDSclcVLQQTgpQ9E25ik9ADkiq69E25tXW+bFrMx125w43a1IhsaWHbaNXjhzR7i
	 2PELYOffo9B+0ttl3zEPAIW1rx4zOrhcPy6isWu2fqmdWBuJpCoa4kC3fKgRnJ8NBD
	 EXi/6Vm2t6ZD+6sufGd5YNKCGFbULk98Y15FCpsPsq7KHMpTGLeyUb7i6UJ9iOQ928
	 tsSfmyEEwvbyVaBTD4hK8A4l+Oc1oaaaQ2hkpR30VrWVvn5eTjdaySYIRuphA5I10F
	 SBfmOSyLn/6Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds
Date: Fri, 13 Nov 2026 08:06:14 -0500
Message-ID: <20261113130525.1058475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200339-failed-6.18-95638f1f05ce@kernel.org>
References: <20261109200339-failed-6.18-95638f1f05ce@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 95638f1f05ced75a82e83f610cd01b636d2a21b1 ]

In init_temp_data(), pdata->nr_cores is populated from
topology_num_cores_per_package() before allocating pdata->core_data. If
that allocation fails, init_temp_data() returns NULL with
pdata->core_data still NULL and pdata->nr_cores set to a positive value.

coretemp_add_core() logs the error without failing coretemp_cpu_online(),
so the CPU still comes online with pdata->hwmon_dev registered. When the
CPU is later taken offline (or the module is unloaded),
coretemp_cpu_offline() calls get_temp_data(pd, cpu), which loops up to
pdata->nr_cores and dereferences the NULL pdata->core_data pointer.

Store the core count in a local variable and assign pdata->nr_cores only
after pdata->core_data is allocated, preserving the invariant that
pdata->nr_cores is zero whenever pdata->core_data is NULL.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 1a793caf6f69 ("hwmon: (coretemp) Use dynamic allocated memory for core temp_data")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Used NUM_REAL_CORES and kcalloc() instead of topology_num_cores_per_package() and kzalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 25a9cf8feb311..03b40d643dccf 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -491,11 +491,13 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 		 * Will replace hardcoded NUM_REAL_CORES with actual per package core count
 		 * when this information becomes available.
 		 */
-		pdata->nr_cores = NUM_REAL_CORES;
-		pdata->core_data = kcalloc(pdata->nr_cores, sizeof(struct temp_data *),
+		int nr_cores = NUM_REAL_CORES;
+
+		pdata->core_data = kcalloc(nr_cores, sizeof(struct temp_data *),
 					   GFP_KERNEL);
 		if (!pdata->core_data)
 			return NULL;
+		pdata->nr_cores = nr_cores;
 	}
 
 	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
-- 
2.53.0

