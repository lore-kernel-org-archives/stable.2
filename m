Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114E237180;
	Sun,  2 Aug 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685612; cv=none; b=qUHq4Nlp+kqbCqbviax1tpNdNBlQHjvL5EASw098k+WDHor+vPGLqhlXD54WrUytGr+fxHEj5SbPdRjZRxoioSiIlrCVp2auMoPeeOIeFyr9rPB7LB94tNRCahrrVQWuqd5oL84c80T2e77G8eaNwIK/HlwzEtJLxLFyePEi2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685612; c=relaxed/simple;
	bh=IfrwjOpzPnpV9Q+Tru6a26fgTY45Egp/KC1PG3FiSs0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J7orzNbVci+x5Y+dHFm9bYT10KJ4OKUewgEUqTn4XTLeoRkA5TuMmwbsYb4suRSHo2p2M3d53MXZIVxHJz/YJ3PmHl98fabuImTTXyttIC9k2K/Gbpcs/cP5VAWSDdz8/8DPWQ+H6GAsBZ8TqWX1gQAurNEyFaEYw2Ej4t+TXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tZ48CzR0; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tZ48CzR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785685604; bh=J4VqWLfvWNBX30FARDgxlRiuvqFbIs6GXH5ot/8285s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tZ48CzR0S8U1Ex6XrH5R9lrA5dKl4bytBCDo4XMR2R04lPslSe41JZFs/cb+jZc/b
	 DDMT8OsB77X+m3rL3ut12+jC71Cxa1PAxCusEgApvJJSesfKskDkRGJRmpkHNCy5ok
	 +ggWZDt8rjj7a93OEmvqX27CI/KJJH/k86m0yYZs=
Received: from halo.lan ([240e:379:2238:cc00:262b:8ebc:c000:80a0])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id BA820436; Sun, 02 Aug 2026 23:46:40 +0800
X-QQ-mid: xmsmtpt1785685600t8z39glaz
Message-ID: <tencent_607CBA8237DA438E36B844318B21538DE008@qq.com>
X-QQ-XMAILINFO: MIB/1UGyXKa7T8S0WAGwz5545nqgzT3DySR5JVCmudQCDCEhls3oawacPvze7B
	 1UD2Y0+5Gt/t3gUSK7PRsE2XkvL2JSIk7AuVmI0WjKYFhAZ4U7DVhhLa6OTSvS4bB+97kmOvzmGS
	 oCItJTU5/m0/vuz4DRmuDvKD0YkNrRu9XGEs20w5eV64aZclAIQAGVln62rHk1G4wteZMW1aSlqL
	 OoSsC84tO3SWltdhpfJsToUvKkLbxhgrAlf8K4jErE52MnRnMPWsYWt5MrH+okgvHOyLrKAHGCcf
	 t22s8rtDxaGCaLcXK6s3mZ764U9REXO/9E/0mT/8H4jjDnilk8Oomm5D8pqJqMnPoPP2Z36dwknp
	 ChVqiRO9hMxsX2Nt2v9SZ36iPr7yaU1unT9oX4EiRGN9+wkxmsSChd9xOH5s6Suj3zHaVwUuRful
	 LwEk4haMuJTfz6kf4lqEAsAeG89gKlm/iDT0mfj2rz0E9i1PKGt5cPN2ENNGCKGrmODWpoBNL2Lx
	 8fNys0wx3heCoOvWVToORWzcbwy/G/PZc3IAos/Z6qhYmC4ZRfZoz9lc4DF+l7Q/cHxbE3nLYDUJ
	 QP3MI2GvkMOVvhvNjm8ziFIl35mJ/Ae5iQRMYRNjxGnKJp1wJLbqU/kXWz7T3d+wMaeh5VxxBMVk
	 rw0Xm06nAWlnBL6snbxyjiUmNxDW3Xq7ConHyVLF1NsGTIXfL3tGcPE4niDDNv0irMiEDsTx2u/6
	 WE92GxSG+9j07d81uDyloPF4X5E9K7EjQvCt0Gyh7S4FFYbN0VM5JdTKXA09xGhN8pHer0qFFxqH
	 Mh1OkMtM1bC004Op3sELeyR0IEGiKY0FjIfRsY6kJ08zGyvCvqwgL2f65gIdg+M4C/IWeYJSeJnG
	 b56GYpIrrY3iDMMfRWcQ1Zo3Cofg3mTPljucXyjzr2RQpqx+/NY40+pJwFk3SilxKusRaSTCCcJP
	 K3elLgB+D274qcoKu4fwxy6ZQnkLV0thDWl/jU7IhDx0ozJP9JPNVGbrupnKVlddxbRsrARbs23Q
	 skmfgiOcWe/be+Pg98K7Od4WydbJq34u+UJUdU1ccO0Gxq8/b1KzdH3NsmCdxj2c1unitAgnORou
	 BSkR9xp1gV0N/HVJ9g3WKa5Oj997QQCGxlzT77vNtU1mrqZwGtNqzJ3sKPuQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net 2/2] net: atlantic: free RX pages of consumed but not refilled buffers
