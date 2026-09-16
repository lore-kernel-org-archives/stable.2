Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEA3D7D80;
	Wed, 16 Sep 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551851; cv=none; b=UP1+bPCLs1ZKoMtqFL972Ez+zZVRGR9SWN7QcAL3eZVnJKrzwxJoZn84OVtG9I5wa2AXshJQgxUekFVmbJE00l08tMBAHxVlaasgj2Cf41gDkID6pQvLyyiKNpETbH/X1catng2qBT3F/TQXzksGIfXRj+Rz2Xu9RBAVNpMavmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551851; c=relaxed/simple;
	bh=Z1I0b+XfzGAd6V3hB26/mUkiALEm5kNlbelYPOq7Nws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+X3XVQxxiQs2w8nnz8+zGPaJFNhnjoGRnoJ2QqEeXx6JtVEp9ozytVVm2t/HWF4Ib/vjQT4kB+OwO2Z4b18zJZT2Nj+0B3AJxz0hVMfZvI6voR7h5GrLMwR9GjLz7T8BR01o8Y51R5u/7XH2YN56oY3KHk0tBS1/MhYQQBwHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABnaTfWZKpqZJfgBw--.15904S2;
	Wed, 16 Sep 2026 17:43:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: eajames@linux.ibm.com
Cc: gregkh@linuxfoundation.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-hub: Fix of_node reference leak in hub_master_probe()
Date: Wed, 16 Sep 2026 09:43:22 +0000
Message-Id: <20260916094322.2006647-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnaTfWZKpqZJfgBw--.15904S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GF15KF4xWF1fXr1DWw47XFb_yoW8JF48pa
	n3GFW3Krn5Ar4Iqw4jv3W0v3WvyF4FyrWrCF40ywn7u395JFyaqry3Xry09rnrCrWrCFyF
	yr1Yqw4rWr4rAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
	1rW7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqP4ebHgABsu

In hub_master_probe(), a reference to the device tree node is taken
with of_node_get() and stored in master.dev.of_node.  If
fsi_master_register() fails, the error path releases the link range
without putting that reference, leaking it.

Put the device node reference before returning on the error path, so
that the kzalloc() failure path, which runs before the node reference
is taken, is unaffected.

Fixes: f6a2f8eb73f0 ("fsi: Match fsi slaves and engines to available dt nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index e5ac9025762e..9507caa78358 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -240,8 +240,10 @@ static int hub_master_probe(struct fsi_device *fsi_dev)
 	hub_master_init(hub);
 
 	rc = fsi_master_register(&hub->master);
-	if (rc)
+	if (rc) {
+		of_node_put(hub->master.dev.of_node);
 		goto err_release;
+	}
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
-- 
2.34.1

