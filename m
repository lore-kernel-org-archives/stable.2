Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4C3B19B9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726025; cv=none; b=H4w8YAGBA61HsGZHEb9qK1k4P/PSTqhluyBRK4yH4QGQ8C5YOADrvZ5CXXb0iT62WJb6xBaTNU0EMA0jkRSzl2pr8xlFh54sqSWPlx+JpDDPbnrVCPDTzwpXlbP4NQ9FbATZxHju4e28ENce3EOHYRmxMwMIuxQz8t+JYEekiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726025; c=relaxed/simple;
	bh=0NRnwOTkYqoD8DBF+bYtIQoBIoqPd4HJRoOYSMROJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxyKOoUl/N9vhNVXU9sGF2jyvo4jm4cxs9HFekJFT2g0bM/dVSI082968E99Gsv7LHxzkKUxNzYfJ4iC9B7WlhmLO7PKfPwhwTRiVLlAo1a8AodWUj7grMQEcraTX9ZC6b8n79vK0Ao3mtMq4XrzskLQU+M4z373G4JENAwTIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/R7v/Ib; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/R7v/Ib"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4629051c946so1659721f8f.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726023; x=1783330823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=Q/R7v/IbW/MXL9vYsMmuXIdmmf4kmy4eLhHST0v/lqLqqeDzxfLzOSXM/PYWjC92ZD
         hPK4i0YCrcd164/Lp3bQalGKGiviGwXW/QGTiLDynuuSGTyw7c4AIukOOA9l3ytZYwCX
         Jpj0w5rFayKJzK0w64+9H32DR6/BQa4FZG+3mgeptocGzHVOKx/fYlGxwdaObfvI4xtt
         sWRY9jaXk94hTVp2kevnCqeWrFgNMyYgAgcR1lRCpyo/EWct5RspFKzbPUiA354THwqS
         eF1NikejQ8Nqk0Gu99K8zadvttX/tmV80lS6ks3Uv1xil9QLovl30+rQ1AzUaNyq/0Vn
         dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726023; x=1783330823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=T77AHdgT22QbMaKv9sEr8xhMvv/rjjm2smL0KPftHhjwyKu+h0bvfX0mvmSjt4hmS3
         5a2As6tapMj0ediwXoRCwkWuiaYAJXPokhrU/3s5JlOVvQ017R+/k4xD7wI3BraadJlO
         ShfSFnsQlBmTb8ffjsk2Exh1iMN9eRsfEA5MNobQfxTTZv1A/cB9AkTSfuQeJAwlRVlM
         a2R1mwOZ66e4ZJJjQjGvJfGQK9F1QA7ahuyOYuzz72Z3M4o6nYOcH3UhQwpZ1m28SW4O
         hGP22t4WtQeLC9A3tEA7+nQS3sQr49VRGwtvDx8nDhpPozRoCvh1w7Pfa4vR6ss+ICBK
         hFKQ==
X-Gm-Message-State: AOJu0YzRuuLMo3t6w870HwNXprAv3GplR3DKggqouTgSeIInaNpbuxQI
	RD2C86IG3CwY8KWoN8NSiQF1bJIg3Zf2Gdr6PUsp77rvYa9aZ9DE3ahMFvBbwrgaovE=
X-Gm-Gg: AfdE7clyh49GDCgZrB2+gbC+m38//xVykfSMYb0loVpZ9YjHFaRxV3caZnfdHYJkX62
	tWq1X14kAAL9Hcn6G8Mr+4Ap2Qs7+748AoLWpXQ7FzDLhvn2ERNdw+FZJVHJLrW1EfV4zY2Xctz
	rzQANWmASZ1uTzAr22IsjS6MYPEqsQLi7su171LX0v8UGONWVnMbKrK/XjHvEM7WEUGfUqIUk/9
	0YxQVnjYr6x1WUCj7Rs0+7t2yCUTXm+R0scXiukOV90K3ZFI3xEDXdIFRdX3FcaHH3566PSkdx+
	64wwvKj1/ckoquxb6j+M4uCwpCwXHlq39/qI/Wql6KuDBqzRe9vhOTOXA4ibuCQMsYzD4B1xLtI
	WjD91i0VlZJdVJAMqWKIFpootV10GWZ44I0EoUssRy97cRdyxNgS1vfihxx9yLS71bcUXY/iYeV
	4W3Z5LpTfhNE23qtN7h/Nvb2e2EDvl9R7iWLFglTtHwO7HI3y3ZDkmt+UxTTENIKKL/PV9qSc+
X-Received: by 2002:a5d:5f90:0:b0:474:c3a5:4132 with SMTP id ffacd0b85a97d-474c3a541a4mr732878f8f.9.1782726022624;
        Mon, 29 Jun 2026 02:40:22 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:22 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.6.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:50 +0300
Message-ID: <20260629093954.195016-1-sysroot314@gmail.com>
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

