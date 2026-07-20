Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624A2E7366
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559654; cv=none; b=YFHwTH6v/VSf4PC6z9ayMUo2CC79XvwVMr9hKfc/dvmGUsXgotRRCyh6cx54pcMZeIrWCL1jIzcvzXAZCNymQvjY6e9s9Cc2TBqSPTLbL2nc8i6Gq6sf7jB8UUWGaLwBYlrrscWwhPVrC/5jR7x1vrZOEd1qGBaurZAaeVBBG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559654; c=relaxed/simple;
	bh=ynHz8i35Cih64drClYB8S2HBOgMWvbsAOVJYJfhMZaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kojq7aq9uvOWvGtFhiFymvt4kNPvjg2n1iChquoCduo25sfwy4To1FZrSv1FHbgPV2/GaCLrLfreZu95E5/Zv9fgXyuo+ZUFwObzVUC1vXtHdWSsVqIY2pLm4LvpV+OpS6fyiKZpx8qk94i+kHTLhkLKdnuUGZlytYI2GkSqKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRfs2KLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRfs2KLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C61F000E9;
	Mon, 20 Jul 2026 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559653;
	bh=lX5KFIIrsn4mDVg/sKoLHlNhDqdyz49wRg1tF/+8KmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRfs2KLx9gPkItBWxuGg4hU6NnDlFkdmj8tKR2oBNy+o0kTeVfhA/CjIXu5i008bw
	 fktPwuXKpNCqpQZece4oDP4wybpRKPW0AIDvBLNMoJsV+MMm4MDYxzQyNNnRpmsVkS
	 XXn7F9tgHqmQF0VoVpgP/+ji3wVff8VdL9uHQhPQNkTf/qQRVObuATXxzvTgwUYJRi
	 Yowg89NRCFBIuGvkvXG+hvL6taMxwdwXrg1gD16l2JrwfbBiSlG7vSueembIU86y6c
	 LM8QNbQhwz5tMyC16PMSzQE9pKtBPtJEM6NaCjcB8hwts6fJAAsfYagezTvbdJNEJM
	 8pioo5A/LQvew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] crypto: atmel-sha204a - Mark OF related data as maybe unused
Date: Mon, 20 Jul 2026 11:00:49 -0400
Message-ID: <20260720150051.1918796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071513-seducing-second-a53b@gregkh>
References: <2026071513-seducing-second-a53b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 75f3d950054389e2556277e42170e37dd97cd872 ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/crypto/atmel-sha204a.c:129:34: error: ‘atmel_sha204a_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ea5e57cc9718 ("crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0ef92109ce22a3..77c0968b696337 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -136,14 +136,16 @@ static int atmel_sha204a_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct of_device_id atmel_sha204a_dt_ids[] = {
+static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
+	{ .compatible = "atmel,atsha204", },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204a", 0 },
+	{ "atsha204" },
+	{ "atsha204a" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_sha204a_id);
-- 
2.53.0

