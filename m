Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701730;
	b=vX6FPGdhuRxhA/wJkFhq85YdE64jPHZNWjJ5q6vcQ9gHNr/I22StZPRR8daCsiQyZGxa
	 iHd3kn6cTgPSUq6gCDLy5FGg2oDhpOu249MrFOJCwCMlTRArNJn+WPbnp2u7mcdyV5DHG
	 lg8kAVNdptEikmFVWoTpaixKUKQhMnBhgZVWFF4vtSY2wZOaI4r4x/ypPG2dzQmo09Y+c
	 OHf8utZrOJ/87qDzCKLx6gP57lDsc2T0U+5xiOpgLIg0hTJpwE4Onbg+AWhUIrM9SRnRK
	 4MzlxQPFtLTyH3BPKjp7ZEXjrifUItx4doBO+7Y5JGOw/ivfd5/583m+LjJZyMNVMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701730;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=J/CHTWTxLznWvODPQ4Afo29zCdiwl4//kWg7/xkmshI=;
	b=mb5mP8OXchwkXKGYvtvz1DmyXeXEbTSLw7I1eMaFXhkLrcrmZRjTJS8jVi9ftr9+Qfnv
	 /vfzEMtkEp7JLE0KC75unTrAXsKkog0upgNasNoZEZm1V8NA8Ru8Yz2Vi8/ScSxYooOBk
	 kgWp8xmivrGFvTsEs2RIaN3zuviqLFB3ll9j3K8M0bDgG4UTHc7YkHEOXhH+S2rgV7WKH
	 xHDuV66MhNuRtd+TO082og5OoOx//Zss+BNLY10Q38t96jg595gyhY6UFQPHOM6TeenHd
	 Vxg4hfDh5K0DqrH2z0RGdZk6VYgqE4sApbbqzBQLoMHkXkx4c55UnPCYyaWsHLiK4EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2293607153E;
	Tue,  3 Nov 2026 10:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2293607153E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHk5Rat+lqb6k7AA--.6253S2;
	Tue, 03 Nov 2026 18:28:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mlxsw: core_hwmon: unregister the hwmon device on event ops failure
Date: Tue,  3 Nov 2026 10:28:50 +0000
Message-Id: <20261103102850.1340455-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowACHk5Rat+lqb6k7AA--.6253S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4fZw1kJFW7Zr47Xw15XFb_yoW8Gw17pr
	WrGa909ryIgr4jvw48XaykXFy5GayIgayfuFyrAFWfJF18GrW09F90qF1akF1UGrWUGF13
	try8Zw1UuFZ8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCT
	nIWIevJa73UjIFyTuYvjfU7nmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkAA2rpnIRz0wAAs3

If mlxsw_linecards_event_ops_register() fails, the error path calls
hwmon_device_unregister() with line_cards[0].hwmon_dev, but that field
is assigned only after the registration succeeds and is therefore
still NULL. The hwmon device returned by
hwmon_device_register_with_groups() is never unregistered, and the
error path dereferences a NULL device.

Unregister the hwmon_dev local variable instead.

Fixes: 99a03b3193f6 ("mlxsw: core_hwmon: Add interfaces for line card initialization and de-initialization")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index a5e7aee730d6..16644f367df6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -920,7 +920,7 @@ int mlxsw_hwmon_init(struct mlxsw_core *mlxsw_core,
 	return 0;
 
 err_linecards_event_ops_register:
-	hwmon_device_unregister(mlxsw_hwmon->line_cards[0].hwmon_dev);
+	hwmon_device_unregister(hwmon_dev);
 err_hwmon_register:
 err_temp_gearbox_init:
 err_temp_module_init:
-- 
2.34.1