Date: Sun,  2 Aug 2026 23:46:38 +0800
X-OQ-MSGID: <20260802154638.40342-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aq_ring_rx_deinit() only walks [sw_head, sw_tail), the region posted to
hardware. Since the page reuse strategy was added, a cleaned RX buffer
keeps its page (and its DMA mapping) in the ring for reuse, and refill
is batched: aq_ring_rx_fill() returns early until AQ_CFG_RX_REFILL_THRES
slots are free. Slots that were consumed but not yet reposted therefore
sit in the complementary [sw_tail, sw_head) gap with a live page, and
the deinit walk never visits them: up to a refill batch worth of pages
and DMA mappings leak on every interface down.

Walk the whole ring instead and release whatever is still there. Also
bail out if the buffer ring is already gone: a partial
aq_ptp_ring_alloc() failure frees the ring but leaves aq_nic set, so
aq_ptp_ring_deinit() still gets here on the unwind path.

Fixes: 46f4c29d9de6 ("net: aquantia: optimize rx performance by page reuse strategy")
Cc: stable@vger.kernel.org # v5.2+
Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    Without this fix, the page_pool conversion posted for net-next turns the missed
    pages into fragments that page_pool_destroy() waits for forever.
    Reproduced on an AQC100 with the conversion applied and this fix
    reverted -- ordinary small received frames (<= 256 byte header-only
    packets, e.g. ping replies or pure TCP ACKs) are enough to populate
    the [sw_tail, sw_head) gap:
    
      ping -c 200 -i 0.005 <peer>%enp99s0
      ip link set enp99s0 down
    
    One short ping flow left three of the eight RX rings' pools with
    stranded fragments, and page_pool_release_retry() warns for each of
    them every 60 seconds, indefinitely:
    
      [278084.929092] page_pool_release_retry() stalled pool shutdown: id 123, 1 inflight 60 sec
      [278084.961064] page_pool_release_retry() stalled pool shutdown: id 126, 1 inflight 60 sec
      [278084.961087] page_pool_release_retry() stalled pool shutdown: id 125, 6 inflight 60 sec
      [278145.346737] page_pool_release_retry() stalled pool shutdown: id 123, 1 inflight 120 sec
      [278145.378745] page_pool_release_retry() stalled pool shutdown: id 125, 6 inflight 120 sec
      [278145.378759] page_pool_release_retry() stalled pool shutdown: id 126, 1 inflight 120 sec
    
    With this patch the whole ring is walked at deinit, the pages are
    released, and the pools drain immediately. On the current code the
    same gap leaks the pages and their DMA mappings silently.
    
    Applies and was build- and runtime-tested independently of the
    page_pool conversion, against the current page reuse scheme.

 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 81685a4dc5a6..e1193c6719d9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -950,15 +950,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
 
 void aq_ring_rx_deinit(struct aq_ring_s *self)
 {
-	if (!self)
+	unsigned int i;
+
+	if (!self || !self->buff_ring)
 		return;
 
-	for (; self->sw_head != self->sw_tail;
-		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
-		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+	/* Release every page still owned by the ring.
+	 *
+	 * Walking [sw_head, sw_tail) is not enough: refill is batched
+	 * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots),
+	 * so slots that were cleaned but not yet reposted accumulate in the
+	 * [sw_tail, sw_head) gap, and they keep their page for reuse. Walk
+	 * the whole ring and release whatever is left.
+	 */
+	for (i = 0; i < self->size; i++) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[i];
+
+		if (!buff->rxdata.page)
+			continue;
 
 		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
 	}
+
+	self->sw_head = self->sw_tail;
 }
 
 void aq_ring_free(struct aq_ring_s *self)
-- 
2.47.3

