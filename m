Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586487;
	b=JCKZ4wgiF6zzi5tYgcLBnF45eVdwExQ+QN5FhTot+DKop9czorZQFxEwH56L3bXlKWYO
	 bfdDsRUxFak1PllT70+7shWNJbnp/59BA/E9JHUH/kR3FVlTgoHIlu71nl4YSSuz2IrjO
	 D+nfiX5gqpey/ESMLJF0B6npGvPOx0rC153Mva1el2EvN6glzOyIbqo8MfxtfSCeSSfTW
	 GbgXRd7tVay3YSQrkyQUg+QdV25tXfcFFrxjex69tas0ZueWrc9C7BeCDtVpL27MQMyVB
	 3zE0pYFpTP92dY36FHFXJzpnUyfQFgyAMpYBVZ+cPufBgLU62DLOpwR6oGRJlwk62Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586487;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4ozu3bzvfbgOwc0XH5XCnshd9cJbrOsn/SPLDVtn8zI=;
	b=nbXGZd9lur7vqJTfFL6kvnt/4RExdY5/aB4z8cb7iYiHmUoF/65ijnBW9s2ENvLWU85p
	 ZcAzq2U8dKJJ8dDTb54vaJg72UlBrKw00OLFadLI18EuDF0plBJorMuAUC0GDrmu1s1WU
	 kqTAXenJSLmcEuCVimDoK9/5Bu2ZrWM2sfhXUg/oRaE3yx/SLiY1ks4vrUwCYk7cnXmRs
	 txdnHZx0derTl0Y36S5fJz2TK7EfKlEF41Efls0fhJHMHyCo7NGw5G2jiSLFAMGE6cqEM
	 CqG0rpqHu2glL3Qh26uvYwTygNzhk6AHOVMBqbPC3xBPRiVqMZuebDwT6ckH8CNFKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="U+R/gcUo";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA952606A319;
	Wed, 21 Oct 2026 12:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA952606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U+R/gcUo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792586487; x=1824122487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8BEP5MPbOJlN7vys7wNvH4sULBHpzW3JIMAwKYD0Iw=;
  b=U+R/gcUo3A0owZhbwuQzhQ3TzVEW4w+GHSwvo83PCrEtO9VesgnPNSjW
   f1xUK+1JNMYjHB1IO5TrZS/IUYLLnEkC4XbkxxZG6cxQT8c11fSuZRe4A
   tmxLP+eTHbLzOn8gJ/BGtr+qAsYLWnX4hpWrEQ+DeTYvrT0BGTBhzDN/8
   Gdgnc5cp0gZPaTPHDXttr/uuVjruzIgo11kl2i0HvQ/sEtyl8Ici0y3Wa
   sW86aSS+4GDFZjSQOPbvsycAuNFTkwDyjyXigVZpWC3b2Uv+cll74ZYna
   erTU51egUmePko05Pd6yYWKJQiw+u1gOp//ot6tlAMXOnAh41eiD2B59G
   A==;
X-CSE-ConnectionGUID: Q864YB7VR2O2hii+KD91EQ==
X-CSE-MsgGUID: IQ21nY+YQqu6CdOqP8oMmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290694"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1290694"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:41:26 -0700
X-CSE-ConnectionGUID: hKL8DJAuTlqmpb2VmcW5ag==
X-CSE-MsgGUID: 08J0FFbcRNWWn1xWSuoVsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3098528"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.66]) ([10.245.245.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:41:24 -0700
Message-ID: <24f53405-f73c-48b6-b912-ad1bdd07a498@linux.intel.com>
Date: Wed, 21 Oct 2026 15:41:21 +0300
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
Subject: Re: [PATCH 3/4] xhci: debugfs: initialize command buffer
To: Jiale Yao <yaojiale02@163.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261021104720.4106961-1-yaojiale02@163.com>
 <20261021104720.4106961-4-yaojiale02@163.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20261021104720.4106961-4-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 13:47, Jiale Yao wrote:
> xhci_port_write() copies user input into an uninitialized stack buffer
> and compares ten bytes against the compliance command. A short matching
> prefix can make strncmp() inspect bytes that were not initialized.
> 
> Zero-initialize the buffer so the copied input is always terminated.
> 
> Fixes: 87a03802184c ("xhci: debugfs: add debugfs interface to enable compliance mode for a port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>   drivers/usb/host/xhci-debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
> index 2aa01d99f23d..a020cbab9674 100644
> --- a/drivers/usb/host/xhci-debugfs.c
> +++ b/drivers/usb/host/xhci-debugfs.c
> @@ -347,7 +347,7 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
>   	struct seq_file         *s = file->private_data;
>   	struct xhci_port	*port = s->private;
>   	struct xhci_hcd		*xhci = hcd_to_xhci(port->rhub->hcd);
> -	char                    buf[32];
> +	char                    buf[32] = { };
>   	u32			portsc;
>   	unsigned long		flags;
>   

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

I'll cherry pick this in case Greg doesn't take the whole series

Thanks
Mathias
