Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4F36C0CD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132198; cv=pass; b=iVw3+QQEy4YatOZgfcMRsBdjbOR5+WjyKgpgZZkY/3mEh74fV8zAy0Xx8yM26XJCA3kFDPdnhPygCRPIQAKrnTRjm420/1+ulrpa+5XU1yYKOeWZahSBDxy8ShkRqHBEqredsaEOXwOKS3ov7ou0dsUYA11hdKD9przCCFsB3RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132198; c=relaxed/simple;
	bh=VKMWcXMVP7UvVkz7QMUJ2T15eWcXIS/K48F8fvZe+IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMKdkuCcyEWUYTEkxuYEfQH/W3G8QmoboIhiD5mBaUyZZbDC5S2sPHOlKkELosBLJFMCw2GQKlOd/fk4Iy72bQ3/7PpuHuyJ8mm28nKds8vrepNeOjqRL5g3no5V10QuSwSxdRmc6KW+2g30HVx9D8NP7/l5LuO6R+y8uNExKNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lULXP3Ki; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lULXP3Ki"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso4037359e87.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 12:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786132192; cv=none;
        d=google.com; s=arc-20260327;
        b=RacGbwEXiBHm9NF6zM75oxqk78Ii7Wy2/7qLSLfPCCrHCRNpWNvLIb4kVG5swBa96P
         yhi0Z/yU1rf8hGXmZw1bihcRDqpMsR7jAwVb3dWdB2QPT8elmER4IezShk//EGkU6qo8
         Mzl5nAtyZGeqc0IdwS+g8HfNwDELmYBqexzBGrSN02SHcGRAZw0QmUW2+waB3Sn8iE3U
         betBRx48wvkejnJGNPnrmjRuj6KtIJg+pR+s6qXXjUitnDoggOWCNEq+TYzU8keR2YDX
         iL0cTRIqZNtsB0YgwXCRzE/TIG+NsZKTwhoNl/AftN3suGt5Shm/TVaK6xwnWU6gv+Up
         Y3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SxyKUAmrI0LwYfrXT8fRXwyn/HyoaEU+MOGavpvLNWE=;
        fh=Nhqx5ta1GBmK0aXMxL+vYZDDXF1T/ZpOt7mA1spROps=;
        b=FCk5B7JEzCF4M/r//9Kn5Jk+oXm31Wnec9CGsYUQ8WTPsw4aWP3WkucSM+n1D6932Y
         HByJh8SRnF5dK8RPRjy1UBVN/p6Wf06BRX198I8Rkv+U+HlLfURMHVlZOiK20iq8lBZn
         I/m2OaHBo4uCizVyHqVgzp8T+r+dFEHAKwk9kT8c18fDKYiwwMB+i0cJhJCnHsonef/v
         R+1Q4lCMob1yulJaE7WFigDiLRfotjK8HRx9SkZh/iVSZiXRjGP+9iv/QbOr23kb/kWr
         yIB9uo8VCocHb6sqZCuUofSCGCxBl+rnJ1L/eLUwSisGC4hEtizk7W7+tOnWKURpzsbf
         3rvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786132192; x=1786736992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxyKUAmrI0LwYfrXT8fRXwyn/HyoaEU+MOGavpvLNWE=;
        b=lULXP3Ki1idUu+/iFZj8OMV+hV2dQlCvoOa7t42xuD6zUz2XEse/CwVbmD+Vr3s027
         IhvkDtkIOoNyIfkI8Wzo7msLCjWh+U6mK20vSVyPeLY7qJsUdv9FYmhmoyD4JwmXhoqp
         dThggtbFZ0M5Aqanx9GmfXYwNLaFO3JgRJD0/WA3D2a+p7waCC3/mS78jqttH4Uy744C
         qEJwsvg8M8D4BFv6wkdN5J6qYIREMoNx+AvzuxwceBF/jYRq5YyEAFb03cmXF3Oo0MNf
         xnD3bcA3bqTBDGvcgUFa+279dKJm/YOn2ILq/z63YyxtTNamgbgSyghG5V8/82pO53A+
         I7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132192; x=1786736992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SxyKUAmrI0LwYfrXT8fRXwyn/HyoaEU+MOGavpvLNWE=;
        b=pg16nt5GQM6DxGVxKfmxCVhXl+Opva9UZcAHPvsLHYXXtjlwK+RLNxHZf8dZRYXN3d
         ecFoW5FQIua4RFVHb+32RWKXlTk+mPwvqnej+2oRmkv+wXdvYj9QMW2nrzydIX3ODO9j
         hb0Y3efPg88Yns69jcQNhLOTjA+ok2Xasppu0KUSQMeVCgF4ZBCAFD2qV08/zxkI2nag
         XK6Dh2TjxMUtJuyDPnXc+GIEMQkEGrSIyo6pR2Vhi85Y7a7uNh7KZPIFsGVfHqeQM5oR
         n9jICK04b7EQ7x4eslJkQ5sFqqkcC4xbRO8F9fKHX+QqEYetTLNglWRAIzUv5mkuksAz
         Pt9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rox04dGm+ag1va+G9aaM7lH7tfR8G3LACPJSh13aml3ePc7e7aliYPbomJIgpifp/Y2qmyYcEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyaulHfaFlgv9AtChFFLi3xYgqigbIUynmrW066N0V42NG1ks
	ybYnyt1dBKsKiYJx3bxe7JRpVSRzfU/w6KQGXYtLlyY7SK5VnW6TdfIjuvCkLssFU+QFXpEOB/m
	voRS0dopkc68wNp7v+gGOkuYuzGSdPJ4=
