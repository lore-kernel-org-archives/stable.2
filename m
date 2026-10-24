Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851133;
	b=jTkk1oKz1MPXVsUHfuAn7ZoZsYBZhcTTMr6j8mEKfYZ+4cwZ0nSgDFRMlK/SrQrwzs3v
	 NgnMs4e3cShQvv/5VSpljL226wHN44J83dbfWurFIu3n0MZEJvE5qncfnHZ1vC7wYQOFF
	 zDE5WDJtOAcQwkHVm0+1j/38C2mVZoAN11u5MNOsHgUrNQQJ9mMpjyupt9C0bWTemfWC/
	 SSFeGzIO++DLeZYINu3+CvBhTvttDD3ZlfTpZHY6hrv0stiGEtLqU+DbD4IT9qg8YuMLI
	 l3PPSIgd+qWJFTaXImd7EvZh4cBYz2nVVKDGYZE3PCoYzQhWni/LTTdVE4pmEX2/Q6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fekl11tBwawdd/BmEQbPpvlBnrXS8QII5cBTf8ZjO9g=;
	b=Wr9jdCbEQL6E3n0gRkx65aeTLzU8IE9YxY7YZTcLfyufkp5S+uJCmAF2oLaRoSclJFRq
	 vYwmfaM1/ZXBwZq5+9ghITmgwPyTiSrbu1ywKbt9ea4zjWCd35Hzk+I+7Cs4JM3TV0seT
	 SjqjZ19r7mG370CArolRDi+7+x/3E1MsglZZeVtglSg7m3sk9NUZJtEhBgmmuo4RjQpV3
	 r0syilaIzSvGziy0mRh1dx/1Ox3bu3BpPBxx/y0W5/SZkzCxsuHk+7pBtNziYpAvgIsfM
	 3uz7FxlhWULX0nN9WQqmjWomfdWaVrMJt4uXcEkE1FClnJZDhQ1VNzbm16vyHYmvdJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CbMAjeUv;
	arc=none smtp.remote-ip=74.125.229.139
Received: from mail-dl2-f11.google.com (mail-dl2-f11.google.com [74.125.229.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FF606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10FF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CbMAjeUv
Received: by mail-dl2-f11.google.com with SMTP id a92af1059eb24-149f2b3f25dso435513c88.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851132; x=1793455932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fekl11tBwawdd/BmEQbPpvlBnrXS8QII5cBTf8ZjO9g=;
        b=CbMAjeUv8mLxRWlFV3E81UbgTZC/jPRqfKMSb6jhRfex2aBdmTAqRLEADWP61n12tf
         P082awDR5IZxWNfJAPPof3lxgpl10HTNo8IKj4IbXk2fj0J0Hiq/e9Vy1huFiFyB+dqH
         vOiaO0StoX6zqsY4SuDSS03YH1oWl//uORRTSVpNu9bF+qMdG+VNt5a9yeXXADklvCxq
         wJY0xTx/ShXmoVz62NNJeKhpqEsENC2naa74MKxm20zXGdZ6tb9JlCFV6u4tYMcZ+XlZ
         bwXWUBAoqejzLvln4pbXSQVNdS0Ju6Jo66ZebS4M3TZSwNgmRKt6qGTQ88iQo7IRgFuM
         HGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851132; x=1793455932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fekl11tBwawdd/BmEQbPpvlBnrXS8QII5cBTf8ZjO9g=;
        b=0G1K7kn+lQslpznQnFBQk8xYUCtVztzYwpURdo0ZpSkju39xdRH6dzYxrKDKQq2NvN
         dnUAbaub4lBaG+GTNxIWsnCxfv+TcCsnCBSbxtox5mZASb7RXijX7zFyib/D77UVp885
         AZxesTF/7ItSpXO6Abvref8EUT2+P63WL704gFmhnPKExE/8VfeUn795EiQMs8JVzYSv
         F/ZlhzoMrVyT+bZ2bewUght6FdGFTIIpQoriBYfDdicmG2o35Ny1llDq9dZtgW4G4qFX
         +O5pxCitcxQ76oHFl8L1nRCI/OV2Cx9htv3+++O1zOk3Ipc+9yCzNmCcfiK5y9N5D3Jw
         ag1A==
X-Forwarded-Encrypted: i=1; AKwUvBy0xZg/4pSeDEquineZeZ5NSzIlRHBgumhVQ/CTQSPWQGxbqS7jzvtKhu2SZFkvvJRV1Fh2sls=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQnat4wd0NDnILfB9GQ1MP3sHyK9bM+KXiVKiEw09gL80B12ks
	9Y9mpxBoeB0YfrvkE4ZhoN9ccUPtBGRaxGOVMi8kNw8Vlriez6zLQxZ0
X-Gm-Gg: AYBFou0QVayoMb66tm5bWUWpE3/wiN+IYlUSG2P3n2CUMpxea34yX9Q91B62/bys8fL
	SUBBSQe97gf1F5zx6K6WmW8XjlYjnJ/Su9gFM0DE0tb+h7bA3uFdVkyn8jbCLU1OO3z2YcODYI/
	uAenZLoaGbubZpm6ooTS9H75yEaLl8JV47V5TyC1vwDGIL5AMDssmyqAgJGhday7DmCWk0E3awN
	eD3bA3ITcKf4l3ZAdoSW5jnQ8d+DBoH1U38LqfpF4tB8OX9Slv0B8lPdRrQ4IfSCCsHw7yZ1Khh
	xlaeWG3AMuHHUzosjodwXuf3TqphMni6TNa7ejJ1Saw92Zz7XZLt7KU3oBlbj4jOpSBIm7bgvGs
	DheP63/sdNquH3IKscmPmLBghbemHnHJXb81Qo5sCocH5z6vA0j3GZ4g0JhchuFZpvVSzLsSzFf
	8+fJyg4StCMKDyw55p71HugAfAn8x6KQdGLryT60mOoqTDXEIJHj1WfqoH4gyD+KU+/kR9C9YQi
	+JK9ovG/tYAcrfDj7BtiTXjEU0CAn91OueiSOnzNIjM4x0G9rvTW5nZacl7JHqdpNGlSnWgefWY
	EZXAARzLxoy3sj37bTFZZ/Ui
X-Received: by 2002:a05:701b:2419:b0:163:c5eb:d42f with SMTP id a92af1059eb24-199291058eemr2330907c88.5.1792851131840;
        Sat, 24 Oct 2026 07:12:11 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:6887:87ec:7e6f:2a79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm6366905c88.12.2026.10.24.07.12.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 07:12:11 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Sat, 24 Oct 2026 22:11:56 +0800
Message-Id: <20261024141157.59301-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261024141157.59301-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
 <20261024141157.59301-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..65be2a368325 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	return skb_checksum_help(skb);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

