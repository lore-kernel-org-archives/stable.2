Received: from mail-pz2-f21.google.com (mail-pz2-f21.google.com [74.125.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF922EEE67
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969707; cv=none; b=JdliVChw26SIgI66HhSspBnTtiRyX2VqViadRoFQGmDjXUiVlEhezC/yt+MYG3HCUnnULfqiWlvGxdW484QojeEp7mR0UkxS++Zx3Lcfq3E7eMroYe9sxJtg8OWsqEx2/bi5l3tm+2VulAi2HuEY9CHnbmt6KUJESqyivcCuuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969707; c=relaxed/simple;
	bh=4q3x0VjUvsd6BIdKh4dxjcXadLqLQxFM6mQepQJSzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLANjbkCdeAoAig3lQOn1yIC9wg/np2S3rB751iy72jVxsJrQbdU5muE9Koqs26DS1QgABRQ7tLXkCCUe8u52vH8JsGSu3r+4URmuPqFvHtjL7D5ox/WbXqSdMwYtTYo8CxljLZ8YUGs4yvjyPsukDOnT2BrRZzIhxnvm3iXvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0LzBUAG; arc=none smtp.client-ip=74.125.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0LzBUAG"
Received: by mail-pz2-f21.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so2951276a12.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789969705; x=1790574505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNJYOwH68Um+gj+JHkyQ06KZcoI1X6BYrC4IoaU244U=;
        b=M0LzBUAG+E4ngoiMV65MDhbsgox3K5+3ta+tx0gZLyief7igIKdaivLhXEZIGM5THM
         uak4iiZmRUCazbzM5IxILqWedfH3/y1upy4ozmebhGzuCpiMHxtuM/scMRE6MYBdxvIW
         3Y0YkYL630tMhi1Vq8VsoPv4i9lQUzabffeoNI/bFzMz5ytD9FBV3RxxduS21Mnq9Aox
         UQCvJp3qLGc1vLsazcgt01vOZXs4KnQbI7O8HdcpFNwrDP8YwsYOiJQWajl2IgCvjAza
         n1kDLJKvSCZXpiB7I+7VHk4Ql3wG/qxqaSy/ybu5F2c+1+SYDYNkfYRPvdRcGMoJiyUh
         2dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969705; x=1790574505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNJYOwH68Um+gj+JHkyQ06KZcoI1X6BYrC4IoaU244U=;
        b=0A3ReOvwfsInZAVZQ0CJ4Du+py+1SDjNzlZvBaux9b3kpGZmU6BIyPPpmfXranRJ8V
         5gw95a37yf5ISvBht8uh30ck+fMR2l+CjalFJk0+D14Se7Zwmoe8p7oEmhAqfVsIRLuL
         ViKRe9HfySAAv6LekaHHVdNNHiR0NYWB67rh/4n0lmu5oRp6D7p5ZZoHvI+yPPJbAWaH
         gv5HwN0ZtQN5NFUWWCg1o6aiLB6Y7N6vtYwpLdkbXyipn3FYc1oL8Z0asbixDkEJCF8q
         E8Xt1ngIYwoUmJDGa6sC7zVbRpD4LWm0vvWtb9qgTzBw83VnMOh+nfznP898VIO54591
         MNKA==
X-Forwarded-Encrypted: i=1; AKwUvBy2cGhLvD39ui+ps0vHBKEV5BLx5Q+4srEFTTVHkXdOCccEBOavYfxnN0y3cr+E4SGOzQ3vPyg=@vger.kernel.org
X-Gm-Message-State: AFuF++lR1krveG8uMj7ovF0d+15+/mkBwxhvq5e7Fp/350KUlUEng4xp
	V4UwCeE94RBOVnsNt7qdSekRwlvtSpcmGn8jPO21vz0z4yeCNOCJ+z1S
X-Gm-Gg: AYBFou0qXPHauQ6dQUOB6tuhZWjCTaHAVTBMPYhd1lG/ZTid7CPHJ0IpBYhYLV9OBVq
	7cf4kyQRbPtrMSp54GId8yNovnJPwKRimzQM8cIis17UfqzQZEZwbul6N5j6raweeQSHC0E/d6x
	Yb72wLINjFwmwZt4FYF5xLuC6aMqYHedntfb6vvKaj9t+P77qRwNznHlms7sKx8M/AWyD69It46
	y3cppusGw/OPFAwZ+eyqaHC0Tdb7f9emlAYOqi2ZO2Yrhsm7e8FxcPQUwjRto3xgELfWCD3cALi
	WLSkxRHi7N+8qFB/d/RKi1785+6qPhYkppnfgdGeAkC1nQ7V/g1TpF7Q29ThDzJB1KMYrexNm7f
	YGngq2pECqxiQZafFrnQfO2J7dVGN7e8n0aOaVGUYj5vYzSSn9saW+hRTMZtDU9UsktApmgPqTs
	4uUNFvnTdejqIEytd1WhLOJyYS0Em/q13bvZNqgz2yVAAWF5ANw/hvYl07SBBIZLO3glRlFDXZZ
	ZdUDBG0vlT3xNVeWvhvyYHCyFCF2SQTd5fJ/0hCFUqeBoiaBGV4UcKxBxnTsIS0L2YDXEM7eo7d
	37K66oSoAw==
X-Received: by 2002:a17:90b:4c50:b0:39d:fd60:caba with SMTP id 98e67ed59e1d1-39e54d21a31mr14881297a91.14.1789969705254;
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm12640514a91.15.2026.09.20.22.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:48:24 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] af_unix: decrement u->inq_len when skipping unread OOB skb in manage_oob()
Date: Mon, 21 Sep 2026 05:48:22 +0000
Message-ID: <20260921054823.1822122-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
References: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a normal in-band read on an AF_UNIX stream socket (without MSG_PEEK
and without SO_OOBINLINE) encounters an unread u->oob_skb in manage_oob(),
manage_oob() clears u->oob_skb, unlinks the 1-byte skb from
sk->sk_receive_queue, and drops it with SKB_DROP_REASON_UNIX_SKIP_OOB
without decrementing u->inq_len. Because queue_oob() incremented
u->inq_len by 1 when queuing the OOB skb, u->inq_len remains permanently
inflated by 1 byte for each skipped unread OOB skb, causing SIOCINQ /
FIONREAD to report a stale positive byte count on an empty socket.

Decrement u->inq_len by 1 when unlinking the unread OOB skb in
manage_oob().

Tested in QEMU against Linux 7.3.0-rc3 by sending three 1-byte MSG_OOB
packets interleaved with normal stream data on an AF_UNIX SOCK_STREAM
socketpair and draining all in-band data via recv(): on the unfixed
kernel, ioctl(SIOCINQ) reports 3 on the empty socket; with this patch
applied, ioctl(SIOCINQ) reports 0.

Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_inq_len().")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the manage_oob() and unix_stream_read_skb() fixes into a 2-patch
  series as requested by Kuniyuki Iwashima.
- Update Fixes: tag to f4e1fb04c123 ("af_unix: Use cached value for
  SOCK_STREAM in unix_inq_len().") and clarify the commit message as
  noted by Sashiko.

 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 42cffeafc8c1..1770af3c2684 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2849,6 +2849,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
 		WRITE_ONCE(u->oob_skb, NULL);
 
 		if (!sock_flag(sk, SOCK_URGINLINE)) {
+			WRITE_ONCE(u->inq_len, u->inq_len - 1);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
-- 
2.49.0
