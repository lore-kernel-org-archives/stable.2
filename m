Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEB35B136
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773097; cv=none; b=Bi6yg8ea2+sBqLFwDTD4vYwKud2nYKUQwq2fYjbglqcydi78zd/SVgcghmdgxTJussH0zzGLp8bifPTIyywv8RuRaVUy5W/6z4S5/bAIQu9cefQNHK8LJyl9asWD2TsUjkOpbJ6VLgoMBNWwfBxGl316VcM4ktGaZOa1/pxFr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773097; c=relaxed/simple;
	bh=Ak6+WF+xM5AzUpu65uHVCUnS9cF4+BBsspRx6zvJuac=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:
	 In-Reply-To:Content-Type; b=Om7RbPYnOKuzlNAOICYf/rOreJABQsMsyBLBboMroMQ0HEB3zMupAWv3VqqDwLvYMjjsFnyKxg0c091gSiYtnVNs8yAXQ1uw3M9GnXtMyspe1QlY0ybXGHBoYVrovhG27/6CqwTNTyPwN2UOSKlV8/3J5wGRJKib0Op9le0LysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UjMp0OQh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UjMp0OQh"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0275E3F1BB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788773093;
	bh=EHK8c6loXVSNcFJOEvIqa5EpxPe99bTmfyj0U+8A3Ow=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:
	 In-Reply-To:Content-Type;
	b=UjMp0OQh1TZCHYprwkGy9/bkazMr4RmFhLdUYawnHsbq7GVYGtFO/9XUnpjWqoXAo
	 76qwG8X+xprA+8T7U67OhacPrJC3k+TyNqgDXpoa8BQVT2JmaLpIr2K5utFs6A34Ry
	 z1YXMpdPyuX5j2bppPGdQK8MNnsKMKU7ls5+3+OrqdmKYU0nB6gj6My2E3XD/XOmtV
	 Fv6YxMIeMzMZYjqXYeuvkIaHFARRFUlv+y+aypGqt6+2NctsA9pShPYRRBpW5ILj9a
	 rGF+dHv0InnZyI4XQhMYIoOIP2WWPafhGC8u7ZoVwyqo0nzmjmrEL362HoAZJaTOVz
	 97h3M+A9dqLazEi5qMwnGOMC+r8HTOw/OBT25lpyMLreT+nbs9+qs7yu5bQ2eOi697
	 Wa1wL9xu4E7JAcHvgqFxBO0W5KEJTGh5nTN9OmQoKLeYI0TMPApYr1CZg1v0vymBfy
	 cYka7knXn1IcFMSW9lM95jscg0r8iG6GAAKBNACyY2Gndqzngx5xS1V63OMIi+ye9W
	 UyVqkyGZnWbCGGIzp+zOZUX1t85h6r2KGXdloBNTBoSkv00STgngjIBUIu41jyP6X/
	 iz0RsXMwHg34bB52cBLEg4t7OOVcdUrMSKHURZZKXhdzymvdr1tazZZkNO3sMbXO12
	 O2EipoBO1Mwed0gTkFJxbUlM=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so3824457a12.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773091; x=1789377891;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EHK8c6loXVSNcFJOEvIqa5EpxPe99bTmfyj0U+8A3Ow=;
        b=f8dYwSCH/1s5tLI1l5tJNqqV+/EQMk/i2Ujj7ebLyYvX5YKhmWTgs4e8Fk/yp/yOmu
         XA8EnzKHkwp4IgWopHUhugTmXwde1wXgCWfpKhAJw5aJxRra9pJikzweaxKNPJ8W5FGy
         5of06uyjuiZ6OOsViMi2OVJC6tpdl9j3tXkRJDpjyEEWUxMX8qHjg1MdjcB0ekAlrBaK
         sUl5aHEn/Ajo/1oSUko6OzONne5qkjjJKcv7vRLYvZmvNPwGEorPSPYKyvtlgXQ6rrPQ
         E7WytYKz9nubqpiKr9+oBGJ5ElxYHUP5MA8Zmx/nyL/oszJ3HFm9ILi5nnA739z9YvNH
         YLGQ==
