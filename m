Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335959;
	b=r7WvEC4PwboDi3K9/UZ+xmJQrGig+5V+8qqbjDPb1+YFtLqZAEZ3ctz6eCOduu3mX3+/
	 SEeQ7qOC3vLf8ja/NjALT0GSi7pGbuCmW/XS3ekQNsA8Vwmy+PbR+h8Zhd7e/hIwOoKbE
	 UOKwxq2NmAXycUpFHTyYFZSoFimFIs8Of6ZtNACIBiWku/OFDVugI8ts3qq2VVqPG7JpC
	 FBkTp9AGZNSVocxBRa/Vc6NRYKW6uA9OBOQMMz2nLguDBEeTu9/CPe94jVLd4SgZi387M
	 Ca5ms/J0qywVz1pqYd+wHilcJ3NLnZQmFI8eX9dcWIUjTsVngvqbFi7L24pvIJWdbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I2KxrSa9qRcP/kEpiBbc8uLhgQ89+RnbagNPtkXGqHc=;
	b=XQnZEsFU3dZ7eqXA9PKzD5KNDPMD5g5+iTA7ureDDkxLIDtNcecGAZVoWNfMRg9TWsQF
	 24z9QyLwA0enp4YmJoKBjbZTZf2LXqErpSM97psgYtNbs0M89VLsv01h7apYdiUKDqvU9
	 oTwprOQXxrXJpwgu5ScwHqvlYk1iKqoGfz/a7GxfSe7BI9mHNq+/QPgSyKTBIcru+9r7o
	 gC+HEYBWTP8iiQFcITU7oe4By8eoz99e8/0fl3YNmeH7JAVLnP8ZviOLavv99c3zPFQEa
	 fK2mpDLT3DDbfwRaIa3NRHQKyMAG8T84jeRERTJ9cPtZfuclY8sY4XlpbSz/ZnlcMLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dM65F08l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE6606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dM65F08l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894DA1F008A4;
	Tue, 10 Nov 2026 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335958;
	bh=I2KxrSa9qRcP/kEpiBbc8uLhgQ89+RnbagNPtkXGqHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dM65F08lXdJSOswFuJe1y6ctb4bhyebpvaR85r4tcbgJ6LrrL1a+DiWSrKoXfXQ/z
	 /p0BNay/jljFKvsimoOZNGhmKpC8PwJJVNjb0B+mnewbKeoONcqHVYgU8CPJFmGjgB
	 hKHCKy3JlOVRZCGSn0u8yTW4FmzmEiimosBI/Ai7Nv2rtfmqWiU/UNG4DZt0ifyQxr
	 o1wFnF6U5oojcal9a7zgE6cpHLZUPN9dRRSynyab8cZHzL4jSnPtDPTJQl8KhMmUps
	 N1X8pc2Q3qYoANMeHivxHvPbEziR158EoooHeSSsKZD/C+dyToIMARaSznLXxr7m0o
	 4CW6YjkZEsX0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Guenetr Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Wang Jinchao <wangjinchao600@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] panic: flatten nmi_panic control flow
Date: Tue, 10 Nov 2026 13:39:11 -0500
Message-ID: <20261110183723.3255298-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183723.3255298-1-sashal@kernel.org>
References: <20261107052209-failed-6.12-75eb687ff2bc@kernel.org>
 <20261110183723.3255298-1-sashal@kernel.org>
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

From: Bradley Morgan <brads@mainlining.org>

[ Upstream commit 75eb687ff2bcec9fba31bbe266e5f91e5c283efe ]

panic() is __noreturn, so the else after panic_try_start() is dead.  Drop
it so the force_cpu path can be added cleanly on top.

Link: https://lore.kernel.org/20260916182957.7788-3-brads@mainlining.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Sashiko <sashiko-bot@kernel.org>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index b4db7f62b8ed5..16c21189c8da9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -250,7 +250,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 {
 	if (panic_try_start())
 		panic("%s", msg);
-	else if (panic_on_other_cpu())
+
+	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0

