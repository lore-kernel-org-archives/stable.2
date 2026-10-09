Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387073BFADE;
	Fri,  9 Oct 2026 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587302; cv=none; b=sJLjyegDyiLYKu/3mpBtK9C7Po7q5c3oVIUrqsP6HREAhkiqkahZYrBbIy50kYf/tG+YHyMLwm7FOmyEja04uLhLxEztCU8lr1K+CEbOoi4ehRrb9qR4VjoRUO5XC+3t4bj8YoRbsornK1wC/XpOhqdan5K65sZWJqvaXagVmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587302; c=relaxed/simple;
	bh=V/2y3VB2FEYliAb3VGyTxwIjRFjrMSfnZvrSfU0mwPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHWc06unMb2zDT78yFrZv0DTF294EAxGPCfqEyq8gNjxgAZFuFv/7vQjjc7UjYQFOPZqgRztWOWaaNOx7BksBz7/U+d7TJ1l/hLwnLLz8veDvX7MIKNwva1Pu8Yv0KSnIdP0JvKzUMSTJHOVI7PTAcjQ9oVIwDoGso7oNv3AuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M946hMoC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M946hMoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791587300; x=1823123300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V/2y3VB2FEYliAb3VGyTxwIjRFjrMSfnZvrSfU0mwPc=;
  b=M946hMoC9oThmag0udropMCd6CXjY0DK21LbLJZNkjzRdnO4kRTo0E3g
   zE1eIJneB+9CsxlkqZq30qdlIMEQMgq+VZ7F1xfs6E+VMiF/Zcn4qoSi1
   +3rVvy2bzCapXzEIPj+ng4I9iLmwI6NZUPuV+Sabgf+mJOk7aVXS9HTuo
   2FCYXAnt72DSxsN4UTB45w2PS9hBp7ddj50MB2c1dts2zDP0bllUCSQwQ
   jj7R3TyyqWimmWtxHDx8KGxI05rWEYGHG7LOMQCW3B0wZ9r3ytJ94rCtM
   uCIA677uF9IcnmfjHrSA7hZnEU+EzMf0LTDZ2yukRakbvHYo4OLbjJrLk
   Q==;
