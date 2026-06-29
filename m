Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4793428841
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752504; cv=none; b=ZSMOry332TRp5yBrbiwvcWDj8N/rfAOTEezhVsKK50XaUTKnX1kLOFMm2XoTWrY7GOGi9o9+8Znf5x8OjekCzThXj3fO21e54i+9lrm876xBbXV+daOsZY6ypAjXmuQ/9GTNtTplwQhRGW2gRoP4CebuJ8QFghiMrJw6vFrQXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752504; c=relaxed/simple;
	bh=0ZbNq3krgb6G8hdaDapKsW5xowxyl35n00VG63vlvsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2PZ/BvyLMjMpzOUhtnTuSBqW/QQgl+SnWc6yOx3oD9Ndy5iez6aGnMaOV1SBNpf5eBWQXdtk86Bneum5QQO+wLtMP8KZe2znbv35zN4AxkOJVSSO8DL+twQO0rIah8vM5xiNX4Cqq8673oPf7PvGFS/rUzj8YT/c7eLSUfjpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=YsFHHwbp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="YsFHHwbp"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51a0188b92fso37894611cf.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782752502; x=1783357302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeHN7utODULOILBow3SQ4SKTKi+vOT1iFpqN2h/hBuo=;
        b=YsFHHwbpRsX5WjoNxm3vYRCqhksFNPQnB0Jc2ywinYZG01tXjjJH3fkHn/Div+1sMs
         ZhqEsZ3KP5/hCtwmCB0sggQycScKKihHnrWvN4HLpcOJuNZTlKnq+N2iGObngd0tVmR2
         sNCaSLYR9ResDcJSB9fXvvlTivQR+tJU0vmOPohlYuGpV8zozEEJARYh8Cc8bA0gcbt/
         mPAqGodfzl0Ws6ujYVGVqZHCS1Omy0pqmvxo2PmF2iMoXoZYTgsg4O1eIA98ZRCZYVFz
         SIZNs95vuTXa4A2PxaBZ2HnF6UIEM5kPpV4hO2xHaCIgQsKcJicrKhkSKSda3VKHsaRQ
         GEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752502; x=1783357302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeHN7utODULOILBow3SQ4SKTKi+vOT1iFpqN2h/hBuo=;
        b=jRpKVIOkCxz7zi2FTmbTzK25d8wtZZr0/RcR9Bsef+ESQW8eTmWU/EE8Gy4/eHl1Q1
         +xRM/s83qUEelpuHcJ1P8CwhTewxNGgx3NthdnK61FyyIr2Jb4oFH5W6w8iXXz6WGdOZ
         yPMzAXWKEkeJqEyf6r8WihjXogu9lma+2Yr3bkvAtzyedscp1YvxHEBEDBtFy4wagdwz
         qr9WNGuRke0ruAnWD8spg/4DaDgX27a4ILZmPRadnor/TZl6hAl5LK/0V5jsJO+WL8fQ
         KU1e6gcY0O1vuX4YYPkCQst27YOlPFJpUhctisuuGxyxpZDeb5q1mRHl3KG1shrEWEEc
         HoGw==
X-Forwarded-Encrypted: i=1; AFNElJ+kWt0llNhk4LY+M1gAfw/uf9jcaEF1lYTPrPVtLawYip4+myyKpeInkDQhVat9MqCZ0lrfm2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT8nKY+sLguObkU3CHdlpxI9k8xCMuWB7KF+71NmirLh0/uh6
	6DbXfO6UcA/7jJ9awjDkFtWo9x0F3nwVirCBi+1rm0XWlRHBD1qd2BdgNjFFXjEjesVVX552ar1
	TIFk=
X-Gm-Gg: AfdE7cmlVIXMI6IN7vmBbAahHHPZh5mxkgC6cU7yQVK+MDFswIrMgja9LFNhPZ2vwtS
	Rq19IRlWS9OWOsPMiViayuKgFL1e/9IOb8D97zEksmIVmaEqp3YYrLUGxFs0vk+gOlr6nCVQjr+
	Wm7bXTWkdF6kBS43iHoZ2KhhHsG0FAIo0bgwpbr9hMylvgcaZVLqk2aKB5qkZA6em8achIRAQux
	gvcffkRUYhcQJt9MqrqOzAH/V0S6S8gepANnPkM2MyTkJBUaW/RBNnu5lFcIh7JT2caAzzVQb8T
	MJRB+5slCOlbhwyllyChsdeOxUBS6ADOo4pk44BoVjMyMWJUOcH4pOlCee85wAf3GPCwDiJ5zAV
	KhGsh+HgUbabOcQOQeo2FMnW57VUuzQMldErJtzYieFMVLq2da6MubheYXcPhZ+aopIuNREmma1
	BKyWcqvqngm9ffqHUBGDz5dKK9Vk+JnzANGAFO2HdhLTsgqJZZqHP0sbek
X-Received: by 2002:a05:622a:551b:b0:517:8446:3afc with SMTP id d75a77b69052e-51c1074e85cmr2361671cf.14.1782752501737;
        Mon, 29 Jun 2026 10:01:41 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm881251cf.4.2026.06.29.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:01:41 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:01:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <e7d49127-0215-4b29-9a2a-e1dc0d889b70@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <20260628231634.6752f74d.michal.pecio@gmail.com>
 <CAFgddh+AUNH9Ji-Qd=BKEDZWJrzPMWN20-g-htQDPSdSehZStQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddh+AUNH9Ji-Qd=BKEDZWJrzPMWN20-g-htQDPSdSehZStQ@mail.gmail.com>

On Mon, Jun 29, 2026 at 11:00:44AM +0530, Nikhil Solanke wrote:
> On that note, I discovered that usb_get_descriptor just blindly trusts
> the caller with the allocation of buf, it never checks if buf is null
> or not. There is only a check for the size. and then there is a
> memset(buf, 0, size). This results in a segfault if buf is NULL and
> size > 0. Perhaps it's time for a new patch to fix this?

There's nothing wrong with trusting the caller to do the right thing.  
Besides, if a segfault does occur then it will be pretty obvious that 
the caller needs to be fixed.

What would you do if buf is NULL?  Return an error code?  That won't 
help anyone locate the bug.  Put an error message in the log?  Segfaults 
are much more visible.

Not to mention that nobody has complained about this code failing, so it 
seems unlikely that buf ever is NULL.

Alan Stern
