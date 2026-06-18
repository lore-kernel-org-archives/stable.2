Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88E3B3C13
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771862; cv=none; b=DUuCkIvbynHG9RDSIqks5sXcZRaDCm0Yyu2MgVvng8rzK9NNNrgerB23b/0InoyHLwYYfgfYLiJbAhhiKbId+ulNral+sQEC13HXqg21sIRIbtYHGwWSkC1pctaXGn7bDWLcl4hi/WpQagDuqoDZiysyyJH/J0+wNnNaEw6+iDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771862; c=relaxed/simple;
	bh=aIbJosctl5OF9ZsLu4oXkOHrco919wfqLXR+++iz1xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjFPU9yDWxSMbYiqSbAfawBU5X3AxRz/CyPMBizu9HfRg6UN+Yk0hOOb8skA3m2yW8Ykyg9z6AV4nbA1+48sMbFOfuUYq/xS4Kwp9LNIm9AyvDyxrBAXtpB/Ph8TdTchnoi7avB/JVDcz0tkMwNncGUT89924bBa7c3FqgrR8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fnPi7h/+; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fnPi7h/+"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-43cce34c881so537311fac.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771856; x=1782376656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9hVwQ2uFHG9yjsxEMthJtly1U3KRAfycxfm9+vQlLA=;
        b=FuJiFk0mVny0ieKfPhR8GNHby0Nk25kPf6dJNGPCU86s2QtD30cvQqHyoFj32LoxzB
         i8Zd3js+GglUHDUcMn8TLAJl8OjHUruXvTzAaHVqsf8sUrl985aSBXhyhDXWWCM5afoz
         UDEdunDzw10osAVYcDT7snvYLw+Ixy6IL9m2kvJ+hNZptDnLzQyuQsbfkaNxMCrpBu2R
         75jRk8VIBw8KtXViIlZliM+rn5Eu1jahCSFQRb/3szs8yhIOfC3YaLzPHjfvAmFoiZa4
         09zHujpkxsaE8uP2OO59ZKaC10nWcfFyr3HDvkahoQSPIaqEfqLX5pqEZGtLnt1bXdiQ
         acbw==
X-Gm-Message-State: AOJu0YwuBCwNbdq+5uxoYieerCDb9MhRwyRkB1VWAr1zQB6FoLxqhR6V
	Kc8BfthBI/PYgOOftDCmzJV9S6Hai0xE7rhYADpYQimE6xNYBaaRHTWmaIn97mRiFqU0FYua2HP
	GAif10pf6dLhj6G9jaIiaGQ+umQvy/hdbShaEvaUzt9g59OsxK3Sw8BI5wiIIEHG1e0oJzqDR6h
	VBfqlKjiggFZxeckQE/MgoIMOC68XYVWMbEjDqr+4Z9cXcTkxm0xtWju6ZT7upxVIo0wmHMRqZK
	1oK34aSiDgyZnQpgw==
X-Gm-Gg: Acq92OGySevtMV0x+VQ2hZq3TLZdEDuOcD93Oz9dHIHUy9e2kzzY9zGhKg6ZhvZfdjw
	Vi7SEpoCf88FnEOmS+AEUooBvAbjNV3xOk/t7IIpAzlstvhYfuiXjgK9oWAxudw+Dxyyg9T9u8V
	Wd32tHESbV7tijG/sdnyL+OGcKuXnNo3UfTLsQ30lnqZWJuqAwtHl7voSSADY2EKm27Mj1Ot088
	skW17l563DkbNtwnwzcOEeuZ3880Ux6CtJ3uRv0UrYGa0duIIWM0TmD1SHNrHgMoiPbL3B2C8No
	YQ2sdCEk7OMYngEpwpEkpHkkK7A50WWh8Q4u+idx3PDgsPMUizFBQd3VRtfE9cIuugS8sA1dYPV
	e9nGyL6vYJ3WDNzSQLqfJEIdw0Y4OZ73dd+3u1ONRVsieIP7UQg4liKPoQ8PKlm09sMm2uPpW1Y
	vn3r0ymoh7SVa8ImZz9vRL43eryjuTM01YAK82gtGMesAZwONCbg==
X-Received: by 2002:a05:6820:81d2:b0:69e:8932:7fe9 with SMTP id 006d021491bc7-6a0b6161128mr5829196eaf.41.1781771856115;
        Thu, 18 Jun 2026 01:37:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-44308a3588dsm843314fac.3.2026.06.18.01.37.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304f23c55b2so677187eec.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771855; x=1782376655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9hVwQ2uFHG9yjsxEMthJtly1U3KRAfycxfm9+vQlLA=;
        b=fnPi7h/+J2SSTjCUSzrMopCYHYLHUIfXhy7fUkFFuJ3ZYuFFnAN88eLJ7ca9wc+Mv3
         Uk5ttiN7FpOJ5UM/EZNSwALdHsc3zPxqqIT2wOzrKSd1HqJlD4rResvS9Ua5YIC5NnCA
         /XDh5FfLTugpc0OmaVWsnjGz/J6tZe+KC1haw=
X-Received: by 2002:a05:7300:2209:b0:304:acc:f079 with SMTP id 5a478bee46e88-30bca09e535mr4462731eec.27.1781771854698;
        Thu, 18 Jun 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:7300:2209:b0:304:acc:f079 with SMTP id 5a478bee46e88-30bca09e535mr4462680eec.27.1781771853897;
        Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	GangMin Kim <km.kim1503@gmail.com>,
	Bin Lan <lanbincn@139.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 2/2] net/sched: cls_u32: use skb_header_pointer_careful()
Date: Thu, 18 Jun 2026 01:08:07 -0700
Message-Id: <20260618080807.1269070-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cabd1a976375780dabab888784e356f574bbaed8 ]

skb_header_pointer() does not fully validate negative @offset values.

Use skb_header_pointer_careful() instead.

GangMin Kim provided a report and a repro fooling u32_classify():

BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221

Fixes: fbc2e7d9cf49 ("cls_u32: use skb_header_pointer() to dereference data safely")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Shivani: Modified to apply on 5.10.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/sched/cls_u32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index f2a0c1068..e501390cc 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -149,10 +149,8 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			int toff = off + key->off + (off2 & key->offmask);
 			__be32 *data, hdata;
 
-			if (skb_headroom(skb) + toff > INT_MAX)
-				goto out;
-
-			data = skb_header_pointer(skb, toff, 4, &hdata);
+			data = skb_header_pointer_careful(skb, toff, 4,
+							  &hdata);
 			if (!data)
 				goto out;
 			if ((*data ^ key->val) & key->mask) {
@@ -202,8 +200,9 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		if (ht->divisor) {
 			__be32 *data, hdata;
 
-			data = skb_header_pointer(skb, off + n->sel.hoff, 4,
-						  &hdata);
+			data = skb_header_pointer_careful(skb,
+							  off + n->sel.hoff,
+							  4, &hdata);
 			if (!data)
 				goto out;
 			sel = ht->divisor & u32_hash_fold(*data, &n->sel,
@@ -217,7 +216,7 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			if (n->sel.flags & TC_U32_VAROFFSET) {
 				__be16 *data, hdata;
 
-				data = skb_header_pointer(skb,
+				data = skb_header_pointer_careful(skb,
 							  off + n->sel.offoff,
 							  2, &hdata);
 				if (!data)
-- 
2.53.0

