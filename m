Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91822370A;
	Thu,  3 Sep 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434022; cv=none; b=LFuIR4lajEojfCIpFgy27khbdThYln0iibVTKDc/msRigkOVLQKZAHi+bhfPe+QnGP3rIokOGsEMgGbzFFDMk7cnoUCgDMQJrfvDb42EVoSl3HwzFtLRSS/Qzs8zT/bQgshgQLtggGOj31mnEPCTVZYEx44m6MFgzcr763PULTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434022; c=relaxed/simple;
	bh=hnkO0ad81/cmvkTj7LCgLnvnVWCyzJAabKPXcrfdrqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0D2YQhYR8OiWG5BWGuVj3TnQNcj4yfFuZxdTAK9b1tNmsTNU/fVoeiTpzjoIyz7kb2/1O6VAEAHIzEVzBtSrV0wYQsEGwuHo4AekDW4aq/ba/0ukO4aZ+dxCttdAqx7DOUSFvbjd9u0tzQWrj/qpDnYwA1dWI4qr6bDdUobxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hn/1ovz1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hn/1ovz1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39200165C;
	Thu,  3 Sep 2026 04:13:36 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42FC83F7D8;
	Thu,  3 Sep 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788434020; bh=hnkO0ad81/cmvkTj7LCgLnvnVWCyzJAabKPXcrfdrqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hn/1ovz1YQJGcm+gPG2vHhsAFvftXp3flnVdklDE2yE4TexJc7psXl72MIWZbWs70
	 V2Thjv7U3ih1dYTYKFMQk3xFwkcS6nhL3RERw8PX1metPFj67lPYBv85xOnyP0GD6D
	 Gfb2BiWhOjWlO3Uup2n4wtl5ljOioWmvA21+OR3A=
From: Christian Loehle <christian.loehle@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: breno Leitao <leitao@debian.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mailbox: pcc: Free the channel before unmapping the shared memory
Date: Thu,  3 Sep 2026 12:13:27 +0100
Message-Id: <20260903111328.805352-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903111328.805352-1-christian.loehle@arm.com>
References: <20260903111328.805352-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

I am seeing a crash on PCC that is related to a an shared memory being
unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
unmapped (NULL) address. This is a summary of what I see on my box:

	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
	 __handle_irq_event_percpu+0x1c4/0x9e0
	 handle_irq_event+0x98/0x218
	 handle_fasteoi_irq+0x230/0x750
	 generic_handle_domain_irq+0xac/0x138
	 gic_handle_irq+0x344/0x740
	 call_on_irq_stack+0x30/0x48

The trapping store is iowrite32(SCMI_SHMEM_FLAG_INTR_ENABLED,
&shmem->header.flags), a write of 1 at offset 4 of a NULL base.

But, back to the problem, pcc_mbox_free_channel() unmaps the shared
memory and clears pchan->chan.shmem *before* freeing the IRQ (aka
calling mbox_free_channel()).

The interrupt is still live when the mapping goes away.

Free the channel first, before the memory unmap. mbox_free_channel()
calls pcc_shutdown(), which frees the platform interrupt, and then unmap
shared memory.

Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/mailbox/pcc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9888dab64639..db30812c5051 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -438,12 +438,13 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 		return;
 	pchan_info = chan->con_priv;
 	pcc_mbox_chan = &pchan_info->chan;
+
+	mbox_free_channel(chan);
+
 	if (pcc_mbox_chan->shmem) {
 		iounmap(pcc_mbox_chan->shmem);
 		pcc_mbox_chan->shmem = NULL;
 	}
-
-	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-- 
2.34.1

