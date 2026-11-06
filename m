Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978504;
	b=QDgHCMXkf5q9duu6Z1yjBSY/Mqa6SZ3Pzse4ehAbT07ab02M/uSzPVFDZCV0k0ncu8vh
	 G8WXiNddPNOSeGAP3ruEkupYrvMLSNlAZc0DdKSFZNJID6KIWpVt5pX6bjM4oxY2kKUV9
	 MmrJ1+EBzan38GjXCcee+sJLCohVTpg9lcN3mwVWflgGH/u3j7GV2IClOzP1v+b0ZDCsy
	 4lA38L3UQK/Ik0sLAxBWOmepnNBc1pFE4OpQDmvm86U7g5ZVuhoCMzJS8AFY++0eMQ5Gr
	 4Wh7JKotACLVarnFcCaTNJnwZCciTTesYzYLtX3++mLdJ5Tk5Q5h5AM/FACYS9xyNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5gB9agqiKxDvndp3lmIXDvsPb7cXS92VWUZhkG9w6fA=;
	b=R83FEgjKXNLss9a/OYP2BzABtLHLTS5DSnKN4pjWOGG8Yzt5o8dhZ8mdPJgO3VzL4Qg9
	 shT45PCFQvgHebHytx2acYSGRI8+ZzFi43WV4jAwWuqQy73NEtdAZ7dsCiQ1+6fotkDzP
	 VxCboZI/3AwfOS3i3w2mJvuVvYJi/TBxfxStQQ0tbVsjmRAxwXc+JrvAHKfWjF4CryPlQ
	 Ua8QFk1yfhMuOZZlk+su6Zu34tpOMJ6++gb7iDAawPX53REKamPbCeoErXmjc3aj+54t1
	 pKLtIs1E0qqNoJDevz7qBJnxXM67SLFZiGmd/REoq3Mea2n4PGv/0H6wbP3EcJo2+Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbSoHxWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E980606A333;
	Fri,  6 Nov 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbSoHxWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7151F008BD;
	Fri,  6 Nov 2026 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978504;
	bh=5gB9agqiKxDvndp3lmIXDvsPb7cXS92VWUZhkG9w6fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lbSoHxWSGmbZ0Y4ylVLrt0KQrv1abH9lj5Dv8Ma9ErwCszbZxCRpFIjyn9dBrV3Rv
	 /DH+Iu1+C2YUEQ9cDab6W6H+jP9UxhhV/OksRg899zIvZ54rTyF5coy+cT4kNAQv02
	 U3DEWrFGQdTe4Op0MJLQ8/jv30gSUpMVNgL4njZCkKv37tZ8HTf7s+0pgv5gcbjDA8
	 pecKPqCCXAjI2BPM279rrA+1haptIJ7VjucLWSspIN6T42WFK5td835kLB4/+qlcL+
	 iwVFwNExqdXvsM3IidRER0FJZhj0nN41PursuvFwCHDxyZO2nc9R9UCAxBDGDir1hZ
	 SyWUfYyP0thfw==
Date: Fri, 6 Nov 2026 09:21:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Message-ID: <20261106152143.GA1621130@bhelgaas>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BB887B4DB8D2131AF5026893E0FE567D6D05@qq.com>

On Fri, Nov 06, 2026 at 04:56:55PM +0800, Ziyou Wang (Lenovo) wrote:
> Some NVMe devices need more than 5 seconds to recover after DPC
> containment, but pci_dpc_recovered() waits only 4 seconds.  If the device
> hasn't recovered by then, pciehp reports "device recovery failed" and
> the device is re-enumerated.
> 
> Move PCIE_RESET_READY_POLL_MS definition from pci.c to pci.h so it can be
> used in dpc.c.  Use PCIE_RESET_READY_POLL_MS (60 seconds) as the timeout
> so pciehp waits as long as pci_dev_wait() does, which is sufficient for
> all known devices.
> 
> Tested with INNOGRIT NVMe SSD [1dbe:5668] with ACS Fatal error
> injection:
> 
> Upstream kernel (7.3.0-master+, 4s timeout):
>   [123.018691] nvme: not ready 1023ms after DPC; waiting
>   [124.106690] nvme: not ready 2047ms after DPC; waiting

Was there a "not ready ... after DPC; giving up" message here?
pci_dev_wait() should log *something* about how it resolved this
situation.

>   [125.642703] pciehp: Slot(64): Link Down
>   [126.218696] AER: subordinate device reset failed
>   [126.218700] AER: device recovery failed
>   Device re-enumerated as nvme1
> 
> With this patch (60s timeout):
>   [74.894811] nvme: not ready 1023ms after DPC; waiting
>   [75.982813] nvme: not ready 2047ms after DPC; waiting
>   [78.094810] nvme: ready 4095ms after DPC
>   [78.094816] nvme: restart after slot reset
>   [78.111620] AER: device recovery successful
>   Device works normally
> 
> Fixes: a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziyou Wang (Lenovo) <ziyou.dev@foxmail.com>
> ---

30 minutes after v1 is too soon to post a v2.  A couple days is a
reasonable interval.

v2 should include a note here (after the "---") about what changed
since v1 and ideally a lore link to the v1 posting.
