Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3C377EB8
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908220; cv=none; b=RgxGXqsLFRITWG2iCHFZxQXalBp254BWDkJt/q5zoSf+uhw24MFDYqH2oq84OIyqU36vbPVQFKhCsD0iOy2f01DIgrRIVx0A+y75XtY60JUN6V7SHfulaQWMUMn6bdMeF8W7YaFhY7xNNcEMyTRnPWjgQX/8dIWtvPhJMt+PweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908220; c=relaxed/simple;
	bh=NQQjSsx7MDadVDc7TngFEjnUA3fUDa8WYM/oWjHn/5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cm1C502bPvDvIODtEbRPbzxwQjWzEQKIMZGyAHuTVuFFcapJxE0Ggk4wlGtvtYuoi7JPFF1gidMqgWZtj7p8Z0FHOdtnWSKZCmqkdHWecKmM2qx930LcE+v/CzQavPFWmH0ruin1zloLonM/8VgrzWZl5TAEhtVkDPjUkEQs9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QWSTITj0; arc=none smtp.client-ip=95.215.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QWSTITj0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NQQjSsx7MDadVDc7TngFEjnUA3fUDa8WYM/oWjHn/5c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787908212; v=1; x=1788513012;
 b=QWSTITj0Na72PoKyoAHidVJBdajK5U5emt2KWRwU/KhbCUb4+A8KwlC7hZHeRdI5P6V+xa5P
 CnAXGrlJX1u339ms7GHEZqVbkFMc9PPu1q3Z0gKzh781t2WvGx1/elsoqX5HCrk0NQ0o5lZbC2t
 d/+Q2KtNiWpVdt8RUJda2Vzg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 17eb4ab48f81af9e;
	Fri, 28 Aug 2026 09:10:07 +0000
X-Mizu-Trace-ID: 17eb4ab48f81af9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
Date: Fri, 28 Aug 2026 10:10:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] iavf: add missing PTP adjustment callbacks
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, richardcochran@gmail.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, ahmed.zaki@intel.com,
 mateusz.polchlopek@intel.com, saikrishnag@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2026 02:58, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PTP hardware clock documentation requires drivers to implement all
> callbacks and return -EOPNOTSUPP for unsupported features.
> 
> The iavf driver registers a PHC without adjtime or adjfine callbacks.
> A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
> ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
> callbacks can therefore cause a NULL dereference.
> 
> Provide both callbacks and return -EOPNOTSUPP for the unsupported
> operations.
> 
> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
> Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> index 87b97e09df14a..fcb273828bc1b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
>   	return iavf_read_phc_indirect(adapter, ts, sts);
>   }
>   
> +static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static int iavf_ptp_settime64(struct ptp_clock_info *info,
>   			      const struct timespec64 *ts)
>   {
> @@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
>   		 KBUILD_MODNAME, dev_name(dev));
>   	ptp_info->owner = THIS_MODULE;
>   	ptp_info->gettimex64 = iavf_ptp_gettimex64;
> +	ptp_info->adjfine = iavf_ptp_adjfine;
> +	ptp_info->adjtime = iavf_ptp_adjtime;
>   	ptp_info->settime64 = iavf_ptp_settime64;
>   	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
