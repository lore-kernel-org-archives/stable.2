Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321290;
	b=bSYFeGcwbd4P87oHkvBuUoQk+OIIfVrtyUwto28yOIrK4PlLJHPEDdggwOlsAPt8xUOi
	 cRruDDsCP+nwTiP8rFUJHoEV8aC2C+Qgq9LW2g98SlzkXfzyN+JktBfTFhNBs3A7BAtZ4
	 65rFQG3WIabVMLLQJu42/q281gWZHtmCdg8lUWyd2bQr7aHj5xAm84DfujljWyB7+V2ly
	 NA0OGO8b11fWMTjClE+/r5yAld0PF3SyA19k1G2cWjKISTLFqfW6Y/RqTrAQ5u3uGqNUP
	 8/kS2iIQHUO0TAuBvedMdq6ZNuSVS3F5NvQEGKaLeWkZAFznVHhQ6xxA653nUlDMnFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tAt1RABVaS7aEUxdXbNQDZYHPP/SqykEzAsxv7gIPcg=;
	b=oth3lbvO+F/S3FNkDmLQpoYPvXJSwMJeCIz9gDSfY5gknrnVaQXUpUM4wHF6ESSqd2RY
	 hVm5Snym+HsZeWb/lU6RXtQ6UJncDH2bCWI8NJ+4/FgcSdbAmWYrf7PxWGwKBnZUmQFK/
	 me0rjaiMf3IRwIozH4LM1/+yXKc8ym1sHuBgnedFIB0goP1265Rdq13EsfZR/Vm8keF5r
	 g4L3aIRqDo3gjeLWeUvseq5KSUmDohVJdBrUtvu5hWHZlHQGgWqWU3zi2LI3a3HeuHCLS
	 pxKPnU3mcuO6xPc9ZbT5CVuUzRPFRXflLwtJn5qhFaB38sZQ6ikzqJGQiYt1NXjYDVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRrVBTsC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD47606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRrVBTsC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B00B1F008A2;
	Tue, 10 Nov 2026 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321290;
	bh=tAt1RABVaS7aEUxdXbNQDZYHPP/SqykEzAsxv7gIPcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRrVBTsCtcklm58+HVd8DHCaAE7/WLngZ68puH+t3ILEV8V+nlFOrTh7Jiht4Hl1e
	 PqFzhqnhmIrSIE6q7huJIef12L0jtqRLlDXf8E2OonoAKWNsMHl8/lJq1/EyDyCwys
	 Z9ct+DRMyvT/ioQq/Fj8d0uOhWrFZc1nmiYV4xx4gpIcq1jOm/m4jtmndev9K7IlXG
	 YxPhPkX6ov7aOJHFfta2r9hkSb5UsQIBgwSB2t4DTSCoc02Iu+XD/Pu8a3uAecO/RW
	 B1mHdIe5zM79NJxNXwtf1ROUjlsSlr71wf254tLd7DVAXzGJA9cyxvlNjabgCiBYVA
	 gOW1TsGfvlZGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Moulding <dmoulding@me.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] init: fix early boot crash with bare hostname parameter
Date: Tue, 10 Nov 2026 09:34:47 -0500
Message-ID: <20261110143440.1917716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110143440.1917716-1-sashal@kernel.org>
References: <20261107053215-failed-6.6-b6bec5b63a5b@kernel.org>
 <20261110143440.1917716-1-sashal@kernel.org>
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
index 94c96f6fbfe6a..0bd5c45aabc46 100644
--- a/init/version.c
+++ b/init/version.c
@@ -23,6 +23,9 @@ static int __init early_hostname(char *arg)
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

