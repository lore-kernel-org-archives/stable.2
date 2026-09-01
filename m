Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A144B681
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298793; cv=none; b=ONm7R2udJ0Z8GKnGI7NqzEFIR+UzMbxyj+0X008dkO/02VF0cgHHi1yTuWgkKboEx3oYX7ja6FuBHwFM/9192KRWuNeR7UKEFItSfnyyfwbs+3JzHG94yjiUsWZx6wloCwkX35neA3uKbF0yvEh+bYGpSEhjfvJCIpabnToItIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298793; c=relaxed/simple;
	bh=/0zqk8DY5QgcTol9vG+KXFSFt100FBlNYtvPBCsmlD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcIgqHLIrR4aeht8wuOoOZL3TyNxHDugJ/NCbBJ8PDWjeceHTyJi/NJZgYDzMpNEYiHPgaRW308yPUHCverFrWWFTCDgCBI5vfe9I+2qi4L/9LO7hmk0YPxDuWltswmoHtGUTnG3gWwKjD/CU87wy3DoU8FiqIPZYnLAYycwS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=uF0R4qC9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="uF0R4qC9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cd0e6fd80so3474126d6.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298790; x=1788903590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2Ph+2F4XnBsZC7RVtAjPh751ig1yynrAPtSoAph6mw=;
        b=uF0R4qC9UhxAS8CvMq6fliKsyRQltJVobvXnxPPUVIoxB84UUOHVXGgCF8N8XR+fgu
         Uc0LGcmaacQ6oIP3YCYaW5urVG3kBptHnD2M27ppA447zPrUvMb5pAMr9uaxmO58o7iG
         9angjlVvSNSc7HDN8gyjjSnksId5wvDKo+0FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298790; x=1788903590;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2Ph+2F4XnBsZC7RVtAjPh751ig1yynrAPtSoAph6mw=;
        b=AOZNlIQO07vpTNFu5nT2oJq4M3cWYlY2GGnAeqVqvF2t5gu1cdwjxWsgONbnEL1UCB
         VxH5xN4JnrOKkG+cKg6iTX+Zh6u1lHXMnHOZtPY4IcW/qYYwq2y7lg96OxjvTAA+y81V
         4i6i0OdOlzfvd3Jh+w1vHHMibcdtMM04JKEwYSLi5ok6MMVOnL4r0IpsrOizVaA77euL
         upTfrNiqatC2gnAGEQrlAXxf0KSYmOT6HRWNhmkSxKBxrWEKNuaRbJDbdlK5Tq+wvTuj
         Jud8BDSltLG7p4TLDzdBNegaq5UoF4Yrk6x27SXk3fhg9RRxy/XxrxKmvKhJJBcaizOG
         ve6A==
X-Forwarded-Encrypted: i=1; AKwUvBz+5fN8y/D7h7eUO28YqvhQ7JItoucyRCUqGP5c6TcolPPrN+eUUwAEiPyFWo7R/pRA/aZN5hU=@vger.kernel.org
X-Gm-Message-State: AFuF++nrdq0eNt0jOrcZ5W014jrgBDMKoOcBuJxcqA+/Am89t1fBhMct
	fX+65Zn8GGKQNG2ygbCRu0Bx27teSwVosqNChh1QJQfjX6zOz37e7LZ0m/4zLU3sYA==
X-Gm-Gg: AYBFou2GRFkCJkVmpu0LjYAqAjADmR1/d5KjJ6SzEbpUDJ9OU/lBCQPAU1QZqEtXGvL
	m/k3MMplxxMA8CTQujGl0YUHCVr+6lyZGfbL3YNsN9D7xI3BZKFgSkQLZTM1TjrmIGV44BSq1U1
	w3Cs8UYi7okEAUHwhaTxBDt01bZsQNAh4b3XeQ/FeMq7ZZnhzaq8VNOOGzJ5/OQoWhAQCL6YLbL
	gLjUxc1NUxesYQ9r5ixDqJcDbWH/W45SIMXsd9bnzRHey6wa+ZqD7JbD0zWy5ik1nm3x37ppvVQ
	2fRtc+zppnIaHoLBX/I+so3xQEV+xHyNKe//wkIFud55kXuOkwiMSckw9+yLAQ6p3Xgs3uVF2Ul
	6TUvS/WyNkpFOka3XOhjMtrV1zmNk2BIWRHMytdzHy+mdvNPM0nZ1WGaPQzD/fbt12XLh9p/HkJ
	Dfqvc4RCVkvCe6cIwrW0iShEheBIL7qgC+Y92FIer1bxv/fQNIfMLjsqAToDCEgo5hxEvWVMRlC
	h6gegxvF7vRPH7Qtps1+o+/XCBke9dvZhmjiA==
X-Received: by 2002:a05:6214:ac5:b0:90c:c4fe:8d9c with SMTP id 6a1803df08f44-90ebafc002emr9783416d6.27.1788298790242;
        Tue, 01 Sep 2026 14:39:50 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 3/9] net/sched: sfq: clamp quantum in change path
Date: Tue,  1 Sep 2026 17:39:24 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sfq_change() accepts any non-negative quantum (only rejects
(int)ctl->quantum < 0). With a crafted size table qdisc_pkt_len reaches
~2 GiB, so quantum=1 makes the deficit-refill loop spin ~2^31 times
under the qdisc lock (a soft lockup / denial of service).

Add max(256U, ...) matching fq_codel_change(). Reject quantum > 1<<20
with -EINVAL, matching fq_codel_change() and the init clamp.

Conditions to recreate the bug:
  CONFIG_NET_SCH_SFQ=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root sfq
  tc qdisc change dev dummy0 root sfq quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: e4650d7ae425 ("net_sched: sch_sfq: handle bigger packets")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_sfq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 187d3ed578f2..8bbcfc9e85d9 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -660,6 +660,11 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
+	if (ctl->quantum > 1 << 20) {
+		NL_SET_ERR_MSG_MOD(extack, "quantum too large");
+		return -EINVAL;
+	}
+
 	if (ctl->perturb_period < 0 ||
 	    ctl->perturb_period > INT_MAX / HZ) {
 		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
@@ -688,7 +693,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* update and validate configuration */
 	if (ctl->quantum)
-		quantum = ctl->quantum;
+		quantum = max(256U, ctl->quantum);
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.43.0

