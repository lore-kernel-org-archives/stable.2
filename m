Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA27496D29
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151291; cv=pass; b=Vg/xm2vnv3cmRax8g8nHjooByenERlnfElARKvFvxwTy1ANiIPN9QKUxkPaTuCxQJi93sMa9wKSkfjnzV25wZIrxf62HKlU9kLSV2X+9fiKv7SXJOWJzjHLFzyKxwKclsYqBwNbElLWCG0vtODaX8MqCnHYw1REh7ZRF6FsMbUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151291; c=relaxed/simple;
	bh=y9nTbIjY2+t5cR0URENpGmSTYgd1reBZmat/Eu9yGBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWJcsSIJgFubalP8VAZHUcW+WdFJbsLYJae77NFcqxDCwNIfIWRQukd8AENFA2zGHFQHp6gd/Q8r1DfFTxt2LD4YjPC9/xGUxY5+hLTtqBZOvDxW756Nn3IhiJfq4qdtcclmU/rGvRtBI51FRYitW6oaFVmndyThBiG8GGxd47s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRnft8B5; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRnft8B5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so77613f8f.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789151288; cv=none;
        d=google.com; s=arc-20260327;
        b=PSN3Yzsy+6BcYNf2pJGEpzCJsy47nj1jPjUoazHWzBDbT1OOG30WwQvREWCAZhWYVr
         JqiofVdnvkclgae3KCpjsmamfqWCbZdLL+pACCmYuLsd21KMsaFCaqFvDG+gzhXPxGLK
         xmRsaPT1CpdNtSq/KxkfzL6qMxCmtNG1S+8sYrnmneahi/BYiD+rSoYnQFAl+wcMF9/Q
         mSb2RyyX9B3PCUtA2G4Qwe0DoGQ6M+kFGa2Xy0I+z9cUhk0265CMLkpa0+DhNhFhCGti
         Wp+2qs6n3zDXhujtiysIx0ovIG4Cgp0IMtgICbdLVrF4QKh+adV1sYMeS2C1e8fEpbMk
         UuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9nTbIjY2+t5cR0URENpGmSTYgd1reBZmat/Eu9yGBo=;
        fh=vvyCHiOfjuiFCr3E6JAHXWjbW56SmIMck+lxrKtN4ek=;
        b=Oko+FnkqH9R73TihuUgvoqbhpC2UyGTuQr2TKmMAA8TkevHTFkvajyv3c5iv5N6VPs
         AbTfcQVlImzXTVKOorKsRbCbf8Dr4mZwoSj1GVnn4/H1d7FkAGcXuzGRaO+5aEjPjSav
         hcjhNJWFz2YurANA0nRH65jAoKC4RqefEGBE0AMnLXuHLDoofl3h6j+snzs1DmIKRv8g
         z8oGEPaWay1alW3eSxWoMcnrbei+iZtoHd61ZkmLzO5ywAukkWhTLuAxbAJLZtrFRP51
         kre3BCyKGE5YIhrUGuFX/1R4VrriEN3zk8prf7fyzeGURwdHIRrEhJyJ5qaU8zlbUHGv
         HZWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151288; x=1789756088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9nTbIjY2+t5cR0URENpGmSTYgd1reBZmat/Eu9yGBo=;
        b=jRnft8B5UGDOkTwcFD420fwte2Et9asVQD9na48sP31wLIrhJfZqpNw6aKvO5Zm/5S
         3d0n2jordDICmvg0OjV30YeSiyCiiaKYB+uehjbc/wpzE/WlFJOi5AJdG1J46b6J139b
         wZ7QEOMtFemVOh6nnbNnFlfoxjc/UuAKYslNgOHjM+aSSNeR8g0rib7sLhMkLAntPoFb
         /+jMBJX+1qL50lOBMHjHXa9p0Y7lxLdXyLjTQW5uXf2yPb6l5H8iH8pRKGYOjEIhMXrU
         lkKETvhYWiQrmVWyv+FwuUZn4rFrObZVBY0R5XkDZQw7JMK4K7SEz0+gDg8sNLYckPZE
         Jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151288; x=1789756088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9nTbIjY2+t5cR0URENpGmSTYgd1reBZmat/Eu9yGBo=;
        b=RvlDCRGb8IJ+4/69WyvfiVM0NCQz+Ihy6yfHRNCEBYd+wjoUvWITXBM7t4KIL2Y4q/
         fGJW4f1cgw3AQmDdpIrZOJK71ezYF5MtLr3iMFUd9xQiyHpglK+hmFJoC3O9TgG8w+kX
         TxQmkR76WVxYo6Y6fC1d+3cMtWtWMZ5GM1qe2XBa4qdFJk6++5AOpaQ7qsJqCWg0qqDQ
         qc1VBRSWyINOmgv8UjUYNAbmut7cQpByMh3kgEbyIAXnOYwmKE+JlZmsv/GOdOueZSt4
         a9t7gLH6L5qqbzl2ohgaunVGQz0t7zllV6TSyfOyXCbVkNwuEvlaAGITpqQMB/Pi0p/M
         adfw==
