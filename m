Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970833F59A;
	Fri, 31 Jul 2026 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465979; cv=none; b=d/nizp1qTCZuEEGriigoudFCGY5eFx0lgBJeKorGJgn+U++lb74ajGzenfNpOXbbI3XL9jE4k1d0T5H8hv5CR8gPKuN8NUE9PbFSKiOt4+mgMmD0aDWP1sERNplb0w/cmm1H19g9xsCOB8Pq2HFTzvsNGPe1UIFyJ3CAEawHsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465979; c=relaxed/simple;
	bh=w0KlrMO9P/MJZBucv1ynNv1CArXsmfi4apzicOb3kB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XFQoPprH2VMKAsyH0xc56rKsKKziTRUEjeXxGP4cf56r7LZEZOYzD3aOyCj7tAP5tkHVzlcx5LF9KiNyUBeDxnhEvLS5I82vxB24dFKl8LywoYK27tXxekoZu8I53Rjxs9RRLpep2+GoGFlYNavT45cAc3LLlZXQtjbNQJ6noFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHGtQXDGxqViNSAA--.7644S3;
	Fri, 31 Jul 2026 10:44:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH9coXDGxq1EJjAw--.19349S2;
	Fri, 31 Jul 2026 10:44:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuniyu@google.com,
	christophe.ricard@gmail.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] nfc: st-nci: drain SE timers before NCI teardown
Date: Fri, 31 Jul 2026 02:43:42 +0000
Message-Id: <20260731024344.317793-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH9coXDGxq1EJjAw--.19349S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?QL9qwgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0gCzlebqh2Vq8BSwVe27bE5XDDVYGTb/X7qfj0EuaAm7OZ
	w1GPJhkomEWw1jVE3rSp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw43tr15Wr4DJF4xJw4fWFX_yoW8tr48p3
	ySg34fKFyktryIqanFvr47ZFWF9Fs5WFW7u34Ikry09r15KFyFkr9Yyr40vFWUC3s5G3y2
	9FZ8Jw1kWr4kJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7rcfUUUUU

This is v2 of the st-nci SE-timer use-after-free fix.  v1 was reviewed by
Simon Horman, who raised two concerns about draining the
timers while userspace operations may be in flight.  v2 resolves both and
is restructured as two patches so the drain runs behind an admission
barrier instead of before the device is unregistered.

1/2 adds the barrier pieces to the NFC core:
  - nfc_se_io() is the only secure-element entry point missing the
    dev->shutting_down check the other SE operations have; add it.
  - an optional nci_ops::pre_unregister hook, called in
    nci_unregister_device() after nfc_unregister_rfkill() (the barrier is
    up) and before nci_close_device()/destroy_workqueue() (the NCI core
    still exists).
  This follows the barrier-first teardown ordering from d2492688bb9f.

2/2 registers st_nci_se_deinit() as that hook so the two orphaned se_info
timers are drained after the barrier and before the NCI core is torn down.
It also completes an in-flight SE enable/disable and resolves a pending
APDU with -ENODEV, using bwi_active as an xchg() ownership token so the
callback fires exactly once.

The two patches are a pair: 2/2 assigns the pre_unregister hook that 1/2
adds to struct nci_ops, so 2/2 will not build without 1/2.  Please take
both, in order.

v1 handled operations pending at the drain, but a new SE I/O could install
callback state afterward; with the timer shut down and the PHY closed, that
context was never resolved.  The barrier added by 1/2 closes the window.

Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

v1: <20260722034729.3254078-1-fanwu01@zju.edu.cn>

Changes since v1:
  - restructure into this 2-patch series (admission barrier + hook drain)
    instead of a direct deinit call in st_nci_remove();
  - complete req_completion so an in-flight SE enable/disable holding the
    device lock is not left waiting (concern 1);
  - invoke the pending APDU callback with -ENODEV (concern 2);
  - bwi_active as an xchg() ownership token (callback exactly once);
  - Fixes: 8ae01f796771 (the orphaned deinit predates the rename).

Tested: builds as a 2-patch series on netdev/net (st-nci.ko, x86_64);
        applies cleanly in order.

