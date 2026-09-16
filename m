Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DD4D9F6E;
	Wed, 16 Sep 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584651; cv=none; b=oOLHCVYYLDDGs2mduUUONpuMTg5MA/BsqeaERJkafmPu2gOjXsPbAhwnlqvkZy34rfibX9o0sUNFRdUeLbAG3N+h+1iUfZDdoi1rf/1MzXNxX5LZGhg9iU3YcI+qBGzaX0JNjXCUMvDb3iiPE7W2rtnuZ1VH+XazdNAg2BxtyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584651; c=relaxed/simple;
	bh=LhTqE8vKZ29JSFqeyd0ItbUv00Wo125vLHNr89gQ5ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDPUYi5q7PCgr66JGxRd6gHmdzfMwk3o6WCn+5orQnZAhk3M/KPbJKZ0btuUMB14sYh08xPcCgulWDl1HS8zI7ekmyAjFn1jthvNbejUUQlFDFLhk6OZJG/PoGrtIsajNmn6roVAhtWZJ/2Ok66I6xetwEBnJyw02VZlq+eX1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXiEID5apqMt9vCA--.24677S2;
	Thu, 17 Sep 2026 02:50:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: dudl@cypress.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: cyapa - fix runtime PM leak in cyapa_update_rt_suspend_scanrate()
Date: Wed, 16 Sep 2026 18:50:15 +0000
Message-Id: <20260916185015.2093520-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXiEID5apqMt9vCA--.24677S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1UKrWDtr4xKF4xGF4rKrg_yoWkWFcEgr
	1rZw1kXF15Kr1DtwnrJwsxZrWFqa4vgw18Ww4Yyr43tryjvrZ8JryUZFZ3Ar4kX34xGw15
	Xws29F9xArZ7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUBT5
	dUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqozWJrgAEsh

pm_runtime_get_sync() unconditionally increments the runtime PM usage
counter. If mutex_lock_interruptible() is interrupted, the function
returns without dropping that reference. Add the missing
pm_runtime_put_sync_autosuspend() call on the error path.

Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/input/mouse/cyapa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 6e0d956617a1..5edf4fdbb373 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -901,8 +901,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
-	if (error)
+	if (error) {
+		pm_runtime_put_sync_autosuspend(dev);
 		return error;
+	}
 
 	cyapa->runtime_suspend_sleep_time = min_t(u16, time, 1000);
 	cyapa->runtime_suspend_power_mode =
-- 
2.34.1

