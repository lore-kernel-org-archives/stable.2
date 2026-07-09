Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF973BBFBD
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594226; cv=none; b=Ag31GJLKKJwuQC5E+wdjbWaOvSpU+CzTb5C1/lSTKWOA1pPBVkITriuJet+u2YiN6umK55ASv4Wt8vuKix+KCepqldOS1a4/2mdZoU+SBvVpu8yCitjvKkwFlpgtwfCN/5vzcj0Lw+hGUllO1y6RD9WmGjRaz0/FCXf5gfsBWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594226; c=relaxed/simple;
	bh=cX2g7yN7CxbeKX26fPZDKH5AZN7XyJR89rq5sBUstZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDIKgJlLP3SYfc8nPrKlRilwRlWWmMM0Z0qmqakg49rQlnOsZIAjMN/bvyrSGeRK5MSaegJVatAwEebb3tXw9OUax0WcKhVcmwnIzGlwyJGxQdRBkcnPPP/3NjfBZ9FUUbjqNxledQK6fwTgKPx978LnJNXhu5ZFoDD9SavMX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJU4hMQj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJU4hMQj"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a381bec3f4so170524eaf.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783594224; x=1784199024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k8iBNfPXmnCCmwf2N2IyxDUsXI39mwQG20vdtqKjBcY=;
        b=CJU4hMQjSPceP8CCaaI/9QGAx//DXzcSXMCVCcLhg8ZT7rhmkJZK8nYuIVf+0eBwSE
         pzMXlrA6pU8SPgKEVn5b9gLk/Phk2Rkd5NwXoBCjjtDdJhv0iyNwFtYUlDZLrsuyLtpm
         8jWDByCrIkyji3mGo+JT4XUz05tXb817D/6PDvQIp50ZiYev3TYZkNWza0QlUnzeeXxN
         vGRHj5I3uPKT4VaYK87aev21s9TZtij+EBTP2SJcKXjUVRC2WUURpBxwCnz4pXmiZN8Q
         aKikPX0e4EdkhFoeJfDlqGbvOnHOrr8sDXnya2xb7mMdhP4ebdBzY4oakstM5eqqmcU5
         iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783594224; x=1784199024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8iBNfPXmnCCmwf2N2IyxDUsXI39mwQG20vdtqKjBcY=;
        b=BgcNdWozD0hXS1WCRX+fzsI6F6lnMx88Fwdq9+aLsp3nwn5QRRu4mzOojBEwEBQTqy
         5khgt042wXvQvevPhaGRhxt4rpc3DlXdnk9enc3ldN6quA2oktyqjO+CHEYxLH7VzewG
         ZbsgDO/5mhjk0ZHPuYERgaCBLUt9meVnpQeCmipwqWso7Y/ZnfUOnl8ELvgxDR3jQ8Gp
         2pUObSdvBbWZ0xfImwFXg7x7QS0H3lRxzMpX27J3PqZ9KmcII5WGr9QDMTC9qbaUgl9/
         TfZ8MUr6L3T0KoESyrClZSVpLHVhIvs2ruCUoppJx0jMsz+gJmCb6rtCmVpGZeto2rxO
         ibPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2gUEHarzb8GCjmolr/V3pKvOOxJI+5wfIGX6zoPQz1RXHlNswl1rKIv1q9FkzW2JTy1TfC0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK9H2rRWx3srSeZz+Botz76hzSFtyjfhDtXChWoGf3oyTWRMA
	o6UMm7gBYfAkJOraAtsm2LPc9l9lP8XXynJL6lwEtSuEexqAjZP1B/Qb
X-Gm-Gg: AfdE7cmcqJgpWtzqlEyUWrxwivoDgXTa2h/wrYhU+5BeU+XySSOj7kKUSE0GZMYUFkM
	dUJsmIpCiAfZXSSNAylTNIEeSqx8zfVqo5xHIDTUR654RQPrk6JbeErffh+KnSGo4AKNcES1Bfg
	N3L1YcC2pzhL1Kcgc9badfVTCGi509I3rBFdlDKUsX5F7Xt2IqMvU5+bsnxiS1VoEGiMWWuTp1I
	L49JvYGlSgjJKoJUefIb0BmwNQkyvuFOfMmiXeSn2GyzuyQ6DRU0ryxWEyIsrWsyyR09ZwgKbiU
	p04L9wSLEmxmtSrSxTvqZEhfmoHyJ9uOpTGXnxfZyk/wS2kmSIoNFmU+NHNr08V9ijAHwj999vL
	pYPbJCxKgSNuIQkoQEvIbT6czT+Z4JxOVAQCuThVNNYVvZLVVkk4IePjZgmHtkbnpEUIUOMv2yU
	hiRQQs
X-Received: by 2002:a05:6820:2014:b0:6a3:14f3:3cd8 with SMTP id 006d021491bc7-6a36da20005mr4557700eaf.52.1783594223912;
        Thu, 09 Jul 2026 03:50:23 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a66b668sm3910366eaf.8.2026.07.09.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:50:22 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:50:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hao-Qun Huang <alvinhuang0603@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>,
	Nadzeya Hutsko <nadzya.info@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Martyn Welch <martyn@welchs.me.uk>
Subject: Re: [PATCH 1/2] staging: vme_user: fix location monitor leak in fake
 bridge
Message-ID: <ak986K54RhRDMpfn@stanley.mountain>
References: <20260704065817.403111-1-alvinhuang0603@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704065817.403111-1-alvinhuang0603@gmail.com>

Hi Greg, I'm back from travel.  Should we just delete staging/vme_user/?
I don't know really if it's used but there are some pretty severe
security issues with this code.

regards,
dan carpenter

