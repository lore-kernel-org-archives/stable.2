Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A874398EB
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512036; cv=none; b=pa73hRB5w5hxNLmsmw03FuBPTufEFO7jO7GZplwtch6TtvT3tsh56+hPr3yGBJyt0DBIme734tnFmbhtvaCSGt5X+16cFpeEswwXY2yVqycAJ351iXjxc+YK3T3olYien4qAnb8UVDEfddNQve6W02qWBYoC3jHhbKS8fFfPZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512036; c=relaxed/simple;
	bh=woNq/l+3U0zz2akwXlegxA86rTMivcRmcH7/T5sMXMo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FMSWtSiOyUHwkvc1qxEFoOoT025TEAx7Kz+xnU+ENMyF27AIoKOdjVUShRgxEwwVg1uPhhstddPdc56g3KlzekXWNEjhYdJKUK0R7IWkT7rG7QRHZzUaqOKRea/PIWnKRq3BJcyZbUdhDLrp6eMLidIkJUbCawSy2wVYNTtlHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y3u1vViB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y3u1vViB"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5276d598b96so5292481cf.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512033; x=1786116833; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=Y3u1vViBio+nqrIXHc3PLM8T7DOvrochPqB15/haNdLZ3fXpwy0nU0obhbmwqe/iX2
         l2MK3TXATohJun+/SSNLSvnA77hZG2imJvfgezTMLOv4lpazgEOov++Msg3p8ZEl9mMD
         BhJE5AT9BBTnQkKoBvXfUsHKW281dkv8wLQytxLkMrLdO4HsokQ20EySQRQ5YT7F3M3w
         eC46HBMOhcGZJr0V3ApkDpMTFNMTGajV4sLrP/UHDJwxs+vPWsC28IIqHCCb2TsH7VeQ
         sE8uvaZkAP2MBwHpT/pgq1LPxt17ovYV+1WGtCO5XWfK57b1mdqAS6uDlbwEhNS2wXp3
         Y/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512033; x=1786116833;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=dF5Q4HGTANJMP5MOZIQj1bsP7JXiGM2NAU1oTu3SgixX7nlv5J/peprr3l6wMYxibT
         ofgwYgszSrKPYHoZMhFmC3IO7clYxgX0Kw3vdLKwqdsViBbirzLRSKFt7SERsHgF3vSA
         EXnvDCqNgoSslPNnHJpVJyjt+0UpjzGiNd3UhoNSlAmupFMZUpEwTfOuSkAue6JlYj5g
         oWJmeVLlbJftF0ABIHVi9NduA4DNEbRroPjZPzpyvm8esFQmSu56ixvDc1ilESpH/APk
         NJ3b4Jptlv2AX7XtqFPlP4ZO8JnnKvADIXWh+0VWzKonz3bZ1uVJtuE88Jwf2Kf+Ozdi
         j7kQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7onAPnb7zeVb710dilXqJlNVy4uRSCXWzx0CpkuTwjdl6skFLsKL2znYI55XSaBiheIaM3T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gllcG1xhvr+pv0Vn9IvMKTuKRLk2921Aiea9qRnFh+2ZYtQA
	gaNxfp280MLSYkP3meIvTbTpeNIS4TvW9vZFhuqQzwtBiwropOJ7ax/l6Aaulw2eqA==
X-Gm-Gg: AR+sD12m6St4LSb9JFzOkHq2OEYE3G3l9wJvbJWJGwBUsV2PQIlQ+c/XdMUWJNA6ZHV
	qkOjuJFHWi7VlIpG7XWrMXV/xQZQnBcYFBI18W78ZKF6P0em8dHPtCbGweHU0KkxHD5FWdgR/vM
	QtISBu8ip+iXBogI6WxSEltdMxheLcT28rEGgHgka4AlVe5WCNVh/DM0e8AeyW7JZFjRSZeOHkO
	DUVoW/wFHVpxJklhREy7DXOdJjclhB4geZdliZcnM7qF79gr+ROwJ9YYLGlRBit77Lps9Rs5SKt
	wQeE3vMHtJtab0DaNsAPkaGI3s1B9Mnaubcc/qF8Tf4nWZfnbrMcJvBu1VtRSk0NL9JO4Z/ig8U
	OoLMpCTG9xUe2uJWO73tJxa2Ru4MJUOqdhr9H00Aj1xFhwW78pSDksufQkCwUoUTAOuosHHFvDq
	vg2vP8y91ZbnRH8kdR8uvsl3feMT2BD4TnI06lZ1aOaP19f1QoIu5sW6Ep0baBVgo97/wC67T+8
	k9mZVqA5yW8sT11rOTUheJYdPN3CwZ3cg==
X-Received: by 2002:a05:622a:181c:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52b566f6f4emr11298121cf.5.1785512033469;
        Fri, 31 Jul 2026 08:33:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebeb909sm9993881cf.29.2026.07.31.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:33:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:33:52 -0400
Message-ID: <f3768f73f951ef02b4fc3f89d53527eb@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260731_1130/pstg-lib:20260730_1437/pstg-pwork:20260731_1130
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>

On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> 
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
> 
> Do the SBLABEL_MNT check before the inode security is initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
> 
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.com/
> 
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
