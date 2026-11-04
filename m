Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799413;
	b=MS3ysnlTNkRUvtKlIE0i1hDNXDAb597I0Bjg+gdTBWBtwbBivTInJR4SZwKlb/IauFVR
	 cMnukLJ5/rsC/kfdJqYQIFzQa3hnoPbg2Wt5MFzE7aylU5x1dMcPWr3NNXb3LYLTJmmoj
	 KFx22h0dhbescGtEez//u1ZYa+6WIRaPQSJnRpHr1CTYRE1sDh01sIp5L9eY6tQbaYlE+
	 FVwIs+5izaka74Xo7SkMl05r1vdYTAIEZCezqAMrdVLd7OmkrbEi9/lgm3IWf8OTyVTjt
	 8LD8XMY2ZW/0UiNAC+cxPiM2aAwe6exdaHgHniXJ1PcoE1ulYfmXft4Ajgxfd2ScogQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799413;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4LNUFmDM7qSESkK7kvh3ikENvKL3ZUc9GBl++dqLwgQ=;
	b=m5sSlZNEuo4A5l8iDlTW+Vlkq8sMWfexgkEO0UVvnVKGvOyo8IEMdCmH18EKPja1fq1B
	 5G4DJ8UUTZswO+7DAYf4631hrTcBXqrURC/iv0qwhwW0kG39HVpFPBNiokWNawlQkjAui
	 cqyWdKYAmr8Y31ukasGfEcza2A6ws7nOz3bh87WLRLvsIYVKaDL+YZ0KT114nn5igtW9k
	 nJiJ+YSVYEhwbRmnHFkCuKjqnpTXaNk3wRO01J/mHI69yyeZCiloT+G57crYYObvDlhYs
	 kSi81H7KUjqMWcWs+RgoJylvHPzRtwpgvZ3NO+blHpoaDaPYH+P1T7tfAkaxvuJNrBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="SjFwM/Al";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC1606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SjFwM/Al
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62271F000C1;
	Wed,  4 Nov 2026 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799413;
	bh=4LNUFmDM7qSESkK7kvh3ikENvKL3ZUc9GBl++dqLwgQ=;
	h=Subject:To:Cc:From:Date;
	b=SjFwM/AlAYB5G35P8CXtasMDmRVmwACblj77nkmEM5598HoMII0dOD8JBQKCM6TJW
	 Te0uD/upS7PcGDubcmzijiuyNFPmEAy2OTgkEXW482a5hwNn4PbrtIJBqB+attMPZk
	 ERBCileKzl/nZ8z+kdU93L12VbldSaPQn5trStj8=
Subject: FAILED: patch "[PATCH] RDMA/irdma: avoid use-after-free in icrdma_remove" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,leon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:36:42 +0100
Message-ID: <2026110442-usual-nervy-ee84@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8a8088b899e4cdfe558428cd6113d45df81625be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110442-usual-nervy-ee84@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a8088b899e4cdfe558428cd6113d45df81625be Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 14 Sep 2026 20:28:40 +0800
Subject: [PATCH] RDMA/irdma: avoid use-after-free in icrdma_remove

icrdma_remove() dereferences iwdev after calling
irdma_ib_unregister_device():

  irdma_ib_unregister_device(iwdev)
    -> ib_unregister_device(&iwdev->ibdev)
      -> __ib_unregister_device()
        -> ib_dealloc_device()

irdma registers irdma_ib_dealloc_device() as the dealloc_driver
callback in its ib_device_ops. The RDMA core explicitly documents
ib_unregister_device() that when ops.dealloc_driver is used, ib_dev
will be freed upon return from the function.

The ib_device is embedded in struct irdma_device and iwdev itself was
allocated by ib_alloc_device(irdma_device, ibdev). Consequently, once
irdma_ib_unregister_device() returns, iwdev must no longer be
dereferenced.

However, icrdma_remove() currently accesses iwdev->rf afterwards when
deinitializing interrupts, destroying ah_tbl_lock, and freeing rf.
Although the final ib_device storage is released with kfree_rcu(), the
object lifetime has already ended and callers must not rely on the RCU
grace period to continue dereferencing iwdev.

Save iwdev->rf before unregistering the RDMA device and use the saved
pointer for the remaining cleanup.

This issue was found by manual code inspection.

Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260914122840.1709743-1-lgs201920130244@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 4b451d8482a4..f405ef761f84 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -318,14 +318,15 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 		container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
 	struct iidc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
 	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
-	u8 rdma_ver = iwdev->rf->rdma_ver;
+	struct irdma_pci_f *rf = iwdev->rf;
+	u8 rdma_ver = rf->rdma_ver;
 
 	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
 	irdma_ib_unregister_device(iwdev);
-	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
-	mutex_destroy(&iwdev->rf->ah_tbl_lock);
+	icrdma_deinit_interrupts(rf, cdev_info);
+	mutex_destroy(&rf->ah_tbl_lock);
 
-	kfree(iwdev->rf);
+	kfree(rf);
 
 	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
 		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));

