Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C030E0D5
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515420; cv=none; b=pt58urGodHI02NTL5qgVb2YUwJpc6V8Ow43iBFrNJVB9mPDkC0nKtZ1IDlt9Zz+1c5ZIPnSdbYtWsQsCmhUx1/GeMFQ0UQnpRYP2+bKUvhLDTr8KOGq5dImJS2XvU7tHbu/2o/UYH6ToLKKqsXc9879lMQdySIvHDFNSFEffUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515420; c=relaxed/simple;
	bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ELRbEjbbEse31Ohq0RwLPhR4mYXBVj2Lj1NFVFfDBMpb1VuZhuZZm/zgyAA5cEG4MLuStd2XKoYsV7EuAXcJZ+r1nXIhpplsyJOjIS4PNk9/Cn8QELlfi0/tCk73MzipfYLYs75vxsiQvEmRH37T544Yd+D+hq1y0JdlInw9Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Cxqhkk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Cxqhkk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d032846c95so33277605ad.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515419; x=1788120219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
        b=P0CxqhkkUmBy/qbfPRQCpp6znjKZzmlDnhIWBRU4eDB2MeuHpPHcP/baT59FFc4pLy
         4RhjMIgP2RnVRXgtL2RWG4T1p+OBzNiO25QmGzymTxXNwXUeEsayet5ZzD8z4e5vLZTR
         o57O92Mwi4RO9xqOIGsvfIkxgAs8gd3rU14bYdAjdu1TClamlj26U4sFajCEcouEriom
         zCxheQ9WumVSYe0d1/waG/BS57L5cib47CWGZ97qxe1LBxCTJfaaA2IX1ele+sSp42zr
         JmZTCtDOliDTJPkf4F7LIRbQNl3ugObYjDbOB9GLInSAHd6lYxdughFuxgGWIv66JDYM
         cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515419; x=1788120219;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
        b=UhbLZClpEK1WmJj9exKye80qWXt6PjIDWGPPElCmW3vqLuxy40iLftvqXnDLu5wUA4
         lJsHirX2NoEyjjs5e39bn3F6Mk4c2WZaI5zJxIN8aeGoVLCeehgi8iplT7E0RNVY1vSR
         L6V9eBelkdi2QR5J9tNaiPWWVhWzbaso4VYgavPyhqGdSxSXJGZ9Rj53OWTtOKwfn++G
         B2nglcxHgAlBidBMxuos8FcHoez7vKWy1uyHd/Z5GTKMX+624popofj4W+JzJSggjti3
         l21yfcLiPoyt1ROJ7yJkyTgkiHF8+sCfMyOh+fQA4ET8B2S8etGL3r0Hj/vYyaCejuRn
         hRGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmA6isdLn2I0QotdYzXh5JjNg/c0Zzb3zbqsXjYkz/ygejG5PJ6X4E/A9euyY2JRpIpN2N8AI=@vger.kernel.org
X-Gm-Message-State: AFuF++kgeQBLK5oC9uhlTo19xgHjmP9Apc5NUrNRhJxCTfGeiK8dA5bI
	yT8ZxmcMXPqJ0Mic+zy4PaYyH3Y6ML/xQjyQHgHJQXaPuqzOE0xsGCdP
X-Gm-Gg: AR+sD11n2gBPRkXuV4eQrxM1QigiaTCNxgRfqMIydTl/SRC0StiqWRIpruxAd9ys8rK
	rdR32dfRYlHPWgAIVJRLeC/E2kR4cCF6Wff9MwP25wvg1T6BKDgFfp1J3HH3R1TwEDC3G5tVb0G
	6/BAfkis4NlY/qN1mGJYWccAF2nuaKWe0ehJOMlTSsah5urO14v4s3l/v0dXjCOEpJg0G/brSt9
	6NpFD1WxwTcDToXjf9JlDkwYZxB+CC+JZa/0diOcNEJSwvD5uq9gTfLbq7cW59Ue8/ShoXN8DhX
	Hg8tmB/AY1OztGtvqGbyzcGivEut5wcKldC8f6Me7BDWby6dXmXCuupBaOBgz2+P0CMAgBcH5dK
	Ts28wjRJfthJlSbsvD1CKAKDaUSIAjtZ/1P6kYhLL3iGoOmTlOCPyFV/wVHEww7cawLRke7sLeS
	4UzNr3sX56QC8xfS1cjvOxjjqkhD3CDL1c5oaYJ79mS7d1Pq+3yfeYFHSrlSTQpn4W7jL97+3DF
	fuEYejVa/KuX572ISO33ZNL8rFnVtkrCVRlWwsMU4g62Of+lbNS4iMumW4=
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d64afa4e37mr413363595ad.6.1787515418856;
        Sun, 23 Aug 2026 13:03:38 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280d116cb1sm7851302eec.10.2026.08.23.13.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 13:03:38 -0700 (PDT)
Date: Sun, 23 Aug 2026 13:03:35 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
User-Agent: Thunderbird for Android
In-Reply-To: <aotPsVYWXXt-X3mN@pve>
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc> <anJGWjlmRxNMoVLG@pve> <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com> <anK_oQqFpZLwCA-a@google.com> <anLtyBB-Vq2D6REw@pve> <aotPsVYWXXt-X3mN@pve>
Message-ID: <3C5BB154-A1A9-47DA-876F-635569AEF6C9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 23, 2026 12:53:21 PM PDT, Shengzhuo Wei <me@cherr=2Ecc> wrote:
>Hi Derek, Dmitry,
>
>Friendly ping on the question above -- is there a version of this fix
>you'd like from me? (A minimal v3 reverting to
>cancel_delayed_work_sync() and dropping v2's probe change, or should I
>leave the whole thing to Derek?)
>
>Happy to go either way, I just didn't want the thread to go stale=2E
>

Hi Shengzhuo,

I have some other priorities currently, so it would be best to have some p=
rogress on fixing the outstanding issues=2E A minimal v3 would be great, an=
d will also ensure you get the deserved credit for the change=2E

Thanks,
Derek=20

>Thanks,
>Shengzhuo

