Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30446C832;
	Sun, 11 Oct 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758067; cv=none; b=jwqvgCLhnUMN/UbntfjoLRZ+WrzGDDhwWdFsBz3Z8saG8UZy6tfnvYvnFIxPsKAKEOb8cltkUNmhJ7djWc8Qcdk/tksB9OaRe3T8zL+DuKuGs+koTLU/Vgj/MEIc/2X/yVXnlhKHibg037J97HMmPrZSbQFuQPHfTomdA5LXGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758067; c=relaxed/simple;
	bh=iFWSeXt4IkuSPGBClUsUtxNeKD3QE1xQ34dzJ1oOdTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaGhpKo8A+vXrATzm3KlJoJSkPXsUD27oZ6T/LWj6zAkkzUkPhGm8TqrC97VNKjsiVLq966F+gIGUm7AkkKDSdAgERnXOq5EvwFxnWL636d/QsqGhl7qJ70dyi2Mb+7u7OwLv/GKzkqh7EFUEtii1/rY0rSXK67+hPbRQcTbWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRH+o2LY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRH+o2LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662831F0089B;
	Sun, 11 Oct 2026 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758066;
	bh=ByMa4MaE6Y8d0cyku8fCUd0wmoUCAmy7PZy2XLjvv2w=;
	h=From:To:Cc:Subject:Date;
	b=BRH+o2LY0exKrfiaHEXnrq5LjWgTTgUX2eJgbg9v8R4umH1yN9Q8cq8hd/ZE/HI5P
	 CydM+2EgRNETvwCL/YD12fQVF1sZ1GO1BWGxdUbdsqVBIXqFIeZO+aHokPz2o+RDjr
	 LZ7zAh4OSDoVwf0XcG+34oqLwEvwYfnKTejdNfI9BZ6Nw4iGcq2Df2SMwyPTVs5DiR
	 +z+7QY7lffoamg/4t4Lcq56GaNXY5f7k+2hPQXYXcZ7xlSoO43pO4/+575NUFayMrr
	 JgnvgUjhFdoxFO0TM1zjkEQZc+5HMXKoH/PGOESCHPJmorUxy23mQzJK0x0+5Reo/D
	 E/xeVSJ0T2VSQ==
From: Sasha Levin <sashal@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ben Hutchings <benh@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] bootconfig: give the footer size static_assert a message
Date: Sun, 11 Oct 2026 18:33:41 -0400
Message-ID: <20261011223358.2327625-13-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static_assert() without a message is a C23 feature, so clang warns:

  main.c:498:56: warning: '_Static_assert' with no message is a C23 extension [-Wc23-extensions]

Add a message.

Fixes: 6ed5e20466c79 ("bootconfig: Fix unaligned access when building footer")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 17d971d47f879..df05340358578 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -495,7 +495,8 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	footer.size = htole32(size);
 	footer.csum = htole32(csum);
 	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE);
+	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE,
+		      "bootconfig footer size mismatch");
 	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
 
 	total_size = size + BOOTCONFIG_FOOTER_SIZE;
-- 
2.53.0

