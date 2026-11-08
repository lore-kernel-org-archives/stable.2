Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129835;
	b=0XIrzf4RMxJMPMnMCmSRsXTkv9Q9YxDHiHn1OP6g98sfwwcMf78y3a9GbxxX8Wvf3Xc4
	 zs8RdeXyzhUDJpX2kEKBRS51KAp6CQlRJsxdE6W2xjPsG8abayZ+syVf4EhwyvK3LJGoY
	 ek/RWXYqeBYmssqgDWHJ0gAi7Ik20icONRQXS+070UggApxPIqY84D20UTCNWcyy/D7U4
	 4CcY+8+BsPpjGM0wLVLE9s8r2QqOw/Uwc4Ox53D4Kieq/bPWFXwzbvnhF3nS1hRyz0rI6
	 hfe5lKERMiAdh/lcLVNuQyrCaTJM5T2qVcLIFXiZ9f1vhamDLX/h9kXXHsDOhCUd6YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129835;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tFFukMiDzJt9S0fOOUEqLbI2e2gAGmA6iCuWDckb1mQ=;
	b=C/eC9zOVtwy47Wkn+wVjqc4n071l3ldQv2X3m4BD4cxP6soGJlwEDd6/R8bTwGbEUaeu
	 MSPuTjNo5WvcQGZ8Q/BPkUbrI1umZpXQJ5vvyeio1Ac21bANaVUiS0BZXHEOPEXfempoD
	 nhMGtXANqGMMlnxjQKpN1yn8/zQSWhQMBBdVX2/dvQeYtAe+013IaoQ2/YpDE79MT3AP3
	 m9Bag8MuiVz8dBD5bdRqVCUuNjKAenA+LJZx1P8G05pJBCos6POvSA9Ca4/m1S1rBtpn9
	 4/3roZ6FSN6qNqcIeDia5K8NUkiX4QPSl1hnhU5VnwYuSrWL+zom+MhfYpySN3D2A0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8587606A31C;
	Sun,  8 Nov 2026 09:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8587606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB31bqkP_Bq6o2YAA--.17700S2;
	Sun, 08 Nov 2026 17:23:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dudl@cypress.com,
 linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] Input: cyapa - fix runtime PM leak in
 cyapa_update_rt_suspend_scanrate()
Date: Sun, 08 Nov 2026 06:45:47 +0000
Message-ID: <1794120347.2701234.vulab@iscas.ac.cn>
In-Reply-To: <aqwD1o6J4svIevWW@google.com>
References: <20260916185015.2093520-1-vulab@iscas.ac.cn>
 <aqwD1o6J4svIevWW@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAB31bqkP_Bq6o2YAA--.17700S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kGFW8Cw13Xr4rurykXwb_yoW5uF4kpF
	WYganrKrWkJw48tws2yr1kZFyFq3yakay5GrykJ3W8uw45G34xtF1UJrya9F1jyryxCa1q
	yF1Fyw4ayF1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUqUGOUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAFA2rv4qiTXwAAsJ

Hi Dmitry,

Sorry for the very late reply.

It does not have to be the "sync" variant.  I used
pm_runtime_put_sync_autosuspend() only to mirror the normal flow of the
same function and the other runtime PM call sites in cyapa.c, but there
is nothing on this path that needs a synchronous transition: no device
state has been changed yet, both put variants mark the device busy
first, and cyapa_start_runtime() sets a 2 s autosuspend delay, so either
of them would only arm the autosuspend timer before the store returns.
v2 uses pm_runtime_put_autosuspend(), the counterpart of
pm_runtime_get_sync() for devices that use autosuspend.

For the record on how the patch was produced: the candidate came from
static analysis tooling, and DeepSeek and GPT-6.1 Sol were used to audit
it and to help write the change.  I reviewed the result and I am
responsible for it.  v2 is build-tested only: it compiles cleanly on
x86-64 with CONFIG_MOUSE_CYAPA=y, including W=1, and passes checkpatch.
I have no Cypress trackpad to test it on.

Thanks,
Wentao

From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Sun, 8 Nov 2026 06:45:47 +0000
Subject: [PATCH v2] Input: cyapa - fix runtime PM leak in cyapa_update_rt_suspend_scanrate()

pm_runtime_get_sync() unconditionally increments the runtime PM usage
counter. If mutex_lock_interruptible() is interrupted, the function
returns without dropping that reference, so the usage count stays
elevated for as long as the driver is bound and the device can no longer
be autosuspended. Drop the reference on the error path.

Use pm_runtime_put_autosuspend() rather than the synchronous variant
there: nothing has been done to the device on this path, so there is
nothing to wait for, and with the 2 s autosuspend delay the driver
configures the put only arms the autosuspend timer instead of suspending
the device.

Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Apologies for the late reply.
- Use pm_runtime_put_autosuspend() instead of
  pm_runtime_put_sync_autosuspend() on the error path: the synchronous
  variant was only there to mirror the normal flow, and with the 2 s
  autosuspend delay the put only arms the timer, so there is nothing to
  wait for.
- Link to v1: https://lore.kernel.org/all/20260916185015.2093520-1-vulab@iscas.ac.cn/
- Link to the June posting of the same change:
  https://lore.kernel.org/all/20260609004617.175476-1-vulab@iscas.ac.cn/
---
 drivers/input/mouse/cyapa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index a8e9b9ab9f84..737fc54539d9 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -900,8 +900,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
-	if (error)
+	if (error) {
+		pm_runtime_put_autosuspend(dev);
 		return error;
+	}
 
 	cyapa->runtime_suspend_sleep_time = min_t(u16, time, 1000);
 	cyapa->runtime_suspend_power_mode =
-- 
2.34.1

