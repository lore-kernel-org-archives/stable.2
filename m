Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983974;
	b=k0PEIdeKC4guy7T5madP9rLySXPj42bs+8CKkcYf5PutVFaUUnPANeps6aNpXxxLwjl3
	 6Lim59MxffsnZzcgR8s3AT5CaeVK7Hir6xrdM48fAQbifBmvvFqr1d1y+JQSclecNRapd
	 ROAGqJ2tlxi6lhEZnF3wEkkEfzyzyTvEb3wj6chNZ2Bub3q+x09cjtyeG82oR6jXe6iCg
	 VZprnLBQSmp0KRsKV7DwVd5EbSE4nxlrPAgLP0rbXy+N7jzuw9Xd20/bF1EfZ72UU2Y9e
	 QUC6F0saLSosmnLwjCDt+gS2RKjlMyHdxN0IjRZN1mmp7uJGiUoAMcIkjkR6lFfJZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aoczeufkw3DOf+e+V7z0I3M4e1H07M0CJBQzemDHKiA=;
	b=TWtjIv+RBA3ZX7IxXPx4ZtAL34Bgh4sMAYfTN8KF/nWiCLP24f5UXhfJe0wC+daTs8MZ
	 Knp1zxQ5W7fKvTfSjpC3HdvCoV1AvkLAvL5cbR8YiqtvCtxQAuwALtZHG+tfAs51U81Cp
	 H7W+bCGRV0iFcSHs7TkyLwI1kGNQWVcR9rCMCDqoZqBi3lsr7463kNFgasWJezVRtWAtc
	 Cgk9Rtk9SkhvKcH9BxcFgbH34XTxVS3Wma4JTBVYD8wgWLTp/ndZVbSVPAR/IsKJhwLvj
	 4FEg1xIwffkJ3/7lcpuKWXmSQ1kASBOUV7tD8MWdakqL4THfDGP27UF48JJp7KohdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fraUT9mF;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4D606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD4D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fraUT9mF
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b179528d56so291356a91.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794983974; x=1795588774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoczeufkw3DOf+e+V7z0I3M4e1H07M0CJBQzemDHKiA=;
        b=fraUT9mFHK9og4458A+ZbVxONdM9BrGJ9bX9Kp+OXfOb9NeYDjpjCoMbZ3cosjdsMn
         txiPE7W0rSaEf6Rdy/FOVk+s5d/sQgGj6gQk10guHUGKBpu48l79tsHDhP0JZSV3loy1
         o+U+vaM7FiIUxLHy8H203NdhjTNa/PwgWsZmYJsGI6EFuy5C3kevAHOPznWFUWQRiH2U
         51eUSNNAAZGU6Iv/R/NaaPS3WRRIkms3+8XzRq2W3VRPdRnJ1VKrsqVELlStAw4b7Qm4
         WS2QFQgW5GrAXtfKCa3TcnSRclBlAspk+NpBzi+1QhTcpWQ14Kg2VjF8Egcy/6bHgo2+
         HPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983974; x=1795588774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aoczeufkw3DOf+e+V7z0I3M4e1H07M0CJBQzemDHKiA=;
        b=BsC5MoSI0dXr1IgsJkj0S3pamj2kBiRQ74zZnYaOGtScFNIVucOrHn1YKhRyB2MZkT
         a5sLEa9SX4sCip+fjo6MhyBJg3JmA8X2dxYAMWNVVOAykoLgAjGMvpxnUB+dsQT38Ezm
         xSs2OtUrv/KjY9NloJq+Isc7eDuPbOkxWwkIL/1fPTt+cMI8gSey9RcOz91YgrY7rdk/
         AgcZ6pDRvwPHUI9SkGeZwkDV3pIxxkZlE/hfZ7Uy2OkfYgZY09gChlDkzmVmeTkhFbko
         h76SKDvQlrIDBh1Wleet503KDJ/eIWrfgzTu8+sgUs9djmMWDAuExFp1NFbtpActobEO
         8+cA==
X-Forwarded-Encrypted: i=1; AL+hErHPdB++aQmO4X4cJpy+4u29euUVHMYx/vnU2W1kHKBfGVLVwn+wSX5hCu8cUta8la6gtAa48Lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8irP/MLuVwHtcZsuuc9F6+64r615NZt4KkZxW/Y+/SrknSMxPA
	IM6wYMT1IM6F8fWnzVkmzHZM0rMEPMpswMkl6e6Yghwl2CglmNx0QyJa