X-CSE-ConnectionGUID: GKBMfY4JSLm6kSEWFwRKhA==
X-CSE-MsgGUID: cUEXYuvyS8Gx0Qhm6SHeXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="293411"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="293411"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:08:19 -0700
X-CSE-ConnectionGUID: BKunYbAtTKmzcnpyVJ/AaQ==
X-CSE-MsgGUID: QVW7ikjGShqDi/sb6+zsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2258159"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:08:18 -0700
Message-ID: <3b225456-30e9-4da6-bb1c-96cd17f65b17@intel.com>
Date: Fri, 9 Oct 2026 16:08:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] NTB: ntb_transport: Make link setup flags atomic
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-4-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260928152550.3354675-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 8:25 AM, Koichiro Den wrote:
> Convert nt->link_is_up and qp->client_ready to atomic_t and use atomic
> accessors throughout. This prepares for the unlocked cleanup check and
> the link-up ordering fixes that follow.
> 
> Leave control flow and locking unchanged.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Frank Li <Frank.Li@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v3:
>   - New patch. (Frank)
>     https://lore.kernel.org/r/i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5/
> 
>  drivers/ntb/ntb_transport.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 55a20ae9a85e..5d2ec484c3df 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -47,6 +47,7 @@
>   * Contact Information:
>   * Jon Mason <jon.mason@intel.com>
>   */
> +#include <linux/atomic.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
> @@ -142,7 +143,7 @@ struct ntb_transport_qp {
>  	struct dma_chan *tx_dma_chan;
>  	struct dma_chan *rx_dma_chan;
>  
> -	bool client_ready;
> +	atomic_t client_ready;
>  	bool link_is_up;
>  	bool active;
>  
> @@ -249,7 +250,7 @@ struct ntb_transport_ctx {
>  	unsigned int msi_spad_offset;
>  	u64 msi_db_mask;
>  
> -	bool link_is_up;
> +	atomic_t link_is_up;
>  	struct delayed_work link_work;
>  	struct work_struct link_cleanup;
>  
> @@ -945,7 +946,7 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
>  
>  	ntb_qp_link_cleanup(qp);
>  
> -	if (nt->link_is_up)
> +	if (atomic_read(&nt->link_is_up))
>  		schedule_delayed_work(&qp->link_work,
>  				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
>  }
> @@ -972,7 +973,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  			cancel_delayed_work_sync(&qp->link_work);
>  		}
>  
> -	if (!nt->link_is_up)
> +	if (!atomic_read(&nt->link_is_up))
>  		cancel_delayed_work_sync(&nt->link_work);
>  
>  	for (i = 0; i < nt->mw_count; i++)
> @@ -1084,7 +1085,7 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			goto out1;
>  	}
>  
> -	nt->link_is_up = true;
> +	atomic_set(&nt->link_is_up, true);
>  
>  	for (i = 0; i < nt->qp_count; i++) {
>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> @@ -1092,7 +1093,7 @@ static void ntb_transport_link_work(struct work_struct *work)
>  		ntb_transport_setup_qp_mw(nt, i);
>  		ntb_transport_setup_qp_peer_msi(nt, i);
>  
> -		if (qp->client_ready)
> +		if (atomic_read(&qp->client_ready))
>  			schedule_delayed_work(&qp->link_work, 0);
>  	}
>  
> @@ -1121,7 +1122,7 @@ static void ntb_qp_link_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt = qp->transport;
>  	int val;
>  
> -	WARN_ON(!nt->link_is_up);
> +	WARN_ON(!atomic_read(&nt->link_is_up));
>  
>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
>  
> @@ -1141,7 +1142,7 @@ static void ntb_qp_link_work(struct work_struct *work)
>  
>  		if (qp->active)
>  			tasklet_schedule(&qp->rxc_db_work);
> -	} else if (nt->link_is_up)
> +	} else if (atomic_read(&nt->link_is_up))
>  		schedule_delayed_work(&qp->link_work,
>  				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
>  }
> @@ -1165,7 +1166,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->qp_num = qp_num;
>  	qp->transport = nt;
>  	qp->ndev = nt->ndev;
> -	qp->client_ready = false;
> +	atomic_set(&qp->client_ready, false);
>  	qp->event_handler = NULL;
>  	ntb_qp_link_context_reset(qp);
>  
> @@ -1373,7 +1374,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	if (rc)
>  		goto err3;
>  
> -	nt->link_is_up = false;
> +	atomic_set(&nt->link_is_up, false);
>  	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>  	ntb_link_event(ndev);
>  
> @@ -1457,7 +1458,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  
>  		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
>  
> -		if (qp->rx_handler && qp->client_ready)
> +		if (qp->rx_handler && atomic_read(&qp->client_ready))
>  			qp->rx_handler(qp, qp->cb_data, cb_data, len);
>  
>  		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
> @@ -2268,7 +2269,7 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len)
>  	struct ntb_queue_entry *entry;
>  	void *buf;
>  
> -	if (!qp || qp->client_ready)
> +	if (!qp || atomic_read(&qp->client_ready))
>  		return NULL;
>  
>  	entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);
> @@ -2385,9 +2386,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>  	if (!qp)
>  		return;
>  
> -	qp->client_ready = true;
> +	atomic_set(&qp->client_ready, true);
>  
> -	if (qp->transport->link_is_up)
> +	if (atomic_read(&qp->transport->link_is_up))
>  		schedule_delayed_work(&qp->link_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_link_up);
> @@ -2407,7 +2408,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
>  	if (!qp)
>  		return;
>  
> -	qp->client_ready = false;
> +	atomic_set(&qp->client_ready, false);
>  
>  	val = ntb_spad_read(qp->ndev, QP_LINKS);
>  

