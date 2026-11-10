Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325240;
	b=KyyKbVJQdSD92it36QeS2z2/iY6tQsWGu8g+bhaHVLhLnXjvnYAsEhASbK+iJQPVOloq
	 71PJvEE3jBHBvjrpfEITCcwdn7L7z1ifbP6a26jQAgnqkSG0xmPxiWWFXhNxXqJbHfEZV
	 gAbORdqEGYobgwIYbZZwVKTD+bjGQVsQ0VT+Y/SN6OxbTZ2hth2tUE44IuSI00BjSidGn
	 SIZAtiw5fFDqxWzGkEBUV6QqaU8JgyO4VJL+qbca7gUizy4cr69zxsYT7olp092qvJ9oe
	 udBnckIrG1EPJ4rM9OaL1OMK5xOF8GzqALiaR0JULwDNyQ6VX/4yzSKwSqcHP77IE9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325240;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WNzf1yjn60InQm88NAWrd+0gSzcc7wU4iA459nZggtI=;
	b=nyX2+kq/RO13zh9cy3LZWwIiLXLT4BPgA3TfCDuzIZlfjgU0vtNumMJT/FhWes4zJCXu
	 UgMqrVlYcSbkmh5bXVYWOZck4TJJSgg0aehtvHzA9BTBZ2z0YRkqYtkfm5DlryOsbkx1G
	 xk2C3VynGv57B5HuhzbNtlYl2C8xwsoP8WnhFZJqawyBAR12WOHQqevPUOxlPlx8pHf4p
	 VtqxHJ1vsUnxM8axuHCi7uywRVkKLgKwmArmS4D+k5hVi+LlgHWKOQBeSrV0rKYwfkGro
	 tIfhkcT0pjJmlxtMXC/QBIlwezVvM7nJ9WXD9+mjTNxFtfg2VmvmL5iT0EdAgVtxe2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZiZ49zS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31910606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZiZ49zS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493B71F008A3;
	Tue, 10 Nov 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325239;
	bh=WNzf1yjn60InQm88NAWrd+0gSzcc7wU4iA459nZggtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZiZ49zSG4U7/uq4Twx7p10vqxUt6Gy1xaugMCC66kVikOJqOe97hqysJlzwk7ZNq
	 WyUkBkOEsDlQKNj828TfvTKeWX74OzcUnue0J2NMabeSyZiWi+QzuvYmhXMb2vvQAa
	 4fJJ9OTaunxHpVHeY5YZx4WStZQSI7d7MtEMraYe59JL5zO4BtASAu2CP560q9nFho
	 xTUyv1571S1+zzl9m6W5jv3K0vXts5y2upCaUOHfjuJuXxTKH7s5aYCcvAFfWD9MdQ
	 k5SqmYVJLm1mEpuWYkR2KevvMKtAplAabEqtaf4VjOlRLTJSWx+OyjLVr9tMRgB65P
	 k4l+OFD+6dC3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 10:40:37 -0500
Message-ID: <20261110154014.2302728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051743-failed-6.12-3c5c55d979dd@kernel.org>
References: <20261107051743-failed-6.12-3c5c55d979dd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 7ee4fa2674e51a0d100b9240cd8a50355141362f ]

i2c_check_functionality() returns a boolean status rather than an error
code - directly use it as a boolean value.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260505114543.159381-2-thorsten.blum@linux.dev
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 3c5c55d979dd ("mfd: twl-core: Unregister the auxiliary platform device on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c130ffef182f1..c53be506311a3 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -750,7 +750,7 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

