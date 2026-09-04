Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921741684D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527634; cv=none; b=Gvjs4H/KRMxD8+WPT8rGRJEAEPaU+HMIIOrKH3WO9E3J2/RWipHitHqaSshSjSbT2VzNeuJAw1vf75IiqwwleUx0/v/CE7PhOGjIwalC8CxOCB+EpOzzF45lP7eFbxdBPInWI1XlhwQXx92TMKmnL+OoXRpXl+BORHLoM8eqpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527634; c=relaxed/simple;
	bh=qeW9HjB/GlkaIQLm8ZbJVD+c0HOdwkjWG+Sfd7Hjcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+KGaAt58Ek3WVsbgDfwDaxoDVdO/YriqtkIrQO0sZbyvN6BnXJdBDVUdPVas3ZIcDJrBoVpFuxlw1WZnKjJfNbDPiIs2F7jdxoMPAintVjo+5phKkWQywJNsWHiKIX2TBVdN5vdrPbIbqegQo2L34/7BMI6qycAOMZVutC14sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roep+fbF; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roep+fbF"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1c75f0049so763905eaf.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527630; x=1789132430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/o90ljmvuQQUSHocuJOX1OqLfyNrCD/R11+CTsvEbww=;
        b=roep+fbFqxg5iARC6e0T7klxq8PXaQgwZI06wgAhPNg53hsBhlxDq/LZoAaouTYjDd
         1sFmkD/Zbpsx82iPLR2Jac9l2YLmsbnPctkS/PSHzLU37WGek5qqeyJ8fZm+nwnDx6Yz
         Sg4NRJFAm8JyIYVI7Wl7Dr0eYRcBEuyfbkHvomWMwx4U+ZXTlFLESp71wEc8N+6eR8ef
         vzX9WktyJendVdsoNHMSvkfUOjzdZbo91N7cZkOZMvgw4pJtugTolcQxLl8pfNsnjIjn
         2OzIKZny+vvmI/NaN+kBVN61O06MCipInM9ApD2sHQBjrxm7gwL21myVjFwQFdHALgJG
         5hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527630; x=1789132430;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/o90ljmvuQQUSHocuJOX1OqLfyNrCD/R11+CTsvEbww=;
        b=Sx6tENwbOWasmTu0aHe11LceeBeL1aAlABioFGC84Oe0Cu+DiEZawnhiwJYGVsRVRW
         EfV+vR2WIdXl7B2yEDOR31JIZIJlmyTliiuWcC2OWII1Mx/TeAnpjfrzwv8GmdErorCB
         22NLjXNWLczjauNCrCnwHy+4OAf9vZWwCjCLRuLU/ihDkeAq1y6OBNepx/WPFQF5+oKk
         u0w5hNAhU5mTltrMY3LmqjIuFrhtX3qFvYyL3NgCjM7eeeX6OxQOM5VnX23v6mjGtGoo
         s6jFKeXpyjStSZh7ufoFzDypbKstKHBrbLusfUIqtBbMMx//4/dIvF4lbXCN3BKTusjo
         v9GA==
X-Forwarded-Encrypted: i=1; AKwUvBz0PU9fiOqbepMhDJ0hW5ExibtwHSKOcaZL5mqwqQmXzLe2XKAjMO6250XrY+D7g5NnQ/JF3as=@vger.kernel.org
X-Gm-Message-State: AFuF++lVBTPquSYNxhUsuZ8XyvKCV7Rk/l8XF+61pRGi4CfxVNbQdw9F
	9CmuNxd9PRPN+Ih8TsjMieoPhTd6W4ZnOe+h+yd3tE43B4pe2BE6YkbX
X-Gm-Gg: AYBFou1JJCbYlKciXXQWD/Hk6q0zICYHD8XRljL9qbzYQxngoNjfyy9kEIedyjPDSls
	ac/74oHmEgKGnEiUm0GNgme1Ke2hVkAVB8ROavwyR/hwAgtsg2zszf9Jfbr5k+gzYSX0AhgmmAT
	DKhbt3rqtqMBuLkuQzCXtkA/D2BxrFcXS2ANkhdb1POGD4MV4ThMs56BmMXAZHZlfcdnFojzafp
	M1Or2e0onBJInLpG3espac6j28DpF+mnPbhJuD3BzEe0CAvFFPVSO0ZlD9scZgcq4Y4kANr0PtV
	zNfo2XTGrCJyQTNYEPJ5nj370jA50NHYmRf5TB2BhTV/ZNNMvIgXFbhl8mBOJEzzYT9xXjTRibZ
	GMFThvPuy6UtDBpsXYCHcEbaQKMdKwJXhwWnvzK15yEzU4TyAFWTd+49LsOikpU5b19YBqm++Ev
	ERlgPAIaMnV/QwbnhTGe8MCUN52G9O1jsJ0HwY8HngZYvST4Rt/h/Nl7CNKSQNiKakFjtjob3rA
	5KxoT3HWYwqpowOfXyDH+4Xy/rMcg==
X-Received: by 2002:a05:6820:162b:b0:6b7:46fc:1cf with SMTP id 006d021491bc7-6b746fc2ed1mr2604016eaf.46.1788527629952;
        Fri, 04 Sep 2026 06:13:49 -0700 (PDT)
Received: from localhost ([2409:40c4:180:9098:c5e4:83d7:dd06:4e15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm10301543eec.15.2026.09.04.06.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:13:49 -0700 (PDT)
Date: Fri, 4 Sep 2026 18:43:43 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Pecio <michal.pecio@gmail.com>, Mathieu Fluhr <mathieu.fluhr@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from
 runtime resume
Message-ID: <apq4FFSD2QKG-jUu@eggarch>
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
 <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
 <apbrp8EaJoIfEg5X@eggarch>
 <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>
 <apg16LtZ-ru9MIBQ@eggarch>
 <082467bf-d045-45d7-b097-97a5790e79d6@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082467bf-d045-45d7-b097-97a5790e79d6@linux.intel.com>

On Thu, Sep 03, 2026 at 10:42:48AM +0300, Mathias Nyman wrote:
> On 9/2/26 21:21, Lovekesh Solanki wrote:
> > On Wed, Sep 02, 2026 at 03:10:41PM +0300, Mathias Nyman wrote:
> > > It's possible PCI side or pm core already provides some easy way for xhci driver to check this.
> > > This specific issue is currently not on my todo list, yet.
> > Alright, would you like to me to work on this? I could look into
> > that side and possibly come up with an approach.
> 
> Yes, please, that would be great.
I took a look at the PCI / PM side, and it seems to me there isn't any
reliable approach for xhci driver to use right now.

The pci_check_pme_status() both checks and clears the pme status bit 
and the pci core devours it inside pci_pme_wakeup(), and 
pm_request_resume is async so xhci's runtime_resume may run much later
after the bit is already gone. We can't simply export pci_check_pme_status()
that wouldn't give any useful info.

One solution I can think of would be adding a pme_wake_detected bitfield
on pci_dev struct, we set it in pci_pme_wakeup() when PME is confirmed
and we clear it in pci_pm_runtime_resume() after the driver has
returned.
Then, we could directly read via pdev->pme_wake_detected in its own
resume.

What are your thoughts on this?

Regards,
Lovekesh
