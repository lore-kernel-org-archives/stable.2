Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744333;
	b=smBWr12k5KVuqbMrLhh+7e5dtjAYDgKR6LvqqU3H4D6vaOLtAsQzUL+ApnkTYFAC6U8G
	 15gSIyThFkE0hkMKM4YREH5azeLFMUQkGQYMB+Vn3yc7zbtl6YKqMv3YoZRcyANoHm+UQ
	 GdQ/Uydqywwj82u9IoKUqXduJAiNZoylLkzn5MCCgDoI3kBkNytwyct6kJpxuXicskOex
	 EW+C1FpBd8sSsdgo+eKxmCEGAmIu7wptCsHpxVfe1uY8RlSlS0KN6qhuN2leYfGuFUBST
	 O0b43v1cHx5Ds2EQkppNo3JnBygzFw3huel9nOJ/WEbsiV/73wiby9sHLy2dSEgnHFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
	b=1OUTtiTlIX2WbZz1vfvtrwvv7zKclQI+oVWHutgG/ZKMqMd1F7wtr1LY0434LJBDBM05
	 5p2SuPaQW9sr1BEQogD1l4HuZnnog4XeTlyEuKgy0ihl8D3QCmIBzgjE1qitsUzOC5iua
	 pVieOV5tn2+1nuzZjFJWPU1HV+Ym9my+oL4SQzc1r9dRdc449Q9pbVpGyu1S/lMQ9awCJ
	 2v7aWbNFp6MIRY6RO9lgj2xAErXtZ7j3miZa0KeE6HTfburUwsJcoJYDykt6DV4hkDdyF
	 ZienpLLF1/+AfGIyXX0HLq4kly54mP2xiHnY/uw+XD8DjjaUNrshApDuph3caxquVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwWVgDjw;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2113606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2113606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwWVgDjw
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so42109f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744331; x=1794349131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
        b=QwWVgDjw45GQF+6Ky53/zvEOWrFODywZMVhnbgslUfG42NlsA8BfaQnPQPpPlWRJCm
         yOfEJezG1W/8e12kvW9xuHlybkPA23txlXl44f76P7wRae6srAogBRa2CnjddfOFkM48
         G5tbtO0bgIYR2jTml5IuE6a92E5TBwd4q85rBHdmb1jqRkFD+S1HeG78TdvINIXzjrT8
         LGzQdU64EHPd9NvW1MXofPuWS33J9Yq6tm74fAXHrNRuMfuSyW+QgGvv5YcE3fF+A7xD
         KU11lzxq1iCSU2O2OIVtkfBpk8pzTcQaHCoAFOFm1rnBy/xJrSLADhfYPfk5St2X9pcU
         xFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744331; x=1794349131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
        b=sRY6qLqMBFPYYxf8/DzpPWX0mvLzfqztzJeM+jtXo56zYtGvSBLEl+I3vVyP7JTKxb
         1r6ttzqkmP/ksh5QLCcqK4kCWCbFYFAiLFyyZ1NwxM1RbvNw+oQtunECP5aGvTqVXKly
         SobYd6/HjzIzB5HqBT6uGOf/zDmnQvE/L0/aSkdLHYEz2pERdYZrgE51xzld8m1hI1SR
         uczozwTBQDXLdtX/+yBYORH8iLSdjmP+xP+3EueF8kqQPv832wqWW3zG/zWnRObGXsRV
         WhcOsEs5lBJAmQP9DRK4xMY0ekAUYZsgnU2TqWYE2543HiyL8+BewQobcnXtyjcT1eSe
         3D2A==
X-Gm-Message-State: APuU4Z+r7jDwPhGbEfw9LOnReFoHNbUUiiBgzZOqVrH7eEuE8hgV8zvV
	1zta8FElv4jMyGQPds5nFBwvixBLsw1Y7iOmRCFb8vMhDsAlgz0Ox+/0Dfx0
