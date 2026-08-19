Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44D3B9935
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150026; cv=none; b=FaWpRcKP9c6SpqW7kswe0du6wArwMavBRr5am/DdqCeH6Ox/TFKJlNR9aF3TyOJ5xvUbycQ7rcO23opdI+uJmKd2HI6uPcpA/Ql1+sJDbWtrnrhqXrgAnI6oVXRhn6xTeIGuAxKZHt64thUHrsokZ87Jz5Vvq5S/BAaLwPEGZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150026; c=relaxed/simple;
	bh=vOX6ffyG/ieT0WE8b5wbPDo0xpG31cy3dM5nOQq2zn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fovLZeo9W97l7Y8deA/VPr7K9et1VOm2+nTs8x9fnjs/jddLWS3VkS1owrssVYnPZgzHnX0rXCbZTKEQtAyWm5L6bcIrYKA3LR6nSxWrnjnmMc6C5xiMmrVKkwEaBotefxWjkycGimERAL6jcLD/ad7waKOo/k2Xcn7YbzlQrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DQKDRwzF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DQKDRwzF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2a818fc4so7028381cf.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787150024; x=1787754824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejuOPt68qhDY4noBlNOcm7rYGgb1gdrrIu92QM8wUXg=;
        b=DQKDRwzFvE514r1SSQSu57hX4Gvr+7mmyVFOZ9iVCcKAPbYaNd9TkkfYldQD8fTVGf
         mJhZ+TFhTv101fwOKct1vblnP97euy+fr+OQAnl8vfrQ1h/qfY2KLrlNaNZIvzJx4eqb
         dt5U3+HcZ7MMcNFoBKYg+Pxn9DfuBmhcNa8kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150024; x=1787754824;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejuOPt68qhDY4noBlNOcm7rYGgb1gdrrIu92QM8wUXg=;
        b=q3sDUZ9P/1sd12eOKuW4KQ8hANZ8wADDyFJ+QXfTk6NFLz1CkSs1Fuk6896n+Y7Kwa
         ffzhrcJHk0HImYOAdrNhnEEYpfFakgTsMMY3bfCpGdvNeaV1UsE+Lgx4QoqgFHghaJKh
         iDLkQgsj5LUF0moCAy3xOnQBvt2kuWqjX+fHxmmFIp+/k+PHGG2vjs5ociZxi3oxQV4P
         ol5ng8CZn/8mSLZPKj2+Orks4CQVqNYpnAUM9VE++cNd3M/4Xr2Rp/RJ/MI0lq0zBS9e
         hhrAArna5ZqrU9k2li6DW3yaU/GFhYJho8kzJv2toDs40ESE32zzStrL8lE36MBjiYqC
         8EDg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5qXdalwZoReuv2YYdHWklpsM1ZIIuXzLkgaFNVjGLu3dsdJNN4xSqDYUMM23Z1jVJpD0Xc74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzbk5/39A/epYIrcgUHaS25kw9e4AlphmZdl4hEauCRkrwe6tb
	R3Ys6bsk/QgQKxRCkiMcqR6VtuvgX2Ia/IW5DOR/xdqYHc1en1K907goR6R2bC5BrA==
X-Gm-Gg: AR+sD126HNxswV9/xr6JjDeRg98GjsGEkNQfLLdG/RDUe6nNfAv2UagFwQK0oF2c86c
	NjBy9Fzt0JjBLmmqVVcmvnctMCf9Pvvp27qe6iVRElx4zFPenDPcTtNI72zSBmNm/uaW379Me5V
	neoPojaOy8VgiWf4Gp9ununRY0D7YUfzESxV8aKtpb3IoIWkXuPEfDRUWl+L1P+mi+2Tu3UFkQX
	iU6NtOaQhgztlulwfx2v41MShojtDykSBrz1zT1NT1V5Nf4wtrtZM2a3NmN2Hp0JPOhoRn57/I1
	mTN02sNMTTSj9K6J3+XiDjMekWbS2zbXwMVShOKgWeQk2fTkY8P1afbGyizgpD4SgpYOSNwUXuh
	ujLPSIupSr5nwFbmEJ/YOz1/qGZMkcpptFAiokdiM/UGUW6z7k92zxXln30h8uVPeZH6ETk0kol
	3w0JK4XeUb7PfkjRCvHhBy23HG+mRYJR9IakfnJLwRvI1WomKNkiv+
X-Received: by 2002:ac8:7dd2:0:b0:52d:824c:4856 with SMTP id d75a77b69052e-52dd5c5358amr45530651cf.31.1787150023966;
        Wed, 19 Aug 2026 07:33:43 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd872f61esm11871901cf.23.2026.08.19.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:33:43 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
Date: Wed, 19 Aug 2026 10:32:13 -0400
Message-Id: <20260819143213.57401-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qdisc_get_stab() accepts a user-supplied size table, and
__qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
overhead, the size-table data (u16), and size_log (up to
STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
DRR and ETS replenish one quantum per loop iteration; with a tiny
quantum (1) they spin billions of times under the qdisc lock,
producing a soft lockup / RCU stall.

Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
amplification cannot drive deficit schedulers into an unbounded loop.
A legitimate size table (e.g. qfq's overhead 999999999, which is
handled by dropping) is still accepted.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_NET_SCH_DRR=y (or CONFIG_NET_SCH_ETS=y).
- Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
  amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=15, data=[32768]).
- Add a class with a tiny quantum of 1 and send one small packet; the
  deficit loop spins billions of times under the qdisc lock and trips
  the softlockup detector (panic with kernel.softlockup_panic=1).
- Reachable as root or from an unprivileged user in a fresh user+net
  namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2

1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caught by
   running the whole tdc.sh instead of affected qdiscs reported reported by
   poc. That test legitimately uses stab overhead 999999999 qfq and expects
   the qdisc to be accepted (exit 0) with packets dropped.

2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
   __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions

3. Given existence of tdc 5993 we dont need the tdc test created earlier
   since the essence of that test is covered in tdc 5993.

[1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.16655-1-jhs@mojatatu.com
---
 net/sched/sch_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..ad4f117ff55a 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
 
 	pkt_len <<= stab->szopts.size_log;
 out:
-	if (unlikely(pkt_len < 1))
-		pkt_len = 1;
+	/* A size table can inflate qdisc_pkt_len() beyond any real packet
+	 * (via overhead, the data table, or size_log); cap it so deficit
+	 * schedulers such as DRR/ETS terminate their refill loops.
+	 */
+	pkt_len = clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
 	qdisc_skb_cb(skb)->pkt_len = pkt_len;
 }
 
-- 
2.43.0

