Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FC3D0C1D
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869500; cv=none; b=j4SVGPOmCe8ffIM61d7yOxR6lQgJm7hiyg5P5/C6bQS2ifAitOWuwpYIbCdfIB8iQS3v39WViHIs0e85QueEztclcxIUMLdIjuwyYtv8veKSINUREurAwLGQrNp3wVPDT6ODF+gCO+WtiFxElFH3jwXO6oYVJffnz4CN9wUUZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869500; c=relaxed/simple;
	bh=JoJzD6813vbi6Nad58gtt+h6HDPUZznYT2PSOqKo64g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA5LmjPjiiWfGwWAG7wRPUIQkVP45EVqC6fkrk52Unj2gZSpJOnNztFUWoqbB6Q05uO0YxQRS0D7NHCdwpEoj2pS0nIO4E1A6LDwjwLiq35CPYLQ0O5b85N3BQeBo+0UypF38Mejht5tuHzCjb0e4zXUn9uKv160dk8XPgLALQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbM/+YCE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbM/+YCE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f620399a0so481581a91.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787869487; x=1788474287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ybld9KoYS9z/qEgstKkgu7feMqUeGPX13VY+QPYd16Y=;
        b=NbM/+YCEHTF1f6VOvJlS3CYc9y/kwwZc6kHRIucnTJU7GJy9fgsGQxdmJJjAh56T/8
         snmvDky4FVKhxfj6wBWnoF766zujzxcagy2mSJeCEZfyqqOi7yWpuFp8ONLTJrKfZVOS
         TKAM6deTMYS85TTkKyYoRTo89j6LBd3KL4Zs0a4Fr/ll3AeFV4dB22+V8YRjGTOw4Fqe
         BcbzdLey2JUFtC03QBFmmUMLr8A1FscO7gZeWC85SBlgsAyhVq5PumlLUA1g5snLLhFS
         m2gRLNm5TTAjmvMECSKBKLQMhhZEU5BjvmCU3gxx8tGIXoDXimyU9bE/pq0tcK8ug4go
         jSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869487; x=1788474287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ybld9KoYS9z/qEgstKkgu7feMqUeGPX13VY+QPYd16Y=;
        b=hAeucw2A/YwG/tsmDAtfHvu4Ws657O24cIOhDV1OmTECUVqv0rifbyCqQOrDNGqxMS
         DCRwDCk3ZxWhvOiU/ZgQryt6GpQBeEKuGt8SpCk8LgepgHB15YGiwxcDfa1caB6NFQyO
         d5/sCR5ACHWNioEQIhD0Bm1v7tYAZ+BwkCZNgbyhdGqQLy+zk/BsazEuac7Cny4qnMMp
         yzzC3WJwXnKDC6XU87fOaeh0cT1JBc0UhYDjFHg3xhQ58CpJVV0MNbZ1YdO/GhWBJCUH
         +/yOSZAHKlibdES5A7SQBDD3Hezh5hNUMUI8ZraWkZeMDFTzrJBZJYPpdRd6mPUyiDYx
         I9BA==
X-Forwarded-Encrypted: i=1; AHgh+RqkDle65vSNQ4UI5Hs7hknMbhjZhlRj7E1p7Q/bAQ1Ev2Zedqy/L1HO8QTj4+kGOfMRmPqinQo=@vger.kernel.org
X-Gm-Message-State: AFuF++nuV7ierGEFu6FdAdJW006dJAAg3CmoN7Vf3ayoUy82wuHI88FX
	9KmVomXyFRWRj+Q3hMyJb8fiRHI4+Ly4+GavO8Ne64oe9wpPJkQQtMq3
X-Gm-Gg: AR+sD11MmvY12kiEJu1x/mcIrjSrlEh0ulA7kkzyB4yPfZYk2zMBsA5SF7v3Ka7w5HQ
	a0/uzDuOHamisM+16az9NdIFHKW3c9/gDyYATWbZQsi2GSY1qrMYmZPOq2kGBwkCZVPVTvLnVGs
	irCtX0q0fXq9GprdAOAsganZVbmACglT9sOCEGsKJTwb8GyEzAv4Mo/ZY9uk8sXVVv4OJ8+Im6p
	zY121Ljv7cLnzLH4e3zr+aSWPRyzfTf1sWctDhRmrvUypzQLYk01dYyaigSNCkPM53iI3mK5Crz
	s5PKyWcDjGo89HSrDrbi62EST/AssHF5VZYLqiLv8yIYt3iUvLVjmGBoSebBxmkZSmWSprMbLIj
	GPy+oHFWjVX1pvZPSklRnYcNKbbiWLSrxe+BFDErgkyU6AkMAuwTaXddquDADhVpOk8QHacBevr
	bGPoWdZdvY0uGt8giPNqXdDYefFRfHgzoeH05trQEftLpQkac3l0Abi/6crFimc+mpIa7zvVrMq
	VdTsM9rk7yjc3Q=
