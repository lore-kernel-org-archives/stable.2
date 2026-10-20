Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536517;
	b=tYaT5YOYbeVK0FgOIesda1NO6JOrM1XLP6/0mCQoKpsFLaNQk2BEyAuh2HenHojDQtCx
	 HkzPL5CSJvW4OEXLUAKAzaEM+d/c0fKi87Rn4IO6KnKz8bPgYu0fXOjggvl1EkViA1D6m
	 b/zha6IVvXK1qcCCGa/O97AF82dWW+uWStVImD7cYUjUiyWM7QG7utWgvX/Tx53C6C4h2
	 YgpQutQ4B01UfrQmykKIW/hS+ZAguNFbY4uGWon61WtWIqtCun2Ue8/mhhfli0YRXwVd1
	 jKuU/BOV3A1psyqflN3erQrykBKu0QiMqEVy92nJBGsSduztu7WPb+l/QPyJchh/AXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t+f2t4DgHL7KNG1SeK4YF6A6q++tfump/Px5Q8bp2kQ=;
	b=TqmzXzmaPeO1cbMlQlwWNxCKIHf4bVNS4zsUXslF5R8FhtS2jiEzDOGzkXSArApPpjUz
	 3J6ZAbWG9K0010uH1s54Qs8CJZInyYJObwut8WgeIMoW6mBZojRxIIBg8kMcexSPIOrjx
	 LUpgCfznKBtLbVmhGt1uhtGaE+UU/3JKF5IEDflJknNQ05UNAq2dQppnEtNPoYAdwniwN
	 UzMFgezLb6UIbWyp5Qfq9MiniMLN/F7EWzsNiXBfGgTV51wY53Yhh6NhqS0q/ns5PKWtm
	 e5Y8WM06LCgXweQ3inA00E6yQuX3ONZCcjxEW4pHP22XvmKJbK0dhaxpTu9ua3lCheQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GntD5A5Q;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE8606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 22:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GntD5A5Q
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso125274eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792536516; x=1793141316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+f2t4DgHL7KNG1SeK4YF6A6q++tfump/Px5Q8bp2kQ=;
        b=GntD5A5QnFs7FS7LtNBeXV/1oBU6zVtvVlKJPmmsbSjvxUlVu6WgfC6TtrYWnkZuJ2
         JfnyLyqMSk7T61RqWtxEk8VRAfXSCbJHBa0kou9wYEVufPQF2J0IgcGS5N7pQ4TFYnA8
         qrwhVNI8MMFNgoVzLM1gQmGuq68J11zyVQGLl1942xB+sS5AXjlOn8o4FnSlwTc0WMFO
         4YtkDn5hcNeCKAsdIz4YOFxLGkdh3G3KECnsfxhpx+nQAPx7gHMQ3ob26K8G3FqlZnG2
         +5CjTnLPvZXUNj5leh0FAR66NnNcfUjd6sjmMYI2F3OZdtUo80pawlJUtuSW0uuU8uVA
         GUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792536516; x=1793141316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+f2t4DgHL7KNG1SeK4YF6A6q++tfump/Px5Q8bp2kQ=;
        b=HWbd5//FaJW6YROLvD59A1aV5EBi4hrzqKxHpAJ2B1kV3MyzZxRYMVBpZRwgCmUtib
         IhN5eSBk4U4PA3PHr5pchirj0iY3n6toQw7fiUe2smACQ0MTxl998HwqXaI6ePeBlkhz
         T/0LV+Qoz9fuSMLpvFclsZbfIw8eStxrmOkaZst89p2dHe3KOmEPesk6thB6mJTnQq1t
         W8qR2ImbI1OcBIf5mcuZl+FLJl9cIYfytVHq/RfQH6r1ftkKvDpZhne36wmNTtF7msR5
         TiWvGl/i/cF2yN0kf5bHnLPIFMBhGmfhQUfXuL059AHrVWN6NVRcHN1/qrwjF6WGHW2u
         PbDw==
X-Forwarded-Encrypted: i=1; AKwUvBzuhtxx6wsqhVXK4u693CiSvPHpOExfRqrTKG7W2s6HXHV+9BB2xKpQOKXn5KHJR3KXn/7R5O8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8xFsBOTzCpLoNjRNVsP/wfxKWPHu+uANRmWmEArPpM0evnRU4
	Td6aPbWqDForqReDZF9+ZtxUbrE/su5ZAvxocrtYS/AQHeUO46WUNR9+
X-Gm-Gg: AYBFou0QQp2FaGK0kUAOoRPlit2DrcOmJoICiQf3LYMoeCUJDwxlmazwbbmYwLlmxVC
	azPWf/k9Tjwkr+I/iOddikl7wcVDVLixIGeyKB1BfjMGdZxCO1jqc0GgwQv4dBdmV4Gyw9ITx4b
	8RNJSeZQ+cZeEvbxVCK1+RQcfSlgvdgr1DjStg0Xs73zF1gRlbWK1I8o87COrx3fo2cNO6Bm/Ek
	rAgfQqTbHQkIsOuIQglfbPqsE5PEBVCpn+nkps6W7z7NPxS4gKQkD3JUgvqKyD8CoRJZ4E7A+aw
	W+zk31r98B750pP8QftLPsO3A/lUvV2qMaQPITomnvPvIhZau4B7MKgBYhoPsLKoJBf3WJ8k4om
	ZGSsTEv3N8zA4VkVXYOgWUbgQtuRX9WM8JkShiY0SnP40Dzsy+LUSGJ/nfDUvFf4DiT2+TQAHZJ
	X/AYpxreRcw4dOBLsjmh/pNyzE4m8B+q8qQS0BW5VXI7ZBQ4yi7Z+DPMHFfbHL3WtdlXVkpv7Xf
	kd1MdH9CAclN0xV9/cEv5/exg==
X-Received: by 2002:a05:701b:2086:20b0:13b:2f26:6881 with SMTP id a92af1059eb24-190a051e0femr366719c88.4.1792536515460;
        Tue, 20 Oct 2026 15:48:35 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aff3481sm1517409c88.10.2026.10.20.15.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:48:35 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org
Cc: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] timers/itimer: Keep a nonzero value at CPU timer expiry
Date: Tue, 20 Oct 2026 22:39:57 +0000
Message-ID: <20261020223957.87842-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

get_cpu_itimer() returns a zero remaining time when the sampled CPU time
is exactly equal to the nonzero expiry. This makes an armed ITIMER_VIRTUAL
or ITIMER_PROF timer appear disarmed.

The cputime cleanup replaced cputime_le(), which implements <=, with <.
Restore the inclusive comparison so the equality case returns TICK_NSEC,
like the overdue case and set_process_cpu_timer().

Fixes: 648616343cdb ("[S390] cputime: add sparse checking and cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 kernel/time/itimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 03a32dffc56c..f7de39769095 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -60,7 +60,7 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 		thread_group_sample_cputime(tsk, samples);
 		t = samples[clock_id];
 
-		if (val < t)
+		if (val <= t)
 			/* about to fire */
 			val = TICK_NSEC;
 		else
-- 
2.43.0

