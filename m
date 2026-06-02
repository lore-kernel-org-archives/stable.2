Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA513431E3
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403630; cv=none; b=dcYWc2nDpjxTIGr2WSDgNNBtm/D7MYIrMdltM6UUvYe0ObLInIwBn/Hg2exYtdhvy6PjpmBsjWjMtsSdXulhRs2fZPQu/jN2tzNL3zl2ZXV/NE24i/P4S7tqxpfWX3TlAbV+E69/KQJupVor1CUQKR1OKGU31GZqVU5VvknI9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403630; c=relaxed/simple;
	bh=Dt7ynl7RjMDm10IwkFbV7yaqQ3XCHkv1Jhl7dMLZbl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsDvI7GQYVSmfjdeJ+G5EGQiSeq/VJ7w0dPRiXjCTY0wRAcK4yFjKdZBceeKNXi+QVySDDhEWYxyoMFSJ/mHuSnx6AZGqEEef4W4QCQunh9xsoqPSui/6wwatxC+CNJ9/uFvyLKF/GmA+SYuVZhQs1oW5JrPnDDBpACXinSOtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mjg0KMTz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mjg0KMTz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176465a4a4so13345891cf.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=Mjg0KMTzNzeCi7FV4Cglipctnd4qTRNJBs44FcFTysdYrVy+WlGmP/0GDFu0J+wJ7m
         R/AuPEohevy1QNUE+WUDGubmJcDZZnffsV7i/Zze94JkqRPhbPdy15Qk6yh0s9q2hu1/
         bI7dm1G26H7om23e5xJModDeVrIOi0meO3NUWse+J5lk5WegiPpkj76Qz79IXx4wghAH
         J1I3OvFvwHvZLYWvaUMDTJFwu8CeiZpFpTAa6VbXuL1p2SxsoyL2H/fX/865+UB4pvvq
         PhJR1KIiS2V1O2Xw5dcvwmRIXL5LbfWF9nRanp+5gjV4eMn6+GEiDs6cHaCPjs+09FpH
         tsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403626; x=1781008426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=MYdI5eQcczE6ywYVsj/WD8HfPMFwGRc1co2MAU6dCPPxqWbUWmthXlJ2qaVwnCQYsR
         ZnFtbCFV85rwToSCFIKkG0IM/CkgzAneY39RKvc+mjaLiQ0Uin8IoqBQRh42uOyuX0ww
         5lomYrRtwh0IGSUOmfC4mrIvONmVULP6iiyVVhI2VDB5+X/x0Y902vnsXfRsPpMjl9NW
         IoZj7sm3Mw6QpjF+VTEE/4L8xGBYkhPgcKSB8gn+4rSUfgrpxWG5xnxDgaION2mhfAwv
         lxDNYBO0Wcd9wvn7egJAdChbLzTkkQu7ULPcVssKSt1DWKEIph4H2g/1XVvaRmCD6TTf
         6/tw==
X-Forwarded-Encrypted: i=1; AFNElJ8DFtrJw5wui6H1roGBNcGy3il/EAILIFvr0h1H9D0j9tzuvCPRGYqh1xR7QlWsvHeEoO4kCpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nO0RhspvajIEL0DqDcbevUD4W5BRKHGJ2pMdb+svDuK9MTOm
	gPnOTnpdt6pE6F30MDOtOM1QvFJePS1/6FomaevoGdhDsQRZG8u/hO0g407e+4tDEaQ=
X-Gm-Gg: Acq92OGvNuJ0ZEwK2IDEPtIqk4FSgSKU8jlcwTTiGYwHOEGawPAAL3weQLNRKIXzCzk
	ZxGO2Y8cgnrHQZEywFr4IsEMgAMK+3YNw9PzVGt86kEXjVXHxZNivbEIrAhhKude9lhkRLjgH2m
	l6sHafm1e6Y/ZZu6YokkeLMrN9+pQ281acPRhin/C4ihBYpm66LpW6cwrUjjbWf0jQjeoM1YQH/
	zgGBCuJii2rzW8YYgOFQaWVlQPct/qA6lUCHE6z8y8/fUaDYqvDA+C1/VGiVUz96Gljfyqc6hPI
	caXH3ZSfaxTVDVTrexd1rzvDK7lIDl3uEh6/yp0lTMGBsIoRSQRkKpNMHTeFwRb8I31qSoN5+U0
	jvfTLfAOfIai9Mz3+Nd1j/1NStEHkk8NGmVoE7ejwKcP0ceQALYcl+huhdLUJbCOwkykYmePkd1
	PD4trKnkHwXmCBI/iGfFBB4LJ7dbRQiyKXlmY7cLBLOx/k2Fq5hTphZlmUb/TK7N6PUUnpOdaXS
	z9rqmwWWf2wVcwu
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864;
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOJU-00000003m5x-3DKO;
	Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> get_free_page() (or how it is called)?

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason
