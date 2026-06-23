Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8539E9B0
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195105; cv=none; b=Er7smNC1VMxrjtpDe+jfTYUTSkR1mIvQlUBQQ85mwZrtupd6A/rEQ/u+T+XKryzqCTYci8YfKK7gKG/SBquILaXnWXCuWa5Y+/rc3vludUqy8UbRqtC+ZmGN9LgVO540vUrgZ4JXpJwYeWXNxs1sjDCMwuVMDEShjdCa0OzTWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195105; c=relaxed/simple;
	bh=lbPIcbZwWKO9mggxTz7p3Nf3bUnQJxUwEnf9iEg+jNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkmlT814S5MT+i0bhKKb1W5X2qTkEeaa+GEIEl/0chcLSYq0PrAuBjPOokus4oHjbX+dka7V0mq8VZGXOYN5AiKhxPF+Py5cxz8B+OloF5dVExUNSH3ybsxVKnWCqbUfSxSVY4kgqqFViOtetMJ44Dizh28n9Nf+MEIExPT4Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W/lpISAD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W/lpISAD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49249707788so20864875e9.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782195097; x=1782799897; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEWRyTTg19ufsww9mTBAfvx9IHHIlg0mdl0hqLyxq/0=;
        b=W/lpISADcxduaZNlocdKjZzyD3/aYeFeFse0gyPD6hliSxtm3l/HldHzEkne38zin2
         clRIZPQyy8YlF/4yIDZ2cWzxhxICI0DB9g//8m4H8JIniWoXj4iDpkR8iXoBRAZRAX6e
         RCkh/hk6hpOeN4OeklOD1VOdqUIgv4ZOpHoI1nskcoBeXa7po1jxCqFgDPAMIZCTxnG8
         OQ67VPfh1DmZ1XI18rr2MUH5oTTYTCHs0Jz7y6oXnCioTw/plVsP+36nXBPt7ytF0VUQ
         jxlMy6GYftVkIlxvIjr/qv9NDXnB2cCKLojB5MHlZ4LGpMzdpwWlDwRkQdzrcKpzWk3B
         8NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195097; x=1782799897;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEWRyTTg19ufsww9mTBAfvx9IHHIlg0mdl0hqLyxq/0=;
        b=rvXt9ZVjsGNUXrJWbepgAFXI886sVnj4p9g4tB00GCBpRHWoCfxF/Z6M8GoZ2k/1FR
         u/de/jM1ZkWk23Dsh2HavhF454oaPc2PjcqkuvdCTvi7gEgIdxCpKbhgG3ocKMRcLyKs
         wcu/DeQJw6bcfpdTUARC5/JT+kf36U45v3hELDf9h7k94E/8SwYbPRoc02VP0SwSHWob
         KAiRsIXmY5U/HiCY8U4WutoDG3Hu018gZdoyDy1ZKVDIn4haIaFc6eVyHKt0UATiireu
         3Y5N4bQVsHrYS+EVtHYd+7JQuDoknJbmnRjP7pFL69oOF3b7fqSu8dp2PmUpSf20Lvzq
         Gu8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+96mdFu+jVTLoextX8XFeps9GQpGXXAyYdoj4f4ogtEP5CUnuusVUHdCuDFuEXLbD6lwX6jtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2oMLiOMeRXRY4G9BJMtz0oQnub6HbjSrW3ZoOXVD+SSTGuuQ
	mE6nSjYmL4VDcGNdEjwwAO7OsfAL1QPZCMtpLGENnO2c85CkurvQo/Z9v22VeFw/ylM=
X-Gm-Gg: AfdE7ckMQ0NbRXx+h3EROGKtx3MicKrX35Jsb7/4GFhdPh6LtpAVfMe29pXGGWjnlhv
	g8mNOYk4SVA/J4JLo9XyMaeQUmH9djmg/Xj4o2zylCm8IcxDY2nhoLggrDWD1IteY8OVoibg4dE
	eSEdsq/GZ8zyV40l6UAM2Mk0Q5Sau0y9BD2bmvhNy1VerYDEENZYbQXFjKIUAazJXKUS/Dysypc
	5+VnP0ZZarE5mH2kRciqD1RBJm69G22b9W76effLhhTXTajPv5ZNhN8rGMSsf7uzDTdCi1LUK0J
	5/7PmeCWoE0OKL4zUkuuK/OJdhN45V9jQZMIaWySarh6YSbcnDF+a6rK0NItYfGap2601xaTjCV
	uNZK4BeiTk4tEPCVLYKkIIEWf9ds1Qj2TLuzh6GoocneBDDJN19MUT/hLrMA/6cx9b0NWNo5a7C
	TVGXY=
X-Received: by 2002:a05:600c:4694:b0:492:4717:59fb with SMTP id 5b1f17b1804b1-492490a77a4mr214171985e9.17.1782195097216;
        Mon, 22 Jun 2026 23:11:37 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1aa48f04sm2986708a91.2.2026.06.22.23.11.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:11:36 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:11:30 +0800
From: joeyli <jlee@suse.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Message-ID: <20260623061130.GA11413@linux-l9pv.suse>
References: <20260615104750.1000-1-jlee@suse.com>
 <30561ae5-1e6a-4cc2-99e2-436c88b2f11d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30561ae5-1e6a-4cc2-99e2-436c88b2f11d@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Disha,

On Fri, Jun 19, 2026 at 04:41:57PM +0530, Disha Goel wrote:
> On 15/06/26 4:17 pm, Chun-Yi Lee wrote:
> > From: Chun-Yi Lee <jlee@suse.com>
> > 
> > Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
> > changed the `mmap` file operation to `mmap_prepare` for relayfs, but
> > the lockdown check in debugfs was not updated accordingly.
> > 
> > This prevents debugfs from being locked down when the kernel is in
> > integrity mode if a file uses `mmap_prepare` but not `mmap`.
> > 
> > Since the conversion to `mmap_prepare` across the kernel is not yet
> > complete, update the lockdown check to look for both `mmap` and
> > `mmap_prepare` to ensure comprehensive coverage.
> > 
> > Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: driver-core@lists.linux.dev
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > ---
> 
> Hi,
> 
> I tested this patch on ppc64le with lockdown enabled. It correctly fixes the
> security issue where debugfs files using mmap_prepare were not being
> restricted.
> 
> Test: blktrace/001 from blktests (uses relayfs via debugfs)
> - Before patch: blktrace bypassed lockdown and accessed debugfs
> - After patch: blktrace properly blocked from accessing debugfs
> 
> Environment:
> Kernel: 7.1.0-rc7
> Lockdown: integrity mode
> 
> Feel free to add:
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> 

Thanks for your testing!

Joey Lee
