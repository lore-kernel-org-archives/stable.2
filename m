Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AE38E5DC
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853859; cv=none; b=TzwTQdlt2BwpoYSpEEaN7cBWBTHjpi8yxNRiThaeWQZAyFgcBszNMjZNsxwtzRVbytQmDgGJBzUSE13d+8gBbVsIbXpEBr+W9TFoZ3Vb5YEe+qQJzEp9UVGXwVuhNiU/Xdk9nkrMWaDz9/XPGMabCt0Gnk/IoOLhk52vw4RCF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853859; c=relaxed/simple;
	bh=o3Oc7rmM9lT7AfEl5LvYKTPYdGrqRUOy6fz+MXd2ZKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVfmfkps8pCP/yO9Z53Qg88Z0aB+I8K9fn0ExGx3MwtsaKN4ja/XW8BD5joBrSKb6oRNHJN7PBTHmlLGEiyZ3UhkuRf0RiwSbTcOkYTbH2ndj78RM8gflaKhp8Zn5mUTJjLaaG05COa74KgSPg8/dGZrAkpcBLMLqHaabGdUHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9puEWvq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9puEWvq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39686abd426so376327a91.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853857; x=1788458657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0XDbj7f6tQ755eLA7AnhMP9ORnA/7/dsePHPY0OVX0=;
        b=V9puEWvq/rKhy4PCZXv+PN2J1gOHzKf47nXrOSoyaJd3lOfl7pHWv4JxjMjwJ2FEjl
         9NW3FzOQb9P369470ri2L4jkZkNirRF4n/10KsaS5STohLgWUOm3OAzysjUWte4ov7J6
         lI9MDoBK3eNHfzQtCex8AM+1VzE8bPvjuIWTwJ5Qd5E5ALTCJFA5uD9ln87HoroMdMdK
         8dBlhP53GdrkwUUPbvgeYCVUrlnVtxfwqY4vYiSWRevwOIM9O4TcHkxOyz6XL3aLww97
         TY5caNWpqxZadNcxg17gkH1kuS5TqpPFBOS6mogQf8BhlX0ehc0Ix0YvmPdv77HHqiWv
         UGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853857; x=1788458657;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0XDbj7f6tQ755eLA7AnhMP9ORnA/7/dsePHPY0OVX0=;
        b=ZBDsfIdQIQ6lqQGAArCmwRkqbvWwO30m5ew/1VaJuQ7+XKMNbnTRmQjUp93y3PTkc8
         1hNs7pKZ4x8GCaExRdhn85GxAAlyNDdvCi0T7sCj4pHIkS3m89LwG1EV6hapRqoiM3PD
         pQuB/Zh5mz2zdqltDOp9DPcwZ50Bi4ngYpSpSUgxzjgga5prHD74cJVYC/wz429W59MX
         OUqRVX4A7T86h4eRnFQFY9zys2p4D4r/EmgxONMHSd+j5V/ddV+Wc9d36ChC7DjaEu3f
         /G5oYnn6KR1Mv4Zdgl8cGBd8ZRsznRuI3Q/mV9Vdc65dJ2mMOxh/wi5aMI2Cj3ObqBxk
         uYGg==
X-Forwarded-Encrypted: i=1; AHgh+RoH0WhJBlSLuuuv1FYZ4e8KfTNV12StUX3QLqv5doX61v3TaI/fSgwmN6nMptKt8+OZZ2qd1+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mMc3jBz9TISkWugdhVqoW+8A9L2iXxjtpIniqFJhla8ClJT7Wk
	y7pcqwIo4NnUkCTmP88XVaE3QxV3QKzs8l0L94ueII1odIk8Qk5B3E4D
X-Gm-Gg: AR+sD10itn0sWQCtZySpUzlBu8Tjc7td3N0Tgc23Ny0nGzQ0/VJAG0YnPQnf/X7C0XV
	TFQxxvv6L3vI55J0BgzDqmAFnUn3WMBK9gMIf98CJWX72qUAP3MUIEHqYaK2rVHagtq/6vpPUJi
	DZSz+LIVNT6XT/tJIzr9Dq11hmr1iOwdSj2h4j2LAIDLIhQTTOGd+8uTsUYGeh1lFmdPPo6jMv8
	vLPKrlPaxGB8M39ck40pSLliiLI1KgIY0D9Wkr+eynwB07PsejilkNevuxY6u6Mlvwg3eXA1Oae
	S14wGit5SOjGNzxsTpXDCmpVt0W+uCvuqjIkiJk7SRnMVMBsAa52BgZ8g9+2ICdM4UCeaK6TcUO
	YmUQiWVdkwdpUSEsZOKL8yi/EWyZ2jp4tP+uqpE3QOB8fNIMPAfi9y2rUUXc3NfkAlBZTMH/l6M
	xfYlhgS6RW9v65PuWI6wyYwFRxjlWsYJwbKH9pw+f6QqXkcun05xn1vCJnf48f0K4OAesF7//Qi
	hIst5Tim+w7VZYi
X-Received: by 2002:a17:90b:2f0f:b0:380:540:d499 with SMTP id 98e67ed59e1d1-396d0ed0023mr2113371a91.6.1787853857127;
        Thu, 27 Aug 2026 11:04:17 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd0079sm3787524a91.5.2026.08.27.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:04:16 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 28 Aug 2026 03:05:20 +0900
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/events: Bound the event log drain loop
Message-ID: <apB8YCnfiPlIXqkP@cxlqual>
References: <cover.1787768932.git.anisa.su@samsung.com>
 <20260826184417.1042-1-anisa.su@samsung.com>
 <472850c6-0f05-4444-bc09-bd9f513c8838@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472850c6-0f05-4444-bc09-bd9f513c8838@amd.com>

On Wed, Aug 26, 2026 at 04:28:49PM -0500, Cheatham, Benjamin wrote:
> On 8/26/2026 1:43 PM, Anisa Su wrote:
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
> 
> One nit below, but looks good to me regardless so:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
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
> 
> Nit: Could this get renamed from "drained" to "got_records"? You use that name below when calling
> this function and there's a bit of overloading of the name drained in this call path that makes
> it a tad confusing.
> 
Yeah sure! Sorry I'm terrible at naming vars...

> Thanks,
> Ben

Thanks,
Anisa
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
> 
