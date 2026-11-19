Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067859;
	b=e6MqWk3WMHFgLe/FeC8V23E9Q7+/YY4p3CgQwX8Jrt/a6F7QEFHkQIiUeM12OU1yXxLd
	 YAKcuSA2BARIU3Ttgc19+v7UFUfSSavnDMN6SvBwa2Vz/6JdH6BQesprQjn3nFFluZW5W
	 k5V//zSXE4uuo8H0pTr5Vn3i/gvPmWtxWzx5EQSZRso9YROM4ebBA9ZWwhmwoxw69oHMr
	 Qrl+PTEXY7AMGi3wxLUk3BFLbbQijd8mkT3Aojo0z2lDQrmCt/zK8/fs9ytRC14wyIOWC
	 F8CNXgfJBVPJ9EgByGNiJWFPUTLbVeZA/AXJQ0nBGsZmHP1BUeDu7JSvCOXLyZJFhcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
	b=1zFqVUS2kEPDvv6H7lSmXcozO9NgueHNIllkNnnkyjosAcfriv/8aA3EHgkNcW1qj8Kp
	 SGlsox85Bbzab9W+/kt0S1MXrEOt9s/hsGsDOQXcD+Cwmjn+quHHrMzeGVd5NfJ1pHBDp
	 ud+NLrrzbOJVHJ00INyJibptRa45Aaa1NbNn6EDsBFAG5/u1K14czFGT2rQmyhVxVT6hE
	 Qh/eVD5ewe8AgYlca3FmjfcIIc0WbFqFg4562qZSAsRU4RJogJxy7yQ7D6Ewd1Nio3fWU
	 MFL4oWKXvIFqCTUIA2UpAnn9T/v73fnwaeWQJP4fimKuetGoVcZhJmz7p2TsE++pYdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBA65JUb;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39760606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39760606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBA65JUb
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b37951a397so1557099a91.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067858; x=1795672658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
        b=EBA65JUb+bv2UxY2ox9eUzkzbeuUUw25Vutf0qUGRIgv4yUMPdIa01zPNzSecI5h6o
         LvV/MaALWu+lrWqnNbdkPMcsXFsMqrmbAO4HF58np00QKwOT0Rn390YRRrA06NdJb3YE
         l+8wAs7RP1X3AL0LXmwo60pZ45zGKfXeO+bSECABikv6xbuWtV5cEuoTxUj+f9XM5V3w
         ji8xI21GvwnThReOV2IGKhi4SKnhmnqnOVkPQlpGsYSxqQNwf1C6CHQSPyqXneS3w7+a
         C+HiTPvJ/Ux7yEelEbHs2YVn3WuNgXiLl9tG9dyh41v4dGbg57n7xheH67UenNciLrnL
         waqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067858; x=1795672658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
        b=2lFqES7NAHuSb4VXnSvBk95A1PLhIjE5ysx50xvufxd77r7lnq8LtN4NWFyv2e+b+1
         fEyykyNkMphs9r2W5rA85VBQZQgdPmKj32z8QT6YwDTIZo41kFj5U/8mT5X7peDDXuJ6
         vm5t5yPrkHforaMNqdpIobSnoJvEHzlJLYqce9iLrS/Zj8M6j0sindEWroNxUADXEhfp
         +ACBHSjdazyDJjRu2alArfKN9ShAmWWbvpgr+FmKKveedqV+QOI8+mm0YYm6yzcdpg+C
         UJE0ImYHJwgX7P/Tkk4k9Wag/pqeHUqFR1a/U0P2QlYyk6CknqSpSwK/T6krTHSYXA1h
         WSqg==
X-Forwarded-Encrypted: i=1; AL+hErFFgJGeGzmvB0masv2NaKuGzjosYZBe8bqfkaG1Nbn94Id+QKT2WXuPEiPM/C2L3ZiLN/Wpm8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gn66LxOVagC/CkUkrqX04bNFB5Ou/v/ab9yx6VbW/aLNup9al
	n3geZwD1REDBVUvQjALPivOe8V5TX5VYB1Cl/sUB0dUiaUshcYrw2y2M
X-Gm-Gg: AZFdTZcoW1iGbJvjJNd+HrFsAvzL4IuVQdBQghbuH9sXiHXr6jGTtBkvdmFfiTtC8Qq
	1UlDeRoLHIkF8tkskwAuWf/nL+LnRPRQaGVp5W1xH+FiWTKVgscr1EgTZNj7IhfrjqVtyUueJ/E
	6qIje0aBIDBPDMSuXV3AUx/edsGV+riev4ObBQ+QJL9IYjIsCh1sf4d+TZda9oTzIjXNmkjNWwI
	OLnVvCnbk5XRi45EML4bnjtwWfKR0jp/8Scq1k9/dcbYHV2GL59P2vWYTnFVLedfFBpipPNwQEj
	L377p/odn4HjO4mL34YoPcUaMLcPJgKv0YmarJc4soV78ICfrhSxdDoQj2ZscxdP88YlOlNMfN6
	eGmhyyCGhV801WTPJc2o6Jc2bNV4epAgTZo5W9o7XkVl64GQOiv1Mve92Nh/nDzhTh+ZIW263Pg
	PlNz3REclkd1HptPMft+P8UKaXwXYorRAdeOxBLtdDTFV8o9Jtho1fU/66mmYk4HvSUM8YnLDUv
	9AbgQi0SU++7/cZ+9lThnr+iSX9Mlo2L/20QhPHPVFRHRr34vtvD+Txn3AE8RvTQIY9UGqN4iD7
	swmN+BpvLcSQQARAui6iOkCbWOAK+bZ/8w8uP6Sv6CZzEcXTRPrU8oGEP9blNSsWIOB7tiM=
X-Received: by 2002:a17:90b:3c04:b0:3b3:adea:4b04 with SMTP id 98e67ed59e1d1-3b3d07bf9c0mr4206369a91.36.1795067858445;
        Wed, 18 Nov 2026 21:57:38 -0800 (PST)
Received: from localhost.localdomain ([155.69.167.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ec9cd0sm24469175ad.11.2026.11.18.21.57.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 21:57:37 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: m.wilczynski@samsung.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] ice: Do not free a preallocated node in ice_sched_add_node()
Date: Thu, 19 Nov 2026 13:57:31 +0800
Message-ID: <20261119055731.55798-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

ice_devlink_rate_node_new() allocates a scheduler node and stores it in
the devlink rate as priv. When the parent is set, ice_devlink_set_parent()
passes it to ice_sched_add_node() as prealloc_node. If allocating
node->children fails, ice_sched_add_node() frees the node with
devm_kfree(), but priv still points to it, and later rate operations
(setting tx_max or tx_share, or setting the parent again) use the freed
node.

Only free the node when ice_sched_add_node() allocated it.

Fixes: bdf96d965a20 ("ice: Add an option to pre-allocate memory for ice_sched_node")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    Bug was found by kbound, an internal static analysis prototype.
    The fix was written with the help of Claude Opus 5.5.
    
    Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
    not have E800 hardware.

 drivers/net/ethernet/intel/ice/ice_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a5c7a4e1ceba..dba6cc912b7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -210,7 +210,8 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 						   *node->children,
 						   hw->max_children[layer]);
 		if (!node->children) {
-			devm_kfree(ice_hw_to_dev(hw), node);
+			if (!prealloc_node)
+				devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
 		}
 	}

base-commit: 6055ab4d82e42de89871db03045b568ed706ef50
-- 
2.53.0

