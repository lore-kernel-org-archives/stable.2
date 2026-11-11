Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409095;
	b=LI0c45DwfD2F7ygpIhqgMS6aBB7L3uYqjqXYlXpipcVn6sFaJTpPMpqOyX5M/66ZVqio
	 Fq5P3xpa2a54uSNcZrJa8f4C7hpi3HYHToQw6DQDK9lI70lOB5pfTqTMALYBMJkItFa4M
	 v7GF9HGAF3CMCfSipMYekHARTtv/hWj/VkSHICKKqo5D7XlLJ49P6LqF8l1ymNXoyExyu
	 HQHNenm6ce4ylnQE+tWjQuRFx7NXwsuGrmEHJeOi0sYcg9Xm4/xOa54fMb3u4FLfrvGfI
	 exZYlxyMCzbIRTBlBO1Dzfu9DTmuo/vzsXpvcpMLf2HRCfsA8s8FH0AUalvqrS5LPNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409095;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=CpWCJ94xtknXCkn8v7FkrW6Znii5UB/65DwrssViU5k=;
	b=AMFi9oeqQx0DnqLSyQoVwMjKxw+R7CQeR73uj9afALdr1tpkOG6eYDtikVTKKd196y//
	 TJmW6nBbIcGOwXy9Luayw64rSW6ZU31qkypHb0t5c3pQAc7Q2N/BqDGwsKcVKGqZYvcJL
	 vO7OUCJ4mMxIUrWzJZuVFy7iX3lO7b+UI6C++upYS3ABaq2L2++vX+PK3i3Htmf0AScCc
	 Eh0vpGHF/OP2VPdq8vkpHbBbuHv2/VdlPe+aA/Dr5w4a5JgjxlKTGRv7bxyoydd0MV0lO
	 BpuNvAiQ+y/kXUJbMF5TT+F4LQQcKV6WJ2st2I3GPizF/VCzP8ILSMqrnehAZ7u7N/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="0qLYETa/";
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46D60A263A;
	Wed, 11 Nov 2026 14:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B46D60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=0qLYETa/
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jPmpz3tm4z4xPSq;
	Wed, 11 Nov 2026 22:58:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794409083;
	bh=pRKfVc7wfVb7PMZfXlLg7JaYDLTtapskOa/+zvTpT80=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=0qLYETa/prukg6Sc1BuWXoVB0zs0aZB4MfkzKYinbyKT0BToDFsvP8uSsTXJQois3
	 x39B5O6sezzSdB55i2Q+KZ3jFiTBGelYUw64WAs+6am6Jo2oBJIyIwYd7ZAMGvW4G2
	 ypmbRX0ZDULHFwUkMy9UkNxy1TuBiwZaI6L95SB4X962k3NyOjvyf9awIRujjqJ4OU
	 Z+pLkn91liWKfBvg/AVjmK4xJjMIYnm59mmZdSyBE5g7qBKJ2o45OyEMnzcyPuidXr
	 zVLZ8eQJcHQV4LLvP9zWnoTu0HdC4Q9yVv8K0DE/RJmBWbAg+pCXvDKWDqAveT7Y6a
	 oii8MWYclJrWQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6ABEvwcA003794;
	Wed, 11 Nov 2026 22:57:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:58:02 +0800 (CST)
X-Zmail-TransId: 2afa6af4827a592-8b453
X-Mailer: Zmail v1.0
Message-ID: <202611112258022807A4cJ4GoTzO_Q2qeMKeG1@zte.com.cn>
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: 202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn
Date: Wed, 11 Nov 2026 22:58:02 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>, <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDQvNF0gc2VsZnRlc3RzOiB1YmxrOiBjbGVhciByZXVzZWQgYmF0Y2ggU1FFIGNvbW1hbmQgZmxhZ3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEvwcA003794
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:58:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF4827B.000/4jPmpz3tm4z4xPSq

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Batch FETCH commands set IORING_URING_CMD_MULTISHOT and select a buffer.
When a SQE slot is reused for a PREP or COMMIT command, batch command
initialization overwrites the SQE flags but leaves uring_cmd_flags set.
The multishot flag then disagrees with buffer selection, so
io_uring_cmd_prep() rejects the command with -EINVAL. The completion
assertion aborts kublk, leaving a recovery device QUIESCED or its CLI
waiting for a daemon notification that will never arrive.

Clear rw_flags when initializing a batch command. The FETCH path sets
its multishot flag explicitly afterwards.

Fixes: cb5a6b308700 ("selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
VM (4 vCPUs, 4 GiB), using real kublk and fio. With the same diagnostic
kernel and batch null workload, the original binary received -EINVAL
for a multishot COMMIT without buffer selection and its daemon exited,
leaving the device QUIESCED. With this change the daemon remained alive
and the device stayed LIVE before deliberate device deletion.

The four recovery scripts also passed twice with this change and a
separate fix for commits arriving after the quiesce cancellation scan.

 tools/testing/selftests/ublk/batch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index 625a9c32a..fcab2ca9e 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -241,6 +241,7 @@ static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
 
 	sqe->fd	= 0;	/* dev->fds[0] */
 	sqe->opcode	= IORING_OP_URING_CMD;
+	sqe->rw_flags	= 0;
 	sqe->flags	= IOSQE_FIXED_FILE;
 
 	cmd->q_id	= q_id;
