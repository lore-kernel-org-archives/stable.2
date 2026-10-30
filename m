Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338965;
	b=0rRKjsWNjNdooCDKYaqo4EDeTD2mQOi7a34JHHUZjQJPIbY1CHoDktSRkMVTXnNzloed
	 pmnKLXzTOXHQXE3PwwFU2Wa9g9izYXDGnl1dmkjfjyXgE2Xb6Ma1ZP/t1QiY+AXlpSIXX
	 DKaHhA3I0AM0qZ8W6qI2z2hYWm4jCRSGPOb5O3cV9LsUjMmt0HPLwBo0XQmDsIKq8CHYy
	 6TgkVFTdrPq3jJhHvbW6j0OyddY9KpkWdRt95Zdtj2jcLbBJtcYMSRRodwnGtDLflApkQ
	 UlsjOreTks3tjH7DzfpLfkDhhj5gnzn7G7gLO/PRJV6hCAS/stUA9aA3RMsx9FAlRHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6s0Wt/J+NclDEuptzzJyz2irJjkpiavB8tG2sGhZUUw=;
	b=OpDkPPz3Q2yclvd6M78gt4RPvLzd4YQuYaYMhCVUfigdBzitImtqZ0IaaTSH/US5u+ns
	 K6tVPwpuZDFQjK0uo2GXXja/KwOjftxooGgW4HMpYNYRcxYp7o/755nAytEhFQbf45FkL
	 FffcIoc2/J59U7cOban4cORlR/9/5CVfjXtB112PyooXFj6jJOTwBmLPgLY75yvKJpWf/
	 KQ72zOTQa6nfX7XflD5AEQMOZAs/9SOLL6fEl2vtp6N9HB/Sirj/ATA1g7jhk3yM75yoy
	 q4uzady7lIhRd8Za910oHACGVl6Uqm6hIlcI6czYmfeemzzpXzZYl2lzUwCvvu4OK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GsGjbOH8;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9305606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9305606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GsGjbOH8
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so99056eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338964; x=1793943764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6s0Wt/J+NclDEuptzzJyz2irJjkpiavB8tG2sGhZUUw=;
        b=GsGjbOH8JXeRf1/E3GD1GqQUdXWuwtKVrctPgMqx01lk11IExxy6Xy+OVyeocBCSiz
         ySnnIPaJx1pudzG1D9+f9KINd8lVZVdlslnb7RnLlFcVPJm4z19QUpEKUvedRZhIHfD6
         +DEjjfLVhC1uPnnYl67GjS1EU8dnyvP24RKIIu2TsgAtvolSk7XTmDi1bd6wNmCVtj1R
         NyzP0S9fglvK5M8k6J/NDaG/JX4uB0N8bfI0Wi6/zG/rTSfu3oIQH+GxabMtHct1Nl4C
         yMyTB+mAlletob4//HSspgI5JGkJQTc5Ad82UWEd8cRnvfct06hRxSw6rEe2MmJTquX8
         VvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338964; x=1793943764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6s0Wt/J+NclDEuptzzJyz2irJjkpiavB8tG2sGhZUUw=;
        b=dCME7JS/M6u123yRx+NqbLoP643tzJZLbjYvemKhdcHwWfO+Rseg00BgcNSOTye0M3
         Gs96J51ZkaX14zm4yMCPH69GRWEIKm0aEFxs4/OElMlaVFHYzKTt/ygCQzL7GuCaGCaG
         ID7BHn55mezrpmIg15VILJSU0sjRdo+nvxoFc+WB1lL5Aym/IAEELFgOxDriDa/Wzx4K
         zmrJuc6iy7eDmGKXY+0dwQV8VAACHsa2enxpCrz03VpOBva505l9r2X93XBuXbyG6C4A
         9ulFmfeSQB7Iq94Wfm6B+pZHKCr1u0xnebtx1cLJrmMVi2e9OBy6h4cnqoRiRMq7Y5rn
         MO6A==
