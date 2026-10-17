Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047602AD0C
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792218629; cv=pass; b=ZDH0qbH7nUYPAAh1GTTj0SDlpmQk1+olRj3dIuTZyggZbgyJLussX/8NWepPqM1VIfga+8a5kXOj+vY0+rTgUorDJOBx35fr9c0gvGAbPTWcRurS6ubths4eldiz3RLx3ag8jprO2ubqMAXyMJd2f+1R0Dfg3eHzM70zoXDZpKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792218629; c=relaxed/simple;
	bh=RdwkPyJhh9E98r1MpaOcpYc/Nwt3X8Omeo42Fd0x3w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbFdO2rl3GglSizcrVk9dNfpFH9ZIDQNoAMLNbEwtr5znVP112RGrnjf+j3YrkDmtP//kypJHY7qJc7qCy8+Wxb9jUsmX4KwoJz6ygU9UCV1FMAxCqTBXEvXrciU7j4WoJzby3reM0Pswm9LuuAhdqx64EPrO5VCLSJtipfkZS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6Ao+T+H; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Ao+T+H"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b89c6caffso4361256d6.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 23:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792218627; cv=none;
        d=google.com; s=arc-20260327;
        b=fp1godm8zhBoeqOX/eXCJAr0xDw1gK8NrH3msh6aBukF+8gd+/wnmgIB1l69+D/c+z
         JkrXzP5NIFiGaf3MOP1GuG8m4+ZiyzZWxAXXVZKOYqApbEDo48B0/7gr2P3RMAa7zmM+
         bsclwi1E6YDPQtXoR4TpqTezvcPqB5D40ZdEA1Qf+ZrmhNUV0eEWYJAHQvPSPTzLy2QU
         mgkxqNxByGeDYEyNJ+qmyxKIDnWm+YemlNbRq+cITJ+tCHkcevGU+bQ+0qndhZbgJlXf
         ocO8VO99Hl1SBySovShjGoNqmDEpEDhIfyNBzKfneXPGYhkDCktDHVoR1GPYrmZFKMT+
         AKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
        fh=bQPw1kPss5rGiQWQGfBLJNJoeweWaFmo/7s3ExnOvDQ=;
        b=bxCYRxlm6iq+GXIG4tRUkN8QaLmfv+1Nxu/asMCz3bJxrc0luquLUf1vCFb36+NoL/
         20x+1k7fzewH6NBplyh9Lx/snNOPbR9Bi7U59waaA2A5Q+cMNfpQ6myPult/PAv8dPME
         m4sCk2XC/CdzrvbFmSMXntxdsw3umEzq7NOjchY9ptMpCCEGtuHqUilvUGkLCKig/Id0
         nKexEFDwyzJJy1OGI5gjJEAADhC7pwmD4cwSW0ereWM/GdSghud0D2RQ/ETabjrxAMvK
         NLJgU+RGN5kZK1CAPnkkhLKsuzMlIXa6sdc1OtP4wg0TvrUg4kurDg7UPAW3tUrCR5RN
         tikw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792218627; x=1792823427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
        b=q6Ao+T+HQUDaazuA5UYlqkK2Wum75oOv2z+RsR6W/879wNJfq2FUkV+j/lkFicFEW/
         O66XtO2s1loXJQD+9wMcmR4DkSdB1uYRS27TB+M69t/rpTlngM5KmaPJRFtZLbfke4Sl
         2sCrfWuokcF0ms6chc5Ufs3SBI7j2Fss+xb2kxlmvM8RiLIEyrBuF6VIJP/2c9qBCbP/
         6sfaQ5EZLNgYKjTdg85Y0xpfiR+rhKm087rilF4aUuPbv6NKiYuLhD6VvWiPYsCvPik+
         XMZywBnRZb0acwrJLf6grjUJxMBE50B82t/YQ7lywO6dFuHQUgNcdwymfClNmNE/gdYd
         wxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792218627; x=1792823427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
        b=ksL5/MNXf97sc1no08AY11nibkR5dCosimnVSOu/c/SpdYfIbPhoRy5k7z48eBhbN9
         F1Cz5aHmU4KJ1IbBy169LWMFLygiz3MI1D6eXNMpppq7fsoyVtos96vROtqdgH6+XhAC
         paUNcJiVOQdpjyKd7oKYWT4a6Y5vHPDwp+ENNke20udF8FfWDemxHpC5n19UzrVTu2TE
         fg7lSCenoVTZ/JJUieijP4udqR4h4q88+Mky8zJ25yvdrRZ8e0FqnmpkZVMRbQK+qfQO
         TGXRajDpO1mdk2OULcDCEI173NyVD+u2E8v8gKs4Hkt4boQtJX+jlJOP3GTNNR8MlPBM
         hKDg==