X-Forwarded-Encrypted: i=1; AKwUvBy4xgQQZcf7BYMcKYZhvQtjwIRLLXEbJpfmiU8iBzHRBJEmLbvU+YmxTlLOI8MihBErC3sMXtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kYOr5egPjD7NJPdY1P50zbpvFnstGkAYxWZ4Z6cg3y6hoplsJI
	y1nXAz15LJutxHIDA7x6LJy44II3OHpOBQ3XJ0JnaW7P6FOjHJDDIPfloViN7zu2s4hgDEZsEbV
	KOSSh8TS5XG+03FrGpGw3UNu6+sMqMTB7UgiztE2q
X-Gm-Gg: AYBFou2QgukZHLusD4x2My3aIgC7FoCjiH2Kb0ativXXLrjc0A3Vqfwc5KnR2zPWzgN
	eD3IL89NtbnmpeoXOni9EM8iaKHgi2kgjxlpiONL4qEOK3BwoO0tuOWmpkzKNHGNmvUwOzR+nub
	0AZKFPb1VgSX/zUOv3fns6Bnhg2LQdkfrm/1KKu0g9B0x1Ox+YlTOceac7/+awLFU1msIUNDVBV
	i620D7ghX+bDbLgQd6XEGAitWI26EItRTXvyTpJCEoLvP4KyiGla9i7to3DVA8bo7yifw0SZpOu
	Y2PX04jqXpx2W0faVSxZtdqavqmYpxOpcnfQHOlULkU5tTt7ti2TZUoTdCegIaXW48zFyZQkWyv
	UmIfjFJ0Q2w==
X-Received: by 2002:a5d:5887:0:b0:485:ae8d:1e07 with SMTP id
 ffacd0b85a97d-486eb3543c0mr6951383f8f.56.1789151287712; Fri, 11 Sep 2026
 11:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904234401.2339633-1-jthies@google.com> <2026091023-numeric-husband-1b03@gregkh>
 <CAMFSARfnRpkq21j7WZYqdthy4aC7VSPjQAKm1eHvbYxhM6pOnQ@mail.gmail.com> <2026091139-spindle-zodiac-2342@gregkh>
In-Reply-To: <2026091139-spindle-zodiac-2342@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Fri, 11 Sep 2026 11:27:55 -0700
X-Gm-Features: AcwNN1WsFlTMBvEiNMDzIzZo5OmwjBJhmGTnyMtJQR0FexDEekyndWgnFLMhtM4
Message-ID: <CAMFSARdSyB9m72r0gpujZmknN_aDVUnyOzKHfdksKhemfzcUhg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array index
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bleung@chromium.org, akuchynski@chromium.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:

> Why not just a fixup patch instead?

Sorry, wasn't aware this was an option. I'll send a fixup patch to address =
this.
