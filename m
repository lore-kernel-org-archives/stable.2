Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A948423C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075894; cv=none; b=ON9xkHSgL4iaQs/hLQpcNWGudzcSzTxwSCx7InsenafrksaD2Fxyp8BMwyVRvNP73aEb12GAS51V7NYmeS1QMPUKqpoJmv76JmYrR+rPm96eT0Ew2W+Xuqw3TVdTuhiD1ygU0dKyOYH8an5E5TFINxu7r2aZRwGHrDt+2fXVzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075894; c=relaxed/simple;
	bh=PteXAD1DPggMcw8dT/xS22YuwTISejXEqBeq+NyzCoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEnxcDNwoAIxiIDyJXGwrRuIysm/XboDpJ4Ey8srPT3vkJ3QXDc72Ea1ex4pZfEiEqHenF+2rr+UA/US742ppHr2Zzjxd3aeva5VqesMZkT83+ooudemT8XWCUQMXelEl6nkqc7DDqBpjzAofCr6/e9DMFU+SeOEUphhIRwmKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmUmLlRg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmUmLlRg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d530328efbso1133795ad.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787075892; x=1787680692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVwPxM1zwUuisKDv++BvBZsLlEbaJx1tUb1t0BisU8Y=;
        b=PmUmLlRgrMph6z6p9pYvFXEd3ULNL50PI0qWEnDIn9tFCOi7Sx9wGh9iBvhEVGm1E+
         Y4/LofSomCbm/St59kMy3GoYfvUjDDIlvLKUTuOn9GxUW1m2GFd4K98ko64aMPpzwEPw
         8lIF7zGTeqDTL+aTtYCyV3LLswH7ps6RPpmJwcPr3rzBdnm5jbYR+YXJ+rrNQW57ZbH5
         /d83208+aKZoKucfZTF270FF/FJbWtynkGcsDMcFKqazS04QcHxM2TAmSl9wcEFVrfpv
         azvexelKerHh/67vfLa5PxCdKgH/c1KpreXyd+KIU96C6A272WuRcXQPpt368snsrDjF
         1spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075892; x=1787680692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVwPxM1zwUuisKDv++BvBZsLlEbaJx1tUb1t0BisU8Y=;
        b=aWrjV3vJQJKgy6Jp3b7sraGBsoQBxErXlDTCclbsa+p7pp7FTsKSKIOYRfFrjz3+4j
         RCWZm8ISgXqwUb1RXWOTXAb2TQE8Pwc4i7QP8ar35FIhNAX9rPjrpxdXyEpMiKqBzttH
         +r/wPUYSEKBIDgObKuY5jKUrM2WwrDd2YVMR7YHgumlbbQU2b4nHJFi8tHKZ632egAmU
         7LDJpDz4O8XcY6uuD8mCp1eSmqJ+TjdKeyOn5d3TjEplcbklqGUYZYLefjkBDAEFPP+a
         kSzR+ov60R2itWi+liA1vrb5BP0XeugzkZ5cUhYgI1krWucC4WZR1qEOoLGKcY+o8HCf
         UNng==
X-Forwarded-Encrypted: i=1; AHgh+RqTq3gM7rU9TcM4BPhKf33ETh8CBVm9fDFo0SP0+fxxSXTrtkga0wTTej9il/nLrBWuTYp9/Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/aQ/+Ld7o27iKE2RmLL0Sm1aqSW56TlHGeItkNz3GeY0D1Wl
	o20zcrwNAGmlz6A0SOPhkWs+WesiB3U0Dk2yHcdlvJHcNZub/n3vRPqX
X-Gm-Gg: AR+sD10ltvsSQOszqouaowPuUPrYWqbE6EoM5cpYMANCjhdWIWu1yyzL94ageO37vc7
	c+mn5pqUZHCC4scUQVaVWwH+osOWGmhcpWdpWk0C4Lxr4NPK2kYwUO51im2AoiBGjR/PouMktl2
	2YfTc9zNozEzK3MPT17H3bUbKUnZunCdBmLDFJ72PIpw7avx8KdM5aREihmETUzeBaHXFfWwEGm
	oCGQEWxOVrBXgrhSqc5oqaTQmTdMFjsGmxPL0yzddGC2AtbN6S9sK6AeTEYmLTN7fmjDw9YmEC+
	vdh7kMNgWipZkgdY+xfhB57hqECJvAfn0ro+aY8VpnDvxMlhW5woR52oWtLuOAO3Qw4TptFD7u/
	255GpXtWgNbeGsN6k3cKRRB/8hlq7HUSn81yLe8CeJOe6KfGFLKyp81OcpuNOJU6CJBz6NRppJc
	+0on8j4cWQl03WgrFyhrhoRVSxX3yVV6v9YhYdB2BxGHSytcuyk1RCXGlHM5+3JZBDSgu5cdmEf
	Z9zJLtDDB+hsffZiOv9TqwZvx0=
X-Received: by 2002:a17:903:388b:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d5c4ee9c5dmr151317545ad.4.1787075891614;
        Tue, 18 Aug 2026 10:58:11 -0700 (PDT)
Received: from localhost.localdomain ([240a:4282:4801:1b98:2558:3176:8229:fc85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e8dc12sm17420645ad.56.2026.08.18.10.58.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 10:58:10 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: konrad.dybcio@oss.qualcomm.com,
	stable@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Wed, 19 Aug 2026 01:57:50 +0800
Message-ID: <20260818175750.4205-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815140931.53297-1-dragonliu2018@gmail.com>
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
making the put a no-op and leaking the node on every adapter removal
and error cleanup.

Use a devm action: the pointer is captured at registration, out of
reach of that memset(), and devres runs the put once on probe failure
and detach, replacing the three manual of_node_put() calls.  The
setup loop uses the scoped iterator form so the child node is released
automatically if devm_add_action_or_reset() fails mid-loop.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
Changes in v2:
- Rework the fix to use a devm action (cci_put_of_node) instead of
  caching the pointer before i2c_del_adapter(), per Konrad Dybcio.
  The pointer is captured at registration, out of reach of the
  memset() in i2c_del_adapter(); the three manual of_node_put() calls
  are removed.
- Use for_each_available_child_of_node_scoped() so the child
  reference is released if devm_add_action_or_reset() fails mid-loop.

 drivers/i2c/busses/i2c-qcom-cci.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c48..d3528c7d15bd 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -497,10 +497,14 @@ static const struct dev_pm_ops qcom_cci_pm = {
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 
+static void cci_put_of_node(void *data)
+{
+	of_node_put(data);
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
 	int ret, i;
@@ -516,7 +520,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (!cci->data)
 		return -ENOENT;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		struct cci_master *master;
 		u32 idx;
 
@@ -537,6 +541,9 @@ static int cci_probe(struct platform_device *pdev)
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, cci_put_of_node, child);
+		if (ret)
+			return ret;
 		master->master = idx;
 		master->cci = cci;
 
@@ -604,10 +611,8 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 
 		ret = i2c_add_adapter(&cci->master[i].adap);
-		if (ret < 0) {
-			of_node_put(cci->master[i].adap.dev.of_node);
+		if (ret < 0)
 			goto error_i2c;
-		}
 	}
 
 	return 0;
@@ -617,10 +622,8 @@ static int cci_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
-		if (cci->master[i].cci) {
+		if (cci->master[i].cci)
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
-		}
 	}
 disable_clocks:
 	cci_disable_clocks(cci);
@@ -636,7 +639,6 @@ static void cci_remove(struct platform_device *pdev)
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
 			cci_halt(cci, i);
 		}
 	}
-- 
2.55.0