X-Received: by 2002:a17:90b:518f:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-396d0ff2eccmr4755412a91.16.1787869486538;
        Thu, 27 Aug 2026 15:24:46 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d22eacbfsm357857a91.0.2026.08.27.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:24:46 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 28 Aug 2026 07:25:49 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, benjamin.cheatham@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/events: Bound the event log drain loop
Message-ID: <apC5bb5KoCcIM6Nn@cxlqual>
References: <cover.1787768932.git.anisa.su@samsung.com>
 <20260826184417.1042-1-anisa.su@samsung.com>
 <ao-m-aFBvwCn4sus@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao-m-aFBvwCn4sus@MWDK4CY14F>

On Thu, Aug 27, 2026 at 11:01:15AM +0800, Richard Cheng wrote:
> On Wed, Aug 26, 2026 at 11:43:08AM +0800, Anisa Su wrote:
> > cxl_event_thread() drains every log named in the Event Status register and
> > repeats until that register reads zero.  CXL 8.2.9.3.1 Table 8-203 marks
> > the register RO and leaves clearing it to the device, so a misbehaving device
> > that leaves a status bit set spins the thread forever, resending
> > Get Event Records as fast as the mailbox completes.
> > 
> > Bound the loop on work completed instead.  cxl_mem_get_records_log() and
> > cxl_mem_get_event_records() report failures and which logs returned
> > records; the thread stops on the first error and drops any log whose status
> > bit was set while it returned nothing.  Every pass either drains a record
> > or clears a bit from the mask, so the loop terminates whatever the device
> > reports.  Logs are drained best effort, so a broken one does not suppress
> > reporting from the rest.
> > 
> > Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  drivers/cxl/core/mbox.c      | 58 ++++++++++++++++++++++++++++--------
> >  drivers/cxl/cxlmem.h         |  3 +-
> >  drivers/cxl/pci.c            | 39 +++++++++++++++++++-----
> >  tools/testing/cxl/test/mem.c |  4 +--
> >  4 files changed, 81 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 7c6c5b7450a5..5954ba20f0be 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1059,8 +1059,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	return rc;
> >  }
> >  
> > -static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > -				    enum cxl_event_log_type type)
> > +static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > +				   enum cxl_event_log_type type, bool *drained)
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > @@ -1068,12 +1068,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  	struct cxl_get_event_payload *payload;
> >  	u8 log_type = type;
> >  	u16 nr_rec;
> > +	int rc = 0;
> > +
> > +	*drained = false;
> >  
> >  	mutex_lock(&mds->event.log_lock);
> >  	payload = mds->event.buf;
> >  
> >  	do {
> > -		int rc, i;
> > +		int i;
> >  		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> >  			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> >  			.payload_in = &log_type,
> > @@ -1094,6 +1097,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  		nr_rec = le16_to_cpu(payload->record_count);
> >  		if (!nr_rec)
> >  			break;
> > +		*drained = true;
> >  
> >  		for (i = 0; i < nr_rec; i++)
> >  			__cxl_event_trace_record(cxlmd, type,
> > @@ -1112,31 +1116,59 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  	} while (nr_rec);
> >  
> >  	mutex_unlock(&mds->event.log_lock);
> > +
> > +	return rc;
> >  }
> >  
> >  /**
> >   * cxl_mem_get_event_records - Get Event Records from the device
> >   * @mds: The driver data for the operation
> >   * @status: Event Status register value identifying which events are available.
> > + * @drained: Optional mask of the logs in @status that returned records.
> >   *
> >   * Retrieve all event records available on the device, report them as trace
> > - * events, and clear them.
> > + * events, and clear them.  Every log named in @status is drained even if
> > + * another one fails, so that a broken log does not suppress reporting from
> > + * the rest.
> > + *
> > + * Return: 0, or the first error encountered.
> >   *
> >   * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> >   * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> >   */
> > -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> > +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> > +			      u32 *drained)
> >  {
> > +	static const struct {
> > +		u32 status;
> > +		enum cxl_event_log_type type;
> > +	} logs[] = {
> > +		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
> > +		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
> > +		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
> > +		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
> > +	};
> > +	int ret = 0;
> > +
> >  	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
> >  
> > -	if (status & CXLDEV_EVENT_STATUS_FATAL)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
> > -	if (status & CXLDEV_EVENT_STATUS_FAIL)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
> > -	if (status & CXLDEV_EVENT_STATUS_WARN)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> > -	if (status & CXLDEV_EVENT_STATUS_INFO)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> > +	if (drained)
> > +		*drained = 0;
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
> > +		bool got_records;
> > +		int rc;
> > +
> > +		if (!(status & logs[i].status))
> > +			continue;
> > +
> > +		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> > +		if (got_records && drained)
> > +			*drained |= logs[i].status;
> > +		ret = ret ?: rc;
> > +	}
> > +
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ed419d0c59f2..cb5372eb2d85 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >  				unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >  				  unsigned long *cmds);
> > -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> > +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> > +			      u32 *drained);
> >  void cxl_event_trace_record(struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_log_type type,
> >  			    enum cxl_event_type event_type,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 267c679b0b3c..3daf17835c06 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -514,21 +514,46 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  	struct cxl_dev_id *dev_id = id;
> >  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > -	u32 status;
> > +	u32 mask = CXLDEV_EVENT_STATUS_ALL;
> > +
> > +	while (mask) {
> > +		u32 status, drained, stuck;
> > +		int rc;
> >  
> > -	do {
> >  		/*
> >  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> >  		 * ignore the reserved upper 32 bits
> >  		 */
> >  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > -		/* Ignore logs unknown to the driver */
> > -		status &= CXLDEV_EVENT_STATUS_ALL;
> > +		/* Ignore logs unknown to the driver, and logs given up on */
> > +		status &= mask;
> >  		if (!status)
> >  			break;
> > -		cxl_mem_get_event_records(mds, status);
> > +
> > +		/*
> > +		 * A failed drain leaves the log's status bit set, so another
> > +		 * pass would resend the same query forever.
> > +		 */
> > +		rc = cxl_mem_get_event_records(mds, status, &drained);
> > +		if (rc)
> > +			break;
> > +
> 
> Hi Anisa,
> 
> IMHO, this new error path might leave an event log permanently undrainted.
> 
> Now cxl_event_thread() breaks on any error returned by cxl_mem_get_event_records(), which incldues a temporary failure e.g. "Retry Required" from Get Event
> Records or Clear Event Records. In that case the log ramain non-empty.
> 
> CXL event interrupt are generated when a log transitions from empty to non-empty,
> so after returning from the handler there may be no subsequent interrupt
> to retry the drain.
> 
> Maybe we can use a bounded retry for retryable failure ? or schedule deferred
> retry work before returning ?
> 
> Best regards,
> Richard Cheng.
> 
Hmmm you're right...

I think a bounded retry makes more sense since scheduling deferred work
still needs a way to eventually give up if the error or status bit
persists.

Thanks,
Anisa

> > +		/*
> > +		 * The Event Status register is device owned and read only, so
> > +		 * it cannot bound this loop; records read can.  A device that
> > +		 * leaves a bit set with an empty log makes no progress, and
> > +		 * only the device can clear that state, so stop polling that
> > +		 * log rather than spin on it.
> > +		 */
> > +		stuck = status & ~drained;
> > +		if (stuck) {
> > +			dev_warn_once(cxlds->dev,
> > +				      "Event status %#x set with no records to read\n",
> > +				      stuck);
> > +			mask &= ~stuck;
> > +		}
> >  		cond_resched();
> > -	} while (status);
> > +	}
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -682,7 +707,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index a7da279aa3ef..87e01612cea9 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
> >  			event_reset_log(log);
> >  	}
> >  
> > -	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
> > +	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
> >  }
> >  
> >  struct cxl_event_record_raw maint_needed = {
> > @@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		dev_dbg(dev, "No CXL FWCTL setup\n");
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
> >  	cxl_mock_test_feat_init(mdata);
> >  
> >  	return 0;
> > -- 
> > 2.43.0
> > 
> > 
