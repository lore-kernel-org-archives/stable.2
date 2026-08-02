Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4C2C11E2;
	Sun,  2 Aug 2026 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676061; cv=pass; b=JLGFyThFycFHStTifDd6jqSuwY1WjsH7ipdS8LOu+LZCpYUl1va5R6m9KK5q1g2g1pPUwjUsQkwPO+KYSL8V3ratSjqWDP8al7DAa0ra4W7WKo5jmJWM1aEBBrS2y5qlBQjFNjxpISppaipZKQz1oBrnzEcJm9FvHpfhzFs7LsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676061; c=relaxed/simple;
	bh=TX86fR2kjDQY5i3Dd06f3nI/vOSbCU2+EpKdMQgw8ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9c3wv3ciHD7Ys4kBlNY0hzJd+ERZfxhzn8bT9hYhgirB1uYzNPCBZRJJ8moekAohDBvY4skEXT4Z57ECfwagcKOsCvFdHQPqz2FGYq+wd+ez46w5900CBo6o1rvKcQzZczyedScXqLMoPysvRySuzNEXu7tRDwuWgRx3XKcu+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Ct7n1TUH; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Ct7n1TUH"
ARC-Seal: i=1; a=rsa-sha256; t=1785676035; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=D7tzayY67s+d/Q1L4qjVR3mXYfFF4ugVDLW5pE99zsX0Y73b2uMVVn3WVzEdAXN5c33Vpadzh2RqxFUjUUtK3AhncPykWF0fcyPWKN9I0Zy4TswSE37sXnFjhmW0/EQiWwf0V268rMajcobuA48oDZRVqN84MXFuGeWmQyEubmE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785676035; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qXxi1bQRsm1+bpdGGhQN4aVMuJcOjF/XXMNCUshziLI=; 
	b=HpSjWY/mKdIXiPV6EFR5oUiKOZSAVJKPlLihaQ1E5f9w/C6a+d90KqloEJZZ1mFcLTuNhovElNEEy94kw7WI8sEBzWvnb5xrUsVKBzl4/rjfFEvv6FcK1j2DcJnJO9fCJl9hKOVOhCiIAIx8Wbkn+301fDZiWyVK4njA+lnzo3o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785676035;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qXxi1bQRsm1+bpdGGhQN4aVMuJcOjF/XXMNCUshziLI=;
	b=Ct7n1TUHNwjj5JOlfRHUn3tXFw3LDnBjkGIpTTcItFuJlw3PRHHFhY35yCXcvhgQ
	MVk8vYv4VKrH6pK4iUee9ViehXaAHsu6JGctMjsvx3P5BnE6/f7LuFgpnughKhfw70r
	i0rRyfypzOPcIemvXT7fcY36X4eMtNLXx3U3Kz4Q=
Received: by mx.zoho.eu with SMTPS id 1785676033102608.5762035175266;
	Sun, 2 Aug 2026 15:07:13 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mfd: qnap-mcu: clear the reply state when a command times out
Date: Sun,  2 Aug 2026 13:07:01 +0000
Message-ID: <20260802130701.25702-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

qnap_mcu_exec() puts the address of an on-stack buffer into the shared
reply state before sending a command:

	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
	...
	reply->data = rx;
	reply->length = length;
	reply->received = 0;

qnap_mcu_receive_buf() clears reply->length once a full reply or a
recognised error reply has arrived, and refuses to touch anything while
it is zero:

	if (!reply->length) {
		dev_warn(dev, "Received %zu bytes, we were not waiting for\n", size);
		return size;
	}

	while (src < end) {
		reply->data[reply->received] = *src++;

The timeout path in qnap_mcu_exec() returns without clearing any of it.
reply->data then keeps pointing into a stack frame that is gone, and
because reply->length is still set the guard in the receive callback
does not fire, so a reply that turns up after the timeout is written
over whatever is using that stack now. bus_lock does not help: the write
comes from the serdev receive callback, not from another caller of
qnap_mcu_exec().

The write stays within QNAP_MCU_RX_BUFFER_SIZE bytes, since the entry
check rejects longer replies and the loop stops at reply->length, so
this is a bounded write to a dead frame rather than an unbounded one.

Clear the length and the pointer on the timeout path, so a late reply is
dropped by the check that is already there.

Fixes: 998f70d1806b ("mfd: Add base driver for qnap-mcu devices")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Found by reading the driver, not from a reported failure; I have no QNAP
NAS to test on. What I checked in the tree: reply->length is only set
back to zero in qnap_mcu_receive_buf(), at the two points where a reply
is complete, and reply->data, reply->length and reply->received are only
set again at the top of the next qnap_mcu_exec(). So between a timeout
returning and the next command there is a window where the state still
describes a frame that has been left.

This is the minimal version. It does not close the window completely:
qnap_mcu_receive_buf() runs without bus_lock, so a reply can still
arrive between the check and the two stores. Closing that properly means
either stopping serdev receive around the timeout or protecting the
reply state with a lock the receive callback can also take, and which of
those fits the driver is your call rather than mine. I went with the
small fix because it removes the stale pointer without changing how the
driver is serialized.

 drivers/mfd/qnap-mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 8de974ddac3e..f810cb4ff2ab 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -239,6 +239,8 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 
 	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
 		dev_err(&mcu->serdev->dev, "Command timeout\n");
+		reply->length = 0;
+		reply->data = NULL;
 		return -ETIMEDOUT;
 	}
 

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

