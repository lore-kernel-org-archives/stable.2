Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425729;
	b=vVHYh2BlFyqUC7vFrAMYH+Jx8GGmW3cfAvoZWBJmOqNY1SWS0XLxhQSJYqQooMcLj/1H
	 SGouNfPmXsqHXTjtJps1O3YBLm4hs+yb4RHvYgiTmkURMklvtauRDeojaHjNoyFD9Y59z
	 v13SwgyNS9P7Qlsev9MU7exknthAvrkixxnAkZ6go68pCDkRO6EvvbqWngt/QDRAnau38
	 zYk0BHNQa3766BV4S3GNkOTB0Razw+ULVGc2JUIhV5aFd9V9mN6Rg8t/VIMPsu2gbl3Gl
	 1+LpAND73kjd1ukpSXzAIg6MsnLrbfeOgvntLCQS1MgkDF/FrKrXn7ZnuqibykGxoAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m4mRMxINB7KJcLuY9pcNP2CM0C8EStUnPusFMTWZLaw=;
	b=rQqAmnbCyPF0h6iUQ41sCxnJkS9b3jwnde7aJEZf80k3QNPTo8CY4o9eR+jZ7MkKwzPt
	 NhzjthuwCieg+zxroydPDyQJZStlLq//zW60l2bhwfGVhB2T2LWly0AcKhVf/dkynO2oP
	 wXv8FkorXCggoeuLhyD5ClB8wJK1ttO4t5jT6vtj4ftTlIYatsKIHTqtwLSqS2WCemJtg
	 Pfw9KI2RO+uj33OTCEZOrjQiSyBqCjY5KzRzarapFa4J3m6elx5aHzqA9NEebMSvd8GST
	 80zgsstgU2EdY2KUVpOXzIPSNnNqCeqhTgk2O0YNPZZCaotsAktze+eEZNgjwJ8Vz5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHGho8ew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73960606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHGho8ew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B861F00A05;
	Wed, 11 Nov 2026 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425729;
	bh=m4mRMxINB7KJcLuY9pcNP2CM0C8EStUnPusFMTWZLaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHGho8ew1UblmIJwl3krHNX2+hY+SLjB9ZhXNDDGc4K40gOle/aJfSHo0p4wa6Ya+
	 O4xidNhd9hCqi4rXBJiYgWsFWNuymV9JMEuUWt/VX+4+G22YQ7Nea2vFc/PO8LDq4d
	 KokNo5uatKsoGbBSQku6UFw2dDox2I/olwoly99cHp4Et4ceglo/cza4oKv9ZZQYkh
	 YVobiGyjAGwHmrITmNTwRxNesEhTJflNYD1B5QGt0UX4rh2bN+Ql3MZ7A3vyI+Sp40
	 qkzIx5a6z3pdC5yJz6E5jE0VxYkmxFBYDFfAtZ3+g/08K8Hzy64KEqnXhDBMnpLwC9
	 WwnCmfeKRGF9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] kernel: debug: Ordinary typo fixes in the file gdbstub.c
Date: Wed, 11 Nov 2026 14:35:26 -0500
Message-ID: <20261111193515.3990968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063025-failed-5.10-13962ef7021e@kernel.org>
References: <20261107063025-failed-5.10-13962ef7021e@kernel.org>
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

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

[ Upstream commit 2bbd9b0f2b4ec0afa80b52b1a68bd3bc80618275 ]

s/overwitten/overwritten/
s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Link: https://lore.kernel.org/r/20210317104658.4053473-1-unixbhaskar@gmail.com
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Stable-dep-of: 13962ef7021e ("kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index b57e5e338aab2..45f6e39d29db4 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
 /*
  * Copy the binary array pointed to by buf into mem.  Fix $, #, and
  * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
- * The input buf is overwitten with the result to write to mem.
+ * The input buf is overwritten with the result to write to mem.
  */
 static int kgdb_ebin2mem(char *buf, char *mem, int count)
 {
@@ -960,7 +960,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
 }
 
 /*
- * This function performs all gdbserial command procesing
+ * This function performs all gdbserial command processing
  */
 int gdb_serial_stub(struct kgdb_state *ks)
 {
-- 
2.53.0

