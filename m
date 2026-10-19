Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249F4AA02F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403609; cv=none; b=tp80xnzbi69LWBgcb/6K7cl8tt/7yygq23d6HFj95hQi8AXXOa4QUoiXlYrxLkwSPa0UON7KKaZR1J+kbCVpWKcf91GSUoR5sVp/nRF4RsHwz4RWjvcGL2z3ddVemo23G1BP51sAYfAR4aSZrkZxuiCXzS73yMXHrrVZu5tgkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403609; c=relaxed/simple;
	bh=wSN3ub5TrmRaWBsbfyH4c/xksBOX2p7ZP+TAhGLQxUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVxgaoKHK5pJPhKxLR+/B+b5qm5fBDT5u61U68uqpHH+/0E0udkdhJGiTkMzNPzA5v48yvcQcg+/0b59Ljuys6edznlFu9HfACLtSqhzPU4beUX1A6fmEo4THT4QyugG05RAAKAVEBbx6iLFDSN0xi4O9CqJTqZ182FfI0cpKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=W/BN5Awe; arc=none smtp.client-ip=51.250.60.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="W/BN5Awe"
Received: from forward102e.mail.yandex.net (forward102e.mail.yandex.net [IPv6:2a02:6b8:c32:0:1:45:d181:d102])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 1BCE1C02E8
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:53:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward102e.mail.yandex.net (postfix) with ESMTPS id C11838001E;
	Mon, 19 Oct 2026 12:53:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-QgZh16hc;
	Mon, 19 Oct 2026 12:53:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403590; bh=2SHza1+i+zwo8us2btOCup8u5eXc61mQ7dRrKv+AwK0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=W/BN5AwebfGJQbS4TBFAeP7ijTCeFiXlmz8fWC/Sys1FH+Cxro9ulHeBswnxPO0y8
	 kJ2NS4kwUZEPACIlg4Wbla/hr7zoZOv5kNxtG5CsEbh8JcQcWv7ZWh+NG526iaRAOF
	 ba9/2QdAtHB9DOtxMdDpiS3I+5RJfLbykP7cuRME=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <shodan.ai@mcst.ru>
Subject: [PATCH 6.12 v2 3/5] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
Date: Mon, 19 Oct 2026 12:52:37 +0300
Message-ID: <20261019095239.221813-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019095239.221813-1-dmantipov@yandex.ru>
References: <20261019095239.221813-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
is checked for error but not propagated to 'out_err' label, so error
handling may not work as expected. Fix this by assigning error value
to 'err', thus making sure that error won't be silently ignored.

Reported-by: Sashiko <shodan.ai@mcst.ru>
Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
Upstream commit is on the way at
https://lore.kernel.org/bpf/179239853943.3290.3841022911205774928@kernel.org/T/#t.
---
 net/ipv4/tcp_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index abaaf3e70ece..d17b347b852d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -567,6 +567,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					       copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
+			err = ret;
 			goto out_err;
 		}
 
-- 
2.56.0

