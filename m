Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DD396579;
	Tue,  8 Sep 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852374; cv=none; b=sXC+2Fzr5GimOqWTkKZZ18lcePUV4oqApTjhIK574KuDwLBhxz4eEujPhko+yAM3ZShlHob3FmEZUfV6dWDVA7gt97Iezf3sFYJWc/eL1Supt7CeaehIq36HSUjXRSQQz0mYFMvz180wD1ZxMqqjVQUFFh+RKajU+lSMJukSpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852374; c=relaxed/simple;
	bh=RNj8bNDPoqgTZww4eSXoFwemv1jGmr8fMaku4epod3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuoRIi/3w3HGCdgQ1W19TTV6VaugZ5vGM4EZC5h0AmskayNPrTM+6ibGPTPcR2GwTHmfimBd1LnCKJrMKQNSRVgmLFPVaP5C2qERsimOQTHJiMM/UrCzQcEOMf7SDX9AFGYUKnVNVV5IyEWgdPd1nF4E68ba4TNdPC3MbPdaO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCZO/LBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCZO/LBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0151F00A3A;
	Tue,  8 Sep 2026 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852372;
	bh=jTFa7o85HfsRzNBfV4MGb2LKxXfcZbC4WkrPTKuc/Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cCZO/LBsTF7qo7/DvrIev+rF/sK81D2iKzd4UD/f3GE2/q8/+nB1SnTgQJJaJbx1M
	 NQ7ui5/MyViW9IdA75KqRP/78HkvqZaJIKAJf+nQNNbu1DpqALHHLmiWapeoWGPN5V
	 5lgwhjDUTepgJGGDJLdIIKZXAXxCT5LcUBuq7CKBGoaYf5/PKJlOluHU56pfwGevZa
	 Ey2w9m2HzErqfxp5rNFAy8fKV+NisFnZCdxkAP1kPLB9/1YqGRCbW5RBAoSZSaWlQa
	 rqcM8md/0gZkA4MZ9BKTs/+pJVO3dtGsZPknpUg+qyAOtBeIcFUTYlAZj8WxwMjWY8
	 /QYg3iUcp7+QQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3qDa-00000000spI-0krx;
	Tue, 08 Sep 2026 09:26:10 +0200
Date: Tue, 8 Sep 2026 09:26:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
Message-ID: <ap-4khETBju3X8-T@hovoldconsulting.com>
References: <20260907151428.643841-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907151428.643841-1-adrianox@gmail.com>

On Mon, Sep 07, 2026 at 12:14:28PM -0300, Adriano Cordova wrote:
> Do not dereference mmc/vub300/udev after the final kref_put, because
> it can release them via mmc_free_host()/usb_put_dev().
> 
> Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")

This commit reverted a buggy change so if anything is broken here, this
isn't the commit to blame.

> Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
> Cc: stable@vger.kernel.org
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Are you missing an Assisted-by tag?

> ---
>  drivers/mmc/host/vub300.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 2dae474dcd06..a1a6aa1aafdb 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
>  {				/* kref callback - softirq */
>  	struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
>  	struct mmc_host *mmc = vub300->mmc;
> +	struct usb_device *udev = vub300->udev;
>  
>  	usb_free_urb(vub300->command_out_urb);
>  	vub300->command_out_urb = NULL;
>  	usb_free_urb(vub300->command_res_urb);
>  	vub300->command_res_urb = NULL;
> -	usb_put_dev(vub300->udev);
>  	mmc_free_host(mmc);
> +	usb_put_dev(udev);

This makes no sense at all as the driver data is freed by
mmc_free_host().

>  	/*
>  	 * and hence also frees vub300
>  	 * which is contained at the end of struct mmc
> @@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
>  			construct_request_response(vub300, cmd);
>  			vub300->resp_len = 0;
>  			mutex_unlock(&vub300->cmd_mutex);
> -			kref_put(&vub300->kref, vub300_delete);
>  			mmc_request_done(vub300->mmc, req);
> +			kref_put(&vub300->kref, vub300_delete);

This order has been here since the driver was merged.

>  			return;
>  		}
>  	}
> @@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
>  		    satisfy_request_from_offloaded_data(vub300, cmd)) {
>  			cmd->error = 0;
>  			mutex_unlock(&vub300->cmd_mutex);
> -			kref_put(&vub300->kref, vub300_delete);
>  			mmc_request_done(mmc, req);
> +			kref_put(&vub300->kref, vub300_delete);

Same here.

So if this is wrong (it does look suspicious, but this driver is just a
mess) then that's the commit to blame.

>  			return;
>  		} else {
>  			vub300->cmd = cmd;

Johan
