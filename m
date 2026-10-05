Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340A4AE12F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220679; cv=none; b=bATDK1MUZ/+4cKJ87hpYh4wSrC/MHMBICK7ATS9PffFJYVcRyMULW84n+3+OeZ5IabF8sUTdT+fTgqKBdfWf+hMS3V6LGpgnA0x5+W5+q54/V5WJvg+Gh4aiHrZDGhwKrjsZa1N58sV+XPOKKxwwXoW6DJ4uFzxX95ACianJwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220679; c=relaxed/simple;
	bh=isqkyuC20l0KsayGo9BC73sc8LGlcUBz387l9MvZ5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFllO0xiplsKewVIcNvuV+ZFjGOGEXfLtx1G+oWPegrVTCtcX0rH5Pdy8DXjkOGbezasZd9gy/3vvCiio55OLcQsxaruhVF3jyv+flAESlgnO7b3NItYAUuyeBTiXDaYtgccy0YpK56CXWWpyU3WBMLx0QAw6JnlmNfyjf74uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZChN8af/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZChN8af/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D6A1F00893;
	Mon,  5 Oct 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220678;
	bh=UEjMibGBH5J81ayz8xlUAdC2YcUVvrQwSIqvy+KUew4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZChN8af/if8wj7dPh/ZMlH61BICU35m8W2nGkihe5m6JPPn8LYQWmbHMbxRHtu2yy
	 47nrlH6loZk0mPlqAkO7d2A4g/iEzFb5Zd3uqTZeC7pr576IIsalITb4btT4nRf4mQ
	 ELowM8pu13Z8zwdQILxFe1QzHJ6mg7FsK4xw+Xxolq682PLyZZtsiecPCweOD57Ce1
	 irW9cxLLWIS9DwkKe3LrhNzpYMVMGvhzId3bjBzGqSL0G+nzeeHpbk6db0ZV8VE72J
	 /2xUfk4mbY78OP7HDLGOgoQUBOr82wbj73UVTA66ZTVjDDSL+2khVFYVTA4XW+6IhX
	 Xgv7bFRZ68hVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] tty: introduce tty_port_tty guard()
Date: Mon,  5 Oct 2026 13:17:52 -0400
Message-ID: <20261005171429.3065052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-mammal-arose-32f1@gregkh>
References: <2026100521-mammal-arose-32f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit e8398b8aed50382c21fcec77e80a5314e7c45c25 ]

Having this, guards like these work:
  scoped_guard(tty_port_tty, port)
    tty_wakeup(scoped_tty());

See e.g. "tty_port: use scoped_guard()" later in this series.

The definitions depend on CONFIG_TTY. It's due to tty_kref_put().
On !CONFIG_TTY, it is an inline and its declaration would conflict. The
guards are not needed in that case, of course.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-3-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 56964f6a3123 ("tty: tty_port: restore TTY_IO_ERROR on activation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tty_port.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 41b1c72745ca5..5e2cd738aceaf 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -273,4 +273,18 @@ static inline void tty_port_tty_vhangup(struct tty_port *port)
 	__tty_port_tty_hangup(port, false, false);
 }
 
+#ifdef CONFIG_TTY
+void tty_kref_put(struct tty_struct *tty);
+__DEFINE_CLASS_IS_CONDITIONAL(tty_port_tty, true);
+__DEFINE_UNLOCK_GUARD(tty_port_tty, struct tty_struct, tty_kref_put(_T->lock));
+static inline class_tty_port_tty_t class_tty_port_tty_constructor(struct tty_port *tport)
+{
+	class_tty_port_tty_t _t = {
+		.lock = tty_port_tty_get(tport),
+	};
+	return _t;
+}
+#define scoped_tty()	((struct tty_struct *)(__guard_ptr(tty_port_tty)(&scope)))
+#endif
+
 #endif
-- 
2.53.0

