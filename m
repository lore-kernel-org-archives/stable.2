Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267053002B3
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529314; cv=pass; b=Rq/oXQAy2X3fDBZcDzDCY7MwxHos3owgVLbgHI5CovTGarEejtaErBXGrCT3W11P2VKBw453oG7nrx9m1JPbZrCDJEaNgsokcpRkdolsfu2V1kb34zHsLtti9Vm9yXFYNC+kEc9bIs7faHGJpQe/FQLqPAmfObmdGLcSrRHqovE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529314; c=relaxed/simple;
	bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIKT9hIakRWVuqlXrk1sAQcWBYkrN+dZNjTggeb67eIgjHk7LGVqmzsNjlwEV50FfWmA+tTjZ4TuB3Y2iz+HRIXA0CrPZFgG/jI6QkVFw9gI5kOdb6ZLjrdAAYtGUIwmgjYqciUV1yE1VfQPpXCl4rP5XU+52NH0pXsoyNHQ4wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0GEz4z1; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0GEz4z1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so57281cf.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529312; cv=none;
        d=google.com; s=arc-20260327;
        b=DKvkjS9lc1USIJ3Fjx7sbgW1lzvfrgrsCIgGryRgjjvM5t8/pJp/q7aXtsyBSXjvEI
         0+iEOXtXGTg+AjW265K/XJk086YXL/G0D3y3rnD0323oTy4ycdk6W1SD7D4bsvKMZI2+
         Kp57J7hSiDuagLdr8z6rHmAu6VgEKP1BDBP89/P/wvyt1OvUa+4E9CmxBGNRZEKhaE1y
         96i+LqcgjY3yuZSgTajMkuLgLtgFtIEez+VFTJS3fGeOO+Ngy/7ATTtZWhBtUuL0Ckki
         W5rTWfd5XCouLOmFkKfdwseZCNl7su11zTd+QXCpZzlZx+7YhwvEaCON6QdwVS0MhAaq
         0X1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        fh=Cy6mXIYGx1Wr32DA4Oi/zDxXnzfhv36zW83Y73kFmF4=;
        b=sd/zm57iEdyzscVa2reWQhNwDHg5eLkU+HNZao3HpSy//o8Nfnkm/OLHc5h3r43yhL
         lDayF9RUIXrWlJxgCjqEnlmvqhHz8DlqZ7ulK1C+HsZpgeYE0ALoap5ieJhRI88v09yk
         vEH4dDmpyqdQ8PCFMbAirGqJ9uo/gLJVSkBTFbvjmBOHz5r2yES6GUttWOTryfNSwwTm
         krlnrZaGsL7TV0cHlla796lAkIuSTK0rC/nVQzrknQ/jWfTX2GhUGAwXamxyuw/LaeA0
         nBLS5jtYX1O13CNwMVbgU6RkZu1YOf7ix6gUY2CfHgmUiXxQMrRXdN0790pgFKflYJIQ
         jRqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785529312; x=1786134112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        b=c0GEz4z1kPXm7Do2sKytw6jCHFKwknOQcgLIRBim2Ab43v+5lQjm0vBa8UWj6MQHgT
         q7dPbU5jZdJlMu0Xa4QFPyQG8sltTu5Me+UMW2q37vUsBqmJPw1uE3fni5M41+8kDvmT
         DhQ71mV3WbmRxfhS5piE0bPds6CGpLv3/JD18XFq6ulnklhDCMwb8LxflRmXTlVSNavJ
         LbVmJa3H6B+R3GBJPdR516b7HCbKxsBallOPYPNAfnZxY2rxLavjQ7lP6IACHGpO0T4F
         VbeiCZEJ/mwPtBWfU+1I78CNW6TkUUZLq1ze32fAfMfN5CwzvlRzjCJQTKNE/Ilvb2DO
         SGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529312; x=1786134112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        b=c+ZZzaJHKpQo1ppG7sbaRkEEMV0a5mc5ZyAPVEyxxCVY8S72F69HbeVDaaolsulMUI
         i9S/SP0Tm8VRlEvE81wfzvK7Kh/LTB0DHXIA3hfDcJSKyayWxAFdteGLSgqLdXZI3CHr
         6DFLYqYC9BJqnpSqGyhwWk761eMWI3bAR2TPt/focvsRZX7zRXWVQmTq6UtRwGvrWwnk
         gQTNRKvU8NyA9MTm+9itL3hKT3ms5tBkViuMt9NIYpdFmRRrGSP51VHn+gPbo8e7dXDf
         sALP+K0pyPPHw3XDKDQVCXYKrbTeQotH/j+k0ROW5y2ffaCQuM3ZajmJXDAMT5JAdGIZ
         DVqA==
X-Forwarded-Encrypted: i=1; AHgh+RoRjndgjO3HiW1EfMjmqRI3fMlaI3iVmZevC0oEP8bPPgq4jv4UJgglGXZTz9KmMDS3Pyucg4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDQG2vEucHlqFCDipdm80UtL/s2D5Z7UEUaizdb0ajeFoGJTd
	ev4DhS+PgwBHaUr31uBF8x5kTJl42X/rF2xLbgv9Ilvrnvsb+eiLY2dVkEdb1dbaQRn5bW0aM72
	l+LWWX1eRdS7+6cK7gUnZqNhTyR7RR6HyOUhNNPqa
X-Gm-Gg: AR+sD11teIWelAcLHcUqb2ttQWTXtg1ozR/lgHBe85zza6MVQhaKGAwpOmRuW8G0mJO
	GRcuS0AaNvOyy2ThY8PbySEMaUproz+wbhIOC/MczthBIUM24ZtJTwgmxa5sJ2Hw3PKtVxpNhMz
	k0JSKm3vx5v170cB9qRkcMxYfDPVc3tD963JG5PDVNRjdJOoCv95LDoHNiyJd6GHkP5jsjCQjDA
	poGiqaOpCHehlMGT3C8EfvmhDDaAZPyC2x/krUx/lmukHzbjpxFch3IUZEPeqabXVG9RkYxKWTb
	1M6hoe16AbZf5Z4Y3ZPDP4OiElq6Jx9Ml573SfpdVQqAGEuFfxtUryUrV2R0CqP1seMVaL7DAUs
	=
X-Received: by 2002:a05:622a:1823:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-52b5b0e51demr641901cf.9.1785529311540; Fri, 31 Jul 2026
 13:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721005603.1710551-1-linkl@google.com> <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com> <20260723051327-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260723051327-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Fri, 31 Jul 2026 13:21:40 -0700
X-Gm-Features: AUfX_mxNBDgDMslJcUjNED66vC66b1XZjumXM0ISgNPSYjId3DELRHMAgLjGE7s
Message-ID: <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> I suspect rest of work items we have, e.g. update_balloon_stats_work/upda=
te_balloon_size_work
> all have issues around freeze/restore and error handling.
>
> --
> MST
>

Hi Michael,

We have indeed discovered a kernel crash in update_balloon_stats_work
after the balloon driver failed to resume and initialize in our
production fleet.

Alex Wilkins <ahwilkins@google.com> diagnosed, root caused, and
reported this vulnerability. I am currently drafting and testing a
2-patch series to gracefully unregister callbacks and cancel work
items on resume failure so that the VM continues running without the
balloon driver instead of crashing with a kernel panic.

I wanted to follow up and let you know that we are actively working on
this. I will send out the patches to the list as soon as they are
sufficiently tested.

Best,
Link
