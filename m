Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50223EAAD;
	Mon,  8 Jun 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933191; cv=none; b=Sl8uXm0/xyUskWbWDRD3bp4d56N3HpWUP70YrIcIibn4J6ERoRQl+dYBJzhKl8U4gIeKGbseoz173AnKINd9rTXdQRrhRUxZWbNVf8StVJpGy6BGBeVO61RL1aDxXmQpzJm/0wgVkajGQswFISuk5hcj+MDBFe5rghPq4axsOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933191; c=relaxed/simple;
	bh=RUgZeGhk3mrRGKLYq0a/yy5JNCEBELDVcua38Q5Kkds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CC3QtwPVfHrO/ZkcU5LatvsFBDkKVp0BRMFG8LdoQHwV/3UgdqTtHkXolrloegm6CoRBng+AUsZv1BQkIO8JRZv20u0aRKCivV2e9Dh0gQuI7srPh5BWnJkHv0Uxni95MiQFCGGYBeT/Yc3ms0VCY1OABrOFp8Z7ysmJCgzhbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASw9aDWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASw9aDWd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5FC471F00893;
	Mon,  8 Jun 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933189;
	bh=N3oy4xmq4C4ND1356+b9YpxpOAFUgRGxgZuuCWGlALs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ASw9aDWdRcO7+VnSW2ORQGoUq5sR68vKzzC5eSwoopKcdBsNabRop9c+64TT3Q8q1
	 OZCkT82Xu3lHjUeb11mlsrsVw/S45chKYAyMTNAUji+8Avn2GqonWR3Sdt9keDJ9K3
	 Rp0phRCU8VvKmlicMoRxl//sXnhu7b5+p/bD8/F2m/nbRZIRLOPxtHG86//XU8uEBv
	 oBf1QOqvaL4iOZWjBEpnxN48WixHqyPmOeujDfNFZPGzT+snWhA7HvTTN2EI1eSAbS
	 eJ4DEznL5qblmRj9QvlrobqcL8e2eADX0spcyGJpnwwD3I9K2Nmb4P0g8f8+9PXLib
	 ve9A0Eri3Z+Yg==
Date: Mon, 8 Jun 2026 10:39:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ppc/pnv: Add null checks for OpenCapi PHBs
Message-ID: <20260608153948.GA36499@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527180816.2749186-2-adityag@linux.ibm.com>

On Wed, May 27, 2026 at 11:38:14PM +0530, Aditya Gupta wrote:
> For opencapi phb direct slots, the .pdev for php_slots will be NULL
> 
> Various sections of the code in pnv_php can do a null dereference and
> crash the kernel.
> 
> Originally, the issue was hit during boot:
> 
>     [    1.568588] PowerPC PowerNV PCI Hotplug Driver version: 0.1
>     [    1.569722] BUG: Kernel NULL pointer dereference at 0x00000074
>     [    1.569811] Faulting instruction address: 0xc000000000b75fd0
>     [    1.569890] Oops: Kernel access of bad area, sig: 11 [#1]
>     [    1.569963] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>     ...
>     [    1.571492] NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
>     [    1.571604] LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
>     [    1.571690] Call Trace:
>     [    1.571725] [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
>     [    1.571783] [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
>     [    1.571951] [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0

Drop timestamps since they don't add useful information.

Indent quoted material by two spaces to reduce wrapping.

Run "git log --oneline drivers/pci/hotplug/pnv_php.c" and "git log
--oneline drivers/pci/hotplug/" and match subject line style.

> This occurs for hotplug slots on root buses where bus->self == NULL,
> such as OpenCAPI PHB direct slots. An added debug print (not part of
> this patch) confirmed it was opencapi:

Style "OpenCAPI" and "PHB" consistently in commit log and subject.

>     [    1.617227] pnv_php: slot 'OPENCAPI-0009' has NULL pdev (bus 0009:00, parent=NO (root bus))
>     [    1.617308] pnv_php: slot 'OPENCAPI-0009' dn->full_name='pciex@603a000000000', compatible='ibm,power10-pau-opencapi-pciex'
> 
> This only required null check in 'pnv_php_get_adapter_state', which
> caused the kernel to boot.
> 
> Even with 'pnv_php_get_adapter_state' null check, there are more
> possible null dereferences pointed by sashiko, including cases where
> userspace crashes the kernel, such as:
> 
>     $ cat /sys/bus/pci/slots/*/attention
>     ...
>     [  557.036295] Kernel attempted to read user page (6e) - exploit attempt? (uid: 0)
>     [  557.036354] BUG: Kernel NULL pointer dereference on read at 0x0000006e
>     [  557.036383] Faulting instruction address: 0xc000000000a83334
>     [  557.036413] Oops: Kernel access of bad area, sig: 11 [#1]
>     [  557.036449] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>     ...
>     [  557.037749] [c000000046707a20] [c000000046707b90] 0xc000000046707b90 (unreliable)
>     [  557.037795] [c000000046707a70] [0000000000000001] 0x1
>     [  557.037850] [c000000046707ab0] [c000000000acb00c] attention_read_file+0x54/0xa8
>     [  557.037910] [c000000046707b30] [c000000000abfbfc] pci_slot_attr_show+0x3c/0x58
>     [  557.037977] [c000000046707b50] [c0000000008181ec] sysfs_kf_seq_show+0xd4/0x204
>     [  557.038022] [c000000046707be0] [c000000000815004] kernfs_seq_show+0x44/0x58
> 
> Add null checks to prevent the null dereferences.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presence detection")
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
