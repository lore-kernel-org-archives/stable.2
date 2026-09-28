Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BA2D8DD0;
	Mon, 28 Sep 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616217; cv=none; b=sCrYQt0f/XDrfbJBMY3YTMqf3CONZquDtYCaUKHippRFPZdLBKl1/t6u2Qge+2mCaiYi2wh5ZxQZKwiGw/gJuJCacDcMyjHZ7jqPEzI8ZovXqa10am50tzaSoFeO2vm3Z0n7sNIFEpo4ujppVLiq6QiC1XkePmBfvI3ZvRLMB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616217; c=relaxed/simple;
	bh=vqrAPG2a5N24mPZyIlZ1ZZFFpPG47RYaI2AKAjMgvjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2eAE22Rp3FAZGRO5bnakLIIZNiRuogSwSxsyFmFgkRdjz90wOB4gQfDAEcYls1/Ha45dIdd8Flk920+nllkTu3wns21IweV+Nd10eboOsJtwtqJfVGhk7ftQ5Mzb6GdchYT+n34Ol8HdtVlAs9A1mltZIezC7NW2/wtWaVODoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HjsXUBw/; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HjsXUBw/"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7C26A32C;
	Mon, 28 Sep 2026 17:24:19 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=HjsXUBw/;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 08BF22187;
	Mon, 28 Sep 2026 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1790616206;
	bh=8wK+Mt7wxK/GvFsTbwxSYIH31MdufPxWj27TEn5fYbA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HjsXUBw/YXO5O8K+I54jGtFOzvJewiIbPkFX0dckgswm0nWog1gw7divhg3Ryq3DD
	 ONNPEtumiKSA3gJl4Ti4D4D11jY1lQ2Z4sQuzZBlLExBQH6eVgVe2Zxh3ZgvWgdwR8
	 5zj9UOeAj91erCnA1rQTZYSBT/+B+5HBbu4Pc9rQ=
Received: from [192.168.95.128] (172.30.20.196) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 28 Sep 2026 20:23:24 +0300
Message-ID: <e7aa6fe8-1284-4b5b-b6e7-ffff610466fc@paragon-software.com>
Date: Mon, 28 Sep 2026 19:23:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/ntfs3: reject an oversized resident attribute on
 the inline iomap path
To: Michael Bommarito <michael.bommarito@gmail.com>, <ntfs3@lists.linux.dev>
CC: Mihai Brodschi <m.brodschi@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260711152630.2975127-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260711152630.2975127-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/11/26 17:26, Michael Bommarito wrote:

> attr_data_get_block_locked() maps a resident attribute as a one-page
> IOMAP_INLINE extent: it allocates a single page, copies the resident
> value into it with memcpy(), and hands that page to ntfs_iomap_begin()
> as the inline data.  The copy length is the on-disk resident value
> length (res.data_size), and mi_enum_attr() only bounds that length
> against the MFT record size.  A corrupted volume with MFT records larger
> than a page can therefore present a resident $DATA whose length exceeds
> PAGE_SIZE, and the memcpy() then writes past the single destination page.
>
> Impact: reading or writing a resident file on a mounted crafted NTFS
> volume whose MFT records are larger than a page overflows the one-page
> inline buffer in attr_data_get_block_locked() with attacker-controlled
> bytes.
>
> Reject such an attribute in attr_data_get_block_locked(), before the
> page is allocated and the copy is made.
>
> Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Changes since v1:
> - Reworded the code comment and changelog.  The oversized resident length
>    overflows the single alloc_page() page that attr_data_get_block_locked()
>    copies the resident value into; v1 described the older
>    iomap_write_end_inline() BUG_ON(!iomap_inline_data_valid()), which was
>    removed in 7.2-rc1.  Thanks to Mihai Brodschi for catching the stale
>    reference.  The fix itself is unchanged.
>
> The unbounded resident length dates to the iomap conversion; only the
> manifestation changed when the inline buffer became a single alloc_page():
>    - 7.2-rc: the memcpy() into the one-page buffer overflows the page
>      (out-of-bounds write, below).
>    - 7.0..7.1: the buffer was kmemdup()ed at the real size and the oversized
>      length instead tripped BUG_ON(!iomap_inline_data_valid()) in
>      iomap_write_end_inline() (a denial of service).
> The same data_size > PAGE_SIZE check prevents both, so it is the correct fix
> across the stable range.
>
> Reproduced under QEMU + KASAN on 7.2-rc2.  A resident $DATA value length
> above PAGE_SIZE, as a volume with MFT records larger than a page presents,
> was supplied while the alloc_page() + memcpy() path ran unchanged; the stock
> kernel faults with a KASAN out-of-bounds write in
> attr_data_get_block_locked():
>
>    BUG: KASAN: out-of-bounds in attr_data_get_block_locked
>    Write of size <data_size> by task ...
>     __asan_memcpy
>     attr_data_get_block_locked
>     attr_data_get_block
>     ntfs_iomap_begin
>     iomap_iter
>     iomap_file_buffered_write
>
> With the patch the same access returns -EINVAL and does not fault.  An
> in-bounds resident file (control) and a non-resident file are unaffected on
> both the stock and patched kernels.
>   fs/ntfs3/attrib.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index c621a4c582f9e..2f73714a2db97 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -1034,6 +1034,21 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
>   
>   	if (!attr_b->non_res) {
>   		u32 data_size = le32_to_cpu(attr_b->res.data_size);
> +
> +		/*
> +		 * A resident attribute is copied into a single page below
> +		 * (alloc_page() + memcpy()) and mapped as a one-page
> +		 * IOMAP_INLINE extent by ntfs_iomap_begin().  mi_enum_attr()
> +		 * only bounds the resident value length against the MFT record
> +		 * size, so a corrupted volume whose records are larger than a
> +		 * page can report data_size > PAGE_SIZE; copying that many bytes
> +		 * would overflow the single destination page.  Reject it.
> +		 */
> +		if (data_size > PAGE_SIZE) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>   		*lcn = RESIDENT_LCN;
>   		*len = data_size;
>   		if (res && data_size) {

Hello,

The patch was applied, thanks.

Regards,
Konstantin

