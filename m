Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFC356746
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636328; cv=pass; b=IVNK2Mz62QcNE0v/hySmQpB/aIXyQ6XSZlSHYOVM9jXSE+EnLywIixisQwdHY/7gYMhj91Biityy3QAWAscFAnUDxO/pEg6MCkSj0mV341SlcPiy18aMA0QuOlp51sLY5lFGa4YuQ27luvgydZ+TTBei4NRAHYGa7I2hp7r/g+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636328; c=relaxed/simple;
	bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZnu7vNQ4YFF3zI5b+jHYlnrNXjY/2Cl+8YJtMQqSGdMmevMYYYJhXieBi4i9k+3QEYB9juwYUjOm4DEe/q7MZQT2DicWUgVkmF66iT4SQstDZ18VOhmIzQElGASNiRo7bDI1715zyUF5n5FrSUNBovP3475M59wSP4taXMrDmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFvh5E+R; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFvh5E+R"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3492593a12.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 12:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636325; cv=none;
        d=google.com; s=arc-20260327;
        b=p+PQnK8FEnJvVozDVFQ1uioo8M7D6HyhlrHb8/tOqLnUUI301wL+DYbYmEGRXihWYr
         b30AHmNrPOQ3EpvXjlwXjNoQjIDsMkEmsEPAohZwC4kAQ5lJ9qM+51kAKpnEHvIrqH42
         LTkI4bcICVQLzVjxWbPaqknIMDrME5BwrAfNTRWBvki7emTh+BMRkAA3LFT3Kbdiecj/
         dDKVJ/sAwNlRy4GG0zI41Uc0NRtDLsvo+CXa4LA0x3XjaSG6Vadb8TH+28XUAiRewYAc
         u/NbHd/apiwBQ/kzgZPVvJYWPfVvdlhT7ZOjXaepELXJbED28vPD88fDl41VH54jUz2H
         z/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        fh=0tG+QAUvgeh7o+6RLGBt6Il8dOLjdM5X7opdwPcem+M=;
        b=gImJXBy5Ur8+0/AHrKv5zm68M+pIO6f8nyW2UOfD/fkZnJjjF5C53l6YLOSDtIyqmi
         l79nfiSuEV+kMCeeFYZTFyoreS5Sf/rVlCcg26zWzf4TSmIGOOyDDxrxONJl3cTqaoDx
         Kb3CYepNZwJHxox29Lshr8gKr96OOu4TjtUphYrzcgJ9gR/DZKlTH2Ovw2ab2nvj4CR0
         P9eFsr8Zz2OD0XVqUtxSVU/Bok+ZakpuhRZNOJNos3I30gW2hzpdSaOcKG//Mih+BLZI
         z6NSSj+ufsNCrV9AH8D5q/Kxqt4c0g9UtRSg2zX+RRa3bAvkKvbWlW8b3KflgZ1pF8n6
         gPRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636325; x=1789241125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        b=mFvh5E+RfS4aNj0vy+YT58yiX5gXrqVTmIyvgCwl7s4+N8bAysfWJFRiBZchZHSZP1
         xDITBb9j3SypuZd5P0/6K4I5UmMSmoMBIQN2nBHdmVxV5V3xiJKCrfjS3oEchRJgz1XF
         w5WxNlnmLWbZGXXH5v4xtjVDWrsQwi8g0uNekvGul/R5js8SYY5tTcZ8NQC5wqgAl09u
         m/RDe731TzJzY24shmP/QfiGau42eQ1cYicgWaEg25xwFkJaD+Y1lOibwCgKY10QRrKk
         DqiY6wsiqdW0c4ykZY4pnjjC8Ad0sEsZKFiVFQb3B6NJglzTDtxQTdobzJbdWTbqxOfR
         6g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636325; x=1789241125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        b=qZXtPB5yO1Q3SCT/Iqq6ZZPs9pkfQJAvfntnz0d00Y2cZvFeKW0+ZtpszoHJfmwpdx
         LHdqnqGs2kUhWdfNK8//RWkqJg2UhvJXyrngbvYUctySvVysfTYIs0rWLtSwfDiEyXZZ
         i4lRvBvMt4LWAq15nYqVdAyaOr6XvsJwoEXqQ7EBgOjmnytD6rWcDefLlx4B07S+RW3W
         JD/+4KOqNgGegW+9Gavwi45c8rQeTa4Y+dvyyWeCJKfiRTCr6GaIgRec2jd8ItZ9Vy8z
         3mZmkrwvOM/ZW1vzf19UuhRY0nh99DSxwDxj44QYW9VvjLwuO+oxOWG03zqOCey/M4VF
         ONVA==