X-Gm-Gg: AR+sD12ZF5GkECzKpNdZ8tjrD/GNWiaLx3hfPe4ZtMzQy+TDtQ1Tm83yF9PR3Jbhsyk
	fEc7QawmUlUhkYHPeitZWhxPYKXjGx8ZtD7xNeRpb1rgf24CUu6hIYe5nYVIO18AC2FjR7XLAFC
	6S2in4iRoqJNqIxrMPrHsyH0ruEvVkqZj5xvwV0wdnywgXWH/Ozz77nKDDkLhUmfPTonbrQU3lb
	L3emAGKv5srCqOcAMigYI8g5/6yiqvMutAiC63YG3EkwwDQMnMMSXHSR6QOi8kI7UqfHWvryAUF
	zvbKaRXzpAWfPC7FcR6ZZZyKTq6v5P+u9KgBz/UoAoR99ZOy2HbhmGvtiwB8riv1vQqJ+VpPQBB
	++8mI/rRbwVoYdnezMejj2qofpw==
X-Received: by 2002:a05:6512:3c92:b0:5ae:d80f:c77c with SMTP id
 2adb3069b0e04-5b2f4cc45ffmr3489843e87.30.1786132192296; Fri, 07 Aug 2026
 12:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <anWWr80yAcOQaVVS@nxpwireless-Inspiron-14-Plus-7440>
 <20260807182124.41572-1-gvalkov@gmail.com> <9cf8e6ee9c4c655e685708bc5660429074b18326.camel@sipsolutions.net>
In-Reply-To: <9cf8e6ee9c4c655e685708bc5660429074b18326.camel@sipsolutions.net>
From: George Valkov <gvalkov@gmail.com>
Date: Fri, 7 Aug 2026 22:49:40 +0300
X-Gm-Features: AUfX_mxRBT9-U8Aa_GHxuMmHTk-qUbjASbhV_06GViPmHzIDoVy768Olpa7FjGk
Message-ID: <CADOrJmbhdWhqRj_TSKYEgb_TrbJUpkQeYTGDb_93WSDdeaJPpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] wifi: mwifiex: ignore ROM regulatory hint on WRT3200ACM/WRT32x
To: Johannes Berg <johannes@sipsolutions.net>, sashiko-bot@kernel.org
Cc: briannorris@chromium.org, andrew@lunn.ch, chunfan.chen@gmail.com, 
	francesco@dolcini.it, kees@kernel.org, miriam.rachel.korenblit@intel.com, 
	wenst@chromium.org, rafael.beims@toradex.com, avraham.stern@intel.com, 
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Johannes, and thank you for your quick reply!

> You're supposed to always update bindings first, no?
To me the logical order is to implement the feature in the driver and
then enable it in each board which needs it. For Linux just WRT3200ACM.
A separate patch for WRT32x should be sent to OpenWrt.

Please let me know if I should reverse the order.


Hello Sashiko AI,
Yes, I intentionally implemented the flag as a root node.
This way the new device-tree property can be reused for the
other radios, which use mwlwifi, and also require this fix.

It would be inefficient and impractical to define a separate
device-tree property for each radio, where it is actually the
board that is affected, so it should be a per-board setting.

Also my attempts to use per device nodes or the parent always
return false so they are not usable.

I do not understand the part about dependence on CONFIG_OF.
of_property_read_bool() returns false when the flag is not
defined. This preserves the original behaviour as if it is
set to false, so the feature is disabled.
External radios which do not implement support for this flag
are not affected.

v2 of this PR used of_machine_is_compatible, but there was an
objection that this adds platform code to the driver.

How can I add binding documentation and where?

On Fri, 7 Aug 2026 at 21:39, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2026-08-07 at 21:21 +0300, Georgi Valkov wrote:
> >
> > +                             /* Allow platforms to ignore an incorrect
> > +                              * regulatory hint from ROM, so userspace
> > +                              * can set the correct regulatory domain.
> > +                              */
> >                               if (country_code &&
> > +                                 !of_property_read_bool(of_root,
> > +                                                        "marvell,ignore-regulatory-hint") &&
> >                                   regulatory_hint(wiphy, country_code))
>
> You're supposed to always update bindings first, no?
>
> johannes
