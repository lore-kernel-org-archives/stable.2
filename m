Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CC2701B6
	for <stable@vger.kernel.org>; Sun, 31 May 2026 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780201534; cv=none; b=H9qKo6Canuf9FeN/nBry/xUcmk/7kamoG1SLuZZSBIbhKSmLg2VLIerm/CBZQuNPe6zqq+w/nN3S0LVNa2KHJ8BY6dEwyPLpCP9yx2x9YNkdhTDFnRl+jMOrW77wS0pL/+0sRT+i0yRTmdGkbxT18CdiETQyzPf25bJcIP1UqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780201534; c=relaxed/simple;
	bh=FQrHc7/WACHtQhLJsx/v+kkrVB2a5rej4lOPYVo0LnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpZaW/di2Hpl7MLe1U7Egl9z630ipyLZkPwUbZnL8mhTicq+z+vMxoXmG+HIYey7UlXcxoYKsWyHSJ0VfBNo7lyGhTuThUR0AMopbZ6fl3xCIA0BYpuOslBwM8Na81NQc32PqPc3q21XElzUqjZNEVD6R4qlTkVZ4bVpGDtFVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgpkVZmG; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgpkVZmG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1728870eec.0
        for <stable@vger.kernel.org>; Sat, 30 May 2026 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780201533; x=1780806333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfXUlA4q1Rnkp6HcFZLfh12tpxz5WVB+RVOLL/F8nHA=;
        b=AgpkVZmG0pIHq6rR4hylRzv9wSql0c7w2XUcI7uIqPs7db9pPVq4LOCgpwjBsoQN6F
         occa+sUecVpfiNMSeFKGnpW07r91i42D61PQB7XPw59jblwydRd7sVoAVmT2YF2Lvrel
         Y9X5frVnxipWK6ryV21iAuS033WnCFk2Mw10nYXARUi1vAzz3wjOKFFl1v3WDjwq3tac
         O6Zbpg0erAP3K4AokMq6EaA8uBaA3VsLVUSkgVA9qtgWsQXywCD6N5q1sgSQKoNwdgoT
         ktd1P3LNfKC1cP4Oi5KF03fJjEyQ7Ld5qMERCvb8DgtiCJA31xuJtV0CDC4dNkrXjBPX
         pJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780201533; x=1780806333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfXUlA4q1Rnkp6HcFZLfh12tpxz5WVB+RVOLL/F8nHA=;
        b=UcbFBqnsybBXtI2DZaI6Aab1ygpOvPka1GNL1rDOJ8l3grjm0bn4pU7q2Wn3Bf6A8p
         xieGt3DMeICblAEAowAqb85ni7IzNkgSKiFZRz0EM/NDckmK/eNolMtCyyoDuwUFf9/Y
         FHOuyuNItbE3eGpUTKIRtqwZrSVwuOx/TEB+nQ5FtSXFCp0MY1I9Mfemf+Q+rfQgxWMv
         Ol9GiIkV6mmkiFQlg8PoFMOScJLxdFUNxDNsPa4zNyvMejbB1d+hgECopQe1Z6urQpsG
         saz3arC7ANcDDdqWigPfbk67zMb8Uc2VwKBxiXETiZrHFoj3fM+ZQnVh4GKiCkuPFsJb
         Gitw==
X-Forwarded-Encrypted: i=1; AFNElJ/Hriyz0LA5muF3veWl2PG1CqxSnUl5xPrs1UBZnCW2TOBKziBGVgabNyCezA4wAQ5cC+LNtyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/3DjQi3sqEi6OKJF21m17dEMs/KBCaCgdYQAL8kls8VJ1o8Z
	Qm/Mm5Rp7qPeM/dfXrQZAIm9eN8tA5WZZmLH53S9hvKoyqgHzGMrKh3p
X-Gm-Gg: Acq92OFyYHzpzlBu76a8F+3soHNtOnujS1ID8vWOWOtT2InaGK/G8KgJtCv52IBaK01
	PItWYeoXtXEU0PK1yxI1ggzTlE05uPaNUrfcyXr85bJcuaXqsgU+F5/1QKfm55gd0qHA8IklKKV
	L3LAottBrSMPokmtvz7c8MfS9jZ+gw26sUErSuFX2P8akw598dUBl5xxI5ifqramrgA/w7HcOAy
	hnFqZGlEVqDB/WVSlwqig9uSuTrY8bwrahtItiazUeteSoYzlk3JFXZBLIjrf7LIB7eHJU3dwHE
	j8xziQRuu4ww8drN/NbWeEBTBxLXk3J25d+RZFzUa9/66C/qm3yabiW14dvEsy/c2pxrlovxdUH
	nxdq3wwrTiTpggvq6CotU5/yyQqNNlqAxwxR7yf8479Sh/HG2GPyNwDWf2e9w/1KnOv0l93puCs
	sG/C0WWdr8qRNk4kDx1VgbQLruKx/9ywSQK/MYyG3zrsomjc9cwWL6Rvmd0e7ZGsHRCCzCqBhb1
	w==
X-Received: by 2002:a05:7300:6da2:b0:302:b44b:b64a with SMTP id 5a478bee46e88-304fb1a66fcmr2160397eec.1.1780201532584;
        Sat, 30 May 2026 21:25:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:aa7b:13a9:ea74:503])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b8fbbsm5483650eec.26.2026.05.30.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 21:25:31 -0700 (PDT)
Date: Sat, 30 May 2026 21:25:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
Message-ID: <ahu2oxLwkgMlwXu7@google.com>
References: <20260530155930.128183-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530155930.128183-1-jinmo44.yang@gmail.com>

Hi Jinmo,

On Sun, May 31, 2026 at 12:59:30AM +0900, Jinmo Yang wrote:
> wacom_wac_queue_flush() is called via the .raw_event callback
> (wacom_raw_event → wacom_wac_pen_serial_enforce → wacom_wac_queue_flush).
> For USB HID devices, this callback is invoked from hid_irq_in(), which
> is a URB completion handler running in atomic context. Using GFP_KERNEL
> in this path can sleep, leading to a "scheduling while atomic" bug.
> 
> Use GFP_ATOMIC instead. The existing code already handles allocation
> failure by skipping the fifo entry and continuing.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

If you want to give credit this should be "Reported-by: Sashiko-bot <...>".

> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b35..2e237bdd2 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
>  		unsigned int count;
>  		int err;
>  
> -		buf = kzalloc(size, GFP_KERNEL);
> +		buf = kzalloc(size, GFP_ATOMIC);
>  		if (!buf) {
>  			kfifo_skip(fifo);
>  			continue;

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

As a followup please consider changing 'buf' management to use cleanup
facilities:

		u8 *buf __free(kfree) = kzalloc(size, GFP_ATOMIC);
		if (!buf) {
			kfifo_skiip(fifo);
			continue;
		}
		...

Thanks.

-- 
Dmitry
