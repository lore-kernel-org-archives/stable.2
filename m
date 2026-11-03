Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744599;
	b=Lz8kKfbvlUj5hISjpOy5azqkdLhvCXNCHw7hzmSOeH/hzNllgbXe0/2AtE3ZVb6K2tZb
	 aD1Or0QLYlScAx5eYXaGX/2My+1fiXBvPNzC4bqmHK0vfv3RimtwT78dg7H8U+XcijfqD
	 DfzG0IseQwSIEhNdsG8YLSJyAQxDiVQnoCTxgmUo6bitxlpXwEDTs29N98rEfK7U9fmVm
	 Kh8CXqGK6YHwaxZ3qx/72RZ/adSLmjjyumZnFzpkvmbNM2v/I+SgrpuwMlEf9+5KFSlKH
	 8uMTNNPpifhiASVFHOsZOQhThCz1i0hH6sH7FxKWBBMadc1K1PRlBwpmgUR6VdOXUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
	b=OVeaf4EtdV5aIl9HKaQywLi/q28AMqir0NEWjFJFb7Mqh3nc8x/5O+lmkRzrqNnhKfr8
	 nmDFcmokOnbxOfPOfIlPXNzzBI1XoQ7oAkbpOGYmqkrblZBJcl0tiFplcOaY7isHS99RJ
	 78Ib+/a5aSvCvwQsXkJ3sbQ3dLLEcK/HjIZk6dA0GnL9idg/nqVxgNnIeJ6DjI8rnfIoc
	 nXMSCVZQDLcYJS+0GZE4j1agfnwK8qz9TgDBNnsKci89bFVYx6bKmCYhgtZ0oPr80euQK
	 eanP6JgNl7o6AiZ9MfkKlVQBezJKDcct5cD6mnujrqJZKug05XS7RMzAQbwcq9NGNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1a4sCHR;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906B606D830
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5906B606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1a4sCHR
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so57418f8f.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744598; x=1794349398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
        b=c1a4sCHRs1R+HVGA0+smgfHw8U77MLHfiDhHaSSDZM0rMyYJM6NJ7y/aLc9PMYvMVE
         aEImCURBIakHt1zdqXNFUDlV84a+zq9LpoM/Ew4Ftv/eOqVx8RM3fsncbkztSwk0HToa
         qmHe5uB8FlQrv3tM9B0mYp9yro7N2iJaDYVtBUcGeFYvnatIZpoz4H7ofchRtbc1FeQ6
         HmUTIn4o6jUP2sEpSnVxWb4t8Bynx1S+XGYDDBPYxgJN8MIenxD88qEmzlw2EgKYjbrH
         J8ntbQ+3vS64o+r+cxZC3TgvBHdZ620m577ridfNOYiwXfFxvLYn0iqRsn6swLbP0Q0m
         RuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744598; x=1794349398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGr4yuTjefH8ZNfeidLmCflxZz4RxW5d0w05fPgAcqY=;
        b=XxZw/45o80bZh437qprxqsbpZKEQCEwfbwl8elD2rnFlcoykN2zx5uINaHnS6twELy
         1S6UOBPt/Dy21I6z0cBexIBb0SUVgZqGJCY6J3ZfpvpbGgqkOOmUUzy/vigK14J8EgeF
         IwQ+wVUWfAN5Yb7RhEEYYncvtwbiUl6gbGwZ3VtcU6mkHzpfU6VP4/iqWbzM3runRa5I
         tRAJGKmAz1sk7KJMKiaOqhW5qy0FYsNyUFLRVE42bQOM6exb+Q3o4SB/jvKPvMCLWfFo
         eKQmFE/emWTSko009Np7xt98QN+3G8EVwsx5hYqiDcIt9waM9Hm5vBayTvqmNOuaxtAm
         aq9g==
X-Forwarded-Encrypted: i=1; AKwUvBywLgKAaicB0OkOBoFds8sKut+5renRfcsazvbCLrcZIeJuOigdO/kCa+QYgduf+nFP9fgwlqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UmpXgCUIMQm7UC5P3R9ZCAXH3eVA76KNyFtuoUn+YbR7cpIRj
	IogIG3ublCh2DhTgCEydXDPWvlDvcThyTQiswLliFp6o/fDE2g+K0E8=
X-Gm-Gg: AYBFou37DQrZm4igrIqURk770Knt/dqnp4Y4HMh3FVTAZ+UBreUwn+Yc/pM87mQAhqt
	CFgzkiIk2BtmgxpDugUO9cVNlpuV5TVIOloVjUV//B1DAdm3uGqif8xzBe0UhcHDjmk14rVDW/x
	gmkvd3fgSky5wkAPmVpv75F2D3OInyudxIzfcG12eEZ3RpUJExCKgg8GZeLxHqwYeskZx6lK6zp
	EfGdLAm+jZjZyQ3j9OjWy179jY0V551HSxbWjORmTNxIWpZJem/x2DZYdFk2Z89EL5edb0yFyU9
	WiubcDQONq+yMumsyDLK3oF9xhz8APjSuSqFzxB3Bl8PWbo6HSXb1UplPUHCo4Yv9SyafM/jftS
	KtFdqA7B6SK968gj07+aVP65dROJGq9uGpabqxZ/8JQ0yHB66u3fq6ultvuY2YnWKxF7eWWpcMG
	ft5KsSzb7i1BbRcqxW/JKA2J3VtkMBc8xHZWUeH3EPH7YvJAs5FIz0k8HVCp2WSmqMcinh7Ng4c
	zEPjWqKQsOhzg+ksRBY+0qULoS0RaDJHJ7GopETrmBYeyysHqoeH6kO/AJ8af8W8UAidwsm8BqN
	M9moBb2vVNvzlBbGaQd4CHI7jEclVPtOkRSpZOPAzoEX6PJHMcL7q289Kw==
X-Received: by 2002:a05:6000:26c5:b0:48b:e50:714e with SMTP id ffacd0b85a97d-48e6e50d8a5mr30353676f8f.36.1793744597651;
        Tue, 03 Nov 2026 14:23:17 -0800 (PST)
Received: from ps42.lan.pis.avalls.dev ([2a0c:5a83:540e:7d02::ed7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed551dc5sm279312f8f.34.2026.11.03.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:23:17 -0800 (PST)
From: Arnau Valls <vallsfustearnau@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Arnau Valls <vallsfustearnau@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: remove hw flows before unbinding the flow block
Date: Tue,  3 Nov 2026 23:22:43 +0100
Message-ID: <20261103222243.445644-1-vallsfustearnau@gmail.com>
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