X-Forwarded-Encrypted: i=1; AKwUvByxXLJDmUi0f96YqboMBh17XvJUBUNEdLe+TrlaTwRSEA4gsnU+7cnLx4q0yJdzGlgO7wi5Iwc=@vger.kernel.org
X-Gm-Message-State: AFuF++ni0mz0jmusS5bHH9BATdgGjCckfDfSramzVKLCQ/5ESHdckD/v
	mdzxllQD36bYP7qNNKBDVi/K3mTwhjbml3DN8ChL8f89F+dF5DJxaEoRhNT0r6YoOxu1kPvN3Vb
	7xuXmtyU1PZmUaz+pWbIyZb+KsKngSBCbiEh8pKzLCQBDqMGZh2TuQ41d221+PA9EJYE/MXuL+w
	==
X-Gm-Gg: AYBFou19YvAMx/4sXhFmTUujRnoXWpwvrfEiFZi65pZ0WkpyC/M5K9p3nIbLTvhB+mX
	PW0tW346lfRjhJmp9+6H82/PjARs5OakV5x0OBSi13mLMX/3PYqFMdqsYddSJYbKPr6gdcMkmXY
	WU9k5WhCzjCpBQpMN5M4x5t+Tt6JbaXeBTAwjVQUDsmO7tIfatpy4uA26Hpg5FJr39mzLZyhVdz
	uUnYO+1uZV+b7kzz0TwDepFlI/ILDoqiA3Kmfbtr2ospry3vftqdb+xck5rY4UMJ7tUCXAUMBw4
	SwjuvR1EyfDyG11FCvnv3qZo3aA5L88hFxFeA53rjeTG1EOd19aqaeVhkObq9m60Z3o4O/4Qdqg
	lZZ5eM+5nGuQSEpgwb4rooHXiwascDY4M+g==
X-Received: by 2002:a05:6a20:db91:b0:3d3:ae1f:d7f5 with SMTP id adf61e73a8af0-3da3a0b9eecmr33840776637.21.1788773091289;
        Mon, 07 Sep 2026 02:24:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:db91:b0:3d3:ae1f:d7f5 with SMTP id adf61e73a8af0-3da3a0b9eecmr33840707637.21.1788773090788;
        Mon, 07 Sep 2026 02:24:50 -0700 (PDT)
Received: from [192.168.2.166] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm26111314eec.12.2026.09.07.02.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:24:50 -0700 (PDT)
Message-ID: <9209cfea-729a-47d7-b144-f01ec91b7e1b@canonical.com>
Date: Mon, 7 Sep 2026 17:24:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SRU][R][PATCH 1/1] scsi: megaraid_sas: Limit NVMe request size
 to the PRP chain frame
From: Alex Shi <alex.shi@canonical.com>
Cc: Thomas Lamprecht <t.lamprecht@proxmox.com>, stable@vger.kernel.org,
 Lukasz Magiera <me@magik.net>, Mira Limbeck <m.limbeck@proxmox.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260907085355.861433-1-alex.shi@canonical.com>
 <20260907085355.861433-2-alex.shi@canonical.com>
Content-Language: en-US
In-Reply-To: <20260907085355.861433-2-alex.shi@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this and last some subject emails!
Sorry for cc you guys because of a wrong git sendemail setting.

