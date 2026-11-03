Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717066;
	b=BP1j3lkZOLZxaiyA7pHLD9muw850cPrZfUHpDpqiHbTNqzpXMk1KZXltMMcaMvjWr4zI
	 ObL+09l4hO5Or43f6EULnUgBzAVRm8Y0EvMoZFmE6THp5Ge9gQoIhykqyc3f5PuayEHXj
	 U1WOMW1tOlVbrL+2RYkWPQCTfK0xNxgTB8w+vCCzgu59aE5wk0ap8JaRaiK9v4BHIbwhD
	 iN4lbE3PhpXPbx1seKBibQ0HEMSOQ8M2UsDLIVc31m+q4s+Kwd1jENw26XyxnFu7BOpR0
	 1A1HACp+5UJSE6WnG0v+HeJawPDbuXIN15AH4KIi4FUwzmbqK8IAD4/+1tpon3eiWpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KaGxOIDUSLDrhNtJZX8c9f03J0fEHiNZw1qU0QBhoYc=;
	b=WOiD3NQ0awfiwsyt7c89fe96FewIrrJlZbpfNjZiNYtSto8JSMtUk0zE4LVXijwSBZqs
	 xSW/4CIgL90rbUxyBO3uQwcKggvT+SLk6CfKB9nvOBEdrPjoNr7s8cfIJzC/Qfol5/31N
	 2Z8lYggU4HuBh7/nvg8MTr0MV8SgYO9/9jsnRqrvXu8abWTqdWipvTrAgst4Wo4yOuChp
	 aGBMLln/KLpOaxokozP3zaumWV0kquWz6N4TU3VNqpi95jz5w9pJAYqPfu81jEGsjYtbR
	 6HDIYlfTJBD64ThWpl5+1H+6lrTDMLf7ET9+0o6d4dFzaNFOIlouu3mbMVOqmnfU+6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBZHsAMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D4606A324;
	Tue,  3 Nov 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBZHsAMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F99E1F000C1;
	Tue,  3 Nov 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717065;
	bh=KaGxOIDUSLDrhNtJZX8c9f03J0fEHiNZw1qU0QBhoYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dBZHsAMiJ+/PGPEom3ti3bETufGkQzi2dhXzD+07ycVN49yX4KekU4AIxvAaTOy8A
	 50yWGwqZxKKcpEr2leVlYVLngMKbBGp2hdScXLCyTPGdCCpUSTuYUHuaBTkWCBDIYe
	 D7WDxL8V9RH3ZXUk/lsd+cCYZl5eVAadFkMkcJrN3xLS0U/bmOXrofOrQkOOPQAEEC
	 hlfVtMo/+6YbLzAXRNdVzlk9EjSuY6zilZXNzPFyEv9B4OOOBz7kQHaiY6RHTjFu4x
	 cmvEMDXgGVXIo8toz1CX76Juf7ITWlO9rrCDS4ghbbK+aXlU177nZKQIX+ZyAm8JES
	 Z9/e14ef+8fug==
Date: Tue, 3 Nov 2026 15:44:20 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/20] ACPI: irqchip: validate MADT entry bounds
 before probing
Message-ID: <aunzRO9rxFUlC0Ym@red-moon>
References: <20261029035253.2333852-1-yaojiale02@163.com>
 <20261029035253.2333852-2-yaojiale02@163.com>
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
In-Reply-To: <20261029035253.2333852-2-yaojiale02@163.com>

On Thu, Oct 29, 2026 at 11:52:32AM +0800, Jiale Yao wrote:
> IRQ chip probing invokes validation and probe callbacks after the common
> table walker has only established that a generic subtable header is
> readable. A malformed length can leave callback field accesses outside
> the MADT.
> 
> Validate the generic header length and ensure the complete declared
> entry is contained in the table before invoking IRQ chip callbacks.
> 
> Fixes: e647b532275b ("ACPI: Add early device probing infrastructure")
> Cc: stable@vger.kernel.org

I don't think this patch fixes anything (actually you don't know, it
might break kernels that are currently booting).

Remove the stable tag (on the whole series, though others might have a
different opinion). If this gets merged, goes to stable and then
we discover it triggers a regression (on existing platforms whose
ACPI tables are broken but the system is working) it would be very
annoying.

> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/acpi/scan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0b17a7e51956..10e8d736f44b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2896,6 +2896,13 @@ static DEFINE_MUTEX(acpi_probe_mutex);
>  static int __init acpi_match_madt(union acpi_subtable_headers *header,
>  				  const unsigned long end)
>  {
> +	unsigned long start = (unsigned long)header;
> +
> +	if (start >= end || end - start < sizeof(header->common) ||
> +	    header->common.length < sizeof(header->common) ||
> +	    header->common.length > end - start)
> +		return -EINVAL;

This is a check that AFAICS could be done in acpi_parse_entries_array() once
for all (where you also know header->common is what you need checking, btw). 

Actually, what's missing there to avoid peppering the kernel with
BAD_MADT_ENTRY checks is the entry size (that we could add with a LUT).

The downsize is that by centralizing it, if anything breaks (which is
possible) we have to revert it and therefore remove the check for all
consumers.

I don't know. Rafael, all, thoughts on this ?

Thanks,
Lorenzo

> +
>  	if (!ape->subtable_valid || ape->subtable_valid(&header->common, ape))
>  		if (!ape->probe_subtbl(header, end))
>  			acpi_probe_count++;
> -- 
> 2.34.1
> 
