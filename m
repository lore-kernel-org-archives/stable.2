Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219384;
	b=h9zYzWQ5Pue1PSyRU8Y+SIr26DjWweyn+AmrpgKIGxNGhSyviUzoZpR8ug9Kq3OeVvdR
	 mgZhHV91ipv2Q5/rITi8wJHOma1aglbZAVNf3f87vL1beALz21CtrJROGgQl/4EmHgQHp
	 pNOK7QsKwbUIJ2LytkXH/RbHZYkE1wpMP5nMPXD4f/RNL4dWSiqCRNT6StXv+X9DOnrWq
	 JshVQuPorC8f1o9Zg1stkTEE4rL+3rTnrEPXQqc6FPKlb+9lWEbjMisVK7GqODTk6xpOQ
	 92oEEj9hbuLts4Q6STBvUMqP+pwP8LClbKHeoOmqTO/062r7tr5DscdevtQHz0dGlJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219384;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9PYjsCovxbwG2Itfx3rSNxc2BSeADRrw46k7ndRCDsQ=;
	b=cuMKHF5q15r4TkTgRamBZMp7VzIexDl6rWHLzxm9u7vAI0WZkqXfk7I91NrthNaFGqKd
	 HThVQ8hXJw9pqfGm4454tfeVtPSoCnq4bw5ux6CPIi3dRiBvG7Rsc23xLSENFuniVgTFr
	 MeLexZzBobKblrLuu1HkIOUJxKs9kwY+O6nB1joCYv9HItyHZvcylRzo2SshMFIeSSPA2
	 OXbPb7U38vXLGefZkz5HO0LVHypgnj10Ct01wuoivAabDENmKhm7VIAwrXrdSDaTspzpR
	 TSJXD4S6v7sZeO+/30ZFXnj+9bM3gW7FbdfSh31y7Gl5ft4TVKXeN6jkOq6OsU8QmKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897A606A321;
	Mon,  9 Nov 2026 10:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1897A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz16t1794219306t968aa643
