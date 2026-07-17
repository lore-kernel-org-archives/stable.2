Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2449620
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305917; cv=none; b=IaK6YsowFK9JO0o2sgvw6rQV2iPjG8wpWFWG5QBvX6cYmassXNuGIecxIFSl47CA49j/3ST7UHiTtaMb7FHEZ8E4vMXJbzcfhs/ntpHcF064rVYvS2ehjNYthOlJqr807OloanUCUVmrnBsnq1n6doDA61Luo0LNEOriKgc5XPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305917; c=relaxed/simple;
	bh=CBfSqK2AvgdhR+Bzp0CO34iyovUNpliOo+OgVtl30zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chXlvqpG7IgWioK1A3bvYaLAdUxfdPSgQEABZgbnmCuMtTie5Zs81WjpfqsItbpreDf9kg3ixYVMOXwf6huUXobDOWVQB0nUB7FWwfQ3pozYyZt9xJesmaKnofUru0afcZwSPwTiB+kvxlpx9QfV7UCOm8na+mJHt0Rxp3h70lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bsn0bczL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pmsu/1kO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bsn0bczL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pmsu/1kO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0HLfgnrtjxNOO4Lwlf1DY9lZMzmjOSTkB4j+MM+kqU=;
	b=Bsn0bczLdgO6ODU5YGth9ShbPJ3wdpdgDnC1jBL7O3u0AQtABAu140HnkQkgKOUUBfpdqf
	EXFDSvXEcYaXi08BbTS9mF3qo6YTRu9CPpnQvin+0HSc8TM0Qw/d9ySobltthCAgrMmqVx
	aF/Yiec2y5zrkD4bebIk9zTlYL1DP6Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-crRMnNYpPES22G3ukiL_Sg-1; Fri, 17 Jul 2026 12:31:44 -0400
X-MC-Unique: crRMnNYpPES22G3ukiL_Sg-1
X-Mimecast-MFC-AGG-ID: crRMnNYpPES22G3ukiL_Sg_1784305904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47162f83c75so1059597f8f.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784305903; x=1784910703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0HLfgnrtjxNOO4Lwlf1DY9lZMzmjOSTkB4j+MM+kqU=;
        b=pmsu/1kO3IEzA0DlV0HiXQ8K2bWbTiZGG/mO30bjNoIOvT6VJ+3+OJQGrwoECz/TPm
         R9N/2xlwrePe/ltmpQxigppFTDoz29ArGPTWKusY0ZElIpv2A7toofijes4u9FnTGlit
         kBNzgIcZdKJGFEbmRpelZVvrO0RVSewn+J8g4riTCBeWi3jA4KoMPPVBXElTrzZK2ft8
         eIg3VkFV79CWYc4X6SjQV0CRtFWpTjvCV7JhS05AsopW0CU2ylr6+nNFcEH8XTtkCPSJ
         JllRyuQcKxgfrmcDZnzLQSGH/RppFgitwC5jcIEgtlfGa2idBu7yg146zmyeydSsCUtp
         qDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305903; x=1784910703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0HLfgnrtjxNOO4Lwlf1DY9lZMzmjOSTkB4j+MM+kqU=;
        b=sXgcfNDPjXFbRBR3hpJfmsx48Lx8NC7VKS3M9zws2CSGlrQLYEiJExvG3+rntO2uyG
         jDe6tTnxXk5dFFQE0HqAK40X++Fhtrsy3twwcJvSJzFAJfD4G3Q/cudKHrskesBYl6qf
         yEa7lHygPemB932HnTjlqquSSVV4+tA8synfM3ZGLS6Vx+2WhtdlALfTE6ViPqzOvk9A
         0uQS1bYhO8BLVK0mRm4keM0vuX2w5bE8KHBAjfr0HOkLr4Oq9jUaC/DTkjC9hJrXofmD
         FbPOUWLrf/SnvE6hJYQh63BivbrcbzmrYYYsEwwn7J88qcaCnuGCjaoolPihMYjfAwGN
         BFeA==
