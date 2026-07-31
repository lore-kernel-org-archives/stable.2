Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB262F12AC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506047; cv=none; b=lByk/XieVSUZRXW08Lohg45NbE0YEG0569Qjouow56Jd5RUHcTIY1+wuIDFOys7P+3kD/FTsjutUMfjXqYUDMauSwQUJUq6v2gJJN2NrMbfZ3n9VMdDMUln8GTu042cLU9P6XhuIYV8f3cRvJzvBiqy2/Uh6jg8cObFjVaryl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506047; c=relaxed/simple;
	bh=XnSPYg57DRaO+9NQhcdSDefLNSu6VNnPlnWcrN68V94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0PY2VcPgHMjvqkW+JE2n9h19Q7EedXh8DgbQ9HkONWKi/F8sHfp2u9QIBmaE5Krgze0mrBL7dArnFUxEeg6EKFhWdG7vFMtX5K6/OrNNdbtyU/6ZaVMcWF9FxsiCYO+mQQISCEIyCFIlhb3KwcDYtzImK/XZD6LNEUGUDR3qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/OMwmfL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/OMwmfL"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e2dab83eso147031566b.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785506044; x=1786110844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q07s+fTeCEbc39agdRyb/qs2zGQJBvKVPPRteZKniHY=;
        b=C/OMwmfLeTNvCjkzJjWg2+i+8Qre6Xfz4wCLaYmw3GFF6o3BGnZYi6dNok3LjGNZ8h
         HrsENKtARG3q/i8mMh+WvaJoYXnvZob28BmVIggaILbj+Ow6ySZShXXyQMuDknOYBxM9
         EK46V1KHO9DWacVjeVXPbUIOaGdDpnBLsWV+2OFBexYCkU8pDcG6YwrX8PNFnJ2FjC3N
         +S17i6GJ5DJFei9M5OwJHj2n+WPfOV0t4BdiwPyy0NBOLlosnCVaj8w8DHhk5qGCb5MA
         0fNuBmQeEYuyHYd0AEV33GRxvpx3VEhZGt/WZaKjLYvoWP/sY5KEDmQxXpXPUNFcKsoN
         GG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506044; x=1786110844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q07s+fTeCEbc39agdRyb/qs2zGQJBvKVPPRteZKniHY=;
        b=Dt2a45am8iSDl8Z7cN4vvA87zj9oBrN8iHSWmxP9Qhq9meWDjMXE+jKnqpUoIGd6QV
         q+rWAEXC0WkYserSOjT1Om6vYEkgxUxlU9Pb1J60lAfi51cBdT1cCllX1g9K1KmBna1T
         5xcj34vOHruabAs4voOhsrv7Iz0Iv1Vf50d3p8k8QBJsi8T+dRkqdfe6TFRvEG9Jj/mP
         aA+GrMNS2rqBu0O10TPMgx+eCjx7K+kkl0w2ltWpfRGmyX/igB8c1S8g77C1hr0tQTrf
         2pnvCqAN1HrJ6uPoFxsxUuM7QTKB1RGenPsT/TzLJryQifM4R16LoielWxHOGcueBWZV
         T5jQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBioWp1WOH0IQdbuNwyKylBoln7SJttmMuI9chn9LsSI5yLv8kuPfrZWt+ZkOzPVLuV8mJTvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0VVo2YSDelO+jL0B0C71fXEN9N42MFi4qqfdDqxbheNopNKk
	drcH/VGpkplnRqvINdiVO6is7Q+hgH2BtSL/SYy/2gGnk1bxOuOB/hq7
X-Gm-Gg: AR+sD130HuGVgpqvVrdap+BGZbBN26NdjGAEhITW1gAAtMNEsBbw73FuAoEHf7pny2f
	3BjydVjfLWeaaZS1Zwb9IHn4mrpsWYG3yjM3XjmNtwrIslpMD5FJwzAhHDET4FY4BPokPs+NKrT
	DK4kgJubcaDBCvgB4ljeabq4hSgZEysf/ix6LVMq2XI8wyWldYXTQ+1EQi7RrYr+f6Oig3fnGfk
	hn5abck2I89c8Jlq/TzSWVVIOn+PAn+C8wBm6/2oBMmozlH1g37ggRMSueonOLxnavIqUNWSRmV
	gJUBQO9zFQ29E8tJ6JooipWB3VYBhU9Bwm/666Rf2iPN3DIG6SbcKzlTUhzQo95kFJ6N5lB0Gcw
	gO+9IVyogdm6EnmuLWlmstsxDYmK/LQi/DnY9li8HDDJiAWr7DXQVJbZio2oYR1l+E3ghKpaul8
	ftnT6UGw28JmgWs/Pnbw6COAEq+ykQ2V9XQJlL9ElsCT7kkU2dtKqOyY+hPOa6JTd4eel+u2grB
	z0ehyIrOHpCi40EPJhkxlJ7uV+agKS0xLLC6Bw3Tq3GDTe/YSvVFSvqbevVosbbhG0/UXYMs3VG
	EsteOgNRRGsC5a2OlOmA9hXBszRPN/bcjrZNc0ar+T2vIH/e5OJ9a7g8ikgPr1BduURQIgw=
X-Received: by 2002:a17:906:7945:b0:c19:fb6e:5fec with SMTP id a640c23a62f3a-c1fd23ccb41mr126779466b.18.1785506044262;
        Fri, 31 Jul 2026 06:54:04 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3ca3b53sm165306966b.24.2026.07.31.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:54:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:54:02 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amynpoQscIXD0fu8@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
 <2026073011-crock-utmost-6392@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073011-crock-utmost-6392@gregkh>

On Thu, Jul 30, 2026 at 04:31:51PM +0100, Greg Kroah-Hartman wrote:
> >  
> > +	mutex_lock(&imx_uart_ports_lock);
> 
> guard()?
> 

I'll use guards for v3.

> > +	unsigned int line = sport->port.line;
> 
> Why are you reading this outside of the lock?
> 

Good question. The local variable is unnecessary. I'll remove it.

Thanks,
Karl
