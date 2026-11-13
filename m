Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552915;
	b=ftto6JVy6sxwV+EJFsMPbE8fNXAmUxi66cmUiw5A8iQ46sAyXQw9f1/i6F0v6uJg2dD5
	 ZjEYHvsZz4aOeUtHnPF1DHZrD4La746DQr5zZ3z44MEJvxcDoDGdRhqhEhP5E5G3aICI9
	 Wx6tJj2tsEJKqHieDvDxxXLZ/TfP0RbTEktRC2yh5gTDSHnUjzOVliHj2BTzhRPC+WOXv
	 2y5APUYLYVS9e4cxS1NC1UV6YXcIfzzFMjT4ubXQtklHXRrPtGnx0jUgeilm4guVJvtIp
	 FVkx6c48pcI7UBP5JgOlGQU3Vt564CskeuqXqVEqXlzQmZeP+hIrL6TSdfcjG26pgog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=+/IkY+Nq5HTaTqPlgsehbZVL7GGARE1spdIptKHKV6c=;
	b=Le4QnFrL7zdEdcETlQ1TLde9HUC3doETeRkCg1WlYGPApg74f5aS+o0WDVKYRpGve2re
	 +ig+iFE7FUiQFVdL4q82+RDHe8rgTnghcOgGOVzb/x+d2rWJmCGRlTwEAVo42rKvFzmGb
	 0G2BQ2ADs1gliT6/Q1nBn1yc8jVnAZhUpW9bEeIXWl4KzKnEIqWrTkYr7XiFsnds84Hoc
	 AmqsAIxu4do8ywunnoxyAvhaxsAGswzZET2YvyfVfPcCF4TEiRweAZmmSk/pumKyCjm/l
	 dGntLNeAGtp86+5VTZK7SAamCODBcYv5rfkEL1de1wD1kpjaWBsKmrp9YSiqvX8a+xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baj7hDFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9172606A321;
	Fri, 13 Nov 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baj7hDFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC01F000C6;
	Fri, 13 Nov 2026 06:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552914;
	bh=+/IkY+Nq5HTaTqPlgsehbZVL7GGARE1spdIptKHKV6c=;
	h=From:To:Cc:Subject:Date;
	b=baj7hDFkIrNyJhBSoRu7B37UfV2OY/mCGrh/8gE2CP/gtBWVrhdsJG+StClLHdD8a
	 59L+jnYITXMRKVmUBg7FVuFLQWiVHD87Z3lbma4Fx+bUqig9vjC57216HrnXnxy2vO
	 0vfSXJDeRV2XpyLm7E63kdQ6fAAwES6sb7hb1wKDXD6vmqak771qXaXmXuaEOQVyHA
	 76zaWX7JoPENKD2udzvC/xvTcXrges6MM4jnYu4zygmG17MAlVoL+V0lg5OZ4ZC/7S
	 MbmXKGZZ4agPsw5k7BslGRSi9ZkEPSDBhQauEi9GukgFyN61A7BEjzTdZBgMRRCYz7
	 ISTFiwoIXv0/g==
From: Kees Cook <kees@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dennis Gilmore <dennis@ausil.us>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: Start the program length at zero
Date: Thu, 12 Nov 2026 22:55:12 -0800
Message-ID: <20261113065508.i.606-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=kees@kernel.org; h=from:subject:message-id; bh=xQN7XK4tw3ga3A7lA4yomCO7X4rjVCnrTDnfj4GPyqI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnftvjfleBkD6y6LhfjqbYqdulcrl8xX03ZeqTfZ+5ba c1lrKfcUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFYeYa/gtOfCP6c4hh6p7fV ZQHL+d1LJi85pMP/YuEKT+4ZmxYUhjIyLF6utJS/8S7zptqk1UYlJSXPwt9esv3M29nr4f/igX0 DIwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

spi_engine_optimize_message() allocates the program with kzalloc_flex(),
which sets the __counted_by() counter "length" to the allocated size when
the compiler supports __builtin_counted_by_ref(). The program is then
filled by spi_engine_program_add_cmd(), which increments "length" and
stores at length - 1, expecting it to start at zero as it did when the
program came from kzalloc().

Reset "length" after the allocation, since it is a "usage" counter, not
a "total allocation" counter.

Build tested ARCH=x86_64 defconfig with CONFIG_SPI_AXI_SPI_ENGINE=m and
W=1, with GCC 16.2.0.

Reported-by: Dennis Gilmore <dennis@ausil.us>
Closes: https://lore.kernel.org/all/20261112025252.71375-1-dennis@ausil.us/
Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/spi/spi-axi-spi-engine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index ead5b295e680..9cfee409f15c 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -818,6 +818,8 @@ static int spi_engine_optimize_message(struct spi_message *msg)
 	p = kzalloc_flex(*p, instructions, p_dry.length + 1);
 	if (!p)
 		return -ENOMEM;
+	/* spi_engine_program_add_cmd() counts the instructions as it adds them. */
+	p->length = 0;
 
 	spi_engine_compile_message(msg, false, p);
 
-- 
2.55.0

