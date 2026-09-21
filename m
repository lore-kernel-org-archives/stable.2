Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EA463B64;
	Mon, 21 Sep 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982206; cv=none; b=W4/OlRD8ptTMekBHXPvM49lc3quqDy+oYhH0lIHZX/EOUYa4783gLUC1TJRRDtaHeVP/N1hg2Hzf7fP5Et7ZH/QUkfguuEx+rm3cph7/gU7RcK93GiGen+Rs8Xq8xJr+iV42zJFN/XqlJ4Mp6einb8//SvTDLVdCXviYoAcZX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982206; c=relaxed/simple;
	bh=LrlCW6ZSpn7jlrkMta+IC8b986oVFIukC7vKvzTqBGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+rm83KwqWTTt+2J+aDbv9QG4iD4MM/eletxWSVFXeIh9MhrJwlzmkkBgkmur0Cub3sbj7vHZk/FASqdZ1l+Vw8ouriiTBtwY8EJyyBY97zbIrOiiQIfh0VKaEs7G8k5Pitb//VFsJ7loKYcdHSrJifUqMr/s3IQHI4M0zpJm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=Menizlu/; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="Menizlu/"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gatis Peisenieks <gatis@mikrotik.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] net: atl1c: fix soft lockup on out-of-range tpd_cons read
Date: Mon, 21 Sep 2026 11:13:32 +0200
Message-ID: <20260921091334.3571525-2-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921091334.3571525-1-tamas@rimpianto.com>
References: <20260921091334.3571525-1-tamas@rimpianto.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id C865C182-7EAA-4089-A7CF-1E4542A5B920.2
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 21 Sep 2026 11:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1789982130;
 bh=Ze/67RO3SOQ4dYO1vQK/iZ4AhCadGBDBt2xXkaGnH9o=;
 b=Menizlu/IWLINNVLIv9y7n7GU7dzZ8nMgOP/ro5sEgk73wf4Iy2WKvwSDruE86PNbceZONJir
 c2zOOhcs8KM+vNm3OYfpK/xby4kRDUw6uY7j5OQtwiRB3wnICLGE92stdAd+olYM0b2IDyxwGA/
 nTGRX6XQ9I2nftDwLNsAE1aG5yIbfkc6xy3aTEEWdGcaSY4PFFRw/3WdQ10URvKTQSekn3JoeDZ
 OtXvVkwVB4AKgA81XjEV371/HyKjou6ttXCVNHt/5uXuTfFGykOq++sCUB7TPwAnnB4SSdgaeE1
 URLoCU+NJak3yG/TAelWPcEhilSDzN9chAJhIFFreUhg==

The hardware can report an out-of-range tpd_cons (seen as 0xffff)
while the PCIe link/MAC is resetting. An out-of-range value can
never be reached and the loop below would spin forever. To avoid
a soft lockup treat it as "nothing new to clean" instead.

Reproduced on two machines, same NIC (Qualcomm Atheros AR8151 v2.0,
4-port), triggered by rebooting a Mikrotik CCR2004 PCIe card that
the ports are directly linked to:

- Ubuntu 26.04.1 LTS, kernel 7.0.0-31-generic. The link-flap
  precursor, before the lockup was captured with a full trace
  elsewhere:

    atl1c 0000:05:00.0 enp5s0f0: NETDEV WATCHDOG: CPU: 4: transmit queue 2 timed out 489984 ms
    atl1c 0000:05:00.0: MAC state machine can't be idle since disabled for 10ms second
    atl1c 0000:05:00.0: atl1c: enp5s0f0 NIC Link is Up<65535 Mbps Full Duplex>

  65535 (0xffff) here is the same value tpd_cons reads back once the
  loop below gets stuck.

- Proxmox VE, kernel 7.0.14-11-pve. Same NIC/trigger, this time
  caught by the soft lockup watchdog with a full stack trace:

    watchdog: BUG: soft lockup - CPU#12 stuck for 354s! [napi/eth%d-0:329]
    CPU: 12 UID: 0 PID: 329 Comm: napi/eth%d-0 Tainted: P O L 7.0.14-11-pve #1 PREEMPT(lazy)
    RIP: 0010:atl1c_clean_tx+0x142/0x2d0 [atl1c]
    Call Trace:
     <TASK>
     __napi_poll+0x32/0x1e0
     napi_threaded_poll_loop+0x286/0x2e0
     napi_threaded_poll+0xfd/0x140
     kthread+0xf7/0x130
     ret_from_fork+0x2da/0x3a0
     ret_from_fork_asm+0x1a/0x30
     </TASK>

Fixes: 43250ddd75a35d ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gajdos Tamás <tamas@rimpianto.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 7efa3fc257..e58f1d2c26 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1602,6 +1602,9 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
 	AT_READ_REGW(&adapter->hw, atl1c_qregs[tpd_ring->num].tpd_cons,
 		     &hw_next_to_clean);
 
+	if (unlikely(hw_next_to_clean >= tpd_ring->count))
+		hw_next_to_clean = next_to_clean;
+
 	while (next_to_clean != hw_next_to_clean) {
 		buffer_info = &tpd_ring->buffer_info[next_to_clean];
 		if (buffer_info->skb) {
-- 
2.53.0

