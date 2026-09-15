Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C9372673
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484531; cv=none; b=oh7kfU4tCZQHT/wOmrd8lxGF9B0lzxdlvVu6gBEfvHrq49PYWGFlaXQKKr00ZrnmeQ/BqSoadsONOaqb7kaPBM1Ng5PJb1BXgmMiySJE1svcysHU/fHOGT+KpWpR9jM8f3BUHj9QqQ9vS/Pwwk5Opr38pva16V+LI8oA/1xdXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484531; c=relaxed/simple;
	bh=/fHR+cBcwXjSOEnwm9YuzA0ScboREtQG9KUAT8U1sYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTCRJxqXvXp/s4IVbhsD04PiM48wBQ/KiqD6LqvoEsX1wreASJ++impR3yagb+zp3/FzRI5YDM//nbiyQqo4TPUZmHuQiywYJ3c/G0FmZ516xRQoh7RibbA6An2zzFDuoXKZ5lMBDnTC0bzwYfSSoUUejifAsGg9vEQlRGLpK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=GRmufUme; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="GRmufUme"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90e9ad1a373so8202786d6.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1789484528; x=1790089328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=62dnS9UB1nI/BR4/ltxJuhKZokBySflA5rnVbV11GGc=;
        b=GRmufUmeDJRCz1H4sU2sB5+nYIz9F3ZpjBW/DPSD9AlkWV1AW+Ugy/HSyhA5kSzpls
         VdAceIPlX5LgqLbfnOZvT51MXxwm3GBr/sNcAm5/0GqiLXL9dIW/9LmQrpH1Y3rLEnAs
         vtzrKi89biOFblena4jK4X6UIV85JDNp2JE2guNjDMuR5ndWAoWJWpeMgGrd34xGjBal
         iUt2UH9xirX1Kf+1yLaQyJ3z+bRTdTyxCyfyytpxhImSL4ubCE595H5wtr9Cf0hGwMvA
         4fBP+QVfHgPXPAH1EdoJqahTIuf2LzAL+FG2fTfonr1AHAwjSNKWJkERlinkSM9DL+r3
         BMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789484528; x=1790089328;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62dnS9UB1nI/BR4/ltxJuhKZokBySflA5rnVbV11GGc=;
        b=H1+u/H2fPYSiSul+ddTsj50ogk3dZYPS9p2noNdn2RwnWIcZG/dWYoNV4h81TIiW2b
         uYxpyk8vcl9VUeWwKgmNTpreuftqbmjR2Ga+iqxgNEc5seyg5xxlSrD/TUqC48t7fJR8
         GInkxKhRB+st4bkoCogTxYcdVktOTTpT6ZakmaT6SuJR7mXt8HOWK6Kj5qt7B9U+0+vl
         okQBTvPORd6T21ocSptC5YLg0vTAz8cuJqeherBFYMKfByTlAoxs5TQbG/k2vVUdJ3Au
         ofNyEv31hzeTK2MoWqeeGGWjHm9sjGiYuASIQyYSS7o7WsZEyQNumihRtDOFrgzrIWvR
         DqUg==
X-Forwarded-Encrypted: i=1; AKwUvBwzLvEbCHt9l8d+JXlWDTsnwUfWljRHLiURT7MV4UtAUqveVu44+Po3T40s/3voGWkiOAqcG4I=@vger.kernel.org
X-Gm-Message-State: AFuF++nXYKyi60Um1PvgvGnPnNqor/S7O3SWJ+EPtZKyk3eGhinlOXkj
	Bc5QtBpNxHlg6W8N43JVw58lB39q6aEwPQihp+9oMRp8vgMEYjeKbTI/FqVeUXdHrQ==
X-Gm-Gg: AYBFou0403h4fQY61NrBbKvpHwsDJXTlEOcluD5+CtkgKI+5/89CgyvCDq0w2Db3W/8
	GO/Nr4axYZ2stoxVfzOyB9Du4X4nF5nd9YeyvN+IB/hhiysLvHkiOW/oHLI/VFw2P5i06DHf9Ol
	pkFbcgwSjP+VOvdt0kkQn6wWZ3EhCE0+d1z6lCWj4iOsSE7e5XbQf0fJ6DpcIJplHCmMrJqExEG
	Ksv1d+ydf2DcSDegAPgBtQeRJyusFgnBODXU4h8LfyTU2oQu0yumINdrrfLImdODmkADl/R6PQ3
	tx+b76G5tC4CeSOSx3FhzklsZvs0yo1dy52gg+i6ZDGYOyOuPcJhUjPQ8+FfJ2jlM08MUSCUjcY
	55BAsSgM9bKv434l6PistltOsYjvFdEks8YRPds9NxmQL9OKj4e1+/m1QcedbikE4Mt21Ms7zcC
	CqotJeCKtrOAjFnbC1AKCRupQnmQV0aISof2xJalm4n1by6UrtyCXtHnon8cwwEsLAABmUFAyEE
	1XsGbfZo+U=
X-Received: by 2002:ad4:5e8b:0:b0:8e9:cd74:87bb with SMTP id 6a1803df08f44-912343f272emr52165806d6.18.1789484526773;
        Tue, 15 Sep 2026 08:02:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bec51c7sm381356d6.38.2026.09.15.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:02:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:02:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: core: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <e2404a51-3480-4c93-8d31-6b796879ff6f@rowland.harvard.edu>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915090223.1346-2-joshua.crofts1@gmail.com>

On Tue, Sep 15, 2026 at 09:02:18AM +0000, Joshua Crofts wrote:
> The fail label in usb_new_device() disables pm_runtime on failure, but
> doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call.
> 
> Found using Coccinelle.
> 
> Fixes: fcc4a01eb866 ("USB: use the runtime-PM autosuspend implementation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/usb/core/hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3345b3298daf..dec6d5c49759 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2745,6 +2745,7 @@ int usb_new_device(struct usb_device *udev)
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);
> +	pm_runtime_dont_use_autosuspend(&udev->dev);
>  	pm_runtime_set_suspended(&udev->dev);
>  	return err;
>  }
> -- 
> 2.47.3

Acked-by: Alan Stern <stern@rowland.harvard.edu>
