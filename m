Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91D33F8B7;
	Fri,  3 Jul 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067145; cv=none; b=ouokCJMVJea7ykRsbdaY/kiFHDwA1DSkbUg6leXdAYaEe2p7rnJ+uD/E0yOJiUPQeA8lgDFrzmt8vJrc2SQZhy1W12Nl/EHjuH/q5N591vn/11CSBBSWtjxlTD4CdCG1Mhm5fr6E45xLZ0RTQ/6EEd1UAPxiPpv56Ncf39EaTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067145; c=relaxed/simple;
	bh=oIg4UTeySBY5NZswH6VTdOEtrzzm2uZy5zXM6quIj7E=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=YVBKB1En9VpX3JXj3I257YQiVX0ZccyaU74tT0PUXpshey4BvGeTL6kCL9gm5i2fypn59H2XM7htVHogIiNFK76btCHz5IH1HIIi0rZ5ES9qKl+ul74186gVG27gDlhgzt1J8LTRSD1cltAQiN5WINEs4Q0N5NzinqfEQ23LTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jUwmaPdH; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jUwmaPdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=oIg4UTeySBY5NZswH6VTdOEtrzzm2uZy5zXM6quIj7E=;
	b=jUwmaPdHdgraDZ2cXIWTN+NrPhBZKbQC9QsZ5eCuM+uN+jI6L0EQfd5s0Hp5ma
	vfyhhgQebh4UEmP5KRdcfv0S45K0oBM9vTlgZwNJeAJ26QRQabZ5jJGDcUyaY5JR
	ZGC6nypzOdRMQek5bkJx3B4xa/BwQzVvnI7Sv/J8TlF5A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXb4HpcUdqXXvnCg--.46753S2;
	Fri, 03 Jul 2026 16:25:14 +0800 (CST)
Message-ID: <6A4771DC.3030301@126.com>
Date: Fri, 03 Jul 2026 16:25:00 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Namjae Jeon <linkinjeon@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: validate error codes in check_windows_hibernation_status()
References: <20260702033656.23048-1-zenghongling@kylinos.cn> <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
In-Reply-To: <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXb4HpcUdqXXvnCg--.46753S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4ktr13Wr4UCFWkXF1UKFg_yoW5XF1DpF
	W7Krn0kr4DGFWIkas2kayfAa4Sv3s3JF45Gr98Jws3urs8KF1SyF43t34j9F1akrWDua1j
	qa1jy34UWas0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-sqJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoQoD02pHceqh9QAA3Z

Looking at ntfs_lookup_inode_by_name() more carefully:

All error return paths inside the function use hardcoded kernel errnos
(MREF_ERR(-ENOENT), MREF_ERR(-EIO), MREF_ERR(-ENOMEM)) - these are
already valid by construction.

The actual risk occurs when the function returns a "successful" MFT
reference from disk (ie->data.dir.indexed_file) that happens to have
bit 47 set - making IS_ERR_MREF() true at the caller. In this case,
MREF_ERR() extracts garbage from untrusted disk data.

This cannot be fixed inside ntfs_lookup_inode_by_name() without
changing its return value semantics, because from the function's
perspective it found a matching index entry and returned it. Only
the caller, after IS_ERR_MREF() triggers, is in a position to
validate that the extracted error code is a legitimate errno.

Restructuring the function to distinguish "real errors I generated"
from "disk data that looks like an error" would require a more
invasive API change (e.g., returning int + out-parameter), which
seems inappropriate for a legacy filesystem in maintenance mode.

在 2026年07月03日 15:06, Namjae Jeon 写道:
> On Thu, Jul 2, 2026 at 12:37 PM Hongling Zeng <zenghongling@kylinos.cn> wrote:
>> check_windows_hibernation_status() calls ntfs_lookup_inode_by_name()
>> which returns MFT references read directly from disk (untrusted data).
>> The current code extracts error codes via MREF_ERR() without proper
>> validation, allowing maliciously crafted NTFS images to trigger
>> incorrect error handling.
>>
>> The MFT reference encoding uses bit 47 as an error indicator, but the
>> lower 32 bits can contain arbitrary values. If a malicious image sets
>> the error bit with a positive integer (e.g., 1), MREF_ERR() returns
>> that positive value. This can cause the function to incorrectly
>> interpret the error as "Windows is hibernated" status, potentially
>> leading to the filesystem being mounted read-only (denial of service).
>>
>> Fix by strictly validating error codes: only accept negative values
>> in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
>> (positive, zero, or out-of-range) to -EIO to indicate disk corruption.
>>
>> This prevents potential security issues and ensures proper error handling
>> for corrupted or malicious NTFS filesystems.
>>
>> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> I think this should be fixed in ntfs_lookup_inode_by_name(), rather
> than in the caller.
> And I will revert your previous patch ("ntfs: validate error codes
> from untrusted disk data").
>
> Thanks.

