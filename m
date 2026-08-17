Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB0426D03
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982333; cv=pass; b=Q1lfn8gvuh0jmyImNoUzCNU1X1hAHz3wdBw3pLvZkd/rXzpIbImiZUEkBigqc3n7raJ2N8/vmdjJiY43xeQdbJeZ0ClPoH+NqB+XNVyJ8G6yVykH/5J7tK4vMKCUz19EVVgyEGRsjQ5RRQOGI+vNqkzTcnSNdmXJs9e86NHGjGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982333; c=relaxed/simple;
	bh=no5UqGeu/I9IJaiTWAxVWsktaYLTQKvl28qMYcHHr+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1SFByKBBimtK97Pjyaq3z178dtZKgXVdqA1gyLDVIHfEdtn0Rmfcfcc4TgSrFu93Tkjjj7WOQaaZi13rBwK4mAa1KremXW34/+CKDnM/GmQccGHDtl99hiLE10G80q5i7FcMs+6HA3MXlMeEH2vqtLTnF5kll9ShralAx3azhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cYUn7vv+; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cYUn7vv+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7c6ec9dbso163849285a.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982331; cv=none;
        d=google.com; s=arc-20260327;
        b=i/pm9EWY3CE1IXkIc+fvCxYM8mNQqo9Hpfy7TZzDzm/jOAWgGNmGfYxsQR+NMtKIqg
         ZRMyjryibjJrUKdD42wAyFOv0HpKu6DYXgvcRNL5kSkxSNaqph8kLFLoj3JFHr6Ey3MH
         J3FLUJYpvsE4rVsuKTM3CSpRrJsiEZhqm1KnaO6Z7MVqEpHF4DOGiKu7EJcHPj4xjKhM
         xBWLuWvKEVPdng3hQ6flZQOQzFLIMLmpT4aO2yxgNeOVh6sS7ngV5VyBOitsyJl71UQF
         GESblqpcVOrhF97RtxOmp+WjefosUyqrAfnDtMUx/tX3vkj+rHa/mh0yD5trAEZ3Kkv9
         oThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        fh=4xOxhBlQnq0woYNxJLDGxqNwoJSHQNcfTukIUpLAfqY=;
        b=f3GpdwB+HbUhJRVuYgfHZdLaIWOme1CB8+H8dLEtEjEvR0SVwQVpTXA5q+hAmEYyqC
         lVKn+wsHU345H5rNtmmPfE+237xkr4G5ApIE/pEgSAr9gvBKwbKjvwt4HEFUwpMnnurJ
         ol1ubesnNJLYOo4dfeEXnerhR0t1uWHBYtwM6wqS4OII3KEzfIWHRX36hU8SSt6svy81
         rV3GDFaZNhel3AtE6NQJyB0wMgjE4ev5ZtCj9AI8sOTv3qQRKBg/Wu1J+xcyfegEwuJC
         SnrmpK0MGRG7gplmWJ5AsltEE3th36zkiPn4JDJNTSlx8i3wZmRyfw22x0tU/XJj3ZYi
         dw7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786982331; x=1787587131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        b=cYUn7vv+/NM0UmxmOzcAOD1iOns4Z+X1PzoQWgqgWwvdSitZfzaXUXMkSbr9wNWKfr
         iDmh3AeBMWbhRcifC/Sztcg12QQDcRvBRC40BcLJz+csbnHXbxmBGax1AYfj1q6t9EhA
         5tMql5PUbK4NmEQvwixc6NXSIocViXu+IMz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982331; x=1787587131;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        b=g+DTfqlO5NAyHGAsOGYzRIsUNejyovRp4OjyMVdIe1YXN955L93qHuuFmGwdSeXi+J
         sXHheoL0PalEcEzJVzriGtZ4qpIPCqLeB3WMxkjy1Mky69OIg7HcxtuBRx8BWwL07kq7
         0NkXleaTnV6ecZd7sdJI30/EsALfiyWzyAvtEP0gWJejYYy8tZ/gjBas7dNf9aSQuP46
         C5Gkpc/tmMukmYBZrDTJhKEc/K27VO4Jl3PobxLZPbn1cbptDb8/YB0XoLUUHytSjKQz
         H8IHG+lfiK7MXFoJAeupv7mkSO0MUPlK62Xd6yMWhyURdoSSmBFXoHVcL8WjsYzitY0p
         s6MA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+sJzWnHTL40k68OOvfAPb+rVsy0ZphQZZ1cf/uZTBCPBC4S/HAZ12BIAvJNOP86ep+77LPcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYjnk3fYkyWEFn8nEzhORSId7lZflU/Sp6uA9MdJ+JtmK1TRP
	RJTneDUkp/kAeNDuT81sQ0LpcaDdGhIooTiNq/WYe1sUSVUOV8j2xz1KcJG3nCL2V+T0dGl8tlQ
	tHPJpTOf2p1anN4WGJnyE5yiXjvuvSDNcTnqOJF37tw==
X-Gm-Gg: AR+sD119FKVi/6xSp/+MpZUt8goBoYIovSVBnCMVVNq2wheBIR1qZvsFqALeL69lKnf
	lgS2GHumW+PGxCWHTO5536HYjAbpdErtMieLTSCtxnHNLRpeuJM0kwf9zcXVd8ZrnAVbIwSVIUx
	ZcttWy4bmGpqBaSinwUxNRV8rtrR3yyRZ3/6gQlkAlgLvFi/cokFv0a3BxBd2gwp4/FqpOAQnd4
	0QM0M9KHyt2c/0Sp0X2FjZz/rc+S8wxBbN/LlajpIzbp+MpI1AbYpSIhI79OihFtN/MQHdGfcR2
	YQSb9qjvNcJ8F3+ATnDus9PB4vIOnfAHlJyV01gDJAXYbIeG2jglvJcYFrVsv/MpV8gTZq0WpKP
	s
X-Received: by 2002:a05:620a:bd4:b0:915:e670:4021 with SMTP id
 af79cd13be357-93704c453bamr158105685a.45.1786982331219; Mon, 17 Aug 2026
 08:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813035836.74045-1-rochan.avlur@gmail.com>
In-Reply-To: <20260813035836.74045-1-rochan.avlur@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 17 Aug 2026 17:58:39 +0200
X-Gm-Features: AcwNN1VSPxOYN7kpQnUrOdAukJXi-HG8yj6uq1YUzdXVgD6MbWB9mTBM8yTMWRQ
Message-ID: <CAJfpeguLnQ3rps_zz5sQmb4BZSG+C8+d5cCJdW2+VxCdtajhxA@mail.gmail.com>
Subject: Re: [PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 at 05:59, Rochan Avlur <rochan.avlur@gmail.com> wrote:
>
> The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
> and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
> concurrently processing the same request (FR_LOCKED set), the caller
> frees req->args while it is still being accessed, causing a
> use-after-free.
>
> Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
> returning early.  The wait will not hang because fuse_abort_conn()
> ensures all requests are ended.
>
> Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
> Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Applied, thanks.

Miklos
