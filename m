Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB51486650;
	Fri, 25 Sep 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329750; cv=none; b=Eo4AzIbYMWRn3jDHq1lvOa4w3uqCDSuh0TJhuMqaLRaISF5n0rgnv6jH2dsPeWvcoRAkSokdrKdaEP0wa0l6xAk/5bugudVc02hSsUwwxao1bqyaymxr3z9EQNJ9YC+cAJGeJZw95YB1r3YrN81kj5EOhP00/Uc+leaj8udW/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329750; c=relaxed/simple;
	bh=KVwrx190xktzE843f4n92D/podfAs9oU/wmC2+vWqsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOyeb6SzxPKscgdLemAk4OxlxwjCTna/VqPJOVxqlY+wA5ZuHtDNIpoTdEA87BWGx+SnPSZTvkmQE/DVf1qdKmwR6+aHrsZqLs8kgQl9w20FWAfzo0yWqrCE1AWO5Q0Dz+6vcm9j1JNWnkaK5AgII1rtJTzrKdQK+xIG/7Z1Gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTgsclWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTgsclWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A151F00893;
	Fri, 25 Sep 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790329746;
	bh=EgNxEGp+NlXRyeq9TTW8FL/WtBpQd1jhsUJlo4uhSCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KTgsclWAjBuNrbYTl+gMM5Ohfb2sYdWd/06rxf7lowvW2wIlB+oTzy8CwbrLAko+V
	 qMwAwp+8GwQTSo5ePf/VwyI0xs978AAqDPex3V097Uqx/41ZkVDMCbuDeA0mSwe9ai
	 TF0lckr8frxVEOUuIz9DMxkMstAYNpVAPWWdKf8V6UN6povzoVHHDHaVXhqli4QvTq
	 dkVkl8obonsZvhzvHTYFVvkyquziJaST6uc7lCG8CpG6aFxCADdkRTr4vqhyPCNUe3
	 LuXyPFDrc+sE+G8endy9vhgMu8K4Y0z6FFXTuYB2doccbk8f3t2iiT600eu/6Irdvq
	 M4QNh3PwuIHLw==
Date: Fri, 25 Sep 2026 10:49:01 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net] net: vmxnet3: unwind partial IRQ setup
Message-ID: <20260925094901.GH13925@horms.kernel.org>
References: <20260922110710.1569410-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922110710.1569410-1-runyu.xiao@seu.edu.cn>

On Tue, Sep 22, 2026 at 07:07:10PM +0800, Runyu Xiao wrote:
> Track which interrupt vectors successfully acquired an IRQ handler and
> release that subset when a later request fails. This prevents activation
> error paths from leaving handlers registered while queue resources are
> being torn down.
> 
> Reproducer:
> 
>   Build an x86_64 kernel with CONFIG_PCI=y, CONFIG_PCI_MSI=y,
>   CONFIG_NET=y, CONFIG_NETDEVICES=y, and CONFIG_VMXNET3=m. For testing,
>   add a test-only wrapper around vmxnet3_request_irqs() that lets the
>   first request_irq() succeed and returns -EBUSY for the second request.
>   Boot QEMU with a vmxnet3 device, for example:
> 
>     qemu-system-x86_64 -machine pc -m 1G -smp 2 -nodefaults \
>       -no-reboot -display none -serial file:console.log \
>       -kernel arch/x86/boot/bzImage -initrd test.cpio.gz \
>       -append 'console=ttyS0 rdinit=/init loglevel=7 panic=1' \
>       -netdev user,id=n0 -device vmxnet3,netdev=n0
> 
>   In the guest, load the driver and open the interface:
> 
>     insmod vmxnet3.ko
>     ip link set dev eth0 up
>     cat /proc/interrupts
> 
>   The injected second request makes the open fail with -EBUSY. On the
>   unfixed kernel, the first handler remains registered and
>   /proc/interrupts contains an eth0-rxtx-0 entry. On the fixed kernel,
>   the same failure leaves no vmxnet3 IRQ entry. The injection is
>   deliberate to exercise the partial-registration path and is not a
>   claim that ordinary interface activation fails this way.
> 
> Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
> Cc: stable@vger.kernel.org

