Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E146EF60
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663317; cv=none; b=Q5Qvnh+dcDGidl2xRD2AGQcusr5c/omF4HlmYOL/R5LwdnwlmObs7SuLySo0h9ClulLJCa6v1kmh2S+6Cycc8e6B7eoFYLCka8t4J41hrgsp5kjH224j1Hr5KbPnJmyPwdjBk90A+gWs+lI484RFdga1d/6GBgdUgSWe5BQVpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663317; c=relaxed/simple;
	bh=nzHwOz5WsahsMVrRtMjM62EINvbS+CRqRQSUJ1n5rlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chhi09UwVcmWjGnnsmxMNihBFFOxaqakzUyDO874wSwQ4MUBw51w+rvNdTjuex7E1qcRwHgWecbdpwxf50To+7fa9rA9xdRKgD0uUfNxdmllWt9mgZ6Xy+PPhNkWUIge3F9BqMkRGlFuJV3YrdOkSAyL8LcJr8QgS4mkh85OJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzednLoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzednLoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18301F00A3D;
	Tue, 21 Jul 2026 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663316;
	bh=nVFEhs2pkCVWWr7hzJl/Nm/U5bHBI7A1Iy4C2cWjPAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzednLoTBwptNpptDMICxmYkHup/3vO8/jCy0plOpRnXZkSVTpa1R7abwd9lwwwrt
	 GTEeOXAIpL+Cvvjzij6zN/zvVi6dYhMvmDT+310SDZzc9tX1qYmkwssiEev96isFMH
	 GQ8ly02kOnThXSxBfowmo/jmvVljviI4OQN0wUz6TbVtErqGZrL+1sULnxVjWInIi3
	 KjfI4CS8XNn7dyOuy/4o+p3amMTCjFTdgGxlVxzb4Y6u3ShD+gtVvnawNkxZJgYABK
	 bTnRac+/g0L8cb5Pd0+Oi+wu7S6DplAKEeeC2rFElWRQsC6fuNY4KZLTIHPEkO5HOL
	 Dpd5VIIRqSS9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] i2c: core: fix reference leak in i2c_register_adapter()
Date: Tue, 21 Jul 2026 15:48:30 -0400
Message-ID: <20260721194833.416799-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721194833.416799-1-sashal@kernel.org>
References: <2026071656-confess-dean-8762@gregkh>
 <20260721194833.416799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 3f8c4f5e9a57868fa107016c81165686d23325f2 ]

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 60f68597024d ("i2c: core: Setup i2c_adapter runtime-pm before calling device_add()")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index b529eb8214fcc3..cb4313d50c6011 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
+		put_device(&adap->dev);
 		goto out_list;
 	}
 
-- 
2.53.0

