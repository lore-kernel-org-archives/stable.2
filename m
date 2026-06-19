Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C63314DE
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863093; cv=none; b=O1jF9zEuNLdgf0t31XoV/5nW0/ahyeo4orb0aVINZMMJflyBaOkWb5jpkL5Pv57oKmf/VUT0UKPtp4VWipkdLwF5NoOGOPxC//FmFMugk+f+UuZyI/x7MIfAdo+jU05pBaWJAYhS/FsTx/bYt4zQKRXNubFfQloe5FETKgP36vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863093; c=relaxed/simple;
	bh=uTQGVxJp6sa5nGg1fan4r/Fv6LYC2ueA0DG3l4AmA8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3WrH2C+LTlDt4OqlOoq8xmn/jwqND3t72BU1kaId+21dRsT7bbRGbgDNkOzKRxhkVWVtwLXeUwzWSpb/qPdmE2R4qzJ2TFWRJS5diKKkJK4dbuHod/Z3rVc9idxzwDU23ol1Q7eyEFaV051UepPmYfePnjEbmvFTGqs/XA1gUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WyIWBXhZ; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WyIWBXhZ"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8de7bfa31d5so7758786d6.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863088; x=1782467888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+BCE++6dnn9vpZ/E1d7WFQ8H+QlVa8C9fwXmSQekOc=;
        b=dYZE2qQhkwfgkz//M98ZRusD2miCDc/zlkKsQID6IUTDR/Y8n7TsSOckyfr29opSd3
         1lu7Htwvt2GcxXMGRqbdD2vGxiqrwyYMdsYdHPbZtKDoLnnTBGvI8PHufiv5yUo3piGj
         T6p/1BsLm6IhTKfnG/02HIu/QRgwwlacIiOZoDIfngu/DkXfxcgnTkdP2sxi/Ab7xElE
         7cwfUdZvUY+Ia+UYtlXfNh7Tvl8AmSbGu3kzCSpsqGEYlxY4NDfQAQ75fA90fY+JUO5o
         lf4dgM+HCxb7zL+lHkucfqF8+1OxlgFTzG2MVachkHtepgwTh0WJNagQq2hDWXubCz7B
         f6og==
X-Gm-Message-State: AOJu0YwC3mLyvhygpN++545pnJB7lUXZGFO6HA9Ako4XBUfRe0cyAhNc
	tn2fO3+gtcUg0UsnpE/UJ69yujgSog4XSv0lXOwxdNo118LvO43/oObormz8+C2SqFCJS39uLFD
	wBVbiiJupqtqZF/jvGdHivku/cG/WXizb6gty06s7bWRhNMEg2uDdSIyyBuSnSUzFCTbpkGHNVK
	iB6SoCv2F00gdszVAoxAYyuKgLXbbCcTVo/YjxFaSYhybBloPf9UOslkU1ufy7v83w5rPUhVPw0
	LOhP5wjRqnOXCDKvg==
X-Gm-Gg: AfdE7clOie77BPNVEWrtxOyHUSnMblKzrn+iEwYVo/V80e75rbjDocZpSnQ+tnU/WUA
	vVfuZWKBTz2o00FJ9rW0JuaVmF2VR6VfV0mO/vFk6PQ26uKkMposgcYWOt6pXJUbMPJFXuFlHuu
	dPlqKXrp19KeZW6grZc2yh+dlrv3B7nZkMZHrrvYZx1YkpgNOYM9zm3grByIW9X26Xb5L1+k00P
	ZpwsyaUBv68jreB3BbyAvSVTGTL6k/xbk1If81X3aRHhqZ4W/Sbh0DyqYDD54TqNHYJzeMjVwER
	Z9pIDa4mZt1b4IKvpJPMLXEKMrBS68lGDTDaks4O3eaVZ/gr3Fkwbqo2VsQyYoYxXAGBP4v0bJO
	5SbtDsnl3HC/E+cV1eY3wdvrOdk2aF8A+rznIoYuonhVI3/senRqc62T08THKiEwrHfOEu1qdFS
	Xgbp3Uu1EyS2PrfQGaXoqwStXJvM9n3qf3SWhLX6Dnm3GBDF1M3g==
