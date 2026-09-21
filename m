Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9B35E55D
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969707; cv=none; b=kisO05pMvU+iEIOdhuyj7o40Bx2dW8RQFZ/E11h28h5uAbV0OuI1vYWaR53cqhDovk8apLn7Ex5iQaQy0EkFYVY4LDZ8nmD00GpZw/rqmcjfMANPKOJDZZSQKGp7tWXoP4IsTsma6Xud7HNneRRFmE3d6dPDcfUYM4FETkAFtYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969707; c=relaxed/simple;
	bh=8xMxHrMZKCLWCGtEEIoMvriov/njsTTmxt2LdeiMaus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtF49QCrqsLcickXzhEE65t92QiWkBlQslczeBvBhoieEpxeH7BNi8PRmKChDotN8aN4Yf5Z0E/PARdHozsxMYj6O7wtBCAdT2OU5Yco1/chQYyf2nlOlDAqFUlixYh8jnMVbMHhzohLzidsepzjCUSGIn0LMew7HLt/GNfONSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDT/XQ1l; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDT/XQ1l"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so731734a91.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789969706; x=1790574506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtXVDzTY65CAD90qKovN60KJ+n6IiEH3Afd2IJ+KCWA=;
        b=TDT/XQ1lb0FF0Y08AP9AVy6AFcnOfHQIubQinRsgQdDZove8/2McJbXs6PnzK0NpPe
         g/s8z7IrvuNVYpHjuol1qX/1xrC/vfRWwzq2SXXH7gnfN4Cs1aoCHzPVBXotIYIkVMfo
         aXYbcFBzxFDPED3j/JSywl590SCu8MRgcdjHElL2vJpWhJ++qfbzexpRsnS3EQm5DMh5
         sMlgE2MhtiwxvBqjdJInJlN1uG5TaA1gGCFPCmoN+2C3rjnIRYu44ZofJwkh2iEIv6td
         4j/KA6uRFJ12g9mt6waezdAbjAhSiTmEZS0G2MizFEBEalfJ2B0k6fg0qmzX19JTTox1
         Ws/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969706; x=1790574506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtXVDzTY65CAD90qKovN60KJ+n6IiEH3Afd2IJ+KCWA=;
        b=udJ/4ngI/OlMk3PGR+QXIcEpLWmvfWZWqCJc3BAMcr8f/GCats2prP7OJs9dvU9/RN
         cToLTdNk5QgMMAX2EbDAOEzmbJrcA9geL2PoAQWCUpcP3d1PeJBkTDk4keOyyDVl/Wxf
         OYbswx0JcnApO+NT45du7FZNXAAymS2HkGnoPBdrT1+O7vguiqkg1piHh2q2iB2IBzCE
         zTRYIt3TSL4w+c+UxX1Z+Wk51YPqc8jgvJ0EGqULx6cgc1SSNU2E6VxoVhyeiklpmlrW
         ksJ6sM1pNlvEhqeV6Jk5L6Wj+vRRfUdPCEiWo66CqhKNalbbrsgVpTE597AcPcGV4bkm
         5Hyg==
X-Forwarded-Encrypted: i=1; AKwUvBwtp6xbs63toHMLdgUYvV1es60deKQpiD/eyyn1/Aapo8wVjT4Q90cP2IWL+CgB/E4bPRZ1WWA=@vger.kernel.org
X-Gm-Message-State: AFuF++lQJ3HapnOA8fl5pzcZd8LTtLTZEcPgrFnjA+uCuVkIaYc9DL/0
	2zwXjzwGdwGOxIXuzkyD3qfzynuQJH5CuVi0eGjxSW7mr1zBDsRblv+r
