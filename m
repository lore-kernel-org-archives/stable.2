Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07303FC5D0;
	Wed,  3 Jun 2026 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470274; cv=none; b=magQFUwkvYNXaWR8kjM2ttRT5tOrKFbLc9JgmknCEhUJaVxfT8RCD2wBjcYlfYNEUiQ2dA1CZV8bzIDVXgZ2Dpz68VC111RE4FZRNPVc8VNJ3bgA0eFIqqnP9P09eaCYuTVEfyK99fa1yG2pdYSQ6wFZC1BZRUwnyOxrapT/RgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470274; c=relaxed/simple;
	bh=/DwvyFrcBfOuFGTiBTM3IeCMqQkQQAbzx1c/0Tqpc+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJeyNSC44Pucnx5jlNOGAZhqKerIelrVm6TLqFecRq1tQ+mgHcJa5bbscrSgVp8khw/9ypE+Kq+QFQzR4XoIVzW52DGl69eryPUtNkd8bEKQWKsCXHD8dVErx5AqnF9ZogyDE0T/DGggScCckw/ToFC4ftHDrBwuIbYQr2zm96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp07iUhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp07iUhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E121F00893;
	Wed,  3 Jun 2026 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470273;
	bh=DEcpTemmToYZVKIk8pXtuPF0zFWXNAtbHSkvBvRXIto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rp07iUhSLEd1Giy8+s8MRzEgqLR6Wi8EMdvuyTp74OSYL/i/lXzWO3JvFCPtVcMnw
	 j1Rsqul0GJTFI5u+kVrc7gGEJyxz6rpEqqIi6VqtQomvI36CBRVkMOzf1CQI2bbnl+
	 uiSg7bzeFIKPZ28wU7FafiUmkPPWELvWDSnAaZR8ceti1Im++bnCfabmTj9CDlc3eY
	 FN7e7x6GuJ7Lo80jXX3Q2H+r1Y692dkIullgnXzwATxSBYvHxxebkkgv0U98uqU/ik
	 bimTN9FU36PNsmsEkOVZ4Pv5hi8QHJXAFgYoowOYOKD1Q5gYC4jdO8Hm8bypu2B9wa
	 Md0/edCOrG2Qw==
Date: Wed, 3 Jun 2026 09:04:29 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Wenshan Lan <jetlan9@163.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 6.12.y] HID: core: Mitigate potential OOB by removing
 bogus memset()
Message-ID: <ah_RiLcNbfyfDHko@beelink>
References: <20260603054344.80160-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603054344.80160-1-jetlan9@163.com>

On Jun 03 2026, Wenshan Lan wrote:
> From: Lee Jones <lee@kernel.org>
> 
> [ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]
> 
> The memset() in hid_report_raw_event() has the good intention of
> clearing out bogus data by zeroing the area from the end of the incoming
> data string to the assumed end of the buffer.  However, as we have
> previously seen, doing so can easily result in OOB reads and writes in
> the subsequent thread of execution.
> 
> The current suggestion from one of the HID maintainers is to remove the
> memset() and simply return if the incoming event buffer size is not
> large enough to fill the associated report.
> 
> Suggested-by Benjamin Tissoires <bentiss@kernel.org>
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> [bentiss: changed the return value]
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> [ Replace hid_warn_ratelimited() with hid_warn() in v6.12. ]
> Signed-off-by: Wenshan Lan <jetlan9@163.com>
> ---

This commit is known for breaking devices. You can't backport this
without the following 3 fixes:
4d3a2a466b8d ("HID: core: Fix size_t specifier in hid_report_raw_event()")
206342541fc8 ("HID: core: introduce hid_safe_input_report()")
2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")

Note that this is the same for your 6.6, 6.1 and 5.15 patches.

Cheers,
Benjamin

>  drivers/hid/hid-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 294a25330ed0..6d61bf20ec3f 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2029,9 +2029,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  		rsize = max_buffer_size;
>  
>  	if (csize < rsize) {
> -		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> -		memset(cdata + csize, 0, rsize - csize);
> +		hid_warn(hid, "Event data for report %d was too short (%d vs %d)\n",
> +			 report->id, rsize, csize);
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
> -- 
> 2.43.0
> 
> 
