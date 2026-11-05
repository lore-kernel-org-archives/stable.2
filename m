Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888686;
	b=NasvHqHxUv586qqOrrLc+4oPgqM3eBWKV0q960F3VRnVb73rPw99KRJx3VC11VNkiANz
	 NwxvIHzr1yVaE0+XmNOikrLVpP5WBHAvB9saFRJU0hKpF7oTQFShQisn8dfKScFY5FT4P
	 ey82J78uV4eZlJuOC5Wp9fEmTGPdkihtY9RWN7BHz3rM9zOgqeRUCxCezvT6aEaEyH6hO
	 XGOkklrcMD9Ds66zd+xyuctyBBPsxEsW+8p+JaUSp6g58w2rwP5dKlfVrXc2rOSKwSnEF
	 pGxffRZke83/ijcHnWLYyTpO8cAg1DmH0PIlul2RhOaZZDD72+7rgEvYBIi6sZpGwwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Whq/GeK8lJYp6vWQcR6l4+gWrLqDlX5gpLbTFWIZllg=;
	b=tO8O9y4iVM7EbQ2uZomUbg7o6RvAP2dbr/cgmsOJpl9R0xBIlqjHcDsvJm3eMcLNtTAy
	 C5P9qPSG6LSTuCquAHtVJ8npFlfbMwLD3hQ+QsP2IJzbwyfqeVcEGWjUFOjjs37Kynt14
	 J11ruh1wCQ3Wley+9VXynFK8+7db6bp8n7n7qlz8qoibiPHxzoQKGJF/skIlxlmK30OWe
	 oH8Ecpmv6x2DAiROwXvCSch+/0peBRbk7FFoH/24C8Ul3+FDyRHeg0VaAFJ7/D8su3afd
	 OdLjw7tarLWmxCKFynYXEcFDXpdznhOkL2yD2m2cZ/O0A3bHka2uhCTD9UROlUSCFqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nFoa9KRz;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85E606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C85E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nFoa9KRz
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a079256596so1728123b3a.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793888685; x=1794493485; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Whq/GeK8lJYp6vWQcR6l4+gWrLqDlX5gpLbTFWIZllg=;
        b=nFoa9KRzdugdYzLTBT+UUtYNoZvRI6P0geoxWFlfVUvaiMNQOD/OAS/Ect8bmHRecH
         ERz9Kj+q5++Nu7jlyUIzA0QTon07UB0y09yGR0SU1ULfRGvydKu7R0Zn/2ITkxGk7UPC
         3rA11ALeNUBB13T3XLjdTK0zWgYU9clH5+n0UiBqh7Wm9ng/kBptFmDi08rLuiOBiARq
         PfkQFMoztwa4uO+Qzv/lmop/xXmEy3Ev0n3F/YoPV3DPu/gNsGI0oHO9fp4SXAV51djT
         XSPpcU7IOp1nbiagEp+luCMvUuJuQ9Vssqfhb4bERQSI4tSdQ7fqB6IxwVHqD102HDhw
         AWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888685; x=1794493485;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Whq/GeK8lJYp6vWQcR6l4+gWrLqDlX5gpLbTFWIZllg=;
        b=npgBQFcNPGGAqD+PUuAfwXH2k3U3byFOQFQ/S5ugIdQnw11PTHD3gJS7LsqDbj/MZk
         K8x+nbezfOieKEYHa7GkSue7u+2DcthWenxhSPHFq+JLS3hZbAj4ISiNIUXTo1sd47ES
         v6kp2778xVAPTYb7l9OG1O0Jid3guv3XM4ZSWzMBdfJHc2vjTp5Bp8W082zKV0cn/gkW
         VG7FigDN4Jaj/y6NuzzO35Za1sJ9cE0myP99Ey5axupsQN6/TmRhNVCXaw9amRdSeiiL
         PVb2PdFDygPC9OF4PkDnaC03ZMVSev4IPX3c/qeS+2TIlcWMKE5KY5ea5/+v6h3XJIWI
         zZEg==
X-Forwarded-Encrypted: i=1; AKwUvBwjvnegFn/PJuOv9O+aBzbA52kkWSHP0YuDxRtMQnpCWdn4hhqtI136XnQBUuy8F2U7krSZCJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z98Ti/AGzcGi9oI1rhlDWN4Sr3JRR7N9T6wiFhyhCKc+ht+Bt27
	AagA4515hsVDcYqGUAnSVdjXK6XqjWf27HrtvvPUMc+QFHYVa6FiXuUoV/FtWpwfZ5ZnUJlD6k/
	ZlHUTKQ==
X-Received: from pgly25.prod.google.com ([2002:a63:1819:0:b0:cd8:2b49:af45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6372:a745:b0:3d4:52bd:b89d
 with SMTP id adf61e73a8af0-3e928d46807mr12909269637.23.1793888685125; Thu, 05
 Nov 2026 06:24:45 -0800 (PST)
Date: Thu, 5 Nov 2026 06:24:43 -0800
In-Reply-To: <2026110539-lived-blast-ef64@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104211043.516122098@linuxfoundation.org> <20261104211109.504581890@linuxfoundation.org>
 <dac4e304-98e6-4e61-93f4-8d971069d936@intel.com> <2026110539-lived-blast-ef64@gregkh>
Message-ID: <auyRq2HXJIfMXgBh@google.com>
Subject: Re: [PATCH 6.18 0942/1005] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Nikolay Borisov <nik.borisov@suse.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Greg Kroah-Hartman wrote:
> On Thu, Nov 05, 2026 at 03:04:56PM +0800, Xiaoyao Li wrote:
> > On 11/5/2026 5:11 AM, Greg Kroah-Hartman wrote:
> > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > There are some dependency patches failed to be backported [1][2][3]. What is the
> > preferred way to handle it? prepare a separate series for 6.18-stable with all
> > the necessary patches?
> 
> Yes please.
> 
> Do you want me to drop this one for now?

Yes, please drop it.  Thanks!
