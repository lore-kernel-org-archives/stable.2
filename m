Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7F40861B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925518; cv=none; b=VLRvKfehEq+o5FTFFPKCB3NvKaesGDFpZ+XE21ZXUETvulxByH2l6Ib0anJBW1OeQJuaLmxnIeSE8uU44M6KiWnYGdcM7iw8tn3YzXLPOVpon8mTDUdaBDfSTdjjpDb7+jgviC2RwECqNgv07E/vRydOI52w8qmZzS9eFE3Amzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925518; c=relaxed/simple;
	bh=Ar2VSFfOX9Y3NHy+gCdt76XnYbYIFnThMiDcS2J/SHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fehi0yU+oAEL/5XEG/+uRnyeG/fS9ylrz5foFIZAkUay6sqMPNb8oJanKBsgMkXz1eJ3mljdVFRofqULYxs82rM/D65xOC3Ava6sEt77lEwbYhGzKd+HnHAGrCDrqLsRLbWfU/gNT48bycL6dafd9BvfDS8mgSy7CUFtfnHuvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=PYhp1sGQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="PYhp1sGQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e53581361so48246985a.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785925516; x=1786530316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBFdOOeUVBY1Qp0eWq07UF7DoGLXPhkRtG5vT8+QMKs=;
        b=PYhp1sGQtJ3DEZAoUlztW08B9vnfubJCd4+6Uw5GxN94Zb2T/0rsk+HrCnReeRS302
         Jp13zLSDGFi+R3Ua69l2YBHPbg3ZEKsVAng9BmiRHhu2aGh05ExLiHNQSd8Pbpe5W6ry
         bPGSoTTi2ceGQDr3l1tbeA0xQNrKDmdMSdyQs6hLHI9b5ePICr7HHshkeicBiZvLhL/f
         uUpjv6UH3ge0AIwZgJ1tQitF0C7Z6gbAO0t7s7EpCNGFQSpRH9zuuKtkkEFJq5Gida6w
         MeOw/shCCIKK8zK62+N/+mDR/8bD9yMfpr/GqvwKDVMNvIhBu4Vrd8ycLMq71zdlJhT4
         lS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925516; x=1786530316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBFdOOeUVBY1Qp0eWq07UF7DoGLXPhkRtG5vT8+QMKs=;
        b=bFRl+JJuswoCeXrc0EUbisVtY6/YWFihDa6ZuUJoCo6dSIcJmjXRz3PODn7P1oonab
         68Jk7A1Hy0UJog/+7MTsiRMlVMqeoBDG3cITKZcJlq6un3gNQR1fx0Pong7gZUKcL062
         /xuym8GjV10nNz59mGKZ3iMJO3vnltK9ZJGsc3XM4cJqcabbZP/c6fPGN8dv99Pk0f2P
         CFvJer8LKBxVwvFyXryOntkLrDRkMeyemZhtjPzdvk6yyCM5E62ONwtA6/LgylQ3Tqu0
         Fcb1yuCHsG59xidfXTDgDK6WODaKSi2Zi0TinVM22u6aNvgBoxALvgIqxXaEuy8Bwc2U
         IPQA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0IsrK7OsUHItbpxCrfJHT2pxm0OlnbZ/jC9qS2SO2ZM8vHSYHzNmEhrFlX9HjOnIRh9/kJQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37gC4aAlSKwIdEO8iqAle+6FjzdPM+eG3DNVvneEbWz0pihn6
	qFkES2GzyBTGWhHHBoiqPk0mvKekfst+sdI+Pw2tfXXCVGJj+Xjhd8/3zGAedbGCXIE=
X-Gm-Gg: AR+sD10GMupjq8roUFvbu0VkjRKJE24rNH4gckYq5+oZwRjfAngOeitjzYfXFozLmCl
	fQLPU1JVdYM+RvFWHVMqxHcFdU3Blf+jHGElRq6TBJHrC6GfDZyE+vzmJ77RadVvl447HqkPX/a
	zzBpB/gfuhA1LBMukI1AiwVrxOot/SJu36HwYvTiW1lyFegy0aiVmrUZWZOSvHTf+BvNV3qhv8/
	IHs6bv0wgdfJelKYhar1qSf8e5c62QwU3k9F4qspfnNuNyMM3qtUgWqGaMS0VxhBL6k/NFFv2gj
	lTwWBoi6MVqkf9WhAKMuEDJPzHDWmFH60GKqKxukDNKp8TMsWxncyqdLlTcCP9Ug6ONapW6/wVZ
	q51SXuy4epnjjDzlpKcp1HoZmywuOHbEhye/15GzvSmWI4RsVoVVOjh7t5xsdFr//N6VwMNKOUX
	1EYDesiRs9ScOjF4iL9bIn2o5Ik3nMRzcxKZ2gcc96KfaYRanPXO0N2aQJ7CpfnNPlug==
X-Received: by 2002:a05:620a:a003:b0:932:fd59:3e57 with SMTP id af79cd13be357-93649148855mr447772285a.41.1785925516159;
        Wed, 05 Aug 2026 03:25:16 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9364a597e2asm119983285a.43.2026.08.05.03.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:25:15 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net] net/sched: sch_taprio: do not requeue a deactivated qdisc
Date: Wed,  5 Aug 2026 10:25:14 +0000
Message-ID: <20260805102514.740834-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

Root qdisc replacement and deletion call dev_deactivate() without
resetting the old qdisc. This marks the qdisc deactivated and waits for
existing runs to finish, but leaves TAPRIO's private hrtimer active.
advance_sched() can therefore requeue the old root after the final busy
check, allowing a new run to overlap reset and destruction.

Do not schedule TAPRIO after its root has been deactivated. Keep the
test in the existing RCU read-side critical section so that it pairs
with the synchronize_net() in dev_deactivate_many(): a callback which
observes an active qdisc must finish before the final busy check, while
a later callback observes the deactivated state and skips the requeue.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

The supplied v7.2-rc3 trace contains a KASAN use-after-free. The
reproducer did not trigger a sanitizer report in the current v7.2-rc5
campaign and can be shared if needed.

 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 299234a5f..2cf76df43 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -990,7 +990,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	hrtimer_set_expires(&q->advance_timer, end_time);
 
 	rcu_read_lock();
-	__netif_schedule(sch);
+	if (!test_bit(__QDISC_STATE_DEACTIVATED, &sch->state))
+		__netif_schedule(sch);
 	rcu_read_unlock();
 
 	return HRTIMER_RESTART;
-- 
2.53.0