I am not at all sure that failures can occur in practice.
And while I'm happy to be convinced otherwise, if this
is a theoretical bug, then I think it is best handled
as a patch for net-next (without a Fixes tag or CC to stable).

> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/vmxnet3/vmxnet3_drv.c | 38 ++++++++++++++++++++++++-------
>  drivers/net/vmxnet3/vmxnet3_int.h |  1 +
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
> index f8df83f99..05373ba4d 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -53,6 +53,9 @@ static int enable_mq = 1;
>  static void
>  vmxnet3_write_mac_addr(struct vmxnet3_adapter *adapter, const u8 *mac);
>  
> +static void
> +vmxnet3_free_irqs(struct vmxnet3_adapter *adapter);
> +
>  /*
>   *    Enable/Disable the given intr
>   */
> @@ -2585,8 +2588,11 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
>  					"Failed to request irq for MSIX, %s, "
>  					"error %d\n",
>  					adapter->tx_queue[i].name, err);
> +				vmxnet3_free_irqs(adapter);
>  				return err;
>  			}
> +			if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE)
> +				intr->irq_requested[vector] = true;
>  
>  			/* Handle the case where only 1 MSIx was allocated for
>  			 * all tx queues */
> @@ -2620,8 +2626,10 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
>  					   "Failed to request irq for MSIX, "
>  					   "%s, error %d\n",
>  					   adapter->rx_queue[i].name, err);
> +				vmxnet3_free_irqs(adapter);
>  				return err;
>  			}
> +			intr->irq_requested[vector] = true;
>  
>  			adapter->rx_queue[i].comp_ring.intr_idx = vector++;
>  		}
> @@ -2631,6 +2639,8 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
>  		err = request_irq(intr->msix_entries[vector].vector,
>  				  vmxnet3_msix_event, 0,
>  				  intr->event_msi_vector_name, adapter->netdev);
> +		if (!err)
> +			intr->irq_requested[vector] = true;
>  		intr->event_intr_idx = vector;
>  
>  	} else if (intr->type == VMXNET3_IT_MSI) {
> @@ -2646,11 +2656,14 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
>  #ifdef CONFIG_PCI_MSI
>  	}
>  #endif
> +	if (intr->type != VMXNET3_IT_MSIX && !err)
> +		intr->irq_requested[0] = true;
>  	intr->num_intrs = vector + 1;
>  	if (err) {
>  		netdev_err(adapter->netdev,
>  			   "Failed to request irq (intr type:%d), error %d\n",
>  			   intr->type, err);
> +		vmxnet3_free_irqs(adapter);
>  	} else {
>  		/* Number of rx queues will not change after this */
>  		for (i = 0; i < adapter->num_rx_queues; i++) {
> @@ -2693,29 +2706,38 @@ vmxnet3_free_irqs(struct vmxnet3_adapter *adapter)
>  
>  		if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE) {
>  			for (i = 0; i < adapter->num_tx_queues; i++) {
> -				free_irq(intr->msix_entries[vector++].vector,
> -					 &(adapter->tx_queue[i]));
> +				if (intr->irq_requested[vector])
> +					free_irq(intr->msix_entries[vector].vector,
> +						 &adapter->tx_queue[i]);
> +				intr->irq_requested[vector++] = false;
>  				if (adapter->share_intr == VMXNET3_INTR_TXSHARE)
>  					break;
>  			}
>  		}
>  
>  		for (i = 0; i < adapter->num_rx_queues; i++) {
> -			free_irq(intr->msix_entries[vector++].vector,
> -				 &(adapter->rx_queue[i]));
> +			if (intr->irq_requested[vector])
> +				free_irq(intr->msix_entries[vector].vector,
> +					 &adapter->rx_queue[i]);
> +			intr->irq_requested[vector++] = false;
>  		}
>  
> -		free_irq(intr->msix_entries[vector].vector,
> -			 adapter->netdev);
> +		if (intr->irq_requested[vector])
> +			free_irq(intr->msix_entries[vector].vector, adapter->netdev);
> +		intr->irq_requested[vector] = false;
>  		BUG_ON(vector >= intr->num_intrs);
>  		break;
>  	}
>  #endif
>  	case VMXNET3_IT_MSI:
> -		free_irq(adapter->pdev->irq, adapter->netdev);
> +		if (intr->irq_requested[0])
> +			free_irq(adapter->pdev->irq, adapter->netdev);
> +		intr->irq_requested[0] = false;
>  		break;
>  	case VMXNET3_IT_INTX:
> -		free_irq(adapter->pdev->irq, adapter->netdev);
> +		if (intr->irq_requested[0])
> +			free_irq(adapter->pdev->irq, adapter->netdev);
> +		intr->irq_requested[0] = false;
>  		break;
>  	default:
>  		BUG();

> diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
> index 9f24d66db..93c545eb6 100644
> --- a/drivers/net/vmxnet3/vmxnet3_int.h
> +++ b/drivers/net/vmxnet3/vmxnet3_int.h
> @@ -362,6 +362,7 @@ struct vmxnet3_intr {
>  	enum vmxnet3_intr_type       type;	/* MSI-X, MSI, or INTx? */
>  	u8  num_intrs;			/* # of intr vectors */
>  	u8  event_intr_idx;		/* idx of the intr vector for event */
> +	bool irq_requested[VMXNET3_LINUX_MAX_MSIX_VECT];

This isn't the central point I want to make, but if you take
this approach then perhaps a bitmap could be considered
rather than an array of bool.

>  	u8  mod_levels[VMXNET3_LINUX_MAX_MSIX_VECT]; /* moderation level */
>  	char	event_msi_vector_name[IFNAMSIZ+17];
>  #ifdef CONFIG_PCI_MSI
> -- 
> 2.34.1

The first main point I want to make is this: vmxnet3_free_irqs() tries to
do too much.  It is is a long function with nested if conditions. And it
doesn't follow the basic flow of keeping error paths in conditions and the
main thread of execution outside of those conditions:

	err = do_something_awesome();
	if (err)
		/* Oops, it wasn't so awesome after all */

	/* Main thread of execution continues here */

Probably a lot of clarity would be achieved by cleaning-up the above.
But not without the risk of adding bugs :(

The second point I want to make is that, as a wise person once told me,
relying on generic clean-up-everything functions leads to errors. And while
it feels like duplication, it's usually cleaner to simply unwind using a
goto ladder.

I think this is the case here. And I'd suggest an approach similar
to the following (compile tested only; please check for out-by-one mistakes).

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index f8df83f9965d..618850ba7918 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2562,6 +2562,8 @@ static int
 vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 {
 	struct vmxnet3_intr *intr = &adapter->intr;
+	int num_msix_tx = 0;
+	int num_msix_rx = 0;
 	int err = 0, i;
 	int vector = 0;
 
@@ -2576,17 +2578,17 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 					      vmxnet3_msix_tx, 0,
 					      adapter->tx_queue[i].name,
 					      &adapter->tx_queue[i]);
+				if (err) {
+					dev_err(&adapter->netdev->dev,
+						"Failed to request irq for MSIX, %s, error %d\n",
+						adapter->tx_queue[i].name, err);
+					goto err_free_msix_tx;
+				}
+				num_msix_tx++;
 			} else {
 				sprintf(adapter->tx_queue[i].name, "%s-rxtx-%d",
 					adapter->netdev->name, vector);
 			}
-			if (err) {
-				dev_err(&adapter->netdev->dev,
-					"Failed to request irq for MSIX, %s, "
-					"error %d\n",
-					adapter->tx_queue[i].name, err);
-				return err;
-			}
 
 			/* Handle the case where only 1 MSIx was allocated for
 			 * all tx queues */
@@ -2620,8 +2622,9 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 					   "Failed to request irq for MSIX, "
 					   "%s, error %d\n",
 					   adapter->rx_queue[i].name, err);
-				return err;
+				goto err_free_msix_rx;
 			}
+			num_msix_rx++;
 
 			adapter->rx_queue[i].comp_ring.intr_idx = vector++;
 		}
@@ -2676,6 +2679,16 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 	}
 
 	return err;
+
+err_free_msix_rx:
+	for (i = 0; i < num_msix_rx; i++)
+		free_irq(intr->msix_entries[vector++].vector,
+			 &(adapter->rx_queue[i]));
+err_free_msix_tx:
+	for (i = 0; i < num_msix_tx; i++)
+		free_irq(intr->msix_entries[vector++].vector,
+			 &(adapter->tx_queue[i]));
+	return err;
 }
 
 
