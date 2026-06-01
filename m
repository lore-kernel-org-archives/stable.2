Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AE23EA9B;
	Mon,  1 Jun 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283264; cv=none; b=YxXCPqff9SSAI7G6aQRRYXsUE8If1wVU920q3OzHkxlFcvHVgOA6IamYDovqG1W5fsfa6hxBPD0njgi/o+ojBuucJB4u2jKp10B6hrQjCYdPzh+oUgCXLblcUQ8avhG36Mtus+gCXZOnu15iAAYPKvsM2dtTENvAHN9RMFKJq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283264; c=relaxed/simple;
	bh=tMDfNkGQ+Wl5mAlRHZIVISbW6X21lwUZRzgzAXlvml4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yez/5EmyMd1L+pcH4RfGl40QfAPC0pXBsaiTV10iv3lNKuVSS0bquxn+/WtEFVXSsuaso0+2S2O5wcW5FBe8wkkSLElvKdaXdZaRqRlyazM+6wTmYR7sAw/eNOL3yh/Pyig3R9qHpYY72NFd+mFcso273EKNxMq5KtoNe8TRR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GPDz5PmN; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GPDz5PmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780283252;
	bh=QO1KFyPL1+J1GrBWkpwiZMrb/LxQzYLbjd8amO7TedE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GPDz5PmNPRzV4of1bng7Xobo3qJ0BudcnjwOff+htu4VrgfWR03gHNOxU+uKJ85ju
	 YOtc4i7FKZwtRq+xHz4RQ259xcbV3PiFsreuPJMkAkSPilmuYoIgvlJGnx6slX/2ok
	 a6/I3++lPqglQSo7/o3XX67O5G/uZgRE9XfMhd0E=
X-QQ-mid: zesmtpgz3t1780283242t05aa13f7
X-QQ-Originating-IP: YRCbA7bqRKH6wAc7eU+oyoXj0OqwQdNppr3PyW5KP6M=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 11:07:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17389882740423473155
EX-QQ-RecipientCnt: 17
From: Shijia Hu <hushijia1@uniontech.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	kees@kernel.org
Cc: paul@paul-moore.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	kernel@uniontech.com,
	Shijia Hu <hushijia1@uniontech.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH] fork: Ensure copy_process() returns a valid error pointer on failure
Date: Mon,  1 Jun 2026 11:06:49 +0800
Message-Id: <20260601030649.2513937-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MNbA5mkmBXEJOjuZzNmFOFQ03GGcBHln4T++EcLEbRaCD7/61N7bURs3
	2Uu30URUafG2hBytlcRFvc80Yu8Y/gOQpSlw70IwE3jEPOKBBydEtJEuKmCEXM61r2KXtMa
	VjRQXzagpYm6Lu0idZaePvdXAvtq/ckQI8SM2igLcooChi3xFQwh3q1VaAQEMhqLkbtzqAN
	0KertAuxfB55r7bcwsrQnqpTUPgbFff5q6HrQL7B/o0wrsyYQ9/GFqICRaatx/WRSv5iabn
	3Ti6ytJTK7Egc2TxMSFDLMsV7qIqLzi2EfO47aC9wqC8KRJcLKoAm1OQlMVZ1AQQAWTQXdi
	pC2cxoG0ckfnF/wDEVu4jn6PANXpPkWgLG+Jps5ufTqgJ5a1RP6lBzYFbwFtiTWs2zl0fao
	vFERj2EBhwE/mp2DFQeCSRAJhbhpFQfNiLglQVlDm1f+YxV1Hs6MMRevjhih3vW4OFFAUiq
	aV4xfXeJHuzAV7bJIFDvjYuj1s53/mxYboV9rtTiiEnVADV5tkjViXom9pjgdcFbDRmZ3ni
	2Kq6NT6AFK7Gh+RuDsVCULOObX8g8mxxakc4yhZBpbNwgrqNes96OLqw/nFu9cB389m1pZj
	WP+mqAxf1YxO1ff+GcslnjKDOgYCHKDIY8H02b8CeyrsR+8IIwWE4uihZRkZ3WsESh/0g6j
	e8inFUdydFVrzP1XWI/CUrkfw6yof2e5oNYaqM3FlfNXbkDVUYuco/Il9q2QRVfJtrkvuBO
	TsTqZBS3BCgLMMqAcHgGQd3vIYpq1ZXcNng13Kmsiw7aRfVab5FIrsyQKcyQlQPzmT4YFnY
	h1Vd1EWT+k5YFg+t9N+QwDBX0uW5UKR6HvpYyXywifUxd6fmiN8h0R+oxC7gg2vWCI7/BTo
	3AsLSFkfqPq471lLHUu8Px9/dQ1vAJZrdbuOkYly1pG50fqouECcRw60mmSjcC1OSa3DToj
	TuLfOZry2MeTZOBTewd+eHkdqsMJoCXaiZkYD/G3l0+L7uJSkVc1p8ZH/az4mq0xvN4Moy0
	Uy6woN8keloWbTk+FR
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

copy_process() returns ERR_PTR(retval) from its error path, so retval
must be a negative errno in the range [-MAX_ERRNO, -1]. Values outside
that range produce a pointer which is not caught by IS_ERR() in
kernel_clone().

This can be triggered by attaching a BPF_MODIFY_RETURN program to
security_task_alloc() and returning an invalid value. copy_process()
treats the non-zero return as a failure, but ERR_PTR(1) or
ERR_PTR(-MAX_ERRNO - 1) does not produce an error pointer recognized by
IS_ERR(). kernel_clone() may then dereference the returned pointer.

Normalize unexpected values before returning ERR_PTR() from the
copy_process() error path. This keeps the fix local to the fork error
handling contract and does not change BPF_MODIFY_RETURN verifier behavior.

Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@std.uestc.edu.cn/
Link: https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163.com/
Cc: stable@vger.kernel.org
Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
---
 kernel/fork.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8ac38beae360..40bfbdfffbdc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2599,6 +2599,13 @@ __latent_entropy struct task_struct *copy_process(
 	spin_lock_irq(&current->sighand->siglock);
 	hlist_del_init(&delayed.node);
 	spin_unlock_irq(&current->sighand->siglock);
+	/*
+	 * The error path returns ERR_PTR(retval), which requires retval to be a
+	 * negative errno in the range [-MAX_ERRNO, -1]. Normalize unexpected
+	 * values to avoid returning non-error pointers to callers.
+	 */
+	if (unlikely(retval >= 0 || retval < -MAX_ERRNO))
+		retval = -EINVAL;
 	return ERR_PTR(retval);
 }
 
-- 
2.20.1