X-Gm-Gg: AZFdTZevO0wNlEsppx0UUgwI8ZuqfPa9zQ7mOntADElPk6PLqlsEeUp/EJy2/SyUaLD
	+5Iq1YAlZUJS8gcnRGeLBdqaF2qO5qz8jC4Ege4Igz+ucn7raghHY0Szwp3iMquoDiunaMnPywe
	oVoAYk8lb+HPJTkhTHjZLa4PX4ExbBrBJB2k5+IVAsY1ZeXoyPwhjkBNlc398gZNnpW596roV61
	CmCF6rE2Jgm9Du8vOdQ4JaGxs/LA4S2USr8mPZl93cDqAWKN7jYSzRM5Em3vSMaufv+MuQkwX22
	k+KiHRLj3ssj4p+m3jq3esN3oEXFor9eXe2b45COwHSsgJVpNShcMdktblo558qf91Nii7280Fk
	WJMHoBotfWIPlS4SrtKEfnX9uDAoiMFVf3OHBfdde3Q4mi2wrCAw2cMUhDGKbAQf10LSL5wFKCL
	Tu85zeGqYsJsbpNsD0y7D6CQU1jGODKv94cI5xByTqaRDF4isOw7HdJb/HHDdH5tPN9yi+WYHb8
	T+SwjUDtFO3Uouhr6X+D9T/Pp9hYfLtbNV85RXDGr1RJL3uwU8XHSZ4XYT5T6VuFrxCCQPB/CWP
	ZEeWfqohryGniTHggdPIJfnxyv2W4+1/uIpbKD9795GNGRQg8hzmpBiTvZUd8UIvtqauDvODUS0
	iLwQYgIbnYBvF+1tgpS47k07YXXxP59/NQbFh6OrCsAnxoPgnI2Zp
X-Received: by 2002:a17:90a:d445:b0:3a7:ef4:164b with SMTP id 98e67ed59e1d1-3b3d06873d0mr1539328a91.2.1794983973868;
        Tue, 17 Nov 2026 22:39:33 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([104.28.235.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1c03e04sm2562322a91.15.2026.11.17.22.39.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 22:39:33 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	koen.de_schepper@nokia-bell-labs.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net/sched: dualpi2: refresh head timestamps after trimming
Date: Wed, 18 Nov 2026 14:39:21 +0800
Message-ID: <20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118143500.dualpi2.0.543a9a1be910-zhiqizhangg@gmail.com>
References: <20261118143500.dualpi2.0.543a9a1be910-zhiqizhangg@gmail.com>
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

Reducing limit or memory_limit in dualpi2_change() removes packets with
qdisc_dequeue_internal(), bypassing the timestamp refresh performed by
dequeue_packet(). The cached c_head_ts and l_head_ts can therefore refer
to a packet that has already been removed. If a queue is drained, its
timestamp remains nonzero.

get_queue_delays() continues reporting an increasing delay for the empty
queue, and calculate_probability() uses that delay as input to the PI2
controller. Partially trimmed queues also report the delay of the old
head instead of the retained head.

Refresh both cached timestamps from the internal queue heads after the
trim loop, while still holding the qdisc tree lock. head_enqueue_time()
returns zero when the corresponding queue is empty.

I identified this issue and reviewed the fix. I used OpenAI Codex for
root-cause analysis, drafting the fix and this changelog, and assistance
with regression-test development. Codex also performed automated
validation; the archived results are described below.

I reproduced the issue using Codex-assisted automated tests on an
unmodified arm64 net-tree kernel in QEMU, with real AF_PACKET traffic
in an isolated network namespace and HFSC ls/ul shaping to retain
packets. No source changes or fault injection were
used to trigger the bug. The companion kernel selftest covers C/L
dequeue, full and partial trimming, mixed queues and no-trim changes:
the baseline passes three controls and fails eight trimming checks;
the fixed kernel passes all 11. Runtime coverage is this DualPI2 selftest
on arm64. I also used Codex to build arm64 Images and compile the modified
object with W=1; additional build coverage is in the cover letter.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 net/sched/sch_dualpi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c4..79eba7209e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -938,6 +938,8 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 			break;
 		}
 	}
+	WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+	WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
 

base-commit: 2a324a58a084c5cfd7e5a2f55e0786bee170a4a5
-- 
2.54.0 (Apple Git-157)

