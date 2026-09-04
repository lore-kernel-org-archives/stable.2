Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930494A3F10
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529665; cv=none; b=aEqY5A+g70W6W2IIemVEWs5LP8GT23S80pvNtnFjMJA4cSP/gZiDxrffcJyn/+6IoBM5HnnisdfztwX7Euk5nNI2/pGJBpARPAQjhHWK1sudotKx0jT0zJyrJZ+aV3KJ/2d5rHmtB1aGwWuJ02slKMyW52WN625SXwfn5nOJsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529665; c=relaxed/simple;
	bh=cBq6wHueU8RASUS0W1p6XPk2xPmU14bcM4eKdIsMnes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBoxUluvsXWAigf62GWC2DqnK9B4uL+13nBepGZD9XBPIIEFo+DJhxrIUYMDS3NXCsO4WftyHYcHRyHrmWJU8HAPLRPnExRfY0SCvSc0rqNNVpk6Lpz42xog3p6Dh+2iFBglWsG+6U4EdYOX7IwtRoq4tsgvWP5X4RVzMTTM9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFmN0dS6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4uT9h5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFmN0dS6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4uT9h5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjlwrWQHJKRIbDmuNmLm9kLZcbvN0tPgOtUVsjsfpm4=;
	b=FFmN0dS6B5va3eFFmXz1PyjTYvmC10SXZYyJtu2cmgG9fWaDxNElbgeiljVSN+kI7MfZ6+
	gE52Prt71Pye6swfv4TgrGXQbLflJcC/OXs2QeAV//U0Zm8lpF+NHe4JRk7vSksaewmoyu
	Txw3KIJkEXWUPB2bO6BHc1p4whvharM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-8GwMRp43P9KEILQE-ZIqbw-1; Fri, 04 Sep 2026 09:47:41 -0400
X-MC-Unique: 8GwMRp43P9KEILQE-ZIqbw-1
X-Mimecast-MFC-AGG-ID: 8GwMRp43P9KEILQE-ZIqbw_1788529660
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1f74261f67so112296266b.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788529660; x=1789134460; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjlwrWQHJKRIbDmuNmLm9kLZcbvN0tPgOtUVsjsfpm4=;
        b=Z4uT9h5dyOcofO8MGdAKBfoelt4d+GrG1tz6dufyHawEic6yg6fnLwX94qFwk3cL6j
         9eGu52GteKxgAzcveRPhT4Fh94ojKq0dI/+zDBuSqBXUHiAAWhZNm/InSGD5RwlrgLhV
         2V8AK+fVETUKAv84KpFjJ1H0V0F2BEqgc4ct4EPD0ZJTXm0JwnP2PRT2FjzrqRKngt/m
         Tsj/0zuJsSg2u+8Yk2ZYw/diCZmiDDhLIzkvG4+KfM657TPjR5I1gKJW2RJIye6bajy2
         QkLKCkSKF5KhBNEwscLYaxI9ITxMC+1sZoTOruE9LGA8xwPe8yttklkiELfvH2dSPqUE
         1GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529660; x=1789134460;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hjlwrWQHJKRIbDmuNmLm9kLZcbvN0tPgOtUVsjsfpm4=;
        b=Lblh+TKDgy5vsK7HNiFGZY70m30DSZ1cIC8/e4Be2c8uL7TE36UrNFrlufoKDqE97A
         DBzUaUmqSJjapXiQkfPXFsBvkd0ZNpSKoNfcyqDx7fYqZ7R5R6HXiXuPejABbz67ggeS
         ijOfhNNGHVF/OQp+hZlX1xnq2qQhrS4knhzhJ+NGJZFnHTSz2VtIOSJ8BPyfRWDFZXEn
         2tEx2nVhfZdyhpxzu2/knsEAhmx1fyWPGaTx5CQAcwedtzzMXVV4u0wmJvtNZTLkzbiB
         Nv477ZpOLuvSK2+PKT1pZQKzy8xfeAzE20uPDMpAe5YAlG5NJF25jJrmxdqpUJ0p+Ur+
         W9qA==
X-Gm-Message-State: AFuF++kusetLBIOioiC+p01UFCrsGKn/cFNdxeq8ApvDGW7wWt1yGHMY
	8c2HTvab2euECZDnM40Z9eC7pUBveiDLADCNsPlhGf9tRDmLxhV+I4djNdgZ9ad8UQgu4kiPcxO
	qcjgYzJysJ1jIm7AJs9sXqj7Pzn//M7IL5eN5XHBxmoTL32KJGght6QLFXg==
X-Gm-Gg: AYBFou2Owc3InmcL+yQlCA8kT/ChZHtpmvRYvEShyu54KJmN2IcQ7K+wDpv/K620N8q
	KRZIvsWgrmhXgsNz4hOTOXo3M2cE8AcOIxE/RIVpvfKhz9hn5rnHN7aRcdJNSWH/U+TM7Rep+H3
	3TGtrNvuekOFDrAeUgLL9pymWjiGSz4s8SPmaj5EMjMNLnM3p/w9LGrfPKCHmCX0U3XahxrfOVa
	4x1UUq71h5aP9v/bluHyAb+hVtIz8QxsYkQ4Lj+Fs2Wr3NyQFcshnSQ1gt6djziU7tXbbuicIiS
	g2ndboU42diYdd13wgiqbiyH8BKHs+qdU9hTIXdkoLqlLhavQqXbXPBMnwVAiXAX8KQcL1Oe/27
	Scr7NHfGd0yf1yh/4R7dtWU0tdzBmUo9WbGLi9ipZ83DUyyC6
X-Received: by 2002:a17:907:c81a:b0:c25:659:89ba with SMTP id a640c23a62f3a-c260c8d4e21mr258416466b.9.1788529659992;
        Fri, 04 Sep 2026 06:47:39 -0700 (PDT)
X-Received: by 2002:a17:907:c81a:b0:c25:659:89ba with SMTP id a640c23a62f3a-c260c8d4e21mr258413766b.9.1788529659463;
        Fri, 04 Sep 2026 06:47:39 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b89sm107918966b.10.2026.09.04.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:47:33 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 5.15.y 0/2] Backport
 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri, 04 Sep 2026 15:47:32 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <869896C6-D43B-4953-A7FF-901424202333@redhat.com>
In-Reply-To: <20260904094519.1817105-1-i.maximets@ovn.org>
References: <2026090351-refill-bondless-262d@gregkh>
 <20260904094519.1817105-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 4 Sep 2026, at 11:45, Ilya Maximets wrote:

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):
>   openvswitch: Fix CT limit teardown use-after-free
>
>  net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
>  net/openvswitch/conntrack.h |   6 +-
>  net/openvswitch/datapath.c  |  10 ++-
>  net/openvswitch/datapath.h  |  26 +++++---
>  net/openvswitch/vport.h     |   8 +++
>  5 files changed, 119 insertions(+), 53 deletions(-)
>
> -- 
> 2.55.0
The backport looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

