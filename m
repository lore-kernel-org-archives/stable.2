Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093B372EC1;
	Mon, 12 Oct 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792632; cv=none; b=QCmKeT6NYiI2lO0COZ67fXlONxFPOiUsKlCvsQfx/ykiNNLcdjNpUg3UQkhb0ffIT8/5W906e79SZhYV+tybMtHpQsxp4QJYlRLH7JjsOo7tFSVIoytVvT2PFSb5z4mq2HcnJiN/NR44nXHFROw4Xj/+Y1nl5QecHtQ5rtz81nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792632; c=relaxed/simple;
	bh=DEux4xfpTsHMCrkoqZuZiLUBMLlC23n4EI5ObgM0iC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPRvPO4nqYvEtJYTjuCJDieeDvS6+o0Zh5bqB3pe/rjZCcW6HQWP8EInVpDMy5O6LhzQaNPog9wzWjiHpmvoCKXPAtjLv8H6Q6AguVhojstAf/7EY6PQ/9wCtsc7D7x2parBoiXS9XYUq9yW2VBE5KDECeGFs3d2REWT5WLVhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz11t1791792558tbc1d51be
X-QQ-Originating-IP: XuDCakJyhqZ5EbitY+0Bc69o9NC/l6hVYO3ncUo4q2I=
Received: from localhost.localdomain ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 16:09:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8330384946093858897
EX-QQ-RecipientCnt: 12
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5] net: libwx: fix VF PM suspend/resume flow
Date: Mon, 12 Oct 2026 16:09:13 +0800
Message-Id: <20261012080913.49444-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NbhrksM5CKG1Kjszl1PLy2GGg0bQeqD2NTntznbFWaTNbMVhixP8dmPV
	zR5pcJEIzovGY75rAZC5OEdT1qERUjRzmiTEqcPEyj6MPlAWJ+4/cH2Nc9FAt154T3F0iF7
	CYoIBLtUyql9Zo4hHoa6/gvdAoan+07j9zoXCk3aQxGWft7+EfgfTK1d/BlTl9ut73mLRK6
	4Qewy95cmQRtp5Ao7zthxx0RhippkLJ5VA5AzFNaOsrNKF06SQiXFoSJUze44XdgZqAYQgK
	PPAqWZAjOt+xrDSzGpql+gZinGyOIRT9HvmSFdAU4fHJ5mKWEcVsiJw3D7aPcfWs9MPWbrc
	zLM1mQUG0mleodp+E9z3KF8DLJbH1UAHjVtt2ntkH7VOYMVE6t6EGQoXT/xclUZLr2vjagw
	a2ipZG+Th2GAkY0GQ0/SdXypiKV3yg59HXHW3OGEnDJAu3H67eVH27Wka4QTTvi8LVldSlv
	hJaPf/YhaZnGH46ftcm1ZQSC/3DE8/0aEHIea2Wrh8xJ/JEtBFpFgHeVfYPNbeXhajYkyUF
	u0M39XhxKxwu8jcdPhCCYGb4c6z7+hJZ/dVaCXjRtiN8nZA1FpC//co+KHxrJIpp0G5LGRv
	0N78Gt9+fxFMU+HUT6hHFBrj4+FrWGtrFWkgnCzBRzB2E9OnUO4L3Iv/7JmR35B+AWcRGud
	mPyQ1M0udXx8MxqkuPo8owNHSRrPeQH+V2xzCAX56PLUp13xaujbd5PW/1FAwvQ0/pc4l8Z
	3GXYofvzxu2wdc1/rl6YlucC1of23rIq3RwD5oDeiGYdi8U/1G6CcwAEZTtSp/GLFKxFm1s
	QQGeomQX03VNf7xlRQqXx0ovJxMDljf3zqkTY/12s/I9wlRqJBhOdWYKD88CxxU1nCDT58P
	QgN0lTdRN+PHfDV7nRfItLteq5FAn7lnZnn/RJhbc+hipZRqti5YhVCsl2DoRJwnvxlh/Fd
	aZZ12tJ00FdZdg3dcHDjqvTxdhjt0O0XxKx/lA9K5mxs/KQRCi3zjFMzvUdb02NvIr5Ku5L
	vLDDsB034KcNScOhe51nSod6UseLnFsv86NPqv3PdRrsjR0R5aI95X0O+Z0i8/GCalRA6TK
	5jP4PUJE06m0Zk9wnPfomRAqHQT1srWaA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The shared PM callbacks used by txgbevf and ngbevf free queue vectors and
