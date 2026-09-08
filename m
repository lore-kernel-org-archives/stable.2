Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBA53CA90
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870785; cv=none; b=Uf0KcQklKqzKaMnPeMN4GOO8ln3hVfL0ToW4yx5tQDM9IcrwfjZE4gbfu51CZyp58nvQySi0Hu/HYVuRnoyzipx2DxMz8AI16Jq8NDL1S2hk6dH17WcXY4cPpWNCRpN+Fu/s/6Xh8eiKffeqWpDkttXYRGCtj84HrsG2zq8P3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870785; c=relaxed/simple;
	bh=zGQ45INhV+e8yZFj84FGEy4sP5CCpL1qdRdz893lRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3COowbLm/B0NdBM170wxnDZCZ6UK6Tak58BZL5zCggv4RkoOEe5tiys90OKKJSVOu3TO/B1ZM6+Pq6k5ELI71h1FYVW38nFpDWQ7OjGJ6qlnB4b2W7D5zx7H59EtA0zFuebu4iDR6QrtONgbDzGMiZpugtNEEV3THEEYW3KfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+4p7DyG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+4p7DyG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc48fe04342so934595a12.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870782; x=1789475582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zq7zuTRm/ZBDJwfmL2/GYPh9/WXjQmK9pRLqW0xElQA=;
        b=a+4p7DyGQo+1sHa9RpgIAvM+j7GiMPQB+QfQAvrC/Gus1PCKOWPV7eN2AP6J3mcAoR
         0mH8kn27SB43+cMrdf9RF3NJNPE4I+GmH24VYyq/jlearkfPGDXp/2WUteyM3dNJR+I6
         YHmsx6fqmXGa+o3tC/6kSCgyBgK+zt5q0GFIYOEMNEXJPsmBbUOuyTbw4c3TKfoPag9f
         XybMyfBu9KKYMoM1LmG/chGrL48tjuU3TxysQg2KTv3SmxJqQPKlOlTjjdZXO8AXpEIv
         Ilii6JCPq6cBTxKodquai7FMsnmUUGXyy8gQ1yA4AtwB1UdVj0dIrRX1Jvuj9sChZcEQ
         LY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870782; x=1789475582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zq7zuTRm/ZBDJwfmL2/GYPh9/WXjQmK9pRLqW0xElQA=;
        b=UQ41R7SpMHYRAfdc1orxM7IKgkmYl/tN7Kz/3kiYq2xCDcRsWePuoFzfBq1kocYVsa
         uiRzb+x1imHmEckOkhE7TlodYDAEjxDR61LqkU8c6Oae5hu+RVDauxIlyGew9/RzGaBv
         KQw4lqvMOgBUquweyPxm58Mky+zuNkG3mxIqk4Wya1Q6JPoNT83cpjPfBDBqa0I+eBp5
         kIkKy008MKPQ2cTGT6wxj/LKG6x+HX1su0/shBfypb6jvMzkN1eiKSzkSBN51z3DIOBm
         yeOIzATzSGi7GWzOTBiWP3a6t3gY/dFsgBIUoit/ftWGHIi5lHI2NDsjwQzxyQz8Yu7Y
         P+qg==
X-Forwarded-Encrypted: i=1; AKwUvBwlzi8jLyZpB+aNWSXWD1ZltvlEV2BXwMRV0GhaQot+eJpXD/u3ImpfP2a609GGcPq0Vl9GpPc=@vger.kernel.org
X-Gm-Message-State: AFuF++n2P1R4w4T1cen3HS5bo6I9DP8bhFKz81NHFhdJDmZto7SuVPMA
	nlKfcR4UYxAs49LZ4/GiAxCoPv+y32m7lB+Pqa5pagk+cRois5kvGhNk
X-Gm-Gg: AYBFou1sZKVun/DRhPc1CwhAYC6D+zA8PQ1i8FrKGXCLG3xlKzW29bmIuNXIuTutzAs
	ViBLJ51XNrQezw41An1lMl4L3m0S3P3B4TfVqLHiJQZirZ+5JkisHTOTT09NR7PTQ2McpDVQRB+
	9abUYXrrt84Um8z6mL8ebLPrccvMpru9+0HyFku6a0k5S25L/a9aWKz8LL23SYupHRid9VK0CRq
	JJ4zw/tsLuVQeTl5JKDr0l1wnJI8fvgT+FiwkdraFWNFVfDlduz3TWKs0D9HuvZtu/U6DFRI2GL
	yljEMWUwEaEIT7Oa6ASbCQvelWeyDbohxRSh3WKS0KkqrUOa2X8UnJk/7uPL0JHKy/1gL5ax0RE
	P6awHodxaTdwDuyXFHxHSmFHA602PN+JPi6sCF4e2cUQE9yLq3cdbiPu+DFskXBgWiCUjl4tcnZ
	+4tK123oIsld9hFby5eRfR5yHrNNUuV6ZPJ3CeJR0ttZ2/P6rWj3ix5KRZ4WN9z3sIyueY5b13q
	4wcPhEOZTmJ1DQOccwOv+OZxo8=
X-Received: by 2002:a17:90a:64f:b0:39b:370e:c807 with SMTP id 98e67ed59e1d1-39b370eca6fmr24154970a91.17.1788870781754;
        Tue, 08 Sep 2026 05:33:01 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm12511958a91.2.2026.09.08.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:33:01 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: skip expired catchall elements in dedup walk
Date: Tue,  8 Sep 2026 20:32:47 +0800
Message-ID: <20260908123252.1162896-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

nft_setelem_catchall_insert() looks up duplicates with
nft_set_elem_active() only, while nft_set_catchall_lookup() and the
dump path additionally skip expired and dead elements.

Once a catchall element with a timeout expires, this predicate drift
makes it invisible to userspace dumps, yet it still blocks
re-insertion: with NLM_F_EXCL the request fails with -EEXIST, and
without it the request reports success but silently inserts nothing.
The stale entry only goes away when the (user-tunable) gc interval
elapses, so the catchall rule may silently stop matching for an
arbitrarily long time after its first expiration.

Align the dedup walk with the lookup and dump predicates: only an
element that is active, not expired and not dead counts as a
duplicate.

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 net/netfilter/nf_tables_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 765a92fa90d6..6458ee26dcd9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6995,7 +6995,9 @@ static int nft_setelem_catchall_insert(const struct net *net,
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
+		if (nft_set_elem_active(ext, genmask) &&
+		    !nft_set_elem_expired(ext) &&
+		    !nft_set_elem_is_dead(ext)) {
 			*priv = catchall->elem;
 			return -EEXIST;
 		}
-- 
2.43.7

