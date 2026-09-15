Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544034D90D;
	Tue, 15 Sep 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486749; cv=none; b=pXSOvuyavbz4znbDz5g9bYOHHhA7BcgK6lO9D7yzaqK3EsAJfxZPp9KxBl8lrbr8itaBzF/hRNBSo9CbsRveUJT27pttzFnOKQ/fDcIFcz4umNThaMbXxJV3LCxOvdt50sSQSB0P8tk1oPfKmPeeOg5pyICCQKHgqvcNvVe/FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486749; c=relaxed/simple;
	bh=sK1U2pcBRXSUG4hPLCv+k6RdkddJEp/+87Nhj5sEvK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EAATa7DnW9ShnXTTETfuGxzXdcAtPWcEdjRdnH8IWay1I5fCbF487D4I0uIklmLGHdjv+0pgasHMHUHIWexhoQocSDpry+D9fJtYlDQA7dAfGn/ezVAiEMvkMH1MY30y2qzruHDhl4iIwAyHnWf8nYF+ALOmYUd7V+clCDb01Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=l4KoP7F1; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="l4KoP7F1"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ddda0bb6;
	Tue, 15 Sep 2026 23:38:57 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bruce.w.allan@intel.com,
	jgarzik@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net v2] e1000e: roll back registered MSI-X IRQs on failure
Date: Tue, 15 Sep 2026 23:38:50 +0800
Message-Id: <20260915153850.1704903-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a5b8aa0b03a1kunmde9de9ca2e1844
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhpCVkkaSxgaSkpPGUweH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=l4KoP7F1ccZ19J9s9emNvOtdcSGqFZ0nySjWd4Axv+n8q/+epu5SUdlj8eLSOMI9y0H2LLDeIb0TvP1+GT4MwrN0lw5krh9nTY+TvHkTM/6AxeKqXcolZNN/PiGr+kPsc6FJUEKeXz0S8pDBQP5/tKrUMD4DcdnA+nnEMB9fbWo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=rmJRg/Am0hi7AntLZKSZ2ty+PuBbNEcVd9oFLNxQpA0=;
	h=date:mime-version:subject:message-id:from;

e1000_request_msix() requests the RX, TX, and other-cause interrupt
handlers sequentially. If a later request_irq() fails, the function
returns without releasing handlers that were registered earlier. The
caller then disables MSI-X and falls back to MSI or legacy interrupts,
leaving those handlers registered against disabled MSI-X vectors.

Free all handlers registered before the failing request in reverse order
before returning the error. The failed vector is not freed, and the
existing fallback path can then disable MSI-X without retaining stale
handlers.

This can be reproduced with a QEMU e1000e device and a kernel built with
CONFIG_E1000E=y, CONFIG_FAULT_INJECTION=y, CONFIG_FAILSLAB=y,
CONFIG_FAULT_INJECTION_DEBUG_FS=y,
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y, and CONFIG_KALLSYMS_ALL=y.
Start QEMU with an e1000e device, for example using the
-device e1000e option, then run the following commands as root inside
the guest. Replace <e1000e-iface> with the actual interface name, such
as enp0s3:

    mount -t debugfs none /sys/kernel/debug
    ip link set <e1000e-iface> down
    failslab=/sys/kernel/debug/failslab
    req=$(awk '$3 == "request_threaded_irq" { print $1; exit }' \
        /proc/kallsyms)
    req_end=$(printf '%x' $((0x$req + 0x2000)))
    echo N > "$failslab/ignore-gfp-wait"
    echo 0 > "$failslab/probability"
    echo 0 > "$failslab/interval"
    echo 0 > "$failslab/times"
    echo 32 > "$failslab/stacktrace-depth"
    echo "0x$req" > "$failslab/require-start"
    echo "0x$req_end" > "$failslab/require-end"
    echo 3 > "$failslab/interval"
    echo 1 > "$failslab/times"
    echo 100 > "$failslab/probability"
    echo 2 > "$failslab/verbose"
    ip link set <e1000e-iface> up
    dmesg | grep -E 'remove_proc_entry|WARNING: fs/proc/generic.c'

The third qualifying allocation in request_threaded_irq() then fails,
after the RX and TX handlers have been installed. On an unfixed kernel,
the last command reports a warning such as:

    remove_proc_entry: removing non-empty directory 'irq/<n>'
    WARNING: fs/proc/generic.c:<line> at remove_proc_entry

The fixed kernel reaches the MSI or legacy interrupt fallback without
this warning. The failure is deliberately injected to exercise the
error path; it does not claim that a third request_irq() failure occurs
spontaneously during normal operation.

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

---
v2:
- Add exact QEMU/failslab reproduction steps and the expected warning.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad4..f55aec340342b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_irq;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_irq;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_irq:
+	while (vector)
+		free_irq(adapter->msix_entries[--vector].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.34.1

