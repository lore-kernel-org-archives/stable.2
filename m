Received: from forward104d.mail.yandex.net (forward104d.mail.yandex.net [51.250.60.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D964AA02F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403599; cv=none; b=rX9iG91vZLCV++Emt421EKBqOTu60LXrC2WZqV+l00QMjrCQz2telLCfBfkvArTqEZwyRMnRIpMtWprWjEMIJH9noJc57VjDtgWtydxUphpE2Taj1bO+vxQOb1KB//obDUv6EYEbze33gBYfFG+KjJEhZFClt8/vWB09amUKgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403599; c=relaxed/simple;
	bh=skV8ZvII+p+Xs6akVp6QH27Vb0T9vfT2BYXzDdsufKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG0Uywjj4sA7rjPOGSdY3q67d+5vQ4+WaVWk3ZyIlbrPnSLXtQvAqfIjDkgXUMOQo6oV7Evcl2knR10TVBORndyMW/8iWEsbCAYmmzZS4ib+AGRmWFVPYRI4VevDdLV19psYjJ3URsdjzKD3q1N1BoSl29S4NJkWe/yfY7U/JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jPtbdWuE; arc=none smtp.client-ip=51.250.60.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jPtbdWuE"
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward104d.mail.yandex.net (postfix) with ESMTPS id D4CACC0048;
	Mon, 19 Oct 2026 12:53:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-4WCStlZY;
	Mon, 19 Oct 2026 12:53:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403588; bh=S315m4hUJ3w7yDcHzy7rJDTkk8pJOmbqZYJ/wzxDN8g=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=jPtbdWuEdLnLVNCENOA3fj2B87rGwD/qppzIwroWh0Ju1JHAm7r6aSqGA26TB8rWc
	 dFJ9z1g8HD5SJxt6v2S28FqVcwij0nKXv+yJgtq0xIQJwasYzHX3MhtlEH13zZw/th
	 BTmaBPC4Lm3VNK6MxJ+NA4hb3snVzAfgoiiCu+v8=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Levi Zim <rsworktech@outlook.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12 v2 1/5] skmsg: Return copied bytes in sk_msg_memcopy_from_iter
Date: Mon, 19 Oct 2026 12:52:35 +0300
Message-ID: <20261019095239.221813-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019095239.221813-1-dmantipov@yandex.ru>
References: <20261019095239.221813-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Levi Zim <rsworktech@outlook.com>

commit fdf478d236dcf0f1f68534df5d456ced625195bd upstream.

Previously sk_msg_memcopy_from_iter returns the copied bytes from the
last copy_from_iter{,_nocache} call upon success.

This commit changes it to return the total number of copied bytes on
success.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241130-tcp-bpf-sendmsg-v1-1-bae583d014f3@outlook.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/core/skmsg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6eca57da3cff..42e14d2f6966 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -371,8 +371,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes)
 {
 	int ret = -ENOSPC, i = msg->sg.curr;
+	u32 copy, buf_size, copied = 0;
 	struct scatterlist *sge;
-	u32 copy, buf_size;
 	void *to;
 
 	do {
@@ -399,6 +399,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			goto out;
 		}
 		bytes -= copy;
+		copied += copy;
 		if (!bytes)
 			break;
 		msg->sg.copybreak = 0;
@@ -406,7 +407,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 	} while (i != msg->sg.end);
 out:
 	msg->sg.curr = i;
-	return ret;
+	return (ret < 0) ? ret : copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 
-- 
2.56.0

