Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6D3A6B66
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654914; cv=none; b=B07Ywe9NeAdOw3UVQqos3u7d3/GBAYSqt3AG9nVYuCbD/81ITB2Y6rkb1Mf/0hQW/YCYqSFvIwj0tADYs4+ngxGmR8sk9UqBsMkrlowzG8DjVZFmEWnqBiMOEG8Cls75eEbcoaf+e87MxMgY0F31TxdRdRpYMiQbVfq8VAP24CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654914; c=relaxed/simple;
	bh=G/Jtpz2dyjwRZd8CQBnGefINIJsyzwvfZ4xUAeMXeAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpER5XaK4IFGIQ1bzPvQpL1cctcQ8VSIqpL4N7Dzt8KfE8N6sKgkUAZmuYaxBds0pMi1AQLRWjnmfaPEhlkfhZemVhDhZMI3ooR4UgrZes+Of8WRWxnl2fxuoYETjsTgT55JohUFZuQ4utphrx4lztEu/UyjiesRNZ5kcul0uyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=kCyY0u2p; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="kCyY0u2p"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51a868b6962so30119341cf.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782654912; x=1783259712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNV/A7emqW06YSeGh0bw5IhKLR9YF/fHiPtbm8SqJPY=;
        b=kCyY0u2phgACkIT5UOY80q1vsTHAJQDit1ezltfbcrwIps1AXXDVt+J3/LtHnIhMpY
         UO/ZUa83LXtyMhMXXyeM57ojNJHAnpTbQ3oQjbbqAGMRg7jELULe92UQGG+U8ddCd1It
         JFuVVMWm1VQexfu5wN4n9XSbRepM71K7PcJFaAi81Fo6BkjfX+/yjz+RPDggF2l3Mnjv
         JLFsT1SXdtBoEVj5Vu+BwrWv2/eV1PiIbqyrrHRS3e4HVv66PEZj5KITNpfjf08FY9Or
         zZrkmVNPCpL4r834jgM2K87cHRZWmuGJ8+KsOCNf+KlQFcVXSFhv0TgLqKmToCgLX/LP
         KaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782654912; x=1783259712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNV/A7emqW06YSeGh0bw5IhKLR9YF/fHiPtbm8SqJPY=;
        b=EjhJCB7UN18Eadg2TmudYTuzgckl3cTRw3J9t3fRsTO5ieGn4dYMvXWmJydd/J/aXi
         rSgsZzBU0uWia2RJMNMRUXSAYWBOgklbDEhbYwvKZaD6d8O+b6fQsaPvO20BC4cxzqJ2
         7Vka/6Ry1ayLGclwmX5XtDIuo2qvL+fIfNzXBbfwZofYDNoPYX5TheF/b8dpsbzP7+uy
         xV7pogNfOMjb9bn2RS2XkA4ug045kg+xO4x1aUfy6/2CvTtxOp5KyVpA2upNGOnaWA/M
         hmF0T/CnJOIg63ptwbZ5A22hSmi5bsKdbkuAjyPlFTEN67EDAFtKd+GfeL9579Jmc3Na
         Nj2g==
X-Forwarded-Encrypted: i=1; AFNElJ/LmBYCvqi3ovezvi6uz8xXCUbFjlPt2opnmOPWHb3D2XvRM59Ickr22zJci3Qr6dlySlaXRk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok4VIGg0UYmo2KrzPWRZLxy/BIKk8jGglKD6se+UmNI3FxAza
	MnqMTqRvpYXe1IEX1hdtX8UJrYX47BsdaIqit1+bH5JdH9K/FO3Qq2H/YCbWzdmNlQ==
X-Gm-Gg: AfdE7ckStWhtYfP1S8XCTlhb7KDj5xMzmk5M3uxiUtIhFuLrSS8mfnDugssjbt5zekV
	EPlvaAKVRS5/DpDKHuxauhFyLWq+j+qx7EwYI2CZlWpZsLUxcl0aHjTKQ4kCvxlyBaMVBIaj919
	Oc82OHk/sN8Un58/MDVDT0jWJUbGzK1kpNsgz5ryqZqkFDjxkXFUx1kK+Oe9R08rS963Cg2k5JI
	JddKaL24M1mHdwM/8iMschzLlaJFpoDhafVa2iP5bkL7JoJpiIKTzJuJZnmG2zqIzSeipvIgov2
	xv5HQUhxEwZnVEpHa+m2qyeACOyUk1eroQnnjr7MvIhPXAJmlz5C6NdSXkdFc8Dx7h6qfFsY37h
	52fvO/PE/kk0o7e8etISW//MMr5BugTIPAyxPIDzS7msQTiq4+PZ+cKP+QcZry9CWGhf3jSmNTg
	TCouvaXjFyKLDo7zMxK1dTxpsUl0OHE2w6
X-Received: by 2002:a05:622a:4010:b0:51a:8dcb:d9ff with SMTP id d75a77b69052e-51be5ed80camr62533671cf.51.1782654912134;
        Sun, 28 Jun 2026 06:55:12 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b50b9sm140835361cf.3.2026.06.28.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:55:10 -0700 (PDT)
Date: Sun, 28 Jun 2026 09:55:07 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>

On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> out how to make it properly work with my patch because of the
> following reasons:
> 
> 1. I don't want to move it to the top because, from my pov, there must
> have been some reason for placing that quirk where it is now. so i
> don't want to mess with it.
> 
> 2. Regarding my idea of adding a condition — so that it doesn't change
> the behavior when the quirk isn't set — if the full configuration set
> exceeds 255 bytes, we would have to issue a 2nd request. In this case
> the existing behavior would be more justified.
> 
> So, I'm a bit confused about how to implement this properly. Adding
> yet another condition to fix the second case doesn't feel right to me.
> It would look unnecessarily complicated. I would appreciate a bit of
> help and advice.

If the 255-byte quirk flag isn't set, do the delay before the second 
transfer just as it is now.

If the 255-byte quirk flag is set, do the delay before the first 
transfer.  If a second transfer is needed, you can do a second delay 
before it or not -- I suspect it doesn't matter.  If you want to be 
safe, add the second delay.

Alan Stern
