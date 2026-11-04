Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799403;
	b=FyFXjFxbRusg7kYq72l7efPOn7TSWFUw66bjHFdH0hvPPE3tpKYzhKbD0TuWjt+QYr5w
	 ihN2teeFXJsK2FD64kk5KAbasbJVzpmN0aVd+9R/KmN81/FWU8pmnfTJmR0sdZTkfL9PQ
	 y+SjJdrF0ksNE5cEbTDgN+NsU70MAvqubI7iNlJ19ksaF10+h0fm+tOvM/+HyU6FeVbif
	 fOsQEoGCpjpKMYI0huXyHIJez7lp9LyRKh2w3zF4PoD0S4ggYy9+Vn9R0rZltw2g87ohg
	 n117bu3MmnLOURJTthDo0krcwwj/zgm7ZUbS6jBITLaVOJuUkQRtfaOwTW9O/2STBFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799403;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tC2bnNsNtwJjmtFvORseFMqwvgtojtmWycjii4zGGxY=;
	b=hjSHSRhD/wEgg4124+jn+M/VHfKcTtAeBLWIfVl3cn4OhGN7PLNLIaLEUL20Bol/rwBD
	 7cGh/7a1iNtrJCDaqrJej+aq9sHJQsnw2iAnd5vrXJbrHQ7EsMqfJzwxfQWS9vxBZhhqp
	 ethcNfYp6rTNAKQzDNrWIA4PEXWSZNIpXSiLqAMpe278bihpf+M7WaCDVfI0eHcLmQsio
	 ahqsvIY4VnFPRZI5gXUPVstNyk4XI6hHXjepJn01SPEHHx74FcmWY0JRHJ9kmc/ciF7aF
	 csZ0tVV0Lz0ZRLHt21qP16AY2TjvJGs40AD6VXtX6sR72k+sOdSbu8f4sWxWkvpN9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A1nWN0wd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D6606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A1nWN0wd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17661F00919;
	Wed,  4 Nov 2026 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799402;
	bh=tC2bnNsNtwJjmtFvORseFMqwvgtojtmWycjii4zGGxY=;
	h=Subject:To:Cc:From:Date;
	b=A1nWN0wdFAKcvbO9epLqdAUmwT2xBjBK8e5Lh3uQNxnHfF2r3aFREOwmpZHQUOHLK
	 wa/fdOdV3EHkylQVECUdTJDL8zQXoT5bCRujdjJ+bIsgGN4IBJ+7da3WBpjsAFwrFb
	 PhcsOr9XgVOyuY/qInrBizc4wvN8moCHp6iLkT20=
Subject: FAILED: patch "[PATCH] RDMA/irdma: avoid use-after-free in icrdma_remove" failed to apply to 6.12-stable tree
To: lgs201920130244@gmail.com,leon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:36:41 +0100
Message-ID: <2026110441-support-onboard-d0bb@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8a8088b899e4cdfe558428cd6113d45df81625be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-support-onboard-d0bb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