On 2026/9/7 16:53, Alex Shi wrote:
> From: Thomas Lamprecht <t.lamprecht@proxmox.com>
>
> BugLink: https://bugs.launchpad.net/bugs/2148534
>
> megasas_make_prp_nvme() builds a command's PRP list in cmd->sg_frame, a
> DMA pool buffer of instance->max_chain_frame_sz bytes, spending one
> entry per NVMe page of the transfer plus one per page of the buffer for
> the chain pointer. The loop runs until the transfer is described and
> never checks the buffer bound.
>
> max_hw_sectors comes straight from the MDTS the firmware reports for the
> drive. On drives with a large MDTS the only thing keeping the list
> inside the buffer was the block layer default of 1280 KiB, which needs
> 320 entries, which fit into a 4 KiB frame as that holds 512. But since
> commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") that
> default is 4 MiB, and such a transfer needs 1025 entries, so the list
> runs a full page past the end of the frame:
>
>    sd 1:0:1:0: [sdb] tag#630 page boundary ptr_sgl: 0x00000000ba62d13f
>    BUG: unable to handle page fault for address: ff663bcb81e7c000
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    RIP: 0010:megasas_build_and_issue_cmd_fusion+0xeaa/0x1870 [megaraid_sas]
>
> If the page after the frame happens to be mapped, the overrun does not
> fault but silently corrupts the neighbouring pool entry, which is
> another in-flight command's PRP list.
>
> Cap max_hw_sectors at what the chain frame can describe, less one page
> for transfers that do not start on a page boundary and so need one entry
> more. This is the megaraid_sas counterpart of commit 04631f55afc5
> ("scsi: mpt3sas: Limit NVMe request size to 2 MiB"), but derives the
> limit from max_chain_frame_sz rather than hardcoding it.
>
> Cc: stable@vger.kernel.org
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Reported-by: Lukasz Magiera <me@magik.net>
> Closes: https://lore.kernel.org/all/GPhsSM0vkgyIrs0DIZ62qeUZX7X4RxwQXVKiuvMx-lHQVSPDxpztUyQOGS0xikqvJ-Z94hMV-dW_5KN_0CX2hsfV7kTf_t0MTf6vdAAaSEc=@magik.net/
> Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
> Closes: https://lore.kernel.org/all/d171cc76-bf25-48ce-b482-d344669dfc24@proxmox.com/
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Link: https://lore.kernel.org/all/yq17bmzd5jr.fsf@ca-mkp.ca.oracle.com/
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> Closes: https://lore.kernel.org/linux-scsi/20260827182106.535D61F000E9@smtp.kernel.org
> Link: https://patch.msgid.link/20260827175743.734593-1-t.lamprecht@proxmox.com
> Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
> (cherry picked from commit af8c27375733fb6a6df9fa484cda77cc3dd0cb80)
> Signed-off-by: Alex Shi <alex.shi@canonical.com>
> ---
>   drivers/scsi/megaraid/megaraid_sas_base.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index ac71ea4898b2..436d4e0a15c4 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -1973,12 +1973,23 @@ megasas_set_nvme_device_properties(struct scsi_device *sdev,
>   {
>   	struct megasas_instance *instance;
>   	u32 mr_nvme_pg_size;
> +	u64 max_prp_io;
>   
>   	instance = (struct megasas_instance *)sdev->host->hostdata;
>   	mr_nvme_pg_size = max_t(u32, instance->nvme_page_size,
>   				MR_DEFAULT_NVME_PAGE_SIZE);
>   
> -	lim->max_hw_sectors = max_io_size / 512;
> +	/*
> +	 * megasas_make_prp_nvme() builds the PRP list in cmd->sg_frame without
> +	 * bounding it against that buffer, and spends one entry per page of
> +	 * it on the chain pointer. Cap the transfer at what the buffer holds,
> +	 * less one page for lists that start off a page boundary.
> +	 */
> +	max_prp_io = (u64)((instance->max_chain_frame_sz / sizeof(u64)) -
> +			   (instance->max_chain_frame_sz / mr_nvme_pg_size) - 1) *
> +		     mr_nvme_pg_size;
> +
> +	lim->max_hw_sectors = min_t(u64, max_io_size, max_prp_io) >> SECTOR_SHIFT;
>   	lim->virt_boundary_mask = mr_nvme_pg_size - 1;
>   }
>   