X-QQ-Originating-IP: BL+GGtNklOLcGzGXfosN67fC2dQ023DN/eMB4kzlGc0=
Received: from localhost.localdomain ( [60.186.246.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 18:14:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5273375935813799961
EX-QQ-RecipientCnt: 14
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
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	stable@vger.kernel.org
Subject: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
Date: Mon,  9 Nov 2026 18:14:42 +0800
Message-Id: <20261109101442.84605-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MDV28+Mv4MtlaDd5HzZDny1I3Jz7tLGp3MzYHp9KxAOhvrNR84kHfjiE
	NTqIpK/czfv1/07xvze/J+NOyrsSln50j+m+WtvYXYMcMR+sVyzifnsGl852E5X7TmWTQSB
	hnun5raMzJT5Dwkg7/gI989oaKEGZuPo2AgunZME7ALTsli1dJd7xaoDbk7z6JBhFZeN1/v
	Wcdup1WT9dVASK2HBJFUrDJLFKQPA8MVB5jJ+o9L+Gy39yG4mlS/YJOtbpFZ2P6UO+pzh0h
	Fc7Mi96JinYrMJG/rLNuyeISJHVCy79dN76e/WE5ws2vQkgTqcNNq6p83HWFsVpfAtBV+Gj
	d7+V5yRYT3Rm2xzgKEpINFHDOA3d1xE2tkI9NSJbH9RhJ1ab9nRrICssu1BN+VM1IgN45JE
	RFt3CEwQlEClWFWjeqK8Gh9aNVoocybDVCizSDYBpgxN51ua3/izZUF2uYGOTrU53chavLD
	5okGYLIxdbaKIvOo8lRmyjUORXIwYqago3kvCJ5Q3LmJJTZZOqYRk0dC/CX5rr0285vrSUc
	FpLPmMPFL0SSjOk6qmDUSDVA3GTL2ZTKLPi5qFvNejo5pW1JFKyVjIAL5M+HsepzIO7U4/s
	IVacWY00rLrmKR9sAq4qvHVLqke8CIcELS55VnzVysGu3+Q2UszcW9htt+m8zs20/7LWnmT
	/PgLE98OfqFiMrdnnjYk1VEXMAJwuoYelDGnONFgmQnaNU0lYRKZl1+zpPDIsjRW37iJlxr
	wLln8rk7qLDpu7mVBF0LXl2QPWW3+QUONpdaX/sRr1Qbri6QOy+0EtfJ5OlStOWItjfVASY
	6fX4+ll48MT/XLRzeHylRKevu3ZwFF9e0PNtkFMa1lyeuY61h+dIS8/f2iuyt72mRN17QuZ
	b6nvOBGvq3rlCu5W11POrWASxPqcqTa/ZvbOF5aYNB5gU9ciNV9irkLjLZcADt6P3APT3Fr
	lZI/1rSNLNMxr5gjVEy+abtbjc6a1Fl52PFGnvB9JYq013Df2B1i3jee7TIgJ82PyGpRDSt
	juE99eImZu6NTHjymDr1JEgxmNZ7lpm+GN7VALMkz9jOj0KWgtgKWbTMehnWQhxDss4PvK6
	6AYfnFFcvWsYGbO0weXfvhulj0JCNOvijPTwLAPUHMy
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The shared PM callbacks used by txgbevf and ngbevf free queue vectors and
disable PCI without first stopping a running VF or draining service
activity. Resume does not re-enable PCI or restore the queues and IRQs of
a running VF. Service work can therefore access torn-down resources, and a
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

When backporting to kernels that do not have commit e73e4d187a1f52 ("net:
wangxun: add pcie error handler"), add WX_STATE_DISABLED and
WX_STATE_RES_FREED to enum wx_state before WX_STATE_NBITS. The PCIe
error-handler implementation from that commit is not needed.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Cc: stable@vger.kernel.org
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v8:
- Rename the goto labels in wxvf_reopen_subtask() to describe the action
  taken on failure, and merge the duplicate open-failure and hard-failure
  labels into a single err_disable_device label.
v7: https://lore.kernel.org/netdev/20261029104220.77344-1-mengyuanlou@net-swift.com/
- Skip the deferred reopen once the netdev is no longer registered, so a
  pending reopen cannot race with unregister_netdev() during removal.
- Correct the v5 changelog: the reopen is driven by the service timer,
  not scheduled immediately from resume.
v6: https://lore.kernel.org/netdev/20261019060216.38458-1-mengyuanlou@net-swift.com/
- Clarify the enum dependency for stable backports to kernels without the
  PCIe error-handler commit.
- Keep API negotiation and MAC refresh after reset errors for existing
  callers, while returning the reset error to the resume retry path.
v5: https://lore.kernel.org/netdev/20261012080913.49444-1-mengyuanlou@net-swift.com/
- Keep the deferred reopen pending while the PF is not ready, so the
  service timer retries it instead of giving up on the first failure.
- Serialize the PF mailbox probe with mbx_lock, send a firmware-version
  request, and propagate VF reset failures.
- Serialize link updates with RTNL and skip them while reopening is pending.
- Track PCI and resource state to avoid duplicate teardown. Use dev_close()
  on reopen failure and reject ring-parameter changes without queue vectors.
- Retarget the patch to net and add Fixes and Cc: stable tags.
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
- Flush the service timer and work synchronously during suspend to avoid
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
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 123 ++++++++++++++++--
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +-
 7 files changed, 126 insertions(+), 12 deletions(-)

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
index a7f3c48e9603..66b21bde962e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1288,6 +1288,7 @@ enum wx_flags {
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
index 26de78e9a69e..e274a77b3be9 100644
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
 
@@ -137,7 +162,7 @@ void wx_negotiate_api_vf(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_negotiate_api_vf);
 
-void wx_reset_vf(struct wx *wx)
+int wx_reset_vf(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 	int ret = 0;
@@ -150,6 +175,8 @@ void wx_reset_vf(struct wx *wx)
 		eth_hw_addr_set(netdev, wx->mac.addr);
 		ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 	}
+
+	return ret;
 }
 EXPORT_SYMBOL(wx_reset_vf);
 
@@ -279,6 +306,7 @@ void wxvf_up_complete(struct wx *wx)
 	wx_configure_msix_vf(wx);
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 
 	/* clear any pending interrupts, may auto mask */
@@ -376,6 +404,9 @@ int wxvf_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return 0;
+
 	wxvf_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
@@ -388,25 +419,101 @@ static void wxvf_link_config_subtask(struct wx *wx)
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
+	    test_bit(WX_STATE_DISABLED, wx->state) ||
+	    wx->netdev->reg_state != NETREG_REGISTERED) {
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
+		goto err_disable_device;
+	}
+
+	if (netif_running(wx->netdev) && wxvf_open(wx->netdev))
+		goto err_disable_device;
+
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	if (!netif_running(wx->netdev))
+		timer_delete_sync(&wx->service_timer);
+	netif_device_attach(wx->netdev);
+	rtnl_unlock();
+	return;
+err_disable_device:
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

