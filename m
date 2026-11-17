Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924219;
	b=BpiiMT/StdWT+j2i8wh3ShJtcz6qUwOr6EpkaHJEsHULzYHMc2Z2D6RAEfrslt7kHjaf
	 /Wd97xrKJbtOa6WWdpwTEyoucDmi8kLEJFMy/lpGIq45FcW0je+E4Hie0OuycG3NHwsXx
	 muUODWTMTX9381eiS634F95bdwDwFOZoYVGVM3s7I4bxmzG+hCR7IBMtD7UqPxhH8w6zs
	 2iL82JxKLl3G+h0vhaaJkyNBEKWfOq/DC5TckDhc31gUfdB6d9CBnvmlkAYqm7bWJQ2Ua
	 wvlf90xfbeK0qexrEYY7CIjZq4PVmw/8LqcsR5GDCuWP1E9vRdY/9gwhiTCWUVjbS6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=alFbhvhmLX/J2fLZw0YpZ2rT70ZCayDvSm7eBC/5SBs=;
	b=uxE6mBpmqSRUzoIQnDtnEa5LlUNi/z5RFCOtjkzQUzPsZ9hDf7huIYPzjMhOZFlv3v9C
	 28bwdrx4FUyI1Tz15aAiLSUrfyo551inTrnIktpswL/JlIj5HKwsHs5HRYoknjpq7E47E
	 xmOz0/MavHJzc22mc1u6o3pTAExJWE9LADbwSsWksjpB9AeiBm49J/3QGnPZUMKpvt5m0
	 McHDI+nOQ4Tlxt8f2nlxc1Fqvs5SXQgUX5Yzu48naIRW/8MrYtmsRul83KhM2VGKA59DG
	 YvaxgABtLKLLFK8QXcxETCMCpwheZ4Qfgk7b6G4ampzscsHv4tCvFueyKNA1OpYzcAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=rAazOPve;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04684606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04684606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=rAazOPve
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5430f70c827so63305211cf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:03:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794924218; cv=none;
        d=google.com; s=arc-20260327;
        b=ZFM1LKmo20Vx3HmkVRit8lImPoeiOuceFSfM42jBT8sqeXY3FxSpD+sd+GWYMTLlIk
         XN8CiX5Q6dpMeuep73lCjy77pClLnFu3MCH7NNPVtzkJjGMeERyWj99u+pOnnisc5Jux
         YFqP9uRCmEaBLFJpjyEU4RQq/cSrWJ5iRytQ7V5MYUpUZ7GQ8X5lCdw4G4xDnsG2i0Wu
         NuDpxlBfxmc5WK55tEGjPIqViXODdQZ534AJWZVd39YpSVAoOT4Yhw7lGn6r2nYws5zy
         t2vUaOJIziwSiGIQSYjAa7E+ggvPdXp7JSmkyfbH1uwSlYxY0gqneLBTXETa/9/MOdb0
         IqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=alFbhvhmLX/J2fLZw0YpZ2rT70ZCayDvSm7eBC/5SBs=;
        fh=6rqH6B6Pg79Y3pXaH4Bq7FkWRZmKMjVVJveWf3i8/rI=;
        b=M1WIK2h3GeVc6w7UDlqtShTMZXsXVZ8zB9418QM6dm2f/FThd8dh28q0W+QZGlk33X
         ChsvvpL/TCkSfvEyArpzOGrz2lTJmhT6qAKEUM7N7HvbvSjFD/ShD8E9jfEUwDppWbY9
         koNm0+QfDFiImdd/zytIF3YxwXVnQnummYVMims9KK1jnmq1dmLsA/LIUVOO1RFD7FvD
         jM1zKx6mfeUWCKrqpWgfauCLeRB4ezbnYA5Dix+d/KfnryI9UPH69KTZ+jaX4ZzBX1CV
         BdXuQLk++giJt+2pLcaLn+1jm4TamrusJpZs5RrO7WO4pGVgl1fXPQ1lie8Y7HYXyiaW
         gW1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794924218; x=1795529018; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alFbhvhmLX/J2fLZw0YpZ2rT70ZCayDvSm7eBC/5SBs=;
        b=rAazOPveQZBeHP7/PYw4cGVuGw/93Af91SiR8gE29Oyag17JAwG5+zyIwcDHwgv7c5
         MQfGdzJdI40chKAxdlzV1wb6vkgBzsrCiIh3zFteiBbL8A1SKzbeCaTlmXGZ9+qPfdjj
         ArZCGgbNAkpsnhMIgf7Wi7Xc9XKZx8xniLRy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924218; x=1795529018;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=alFbhvhmLX/J2fLZw0YpZ2rT70ZCayDvSm7eBC/5SBs=;
        b=CltwmLn06JaiM2qhkBLvJExQq1sXYqOXkACMTjHck8kgg+7/msgH52ad//kdgDYDcj
         sSK5VNekwvSPBJZGvbESa6ZTf3XsW0XiFghh9vGZoTpfcXN7rY6+98WglgXyBz2asS9V
         QGxLIEfbIWUqjvio/l+tV3IdNS0+akxr5xeUwVD9E7391sx1YaCduAa/TZ3BF2Mjz+4o
         RIw/gsJrUr3tcuudKQiZHycr/rOQ6A+b7Bj890UUmCDCrMLoiw46YeAQPmQy1NTZsR0+
         6mhIWDAQBp9UxU2O3XQ/2ZebDahYS2PxdkY/7vAmMUqYlencgTEJap1V4SLpGJqSh2SL
         kSWg==
