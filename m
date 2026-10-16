Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D2820AC
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112544; cv=pass; b=MN0kTNifynyY4pWhheQFIgqdbNkkIo0tgQoq65Y691Sa9oaIcRT3kp+jaG2v+TfgkSkIjfkTxgtwnkpmJJcjwRTBTDrm2WjwskCBdoCetMX9mLTUXwxJuLkxkQsj43scd5XOYBAGQe1HhxV94XQyApCq/KFqA77cVVFeT/B/lJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112544; c=relaxed/simple;
	bh=wBL4SL95L+TQnICvrDYhAddbR+PbmE/yJ9gkoqY22Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0Nyclfb7A8Nj+XD4FDwlaDbHPp+DttjhpKA2vTjVBzykqiUMg/QvCUxMobHKW6+GbIYNFPsZ2YBH7pj40pqS68Skqm7jzbsT5mEzdFLpY695HeSY/daGFYychyzuSmlL8XmR9xFzIMgDXqB7mGGZwuH981wbhPUGsGJkyv9GJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT5brC7i; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT5brC7i"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ab38a051aaso51480547b3.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792112542; cv=none;
        d=google.com; s=arc-20260327;
        b=hWJOZqEGhvZRJ9CR6Sd0f6OpVQhuEbdI36ddKxhtXo3bx0OGXhhtmgswOA3J/RnV7T
         YgTMoN1VTuuxHgboIyn8CZN+2CT0E6CKxVyP0WE5OAefd3reoPMqSZdY/UpH7c2yJaPB
         YRR6SvhPOiPqimyHTSlfqHFARQGWY7HfCTBGFXLh4htbTkUY4C93921O5kB1BVL3nFkk
         kagS2Mdo9ztVCGOQ625/FED5GuE7sm5IvAeT4uw2N+dH588/PP45EVUOHdl6uOtN7sjT
         5B9dJn3AutmyZXk3wx3YCN6rV/eOVjawEhYoc3QHCy+y1YcF9KvGK2WO/AkK7X/rnUjl
         zpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61thaWeZT91miu29wfZjfnsN1VP7QHc+H0c4ZsXVYAI=;
        fh=X9VDuLbwh1IDmGQlwToIsP2Ge6HpZZrANdGz92aU3B0=;
        b=L1tjwuGPEB2566HzpWIjlxoB8g96FWiDLzN2Wk0CzhxwA/QNaxreos8UoyQMghHlhR
         dy3WQzUcvOrbUhVWg75+oOZyIclwjY2cf4Wl15H/blAxX8WzJf58vI37mNxsNp0phd7G
         9vM6WmonddCKI3kez5u8HW2OAs5cRfdVMfyazmNEVkOlQTOpcWfyaX41laTjcuZulKeK
         EdE/HoeC+bj8OCO8aRQ+iBKZezW2oWnOvVS35thq0IRnlAAgeB6Dypk/X8pYEzCsl+tP
         A3ODUgoXOrcfjpJebR+cTunM4skJPoKAM80LOM3nh99l1g2Sn4kl08UA33GgPyuhA3RH
         12tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112542; x=1792717342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=61thaWeZT91miu29wfZjfnsN1VP7QHc+H0c4ZsXVYAI=;
        b=cT5brC7iOfTtQBvFyw4dnHmYWOoEB7Dt+mHjGTLshQCn8QQDwCEixuKLA8E+Kx37PS
         FB2JxyhUAtNSKDSE6D+ekborYkACTNrfGKd6RSG1vup2kXmpM43K7RiYOqFEzrJLeY32
         pmu1pu8WKTiiLh/+xSmqH/nYT3xCLEEm+oo7s40UJyn8hm59j0unxyqJfIXJ9dbUQ/ME
         QLoBcQaUqcGsrqPquJI1hGPMtM6iWY5JTNDQH9nFpg17kvT3CbYwh1qlFE6KOKMrvkv/
         k52EKqcELFrqoe/YPm7xNwZxRPLlfNktEqLer8a8+KkiHApF0BK4GhweDKSvlaiUIxVG
         wNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112542; x=1792717342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61thaWeZT91miu29wfZjfnsN1VP7QHc+H0c4ZsXVYAI=;
        b=IYozkL0NP0iMIf9KpmC+mSE4D0VHYCHACZRHPhzcPwud5GkT8uxOiHiOzpodQA+0ve
         j7jj6lE7qPY1lmFXPrCjpK2AeJWuvvWAihHMtGpdC109ER7/axx2zn/yikWZpCKBCBr8
         qhZeWTd3o1OYo6GyexaJbwuBbsqfcRNNZUYhmpllp1xJqWoG6w+u7f1W9IX0Hv3Giy/0
         EX5VmKxMFSOr9YmP81sAzqYUMTAxTvUt+LDX9Y8ShVgb9NoD//MnInu84yW2p8o+yosx
         4kNG1DMpUHAlXyDPQ2iygF1Ht24hOgPcre3QSjXXG74ywwC6mwUIXr2GGTBvN1wDGWEI
         vOdA==
