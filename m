Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF3517BCC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949743; cv=pass; b=ndaEJp31VWPZw5/Ee+10fX+hjv/HwLorIy03EAX0RchR4+4sPjlcuvdA9mr0yT2H1o6tWY1qXpPyhGOcwagVA8Nyck6tQL1X7enqYJ2CpBh5EjfiIsEio9LP/F1ZrwUxM7/rlfJq8jinJpulsgnxmUlHHqV3u9FCfjEwS00Hq5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949743; c=relaxed/simple;
	bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpbf96pO6SgToD2DvjJ4vOXHI1BJ00f+//RyxecBzMbuwmCT3Arhp2uglNbXUaScSeYGg/ZWYTD7idhE805Yj/fWbcoRb5ivfhwTZ4W7GiF9NNaXRb4FOZWZKFaTakn2Jza0LWJXw4ApjKJAX9gqtxVMk759IeZPO/h1c917tEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbfn5/vD; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbfn5/vD"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b31c0bso925187e87.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 03:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949740; cv=none;
        d=google.com; s=arc-20260327;
        b=VVUcZpmO3J4zJuo17VprQY/U5pxN1ouSysLx1UWSA7C/77MT0Lw5Di+tyfG4YPuChX
         FAcuDYPmWPvC/Cm+Bi85pUgL/opgd6gIuLTVrF64GRUH30OXrYEWsRmV0A5jqa4k0Pdl
         h/cA9lxOBcbMdWT5Tbm+5L58jjGQ6tylDGh92mx3O0/C4K+2J64QSFWbQxHtW5zBZuUU
         U8fvATzkcUJ1xQDosORIZuE8RyGUwF7lW+C6IjeiwS2huSwY7A/LV8Oe2KKP5Yxeea9U
         ysrrhBcmfocii8ALB2wO5zwakFZoz/jZTwTe7HrlMyotnP/X2ozYn3wPhDYF6zyQVFgc
         Ifkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        fh=Xg+qt9A5g24czzFLMaGNeznlKA3/1Oix7YB2HN43/KU=;
        b=Kwyw9e1sHpBOhpwuu3EKGZwXmqT3E/MjKHuAbQ76bA1qv/Rwgktqy6lEIRp7a3F2A3
         myDBK6oReKmH+rTVj8ELbrtLdE+3ptX/GXCtczR7nJE6g2U4MI2t59QKlYju13fsVisc
         q9zX/gE/vq+ZB+rhjNMjqSekIGXctu3pHfsCyI6gh8MUPN6ilEPaoa0qmWhBTZR7Bg4h
         qISnY/+67NFzDdHnHbp8pBlS51afgzTZlQt04PxtjOBMNoQLDhfnICheakRoe0PNV0Ue
         ZTLidyctRHLlNKYIxx71mDtYwVCrWK58hT3lI2Mfu+R/9lkx1yTTJXgGcT8i9oGRkaHi
         Bw4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949740; x=1789554540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        b=kbfn5/vD52Xx0hHWdVYALiX6tNDHW5L6a3+TNfOu3g7/1LdbJZa6d11WY5eWQUSSij
         ygZQElfol1WVcqMFY7DMBi6kyxAAo+BBFf9w3iXxzLWZPPXAEFVKqmff2PWZEI5dT3W/
         ZD0ic1MRhB4lT+MYsd4yJXmWz/EZeSzUIvtHd9SOKJyT88MEze0K9YlZuM/TMfB4GnWw
         NZ36N2Gn8tFGai4azk2a8KqF6wm53szTwIC48wifFfse1hZ0Hwu+T8o9eIRw0UEDRgnA
         2I1oEbY53yLMTNftcyJlBosUv97h5+zjX72w6nlp7VtnbLtCXDYyMZMURTqlP3xmU5Bf
         ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949740; x=1789554540;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        b=JzWBp8LjcpFmhORFuklgpt1aVK73nQc5l59QGCzMD07cHEYLhHSSt0iz5MT0y5oWAt
         Y/KMCcbORPUQDHjBrKsUPoMf4Gm+qw2fy5SevWJU6jZDEu4gaLFbqSyd7UlfxYL/vSV5
         kMGAhlW/5M9GUTO1L5549uW0gw76FGkn2SUJbGW4q4KOFsb1OHrCjFs+FvKC++BrdOk7
         BnmTtGtKtOzGqliD/T4p3XzOUDGgMZMVe7UU3kq61J42hCL+ZYY/aSNPp33kWxg8j3Cj
         AY7aGqNqrEZTASH/zDWHyDUf/UiZzGXPuTIihYa6rU4ywO8eU32qUsTNgzzqUgH5BM+W
         wONQ==
X-Gm-Message-State: AFuF++njn5lFKO2ZHw5wyh1VqiED8XaZnZ3nsQnOydTAKsZ1eXEBdd5N
	PNE9DtRnWyJ145UM3mnTHGRqJfV9F4lqzqeQWaGYtlgedO2qnxW2ERCUu1PXIqMUrE2sc5Xmazh
	V/VQKE0gwG2NxHQ0RrhiFRlMkOFsswkQ=
X-Gm-Gg: AYBFou0JRK6z67rb9boXEXi+1HE6UBtR+AdrPwvym8P9i0wjHOJY2I3iWSq4HEW5HaL
	LbvO3IbxAYvwJx3H6CQocdvsaI5cMOi8nJJ8dmDE8UceX9A11c5s2Ccuwv5+KHOnE7bwAAgJMGZ
	8M9ExF+tPghwf6nTdlXbJTtPaZxA05YhDx+Fh3Yrg7JOcdziNDpVusk9L27r8swuAy7yOFTrhxc
	uAGQH+JwK3Z0Dn23Knl0yk3QyP3q3eqZwGTNqhHGBPe4aVn+2xmB5WwKh9Y3cR358CfRvkeB8cn
	g95ODsSHUgXVQNikVWyetESTGYOOj4ZxdB0dMwqNt5k49R1yMEnNIELCey3Lc2Q16DrZenUk23l
	PxJsMhFIbPY9sfC7Wfw/gezIBYkMpbBeUYQVQl6m0sBEG8mF6hWI=
X-Received: by 2002:a05:6512:1329:b0:5b6:1913:8d38 with SMTP id
 2adb3069b0e04-5b74d53007amr4421132e87.6.1788949739610; Wed, 09 Sep 2026
 03:28:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:28:55 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:28:55 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026090833-mutt-whiny-242e@gregkh>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com> <2026090833-mutt-whiny-242e@gregkh>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 9 Sep 2026 05:28:55 -0500
X-Gm-Features: AcwNN1VIuW5R1C4C30YvVizM9RLgpK4zIRN-8f2fSAOShJPErBt4yMIadb0ME_E
Message-ID: <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before
 updating state
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, dmitry.torokhov@gmail.com, pengpeng@iscas.ac.cn, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

You are right, 6.12.y and 6.18.y need the fix too. I missed those branches
in the initial submission. I am sending the two backports as follow-ups.

Both apply without code changes from upstream commit
95dffe32a66cbed07fbfa7afed39d56d5014e04f. I built
drivers/input/tablet/aiptek.o with W=1 on 6.12.109 and 6.18.50;
both builds passed without warnings.

Both patched kernels also booted under QEMU/KVM with UBSAN enabled
and passed 20 module load/unload cycles. This was a module lifecycle
smoke test, not a test of tablet reports or reproduction of the bug.

Thanks,
Miguel
