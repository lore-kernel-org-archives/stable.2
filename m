Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765473;
	b=CvLs6Qw+ijbYsVYkHWXHpI5wpev7xMalGAGmVQ97f/evLqQlVOzjL8TMCzlXeXIVlh89
	 +E+tcDPmblZZnUzBSlGyvXLzLxynwkiOMtxhCeM4i9K00Pw3cD9dxZ2L4BQtSpd9Ed/BQ
	 Ny/MCL8SHQlYzthL30zmxP+/T5TrYvpaRHKpCVr/D5BVEHpzSFe3Ets+FjtgxmQpU5qPr
	 sxXd/O5LIM14feW6wREbXQ4Rz2JqjpYilIobhD85NwuNpZeNImRbTgjBcVFbEXjqQPdZa
	 GL9onxbnIFRWRKBPYthf/uh7auAmUYKOwk6x/IcufaCHDnb7ruYdQLGNAS3O1y/oXQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765473;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vGF3dziQtL5cdnG8KAdMP8sfNkmuXivsEV6t1rhjwuo=;
	b=oak6C3KaYOdFQxBlgvMS18OugMISmyky5oTuZRFAI4PbYZyLe2Y8a4O5Z5OxhcDpSQJP
	 Oi/xsDS7e60EP/2b9nMqIVvXNN1W7S1cwp+Y2vzHua9WFdlUfY5ynZi/0xuopnB1xnRh2
	 pSiGYNKGEP3qcDzRFPyZUAQSTnYMuH1bQjEabQaEwD4pVqGkvLSfQLFxZG4xsjTF9dZVK
	 UUuxM+4rXZCtW8lPdM/uKNQviwaGJghtY8kRinFQzY43exl1XOXcaQOFyXTNLl00y9+lO
	 XwCmzHRBE1ivpxXE+woj4tBhQcaZOsyRzAQ6l1FLi+3oonVHfkogUVwDZE3bz2Ljt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0Vtw8q0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE429606A31A;
	Fri, 23 Oct 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0Vtw8q0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC8C1F01828;
	Fri, 23 Oct 2026 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792765472;
	bh=vGF3dziQtL5cdnG8KAdMP8sfNkmuXivsEV6t1rhjwuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0Vtw8q0MgiIoKJa5LLDQm/285F2wwjCnYpIURlyedB3OWNGPVczB9/jWjqoUETH1
	 BSEWeAry5ofq1KdPIg6Ypwmmcypbchg4/MnVWrGcPs6v6jjei041JCvpCUCLmD/Sma
	 G1+tNlGn2VvRjycHE3NdP7Mcg//xu3Hesu6r9+dYRmCTHF4YLeYbGL9IZQpYqyEJFF
	 l1Wn01PsXmOSs2nJlukkHKa5CQshB/W2auRU21bLaKuVkGaQNt4MhYnuDj2extfgRu
	 4lUF+rUStKP0TazYWhs/LDxGkb2eRC7kOyC1Qafm5+gfjEs6pdOkuQ+ET9lN6+owr+
	 ZwlZcAvMlJ0Gw==
Date: Fri, 23 Oct 2026 15:24:28 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mailbox: pcc: validate PCCT subspaces before parsing
Message-ID: <20261023-invincible-satisfied-dragon-c3dc50@sudeepholla>
References: <20261023093839.715037-1-yaojiale02@163.com>
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
In-Reply-To: <20261023093839.715037-1-yaojiale02@163.com>

(For some reason you domain gets blocked for me, so please wait until
I check response manually on lore)