X-Forwarded-Encrypted: i=1; AKwUvBxXl8TTPvlRr7IL8JpY8akkWqGdG2ydcAyuIasng9btOVA3LVH2ixMsGIwBZYQtPJrawPz+hD0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7N6WRbarO2UURmc/mMoyQ8GykG8orOHhKyVRttO4laKK926gb
	ekGnxZqMsBL5dt1zZnDPC6WX77PT8UQYUjzZGWfuqbw258oCYy8kMj0s4JcYVNA65QlSK5/auuR
	EZzG729FiOycMlDDNHJAbWLVbFrFJ2DM=
X-Gm-Gg: AYBFou04ekmp33YTsPzF05XdulVQJPBrVsJrYpBISikkE9YlWDI9IiKe7lcVLztKgUm
	JtlqWzWxYxccoRiR+ZufLPW4FiMxJAd8Sl6uz0el6qsx5M7hKkAMRThMIEbWcP1KrabJgXiEzF2
	J26G2vMCvoXx0RZ00WD4bchp8PhbLZ+XeTjiUHTfzazGps4cZezUIulG/sDCVAa+ggIetYL3I8M
	Mr/QbgJpNCulsZpTsst0S81izz9HY5SDzpceJK1Lgt2endYtx6BZZDOHqAByPcftbLc7xZikdmJ
	mVjqgTIey+mkIf6jb4t902+9Rb86CptbF6S1Q9KFrOZP2nkL4HZnQ4aXUWDpKBS6qiS+VsTr/f3
	F/j0kaX5lqJw=
X-Received: by 2002:a05:690c:2605:b0:8b0:cf3d:7b19 with SMTP id
 00721157ae682-8b0cf3d7ef0mr21478237b3.32.1792112541667; Thu, 15 Oct 2026
 18:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-alsa-pcm-drain-wait-lifetime-20261014-v1-face1209fbc882aabda2@gmail.com>
 <87a4oe7sp5.wl-tiwai@suse.de>
In-Reply-To: <87a4oe7sp5.wl-tiwai@suse.de>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 16 Oct 2026 09:02:10 +0800
X-Gm-Features: AclHuK-9sZJHv-N7sDN_4DU5rI3kpYqHnyhFgeQYS7zeI7kbuFwQvs7XDIngvOw
Message-ID: <CAFRLqsVKV7X665-HOu-SRjG4s+D7QrRciiD6SVZexAnS7pffgg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Keep linked drain wait entries safe across unlink
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, phucduc.bui@gmail.com, 
	cassiogabrielcontato@gmail.com, cezary.rojewski@intel.com, 
	kees+treewide@kernel.org, yilinzhang@moonshot.ai, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, baijiaju1990@gmail.com, 
	jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Takashi Iwai <tiwai@suse.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8816=E6=97=A5=
=E5=91=A8=E4=BA=94 01:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 15 Oct 2026 19:10:29 +0200,
> Cen Zhang wrote:
> >
> > snd_pcm_drain() queues an on-stack wait entry on a linked playback
> > peer's runtime->sleep. After sleeping, it calls finish_wait() only if
> > that runtime is still found in the caller's group, since the peer may
> > otherwise have been freed.
> >
> > Unlink wakes the group members before removing them, but the generic
> > autoremove_wake_function() removes an entry only when the wake succeeds=
.
> > If a signal or timeout has already made the drainer runnable, the entry
> > can remain queued after unlink. With unlink performed before DROP at
> > final close, the following ordering is possible:
> >
> >   Drainer on A                       Final close of linked B
> >   ------------                       -----------------------
> >   Queue stack wait on B->sleep
> >   Signal wakes A: TASK_RUNNING
> >                                      snd_pcm_unlink(B)
> >                                        Wake returns 0; wait stays queue=
d
> >                                        Remove B from the group
> >   Cannot find B; skip finish_wait()
> >   Return due to the pending signal
> >                                      snd_pcm_drop(B)
> >                                        Wake traverses the stale wait
> >
> > Use a drain-specific wake function that removes the entry under the
> > waitqueue lock even when the task is already runnable. Preserve the
> > ordinary wake result. This lets unlink detach the stack entry before
> > changing membership, while keeping the runtime check around finish_wait=
()
> > so drain does not access a freed peer.
> >
> > Also hold the existing group lock from selecting the peer through
> > reading its runtime fields and queuing the wait. Releasing it before
> > registration lets unlink perform its wake before the entry is queued,
> > and can let the peer runtime be freed before it is accessed. Release
> > the group lock after registration and on the no-peer exit path.
> >
> > Fixes: f57f3df03a8e ("ALSA: pcm: More fine-grained PCM link locking")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
>
> This doesn't look needed / fitting for the latest code?
>
>
> Takashi

You're right. Please disregard it. Thanks for pointing this out.

Best regards,
Cen Zhang