disable PCI without first stopping a running VF or draining service
activity. Resume does not re-enable PCI or restore a running VF's queues
and IRQs. Service work can therefore access torn-down resources, and a
running interface is not restored correctly after resume.

Stop a running VF under RTNL before freeing its interrupt resources,
preserving its administrative running state. Drain the service timer and
work before disabling PCI.

Re-enable PCI on resume and defer PF readiness checks, VF reset and
interrupt setup to the service task. Retry readiness and reset failures
while keeping the device detached. Reopen the interface only if it is
still administratively running. If interrupt setup or reopening fails,
stop recovery, close the interface if necessary, and leave the device
detached with PCI disabled.

Track freed resources and PCI enable state to avoid duplicate teardown.
Reject ring-parameter changes while queue vectors are unavailable.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Cc: stable@vger.kernel.org
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v5:
- Serialize the PF mailbox probe with mbx_lock, send a firmware-version
  request, and propagate VF reset failures.
- Serialize link updates with RTNL and skip them while reopening is pending.
- Track PCI and resource state to avoid duplicate teardown. Use dev_close()
  on reopen failure and reject ring-parameter changes without queue vectors.
v4: https://lore.kernel.org/netdev/20260908095801.61346-1-mengyuanlou@net-swift.com/
- Refactor patch description and subject to focus on PM flow rework for
  net-next instead of bug fixes, removing the Fixes tag.
- Unconditionally restore the interrupt scheme in wxvf_reopen_subtask()
  to fix NULL msix_entry dereference on previously admin-DOWN interfaces.
- Add WX_FLAG_NEED_REOPEN guard in wxvf_link_config_subtask() to block
  mailbox and register operations before reopening completes.
- Validate netif_running() under rtnl_lock() in wxvf_reopen_subtask()
  before invoking wxvf_open() to respect administrative DOWN events
  during deferral.
- Synchronize core netdev flags (__LINK_STATE_START and IFF_UP) and
  trigger DOWN notifications on wxvf_reopen_subtask() failure paths.
- Flushed service timer and work synchronously during suspend to avoid
  tasks running after PCI device teardown.
v3: https://lore.kernel.org/netdev/20260904085216.43469-1-mengyuanlou@net-swift.com/
- Fix DMA-after-free and UAF races in wxvf_suspend() by invoking
  wxvf_close() when running, ensuring DMA engines are stopped and
  NAPI/IRQs/rings are cleanly freed before clearing PCI state.
- Replace manual resource allocation in wxvf_resume() with deferred
  reopening via WX_FLAG_NEED_REOPEN, scheduling wxvf_reopen_subtask() to
  run full wxvf_open() sequence under rtnl_lock().
- Move timer/work synchronization after rtnl_lock() release in
  wxvf_suspend() to prevent service tasks from re-arming the timer.
- Add error unwinding in wxvf_reopen_subtask() to set WX_STATE_DOWN,
  clear bus mastering, and log errors if reopen fails.
- Skip wxvf_link_config_subtask() when WX_STATE_DOWN is set to prevent
  link updates on downed interfaces.
