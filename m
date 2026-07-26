Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BD370AFC;
	Sun, 26 Jul 2026 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092665; cv=none; b=u0P9XRXXd1PZdLM/sD65XfMEcGMmyoQ33Q8nnzEumuI2MSRN8k8bEBoYFvTOpdUvNdcx+r6hW6v460actkGOGajtu/bqGrRKf62wPDVZ7Fcc/c6wgcaubPEc7W3IM+wImgg9O1btlErK3cmfXH/IQmOfBsH84PoNcRlWOZFvjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092665; c=relaxed/simple;
	bh=P8I2GRvbjLoIuVcmUhpS0nAAMO5guMuLMvbSi9y0/so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5SCmMtWhrOCLu+mzmzWLTEdtIDSonZkmOblDJE92NLLlKnd4y3K3A+n1vc+jKpTt17Lq/DvbwWSXp6YubXz59Imd8fhiL/mjaogVV3pgu1Cd5H8+Vsp2eWk15A4J0vVHwCMYa2NWHXsIB5cwf+hKbjZ8+LmMtKOMIKP5emQzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=mR/ZJk0z; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="mR/ZJk0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785092655;
	bh=8hrwqkEbE+xCP5QImKxJlgtfWpbG35Hxqw1lQB9hZX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mR/ZJk0zMcAq7wD6jENSVAAGvicV0eMpLeplpO7cNAo5yJJNNXIJ2X9regoJ5wCgv
	 b3Iihy7P4/gBrn4lDsz5O8ghw9K2twk72pi+hml7mR/qf6tC0NyjiBtM3EQmBgCgXY
	 i38IrLeZHk7SrfwSFB06lRT/3UUK4vWePVOukHtc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h7WNv3JQ9z6vQS;
	Sun, 26 Jul 2026 19:04:15 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h7WNt5P1rz4y2Q;
	Sun, 26 Jul 2026 19:04:14 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCH v5 3/4] panic: fix va_list reuse in panic_try_force_cpu()
Date: Sun, 26 Jul 2026 19:04:11 +0000
Message-ID: <20260726190412.10891-4-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726190412.10891-1-include@grrlz.net>
References: <20260726190412.10891-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsnprintf() consumes the caller's va_list. When the redirect fails,
vpanic() reuses it for the panic message, which is undefined
behavior. Use va_copy().

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 74065c860779..a483587fdd2f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -416,7 +416,12 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 	 * fall back to static message for early boot panics or allocation failure.
 	 */
 	if (panic_force_buf) {
-		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, args);
+		va_list ap;
+
+		/* Do not consume args, the caller reuses it if we fail */
+		va_copy(ap, args);
+		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
+		va_end(ap);
 		msg = panic_force_buf;
 	} else {
 		msg = "Redirected panic (buffer unavailable)";
-- 
2.47.3

