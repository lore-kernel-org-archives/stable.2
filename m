Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321630;
	b=1hmouBqWFA7wNRAku1w0cb6AWY3+tqRM4n6K8tlqz/pF0RrD1VVY8UMkD+y6fzHp0PZ4
	 KHA7lb09HrWhOOZPJiK4pQoLKk0R6eyFD6CLzvwGsEkxNLt/586bc2rCMzTLEifV456ga
	 pEvkD0w4h0G3LWWeL+z1DPn8uhVMvV2mM9PSbO2JvHrGsD0n18z4i23kFPRFyJ7iFCgaF
	 TtrEOXZ8UibOY/cQBbw4JA2jH48yJDAhQFtqL8gfiNawvluP+RgD+T3GEjFecrJYvAJ+G
	 /UgH+RHMFrWc2FMCywzGDGc7KP8X6UtKO6ak7P5SHSbAZ2D32LopJkLjgc1TJr19D5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0BFbzGp0NJAMF3m0hlVnWgQiJfd3wdl5rJOv2Ou0Ns=;
	b=eVGw1p07EO2DSG6dm+AdWP+ciVJbJEM1z9XFZSNlaDeGNbQnsfaHpMg1RtekvoJNw2Qc
	 GVFr34Adw8eHyrIKojL39L+11hpz6EqKv0mlCVQecCdvqVvEyNORZARZxnrmLWaASGMp3
	 CsDspfFDAGFdosH+f3J604JXlEhkSzU5bIWf7Xp4SqI83k8LTOjTlKbmkogmJnZ0RZ9wa
	 AXwfEs1cfjy9vSRCVExtGu8pxtkBU75iHrpwU1LGt6v1oIH/8+XJx5gtUQtrNuTkSH6SO
	 CVHXXPgDQwf0+528IanGZfAX7M+gTgUl7ywkm7FNMTjFkNyotWdkaD4Cp660Lzyreyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlEtawyh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DE606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlEtawyh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D411F008BD;
	Tue, 10 Nov 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321629;
	bh=K0BFbzGp0NJAMF3m0hlVnWgQiJfd3wdl5rJOv2Ou0Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FlEtawyhsyoC2qqExLZ4887m6vDUe1PCuA9yW3ShMfekY09lZkymZtDz4x5+qI2zP
	 8REZIos61Y+dTH4WH9uQFIexP37sNQb/Y0djnIC48mbOuMqmr2YXynhyaCrG6Fp+Cp
	 TQvCyAnMf07wGJVaTT6gS/Lc6G9HKrKfpi9mH5CEHHTCnhfSPXw9bY7CVA8IJ+8v/u
	 RuJ014xbGDqwnrgfq75UyvwGsvIIHnE/NubvS0Oj+zgTNPQrz92EyMOW893hDmQXNN
	 0XKJ8hgn+U2yv7sZDfpGY1K6WszF3u0vTHvHxtGQ+b9mIbCZgeyjUioermhRZ2NNrH
	 8IAcfvjW5U7kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] init/version.c: Replace strlcpy with strscpy
Date: Tue, 10 Nov 2026 09:40:26 -0500
Message-ID: <20261110144018.1943926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054505-failed-6.1-b6bec5b63a5b@kernel.org>
References: <20261107054505-failed-6.1-b6bec5b63a5b@kernel.org>
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

From: Azeem Shaikh <azeemshaikh38@gmail.com>

[ Upstream commit 8ebab155ea18a6d6c47b17287a0ab4633334f6eb ]

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230830160806.3821893-1-azeemshaikh38@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: b6bec5b63a5b ("init: fix early boot crash with bare hostname parameter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/version.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/version.c b/init/version.c
index 01d4ab05f0bac..221ccede8902a 100644
--- a/init/version.c
+++ b/init/version.c
@@ -22,10 +22,10 @@ static int __init early_hostname(char *arg)
 {
 	size_t bufsize = sizeof(init_uts_ns.name.nodename);
 	size_t maxlen  = bufsize - 1;
-	size_t arglen;
+	ssize_t arglen;
 
-	arglen = strlcpy(init_uts_ns.name.nodename, arg, bufsize);
-	if (arglen > maxlen) {
+	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
+	if (arglen < 0) {
 		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
 			maxlen);
 	}
-- 
2.53.0