X-Forwarded-Encrypted: i=1; AL+hErEvt+v4ZklBA2RC0KMjjfyZzgFc36DgoJSXeSM776XWw8VKDRE4ITzEMmcitiNPdWhZwfTed70=@vger.kernel.org
X-Gm-Message-State: APuU4Z82+m5G7Nv3AK7maM1fvDKDROhTIWan3qcK1MdthKhLOk2hxDL7
	pUwAaG0gBNzRxvZV8+3ltetrnvPKZw3xW0VBHPevaX7rokx1rcXLe/cqVHf7AhSF0qM//tUiWxI
	KASm3w+skA4yLlQppQGTFBPDsXsVgTxGGjZk3TW0EZw==
X-Gm-Gg: AYBFou1WJNTcDM3X2CPHuSOpJeERwmNf4R+H4ohZTTYMSngCmDXvKjfQwbg9WgbnyOf
	lRpNKTHX3PP6ZFEqWByCTMtXH8O/RYbiM6STMT4dX2DV0ObVt8sswutphgYHLHHmKjSnTIKpQfd
	0zV/lEwZvlMhzkycjU5kxMhmYFPtJiNTMWUkBlLRYaAv+ANBP8MOTb3Ee+9mNGnNXdcPAWBfec7
	sVBmuttA/w0sV8h5PIFLW5ZaNY1Tx8XLW/WShSxJiJW+ceWND8aomhnsiKSfZtSE3LR2593F2ZY
	Tb3wIj/kHBPXMwat1RJfqe4GRYOwqP0BIl6UPsnlOECvePzSwH/gclDmH2qPNLrK7e1IjFrBgZt
	ItJcaiBPB4NiSathMukBZ0a7DXMw4BrZCzAGc3/gFIKwj8gXkfEBue2zzAXi1fR1MEl+B3ffDdZ
	bN8p63qYfHwac=
X-Received: by 2002:ac8:5ad3:0:b0:535:2047:6363 with SMTP id
 d75a77b69052e-55ac448c12dmr221360331cf.6.1794924217487; Tue, 17 Nov 2026
 06:03:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110150250.71520-1-ekffu200098@gmail.com>
In-Reply-To: <20261110150250.71520-1-ekffu200098@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Nov 2026 15:03:26 +0100
X-Gm-Features: AclHuK-p32xS9Ymw_ghXNjlBRtB_UAl6rx4OxdJZvic7C_w4sxAcHG3mT5pB1sc
Message-ID: <CAJfpeguXcXTPpYshszCDM=Va7Rx5VZiMStFbSi66R1NjB566+w@mail.gmail.com>
Subject: Re: [PATCH] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 16:02, Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>
> inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
>
> But inval_wq_set() can be called at boot or module load before
> fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
> warns and the work never starts.
>
> So defer scheduling the work until fuse_dentry_tree_init() sets it up.

Please add locking as sashiko's suggested.

Thanks,
Miklos
