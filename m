Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E558F092;
	Thu, 17 Sep 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655035; cv=none; b=dPyupzKAwydjM52Wxi4tqgIyLkor7zcwXhS25HbfDDHehnMrOynPhw2yo1J9clX5lMqUT5vf2lFhXXvFcLlV2xjPjCzYFxyN8xrL0j8tD8wojuVJQmZyvWzGiGqpB4hAVhM3vxz+qkv1JIVooXjmJrXuliDcumpb6vhYLyxXK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655035; c=relaxed/simple;
	bh=AbPGuFvrX+Y/Z/llspYtmWkIySpxasLTu86xOBq0XPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NfPi+tskDQjnd8HJDvC9cdBPqVXQLVhphTpLcFUvjwxjI/3K3nfnWwfU7M/ClV/DltFX3zGvuCyLXm1vvJnbLNbeYMQGcb4F0vYy5iPzagwRapuqu8sybcNyn5celk29s9yZlc2/V5HzYu62SAG3FHpSV5aLlnOn2NVy/S3QFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+ELp96tqBV+CCA--.45567S2;
	Thu, 17 Sep 2026 22:23:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ptp: ocp: Fix dpll device reference leak in ptp_ocp_probe()
Date: Thu, 17 Sep 2026 14:23:37 +0000
Message-Id: <20260917142337.2156652-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+ELp96tqBV+CCA--.45567S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryrGrWrAF4kCr15GFWfXwb_yoWDJFc_C3
	4jvF9rXF1DuF18Kw18AryDZry0kFnFqr48Kr4ktrs3J345XFyYgrZ09Fn8Gw1vgr1rAryD
	ZasxXrsxAFsFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU
	rdb1UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQNA2qr9nADpwAAsl

ptp_ocp_probe() takes a reference on the dpll device with
dpll_device_get(), but jumps to the out label without dropping it when
dpll_device_register() fails, so the reference leaks. Put it before
returning.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/ptp/ptp_ocp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index beacc2ffb166..dacb941da8e9 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5106,8 +5106,10 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
-	if (err)
+	if (err) {
+		dpll_device_put(bp->dpll, &bp->tracker);
 		goto out;
+	}
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
-- 
2.34.1

