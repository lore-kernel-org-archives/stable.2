Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BB38F930
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991169; cv=none; b=JlCAQW7Ni+SQ+PMBIjZST8eZQi8NcASxK70swd/BxrKveBOQB3iYF1hc8PeIYT0AUG2Q0ACYWlrIWhQsmdxmS1oK0z27kcEFJyKH6OWCloXKR1KSrzK7THRX6NmgUHbvKo9ejVSmpXykZndvNydXqn4hPl8QdcOAwajmP+vNJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991169; c=relaxed/simple;
	bh=BNvdFc28OirNme4nOiVVSm2N77c4+Bdl5E11EpJUi04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6mo1UOVatgmZMHa7mfspr7IAqr5z+lH75EwqYJweskkBGeneAp9d3X1oEKiA55OpPfHOySec5Hm4LwQ3hNA/NDbTTkH1wiFvewYIbgSTK8A0DB84l71JDrfxFsWIOhUzOjyNeyBc85tgQVhHTvkNdHOsZRVoSOZSBsZplpIPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Sbt1qy00; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Sbt1qy00"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92edb12cdf2so117829085a.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991167; x=1788595967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgwAcg2QIz2kJViuMyXUOwt7mGNsxAiO6To1hWCAJdQ=;
        b=Sbt1qy00QaANYG63qlkFr0IKMnRoChwc4op7Qp86DxNWwjYc02ris+GjnjWC0Vnlun
         thFlZs7KSaAcH3++E1Sd7fJGsqd0EE5j76V0sL16lrMpjj2VXIzoEtxXf0xXjPBDnQdF
         wbIyA0x+E4B5MDtkF4LD7CUMmTx4cWOKh1u98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991167; x=1788595967;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgwAcg2QIz2kJViuMyXUOwt7mGNsxAiO6To1hWCAJdQ=;
        b=sb2NAq266OtcESZHe5pT18Ggigwuf9T3M8eLzkZ/UzgOsS5daGHFqIg4eCptgTfan+
         /9PYx60BI9vkLyHEy1v8+VsR/q98vOcGlPwqYTAq/lUaZA1iGqiJS0zefXFw9qyMd5EQ
         fr9jsyQk3A4rwxKtcVJNe67UyF9MlwQ1c6eVxOPJ2MgSOlo/JOn0e6ROLEOAUzfm/qIm
         AupXUUH5FCGh0QZ+teM32q64+WoBXv+yvq6XeSLXd0CCKf3OKPhcVyieUEi3O/xIc0cH
         DlPf6IY2zYEPMuDaDqqxjyrUG+DKLRAF2ZHj8Dis6wIBk+2geDSpJXmRgjTsd2AGzxZs
         mKAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrat3J1mpQnpLfr2NHZZhSVBqgqsxKqlNgbR75/AcFBewjNFTZkV53AnO+j7zmW64K5Zhju7yo=@vger.kernel.org
X-Gm-Message-State: AFuF++mkWx0S3YPMGpwB//azqlRLc3ykokCvpK7SRhqU6kDW8WXxHwSZ
	DBYmKoKohjCdA0lgF3LWOBMudr/wt8hvj/HYHJqwer18zUdQWkVYL20N3QPEs6Gucw==
X-Gm-Gg: AR+sD12Op3jryJH0vP3/PJgxFKYglj/oKN6ZD3UBsN6DTZmzt6v5KAOARheM2RSlMj2
	JmMUpuuCZkox5jyRFADZ3R11AnuXdHmwAaTpSaNsFRw/2156rz9rJ7Th1t2Sv/im73XuOub/V6A
	uuj4+pmlo/Y9aojw5XCP2pbmtt/AZXpb6YDm/PAbsBuh5/yViGYqi0JnFa3Hf4lwuYa03gz/yF0
	f/9x+biV4YnOM57Nf7EkGewTPLVN0EpSS0lla7I0R7bEHUYk+cFO+O0rOkqMvHzajNdVd3s62+k
	3lrDv3x0LoWNIhfLzfEeti3sTa+fZvZGyOnyvHsE5viRE5mgtlsRrYZaho1OtRMyR5qeKD+rgEW
	TRUHQzm2UAc6s5lARFFgn1TEZCWy6qwZrU9hEDk6DH0nyIc5eqRPB3B0edkp/V2l+gLGOoA5Saz
	NDpElFvUaBsygWb3GUle9i5y7BP/KTBPCDi9uRG/nI423uhTkUC3xIIQH6+i1P8hsUKFayCV6tO
	IUIoBJLdTBq60xKJoBQvSs6lv8qSr9l5F5egpq/EHcQ+05LNtUiVpiTvl1uSCsIBaFmpnWrfA/K
	pSIANUFEoJBKV0N6veGD4QSxaAE=
X-Received: by 2002:a05:620a:371b:b0:939:820:2e71 with SMTP id af79cd13be357-93913904558mr1311203185a.33.1787991166842;
        Sat, 29 Aug 2026 01:12:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:46 -0700 (PDT)
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
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 3/8] net/sched: sfq: clamp quantum in change path
Date: Sat, 29 Aug 2026 04:12:24 -0400
Message-Id: <20260829081229.81708-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
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
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
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

