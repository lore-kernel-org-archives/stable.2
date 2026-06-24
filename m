Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA12E888C;
	Wed, 24 Jun 2026 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292919; cv=none; b=ZiKqwG9wj33Lq8e5Gm14ieXhxMtrB9Imobxrqi7pwaMVoWt+VeNQqnQF7aAWLL6/nTXAe1uvarfXi4kcY/r+T41kGSipNtVjMfHLmr4BzIjj/IYND79GmA1ygM+WeMfSy1vSC4sINAz1315DhvgfQfDpRJiI8GrOyIrcg4nAlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292919; c=relaxed/simple;
	bh=Azm7ubrMD6JXaz1VGK7wnsLESxv0MOeQLiK1k2gWfHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvbl3ESwUSZBq9p6Bhoa9iC221aqO7BOjpUGmRviGB/vY1+hvgKXHLgvd5odyJ3hJ1yIYOEYGW4Wz7fKFAxp9a/vNMrEUyWMJQoI2JwZWK/K4nOjTPKv2ALKD6V8A8w96sR++yAdo8xvz71gAmmALsMeZwJXj8UCHeC+VGU7mO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh5iugpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh5iugpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA68E1F000E9;
	Wed, 24 Jun 2026 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782292916;
	bh=0YQJcLtJuzVGfUWVmDrdkkmDKmjbJeRfmdceiM4w9ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lh5iugpkjX/cc6mo8A8+YoXd58S73NeSMjCB8sAUl+1MJe/6P8aw4q8kbegPWyH1V
	 WMOFhTDdCHjm7DHy+NOFuWzRM+YyWKZPEDs4XdTSdgOTyA9nuMcPli/RQkWxJq8dlI
	 bmquy31jm2e7JHr9eno/lXGM9ctZDETgb+LSKWpx09kGD+2veJ88RSugcRCWglwdF2
	 m4I8fQ/AUsey/Z9l+YIFaQNqBWeMNxI5UfvUCsF89OBvguiF1c5Wuxr9QNcJB/0oN6
	 3gAy43/ji9ipq6kBqwdaD1jAiqVVis6dOFPjbdgxeae6H+4rdO44AKW/+DdtBWn9cD
	 d9ah0HBY/O/9w==
Date: Wed, 24 Jun 2026 11:21:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <ajuhrzRodTlLAiIe@gmail.com>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623211904.3674-1-jason.andryuk@amd.com>


* Jason Andryuk <jason.andryuk@amd.com> wrote:

> Xen synthesizes the CPU topology, so the num_nodes and num_roots values
> may be surprising for amd_smn_init().  Specifically:
> 
>     roots_per_node = num_roots / num_nodes;
> 
> may results in roots_per_node == 0 which leads to divide by zero in
> 
>     count % roots_per_node
> 
> As an example, I have a system with a Xen PVH dom0 that reports:
> Found 1 AMD root devices
> Found 2 AMD nodes
> 
> Ensure roots_per_node is at least 1 to avoid the divide by zero errors.
> num_nodes are allocated for amd_roots, so roots_per_node = 1 will
> populate all the entries.
> 
> Also add a pr_debug() for the number of nodes.

So arguably this Xen PHV dom0 PCI configuration is bogus,
because it violates the roots % nodes rule, right?

Why should we not go back to something similar to the pre-40a5f6ffdfc8
state of things, which warned about such bogus configs in the syslog,
so that it could be seen and fixed:

-               /*
-                * There should be _exactly_ N roots for each DF/SMN
-                * interface.
-                */
-               if (!roots_per_misc || (root_count % roots_per_misc)) {
-                       pr_info("Unsupported AMD DF/PCI configuration found\n");
-                       return -ENODEV;
-               }

Instead of your patch which just silently works around the
borkage and issues a pr_debug() that nobody reads?

AFAICS the following fix:

  0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")

Never restored that sanity check & warning about such firmware
bogosity.

Thanks,

	Ingo
