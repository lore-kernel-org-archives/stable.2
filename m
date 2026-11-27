Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786357;
	b=z2oYBnWrbK7hsJRpTFKLCP2XUwaFXO49sExvUES0zlDAR8h6+M4brmnBx/AuUj7n4IrP
	 HWx9NDz1/Bn1ATHMt5+H5IGdH2gnjvuTHs7Ya2PVVbjw7udGsHS68JYtSnIwbQsoZyyXr
	 w70HBd3b0JFccEULigX7dTeTBtASGOiBOecA3PtOTmtF3VlXf6bcqJrocdBnzTD9kWH4j
	 0UqT4FrfKS+IQ6q5zMjtBK+7TPOj6x/Fq5HP+Gu9sPfTwj7u3gDikk9HqCFeNIDXnFPW8
	 Zs7RqKGluyv0AmO4Sccc4VHL6UO0QBZnjtFE5jnHJjMhKqk5FSN3SN7Z0OyQKfs5cpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786357;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iSWbOSSEBtmBz4BmAl68bnywHwYp2BFmFo07moHtBKk=;
	b=2ezF83Yra95/bZKSDhLw6pJsLQXYTHkf+UcIHAUFtaiSDZzDr7VsqxjDx8v37nNuZF8m
	 5o2QXCtzOXRyorw1QvzCtd/AQ3GZQO48eVIB5dct14rqwkKzS7zw1sVUXOJQluHBSYKJu
	 oU1iac4bBzRqEowhg+D2WdoYXLeNAvbxC+0iJ1bm0gqE8XUXdJUHMwuiiKTtWYUJ0NKtX
	 Zb/gZF7yMLPlq+N35CniQET0DkBDreGahs0MNV/YP884fSnJOnJoDq19a6txgMUwGSwHi
	 PQelcYnj2JKOwa1Q7EDh7WQaiA/YGkeEixMZTgOPG0mdwVwHCrjF/+XBbVmYxifN7MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kb6z2o0X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1C606A323;
	Fri, 27 Nov 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kb6z2o0X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795786356;
	b=GhV1CNUjUf0B7B4evmbIhgoe+d26XZlIQ8k8NEAoUjtvR3RVZzTcbg7SmMfeIgsYGk57
	 d+oj89FyDyJksTXzswHXNDwOEV8ykyCQDKFuoaGRfKH8KnTcb/5G7DSo+HfaRkWwQMKiG
	 YbrOafvQmfPL4ZqHvvNksZpaYsSOxeG6s/C7YTw6TCVBr5+hFYp38nlt7ixgoA6Xdv+qQ
	 gtUEXeq9TyhEQWWnrSAjdkvxyiup0++bElRLA74pheUERaQSDqxkNA+D0mBStRyRLDPQD
	 FuIYK1H3xtgfZX7hpnHROVRIXmZwinB79RbmrMWeyMRMtX6qDu1YiAjp7CwhDxVUbBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iSWbOSSEBtmBz4BmAl68bnywHwYp2BFmFo07moHtBKk=;
	b=PzjDpxkOJBAda5auLx77/9qPZekAzH7lHcHZf/EmeIVmPwWd5KAclPaywxwRZrnu9mOg
	 CxX0cfkMa4SCQcLUwFtv7UExbriFxmGxZfoCYCEG7lnJC1gT5syTKK3kLBEBXsQklfXd0
	 tDdgq3YAMejapoVN/FW02Pv/7AsN4bq1Uglm8tX+ZVKlLnNbPENzFBLRrtl17eRVTJDjj
	 yyGeSSvVy+MefEX68fOgpCJ3g/MYj8tyG2k43ACW0c6RTqN0T1ADmYlYOg6lcPTX8+oMX
	 X26PKppGsE+cfCDznqRwo3K5nO1PCjGyj2FbdGxkQ5EsaKn6zCNRUK5iAYw1MqSTpzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C44031F008A0;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786356;
	bh=iSWbOSSEBtmBz4BmAl68bnywHwYp2BFmFo07moHtBKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kb6z2o0X+UYJESY5gKTbTWhme5+GPbxqCoNhA5NcMItAMTetFULozSVr0cmo5c3MF
	 AXhK6QBrGj+hajol2txWhLvU5tANPx0TdHok5XtFPDKrtQI21AmMQYre9/5ILIYNAl
	 77IxspBJjAIjKPIg9ipAyxrtLLr5YANpccfC6Lsttr8plnU05ykFYvuAAmCrNt42Hd
	 H7lfYVYt+/9lXhlp2jL5RIXr9emrrPmyHFUwIpGr8pXVGG50YdPxjEE3eXbQLlwGdZ
	 Sl3nyhvms4ZywXNQ2OejK7uCNw53qA898RzzwOAEgbkLm+0Jj5JMeaF2n0exQu9k3t
	 YOo0Y26oEepmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4E42F4B80C;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:32:24 +0800
Subject: [PATCH RESEND v4 2/3] pwm: loongson: Reset the counters before
 enabling PWM
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-pwm-loongson-fix-v4-2-607f325b74d4@gmail.com>
References: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
In-Reply-To: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Imported from f20260920-pwm-loongson-fix-v4-0-41b36b3c6497"@gmail.com, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795786349; l=1375;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=nEffXoAuY0LXvNjn27LU1Ds6mcGSPElXiuPjP4r7awA=;
 b=ZB6/mPRpggxjXqpMw+PQxxBcr7XBNTXFyP0f5LOwzzfn8+/KTNrnXSx27T4SoWr60ydsrGBSd
 lbdpV78SKvJCROA1kEtfRv87GHevahMN77XE4zJZGexQS+OIhvnZZHq
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
Content-Transfer-Encoding: 8bit

From: Keguang Zhang <keguang.zhang@gmail.com>

The PWM controller may retain its initial hardware state when the driver
binds. Reset the counters before enabling to ensure that the PWM starts
from a known state.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Fixes: 0de9b836a3bc ("pwm: loongson: Reload PWM configuration through counter reset")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 0ec773fba813..6f609fd0b90b 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -110,6 +110,14 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+
+	/*
+	 * Ensure that the values of LOW and PERIOD are sampled into
+	 * the shadow register when the hardware starts running.
+	 */
+	if (!(val & LOONGSON_PWM_CTRL_REG_RST))
+		pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_REG_RST, LOONGSON_PWM_REG_CTRL);
+
 	val &= ~LOONGSON_PWM_CTRL_REG_RST;
 	val |= LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);

-- 
2.53.0


