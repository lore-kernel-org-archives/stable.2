Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFC37A496
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236843; cv=none; b=oB1a2XzpTSbonhYG3RS0iqYgKHHbUaVIWylMdr7BxJuR6I7qmKQjmPz9WdH20eDa2kAS6AUVDDynQt0ekUcL2gGMZZCRQRdb9jrvz9ct5qyMeljLcNKA7go6SnyUtpuyMlADXkUDUhWl0tSX9xCv50m4pc/aK9mocUkTp3855KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236843; c=relaxed/simple;
	bh=jjKGwSdZG7k8y+xeUtK+Eh/lMzWYDgmty8uBtR6cD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMlQJ78qiT3gf/3nmmD8maranGicJjVcPIpDXjmhuLq7X0pX+Pk0XZtvWFyGhtpH0LjDC/7fpZdCMYA2VoJl06ZrQE7qq3tW7NhbYxmMI/PYN5w3rZHrh6U6A4eY9+Pc9KYsz9kIwrnfsoszIsBvP6idK1ZiJaTxyDk/NdSCT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZCoET5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZCoET5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FC1F00893;
	Mon,  5 Oct 2026 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236841;
	bh=4YXlJhU6vMzCjfZZ8X94Oq2Pl6r2FZa0izdXMbQQR8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZCoET5PsR8tuxGXhM4eae29gD9br6OML8YBnGd10mNzvqHoGYkSxIzZED8tqmo4n
	 /28tv0OcT4q0yY73GTEnPrNBrbdLvz1Ra8UkChoZEtphJwzggcua2f1AwKGgw3Gomb
	 dBayl2+QsLfRFGeMZt6XtnU4IfIjua8y8GjzLFcrbjxAfnxsn0H9gitFn3q72tOEIl
	 4wnX7MNUQxN1tBJyfNs4S3sKgK9e2ccnZ0eDJnGdCaX86qR2llXGgissj0MFEOtuOA
	 nk6JpJ349R8cAGD4lPMuTHkp/yAF81VHAnmd0cgmOcjlmh3U2IlaegEO65r2gn+vbQ
	 ZD9Npw4GJ5tnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] perf: Require kernel access for text poke events
Date: Mon,  5 Oct 2026 17:47:16 -0400
Message-ID: <20261005214657.3401268-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005214657.3401268-1-sashal@kernel.org>
References: <2026100516-headstone-video-e3d0@gregkh>
 <20261005214657.3401268-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit 357e8a77a501d96c9517f01f4a211eed5e9c9184 ]

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f112f12cc3ce..c6933632d65fa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13536,7 +13536,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
-- 
2.53.0

