Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321630;
	b=vjCOiX2n7WcvLMZzU1ZubksUc3NVn1rbB/dHVJLLxSQNX4WCR1vnDLIVxprVvu9ptwE2
	 Gw37cFtZMejZWXJ6WP8vQuo15UXKa6eFxxYERuveVoGP1u22MPNwqJO33k3ZKTKEiOJdn
	 zGtFMOYJ1Ynl1ab2RmafzxAljkSgPcUXkGswI7T6UlZDl8he6lJuJc0B9JMgo61ZNW0j+
	 ZcAfsRfP5XruaIVFILBe6j0jlsGkxzMAVGd4TjxFf40KWFxHRQzvxZyfLVNXp9ufPolUu
	 VxqsB/8pd4ynYqix3lv7XuS35vg8D350Qa2W6B6bMnCz5ocItGtL/LvbHJVugGG39rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iDnhWwNWIWHFRc+GA0lD6SNMhHWBVbPXAdnd9zGF9FM=;
	b=AkG02cgv4bsfaPjnAB8TXbj/Qh/HEWVLB/EE7QH/dQHxdTgXIdukVees+t3myaJxdMpe
	 zbFN44PVBcHOuM0i7KDp5uBwe6lysvCayZLHyGrf9ofsF3xeNrCeBtDyars0YN67LbFN7
	 So7MypCLjJyo8gRmHRUCZo2OUevDlplXJYLoo0EQmU7V5HCcBLGJURZMKu9CQ4X6B+kh0
	 faBLn1GeBqtqvNRBBlIFd5rLcRCiAjIkzAlU9ie5+HaivCkshNWs1+m6dav3svPiA/Es0
	 6a0iKO4MqnggKc0xmKwPet3nlBv2+EqicZU7D/XKvaWGVnnffzZCXxjMu249pCqqm2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aik4i2YF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4760A261C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aik4i2YF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C11F0089F;
	Tue, 10 Nov 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321630;
	bh=iDnhWwNWIWHFRc+GA0lD6SNMhHWBVbPXAdnd9zGF9FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aik4i2YFGOP7H7z4AcoaK6OabEabK7YV14YDaFXJLmd3SzUdIED2VE6/Bt9RJWjJs
	 9ER/XkUWgJJZkhae5fOtLvn0FlL085FBg3YixukJLrRSSxKOsWQZYjdPJiQSyhguC+
	 jXONpILIRlPiaP8C0+4kw8j8dLAeKt2N7pYnH2vMZjaGDyDUOYBBk76Wrcs+n+C11N
	 XdJjHNSuQ7FhGUvT0+uP3o67d2fF6hYZfrd7ha9NzOTVZV+Yn4J7KDc7tGLK6cbWtq
	 sGZN630k808yZ8ZWNNFvsDNZ1RF3zNvW1Rh6wlEYMdyCAVHGIZj7zzmkksxlvmnfsr
	 MSCxQVj076NtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Moulding <dmoulding@me.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] init: fix early boot crash with bare hostname parameter
Date: Tue, 10 Nov 2026 09:40:27 -0500
Message-ID: <20261110144018.1943926-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110144018.1943926-1-sashal@kernel.org>
References: <20261107054505-failed-6.1-b6bec5b63a5b@kernel.org>
 <20261110144018.1943926-1-sashal@kernel.org>
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

From: Thorsten Blum <blum@kernel.org>

[ Upstream commit b6bec5b63a5b812145e53aaad1e63661c7214f93 ]

When a bare hostname parameter is specified on the kernel command line
without the '=' separator, early parameter parsing passes NULL to
early_hostname(), which dereferences it in strscpy() and can crash the
system during early boot.

Reject NULL values in early_hostname() and return -EINVAL instead.

Link: https://lore.kernel.org/20260826100904.296151-2-blum@kernel.org
Fixes: 5a704629f2c1 ("init: add "hostname" kernel parameter")
Signed-off-by: Thorsten Blum <blum@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Moulding <dmoulding@me.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/version.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/version.c b/init/version.c
index 221ccede8902a..11cbd3fb60be5 100644
--- a/init/version.c
+++ b/init/version.c
@@ -24,6 +24,9 @@ static int __init early_hostname(char *arg)
 	size_t maxlen  = bufsize - 1;
 	ssize_t arglen;
 
+	if (!arg)
+		return -EINVAL;
+
 	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
 	if (arglen < 0) {
 		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
-- 
2.53.0

