Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58F3AE718
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869215; cv=pass; b=hxTH8M74Ev8Sg89i3fQ1A4JKvTGmUgOcA5prX4QRNInE/RcOY2OhjuiZW79JwFtuXxDu1UJ889z1TLud9ZBwXonPwQIMyHUnzHqnckVQ+NaU8k4ftpR5a9jXHv4htRUwbgTWETw2qUgb5j/7rBW0CM76WUiXZjLD/XQiTeIoOHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869215; c=relaxed/simple;
	bh=Rt5kCYTovKo79P8T5a1y2BU7GEOnV/NaT7+bvWuL78c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abfOgBh9JiXFALIzzt0sfbp49jKi1OjrcMwenpIDU6cDSSMTVCnOcRChrhZLXgphav3tqAuzefNMUu6v+NkcZiveqDP2rxrwRpOZa+8nde+/z45dDk1qX+MO3jbOY53kLt/kFOIgmaASMv2FkRTMqs6B6R2Bo0iXNaSOC8Z7zu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UEqRGMCS; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEqRGMCS"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so30569295ad.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790869214; cv=none;
        d=google.com; s=arc-20260327;
        b=IOLVsn2zADFzVxLMjcXMHT/3CTM4bblSPwHjNZEyyS2younq3mmhIzgoZqEFc8JvFJ
         l7QbkPLgAiJvWMQhpMHn5Z+hO83oC1OsEagU2h/bhokbdmW87j4xzuKI3tdZ3906nxkF
         OTw5GWKIxtr+LSFLGklq/sARdTJVlDyXL7QE86GztaZN/hDjP/NVjVD2wV/8Es2zdtzf
         KzuEQL5Svt8BGsxQs4dHRGLuqkR0pt6EP/x8XKIstWvsvuJii6kSyyZTZGbSMKN8jNNK
         EyfjruOvx5r7OwCLLG8hfZ6yQWhc+yjddAKN27DP7B9SInBpzoNkf4RjxrAM+wtIpK2W
         Fh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sH7suoulEGbXb6HUyxR66b9Kl139W81dotKBuuxFi4g=;
        fh=UIexztALzuDfkrz5+zplmFrEPTYgUQCWaL5FdZUWpPM=;
        b=bweBj64YH2t5Hmh/BcRxaevJXEGOej6otq9OLPFCxB/tKSxeg+98/eE3be4CBdD/jH
         7qp8Px1ZcAtvDRKAOOGi4fXBk++swDJ3exswu8jSGlUVMtPTcTxoNqO12W4znHdz4z1P
         7p6hd1DHFpSkHeyXTr+C/HEuK3dy2pUIyQioOQ2b4XvoB9EdfeKBuezj0OHSylqXYwpp
         e8bTVj4kYBNK7V8uqlSrlZyuVnaqeE3ZOFhTM9Ctr2b7N3p4mSP1u4mJ0IxeJtAM8iJM
         wEbrnUsZf2gpfsihTvpiyJ4dubivtTxdqsbd6BhluS8O3DO5kduLVRPatia+YD9BvdQ7
         WvKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790869214; x=1791474014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sH7suoulEGbXb6HUyxR66b9Kl139W81dotKBuuxFi4g=;
        b=UEqRGMCS5AsPC7sL+2qEmCipuV+jRPfhMrdS5BLxrRjr/GNLH5IUNO+kj9BblAf3iJ
         PBeK8KCcuLYo+25shkMuH6zBn2GSOLHOkUem/Wz+zQXGnbu0fCiouhmv0TnJ1ggD92Wn
         qThrBpoLn/CwPetyKpz/O4TOFHR0bstECNbGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869214; x=1791474014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sH7suoulEGbXb6HUyxR66b9Kl139W81dotKBuuxFi4g=;
        b=2RVs/olgCMXL9swLbQAcyDHtUZu4cbwGtAXroHCj89dGsO0F+Qb17oUsd+3ruJP1aF
         z76QQD4uNKhq0vB/ullut7V6gJGSlfDH4jZQfPm8NLHTVOi0iQ7dh7INSneYLSKdL+mm
         8sgDCc/eD4iGoGFtY+YT2LGf0LmP76OeiLUloE8nAok1IdQejwCSl/yTeytuqkAIWehH
         3ciRarmQf9UZD/A82bwn7HBrvyH2p1FIaOkfgahQpmyLgOqW/pKE4xWzE6A/PrEsobIH
         t4uZiXTZ3wprJo7Qg0ZMjaF/hHiFRqhzru9kAeEO+DeS2Q+kpD7ZnqPhmLFSBNpfC4kB
         3TJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpaY9ZoN2M2ZpbjafvgdEJWtVQtBQokuqNksm5GIHoDvVXrsRnx8X15KqKdrC/W3Xu1ZyZuNE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6aGFTPoXKkeDCPkPxBEYi9aJ+Sfp6GFtLtq9HuMB/VZRL4CPe
	9DmkDdWly43jd5cSRCqiU+vfkCyvZaCp+YX4ZkrRHo2I3JWuLuxr78aQCiTWw44QbfVehRzuXV8
	MPcE9z2TO1GVZxrUg2ULNjmtBPhRwLu8GrBFgt25N
