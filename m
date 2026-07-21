Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8F3EB11C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594426; cv=pass; b=nfUprsM7MYDgGEVid3nI2hZ922rTgwFwsuTof3uZcA3Bkl2RxDjB4cAHET5lHe0N6zC+js4QA9CpX1kD9V5LcFPnFOsn3kaW7b8C/vk8Ey6p7FjcPEKDd0lkG1DEhk7KZwKzOEaP5mFm4h7Pc4NPIAmkKMv9Ka4Q2vy6mtXttT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594426; c=relaxed/simple;
	bh=NP4m/7FFeb4FM095XmhQvw1OvTgPqido2XDAs76IywY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6VB2ggHds/aWwPki1YTRmYCtl5+ppLxhV/BM33KUavS6GEDk0IsixVXGFpLsxd3nzvF5W/I7EaP49fQWO0RphqiYZTAeW+mkcfzfQ8Vfzau5MCbEVzG42d55duCJBmUw+EvvZvSQxJDnDv4avw3oyrOi3SAbZPXSOn2wXJxP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfpwS/G8; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfpwS/G8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ecf499af9so75091647b3.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784594424; cv=none;
        d=google.com; s=arc-20260327;
        b=V+lOIuBVAFuZsT3Nc1z1sO2i6tD5BY01avtJ1ggCb0tWeO9k1GRyvVej52EDTUHWTD
         YCpcNG0QbV+EtIS/TeszsXK2ue6J7eQK5L1epEJyhBepKPaOYyAz4BIXRhep27soaj7D
         QZn/v9vjAyUoJ2gOHKOn/nNAyZKBFGQdCBEp84LOFWXBVEh5iqxSIHnq7HkKMA+9vfwN
         QhlJkhsbQfWKvOHYhIQkoC3khIplL4iqMiWj7+T5TdQqQETHCSVF5gT1lNK+5T5OKOhZ
         nHQ9kXMBEQZ/UfUZ6OJF1D53RpfaesLUQYkA/drul/J06pjyjO9cnnA5baDSrK2V85Nk
         JrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        fh=ndBq/YHpVlydxJA+s5q578ybTakf+9bp2XL+qUiA4qg=;
        b=f/B5JqeOqilqxsnzP96vToaepUEg0Lw7nuXJJxqZhtlreX4fVIrLwtv00mQ89J80FL
         vMz6FEWEUIaluuSovxkyUqQJt0FQf6HzqUhz+bTW6u3zKaJBvrfUK0sySTHVmPASqQmW
         YoddXT1IMP8aGIeBnzFmRwzxWtiEBhmWhPqaB6Qv3pP9q2WWPlDOgBXPE6KJwDmFHS37
         W/846pwb6UyFFLriBh0D4VTLGoliQHH5wXKLG0vzSbzeyHQZQJiwCK7QCzYWflhr24XX
         HemTujtbxRcwCt85dXxN1ObCf9IT4dZXOXYZl91Whdvj1J4+bDk7+npjWVcT2lzhxNZ3
         zqvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784594424; x=1785199224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=jfpwS/G8k7N3hFHsUasjmad58pwaSVGiAud/NwZ9b+iAaNHyJQyUiXnL/xj4vpcPzZ
         GwvLLBxSsNhoWGT0JbINk9CCluGk05kaZw6RM+yA1UjePVtCaz4kpuppIwJ4QJru4zS9
         QD4msmAMUFiqpubkxWDYFv9n5lcYusLYRdnO0fjFDZjQsShekKXwyBif368AT6DVFBG/
         dE61Xge9k1k6PhTHlzJMYliCqJx0+34giBTpyPuNAm+BAvn23o+wQzkGc1vWt/rTHJiU
         kbgmxgdv/Z5xs+CHpBtU6bmEAqjugrRCa+D5aRUlMahYyKNSUtHMJQpAl2N+bwTxaNeu
         FIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784594424; x=1785199224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=qrpthGNhOfz+9kW/NWB0Gw/7CJYwzhNwfw3JbOUCcA/gC/b42dhTcAWTpLIQ8LyVsv
         lW3pQv2sh+sGyzZkCRKt2Z0qB63PMv6fSwjwL9PIlvc41Px7oHgy0FZusSGfwDL+ExAD
         w7alWfDCbue2sUc0rv5FbO+Xrn1OAf3hcO2UgrByEdi1BlIf+bvPUBWINVt34bth/zrO
         S5/j7+nSpAJ+0WNU7BBbBgago8hNCbj+HIrQWLu/2GCDvgMiFqcLd/vxJqWQ7J78A3pf
         Dx3ohR6phBhbfhMXUTPIU4TamDIIdx4zN+/GoVKvS5bXhy0R0iqwxXVXS3IB+dsvpTTG
         vZcA==
X-Forwarded-Encrypted: i=1; AHgh+RrEpCVkY5lvlAxQ0ZgTkgEtbWvKvOntXXpVX/Go4lGf9ljZ0padkTqyMopH1f3zdnMMH+n5tvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+y+bgk/BKAvaOMCW1KB6yaKsOJz9h+T4ZwsAol4Hoqiq9sef1
	iruLRXaAam6lwE+gF0XiyWCALT1763buuIKqJx81WuVVV8L4q0qZYw3+j1sSVisxU9te9aHPEeW
	ExjUW2HI6uB329G6Wdsa9J/YPdcKKU2Q=
X-Gm-Gg: AR+sD13653TL3Y0+qK+i2/X5YaS+JVzI1FlO5OvvFQuHSnMJKrVnjNPT56+1PdnMuDY
	YSQq/F2p/rAhP/SHBVITdzggTKjbTKRSL/b2JcawVsbea0GuxFWLo9Z021by/1P+6qq+ttzNuEa
	Y3cD+dF5MvREjovwbOLa3J0uHF4v8HmwquCHSJbOG8FcDU6WkNB8KdXh4gpe1iMwxJHquu8ndzA
	C18lLR9S5BGOn/1AunWYN7bjnM2Wsx+k6nQhwwiUONmJV9Of0dL1B3so1Xyc9sZQfCX/WgVxbiR
	jF01kLIgiigJWxxiUWmTKsE8NA==
X-Received: by 2002:a05:690c:305:b0:81e:b7dc:3dce with SMTP id
 00721157ae682-81ef26c0dffmr49886907b3.63.1784594423836; Mon, 20 Jul 2026
 17:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150628.2914205-1-michael.bommarito@gmail.com> <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 20 Jul 2026 20:40:11 -0400
X-Gm-Features: AUfX_mw36s0y2ormAOkosI4vBsNzUhY8gfCuww9ShBgf2r8MUtPCtf_7IW_q48E
Message-ID: <CAJJ9bXzMNRvPKDUMBrryaWAjF1WqHS2vS1qwOqOOm--5+YSSqg@mail.gmail.com>
Subject: Re: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:07=E2=80=AFPM Erni Sri Satya Vennela
<ernis@linux.microsoft.com> wrote:
> I don't think the described data flow actually
> exists in the current tree, so the security framing looks inaccurate.
> Please check the comment below.

Agreed, I got mixed up on that.  Sorry for the noise

Thanks,
Mike
