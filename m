Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215730B517
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894783; cv=none; b=DcAirAzwNrvr7XKVm+4Pbo9BfhIvPRH2w2kQD03NhHUQ8gSRjOtPK4kLbD44Ez96PGqtfq6UmVvtvYAL8h5Ap3SyrXk2o/jgqbSRavCpsuaoGikgdlCRzlidqP01s8OpOsP/dwjwQQzO3rkszY+m12K5aCOXHzNDxvr+pvu4plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894783; c=relaxed/simple;
	bh=EWQLNPK1AUAI+pNpdpq3a6y6uUYIGTK0BN4j1FD0cxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A13T9NWEcgsZAm0CvjwdMwBviwYnGmDu7c6cfDraHES/Njigz5OCUdSEnVFqVCAuwRa8bA6Iz7Y/0s9pC35FWj2DjH7v1I1J/bZDfYMBEWHb595jhNABs4RJCXxupZn8kBO0OfntjwHKghUdQ5N18tOArGhlwiPxIjG+MGb3Ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pX7HTGZ/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pX7HTGZ/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so69365ad.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781894781; x=1782499581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q63lvOWSyGFyoDtx2qv9weUbM77aGJ0C15XM//TDr7Y=;
        b=pX7HTGZ//o06ejbjh7ScI0UzaVtVpq5iXGRkyL9JZ3Bxh/LTT1iAMKXBh/uz8UHo+C
         itgGMMODdxAkhjgYlK6Vs6Xrg58dA9S3TL/KE4UcMn7izFVSGUVY7s7xWWJUEvZ1Oh1i
         7YvumeCG4SxNXgZTmxLkhimub66B5/Lo0MaDMpJiBF+POybhX7lBm/+tP08B2zCp/Ydh
         D774ypOWGH93Wxgyy0RBt7yYYLC7RenYZnx9VYouGli2s/AaKHYuZrxn/6CKsxC9SnGH
         1VQAB13gkhKgBKUrK3Gkm7q+IqFfVIXVQ/fILKaMgdU7NPekzFB3hQdl5VVJ6K5Qxhq9
         leuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781894781; x=1782499581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q63lvOWSyGFyoDtx2qv9weUbM77aGJ0C15XM//TDr7Y=;
        b=SqffoZl8BghNwJ1oxUNpjSGwomWcy9QRaiG9JfIOQXKl+NRTmGHIdajQ6I+Y6RFyW7
         psZDpSf3RVEm6yaGhF1agFcCibXUKt+MiIrvd8ij5gYkkVdjlhtpEweInwmrXwkwdXJS
         NC+JeIV53riRAT7dG7A1RsmubRXumR6O5CgY2r15WAmkbvpoh38bqK6+v7qkr5+wr/Nd
         7usMXCdQpzezekxj+QsMG/CXCs+C0gT6pktS3iuOQ9CBzLA0KZOktx/u5/JJAxlfODmM
         t3/S4x14rDsVr59L0ebiv1bU3WoNha3uu3EDfXw4TyH2YiXBVXumrocZlnoKsutB1mg8
         j4TA==
X-Forwarded-Encrypted: i=1; AFNElJ+Z2XWPIA6r4X7u/ZhUsR59N08xU4yP/EQ23efX+g96QT/AjIrA4Y+XbTMxKYPw+pFCzqrHkU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lce3is/4VW1xOAAvNev8VEyhGbCaPD4TK9Wch77hVY35cggT
	5ym2+KbXjrDx1nb1qIPvHaLw52/pqjBR7UWSatBLPyqtkJR9jiZFzbusoyDlj910mQ==
X-Gm-Gg: AfdE7cnHkGmGY0HJlspifncbEMNF/n0cbP/kLL1DBli4Lj9wpq682BipNHtKcZHLyj0
	pUeW5y0cSKHZYyaLxWg/3SUUex1NYu9nECusUL1cLlCG6lq0D0QsxQlOP13uUMlhqobjC0spcox
	GJ10JmeYVVBKCqVkMshczh1poifYiOBpPiOSd+SFbukxZSHPpC7uTRRqi5+yBHzju4UkfNJFVzM
	Yrw9MtWQkKPoxu+6Hq3Rjrach2dUxVemuGahmgcO0jBD9MFPJvMfY4NePZXqTP3yqKuEWnUHu3O
	iaBhquDr5Myudvil/z/5w/7j9rm+xd+D6MY9Bh7VgwbFBay0x/LBrzbiy5F4eePH2S5P58e5zEy
	k88PYgGR77G1i+cByRwsVBeb3s6hqoDC+8HD5+H/VDFBqee4mKu1eetSKTZp4P4INmGXrYap+I9
	yIEbU6R4oQmgksCTKsHcpkDi+zOId5s1a9Y/yg7DlsP93xXBQr7Kz/eLf06uSOSX66kTEPCX751
	W4fOEcUGkjxIwlm4F8M+NcUMd9mi2egt4c=
X-Received: by 2002:a17:902:f684:b0:2c2:2485:7086 with SMTP id d9443c01a7336-2c72007c547mr245885ad.17.1781894780900;
        Fri, 19 Jun 2026 11:46:20 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5d04858sm392064a12.28.2026.06.19.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 11:46:20 -0700 (PDT)
Date: Fri, 19 Jun 2026 18:46:15 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF in binder_thread_release()
Message-ID: <ajWOdxR2BlQtlIM5@google.com>
References: <20260606022233.2402965-1-cmllamas@google.com>
 <aikJKVuny_eOivwN@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aikJKVuny_eOivwN@google.com>

On Wed, Jun 10, 2026 at 06:50:17AM +0000, Alice Ryhl wrote:
> Although I don't think this fixes all issues here, as we discussed more
> in private, this does fix the specific UAF referenced in this patch, so:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks. I've managed to reproduce the UAF that you pointed out. It was a
bit tricky but I have a fix for it now. C binder just keeps proving we
should switch over to Rust ASAP.

It doesn't seem like Greg has picked up this patch yet, so I'll resend
this as v2 along with a separate fix for the UAF you reported.


Cheers,
Carlos Llamas
