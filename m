Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991104;
	b=ePqTbVqnvDaF8wK65RCUy3jf/IVg/AN+fRpqGZSlx1Vei8VlndQLwU5O7nNukXserNrC
	 w8/g4Z8KQPqOLNoDpRRfy9lX+tWgmwAEbuCxbMYY7lGeVyXH1Tk7EmqAHml6tKHf/THrm
	 RKyPo6a9p/nYWX6xaFmIITwKxuTx4MkJlSACodBnzWfciCNCR3ze6UhCWwpX3eQuqc8Sv
	 fvFfXmgrfpy2406yth6rqrC/zol7YCQmUtN2KlnDIc4nzdK4bsKN6U3estqbhHkR8uUFb
	 VvBxvJ++vEUkvzXHSiMfnVdskXRt5E4ZNU+L9PKK6AQrClEUpcvJ5zARnlOhWt7YNYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vMKeyOZcK3q18Yw2MNqKYKjsEME0sggs4rjvagocBak=;
	b=1iVYKgEr5Bln8Ny7Utm+ScAwEX+r9WSj9HaIs1ha43wH2VObqEKnrJUF+Lae2iMqC/cy
	 GIuO/QXBRjrylzyFpIfIf99DLTXtk6Wh7I8r/DLtKh5qqQutJEYaQrCfaSTx/SR4DIZk/
	 N6D6ubeqxqYfLp+ecucwfix2ZQEaXILkts53jhm4HSOcIQKaOGpHWG9IMFik0OYsTxbNf
	 K5u2mhpjHEnRvUM/G3pQw7lDq24yjfvp/jQUuAjSEzdexb6FFA40Ww2aQd4J7KtovCjPs
	 TGg7tlWWYLmc8A7DsithCyMkANJ1RvPo2qi2FaMegyM++hEX5N4w89tQJuqYs5u4hNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKI8d9MU;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90CA606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90CA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKI8d9MU
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-862a05abb95so134665a34.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991103; x=1795595903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMKeyOZcK3q18Yw2MNqKYKjsEME0sggs4rjvagocBak=;
        b=FKI8d9MUzkUbNdnN8QuOvsu6gjuzjotYn7+lzQJRBwIH+4t5OcEvcg8yr5xq1Mj18/
         UEDlJg58pIl2ikt3lfgIJQN2Ut5ld4oFeBPcVfE2Ce9yNkrqlUYSr8Up1nSae2Ih7B9F
         zoLseKBDn0StWUum8symXoT/QHFacANkj6zGg/2OflNiYgk122D40RvVkC3g7Qwf9Io8
         I4S0Ju/K3qvDJPva7j2ONjlLiB59Fr1LiY4CvImd1FMpMuHmijT0f1nbHbgXej0pWM39
         tuQRjudolrUMfgiayZ7L3z6fPMxx71n6I6wCeUe/oPIUFIfOiBYboaZdRNz2LoR2UCqk
         WQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991103; x=1795595903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMKeyOZcK3q18Yw2MNqKYKjsEME0sggs4rjvagocBak=;
        b=t9ZHnU5vczBPdpo9BfM3/5vwqtbusiI33aatlWqhreje0GFCItCsJQqXyTYSUECopl
         kQIdLqgzHA6LZa4hrtAHucRd2eE/gQOWDO81ke867tLTGIvbPvEVOB21wl6DXvgvZJLO
         0BxIRikWFw6OIAGgKjXyEJC3omou0sOiuCvPGOL4O4PciombB53zK+51R8nrJZlpTbOH
         su4HwP/GxV3ObtEwleZ4/M/71fFivM2S5uSTcoEzB1J7tWrGCnFG7QS6FZtXxhTdZ29f
         2Xyyi2Xs9s5jzAO/8IFfgPFZsMyIBFLFOLBsEIYEXkGcqRdAolulhNFsKTg2dIhBxVEn
         7piA==
