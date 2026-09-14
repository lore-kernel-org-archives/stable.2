Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716B443E43
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386721; cv=none; b=OrjCqokaTRi4AuFVlzuofrBc05IQ1E3HdxYPkteDzojfEdh0Y+UA11EXvgT9TZMawURCNJlZ3bOCnuMfAtqR3EmEGiFxHUStv1VTt9uljgHe7QuCFY+s/A66nPKEcRpwdbBOMCSf+35B8Xz65qLFWL83Qbuidq67KunBFpedf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386721; c=relaxed/simple;
	bh=mkOn9nUqrfUVleranEM9ERRJUce7DlZpXPdGbyI6jW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgZcnwkptM+dFBtdc8wf7dykw+jNr1z4c8ctgaZgNL7POrjO3W87z2g0vW/NtlLd9Sn+PWOJO4wH/vxEAYqpZQOsTZBLtU9fVV7/iz39TJ7tzfvfOfNDG8aE422hpOeAVItq0k1YSe90Rrp6yoQFQuGuQtNTimkluWKJGuuLrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVLnIwBl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVLnIwBl"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2772205a91.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386719; x=1789991519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjo/LDgf0JT3PbDxyOorKF5SRzRGH019Y7Xsb5x2tuo=;
        b=rVLnIwBlPoo6rmcbNNO1UradaC8lv2KMOR9etcvBrw+5bIpcK7GRi0LGQEQEMK9lPF
         ADnuTnIBp0MKw7iZbcscsdDqrbz0WhOXEpRM1CqBLehKWYSTpqZLTMy2rJ7KbT2HHt0b
         XXUEFKBcBnE612S6MoCOiaLj4+ZCH8L0mkkhMr4dajOAtxfo9541v1DXtbFL9ht2Wy++
         tpKkhA7m6QcRXSwNjNWqAKRSVbXiSKRkhHWpGdbGCYUJZ98feC4u8Oqdrn0Q6johK6l/
         NJCd7QCNRMAru4bIUH2rp/sLhH2TkD76jdBUa8TnGEIkQOgebzdk6UQjqz77h/oibMtU
         W6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386719; x=1789991519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjo/LDgf0JT3PbDxyOorKF5SRzRGH019Y7Xsb5x2tuo=;
        b=kHU9MwMCfHi26uLSXI6Y7ozCcC+vpVtSMJrMxrOdEejxMv1ti9IjKYCt8+uM3kBq5E
         oKbL7iwSijUAxPDR5SgGMHBxKVOT3+iEGmBn3y1TUrTjIRSqNiPOYJyXum20CSIVPzmP
         c01DZW2+SuIb8DpOgboJuxqwVt7sv/fo2A0AHAGW345U0A3w0DukLrtUx1CEA6l5jxun
         o1JhsjpRp9zGKwHv+1Swm+lqDXvLWwjdhoASLcr7lMz2NarDEjWakgGjnAA1Tu/Nwl/W
         VshMUhZlF9PEKx6WJWfJDJWcLa0+kxmQyKV0POX3Z49MM6uYnqDRaf5J3K0+8ysiVSv6
         w2Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzO9NGhDSj1PpDbs/r8T5DqAghtlet98jrWbD+GI+8LLHz56NFSxfBFfiL6Ab4hPWKOvKZWgHk=@vger.kernel.org
X-Gm-Message-State: AFuF++k/9I6p33Lf3xOVtH1T1VNjGBaJ9yCNFDNO+PjHITTkrC6RS9Bm
	FEwgGBdOcZrGza+qy47n9Kb883q2UY1oX8ta88dzA+IjF4a/MIL9A0Fo
X-Gm-Gg: AYBFou1XIvW/oOnfAYCbrz1htFfIXh+3HcvfXYEdbL0CmngboMC4hnQDwBwJbRVdYx7
	VM5K+LovGNeXQ/5ehKzfx64nh/ggHGIUpJjqR84sNUSsadd+sMwilS94YBmWXiwxd0Xlo1qurn6
	QFkzVsxj8UtZ8ah7xQ0S14wlQzCiK9f3O6kWv3HUADrq7qTFZHTqkvNaupG8MHHjlpM+6LR7LyE
	AKpxG9xwAdgPX1X6k7Zkt3w2Sge/P8GNRklyZgVQNdA63GfKgA0dbc7NP0H4SSlJn1nr0We+6XE
	CRix6W2r5wFMjfmcpFztONP22neMV8jzDjHHadl+bcvfAcz2yPui2aE1lwtNWYBtvRuDZvAkQtb
	Mr2EZLxUrW7nVw/lwuCrrVqLjFfy2H+q6OSuTvWYfaXRVKJoKO0jFnh+I4t32Cq+rnWChsUMifG
	ZajF45lhRmlIgZ0VeEE2sQ+KejHlEBps0zHZbvsH3xgPxALRQFSKIA9PshekiKYM/3bhzAr2fur
	oKWVQ+Z/R+N4yYejOtidnwRx2aiNWoscD5Q4Q95n+vnG9o=
X-Received: by 2002:a17:90b:2dd0:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39dec15c01cmr4922034a91.24.1789386718894;
        Mon, 14 Sep 2026 04:51:58 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d7ff2c5sm5076020a91.2.2026.09.14.04.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:51:58 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v3] netfilter: nf_tables: skip expired catchall elements on insert and delete
Date: Mon, 14 Sep 2026 19:51:47 +0800
Message-ID: <20260914115150.3470734-1-ljp1205831794@gmail.com>
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
dump path additionally skip expired elements.

Once a catchall element with a timeout expires, this predicate drift
makes it invisible to userspace dumps, yet it still blocks
re-insertion: with NLM_F_EXCL the request fails with -EEXIST, and
without it the request reports success but silently inserts nothing.
The stale entry only goes away when the (user-tunable) gc interval
elapses, so the catchall rule may silently stop matching for an
arbitrarily long time after its first expiration.

The delete path shows the same drift: nft_setelem_catchall_deactivate()
picks the first active-next entry in the catchall list, so with an
expired entry still pending GC it retires the stale entry instead of
the fresh one, and it deactivates an element that userspace no longer
sees instead of failing with -ENOENT.

Align both walks with the lookup and dump predicates: only an element
that is active and not expired counts as a duplicate or delete
candidate, using the per-netns timestamp taken at transaction start,
in line with the set backend .insert/.deactivate and catchall GC sync
paths.

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v3: use the per-netns transaction timestamp via nft_net_tstamp() instead
    of sampling current time, per Pablo's review: control plane insert
    and deactivate paths must not let an element expire mid-transaction.
v2: drop the is_dead check, it does not belong to this dedup walk;
    also skip expired catchall elements in the delete path.
v1: https://lore.kernel.org/netfilter-devel/REPLACE-WITH-V1-MESSAGE-ID

 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 765a92fa90d62..7ef2e19e6655a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6991,11 +6991,13 @@ static int nft_setelem_catchall_insert(const struct net *net,
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
+		if (nft_set_elem_active(ext, genmask) &&
+		    !__nft_set_elem_expired(ext, tstamp)) {
 			*priv = catchall->elem;
 			return -EEXIST;
 		}
@@ -7088,11 +7090,13 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set_elem *elem)
 {
 	struct nft_set_elem_catchall *catchall;
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active_next(net, ext))
+		if (!nft_is_active_next(net, ext) ||
+		    __nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		kfree(elem->priv);
-- 
2.43.7

