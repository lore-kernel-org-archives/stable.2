Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319126;
	b=OHi9i7dRou2J85dnAYk5H2vV3FvLQNXss8UUCD4E98lcyZsBL2IRY19I3RWJ0n5/Jbvh
	 XKFljXjYLxtv2RFYKpQgl/W6tXlX2XX5rrqhRSuvqxYhKOIkVQmx4RCEjZCHIqCyyjlrf
	 qZowvPUQz2HPtZ1wz1wqjUxVnAl00EvD3Wosk+wqZn9u68s1xvbDHZ9ZBTyWo/7MnpmM1
	 olyP4y3pqd2bJC4yj8L5aPwxVW2/gW2+g/4cPHK+lT9HivHWrHC5qA72AAg6d9y3W7yHE
	 9kEJvH2EE50PFU81RjMjDLD8XxAcx7gQQRoHnYerprsQm0nRASc8P2GtzSptZVPLN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319126;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kv/PQ8AwO1SWnjb0Y/7lPsAY+hLD7KqbzIN00hiU7zk=;
	b=CmjZJ8smrQaTr5GeOuiG0vighsfvlYG5xkqP7149gJ2uyqfOALwNjzITSOlBoiBGwhhn
	 l7aZ1fc4whTeAHHpYS3Tsfa5wVBKvODqz4MlhnCSy6Br90cUxuTp7Fjkp41xQ+LJXgdKa
	 lUrzBfqU0u6ZoQ0WsWOHzFE1iZc5cbb8HoHm+vO/W7P6olT1U0ILilGoXjVUfqzHwuttj
	 0/jIMdTRwdIEZHFmmGES6XLiwZKy0u/ZpyOyZy0kRaG7HOK5jz+lN2qbpQ0PZv+UdvPOE
	 E255DO0ESIxGdnyZp1MYUEKy0UvZp9w8ocSO5zbEtHWFs69PhRS7OBz9CvjZe67RpcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iijvOO0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B8606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iijvOO0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011971F008A2;
	Tue, 10 Nov 2026 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319125;
	bh=kv/PQ8AwO1SWnjb0Y/7lPsAY+hLD7KqbzIN00hiU7zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iijvOO0bYjVCloPSQSWJKBc1bw9K4YB7E8ozZ/tZWyp6eMOWdYsMyv++Vlxhs2WpY
	 5Ugh/e6EDD2YAtNTVCQp7FKNGQ7mNjZe58SlOrrS65dWL2BFpXXkLTq4v4J6A4hWLY
	 FtziYJTONRNBmxNXA0ig3m3VbSwTKsWzrqBH72uk0inCu6JkcXLXV9eIeM8FZecZAy
	 +clzmw8R1jkjJ2J+9H4m+5HQ/dDqkFBpdZ8L3rjKoI0SB2KvXxjzyGFHWBUPw9tQrS
	 d1pOy1KsTWzcz6/FDwodjsdLdv4H28FkGov3Wk42F0Y5FspISBVLjaKolaSkhl8zlp
	 K0PCY3ai4rHsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
Date: Tue, 10 Nov 2026 08:58:43 -0500
Message-ID: <20261110135826.1817055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061644-failed-5.10-b00fbdad64d4@kernel.org>
References: <20261107061644-failed-5.10-b00fbdad64d4@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit b00fbdad64d4ea7d594bc67988c1722fe5b3be50 ]

vpif_probe() takes a reference to the i2c adapter with
i2c_get_adapter() and passes it to v4l2_i2c_new_subdev_board(),
which does not consume it, but the reference is never released, so
it is leaked both when the probe succeeds and when it fails after
the adapter has been acquired.

Release the reference with i2c_put_adapter() on the success path
and in the probe_subdev_out cleanup, and initialise i2c_adap so
that the cleanup is a no-op when the adapter was never acquired.

Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted vpif_probe() context to account for the absent v4l2_async_nf_cleanup() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpif_capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index f90de09c14853..e81c894dc2aed 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1617,7 +1617,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
-	struct i2c_adapter *i2c_adap;
+	struct i2c_adapter *i2c_adap = NULL;
 	struct resource *res;
 	int subdev_count;
 	int res_idx = 0;
@@ -1701,9 +1701,12 @@ static int vpif_probe(struct platform_device *pdev)
 		}
 	}
 
+	i2c_put_adapter(i2c_adap);
+
 	return 0;
 
 probe_subdev_out:
+	i2c_put_adapter(i2c_adap);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
 vpif_unregister:
-- 
2.53.0

