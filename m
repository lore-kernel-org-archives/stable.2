Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103082;
	b=aBnAKSo5FM9iAc5jjAwGyIsMN2mGkCgmINyI1XcCYUsojtzStAkZIxPGIdm0faSoxP6q
	 Mi5Or813vBLyyMCvFLnD1USSDAZBokbFRlbTcijQObfxotSO+duDGertTxWGvs56WDjhH
	 8unZY7s5Dd8tfXjUG5yRLSk/xZH+plW0Za4LDuCxLJYLBjP/fJeZi9ZjzmnbL3n6wfkio
	 dvj9liba34vJR6CgSqi2SSyUQ5RD2xYP7MNYDgBKbdMKtzykdxbUG0in4GavOQkXEsD3S
	 CraPjtVpyWlY1k8ImY8Y7bHkUtND4l7pY4cOE7hNrjRCZdKoUt4IylvUGl4fTL0in9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103082;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:Received:DKIM-Signature;
	bh=DLDJ75XjjsCibz0EL53P9TCwyCWQcLlHNaoZbM5HS5s=;
	b=tWDUI/0GmHwcdncVcX+b9taScGUu9aKNxaIPQcX5AmDLQD6TLtxPBIo+Pwv93qpJubA+
	 wbcTAaKcLc58TeY3ZSMkn2zjPSqZY9gDd3hBQ/lzsoW3IkTv9RV8yAWjR6TSH69RW059Q
	 7Gb8guIB/HwfgdvB1ZrYY1JgtoQdmhfcNTI7FMs7KiC8XKiMonQ1NnaG6zuYV/tbA45vT
	 hJqhw8Mb0J59IK+M11wqWalwvy0BpxIXXq6x4J1lNvYUtKWzlIjXg8XCU+2KttQg/Kl7q
	 ByBmupOHerRWiciI7NHMYJHQ1QfGjwbCQ5GHoRV8W8qzRd27FKDVtPzZ0NTCZeyFuFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=QJFnOsSq;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78490606A31F;
	Tue, 27 Oct 2026 12:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78490606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=QJFnOsSq
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sinfo@kernel.org, chris.snook@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: atl1c: free the RX buffer when the descriptor
 reports an error
Date: Tue, 27 Oct 2026 13:11:18 +0100
Message-ID: <179310307892.17409.740717153893027262@rimpianto.com>
In-Reply-To: <179310301440.3327.713112000658731384@kernel.org>
References: <20261027115156.17128-1-federico@rimpianto.com>
 <179310301440.3327.713112000658731384@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 3E2F3573-DDCD-4D4E-8324-17F91AE33D9C.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 27 Oct 2026 13:11:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=MIME-Version: Content-Transfer-Encoding: Content-Type: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1793103079;
 bh=DLDJ75XjjsCibz0EL53P9TCwyCWQcLlHNaoZbM5HS5s=;
 b=QJFnOsSq5GWQuU6Rl8xE7BwRmXlAaBsHSE/BmYxEiaRoKmzclTExRtd7lYj4GOEMkwl7JxbYF
 9PDu9vmwdMeI7N5HPTiUO6v3sZka+HV2TWjTKnVOGbhnTUjfzA7eF8WXW61gmZK6tOa4zC44vgp
 hr7mXZ44loaSwuyKdvVBk11p1Ux7RYVUaRJzCLORYDAVmVSqvStVU9CF6q0aCu01dR/AQmHcyaj
 o+wULNzPD+G9EmIUkyT0BTJLbdMBgDI0u0CcG4cpLnceNLCGLRsBh3ksAEpGa1LVIiKHGNraMMQ
 5IvD0+fXpUOxi4CnJKjhFGjR4R77/rQpOAXfo/NdWLAg==

The leak was found by inspection, not by triggering it.

While reviewing a separate change in the same function - the oversized-RX
drop, which removes an skb_over_panic that I did hit on this hardware - the
review pointed at this branch: atl1c_clean_rfd() clears the skb pointer
without unmapping or freeing, so every frame carrying RRS_RX_ERR_SUM or
RRS_802_3_LEN_ERR leaks one skb and one DMA mapping.  I have not reproduced
the leak with an injected error stream, so the change is untested beyond
compiling and applying: it only moves the unmap/free that the good path
already performs to before the RFD is recycled.

Hardware the driver work is done on: MikroTik CCR2004-1G-2XS-PCIe (4x
AR8151) in a Proxmox VE 9.2 host, kernel 7.0.14, atl1c built out of tree
with DKMS.  On that box the hardware error counters do move
(rx_len_err/rx_crc_err) when the link partner sends frames the host MTU
cannot take, which is how this branch gets reached in practice; I did not
isolate the leak itself on it.

If there is a deterministic way to force error descriptors on this device -
a specific register write or a known-bad traffic pattern - I am happy to run
it and report what the counters and /proc/slabinfo do.

Federico