X-Forwarded-Encrypted: i=1; AKwUvBzFB+okjrfbU3EyugnLHZohjJMh/Awp7GYj8U3KcNedB0TaQtukPQvQtJjpr45xCvG+r4i4Lkk=@vger.kernel.org
X-Gm-Message-State: AFuF++la5uHPMfcbxwjUYoKwawCGSvslZ9eY9Fg3g06iZ5WV9AGNyXT5
	Vfywy5Ukpd7q1FMc25e4WC8aT8yvee/R4LLzhnPA/EBLYmbNIkhlN3MwtA77RbCeQQqquuHujBK
	b/GiPh2wElfo/uwnPzMBryBjC93+qJSE=
X-Gm-Gg: AYBFou3fUFIGx6S2Ji31Xz0AAFcUEKxKH5shO6AUOJSuNXYocGEZFZUW+SCJt6Ntlb9
	n6g73+P2Jmw1L5nzLl69syekKUVI2aurNJqAAuqChsjXIFtsn4Z2K9XPeK8HqW72Pvo5UNLjITH
	PeHP3MEdB1JkTjhUAs7Efghk+t30/0e/U5Jxjc6/3ZeTu9UqwFTUHi9n8VMCdfD14zmyilmhWJI
	Xe9uA7Tn2eGebGkBC3/lL5/m7eSVaVfTwGWSVIpMaX2GxV9r8GaKatJt6AC1uq5qVqfAtr8nNBK
	1y4k6rwV/Jbdcy5dQlvAlhDfSWrqwQJyxIXm0j3z4w1ukGTsf1ACBCexeLQR49z7ojcdqEYACtI
	RcnS1qOmRjhXHYo0FqPNFjgAkyFd+asM=
X-Received: by 2002:a05:6402:42c6:b0:6a7:fb24:264e with SMTP id
 4fb4d7f45d1cf-6a7fb2427d6mr1836272a12.34.1788636324671; Sat, 05 Sep 2026
 12:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904123843.375633-1-linmag7@gmail.com> <20260905140755.GA2875205@electric-eye.fr.zoreil.com>
In-Reply-To: <20260905140755.GA2875205@electric-eye.fr.zoreil.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 5 Sep 2026 21:25:12 +0200
X-Gm-Features: AcwNN1VaRI4G-HQNxdXx9quUjsgkaAUNPekVT3Kj7muTqDDS35k5taSE0YYNcaY
Message-ID: <CA+=Fv5TyOLB-wWap6PCpMw646QnovtDV6xwqyg9ygpaBemXaPA@mail.gmail.com>
Subject: Re: [PATCH] net: tulip: use mod_timer() in t21142_lnk_change()
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francois,

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM Francois Romieu <romieu@fr.zoreil.co=
m> wrote:

>
> The current code may avoid concurrent run (#1) of t21142_start_nway and
> t21142_media_task. It may also deadlock (#2) as you have noticed.
>
> As far as I understand the code, current users - if any - may experience
> #1 (avoid concurrent run) or #2 (deadlock) alone as well as #1 and #2
>
> Users of modified code won't experience #2 but they may fail more often
> at #1.
>
> It may deserve a minor comment explaining either the choice or why it is
> not an issue.
>

Thanks for catching that, you're right that swapping to mod_timer()
alone loses the pending-timer protection timer_delete_sync() gave for
free. I'll put out a v2 reorders to mod_timer() before
t21142_start_nway(), which
should restore it for the pending case; I don't think anything short
of cancel_work_sync() on media_work covers the already-queued case,
which the old code didn't either.

Magnus