On Fri, Oct 23, 2026 at 05:38:39PM +0800, Jiale Yao wrote:
> The PCC mailbox probe walks PCCT entries by their declared lengths
> without checking that each entry is contained in the table. It also
> passes generic headers to type-specific parsers without establishing the
> required record size. Malformed firmware can therefore move the cursor
> outside the PCCT or cause out-of-bounds field reads.
> 
> Validate the table header, each subspace range, and the minimum size for
> supported subspace types during both the counting and probe passes.
> 
> Fixes: 86c22f8c9a3b ("Mailbox: Add support for Platform Communication Channel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
> 
> Notes:
>     Changes in v2:
>     - Replace the type switch with a minimum-length lookup table.
>     - Remove the redundant remaining-header-size check.
>     - Keep an explicit type bound check before indexing the table.
> 
>  drivers/mailbox/pcc.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 9888dab64639..91cef0ee3391 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -553,6 +553,38 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>  	.last_tx_done = pcc_last_tx_done,
>  };
>  
> +static const u16 pcc_subspace_min_len[ACPI_PCCT_TYPE_RESERVED] = {
> +	[ACPI_PCCT_TYPE_GENERIC_SUBSPACE] =
> +		sizeof(struct acpi_pcct_subspace),
> +	[ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE] =
> +		sizeof(struct acpi_pcct_hw_reduced),
> +	[ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2] =
> +		sizeof(struct acpi_pcct_hw_reduced_type2),
> +	[ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE] =
> +		sizeof(struct acpi_pcct_ext_pcc_master),
> +	[ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE] =
> +		sizeof(struct acpi_pcct_ext_pcc_slave),

Please add Type 5 details here as well so that it doesn't escape the
size validation. As is, its zero-initialized and lets every non 0-byte
record pass validation.

> +};
> +
> +static bool pcc_subspace_is_valid(struct acpi_subtable_header *entry,
> +				  unsigned long end)
> +{
> +	unsigned long start = (unsigned long)entry;
> +	size_t length;
> +
> +	if (start >= end)
> +		return false;
> +
> +	length = entry->length;
> +	if (length < sizeof(*entry) || length > end - start)
> +		return false;
> +
> +	if (entry->type >= ACPI_PCCT_TYPE_RESERVED)
> +		return false;
> +

You can drop the above check if parse_pcc_subspace() does this first.

> +	return length >= pcc_subspace_min_len[entry->type];
> +}
> +
>  /**
>   * parse_pcc_subspace - Count PCC subspaces defined
>   * @header: Pointer to the ACPI subtable header under the PCCT.
> @@ -568,6 +600,9 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
>  {
>  	struct acpi_pcct_subspace *ss = (struct acpi_pcct_subspace *) header;
>  
> +	if (!pcc_subspace_is_valid(&ss->header, end))
> +		return -EINVAL;
> +

So this will take care of validation as part of acpi_probe() itself which is
good but see my question below.

>  	if (ss->header.type < ACPI_PCCT_TYPE_RESERVED)
>  		return 0;
>  

Make this the first check(need to reverse it to return error now) and
drop the above check as mentioned.

> @@ -812,6 +847,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>  	struct acpi_table_header *pcct_tbl;
>  	struct acpi_subtable_header *pcct_entry;
>  	struct acpi_table_pcct *acpi_pcct_tbl;
> +	unsigned long table_end;
>  	acpi_status status = AE_OK;
>  	int i, rc, count = pcc_chan_count;
>  
> @@ -821,6 +857,13 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>  	if (ACPI_FAILURE(status) || !pcct_tbl)
>  		return -ENODEV;
>  
> +	acpi_pcct_tbl = (struct acpi_table_pcct *)pcct_tbl;
> +	if (pcct_tbl->length < sizeof(*acpi_pcct_tbl)) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +	table_end = (unsigned long)pcct_tbl + pcct_tbl->length;
> +
>  	pcc_mbox_channels = devm_kcalloc(dev, count, sizeof(*pcc_mbox_channels),
>  					 GFP_KERNEL);
>  	if (!pcc_mbox_channels) {
> @@ -844,7 +887,6 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>  	pcct_entry = (struct acpi_subtable_header *) (
>  		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>  
> -	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
>  	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
>  		pcc_mbox_ctrl->txdone_irq = true;
>  		pcc_mbox_ctrl->txdone_poll = false;
> @@ -856,6 +898,11 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>  	for (i = 0; i < count; i++) {
>  		struct pcc_chan_info *pchan = chan_info + i;
>  
> +		if (!pcc_subspace_is_valid(pcct_entry, table_end)) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +

Why do we need to re-validate the subspace if it is already taken care
before pcc_mbox_probe() as part of acpi_probe(). IMO the changes in
pcc_mbox_probe() can be dropped.

-- 
Regards,
Sudeep
