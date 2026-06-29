Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314B3C2BB9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726034; cv=none; b=HbGm/M1uIoZnAQm9Ux5rD3jfCySmSkBrAsPlIIgkehGXG8HK+zhnMaMaqBRO2LnExbIvKLWufI6DLDuZ43m+s19vRVXE/5U3kDyzgG/nPBkz8wLsyXiWP7HQ83sWfnyi67LqWm8fU9b4D3EU0EitXdh+f1ubSNBC4p5u/RCtHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726034; c=relaxed/simple;
	bh=0NRnwOTkYqoD8DBF+bYtIQoBIoqPd4HJRoOYSMROJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuGUKfjPHTe7InotmFQj/992aDkw0EwjBHzSwuY19hPX/4AX/3jy1EbFZ4dmfGLK0W5jO3rR452IqxyOkkI2W2m+U8+QxTImCNkoK9x5sUYNCpgAr1BMTgcWjQmM48AOqy8GqfRMjNq1vfBhbm3bNjkQ03JY81j6leD//JvohpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlnN8uFs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlnN8uFs"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-463f1165e16so3174447f8f.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726031; x=1783330831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=PlnN8uFseUawCPD5S9sjBwd9ju8mL05Y3G0ixJp96f423Yli/5R9c9f80KtvJR3qpm
         E8QUPbMVb2V5MpNUttAjPmbGAIGTY9IaP68wJm/twiAn+auPXCJkfSk89RaxHlv4VOM7
         eYvDyWUGEDyAr9KeLoXLXrHD0xHsnKQn7qvCacCXttV1jcPuryjQx7LIVl99xdqksXY4
         f9Kwd7nNfOm82ABda1UXfFSfMn4v4ouJFI4zh7JamHDwKRKyji7oDucmFgkCtPxUJmtp
         UEPCiLXPvLNfgDVIiaYC+muXT61NBzD/P/4SgagtQEVNs5dZcChNnsOE6Gsp7REb5dQo
         nbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726031; x=1783330831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=oU5fL4BrCI5wbh8gomICGwsyDImTRnJk3WpbhFlNQa86Vbjeho7ymcfR5Wp70+qOEW
         yhT4HyzUxhz0e3xtdDGNg/Rbcln6GItN6f+qlcXls9Prv5eDeC6ZmaApZHthm1Uhr+Ai
         NmhWtDl6cx4MhAR/+s1qHXjBf6ldd+apv7A9CZ5k5xCQzr4VPYH1XC94zWIcxfeaZpTD
         gSVj2yiioXz9AhiUuxaBETbC39eRzSUxn3hlCTgaRqFSjb5zoLiRdbouVh9kexRN4uYZ
         St4M+h1nNq6gxQ/6Y898JCF65QiEnaxv6cSAk4cVnXRUFFuFyi8HHFdt1L2ylpKtiFRA
         owpA==
X-Gm-Message-State: AOJu0YxCt4ZLKBLkaTtdW2BwMZ++jbdpVBWFVo5n3q4t8Vv4rNFiLel1
	g6LXs9o23Xmej/W9SfoBXuWdrS+fpCyZ+5HssKKREgRzJmsru5TpkRxPS98kM0nlHts=
X-Gm-Gg: AfdE7ckCT6713ickBzRgPW2PbRgAqs1XSoWSCQtzmIM/Fqewn7lHIHZJGZUFGl2ZF3w
	0LYF170ktdoe/SU23/qb1oU+sQ+S9ayyO6vluqte44syoqLKPVBARx9jdP30mevtKXQC1KkAJCB
	8hzsSOi8mFTjRoJ9fCJxNkBBibDa7/lfs8LWdaMj42kxbeLSkA5UK0LvVym5Kv/8vbkV83W7izI
	9yX74oa73zesN0fvRrEvVgQO1upWc4qqod4lXmQnlp+XhPBtqm5pWqzDgxhXYEJK5UdFHJjtD0+
	7kPYsnEDxCRHckTLSenkmhNnSnPxj3U0hZQQOdPDaQ2Q3CH/7ARnENRLexRdVW2Ww4wY5xqnSxy
	PrC512ssSj9D9pbnXHzE+wiVFUWtpLymXujBtrddiGDLzCpPTM9tl6pVoDE9H/Ni/z3Sl0arZt/
	Ch5XagjTVO42arXbFYvMlFCig/Wsbg+Dtt94ux37gUyIlDv5KSOBO3rH6CXtsjvSTjh9EW0H20
X-Received: by 2002:adf:e19d:0:b0:46f:e15b:415 with SMTP id ffacd0b85a97d-46fe15b0618mr14873951f8f.12.1782726030631;
        Mon, 29 Jun 2026 02:40:30 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:30 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.12.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:51 +0300
Message-ID: <20260629093954.195016-2-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..82dfb1ad34 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
@@ -613,7 +615,6 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 void unix_gc(void)
 {
-	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_unbound_wq, &unix_gc_work);
 }
 
-- 
2.47.3