X-Gm-Gg: AYBFou1zQtG5oFFbeTUVE6aOzPterI8jfco58w9uNvE/sSXB1bMHbiVTFUMd7OdT98Q
	mgAY7S8DS2QOqEvAWM4SAaft1bt603VUdNB8i8ntlBpIBTT/Sneol5Mvh5TrYejDMXdoKn1x40q
	9ctz+Wuq13nuJWFZTYqjDhtLk0tiqhWo2xO51Mnv7Eg25eYygv0pabhTtlpZcL/+2k1WhtbmeRK
	0QXNrtQ5KS2XpsrxZYiwvym4/i/mSS/gMWnEHsHuHeWPo+2HEp8rTCk/XqsazXfoHHkv5dEt0qH
	+QGrvAukQ1V8UutiMqxW3uK1pZVBzWptVg7AdVUCaVYrcZMPZX3AURAQIMclCVZPX187lef9dpm
	OtK4s5ns=
X-Received: by 2002:a17:903:19cd:b0:2e2:b00f:564f with SMTP id
 d9443c01a7336-2e2e4a20259mr42758525ad.18.1790869213794; Thu, 01 Oct 2026
 08:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917204209.97699-1-mhun512@gmail.com> <arpa-Ps8l8LOwbbx@tzungbi-laptop>
In-Reply-To: <arpa-Ps8l8LOwbbx@tzungbi-laptop>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 1 Oct 2026 15:40:02 +0000
X-Gm-Features: AclHuK-ph787-_ubenGMoiVVddecDSrjn5jG0cc2n9OWoEqyfW5NTQ54A1U_4YQ
Message-ID: <CAMMMRMe7g7yj1iOTOc+TCWe=+1cjFA1rG7H=VfjnrY3p7XCKFg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Stop altmode work before
 unregistering ports
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:18=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Thu, Sep 17, 2026 at 04:42:09PM -0400, Myeonghun Pak wrote:
> > partner altmodes. Disabling also prevents a partner callback from
> > requeueing the work while its driver is being removed. Use the common
>
> Would the work be scheduled even if the driver is about to remove()?
>
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index 50a68819ceb7bbfbd888ca919d678d4c75237c26..e91bbc219c077067294935d=
d5602c1aec636cfa6 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -378,6 +378,7 @@ static void cros_unregister_ports(struct cros_typec=
_data *typec)
> >               if (!typec->ports[i])
> >                       continue;
> >
> > +             cros_typec_altmodes_stop(typec->ports[i]);
>
> Shouldn't this be called in cros_typec_unregister_port_altmodes()?

This should be called in the very beginning of cros_typec_remove_partner(),
or even in cros_typec_unregister_altmodes(). The idea is to stop the queue
when the partner no longer exists.
Partner disconnection rather than port teardown ought to trigger this.

Thanks,
Andrei
