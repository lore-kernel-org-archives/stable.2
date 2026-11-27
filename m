Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807654;
	b=0T6+EvKcisv2QANUd9B19Hzo7rO35eAnKZdg0FEJ823G1g0CSUSIK9zN7pwOLojsLSPl
	 0bapUwUxCLHSI3laKUeA64JlNaCm5Wx+Gvr+kpkU/BZXwaLJN5zVxOjsdlyizqwv/uoqS
	 AmIY/wvPTChuXnyhqmjk+jZ9IYWroC1ncSOwmUD6vm4vnCQhYYlwgjLFYoNmzBJvORJGy
	 BkzVIbkUxWyxD9iDgp8CY2PZOxBbDwpcXhK+hhpHWkp6DcoNhwS5HkyTX+z6hKB8Gk/Ft
	 TDRTwHEVjathuAoj7eytnz8w9UjEUDEg3W20pP46eexVGdZUvamP/wu0T1qZYPhU2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r7C9yHzbT8DIhAv52A8PzBhP7Xd4zcT9yST+bFKc0ms=;
	b=aiVvZBATjf+8M6tDI/QPzTIbA3kz8iknrdV8A47A+Y7xbo3vIfH+5NkNlW/V/JTrI8QY
	 PAGUCa0xJ+KAHcKEOjY2XY5cl27IXfEMkmJQubUmcCn0+HahtlOofV8bZknv9p8Ik0cqT
	 H6s0erE4RjVQuBd9/qmrVmiyw1fLw/w09/AHWGqzTuIF1mD9MD0Z9eWV2lpK1Mh0nYt4t
	 l6GiW3pYGpFVqQg4jil/n9gSff02Q/mH819STI2nbyjOugMFK4+vbIg1x0XRC366l2V9o
	 5+SoizfJJ6svecM+bS6ewQXOfQPG4s3OEsORmXwfuZwAgSfsIbsehxTTe8PB6Wqs7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cpf/cU+M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE89606A321;
	Fri, 27 Nov 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cpf/cU+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4281F00893;
	Fri, 27 Nov 2026 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807653;
	bh=r7C9yHzbT8DIhAv52A8PzBhP7Xd4zcT9yST+bFKc0ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cpf/cU+Md3N+ksXOoD0S58TSb6bqmYYw5TW3+bEdw35AP4ecWwUYTU6EqjfUtq5Ni
	 Td0p5pygiWPiqjabPdJlqTKpOQabMNTdP2GBu+hMfMfDRoekzpozeuKFZbiUfVfd1I
	 Awu6YkX8E8tJKxNGoa3+vWNlgKH0fPTmSjo99ckt8KIUsb7vIqJo/nP5iyJRU+wphq
	 UHyqPOisRUrR1iz6kaCLLwddS0Tvo33NmCqeeT3PSGILlmUJS8QSfJvQ6+uJ+i4HUx
	 Yp15+ir08+cmEtQF8G9KDQjak+vfW5Kh5xenah2+bUDc0QFVqLzEPI+dXPmeyvYebx
	 EIpEqpcBLuFkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	"Thomas Richard (TI)" <thomas.richard@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] clk: keystone: sci-clk: Check allocation failure before copying clock array
Date: Fri, 27 Nov 2026 19:25:33 +0000
Message-ID: <20261127192620.3443537-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127192620.3443537-1-lee@kernel.org>
References: <20261127192620.3443537-1-lee@kernel.org>
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

ti_sci_scan_clocks_from_fw() calls devm_kmalloc_objs() without checking
for NULL before passing tmp_clks into memcpy(), and invokes memcpy()
with a NULL source pointer on the initial iteration when max_clks is
zero.

Return -ENOMEM if devm_kmalloc_objs() fails, and only copy and free the
previous array when max_clks is non-zero.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
Closes: https://sashiko.dev/#/bug/linux-4e2ecf16-17f1-4188-880c-c714a1bf588c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/keystone/sci-clk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 967f77900358..4cb1299cd49e 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -495,9 +495,13 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_provider *provider)
 		if (num_clks == max_clks) {
 			tmp_clks = devm_kmalloc_objs(dev, sci_clk,
 						     max_clks + 64);
-			memcpy(tmp_clks, clks, max_clks * sizeof(sci_clk));
-			if (max_clks)
+			if (!tmp_clks)
+				return -ENOMEM;
+			if (max_clks) {
+				memcpy(tmp_clks, clks,
+				       max_clks * sizeof(sci_clk));
 				devm_kfree(dev, clks);
+			}
 			max_clks += 64;
 			clks = tmp_clks;
 		}
-- 
2.56.1.839.g22a8290db9-goog

