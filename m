Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AC38E8C2
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903641; cv=none; b=EtIRmKuW2Cuq8gXGPo5oGFJGbKtmT0JQaEW4OB5MJtVnzXn1glW49pO252Pl3X4qkeO4vxq2aWRc8uPTTD69oP6yKzx2hr5HG/WDfOkqaywUeEYJQtcWPfjlTB6+3jB8Sx/ZI6db+xH86/3kMfd7qMXcesal9TiHku7so27R8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903641; c=relaxed/simple;
	bh=SJOKXNP9FmKA1NOLEfhFMPNSdAh6YT3VyxOAkzI9GYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9CAG2JOr/P/QuHFUFTYSOybofpxxco5hBi4dAbwhmMLUSCnxprSHKVqjPz84hL/Ee+g+kgtpDEmyHzVywc9KUYXvzlEJEO4PE6oH/xjLgoE42MLoU1KbJvnJ7A49E4zsJ9S3bzlPIH6+SoSbXHFNIhghMmjgS/NZNqW0X0bQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFjDFb14; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFjDFb14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780903640; x=1812439640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SJOKXNP9FmKA1NOLEfhFMPNSdAh6YT3VyxOAkzI9GYk=;
  b=bFjDFb144HWzWJSujwAC8Z/7rDXvnLWbwKHxQlz65npacR8fZj1WwekB
   PFuTWJ765oluYAuQUQYwLOqeiHcwCYeTLGKDMJN4VHbxDJVhlHZ7YHeWr
   SD2bw0UFecTGQhbXpSfabQQYJIaEytMR1APG9OqeOoNceKIXiT+TVW1kj
   cDckKOqLW32oX6eZGTWe4ssDoa6LYlY80iUiVYATr0Qa37o72BbtAqXok
   djzTOCQ3Sj31I0ZmMvhAxjQBIcaw/7r8p11v28G7NoOI30mFDg8bNIGE7
   kloN1rKb6KJyDGrrgOYqT1rN8R61xJxH8iGFMOTcRS/8XUe+dJqbLFprW
   w==;
X-CSE-ConnectionGUID: d61QorNoQym4zu/sZcY++A==
X-CSE-MsgGUID: PCA9O2a9S4OeVMf6vpxYrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92199571"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92199571"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:27:19 -0700
X-CSE-ConnectionGUID: jNLMCwdKTSelGTAsf47bSg==
X-CSE-MsgGUID: qpzfZxoJR5Wukvzc90cEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="275668283"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.44]) ([10.217.180.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:27:18 -0700
Message-ID: <7218fa4b-bb09-47a8-a2ab-7d381cf7d897@linux.intel.com>
Date: Mon, 8 Jun 2026 09:27:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Fix signed integer truncation in IPC
 receive
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, david.laight.linux@gmail.com,
 stable@vger.kernel.org
References: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
 <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01-Jun-26 18:16, Andrzej Kacprowski wrote:
> Fix potential buffer overflow where firmware-supplied data_size is cast
> to signed int before being used in min_t(). Large unsigned values
> (>= 0x80000000) become negative, causing unsigned wraparound and
> oversized memcpy operations that can overflow the stack buffer.
> 
> Change min_t(int, ...) to min() as both values are unsigned and can be
> handled by min() without explicit cast.
> 
> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
> Changes in v2:
> - Replaced min_t() with min()

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> 
>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9347f05a2b79 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   	if (ipc_buf)
>   		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>   	if (rx_msg->jsm_msg) {
> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
> +		u32 size = min(rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>   
>   		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>   			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