X-Gm-Gg: AYBFou3qB2QgfvlLbYXFGH6bZz5jb0NDf6QRcTahFDDwsgCR13YPFjK/UVRPBD7UuKv
	N45AF/wh46rSFxaiIfALvxqRSvSYpJ+kA7+gihrqZ5RfgmUgjP2fXzi0Zi7UuI2Q5Tpi72Fiu49
	nfcISCxVhTMAZsSPo0RFNQPBpFhai85KbqrfoBgMdn2pbx/edGk3j9UrmjUh0EasuZaCgkSye6K
	vg2QJMI/Wgp6f+DaRWesU0kKyec+N6PMTqhOU9xeQgVmQ93LJM8X91FmpgSkLBn6I1NhsODVBvz
	EmKWSYjYaoQJW9GzWG2IJekBBHBlNSZcHf2PRTmnUIyWbOMzoS/oQ0BINpLKKX0OSFJfvn1bYlE
	AKs/MG35VOpeES/ElIiBTBb0yEkV1KdjBIBR4eVLQ8Ss4gVe/A4HbwxpVd/G6iW4UAOfwYjeLen
	IkX+tdEsNGq18eF1g5ijpm/OgrE33F+ZriK34jQ4kGseqc1jyUVJJZHwJ/H2eBvXVnlUd221kiC
	M5e2soNSqWcakn1kzFIaAI8za4GjAIepya4ar9vhKdgkygp9LzqAGIJJ/kkkwcXklIgFM61CkjU
	cjHbLPMo92krnmm5GlvPXlQuYahaKetEOl8=
X-Received: by 2002:a05:6000:2903:b0:487:342:d141 with SMTP id ffacd0b85a97d-48e6e2f6615mr32207753f8f.23.1793744331143;
        Tue, 03 Nov 2026 14:18:51 -0800 (PST)
Received: from ps42.lan.pis.avalls.dev ([2a0c:5a83:540e:7d02::ed7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm329458f8f.24.2026.11.03.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:18:50 -0800 (PST)
From: Arnau Valls <vallsfustearnau@gmail.com>
To: vallsfustearnau@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: remove hw flows before unbinding the flow block
Date: Tue,  3 Nov 2026 23:18:28 +0100
Message-ID: <20261103221828.317312-1-vallsfustearnau@gmail.com>
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

Since commit 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable
binding"), deleting a flowtable unbinds the driver callbacks at commit
time, before nf_flow_table_free() queues FLOW_CLS_DESTROY for the
remaining flows. The destroy requests find an empty cb_list and the
flows stay in hardware.

Conntrack then times the entries out while the hardware keeps forwarding
them. Once one direction ages out of the hardware table, its packets hit
the stack without a conntrack entry and get rejected. This breaks
long-lived UDP flows such as WireGuard whenever the flowtable is
recreated, for example on every firewall reload in OpenWrt.

Remove the device's flows on FLOW_BLOCK_UNBIND while the driver is still
bound, as nf_flow_table_indr_cleanup() does for indirect blocks. The gc
skips flows with pending offload work, so run one more pass and flush.

Tested on MT7981 (mtk_eth_soc PPE) with v7.4-rc1 and 6.12.74. Found and
fixed with help from an AI assistant (Claude).

Fixes: 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable binding")
Cc: stable@vger.kernel.org
Link: https://github.com/openwrt/openwrt/issues/17915
Signed-off-by: Arnau Valls <vallsfustearnau@gmail.com>
---

Notes:
    Reproducer: hw-offloaded UDP flow through NAT, then delete and recreate
    the flowtable in one transaction (fw4 reload). Without the patch the
    conntrack entry gets a timeout and the PPE entries stay bound. With it
    the PPE entries are removed and the flow is offloaded again within a
    second, no packet loss over six reloads.
    
    Not tested: lockdep, other drivers, the indirect block path.

 net/netfilter/nf_flow_table_offload.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 4365859220e6..68654d243bae 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1279,6 +1279,15 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	if (!nf_flowtable_hw_offload(flowtable))
 		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
+	/* Flush this device's hw flows while the driver is still bound. The
+	 * second gc pass catches flows skipped due to pending offload work.
+	 */
+	if (cmd == FLOW_BLOCK_UNBIND) {
+		nf_flow_table_gc_cleanup(flowtable, dev);
+		nf_flow_table_gc_run(flowtable);
+		nf_flow_table_offload_flush(flowtable);
+	}
+
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
 						&extack);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.54.0