X-Forwarded-Encrypted: i=1; AHgh+Rpka8x4+VHiSSeLWN0hBhWQGZ0c4R2sh2CboXrL+C8mrTDYDNi3zVPnDEOrPmLs1Yw4AQXASp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQ/aI246xw41gJ0l98y3ZKRUQe4buulcUQEvZBL0jbomYuDmV
	EVVRMfKRTusdEsvXpvzPuCojOR90eLGEF+d+I8cen3lduR0QrXZEXYpglykjuTJ/UnRokAXNsLi
	r15R87pM7yyQlYK7twTYtOzgmd7WWqf4ILSInMFBif/z8MmqlNFwsg4ceWw==
X-Gm-Gg: AfdE7cnLtFGnh6YeS4F++6+G4/rnRXe4LOWRCt/hvlo4q463halqPepjxX55rHlDS9v
	te+AtbFaPi1Fq/T1eX918jSQEuhT9u4k3XDIfZhYSd5JXAe0njlubZD+J7f8o2bYSnGNr/2XT8z
	vfoSUmBAu8sy59oPqsEwHYR3jwlvpxHFFP3ikvB0ylADRkQ8pJDdNwsTR4Tf5Y45rkiIK7apKc5
	6IyRu7pUeqRskb1PQ+Xak1drr1LQFqSbl1ciFccKmuENvtHegdFyIi/Z9J/VZQYi+TOHfiSt+jS
	Q8j7t66rBv7HL8MmS5oHt5SV9i4V64wJDnHsT7ImKjpG6RdqFPb8RESEMkI982tQb5qVsnh5zOo
	FRNK7XcEMdszJAzPdaPwvunBT
X-Received: by 2002:a05:6000:2f85:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-47f623e803emr4407846f8f.22.1784305903442;
        Fri, 17 Jul 2026 09:31:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2f85:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-47f623e803emr4407792f8f.22.1784305902878;
        Fri, 17 Jul 2026 09:31:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm5310864f8f.37.2026.07.17.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:31:42 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:31:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jia Jia <physicalmtea@gmail.com>, jasowang@redhat.com,
	Linfeng Sun <slf@hdu.edu.cn>, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Message-ID: <20260717123129-mutt-send-email-mst@kernel.org>
References: <20260717142205.103515-1-physicalmtea@gmail.com>
 <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>

On Fri, Jul 17, 2026 at 10:13:36AM -0500, Mike Christie wrote:
> cc'ing Linfeng.
> 
> Linfeng also reported this bug and provided a patch that has your check and
> an extra check to avoid calling into the function in the first place. It's
> been stuck in some other list.
> 
> I think it might be best for Linfeng to re-submit their patch now so it can
> get merged. For that patch, I think there was one outstanding question left
> where Michael had asked if the issue was found with AI so the proper tag
> could be added. I don't think that question was responded to.

Right, was waiting for that.

> 
> On 7/17/26 9:22 AM, Jia Jia wrote:
> > The protection SGL path passes the result of vhost_scsi_calc_sgls()
> > directly to sg_alloc_table_chained(). The helper returns a negative
> > errno when the iterator is invalid or the request exceeds the segment
> > limit. The negative errno is then treated as a very large unsigned count
> > and sends the request into the SGL allocation path with an invalid size.
> > 
> > Repeated malformed T10-PI submissions from a host-side application caused
> > memory usage to rise sharply. MemAvailable fell to about 200 MB, and PSI
> > full avg10 reached about 1.46. The OOM killer terminated several userspace
> > processes before the endpoint cleanup completed. The kernel log included:
> > 
> >      [17036.451028] Out of memory: Killed process 2345 (systemd)
> >      [17036.493325] Out of memory: Killed process 2349 (sd-pam)
> >      [17078.265127] Out of memory: Killed process 1793 (networkd-dispat)
> > 
> > Return the calculation error before setting up the protection SGL. This
> > keeps the protection path consistent with the data SGL path and prevents
> > the invalid count from entering the allocation path.
> > 
> > Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >   drivers/vhost/scsi.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 9a1253b9d..8486652fd 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_scsi_cmd *cmd,
> >   	if (prot_bytes) {
> >   		sgl_count = vhost_scsi_calc_sgls(prot_iter, prot_bytes,
> >   						 VHOST_SCSI_PREALLOC_PROT_SGLS);
> > +		if (sgl_count < 0)
> > +			return sgl_count;
> > +
> >   		cmd->prot_table.sgl = cmd->prot_sgl;
> >   		ret = sg_alloc_table_chained(&cmd->prot_table, sgl_count,
> >   					     cmd->prot_table.sgl,
> > -- 
> > 2.43.0
> > 