X-Received: by 2002:a0c:f012:0:b0:8db:81cd:4e3e with SMTP id 6a1803df08f44-8de3f1b91fdmr42379296d6.4.1781863087623;
        Fri, 19 Jun 2026 02:58:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8de61757140sm1001646d6.27.2026.06.19.02.58.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c13bb8ca9so206665eec.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863086; x=1782467886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+BCE++6dnn9vpZ/E1d7WFQ8H+QlVa8C9fwXmSQekOc=;
        b=WyIWBXhZupzBFdl1r8dQIqLHoIx7lcpk1uOHh8p4P+6Nwu4tyARNVP9EiDJbIEJutM
         gfH4DdwDV36PILIutZIVEpHgFJaCIvGK2EGhsb+eIeVgsa3cGgwD/NlP95Xssbj4uIIm
         hsjXbBK/xWIusy9F5RbiMiS5rusFFaQM/anY8=
X-Received: by 2002:a05:7301:4083:b0:2da:2ec2:64e5 with SMTP id 5a478bee46e88-30c070ee980mr1774521eec.18.1781863086404;
        Fri, 19 Jun 2026 02:58:06 -0700 (PDT)
X-Received: by 2002:a05:7301:4083:b0:2da:2ec2:64e5 with SMTP id 5a478bee46e88-30c070ee980mr1774490eec.18.1781863085710;
        Fri, 19 Jun 2026 02:58:05 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:58:05 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Inseo An <y0un9sa@gmail.com>,
	Li hongliang <1468888505@139.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 3/3] netfilter: nf_tables: unconditionally bump set->nelems before insertion
Date: Fri, 19 Jun 2026 02:28:50 -0700
Message-Id: <20260619092850.1274076-4-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
References: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit def602e498a4f951da95c95b1b8ce8ae68aa733a ]

In case that the set is full, a new element gets published then removed
without waiting for the RCU grace period, while RCU reader can be
walking over it already.

To address this issue, add the element transaction even if set is full,
but toggle the set_full flag to report -ENFILE so the abort path safely
unwinds the set to its previous state.

As for element updates, decrement set->nelems to restore it.

A simpler fix is to call synchronize_rcu() in the error path.
However, with a large batch adding elements to already maxed-out set,
this could cause noticeable slowdown of such batches.

Fixes: 35d0ac9070ef ("netfilter: nf_tables: fix set->nelems counting with no NLM_F_EXCL")
Reported-by: Inseo An <y0un9sa@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
[ Minor conflict resolved. ]
Signed-off-by: Li hongliang <1468888505@139.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Shivani: Modified to apply on 6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 15bfdf07c..196ac4e76 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6388,6 +6388,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
+	bool set_full = false;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -6680,10 +6681,18 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (err < 0)
 		goto err_elem_free;
 
+	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
+		unsigned int max = nft_set_maxsize(set), nelems;
+
+		nelems = atomic_inc_return(&set->nelems);
+		if (nelems > max)
+			set_full = true;
+	}
+
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL) {
 		err = -ENOMEM;
-		goto err_elem_free;
+		goto err_set_size;
 	}
 
 	ext->genmask = nft_genmask_cur(ctx->net);
@@ -6715,23 +6724,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_element_clash;
 	}
 
-	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
-		unsigned int max = nft_set_maxsize(set);
-
-		if (!atomic_add_unless(&set->nelems, 1, max)) {
-			err = -ENFILE;
-			goto err_set_full;
-		}
-	}
-
 	nft_trans_elem(trans) = elem;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
-	return 0;
 
-err_set_full:
-	nft_setelem_remove(ctx->net, set, &elem);
+	return set_full ? -ENFILE : 0;
+
 err_element_clash:
 	kfree(trans);
+err_set_size:
+	if (!(flags & NFT_SET_ELEM_CATCHALL))
+		atomic_dec(&set->nelems);
 err_elem_free:
 	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 err_parse_data:
-- 
2.53.0

