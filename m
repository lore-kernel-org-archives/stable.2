Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A543B6347
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431826; cv=none; b=UmAN+fTBUwodFS3EJUVp5Ml6yKOleEqL4Yl0XTgFADSUakJlUcGHtFAmcHgev2zQ+DNFAvW49Tr4qfnrbFPKnCaK8dgG3HNK/QOMTPqAnijzTkXiFyb6f6ligUDbu9VoiYqlTeSrVj+1qxhSXJrsd34irrNJr96BLYdoVuoRn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431826; c=relaxed/simple;
	bh=Zy3DQ2bg09l45QUdJegt9V4PSCAJQxSliXQ/WCsW8y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTWHKK+Mh3RRvjQ5DpjSWKhgqMq6SQnWP2mnJlcr6D4BKwtkPAN3xLd26POttmg4ruZ5T957YEOayThHIwo6e5ABzfLVzIllWSQTZUKdcwJACpXPNxdVLhlZbukNMp9r6/NFuL34WEaflXmJsc2OQ7NGC40V+XIovvUeRnLaG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUwxbU44; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUwxbU44"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8899a204034so1378006b3a.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431825; x=1792036625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVcS6UviFiqfW7v+A1P6aceXNanxZ3sihwct+0rMisI=;
        b=ZUwxbU44CPGwHL8KYYZwa/oNIcH69QzyiYVNlDe1r3bS5NssH3KBVnpZJ/r2axplma
         D+jt4G3k277kfOpxx99rlH7fz+ADnEUSSG7PE7LxLEfT0FxZ0HGhKorZzfNvLJw+poXJ
         //gM4Y1gaiLpr6lfer3352m1qhIe7KuYh7ppMyaN7N4o+7iuvCSli5WAv1J1P6vqmJTH
         KvvBSrTAqbB9Ku/SbW6ew1nR47bZmGXe9ZPkEJuBeX0Y3Vo3m+Tu3eXAxksKhVH4ahMX
         STgNQzxIOx2L6OgCohsrh62Ohr86sn7MQjbfv/XfgH/lj52C8xTajj5pS9QOMDTaL0yi
         +enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431825; x=1792036625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVcS6UviFiqfW7v+A1P6aceXNanxZ3sihwct+0rMisI=;
        b=L15lE6ZqV2d6x53jLTUXuH0KWIQ2RF7jsU+0XlqjvT8fx3+RgAiK/NxqdfGL+Sv6vA
         Y1qn42GC+NK0TW2ixJayVrY9R7E87lkkd6l27FUpLkfxORymyn6dzKJKSHSrvOWb+Z/a
         i0gO2wJIpZs/OpzfEPasag4E3ZEZoLftEdkKMDBW2fQAuIWPetD0b7y8tPa0GpbgU0aL
         FxfEuRTjWgyHa04+vBYYo7+ozd5M/F9VNIiGAFGEafdt6vqUz7IyxulhZOV/Zm9PLpFv
         QlkGB/DhIQtuQzsd1WdmebdwH2GKwL/eoI1FYQlvaGYekO2YHcfOKpvNZ33a2F30pg6P
         7Wlw==
X-Forwarded-Encrypted: i=1; AKwUvBx2DF6Z7jU4OaT7mxe+w9eGhVHyc4xr3cPZHVns048Z6UiFYg+dBtE+qGg2c1pFGLXq1H2aTRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLV0n2R3+0NRIAeA2C44Qz89cZpo55YqMCYjV1n1eo44Mc7g3m
	MgNwGbODh1aAixtiDUJOep2GT18ICEhAlpNbQ7fmXRqXZVetA8m/y02cP03C1g==
X-Gm-Gg: AYBFou3gAMzM7eecz2uOiLOKP+sWnkwpr7ED9cii9PcAYBSaugMno6+whcidQ470dFB
	B8uYtjTfEJCB+kXDKRbGQm/TplxPwFEdfUcTr56d9AUDv8S5ubDR+wm0yaHreDcmP+XtnLZXHnq
	0JOqDq+/FS95J0bBrnh5dpsvE6jSWqdhv4Gd+iNPx9LXT20Ew8sCtkf3HqWEUKK0nmvyYqtDiN5
	kqb3mB2TLrfD/3vpK3nCXDGHwsgsc0aKrpx6b09GvQN0k3rgb20dQ0BDA1Vr5A7QJ2swuBRDOFA
	uWaSF6/tm+Pnc3xmHlg3aHMgik2R+fDhayeorkpbKKc7TFjmSKaYvYIUHCFcQkQanRL5hpW4cai
	8LOnSvimApawgzT2xyctoADiXirOCOo9avSZvWj/Lxw4Nxjd2ueQvm9H/QHMrZyQahkHz0pZk3t
	BZXC1qSNXCNSeZQ3bLV+YRxikm1DDXHmV9FXMd9e+ZYFsGuypN0MCGBQzu25c6I3sj1GwaR0BDQ
	XP7ZA==
X-Received: by 2002:a05:6a00:a1f:b0:882:359f:ef42 with SMTP id d2e1a72fcca58-891b57c4d09mr2887938b3a.49.1791431824604;
        Wed, 07 Oct 2026 20:57:04 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bac8e058sm1021934b3a.13.2026.10.07.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:57:03 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] net/sched: sch_netem: prevent packet length underflow with negative overhead
Date: Thu,  8 Oct 2026 10:56:56 +0700
Message-ID: <20261008035656.330667-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_time_ns() calculates transmission time for netem rate shaping.
It adds q->packet_overhead (signed 32-bit int) to len (unsigned
64-bit int).

When userspace configures a negative packet overhead (via
TCA_NETEM_RATE packet_overhead attribute) and an enqueued packet's
length is smaller than the absolute overhead, (s64)len +
q->packet_overhead is negative. Because len is u64, the addition wraps
into an astronomical value (~2^64 - 1). When multiplied by NSEC_PER_SEC
and divided by q->rate, the calculated delay spans hours or days,
causing enqueued packets to be frozen in the qdisc indefinitely and
stalling transmission.

A similar underflow can occur in cell length calculation when
(q->cell_size + q->cell_overhead) is non-positive.

Clamp the effective packet length to 0 if the overhead adjustment
would underflow, and return 0 delay if effective cell length is
non-positive, matching the behavior in sch_cake and sch_tbf.

Fixes: 7bc0f28c7a0c ("netem: rate extension")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/sched/sch_netem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8a1b89a289d..a3dcd33bec4 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -366,14 +366,20 @@ static s64 tabledist(s64 mu, s32 sigma,
 
 static u64 packet_time_ns(u64 len, const struct netem_sched_data *q)
 {
+	if ((s64)len + q->packet_overhead <= 0)
+		return 0;
+
 	len += q->packet_overhead;
 
 	if (q->cell_size) {
 		u32 cells = reciprocal_divide(len, q->cell_size_reciprocal);
+		s32 cell_len = (s32)q->cell_size + q->cell_overhead;
 
 		if (len > cells * q->cell_size)	/* extra cell needed for remainder */
 			cells++;
-		len = cells * (q->cell_size + q->cell_overhead);
+		if (cell_len <= 0)
+			return 0;
+		len = (u64)cells * cell_len;
 	}
 
 	return div64_u64(len * NSEC_PER_SEC, q->rate);
-- 
2.43.0