X-Gm-Gg: AYBFou2C0Ka1G3YHw+lyBPVssa2LCvEXwDeen8iS1oZZQoYnLv/A56Ku2cDFpkdNiQp
	GsFa8lnw8c4QDWTyM9MMMHEmUPWJbtiWjzWLWEwQlOV2I2eOVaf7fB41+Uh8JR1nslI1PdQo85E
	37h/tyhqH6/m35jJ56HFWMPH+cCU3Qc+Y3UiMI4U4zLwSHw4RY9ZsWAgqnZ58nCOo4RvhswRw4P
	PSgbxTKD+24ZGRo9yzFsTtaBRCxZ06ZuCflsKBL8MRewu3yKYAT3D3IIm+hOs4JkRi7NGNPkJVc
	tUBmhd2ErSvcEu1pIWA8EWWP0VJHVB0hZu7g62OlCMtu7Gzp6AHDekK4bk1AQ+jRxpISJhytZ7Q
	1LLDvWi7vOMjSgBNqemXOY/epzKUnflECsmBZ2bx98cLRi66vnI9ZmqE+A0Hi3r2upiLsREFjMP
	6BohaOtUMJDqxsLv0XQqpQbR6lcTlV4Oh+GDG+sf1CmXNvXr3V5hwJtcjggjfygY8DPtC//ThNv
	wnmBKZMPKHotxjXc+QKiZfuw+4IllHcqBVzTi41mesEZCUv8EMAo0bgVWXusCzkYKUyWqnJCsZS
	p/cBsOXRBQ==
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:4b67 with SMTP id 98e67ed59e1d1-39e6c6a5448mr8150645a91.49.1789969705649;
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm12640514a91.15.2026.09.20.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	mhal@rbox.co,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	benquike@gmail.com
Subject: [PATCH net v2 2/2] af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()
Date: Mon, 21 Sep 2026 05:48:23 +0000
Message-ID: <20260921054823.1822122-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921054823.1822122-1-benquike@gmail.com>
References: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
 <20260921054823.1822122-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an OOB byte is consumed via recv(MSG_OOB) in unix_stream_recv_urg(),
u->oob_skb is cleared to NULL and UNIXCB(oob_skb).consumed is incremented
to 1, but oob_skb remains on sk->sk_receive_queue (with unix_skb_len(skb)
== 0) to preserve the OOB mark until normal reads advance past it.
Similarly, a partial recv() in unix_stream_read_generic() advances
UNIXCB(skb).consumed without pulling the skb header and leaves the
partially consumed skb at the head of sk->sk_receive_queue.

If the socket is subsequently read via unix_stream_read_skb() (used by
BPF sockmap), unix_stream_read_skb() only checks skb == u->oob_skb
(which is only true for an unconsumed OOB skb) and ignores
UNIXCB(skb).consumed. As a result, a consumed OOB skb (unix_skb_len(skb)
== 0) is handed to recv_actor() and re-delivers the already consumed OOB
byte, and a partially consumed skb re-delivers its already consumed
prefix.

In unix_stream_read_skb(), skip and free zero-length consumed skbs (after
calling unix_orphan_scm() so SCM_RIGHTS fd accounting remains balanced)
and pull UNIXCB(skb).consumed bytes via pskb_pull() (which safely handles
both linear and non-linear paged skbs) before invoking recv_actor().

Tested in QEMU against Linux 7.3.0-rc3 with BPF_MAP_TYPE_SOCKMAP and a
BPF_SK_SKB_STREAM_VERDICT program:
1. Consuming a 1-byte MSG_OOB packet ("Z") before inserting the socket
   into sockmap and sending "HELLO" re-delivers "ZHELLO" on the unfixed
   kernel, whereas with this patch applied recv() receives "HELLO!".
2. Consuming a 3-byte prefix ("123") of "12345678" before inserting the
   socket into sockmap re-delivers "12345678" on the unfixed kernel,
   whereas with this patch applied recv() receives "45678".

Fixes: 77462de14a43 ("af_unix: Add read_sock for stream socket types")
Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Fixes: 638f32604385 ("af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out from the manage_oob() fix into patch 2/2 as requested by
  Kuniyuki Iwashima.
- Call unix_orphan_scm(sk, skb) before consume_skb(skb) when dropping a
  zero-length consumed skb so u->scm_stat.nr_fds is decremented, and use
  pskb_pull() instead of skb_pull() to safely handle non-linear paged
  skbs without hitting BUG() in __skb_pull(), as noted by Sashiko.

 net/unix/af_unix.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1770af3c2684..f5d64e7b5c1c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2885,6 +2885,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return err;
 
 	mutex_lock(&u->iolock);
+again:
 	spin_lock(&queue->lock);
 
 	skb = __skb_dequeue(queue);
@@ -2894,6 +2895,13 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
+	if (!unix_skb_len(skb)) {
+		spin_unlock(&queue->lock);
+		unix_orphan_scm(sk, skb);
+		consume_skb(skb);
+		goto again;
+	}
+
 	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2913,6 +2921,14 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 	mutex_unlock(&u->iolock);
 
+	if (UNIXCB(skb).consumed) {
+		if (!pskb_pull(skb, UNIXCB(skb).consumed)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+		UNIXCB(skb).consumed = 0;
+	}
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.49.0
