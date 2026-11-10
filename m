Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321289;
	b=BHwzhlB+kO59m1c8e2YpjdCOjFqJgt5ZwgYdvmbIZFJ6yyRfHvgkdk3ymVL79Fuoyd6i
	 PTN3XQ15Lr9IbcnnBpxEu8o30v1+BvyEJOdh+Rv4xYIB/fu1LNUgOjjLmSuCnDqa9uPZo
	 +kU9uHR2TfNJAv2/J/RSPbsVpxgKDfGs108A8wUN1VyHt47JV5MZXpUly5SnGcNV6oRKI
	 +KZ/l58SYuIB3Ondg9bCrUcBjR37art5gR4NUlHdXnh5kiExbUC7om2GiyuzsIkdOC8sJ
	 yC8MoKWXlJxp0Op0kscNQvQ2Ih6ZJSmAWIk19se9n5hKfO81G65LgT8SiZmZQH2PA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JPxWAPTyROftCdSzxISepV+MBPGWCBQ5xnvB+LEjkgQ=;
	b=eohPrXKMPftc9nOznObWjMmsuZDb7N2ZUg2tdWHTBa1b4ZPzWbOsfsxQtECYu7tw4N1Y
	 1ujTtin17Dz08iGFNnzvHgFsAVFiMBqAmOYXpV21ICv3e98IiSRatAcXppAlxHdRH1dJq
	 NrOT0dUBEUf5iWE0HwoHnhC8Qqn3hJU0Hu30C0GkCPKyysEw/ujwAlSt/ZO39d+/FuuQh
	 U3ipt8NN6/FxH2AIxRXolOfB9ksUd/nmPwz74atwzj2fDc/XP90mhWuiANUDCzfbvW49C
	 G03ghplacVX2yE3AzL+YQCJg7rj5YAeAg6mScgRaGMASaqXmab4m35LOtnBDdpptubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c41y2b0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C07606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c41y2b0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB21F0089F;
	Tue, 10 Nov 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321289;
	bh=JPxWAPTyROftCdSzxISepV+MBPGWCBQ5xnvB+LEjkgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c41y2b0Aik7zoiifXVXANXlAclABG03cdIbw/dDbgOLCPM4e3OeZcUYX7qZJMXnT3
	 1c8v1EXyI0ANaI9ApRz31U4oYz0cC6D2I2X5nxCpe1095YYdjLqHTAgjMgfB7RaUU7
	 e0h23l7zoV62Ltw0D9PVK+fj6TL4aLkM9ZvTMiXOnf6nvX3wyxX0ULUzn0N1C5nOrK
	 bQm18Pe7b2a/7xD4Jpc8eoz7Q+Ul0i+uBnrU7XbC4vuVJp6eg0L0dFRKRW5xNNEPOh
	 l6DBUNQ20WCSFAgWU3YF/uJDnPT4apilIhEPkqDO7vwJhBxb0HrGBA/ZFrjDJ4VkvT
	 Up5qgyQnQX3xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] init/version.c: Replace strlcpy with strscpy
Date: Tue, 10 Nov 2026 09:34:46 -0500
Message-ID: <20261110143440.1917716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053215-failed-6.6-b6bec5b63a5b@kernel.org>
References: <20261107053215-failed-6.6-b6bec5b63a5b@kernel.org>
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
index f117921811b45..94c96f6fbfe6a 100644
--- a/init/version.c
+++ b/init/version.c
@@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
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

