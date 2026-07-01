Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F143B2FCC
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888808; cv=none; b=l2GGvgTmmNlfbKRyJxoEKYra8yM9LvmgOBjGeiy3LAqB9KdXPFQo2ZZkeIs5lJQTtj5NFbKm4naOQsYPBqtm0mWtqNK2D8vOobyU4ZcsRYl2bwHozPFj6XxD4Xt41x40+SqllxRp9sMVEURunnKeK4swOlXQq36YbCExc3R3MiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888808; c=relaxed/simple;
	bh=c3UXkmSf/U+KQu2LbfQINtMaYbmZc76jB9bbaDgnsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBAXLsS2EM0cAIY75/o2AKfCKs2DOWSrkJHAd6mtAfawmzhdMjT8jSvKWWQS3EaypRJkr2/776r72uwuCyGqxO8aOwvkvQyuO62fs3xdDCcWPKg03tgBTXcQPZy6+17eWZhcjjd1PzLFS5+SU/Jpm3XbU1jiBWjCKnee7kbNi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3ZEc1+e; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3ZEc1+e"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4763b0c1dcdso337802f8f.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782888806; x=1783493606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=b3ZEc1+evCK5sOUeERnJZ08unoNTXe2IMNFiBCAcYmYci/z9/aYXmr9+/1n3HTxmmT
         If1loggdJOeJPST1QQYqDOkdPAVj4fC/OkIlQ7dU9X82bD57esw2RjNp/5wb3kFK1KO9
         C/VkrV+Ojyj2czG4VDPG0OI3XMhT6e587alHhk5ce5z4HnU8eQk2HkFx4+DGeSjuITzB
         gGbs1/uIBTlQDJ0PX3bUtd/URqTfPf5BUbJCp4Dwg76VeD1PIpXHrrKsfC0rJKlKDjPZ
         j0gqi8pciBrsc3YUd8pgNk0yQPX4ur98LZ9UDTNqcIsIJdZBS7fihLD3W+c8uv5D3cI2
         DSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888806; x=1783493606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=l/UEy9RKWlOWSax/v0mJQmBO6PImAlkALuOus5qlrcwhfuy8ELo8z4PRVSFxRexKv4
         04+hGbp80KsOMnaHfcKHj+OSHeROhLev0GGhBbGc3ILnNGujKkg8dhA/59bw6ly4kzi4
         BU4pES1ANlShNH8y+kaHQic8FIs0zTqiRhFCG4Dgb25oPcpn5Rbcq0L+Mi4ksOGaxUp1
         19/nVV3i/2dozuhhaKiwEOPleHTB3Jn4fqfvapbLwdsTt4nuq7t9AfP6CSANwTvX9PQc
         NO1PL250Qf/uJkCQIh5DJfM2FOaZjhaw0ebW30KgUw0kN2u3Sjrf2vIp6O1QhSuCjqVQ
         cyfQ==
X-Gm-Message-State: AOJu0YzujvvZWG3nWMPlzfws4yVu2b41uHFRH9QfMrepH6XqZk9b1zcv
	6Rga2Q/77/RI+6q7PuBYHGECO9bqi7w3qTabev9JwRHaeuvogrkfYxwGqHp8ZU40AB8=
X-Gm-Gg: AfdE7cnoz/oJDOWAnMy0w9B1C2MMg0M3HaBJ4tm3E5ou8Pjos9SVFqqqKWG/zC+f++Y
	2l4xweRWjyOEqbv++UeabVQcdiSPTOIN0Lmn0An5y3F37mFSlVnNJHruXmNnxHbIZdzx7Z9mBwA
	gCQkMyK1y71sBVdbRdWiarSEjEM9xtu4/Jo7ff6GAtRo58DuhsIz1MxrX8iMhUxjKLaO3v5Ege4
	NxtsAWfLAap23kgtxMl7NSgKDCFKp9h6DoohbCHZ7LuSKAiB2ddzCTk7QkH4pi+9TwqHzSptBBE
	Pxn83gxTvrjumtsML/k7qcB1ZHrEApvTWpcU3nVhsZuPwAD7Jm4ph8IXeHwhUuSjCB8qDSssvEv
	6fYPPR6G1NHBt+l5rrjAZw91A7lkmzgg94WsMTpo13s5IAuiRTz4kMwa8S1Pw23Ud3NbTGu0AV9
	VhqTTOAYAhjklujadcUchZCbVWMpz8u3LaLLwwSmyZF4P0wTh25IU+tYlGqD02xm+M4QwVl/aW
X-Received: by 2002:a05:6000:1acd:b0:475:2171:ac1 with SMTP id ffacd0b85a97d-47759c24ffdmr532138f8f.32.1782888805717;
        Tue, 30 Jun 2026 23:53:25 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636d2cfsm16079572f8f.17.2026.06.30.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:53:25 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	kuniyu@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	sysroot314@gmail.com
Subject: [PATCH v2 6.6.y/6.12.y/6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed,  1 Jul 2026 09:53:06 +0300
Message-ID: <20260701065306.281809-1-sysroot314@gmail.com>
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
[ Add setting gc_in_progress in __unix_gc(). Keep the existing
  set in unix_gc() for wait_for_unix_gc() over-limit throttling. ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..fa6983dc31 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
-- 
2.47.3

