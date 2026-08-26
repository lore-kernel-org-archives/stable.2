Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD98331EB9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745836; cv=pass; b=T6NUKs/V6SdX8J69BD/iGAs+awygT5Ul3yNC6QUKfnwz0YGpoQ3Jv7VBW1vKl6QLdlk8XXMBECSTUC2q9Q6ziWy5yXWWMLOqfD18pvwyE1TBAzLCI1tP0dJF150/hWydHseZL/HRWvFAE0gyMZjI/4VPPFiXW+eMDuzCG8wY3M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745836; c=relaxed/simple;
	bh=kqQV7FOuBNOfwsjfxs67LL/EcCSG5E3GWVr1Xi4F30E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6W3cJLwKplrovZUk7pZqVcw/vmD3OUiGg89QBllPZ7WGZNCuTv+Ll/BuA5T9BGBALnPicPd3dYR8+2Lpp859kkxkG8tIaX1tcCazZLxULj3Ut5qh/nPScqLVmgGNjs9DDcs2w/T/vIHlQ2oDi1jWNgeB6IpfhhaANPiQ/tSXoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJsSdFTU; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJsSdFTU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e2fdf5abso314928f8f.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787745833; cv=none;
        d=google.com; s=arc-20260327;
        b=WZ/Seis+EHKyM3RdQ5m16Ss/DEhoFK2gFpU3rxTIig1x0GzRulGBsSmF01+C7Xagia
         2kf9whO6l0peeYOzICKQojACy1P9iu3MNrXtQK+vcLOmB083AijL88bW7pq+/Sc3fOE6
         8XjOn2zUIbxdbv1cISEWADHgTdd65d2bWtxRRRuFkQxbpB3ueL8DpYCP1M8+tLTkHBmT
         BJCRNqG0qQXcxREgv3a/yqevf7jOQzlvbgSzIprF4dYuAmHnhz2eYUV8BK7DPDRLnst8
         9lfd5a364cc8q497YNkj46BzEVzsSGpef34HLNF+6XPkOx1VZNze8M7n+ouR5ZeDCgUZ
         Arwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        fh=pYHJQTNeSGYcJ1513Rm3AI8u1E/faPfdW5zi1ONNW5o=;
        b=hXHxwEJbeAtwdAF551Evl03VP4m7KxnsVzyLTe6oaoZv7rOZ0AlHLGjNi4cm9eH7tF
         N7NMvpPgRhYvAvnlo22K25czpVmig3jjWqWELNuH9B33IXBTohfK0gwR9GG3AeLeghfp
         AtmZSp/que4cOPII3CO6oV/GPm7AIrrE4V59hgFQeZ7XGCdVF4aRo3pYizFkHhv4aoRM
         A93dIi+KQ18NsitWzSjPjzFJwGQgUdlPBZ13SoRfqssIrNiEwBCUqqm3nsKMroKHmw63
         pCNKuVl9KscVajg/VyQ3BSwZaEZXuIL1+33/gnZEvuOCbaZvjOdxu2w7T9DezCWDjTcF
         osXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745833; x=1788350633; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        b=LJsSdFTUFlhSxjlwFeCaUPlDhs4gHq5PKVyPb71YXFH1Zz53gaMuyY2sM+2dA3vOvZ
         p3kbx8NX0/ms7/NUu7/mHBk5HMnTA+mJfKC5yg4W5ZuzydeLepyIgpul57bscDTJlRDw
         85S9ti9/YTMqNqrftvLqN9OZkCuTNJQDjyi/I9enoHZbLKp3paRDteTldMoU27Irb6qM
         ABFyDVGt2GZGlno1Hnmi7jKk+hYy8jdQIHYmj455cdk2cgoWOvkahDuvHACmP2p2TAXz
         hLtR1csMoD2WThlVpt3saL1Xc46tSFmeLk/5RG7LMWtx3rLp+O6YxTgLETS5afjN+v7H
         8ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745833; x=1788350633;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        b=AVTseWEppCD9UowS4hXKzXAI7QjEtkQJNEyMrCIEt9Bx+/NrNJnqQB/XymTrbCmk7+
         fuMZBWA2Cy7zUICoOF7g7EdmYyvASeFAzLZ2m9TcVou3v0eZrYExWUIyNxbaTerIaYn+
         HDBu+oud7XD0Tm+gQF/5Asc6k/oBX2MC4rjpIpGNshmjSnEkj6tECP5Z3XjlOeg64AnB
         aAFkr9JlOOodoY0SM0NNTwKQ/V2NJVJ0K8xiVs0huL0rNaNFUPK9r0himgvPaCePWAUy
         KDVj0sq1eTdZJlzr81mpYLxaIubZ3i8SVUisI4DQx2NpKPygK3FxsYxf/yXpBBgPoaqk
         fjWg==
