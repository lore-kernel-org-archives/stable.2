Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773874;
	b=lfHG5W+GF6yil44qvd3cIDq8Jf70J0v5gfMJJXTTozQ/bXO/q+Xgvl/9dAnopYMU699K
	 e6fBp+UoogOiqUNyOGd255zoPlM6o9XQqkEWnABuACNgI5T5etjI6AUUqvAtGgUKVQQSU
	 yX8dffgloImUmrHw2ERSlbkQNzdb/vXJOMEnsNYzr6Rt5A6Vnme4KWzuNt5GJO2nEGnA3
	 h3TCJ9R9WA2XxRdXDJBkq95v6oQ8wqfSfiwUkfySakyKu48BPr6RfJ4B2qZq6GooHiqUO
	 L72lr8wkI85RhANAx3KF295gjpFzEtm9Pp8eudkDug0rEVp0jbLIuGSSJV9kqxD7cVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773874;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=crSCT2EstgNsJNFIMJ/PB7/a6XJ6ZtzNwTlJSmVt7QI=;
	b=cvM6i4TruzjzFSpVZoy+f98LK+X+FhkgVcCAxTc81YxY58Oyrj0r4dL+eE5aa+8Ur8Zu
	 QXYTAFI3uT3Ujo1814lueERfQdUQ+ZzocfDJqxFKcv+gp2IWTSSFnjC6JiDDbTwPRZJLW
	 dnQI8BFXvlqTksox01HkCrKfIkDRyU52Huaa5HFpz4ETOaQtMRr2c+pQ1bXazl93yVFvp
	 NExjGsDgBxOcKJhRWXtWUBTI3Tf8Uz6MxldzoPnREfRZQwJSzOR2EywrH58+OAdiXKinI
	 9HOqyzD8OPLPyjqXl8iScmaZ1U1pxRnwdMv+0H0camGqXTOE+QjX2b+PWB8wl5wNyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=da+ZMpUe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="g4/jr6E9";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EC606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 895EC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=da+ZMpUe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g4/jr6E9
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GpR8560400
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=crSCT2EstgNsJNFIMJ/PB7
	/a6XJ6ZtzNwTlJSmVt7QI=; b=da+ZMpUe5WH81l/+r03aDnZ0TKA58g6AynAuFd
	3PbwG8JlvuPo0Usu3/EutVE+ZuEoD1WYA1MNnVovKM/M6eTqO/wb71QJcc4YpqWh
	SfTFPJ4rtyW+eUYdwF2noJpiU/kgp/ymQa0DM45Qsgw6uk7MWxVaOsgyWu5jVA3X
	kxcdRrXzIVhuAyD6uBf0vWfgTUcjkdEMMF/BX+D+zIu4Q0d8KubJYoKFw0dbFZBt
	H2v0yDCYhP5Sn1jJYLxNrZDhhq64t7GmYPyo8A+t/eKp/RU/SPmPuppbKF5gWGgB
	+wc74DZ/0m902XfeXhJRXM9I/L0eSznehOibS3O/h8Dlf/0w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqkdty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:04:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f04580de55so43332255ad.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795773872; x=1796378672; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=crSCT2EstgNsJNFIMJ/PB7/a6XJ6ZtzNwTlJSmVt7QI=;
        b=g4/jr6E9M+GFrTk+vA5n11H/h2ASkpwkZ+r8VasglB11bd0FqQFrw7eMwkcHDXsVhR
         JuQ4e707EZ1B49RwB9/en+M+Ohk8Y1XtFUgFeDcwp2FyvkhasE/C4vnnfO9LM88ExRpH
         MclefMpBDX7P6RelT+RAz3dA5I5hLC4G94OaGoi6g4BAoML04tLCdJhASUoiMd+Krb3Z
         EvyT2HJGAtT64/7ASm3VQuD8hbX2U6eSilCZcCYZUM2k7T12w4PqsNZ+b5nTmL3QNCUn
         sgV8MrttBnC1YAT1yVEaVbTNDv/BNB1IPgk3P0J9dULlbMJFpyb5tWxoNkco2mtImVW7
         NeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795773872; x=1796378672;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=crSCT2EstgNsJNFIMJ/PB7/a6XJ6ZtzNwTlJSmVt7QI=;
        b=pZLX9oAtQ9o0pUObkqS1Q8gkxPny0GhJd1b8NDwc1IA4bejma7tEVZqwMmBLW4X9PD
         zd4IHQnPZRPdH3NjvzUnnMOGtyKrIq39xw2w7fa/n3XY1da5uhYxVQVLp7RfCyM8zU9m
         XlIsXgNYQYEHgpwL/dyNycyL7J3TdSlVwd0QXkVJn4cJA69ZT235HjZsGMI/AumXhpHp
         a/wiO2ZtX4hIqcRnLNKnwRAjFRIWpTrRNoFCrcZgvM6Poq/jqLtlSELzT6ztxy9yJobN
         gJuJS4s/YteNsXJHxDVEtDnSxTEjDdZSmxT9mD0pXHnoOsbC1V92aVPqpzUlX8VUSoeR
         4XBA==
