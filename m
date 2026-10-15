Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931C3B3880;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035001; cv=none; b=EeT/FLB235g0I2ax4ko+D0zl0VczWSPdHXP8U8zpr0cr9f2eJHOf9RAsAfeeiPgL+zUSQP61YbEiTfAAN3AIpXyLhn5vOlBn7BIspeUYoezolGanbeUUTMM4N4gGE4eMI4igngP6eQZ94WaO38wchBltxTJ3B5DQDAmI6WmO4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035001; c=relaxed/simple;
	bh=IBuh8V/uOu8n3l2k9h8iBPBCSdskQXtHgw9YykzfWQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FBwX1DV9EuHZvZBsyTDWnbIcTAk+MaTVFt8P7FI6F5trcJbl2iy/h2vzsGuT+JKNlJvAUi5ne6XZQc4g8GthEfXVxcRrRKczQp/uofi3AmHcnaH9Pi2w48MaoGFa/anA9P3SQqkgSiB4tdLULSwjhQJ295yX4EsrEJP/csxs2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZtrfBkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZtrfBkP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F614C2BCC7;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792035001;
	bh=IBuh8V/uOu8n3l2k9h8iBPBCSdskQXtHgw9YykzfWQ0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MZtrfBkPUjVWy0OyGtvQEJ0qpgbxQEFc669XVybZ4kRKWzgNrYe/763e3Svrt4tMN
	 XSs2/94YE29XfdPqB6BPyDWGUTDAe44qKaflRVYDviGBYKnLVDbS5I8P/QceJsIEdP
	 WVmmfur4TkjjgAyFU2jqd/bCCkVYU7MEj9BMIMWaPbZgJk2NQMtRFyWjQRiELtZXUD
	 8HiIBqdsboPP0rnOglyPTCFuToXtP23zZjrRieg/WwO974pF/JYTYsAS+vzJdlzRwY
	 aymVgkjCERr1H3qTBjONZ+54xhPnUzxKNVT5fJrhmtRK2YfjnSVV316rqw8QfUQuoW
	 qrd++QcZ8B4XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF7CC6B2A;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] serial: tegra: fix RX/TX DMA descriptor
 use-after-free
Date: Wed, 14 Oct 2026 23:29:59 -0400
Message-Id: <20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2irVPQr4iHaqAE3WhVB/LvV4
 8DM3BDYCweokhs8nxJkXSKYNIFupGVgFBcZjDJWK53j59OEOw+e0M2EB/WYleysKZSm1kJMN8+
 9XP+2bp7nBbKP2WpmAAAA
X-Change-ID: 20261014-serial-tegra-dma-uaf-39ed62701ab6
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Austin Schlegel <austin.schlegel@arthrex.com>, 
 Austin Schlegel <schlegelas@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792035000; l=2548;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=IBuh8V/uOu8n3l2k9h8iBPBCSdskQXtHgw9YykzfWQ0=;
 b=tq2kzMb86aNh7fEUjolwDWbAM6s80eKTE+KUQmtkedKBxM5OpkDMBwNKxaSzeGoEHV+gwoAsx
 WI6Gr3QFfqsCOl1TwHjBCM9B+6zbsbFFtdM3NNbGfOkVtslxOFBcaJk
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com

Both patches in this series fix the same bug pattern in
drivers/tty/serial/serial-tegra.c: dmaengine_terminate_all() is called
before async_tx_ack() on the DMA descriptor it just terminated. With
the GPC DMA driver (tegra186-gpc-dma.c, used on Tegra194/Tegra234),
terminating a channel frees the active descriptor synchronously via
vchan_dma_desc_free_list(), so the subsequent ack touches freed
memory. dmaengine clients are not allowed to touch a descriptor once
it has been terminated.

Patch 1/2 (RX) was found via a KFENCE use-after-free report on a
Jetson AGX Orin (Tegra234) under UART loopback traffic, and the fix
has since been soak tested for 24+ hours with
kfence.sample_interval=1 with zero further reports. It keeps the
descriptor-leak fix from commit b31245b94207 ("serial: tegra: ack
the rx dma desc after transfer terminated") intact: the ack still
happens for every terminated RX transfer, just before the descriptor
is freed instead of after.

Patch 2/2 (TX) is the same ordering bug in the analogous TX path
(tegra_uart_stop_tx()), present since the driver was added, and found
by code inspection once the RX bug was understood. It has not been
reproduced on hardware - triggering it requires stopping an in-flight
TX DMA transfer at the right moment, which did not occur during RX
testing - but it is the identical dmaengine_terminate_all()-then-ack
pattern in the same driver against the same DMA engine, so I'm sending
it alongside the RX fix rather than leaving it unfixed.

Testing was done on Tegra234 (Jetson AGX Orin) only.

Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
Changes in v2:
- Commit message updates only; no code changes.
- Patch 1: removed an inaccurate statement that the freed descriptor
  is accessed in tegra_uart_rx_dma_complete(); updated the soak test
  duration to 24+ hours.
- Patch 2: removed an inaccurate flush example; added Fixes: tag.
- Switched to my personal email address (v1 was sent from
  austin.schlegel@arthrex.com).
- Link to v1: https://lore.kernel.org/r/20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com

---
Austin Schlegel (2):
      serial: tegra: fix RX DMA descriptor use-after-free
      serial: tegra: fix TX DMA descriptor use-after-free

 drivers/tty/serial/serial-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261014-serial-tegra-dma-uaf-39ed62701ab6

Best regards,
-- 
Austin Schlegel <schlegelas@outlook.com>


