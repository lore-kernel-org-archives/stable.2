Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6E422533
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234200; cv=none; b=C1FiPPrdHUmGw72+w/ag3nuj0uVs7M+zjSY2MM57QhAEvPVJM0zB1jwpsRsMqBq3QTNpCNbC55V5sdhM3EJ7A30f/XpRNFSU5BB7IExshbUFf40vg0GwF4MopX3PRabgEAWwfYRVNkfutmjnaHIMHm3Al+FXo/BuIQb1R3o/9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234200; c=relaxed/simple;
	bh=hYnJ9I+SNx7F4uX7FBbOoRj/uPSXg/C3ApDaKmBP2ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw3qFhx6XmTMaISRCmB2+GMSAHrao2oBooqZO0mdodh0mmY56QvN4gGPpl1lNiKFALsEQJwMYJAbPDGpSjwIsTuHZPABQV1gJKNdxbCMcd/Ok7orEkjpRICiSQgr/UjcBMPmxmWD5yT0O9lV6Xy9xfXSCSkMewT0yny/K4yZxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjJElf+8; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjJElf+8"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso920771a91.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234192; x=1790838992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsM2VZ0IjpuwkgawgmQ1mCqOQgkHltfRpIT8ot/Ka44=;
        b=OjJElf+8SyKAZx81/sX9xCITxHIaz11/iYWorlcKfjbrYCBXXuUfNkauFixvD5goZr
         V9CZqiZixhVYTV5WxxT7WpKrpC721pdP730GgFSTsxMbF+qnDztggpAS+XQ5Qj8F/IDn
         wDpt9DWbed/AN/14wrWdhnU2ZeqNtTOYgXID4PMrghUjVmMPT8eiLT4PpuH7FmEVre2X
         5K/6gwv33djUr7KayYa0HCcB9sFmjMVmHaPC1yoOhCQjnyMsQaJlLoOC9NuLS9DMAvje
         MgUVCBWWJaLA11FG3qh4t+HEqPjpJrTN4Czg8Z57qGt44tI58HY+lgDEueN/65PbiWhP
         sOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234192; x=1790838992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IsM2VZ0IjpuwkgawgmQ1mCqOQgkHltfRpIT8ot/Ka44=;
        b=JdBdF1k36hneQ0i0q5axPJjhYnRuU/5yerkdh3pFfUaAx3Kh6KgXYctD6Qpc+eno+V
         1eG4C1ZdUMc5M7WiUk8xOaiJeURHhEGjbPQJgsfxHhpzHwsJlZ1Rx/cLV9RoHdfwPzRS
         sonvuEF2dVnGDq7LKSs3hgZZroMYaqP1LMGXeDjj5OOh56ofGPzC+8C73z7N1Fe/Fjvg
         BUHBnqktihpufhL1fvl9BVIaJcsYOjtMN5N8z8UBgWBIne1PFRvgiFSEa7iRouN5Spcz
         PdjG+lkrgWSxCvkagtweNIf75jS/iwlgbvKeWzUKX9X/jfC1ZD3tqIbleuLt4aZRlyQO
         XQCw==
X-Forwarded-Encrypted: i=1; AKwUvBxtvPawuKkjlptdZjeQmhNf+DJbIYrFx82AZtWGz2Dqo5pa34fjRE2PAgIooBosofGV/nBLKXs=@vger.kernel.org
X-Gm-Message-State: AFuF++ninB1z0NiiMzSaQnAy3WXYHjXVb1CAZ+2Phih+9kVdFHx0IyP5
	aboPoIoPlVHU1DFTfltQo/E145AAaQTieat5aiTwm9u+yXB1dQq7UWwfuF75cPRS
X-Gm-Gg: AYBFou3fkGg9TdZeyVWcQVe8pD4kwr6C/VLNqTKMloRaLCiqV/81T2qspt7IjG8ehUo
	jtSbtKpaDGfVpa8tt8AK+1jqFCz56YGtSR9i8xJ1INgWz6aciozJEoy7de2Jdt+lECbyUOdN/lI
	eKVs0g6Lp+KT1CDYMJJBwnYzkVPqpa3alYWT3V0U8X6Krtf3jEeAJ+B6NO3WRd51J+dz3u2qqFY
	wEjsi63HOLUYiK8jBRwdpCaAdOmb0S2aYGrJIJm6Vj9rR7BrI1jshYLwh0i84YM7AgTnH2kbArQ
	+XvXmzgSSL/hkeS67lrw5EDew4JGCQKPdnm7i7HAI+z060zZXTW+nJ1Q5lgEIMwHTeSxIi13Tz7
	RJQ1NLThKI/jkZ//jY9fcWRBfNhuI3b6MV8Z0xTgYkM6p7KOFAZOq1/z9Wf8n3vLMODl9942XjI
	BOrKIWXNvKBy93zxflSqbWEC/5Suu7IPH/ePeVDc3PsJUhKbUP6v2paoK3R3WixFfGU5L+QtW/C
	hQHphKukTX/K64f4cgHn1I8relD2QLQCDC9ZonQaCqZ4MO+0HOiYVHWF9piEEP/6he2vT/mUkYa
	3DiZtA5L/A==
X-Received: by 2002:a17:90b:4c0b:b0:39e:6a81:5a96 with SMTP id 98e67ed59e1d1-3a098e37bbamr1320905a91.42.1790234191488;
        Thu, 24 Sep 2026 00:16:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa00sm4003402a91.5.2026.09.24.00.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:16:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2 1/2] af_unix: decrement u->inq_len when skipping unread OOB skb in manage_oob()
Date: Thu, 24 Sep 2026 07:16:28 +0000
Message-ID: <20260924071629.2683160-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924071629.2683160-1-benquike@gmail.com>
References: <20260924071629.2683160-1-benquike@gmail.com>
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
2.55.0.1082.g2b9226bbc0-goog