X-Forwarded-Encrypted: i=1; AKwUvBy8owDNhMj6/C97Gjwo2LlaE4dzLPvPg3aBcO4VVxp1wcnoNyjMy2XL5w9c62BJCcmLESuGqD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJncXbTNlRgH+nG5PbzXo9Ix734tO+gq1z8ZrGoHjiq3j75Cm1F
	LdKAByatMG1pMUnFTLbxrcLDdqAH2ZOho77fJJsV8ffOCPs2gE4PMUPDz2ahr1Twy+xZ7HW+Gz+
	4KFAa9CRU4//OuxjIxZIpdkvYnJ+d8QFxMkdSUuk=
X-Gm-Gg: AYBFou1ZiDzzsVap3+r4lO4CdueVMLbTyHTSXOPILTkxeR6O50xjK8lQQLE5qtWfAbx
	OGn2XUoe3XvCPRVwKSdk0M3LmdpHu6vHJmjUKUfXULHNTz3OEOacotVTF14T2GDo++msNFjtOiP
	ZRITM0oj5tR6TRhL9w14+mGchr94NvY3lghVvu3siguymYpa7ONNX4QOppSw90unP8rlCVQ/xeL
	sR+EUU+Qar3jJO+zge3Au+qV4HxCrk1IS1nEN/4O083o39s2XIxXSWDUFho2hGNRjOq/Or6c2X2
	wRqI91xhQpBmxUCZavyMlFvl97FyAh65gb6E5xThedURH3NP2ygaTNcS5UY2acJypg4LTLN9Uf2
	4Xx4+6mMYDvKyVfZbxmKiRdsuZqzQih0f2/tt9BonNXMdstYW0lhA
X-Received: by 2002:a05:620a:410c:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-93f29d3f0d1mr345360085a.41.1792218626850; Fri, 16 Oct 2026
 23:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026092253-dimness-unethical-2515@gregkh> <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh> <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh> <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
 <2026101737-broker-output-d845@gregkh>
In-Reply-To: <2026101737-broker-output-d845@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 Oct 2026 16:30:14 +1000
X-Gm-Features: AclHuK8oTdGZtkAYns0vEGDb9KwY2aZC1M6hyDXrk7IpcqJ0wBLT9V-mKbZizfw
Message-ID: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org, 
	thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org, 
	skainsworth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Oct 2026 at 15:45, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 17, 2026 at 08:19:46AM +1000, Dave Airlie wrote:
> > So I got a report that
> >
> > "the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
> > swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
> > resources never leaving their bulk_move range",
> >
> > So can we make sure this patch is in the stable branches the other one
> > went into?
>
> Sure, any hint as to what git id that is?

All of the hints:

6.18.57 has
commit 060f8f3020516d71bc4d6159d4d0beef85606a74
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Apr 28 11:44:42 2026 +0200

    drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure

    [ Upstream commit b2ed01e7ad3de80333e9b962a44024b094bc0b2b ]


upstream has two fixes, because we messed up,
commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8
Author: Vadim Nikitushkin <bub4z0r@gmail.com>
Date:   Wed Sep 9 23:50:28 2026 +0300

    drm/ttm: fix swapped-out resources never leaving their bulk_move range

commit fcfe64715b425262af1b36f498f9197f3537ceed
Author: Vadim Nikitushkin <bub4z0r@gmail.com>
Date:   Thu Sep 10 17:34:51 2026 +0300

 drm/ttm: apply the swapout bulk_move fix to the intended condition


we ideally would want the proper resolution of those applied. which is
the patch in this thread.

So can we just apply the patch in this thread to stable, the squash
fixes the stupid in master, or apply both patches to stable and leave
the stupid.

Dave.