X-Forwarded-Encrypted: i=1; AL+hErGc+pSgX89WM/SLGENC0xwK9g5sLy+ZZUqoiR4ntYPcy+vBRA921csRuZ/HaT+imPzW0xDAca4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/02rjvPv1SglUioGw1ZN4JR1m8e+7Ik5kUsjikGR3wt1Usp07E
	KmqoXtSpvnShrlgAiOXfpTdMkRQV+RPGcmdaF5SABUzv4lcfT+0bdNlU
X-Gm-Gg: AYBFou3VAloI27ZTn/Mhggdv3Gzhub8lHgbyOkUGpTog5v+32iCEn9jo36bRzPdBMUS
	aA/HsaeecIwOJOY8WXlwx7+nqfn8Vk/nWhRm80DA0+k5Xk5yjm+RwA5QYuE2ViEKx2JqBQAEsog
	F635Owi4Wj5b8l3lfRq/eoscN1EA/rJlbDOTiJsoYohkWRkXGlYxUbsUs4Zv14rfMWhkVfO0qGV
	Ur1sRs3wKJzES/nifetnfAfKFGAMIDtT8dxWZ8iUgQPur4aAtYy9Jg8TLISrYbdBnxXedObHvAU
	E8t3hwisYUbT7nwIDi8pqGc+L2HZgCa0t2TuvFf81KA04/qqjjIMtGNfull8EQPaQEnJNM9FC4k
	p2+EI5/Sp3qZ/Qp8f6cPZl3kXn8esjdT8CF8Rlv3WWJOL92oRXLfIOIz+Ad83Wy3gmPPoPmiPtT
	YXFMzFvFEHcznQem/6Ur5aBwput51DmwY7kIzhbZ9i9jT0U/9+SNowSe9kFB1g6fQkXEsSUOfG7
	6vEbxvYZj1GO0Wrf9ZMedLn2oXzqTGACImyA2d31fq32gNjQMlCxxKw+yQIl7NiL/lU+w4sITzl
	gaK/htqAn61dFvtWT9dw7Za5O1U7sJk2utALqP8VQKcVIGqgLpJX9CWgGkLgawW+NFSKavWJlb0
	bnOrmM9N6ljKB
X-Received: by 2002:a05:6820:a70a:20b0:713:da3b:9530 with SMTP id 006d021491bc7-71b187889e8mr789320eaf.44.1794991102733;
        Wed, 18 Nov 2026 00:38:22 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b1945800asm1516812eaf.5.2026.11.18.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:38:21 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: walk the accept queue under the socket lock
Date: Wed, 18 Nov 2026 16:38:11 +0800
Message-ID: <20261118083811.1721010-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

llcp_accept_poll() walks parent->accept_queue and reads each child's
sk_state without holding the socket lock.  nfc_llcp_accept_dequeue()
unlinks closed children and drops their creation reference under that
lock, and the last sock_put() frees the child.

A poll() racing with accept() therefore reads a freed child:

  BUG: KASAN: slab-use-after-free in llcp_sock_poll+0x440/0x4e0
  Read of size 1 at addr ffff888112387812 by task poc.bin/528
  Allocated by task 198:
   nfc_llcp_sock_alloc
   nfc_llcp_rx_skb
  Freed by task 529:
   __sk_destruct
   nfc_llcp_accept_dequeue

Take the listener lock around the accept queue walk.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/nfc/llcp_sock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde68..3503f1a7a7cc 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -584,8 +584,16 @@ static __poll_t llcp_sock_poll(struct file *file, struct socket *sock,
 
 	sock_poll_wait(file, sock, wait);
 
-	if (sk->sk_state == LLCP_LISTEN)
-		return llcp_accept_poll(sk);
+	if (sk->sk_state == LLCP_LISTEN) {
+		/* nfc_llcp_accept_dequeue() unlinks and frees closed children
+		 * under the listener lock, so the queue can only be walked
+		 * with that lock held.
+		 */
+		lock_sock(sk);
+		mask = llcp_accept_poll(sk);
+		release_sock(sk);
+		return mask;
+	}
 
 	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
-- 
2.43.7

