Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870086;
	b=b+Uev59NEtgf2b3HSLrDBlCBdmf3722TImqvZTzhxc9WaRDb8hQidt5kw0newmPkZ2YG
	 aegwf2Oz9m0eEkohCWOthp0Ee7RQ0XCZqFiN3S6l2IeXUMFD3GqoGIgR+tcOd7dsrotYF
	 VMI/crkwUcsl+W+Pdrl7q8eK187czFSuPXMeioU21LiQR84ttxgMAhJNIlo2ppJOp9+gI
	 bjODWag6U/pd0fIDntWosmMVhMgIj0jT7z8D8pbOvSzOBr0X3oej4CtBxR4H3CRBKxIYy
	 AfSBNe+4nYP2P/cVWpLi9xw52mgvUYJ8dN3oVWvk8wkZf+HVHFH+SiJTjbdogbYv1bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870086;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=i8wu4ldu0ctG+v5/R50fZxVjOYm5zkL0ZBbxTjniobI=;
	b=W6Ge2o9OTmnJWRaHy0yehh+8a2ecEjeW65QGN38X3xa0x2pbVDZdiT88o9AdrCxFJbaD
	 4w8V0sAIzyCqVHN5QMm2ynpMZtvgliZLTbAcHvbZdZN0hZ3M29fLH04C74emTVE9F7aCK
	 MtAw55u57CB9j9owLkhoqJuGuXmDg7tVGqmNeJrVRfY8KR0fU5FE64uvF/FkqPFfz87oy
	 2B7+ANbPXCvs/uX20UPkRx2OBHCz/HMVHovkPAR+6VyBQRqG3vxHHDBZj3yG/HehniT5Q
	 mx/fVrGHhA915cGrAWgCpK2y/XtM9IeH3N8ZtSulFte/okQbU80kTPEuLmkEutFXqPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D4Ltd34s;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212E606A31B;
	Thu,  5 Nov 2026 09:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3212E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D4Ltd34s
Received: from [192.168.1.14] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9AA5120B7166;
	Thu,  5 Nov 2026 01:14:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AA5120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793870063;
	bh=i8wu4ldu0ctG+v5/R50fZxVjOYm5zkL0ZBbxTjniobI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D4Ltd34sEKHPD18nhlIWm5KNBTyTSdlyW+GsKEnAJBWG4wbIXpgA1crL6iRWcyp+z
	 bYMTmEZO552Epal8dLsOC4Fp3/w3zekszksW0RsIar4Dhi9CKNhiYCFh0e/7LeLDAv
	 To6I+maSI1WMGn+PRC0hJ+9ypm4uEw/sMTUUqvcc=
Message-ID: <d3764ad4-9c95-470a-a3c2-474600657405@linux.microsoft.com>
Date: Thu, 5 Nov 2026 14:44:32 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: util: Fix transport teardown on util_probe()
 failure
To: Andrey Misiurov <amisiurov@cloudlinux.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261104203049.1031148-1-amisiurov@cloudlinux.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261104203049.1031148-1-amisiurov@cloudlinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2026 2:00 AM, Andrey Misiurov wrote:
> Commit 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer
> not initialized yet") moved the creation of the KVP and VSS transports
> after vmbus_open(). util_probe() still calls srv->util_deinit() when
> vmbus_open() or util_init_transport() fails, and hv_kvp_deinit() and
> hv_vss_deinit() destroy hvt unconditionally.
> 
> On the first probe, or when hvutil_transport_init() has failed, hvt is
> NULL and hvutil_transport_destroy() dereferences it.  After an unbind,
> hvt still points to the transport freed by util_remove(), so a failed
> re-probe frees it a second time.
> 
> Skip the destroy when there is no transport and clear hvt after it.
> 
> Found while reviewing a backport of commit 07a756a49f4b.
> Not reproduced at runtime.
> 

Ideally above 2 lines should go as comments in this patch here [1]. 
Keeping that nit aside, this LGTM.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>


> Fixes: 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
> ---

[1].

>   drivers/hv/hv_kvp.c      | 5 ++++-
>   drivers/hv/hv_snapshot.c | 5 ++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index 336b278..813bec5 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -825,5 +825,8 @@ void hv_kvp_deinit(void)
>   
>   	hv_kvp_cancel_work();
>   
> -	hvutil_transport_destroy(hvt);
> +	if (hvt) {
> +		hvutil_transport_destroy(hvt);
> +		hvt = NULL;
> +	}
>   }
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 847dc69..a827cef 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -456,5 +456,8 @@ void hv_vss_deinit(void)
>   
>   	hv_vss_cancel_work();
>   
> -	hvutil_transport_destroy(hvt);
> +	if (hvt) {
> +		hvutil_transport_destroy(hvt);
> +		hvt = NULL;
> +	}
>   }

Regards,
Naman
