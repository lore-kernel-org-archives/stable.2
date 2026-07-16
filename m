Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF733DEDD
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231667; cv=none; b=NYtLGW+EDa/vSlfTnCctz9qnH8UTdU2UUebWXE+OlXszpCPSkPlh13P+VFQKuW0X4tRTqrwazVvmCyfa6R2F4fZ/5wrY0/hlD1+f3o9YQf7JXcXrnzBF0MfAjEA+gb6wkUSGV04XoM7sFhDccqE88hLPja4GxzHrASmio9p78RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231667; c=relaxed/simple;
	bh=XSEsEgNlwWPvDsdw1SmXQc6lSpmBAnebdVFgAvN6ddM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaKkEY/n/eI4cVM/t/vTD6vW01okRqPpO/t5OZvjZwzHUvZkmrKOwV2DgViWTURPr9FyaagoXWbny7bPhhtWW9rvbSGc6s1lkuKncDHfUfsQpdQ8sxfm/4VNQiW02L56Fo/0rMGbwvqg051IlQleC7CJXaxhsG6dTA47aCIveVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdwdxFTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdwdxFTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7841F000E9;
	Thu, 16 Jul 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784231666;
	bh=/Pbz57vgSSvpW4MaE+HoWOZ7XihtFdszrTHbyvVHM8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VdwdxFTeItxu8670s2NDAysFklWItFzRULUrrcEwTnRxj1VEoZnl5D93rfvSGxK0t
	 3rcbBqtLvw7DUgzBwD4byk1BswZrOhNS6gU3uEtmsAdFCKf8OHSN0eJo3KcOwzTNjz
	 LmJQH3+E8v/8ZkKfWqH6yt/WK7Lfn1T0xclgh7UTZ9f4qr3mNFL+pYIjJLFOTrzLZ/
	 vQb2MNnH2wptkPAIz8tQK1ZFeGrbkCjRa+RpmbiGewgmjzpEifWFJPQZO9z7fjb0/y
	 GHOttGzBLWRSKP7xIrznssCk9KKd1lHUKUaqemQ1uBJbP9khvo65DtArHpmVCG+1Mr
	 17oybkwKjTO6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Ignat Korchagin <ignat@linux.win>,
	Alistair Francis <alistair.francis@wdc.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] X.509: Fix validation of ASN.1 certificate header
Date: Thu, 16 Jul 2026 15:54:23 -0400
Message-ID: <20260716195423.1113794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071443-shed-dipper-bf70@gregkh>
References: <2026071443-shed-dipper-bf70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 3b626ba431c4501512ad07549310685e07fe4706 ]

x509_load_certificate_list() seeks to enforce that a certificate starts
with 0x30 0x82 (ASN.1 SEQUENCE tag followed by a length of more than 256
and less than 65535 bytes).

But it only enforces that *either* of those two byte values are present,
instead of checking for the *conjunction* of the two values.  Fix it.

Fixes: 631cc66eb9ea ("MODSIGN: Provide module signing public keys to the kernel")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260508033917.B5873C2BCB0@smtp.kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.7+
Reviewed-by: Ignat Korchagin <ignat@linux.win>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 certs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/common.c b/certs/common.c
index 16a220887a53e8..c7bcf3f6a77e39 100644
--- a/certs/common.c
+++ b/certs/common.c
@@ -20,7 +20,7 @@ int load_certificate_list(const u8 cert_list[],
 		 */
 		if (end - p < 4)
 			goto dodgy_cert;
-		if (p[0] != 0x30 &&
+		if (p[0] != 0x30 ||
 		    p[1] != 0x82)
 			goto dodgy_cert;
 		plen = (p[2] << 8) | p[3];
-- 
2.53.0

