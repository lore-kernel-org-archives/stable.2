Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982B47ECD6;
	Tue, 18 Aug 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071096; cv=none; b=Zs3Dix6jLJvgoy5NKZJI5Jf8hoyzwpnDZM1wQS9XMJgDJisIHqNZqofEg2wGUINxzwYq5kjtIditZvycHDTuTP5RsUFItm8+0BgM52azKp9QOMbXav+z+SgZ7I9FbqJJnoaZeiY71nREY9xGLWf+3pgjeLPmT19nAI5rMDdaiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071096; c=relaxed/simple;
	bh=y1xEHdkQyYu4hIm/J3TTv3eVoaXv12s66et+ZRAS5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAr7fxx1bAyBjO49vH9t6fqDS+1cSM4MsycxDGEfkpz4zjaeXYYVaFG4wJC5UCrl5ot3hQukXb/klu7i0rRDksq6h/EEjFY4GtulwbuLSRzSI+4z18iMHF7gg+ZtQsk8uQ0tIap2UkirkL0mpd86o2OmvCu6uEFTC+nuDRNq6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WoT9xKwE; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="WoT9xKwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071089;
	bh=HJozyneVgN1C78ZNk9U4gpZVYe1rCvHZQb7cDV9S2Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoT9xKwEYux0LiM9tn3CCZejP9CgmS5Yi5QGfpwuP+ETXniknc+US1F78JhkpZDV5
	 EgEJjDAmhWIa6LN5UddWvXo1cUiQwugGeIn8iNTtHkv2cMw4XIgpPDyVCzCxvqjoeo
	 Bqyjea0McLCfffd2e4gJ3SWy4qXCr9sUHMjTXbUY=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hPb3j6j48z6vMc;
	Tue, 18 Aug 2026 16:38:09 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPb3j3z2dz4y6W;
	Tue, 18 Aug 2026 16:38:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 2/6] panic: flatten nmi_panic control flow
Date: Tue, 18 Aug 2026 16:38:02 +0000
Message-ID: <20260818163806.17460-3-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818163806.17460-1-include@grrlz.net>
References: <20260818163806.17460-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panic() is __noreturn, so the else after panic_try_start() is dead.
Drop it so the force_cpu path can be added cleanly on top.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 010b331658b6..e1b443150ba0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -517,7 +517,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 {
 	if (panic_try_start())
 		panic("%s", msg);
-	else if (panic_on_other_cpu())
+
+	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.47.3

