Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430633;
	b=e+hTVsY57EhTPBeckZfjjt8WLIM49K1kf0GexoOMRBPQvTgh4BIFfqOrnbT3WSxFqK/i
	 xyPPfTWo3tZexZquRsTD6j/NpH+YmnQxDIJuupLoX842Cf8l7UlWwIzdpzRgdmx/TcF4u
	 RrFM6YQFr0bAOLXkeyz9I4VusSqhTc0SQf9i/i2QoltjFsgX+IPqfvfiNPCPpwwC7IC+g
	 jG5WoTjqyObaVAvGOZvvcLldthp0nXgWU5qXA1z8t80TQblYNCq1a7Ved6C7HeT+pVSIw
	 9nlpS2dax5fgl/lgBH7ROLxTReBD+FLOlqDs8dSoAwfKxVv58uec3pYdZo4yE0D/wSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
	b=Wtiuodass8+83T0JOh2XVmo8QfPNtQqL+T2pR/RmBFH1wVo7Jjcw/UeDxBeps4YfdfvO
	 6PBfomTkS5hOQ2oRDNjOAo8mH3RPc7/9MXbe6aTgUht7K0kIGug0PPpuhysodedoKaZqB
	 aX+3a6E1rneADtRhQYzt3sjKtCiU55ISIyzCU3Hs2/LxheJkiN4TsIYMwL6y8EfBzhbbe
	 MR6bRUhnz9LMT/s/XlazacvpRxaEI2db57Omrnki6puiCvPTEG56TT4sgjbrTlmNs0e8g
	 ZtZa30DsILBQG/3kNnp9iDzJ1CRntFRaKj237nzxp9Ybzm6SsRRJ9vGKmBYzN28F7Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="WB4/j1+F";
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBA606A326
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85DBA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WB4/j1+F
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917d595138fso15750856d6.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792430631; x=1793035431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=WB4/j1+F1iM/mJlwez/NRd2xWxGjEmcITZuem8/QbOWdCWFw1vKlpZtkZ4RRYEw09w
         G8GbWJi+VRyeyDiTbYI7ciQb4RcUgiyrbSS4PaqNK4HR9lDUr7imu0hgVbPFUL73YdQ4
         Yp40iwmt8wx2g0xGLD1BurD+FGMzryzHq/YJKGG4NJ05yU5W6CsGqgVCPS6tt9+xr06x
         NJu2MHHqH8K1MNC+tINP5riqAV53y7pOLkg1e1x55IMiMlPLaFAtPDN4DiSVnP8U5Jb7
         huAhwOwnmNnVShuwqmkwA/2poIiHAIQDjRncd5mT0MoZ9iviOb2AkWDvTWqnGGSTZ0oU
         YEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430631; x=1793035431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=s2+d4yESObkJzuxuBplF065F53uCHUZ/iwyWoLExNwfPPIruzhLYBYh8Sl+PeM59HW
         CIuDbkd+WXjGyFmM48yWZe8JhRVtbqMxSQfbHepU9zNqm3Qo8hkpY1ePpp0Bc47RtI/1
         03WGnmY2aO+UtfOFwy6UXCJoOKnJtbQDrBtmwIXbQHuDBA+CN5b4zTunSCu4fN4w7E30
         UPE/gWnGFeXgRKB4wzedht3sTDsE490UKRg8FdhKX1cy4cqGuPBnFWshqZgjwbbtdx5O
         ZL5GWIbYV2CLqie98AQakPT5lTPX5xMunlkGwbivAy8b5sYz3nMYe3A99n1aYA4pxOui
         Miug==
X-Forwarded-Encrypted: i=1; AKwUvBxDvYaYN3Ro0dL0wfTQbFIwYi8iCCKl9r2rGj79iLfj2SbmcufrwoTOzFgwxvq/vAohLBD+ASw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1s3gry/wgxka4lNEEf8L3aYKOWl2RA3Zk9zZOZmcMIg1iq7ER
	w+K32eIKr6Loxfa8wGKHYaA6YGP2hEDiwfQs+j53TZIUiGj9ZQFF30i19cRdEBv8dgw=
X-Gm-Gg: AYBFou3xcxGLWdA7+7gfiUEmrmuj2g5zFSwzS0h3FnOBZf6g7mWigWkD9qI4WgEuCI3
	Y3SzLYjBXoH2FsHgNx6yDgALZF6nll9UYP2PJ9AYWobZePtnM+vrcUkK4WYYdRNeP3oE5P4pA2o
	DDQYi0GjM86QQgfKTyodHI0r00H2d3kk+Z3QEX19ZVCIjDlUaZSJnFeeJTGuAWlm7HzTjv7ZlwO
	rnRrYOw8N5DC95UNIMmATcDDxgy0eRlfSebS499/dgTUqRnSSSD/IUqcN/4GUipyx616sJVhTvS
	7YYrb5FesB4nJu+hPACrk54QPmes6sxjn6ci/7MZUYkOoKxNXZBcw900N/UFChWu65EotYB64jK
	5svws/KLkCTPt4If2hZynWsy0PI18XMeTeNYbb9B07AY28CR/qHY2MHx/j5zhXdJ7I3mGXrmLke
	IVyX+QwRK434sfRsljVMWqg9rzdfVqGpj9vvP7cy77MECXSnC3kzaw+zAe8AHZlpa1ZwIhZH9w7
	jo9mul/NqtB7eHDs+gM8kezBfOwDfLNzVI/RK37MOpdwVHdLF6dRIcWwyJr
X-Received: by 2002:a05:620a:1b82:b0:93f:a63:15f8 with SMTP id af79cd13be357-93f29b7fb31mr1250130185a.8.1792430631371;
        Mon, 19 Oct 2026 10:23:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4adb28c2sm14615385a.0.2026.10.19.10.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:23:51 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	jiang.liu@huawei.com,
	Bessel.Wang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Mon, 19 Oct 2026 13:23:41 -0400
Message-ID: <20261019172346.3344005-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019172346.3344005-1-gourry@gourry.net>
References: <20261019172346.3344005-1-gourry@gourry.net>
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

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2daf358269ae7..c7125f6693574 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.53.0-Meta