X-Forwarded-Encrypted: i=1; AL+hErEnjR22FkWQNdCrMELDNjBhwlB6D7O74/NF7Th84x0xPZhWupr+TXqC40+3fVLkOzsD4NBy6zk=@vger.kernel.org
X-Gm-Message-State: APuU4Z97Zg1MGiDLsqrwJNpyj2KZbU4TOP5V7Px5FX9IAvpqdzP5IW3K
	hShomPsjGebKr2MhNsKPB4xgvuZNhfPqNsbvxLuahk+ELgC0eO+DozXZQNGk1KcbQFkJZRbPQ2e
	iMCPzIBCc47rKR/6esig9gTmnN3+eajzr21BmmkE0Tg9jX4NoVvmZ7gsjIyPC+sru6KQ=
X-Gm-Gg: AZFdTZeuwn1Ea2hnp6EebxiGtikz6Lyl/aT08d2BXMghMyLkcGGFuOjL+pqbMx1QiZF
	Gp4MbZ6QSuo0VCg+jD4bR11BDEx1+1Nl9ogPJCy4EJ3oTtdWAe420dIuYWnofXre19bo97Famem
	BSTPttcy0uxXroht5DD5uTm2gOQVibz9I6GQe4PVPmQ5CeMR9CkNxCezcsrlSXER3QeV2OKafw8
	HeMq6YQwZLUsIT44D8Dn9iZ6jjStapfsrXPx5i6tTTMXzUYysQJzmeip/aTTkOcQYiW1dwrhQC9
	07D3QE2SwZdww74f0WJ8Xv1+eGKMQyOR9x7Xk6N/f7KwqCaBzOg357ySWVZ/KWWeWkeiD3JbfxN
	9wFA91L5veG7NSpdJEQCWDQgpQOWR5DpBo+F8R3/L4xLWkYfuyzNFlWwsl9tw0/XKPmheyu9bUe
	TZw1qbkA==
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id d9443c01a7336-2f03f1babeamr234436305ad.43.1795773871673;
        Fri, 27 Nov 2026 02:04:31 -0800 (PST)
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id d9443c01a7336-2f03f1babeamr234435965ad.43.1795773871108;
        Fri, 27 Nov 2026 02:04:31 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84425sm119350235ad.6.2026.11.27.02.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:04:30 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:34:09 +0530
Subject: [PATCH] misc: fastrpc: make put_work scheduling lock-free
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-fix-put-work-irq-deadlock-v1-1-3aa66fe4f2c9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJhVCWsC/x2MSQqAMAwAvyI5G7BFKvoV8VDaqEGxmrqB+HeLx
 4GZeSCSMEVosgeETo4clgQqz8CNdhkI2ScGXWijlK6w5xvXY8cryIQsG3qyfg5uwrosbEmVVcY
 QpH4VSvL/brv3/QDk8rlUawAAAA==