X-Forwarded-Encrypted: i=1; AKwUvBxGpY+a2BX/P6CH5TAWGwh8PEHSg8U7z5bWjRn5xX81lHCffAhfqS5NB12a9Ia+9VClctdM9yA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6R4KJjFJ42uiSKkeyXObefBDbPPMoWL3DYzF4Q9h7VTPzO1GZ
	uQkxbqbzdUfYPgMuWvQUrck04/brJ+fF292ZuuXybukp1qe89MowLjto
X-Gm-Gg: AYBFou1o9R43QmWlHn4rtkhlUFHxX78oM5yBqt2oOJb+FuKeLiscGhPdjUlZlJNsdGP
	3FReN+ecEoUFEKskxiSEnK/8CvIoi2dQQ1tlWihr4rOxM2S3Nfe7u0OTsjKvhu8XqIkBUsbGRd9
	kqWaNaHvoJ3kGbhENGSDi16vSlpRTkOnABXbY/IWeXgwhUmIuGjmynFcRjsZ58RmA7J8FI0J5ew
	HmoR1gcFOiNpDTQwNdECzw9FCR7pLIYGIOiFfmpQ8zCa599xm4kPgYnEl5dsSw+j7UuzeLd5QJH
	sux+Vo3NQ9OMnfGrcvKb/beqhndNrsln52rCn1IDrWjCTjvsiGw9UqzBEpYCVtGt+tObOyq0m/y
	wf4vESsDL+604aAAVeVwQZH808d9X3bMA8R0OCvRkG6gG4XW1crfZOsTIw+adZDuw8b4mNFJmWG
	qhoKAUCWAcv9TVLr9hysazJHL/ATAerBtvL+s14hnLmy/g26F583WHKkoNEjt6JP65vhI4RDdv3
	vX4KZ6J6uAbaib9QxDAAiSt9wIyCsQhOkq+5QtMi4IeSDOgN+KcPfTEz2qiatMKlj1WOIFprX/C
	lWmM3AX/klF5qUkDllkcpG77AbDbzuV3lbv9xWnSMM8HYry/Yiwaa3k6EPzMbzJKILktpkOEF+1
	FwpE=
X-Received: by 2002:a05:693c:20c9:20b0:351:245b:d1e7 with SMTP id 5a478bee46e88-36a42061e10mr1964517eec.0.1793338963697;
        Thu, 29 Oct 2026 22:42:43 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm4380426eec.26.2026.10.29.22.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:42:43 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: tglx@kernel.org,
	jstultz@google.com
Cc: sboyd@kernel.org,
	mlichvar@redhat.com,
	akpm@linux-foundation.org,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2 1/2] timekeeping: Read getboottime64() offsets under the sequence counter
Date: Fri, 30 Oct 2026 05:42:26 +0000
Message-ID: <20261030054227.35453-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030054227.35453-1-dennylin0707@gmail.com>
References: <20261030054227.35453-1-dennylin0707@gmail.com>
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

getboottime64() computes the wall-clock boot timestamp from offs_real
minus offs_boot without checking tk_core.seq. A concurrent timekeeping
update can leave the reader with an inconsistent pair of offsets or,
on 32-bit systems, a torn 64-bit offset, producing an incorrect boot
timestamp.

Read both offsets under tk_core.seq and retry if an update overlaps
the sample. Convert the resulting local value to a timespec64 afterward.

Fixes: 7c3f1a573237 ("Introduce boot based time")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
New prerequisite in v2, addressing Andrew Morton's review.

 kernel/time/timekeeping.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcf47f1ffdcf..7d7a7372f3c8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2700,7 +2700,13 @@ void update_wall_time(void)
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
+	unsigned int seq;
+	ktime_t t;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		t = ktime_sub(tk->offs_real, tk->offs_boot);
+	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	*ts = ktime_to_timespec64(t);
 }
-- 
2.43.0

