Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501371632DD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239100; cv=none; b=jVqu54CWAK18eLwobAmtfOC2v4H5SBqXhYGhj6NOTmKUI1Ju9jLdftwHhnu+FrVVvhFFPueKQDsM0YSkikm0jLFTR63QlwKdL4PUwD1gmse8baxZAHQ029+Vnr7A3w3ha7uv801VxgrISS8i3+lUi3j2jK4Fr6ppUjdCwE8v6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239100; c=relaxed/simple;
	bh=mFRxzb7+H5E8gqKt/7OXwbin9jlqZB7KMo1wDDwkV74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJoRzGcq53d9jzbooHKtKeUni6eL5OwuGhuJ6kRDV4IJMjI0E/OQHEPVXhIJdHGYh+OMu6thosrMgpQ23zH++g1QuRDqQcc2yVKqa3vXW3Z2/pAVLX1w9VnaYJjdHcno4ahWVHIjctDRl4gVF5kB6rJnUs6s9afq4MWZffpTQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3ejvvb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3ejvvb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C8E1F000FF;
	Mon,  5 Oct 2026 22:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239099;
	bh=znMWQDYvOE62XxswcPsL0MD6g0uRy9DJZHA2rmfqwlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3ejvvb0dynvOdVldeoFh1gqZ34hgs6BWUqIVb87OrmdMqYsXqmXRMjkAaFrffLhW
	 N12XgHHbt5DZXBFgvf/zY4GZRGsFjqTl8n1LGdLyx5l3JR+Pem3OJrX+cYate2Izts
	 pyEaKod+akSX36Fc3pOWpmzqgFnYjfdcDsATD51XRp9TVj/4RBKmT0qreBeoJip+Bc
	 sFWDsalQn6NE4+Y/01DBwPrQnmkkw0x49Nf8GCDnqRD5runpP2SrLuPQ373l1bErWZ
	 6Mb2ulVjMvRpWkmZzh7hsNtiLPVKX0jKBEyRuYZxycvOeTHsqz/exhKdFbnfjkbs89
	 eUzHI6sN7jaPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] serial: introduce uart_port_lock() guard()s
Date: Mon,  5 Oct 2026 18:24:53 -0400
Message-ID: <20261005222419.3425745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100556-skincare-lumping-5e28@gregkh>
References: <2026100556-skincare-lumping-5e28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 0fd60b689b0dacce659253ec15cb3d3bf660e30b ]

Having this, guards like these work:
  guard(uart_port_lock_irq)(&up->port);
or
  scoped_guard(uart_port_lock_irqsave, port) {
    ...
  }

See e.g. "serial: 8250: use guard()s" later in this series.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-4-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/serial_core.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4ab65874a850b..191154b8ada2a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -782,6 +782,19 @@ static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned lo
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
+DEFINE_GUARD(uart_port_lock, struct uart_port *, uart_port_lock(_T), uart_port_unlock(_T));
+DEFINE_GUARD_COND(uart_port_lock, _try, uart_port_trylock(_T));
+
+DEFINE_GUARD(uart_port_lock_irq, struct uart_port *, uart_port_lock_irq(_T),
+	     uart_port_unlock_irq(_T));
+
+DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_port_unlock_irqrestore(_T->lock, _T->flags),
+                    unsigned long flags);
+DEFINE_LOCK_GUARD_1_COND(uart_port_lock_irqsave, _try,
+			 uart_port_trylock_irqsave(_T->lock, &_T->flags));
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.53.0