X-Change-ID: 20261127-fix-put-work-irq-deadlock-940a4e7a166e
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795773867; l=3329;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=OqkY2gJhqmf+SDUPxG1CDZcFBvDTgZchNgMudL7t/Qk=;
 b=5MKLE+sXxseY5XU3ASLaXjVtD7+w45YSQEWh56Pd300R2ItYC2ml9So0wQT8810n+FESrwQVw
 ODuJ8IBgwp2CLoO247S50g/la23I2d2cgUUSbleyt7gsQbCONtDomkm
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: agHW8TTEDnUPR3DaGoD3g-x8bxyhJZz0
X-Proofpoint-ORIG-GUID: agHW8TTEDnUPR3DaGoD3g-x8bxyhJZz0
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b0955b0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ME4ylVHw-GArSQJMD6QA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX01V7y3/b1pS9
 MkBcCuZ8jKBacakvTL8d6xDI+GAaaXXph1G7Uz5I65eBrQ9D4oj8QlIvmJiBG1Pl8zNFrd5BOjZ
 JBkfDiUspwcqcI261p6CYHBkfBRDXGE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX0Ru3u4Ic0Moz
 2DIdls1pe95CvgNzei+hjUg2E/HHsXp2FFVnkFm8isPiiXKTTaW6G7xJTkdYAJ3zqrGjeYdYI3n
 utS5+NqsvubnGMiiqPtzRGkkKGAzseHVVZYoxK7fT7+SC16tGz9l4+J84hp/OSN0UVJ37Da9Evz
 /+OANcEmmq25P8Vt+PNUq3CniKKpRYyE7XkHA+YM0N/Zp//D0zrSuLYb2tUz4iKWxuVMePxcU17
 pK9C1ESwi474qkLO89qP78NDqyDfbI8l0+tc+gPOOUkZIbbO+hpz4O3h5/K9ieWLESV7YUj02bL
 83+qdW2v3zwhl7eOErQkX6RxmckaMZZeNpRd4takRLvc3HlDo++Qeilvoy77L0Q6tjfCInqPG3j
 7YI5qBWGUnz94HwNQZwQooemUkoeSbFoH/cz2INkwEumC8SPKbDAOOSTMWEVXcMTRDngvdQqodB
 eD4o6XNFgDD2OHo6TFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039

fastrpc_context_schedule_put_work() guards the once-only schedule_work()
with fl->lock. That helper is called from fastrpc_rpmsg_callback(), which
runs in hard-IRQ context on the glink rx interrupt, while every other
user of fl->lock takes it with a plain spin_lock() in process context
with interrupts enabled.

If the glink interrupt fires on a CPU that is already holding fl->lock,
for example fastrpc_context_put_wq() -> fastrpc_context_free() or
fastrpc_free_map() running in a kworker on that CPU, the handler spins
on the lock the interrupted code holds. The holder can never run again,
so the CPU hangs with interrupts masked, an RCU stall is reported for
it, and the system is eventually reset by the watchdog. It is easy to
hit because schedule_work() queues onto the local CPU's worker pool, so
the worker that takes fl->lock tends to run on the very CPU that
receives the glink interrupt.

The same helper is also called by fastrpc_notify_users() while it holds
user->lock, and ctx->fl == user, so a context left on fl->pending or
fl->interrupted when the channel is removed deadlocks on the same lock
there too.

The flag is only used to make sure put_work is queued once, so no lock
is needed. Turn it into an atomic_t and claim it with atomic_xchg().
Whichever caller sees the old value 0 queues the work; any later or
racing caller sees 1 and does nothing. This makes the helper safe from
hard-IRQ context and with fl->lock already held.

Fixes: 3f645f6884b5 ("misc: fastrpc: fix context leak and hang on signal-interrupted invoke")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5375847d8c9a..3dd9892b11cc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -279,8 +279,8 @@ struct fastrpc_invoke_ctx {
 	bool is_work_done;
 	/* process updates poll memory instead of glink response */
 	bool is_polled;
-	/* set once put_work has been scheduled for this ctx, guarded by fl->lock */
-	bool put_work_scheduled;
+	/* set once put_work is queued; atomic as it's set from IRQ context */
+	atomic_t put_work_scheduled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -661,17 +661,13 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
-/* Schedules put_work at most once per ctx; racing callers may both try. */
+/*
+ * Schedules put_work at most once per ctx. Must stay lock-free: it runs from
+ * the glink rx hard-IRQ and from fastrpc_notify_users() with fl->lock held.
+ */
 static void fastrpc_context_schedule_put_work(struct fastrpc_invoke_ctx *ctx)
 {
-	bool do_schedule;
-
-	spin_lock(&ctx->fl->lock);
-	do_schedule = !ctx->put_work_scheduled;
-	ctx->put_work_scheduled = true;
-	spin_unlock(&ctx->fl->lock);
-
-	if (do_schedule)
+	if (!atomic_xchg(&ctx->put_work_scheduled, 1))
 		schedule_work(&ctx->put_work);
 }
 

---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-fix-put-work-irq-deadlock-940a4e7a166e

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