X-Forwarded-Encrypted: i=1; AHgh+RqFz1zr3okWQts1qx3+c+QFpLAvmP0Cfm7Qf+h32/gDB9EqElRMvsRC6IbJFw5umuFSGzccbio=@vger.kernel.org
X-Gm-Message-State: AFuF++m8PmYt6kyU/TFvTEmNJEnVneeyXzWuiHvIvQ1G6y5iVzcTCkeH
	IooTXfTWfVxPuCuPblXDACQQ4vHejJJRJa3xQDsXf2DMtt2iS9zutlmatvYiy8JPM2Ck5Y4TWYy
	u/BjPyU7zUGpKltN9wdONGWG3Obr774w=
X-Gm-Gg: AR+sD12vKgkAGm/i228bsIX7XPmu9iAV0MDFWVqR/TeoqCqQZsaf9djtKaw47XTI9KH
	JFYySyOYTOccJjIEDLPFfq5dHHwjmKc5bcLSYED7E3UHr8LhwNmfdGCsNUmkG4L4rSnU/SZ6jxs
	2mRAf8GJFQ5qZ/CZGsMmYLKVRML1Kdj5IpuFVuU12O2RWXh9e7B6qQ6qcywnArob9WJ5hey3EaO
	X7Fj6NXf1OEuyp6DNUW/WCrp5+9I84diwAndur/PEk8fW44yX319B2z+Spt9/2n5fxOuAU33T96
	G5cyX1MlWvkWOoqzSaOTMGDwinUZeaWaGVvndxCLzw2ZTJ888AXIuT+iEawv2zEJBGH5CV9hBVS
	Tqg==
X-Received: by 2002:a05:6000:25ca:b0:481:3db1:a62f with SMTP id
 ffacd0b85a97d-482e270a5fbmr6535891f8f.17.1787745832819; Wed, 26 Aug 2026
 05:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822124531.644834-1-sammiee5311@gmail.com> <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
From: HyeongJun An <sammiee5311@gmail.com>
Date: Wed, 26 Aug 2026 21:03:39 +0900
X-Gm-Features: AcwNN1VYn1rMJH0uBE8WqY0o2i5MTuBv0noINf9T0z1pd6bFWRTrogWnyxecfaI
Message-ID: <CAJciObF_qN2G0RNpqO0N+DURop0Ja053QY1krfneCT0bmmv51A@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer
 for the DMA
To: "Xu, Even" <even.xu@intel.com>
Cc: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 26, 2026 at 10:10 AM Xu, Even <even.xu@intel.com> wrote:
> so it's not a problem, that's why you never reproduce the issue.

Thanks for the explanation, that clears up the SWDMA side.

I had read the RxDMA2 side as a separate case, and it looks like I have
that wrong too.  input_buf is max(max_input_len, SZ_4K) at
pci-quicki2c.c:607 while THC_RXDMA2 is sized ALIGN(max_input_len,
SZ_4K), and LNL leaves qcdev->ddata NULL so the max frame size feature
is never enabled.  I had assumed that gap was reachable, but you would
know whether it can be.

Either way, please drop the patch.  Thanks for taking a look at it.
