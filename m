Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095071C68F;
	Fri, 12 Jun 2026 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229709; cv=none; b=lOsJ5MQ4ADzHPdg1UocYKQDUHzHmRV77XSeJ9vay7Z7papCcQXVANVrLK1xetPwbUk5YYF+zInJgTLx1UX+vA3nrrZI6fBJWF+NZrcQhjAFc/NQPh1yqq3HNa5PTeseIqYBHiLmHjemCJUuNssFKe1j+auo0W4B8RlDz53QiOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229709; c=relaxed/simple;
	bh=He6/QblW5rhMu1qmOEpGRtr4ZWdWCzuW1bZ56CfRt2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkwfG9nwQSgG55clz0TM01tJN8Wbv4JOg7Qpcti0TxAkGk0TFahjtT8vkZUAb5MhYV8vhUy3LebD7r2qPztOn7w+TZ89aaXLZlyXkthZToNKr9kXYQvi8D7mT1JoanzKrFdnsSnRsQ9D2xn7CWLYZ3ONaaxYP+j5ZsT3ttlkZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowAD3l9B_aCtqcW9bAQ--.10757S2;
	Fri, 12 Jun 2026 10:01:37 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tls: fix encrypt_pending refcount leak on -EBUSY error path
Date: Fri, 12 Jun 2026 10:01:33 +0800
Message-ID: <20260612020133.11427-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3l9B_aCtqcW9bAQ--.10757S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3Wr1xZw4xuF4DGw4xXrb_yoW8GFW7pr
	1YyFnIkFZ8tr15Gryktw1fGF1rZrWrZFW3CrWDu34UWrnxJr40v34akF4jgFyUCFs5Gas7
	ZF4vkF45CanFyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYQA2orLhmVVQAAsv

In tls_do_encryption(), when crypto_aead_encrypt() returns -EBUSY,
tls_encrypt_async_wait() drains pending completions and restores
encrypt_pending to 1, expecting the caller to issue the final
decrement. However, if tls_encrypt_async_wait() returns an error
(rc != -EINPROGRESS), the function returns early at the error
cleanup block without decrementing encrypt_pending.

Since the -EBUSY path never submitted the request to the crypto
engine, tls_encrypt_done() callback will not fire for this request,
and the synchronous cleanup path (atomic_dec at line 599) is also
skipped. This leaves encrypt_pending permanently elevated by 1.

Fix the leak by adding atomic_dec(&ctx->encrypt_pending) before
returning on the -EBUSY error path.

Cc: stable@vger.kernel.org
Fixes: a9b8b18364ff ("net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/tls/tls_sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..97cfe06b1529 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -591,6 +591,7 @@ static int tls_do_encryption(struct sock *sk,
 		 * below on error, just remove the record and return.
 		 */
 		if (rc != -EINPROGRESS) {
+			atomic_dec(&ctx->encrypt_pending);
 			list_del(&rec->list);
 			return rc;
 		}
-- 
2.50.1 (Apple Git-155)

