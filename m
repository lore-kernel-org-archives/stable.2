Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CB4A99B2;
	Thu, 17 Sep 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639080; cv=none; b=Alhm+2t+lDz4J63LkAwikj5QKH3KeTX5ATvbrefg79ZCkpMYTGToOd44d/lXWjxgVV/wpkRHTw99VCJQz2ohUS7br/U6aNpF+YbHHFWQwp6gUYBP4WYD+s+PMkDGLqcMALMmWBsINOvXmFY4hVPDDCZnH+qN0TqJABWy7EL9Y+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639080; c=relaxed/simple;
	bh=9SyJKiJepEfMQWbT4FNVuAnhkGCKZ4VOJepZafznQeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHxVl/tMUsz7lFkq9aqyILTAHoxvBqj05UAz3iKWZMFuYwLYhCVc5z1qQ6EwJGtfIUx9Jfb+wuW76YCunYVGj7GtY23t3BavIlQ4QgrnaMDH7GLo4TZQ34j37eBI5W3JHKx2asNkMe+HZoYVBb6v6tqXqKXpBNjtuLCBo5EbcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz2VuatqnSN+CA--.40646S2;
	Thu, 17 Sep 2026 17:57:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: abhinav.kumar@linux.dev
Cc: bod@kernel.org,
	dikshita.agarwal@oss.qualcomm.com,
	hverkuil@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stefan.schmidt@linaro.org,
	vikash.garodia@oss.qualcomm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: iris: Fix runtime PM imbalance in iris_enable_power_domains()
Date: Thu, 17 Sep 2026 09:57:41 +0000
Message-Id: <20260917095741.2145688-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz2VuatqnSN+CA--.40646S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4rXr4fWrWkXF13Xr1UWrg_yoWkArb_Cr
	n3uF1xXr45trsrKw15tw15u34Y9rZ3Ww1kJa1ftFW3KrW3CFn7XrZFvr98Aw47urn29r17
	tFn8CFy3Cr97ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8OdbUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRkwBgAAsJ

pm_runtime_get_sync() leaves the runtime PM usage count of pd_dev
incremented even when resuming the device fails, and
iris_enable_power_domains() returns immediately in that case, so
the reference is never dropped.

Roll the usage count back with pm_runtime_put_noidle() on the error
path.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a..d56bc8cc66ed 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -79,8 +79,10 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 		return ret;
 
 	ret = pm_runtime_get_sync(pd_dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(pd_dev);
 		return ret;
+	}
 
 	return ret;
 }
-- 
2.34.1

