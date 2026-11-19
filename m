Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097070;
	b=EOutLXvy2hM/zSb9e10KfE7swkx9i5Q4uMz6xLfhJKdb4Kylq62yJUYy0oTyq8jlGfId
	 PbditCbtAjhcGLuyHuOvRWUa2LMMcPuxIHo7+eRkunCg+LuUEwvZzGTnNvdNNXi5a66UA
	 eoYD/QLRDAm/qia20ciLaJ+/ZtKi4OKaJNIk71WNhWcLqq1S0K7sH8lrsGvURFU3Vxk/r
	 skeUyBN7+hQv00UgIH48KNUE0Q0B+gXeq3iULJj7uz5QNDsvLbZ3r0puAMQfNBkiyyx1J
	 g/V8DAqh0NI603AfUw70Hi35mwIQbrXANJ8H6LQ9QIfUwfg2ExmYrA0gXwEVXTa3wDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097070;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=xYY+5HYcpNDrOfdei6j2b8H2Y6Y1Y5HfYq8ATs9GwvY=;
	b=4pjREa/uN13o2RkHh98KM5WZebl8mXTn891eUZh3pqEZnBA8qXLSKU4F6IEnX6QbvFZg
	 4OsiGFvY9A2FwurYzCk4UKd3LLuYE+lsL6tMMiJalby9RByuh9HHV43AvDZQsrMf8Woxn
	 8B77OsfaEzrvvRI84K61HsJ1I/T/B/efDMPbMVuEKtLcct+44leVfACUw4oljvY08vj4H
	 lizXZRkhYWJxq9F9aBMfF3gZd6DJzTl2Sl18NdiRoJizBgpLSGJTlBauiLrieycwouszN
	 u87g36v+0lAFJhvZIer5T9GmbervOnq1QsQ30T/x9I9ZPBa4BGRRCrl57cgtPr32pOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=MOBe5Kq+;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85760A2607;
	Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C85760A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=MOBe5Kq+
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jVgFH6qWZzFqsh;
	Thu, 19 Nov 2026 15:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795097059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYY+5HYcpNDrOfdei6j2b8H2Y6Y1Y5HfYq8ATs9GwvY=;
	b=MOBe5Kq+9i67JBIuH4JepPP8x9ydZ9f+9oenk5G9dddPi/wLCoTf7EzLwBnp9iLdeBOOU6
	sFvP3Yrv9lz71QhKDuxrdx94QZOsfERRjzOuWC5oCmJXj46sxz3bTaavHYl8UU+QYDpQH/
	xCikJ6XUxYRyFTAAubWmUaUfDweOjFxpzbjV24CzPR3DC062qYiznuj0kGOGeutVjbf/g1
	NRJuqc6hPUnvE8zcRiPJ0M2/8XRok5RU0izhNw+Y5rikPo0pIXoh7ncs+y8JL9JZEtm6Ko
	8hGNNiB+mmesCNbZBTA8XvVXnTHoZNQNN0FObx0z/CT/SA6RjvEBJAeimpOnwg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/4] igb: don't disable rings that don't exist when disabling an XSK pool
Date: Thu, 19 Nov 2026 15:04:07 +0100
Message-ID: <20261119140412.163202-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jVgFH6qWZzFqsh

xsk_get_pool_from_qid() checks the queue id against the stack's real
queue counts, which can be higher than the number of rings the device
has, e.g. after igb falls back from MSI-X to MSI on resume. Disabling
the pool of such a queue then passes a NULL ring to
igb_txrx_ring_disable().

Only disable and re-enable the rings the device has, as
igb_xsk_pool_enable() and igb_xsk_wakeup() already check.

Compile-tested only: the XSK pool path isn't reachable with the QEMU
82576 setup used for the rest of the series.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v3: new patch.

 drivers/net/ethernet/intel/igb/igb_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b5..8ed82bb 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
 		return -EINVAL;
 
 	rx_ring = adapter->rx_ring[qid];
-	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	/* The stack can know more queues than the device has, e.g. after a
+	 * fallback to fewer queues on resume: skip the rings it doesn't have.
+	 */
+	if_running = netif_running(adapter->netdev) &&
+		     igb_xdp_is_enabled(adapter) &&
+		     qid < adapter->num_rx_queues;
 	if (if_running)
 		igb_txrx_ring_disable(adapter, qid);
 
-- 
2.56.1