v2: https://lore.kernel.org/netdev/20260829091423.83097-1-mengyuanlou@net-swift.com/
- Refactored the suspend and resume logic to eliminate full netdevice
  close/open cycles in favor of lightweight interrupt and queue manipulation:
  * In wxvf_suspend(), replaced wxvf_close() with explicit queue stopping
    (netif_tx_disable), carrier drop, NAPI disabling (wx_napi_disable_all), IRQ
    releasing (wx_free_irq), and resource freeing (wx_free_resources).
  * In wxvf_resume(), replaced wxvf_open() with granular resource allocation
    (wx_setup_resources), MSI-X IRQ requesting (wx_request_msix_irqs_vf),
    and deferred hardware reconfiguration via WX_FLAG_NEED_DO_RESET flag.
- Dropped the addition of device_link_add() to parent PF in ngbevf and txgbevf
  probe() paths to keep the patch focused strictly on libwx PM suspend/resume flow.
v1: https://lore.kernel.org/netdev/20260826095243.16939-1-mengyuanlou@net-swift.com/
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |   2 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 133 ++++++++++++++++--
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +-
 7 files changed, 133 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 940d2e59876c..729b1ec65bd7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -790,6 +790,9 @@ static int wx_set_ringparam_vf(struct net_device *netdev,
 	struct wx_ring *temp_ring;
 	int i, err = 0;
 
+	if (!wx->num_q_vectors)
+		return -EBUSY;
+
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index dcbf5811046e..701d239ab13c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3402,7 +3402,8 @@ EXPORT_SYMBOL(wx_set_ring);
 
 void wx_service_event_schedule(struct wx *wx)
 {
-	if (!test_bit(WX_STATE_DOWN, wx->state) &&
+	if ((!test_bit(WX_STATE_DOWN, wx->state) ||
+	     test_bit(WX_FLAG_NEED_REOPEN, wx->flags)) &&
 	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
 		queue_work(system_power_efficient_wq, &wx->service_task);
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index afd980dbb793..d8551923cdea 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1288,6 +1288,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_MODULE_RESET,
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
+	WX_FLAG_NEED_REOPEN,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PCIE_RECOVERY,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.c b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
index 7567216a005f..213d13d26070 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
@@ -38,8 +38,8 @@ void wx_init_hw_vf(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_init_hw_vf);
 
-static int wx_mbx_write_and_read_reply(struct wx *wx, u32 *req_buf,
-				       u32 *resp_buf, u16 size)
+int wx_mbx_write_and_read_reply(struct wx *wx, u32 *req_buf,
+				u32 *resp_buf, u16 size)
 {
 	int ret;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index b64a4de089f2..e8001d5856a9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -109,6 +109,8 @@ struct wx_link_reg_fields {
 };
 
 void wx_init_hw_vf(struct wx *wx);
+int wx_mbx_write_and_read_reply(struct wx *wx, u32 *req_buf,
+				u32 *resp_buf, u16 size);
 int wx_reset_hw_vf(struct wx *wx);
 void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr);
 void wx_stop_adapter_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..1e65cc281b68 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -16,9 +16,23 @@ int wxvf_suspend(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
 
+	rtnl_lock();
 	netif_device_detach(wx->netdev);
+	if (netif_running(wx->netdev))
+		wxvf_close(wx->netdev);
+
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
 	wx_clear_interrupt_scheme(wx);
-	pci_disable_device(pdev);
+	set_bit(WX_STATE_RES_FREED, wx->state);
+	rtnl_unlock();
+
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+
+	pci_clear_master(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 
 	return 0;
 }
@@ -34,11 +48,20 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
 
-	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
-	netif_device_attach(wx->netdev);
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
+	clear_bit(WX_STATE_DISABLED, wx->state);
+	pci_set_master(pdev);
+	rtnl_lock();
+	mod_timer(&wx->service_timer, jiffies + HZ);
+	set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	rtnl_unlock();
 	return 0;
 }
 EXPORT_SYMBOL(wxvf_resume);
@@ -52,13 +75,15 @@ void wxvf_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 EXPORT_SYMBOL(wxvf_remove);
 
@@ -137,19 +162,23 @@ void wx_negotiate_api_vf(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_negotiate_api_vf);
 
-void wx_reset_vf(struct wx *wx)
+int wx_reset_vf(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-	int ret = 0;
+	int ret;
 
 	ret = wx_reset_hw_vf(wx);
-	if (!ret)
-		wx_init_hw_vf(wx);
+	if (ret)
+		return ret;
+
+	wx_init_hw_vf(wx);
 	wx_negotiate_api_vf(wx);
 	if (is_valid_ether_addr(wx->mac.addr)) {
 		eth_hw_addr_set(netdev, wx->mac.addr);
 		ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL(wx_reset_vf);
 
@@ -279,6 +308,7 @@ void wxvf_up_complete(struct wx *wx)
 	wx_configure_msix_vf(wx);
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 
 	/* clear any pending interrupts, may auto mask */
@@ -376,6 +406,9 @@ int wxvf_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return 0;
+
 	wxvf_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
@@ -388,25 +421,103 @@ static void wxvf_link_config_subtask(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	rtnl_lock();
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
+		goto out;
+
 	wxvf_watchdog_update_link(wx);
 	if (wx->link) {
 		if (netif_carrier_ok(netdev))
-			return;
+			goto out;
 		netif_carrier_on(netdev);
 		netdev_info(netdev, "Link is Up - %s\n",
 			    phy_speed_to_str(wx->speed));
 	} else {
 		if (!netif_carrier_ok(netdev))
-			return;
+			goto out;
 		netif_carrier_off(netdev);
 		netdev_info(netdev, "Link is Down\n");
 	}
+
+out:
+	rtnl_unlock();
+}
+
+static void wxvf_reopen_subtask(struct wx *wx)
+{
+	u32 ping[2] = { WX_VF_GET_FW_VERSION };
+	int ret;
+
+	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
+		return;
+
+	rtnl_lock();
+	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags) ||
+	    test_bit(WX_STATE_DISABLED, wx->state)) {
+		rtnl_unlock();
+		return;
+	}
+
+	/* Serialize the ping with other VF mailbox accesses.
+	 * The helper sends the request and waits for the PF reply.
+	 */
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	ret = wx_mbx_write_and_read_reply(wx, ping, ping, ARRAY_SIZE(ping));
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+	if (ret) {
+		rtnl_unlock();
+		return;
+	}
+
+	ret = wx_reset_vf(wx);
+	if (ret) {
+		rtnl_unlock();
+		return;
+	}
+
+	if (wx_init_interrupt_scheme(wx)) {
+		dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
+		goto hard_failure;
+	}
+
+	if (netif_running(wx->netdev)) {
+		if (wxvf_open(wx->netdev))
+			goto open_failed;
+	}
+
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	if (!netif_running(wx->netdev))
+		timer_delete_sync(&wx->service_timer);
+	netif_device_attach(wx->netdev);
+	rtnl_unlock();
+	return;
+open_failed:
+hard_failure:
+	/* Do not retry interrupt setup or reopen from the service task. Keep the
+	 * netdev detached and down, and disable PCI.
+	 * Retry by rebinding the driver or through a later PM resume; bring the
+	 * interface up after recovery.
+	 */
+	timer_delete_sync(&wx->service_timer);
+	wx_clear_interrupt_scheme(wx);
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	set_bit(WX_STATE_DOWN, wx->state);
+
+	if (netif_running(wx->netdev))
+		dev_close(wx->netdev);
+
+	rtnl_unlock();
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(wx->pdev);
+	dev_err(&wx->pdev->dev, "Failed to fully resume device\n");
 }
 
 static void wxvf_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
+	wxvf_reopen_subtask(wx);
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
 	wx_service_event_complete(wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index d45d5d8ac3ab..5bfeab6fdde6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -10,7 +10,7 @@ int wxvf_resume(struct device *dev_d);
 void wxvf_remove(struct pci_dev *pdev);
 int wx_request_msix_irqs_vf(struct wx *wx);
 void wx_negotiate_api_vf(struct wx *wx);
-void wx_reset_vf(struct wx *wx);
+int wx_reset_vf(struct wx *wx);
 void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
-- 
2.30.1

