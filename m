Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964859;
	b=kCW1AvA/Z004qaxpbN1YTnWeerVerH8yjjLki9Bv4waTjaMy71SG1SSSNdmnQlcgwNar
	 bMBszE7BsEjfeUAiFT1SWDnFyriXRBIwix7hKMYie2ggfn2+7JsBrtnxC2Ff9YBxogq96
	 uoiHjUwnzJL1zjEdJkmNF2lkpj62eHLEJ2gfWLNADDx83ZCRYEZj25Wn8cj6sYIPS3x5L
	 S61fjh9c+DbL97ESKskoC5dsya6k2s3Idc2458I2TRQMCZnV76VbqjE31RHtTxw+H+nbU
	 Prfkt742C9ifl7YSO+NATFi+wd1niAUO9hPfV9axWl29kkUA0+ZKTJEOcqYq6bEHPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964859;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=QHNwJbwh7mlvDgPVV4CphyWTwCB0r+1pdPywgXP8Ttw=;
	b=fhY87utgSOk0okcOpbmg5PI64nWnR5UClAXhVARw43eLmitbhyRatw2f8CNZAmkOQ2CP
	 /B9AhbsqU5MkevVszAUszq69GUeCIEvat9hqcM1wMBybDffsMIvD6YvNutXX0hbKmxqRk
	 93PSf+tsrsYkHN+xH/I+yfuOmesAt3jloQOamzr5dnQpROyJJWrs2ez95ClhRHU8BxHMe
	 UNsORR+vBABVRCM2uMzpIhdL1nmrCNqlL7MD/KkslRoVYsTbjGf83i/CkC5P2TQb1Yypy
	 irtiJdxnjPbhr72O9peXqU3eBbqFklKiBNPac6TvfQt9X8MdLC5qM8SxrKraw14LRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=liiSK3rg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aonZ0WQx;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA96606A327;
	Sun, 25 Oct 2026 21:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA96606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=liiSK3rg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aonZ0WQx
Date: Sun, 25 Oct 2026 21:47:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792964837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHNwJbwh7mlvDgPVV4CphyWTwCB0r+1pdPywgXP8Ttw=;
	b=liiSK3rgvLGVynrz0QOtROsNuSWWqRJyUE55STey0xIeXBshqCt+A03k7HZymFjD9fw5Mw
	V+rNuewwmo9weqvEV8AHD+D/7uGvbZ9HSdMhttiYQ0fDvUZDv8FhQDnaxZQN/qYlVTBnv1
	+j8rUyET3q0E8AKwdIw4ER3bMMOcm4Cqi3O6tVqandanpJjXXwhgaSXJ0x4o9DqBebGsgt
	U02Ir+jWhDhXWxIqP2t1ewIXOtggDIfQAWFUz8DOTIfJmrbXSJOJTIyBQArb7oF0Yesu+v
	WeAknfuDTGpRLsGAIm2lXYK46gwogXQOvJS/ME7UiXJjn6LqmK5Xrrsn+L3L7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792964837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHNwJbwh7mlvDgPVV4CphyWTwCB0r+1pdPywgXP8Ttw=;
	b=aonZ0WQx497aQNkviNaNpB7jKGgrlVOJouWLcrBnsRO7b9Nuvw4ykaM+UoLhp9eYefqj2T
	nfiA2yXJr7mZqrBA==
From: "tip-bot2 for Hungyu Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time/namespace: Fix overflow when converting
 absolute deadlines
Cc: Hungyu Lin <dennylin0707@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020233433.20997-1-dennylin0707@gmail.com>
References: <20261020233433.20997-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179296483546.4109677.6972339291932027363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     d69cfd33b5a8d176124c564513b9ceb933595d93
Gitweb:        https://git.kernel.org/tip/d69cfd33b5a8d176124c564513b9ceb9335=
95d93
Author:        Hungyu Lin <dennylin0707@gmail.com>
AuthorDate:    Tue, 20 Oct 2026 23:34:33=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 25 Oct 2026 22:43:19 +01:00

time/namespace: Fix overflow when converting absolute deadlines

do_timens_ktime_to_host() subtracts the namespace offset from an absolute
deadline and clamps the result to [0, KTIME_MAX]. A negative offset can
make a large deadline overflow to a negative value. Since ktime_t is
signed and KTIME_MAX is its maximum value, the subsequent comparison
against KTIME_MAX can never detect this overflow.

For example, with a -1 second boottime offset, an absolute CLOCK_BOOTTIME
timerfd deadline of KTIME_MAX can expire immediately. An absolute
clock_nanosleep() using the same clock and deadline can also return
immediately instead of waiting.

The earlier tim < offset check already handles the lower bound. A
negative subtraction result in the remaining branch therefore indicates
overflow. Detect that result and clamp it to KTIME_MAX.

Fixes: 89dd8eecfe961 ("time: Add do_timens_ktime_to_host() helper")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020233433.20997-1-dennylin0707@gmail.com
---
 kernel/time/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 3aff27b..635f7e5 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -51,7 +51,7 @@ ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t =
tim,
 		tim =3D 0;
 	} else {
 		tim =3D ktime_sub(tim, offset);
-		if (unlikely(tim > KTIME_MAX))
+		if (unlikely(tim < 0))
 			tim =3D KTIME_MAX;
 	}
=20
