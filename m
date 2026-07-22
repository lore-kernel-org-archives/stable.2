Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818C361657
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681446; cv=none; b=b8rgo7TrkiE7dUVEFPUlChNhbAHmUdcTqiKkCU2GR6z65h9VWIkXu8JIXM4QOjgqvs2dcoyDdVf2GZJHaw5iVTvyfsayH4ydam/oqI/1jnsiDi9C04BBm+1xexAjlMhnq+0NGDiwahzPu6BNVPHJS/OT+5Ba+UOhnDkFGKY0E4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681446; c=relaxed/simple;
	bh=pytPMaqIE32sEZ+xsapNrzwAUubBej0zF7BlZebiiRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMN8UEfCjvdSUg6gCDikHThn9ZDhtWE5dEedLoU7FdnxZXUKi10xTtyjkZ5ayM/ByIAyZKgrQQqrtuzym/jkVbeY3wjnla9fgTG64GGhDjVwt0sHJsrmuQdH+w/rg1DvCXRxM3k4wU2rtIGhx/hqI3C/CtHjnuimltjlKCHX2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS+yLIlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS+yLIlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D30E1F00A3F;
	Wed, 22 Jul 2026 00:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681442;
	bh=LFfxXskAQnCGACveIxQm64UoFQQqytRmZaNd7PsXChk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VS+yLIlDecsMhuf4NTq8TKo+dIcb7a5ygm2iP6LN7kETO04nxah1ViYFtS8yjUkPQ
	 BFNEX6RFhVbMJ0ZASPV0sfv0R6ZExY3CbYMsUUSgVBUtLI4azT7RSaPjsExovhGxxC
	 mu/tOCc8D12c2RAEKOh2d6s0dm3SZIcbi2phszPh1KKfxCk77bdnLsmFtNdKjFAfYs
	 PrweSIIzl82LLJaQKZUkVQPxuNkYKgjI4ghn41EwK7/XXbN5Ta1rdLOyjjEH0B9D3s
	 7i8JAxZThVMxFvhwkTCi1Y7/+1+DT7Y+w2wpOdQooDdiz9wm4ef9U7owlnrrgLp/JO
	 mFsPbfUWPg0cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Tue, 21 Jul 2026 20:50:40 -0400
Message-ID: <20260722005040.603782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071620-amuck-discount-27b0@gregkh>
References: <2026071620-amuck-discount-27b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit e43f32816a1b1fe5a86279411626fe3a9be56d45 ]

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260610030513.2651018-1-haoxiang_li2024@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index e9d07323c6049d..56447ba98e781c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -874,13 +874,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
-- 
2.53.0

