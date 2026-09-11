Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1D4AC159
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150227; cv=none; b=FS/suRPJRlH+fY3pgb45H8isTMc63YkOTZjQRVzStWXuCd5Cdiluqx5eb5KIcndqRYC6wuQnACXefKbnfr/p4qAwqIlx3FrsqUejFLEST7+kSlDb00wuwAw/HbMuOMEf8LMAF1EObMJxo1mzE0ozdWaqZx4fNZM+trc/DEAUBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150227; c=relaxed/simple;
	bh=pwGqM/+vkkzFyVI/JsfB/s0Y3ZhUGDk2RXiK+bDPZ8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmPX6Byr8Afrucxm5WI+5bZum3vq2bdwlsXnO22qIdYyJzys8aDq1/VblTzKTeuUgSXuIIJ/LBmJ/5ryyqZZlsMGCgYtF+T6JJRVoZ6DGk1KAGyyrLjMOM/tu0WmmHrTIK0FalJaYrtYDSevOlXgvl6GSFxmAirI2ThotY74OWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJGBsGOL; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJGBsGOL"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1641443a91.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150216; x=1789755016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vRIpRvEbMMuUyHQQxsZ0NfIJDkuNXQPXZTlmMz1Dzfo=;
        b=MJGBsGOL1Vx5T6qgQDRTvsJIxInyquLyKVSC/qnMOScZrZcEgx4T2oqJ3WDUKdg5D9
         LDJD/LvJBtCmoPIMWA1s68nEMamgKE/2cMjfkqzTfAB1/etNNhRYdiK/f5yyB9Kbuj/O
         wnwOkY/5MhWTdpbUlxHOcoVoehgFqcVvZr8i+DfKwNBW1Hy/W40zJ0ADs7//MW4zsbji
         DcL/ZXLxFyZqBJ19Py/IxBnLrDf6HnMoZzHa2EdnOitvlsbJ/NSeQz4EJLNLfa7G64XI
         lyTgjxJlnWUZQ9X/hF/ggE4Dwrmaqe6Vo11E9l6VJtygoBuwUZ9desx3LNvinXdebafH
         ZUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150216; x=1789755016;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRIpRvEbMMuUyHQQxsZ0NfIJDkuNXQPXZTlmMz1Dzfo=;
        b=SmMFVG0B96iYuqMqWBAFcudxO8SDd2wDKkO8lkeVd/Av4TmqFT3Z5k0Kn5oyMwpY+k
         CoymIK1Tu4uE7AUpRzoPSdG++gFU3SQDndMRb5zuFG3YJR1a4v8SOWWkZSjdteI2w1fc
         DRAUNXMFqprVMf+b/NURmah1jGa85c79puOGpHPjey+7yG38ji7CACwLZLA0fw+cTqmW
         FNseclg1p9uxlUhIS/izeFxS9NW3mw7mLOXy/glxitVTSe0YEntepAxLkhli/HvutXMV
         sgcfkFJoiLpJTOa4/1hb2eUMeK4e7i85SMGwxwUYVJ0s/BD3E3U4kXXjNTQbPAts/5Ys
         oHFA==
X-Forwarded-Encrypted: i=1; AKwUvBxKj8kZXlj+/twRtREnZEBFxjv5CjnXwEcso/kX4B7Wv2jX84AF9ci7Idrt5HOoMqjHUAEzxfU=@vger.kernel.org
X-Gm-Message-State: AFuF++nZjvPkrHmjmIlYLNXLOEG8eDwLQrSCeSl89tfx2GGnsAn/4YaX
	5Etu1y7N5wJFQNv1QP5CEMelF3kn6ksdcqXgASfWWSQJHPUO0LrUBAD89nLKgzPpjPE82nGTm9e
	CQvmH5A==
X-Received: from pjdn62.prod.google.com ([2002:a17:90a:2cc4:b0:39d:a3ec:2af1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e50:b0:38e:9ef9:eb97
 with SMTP id 98e67ed59e1d1-39d9c1d8f30mr10349194a91.16.1789150215466; Fri, 11
 Sep 2026 11:10:15 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:10:14 -0700
In-Reply-To: <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Message-ID: <aqREBvLRKgD5cGgk@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, Jim Mattson wrote:
> On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > So, as an immediate set of changes, what if we do this over ~5 patches,=
 with patches
> > 1 and 2 tagged for stable@?
>=20
> By "we" here, you do mean the Royal "we," right?

Correct.

> I just want to confirm that you aren't expecting anything from me. :)

Do you happen to have a selftest for this?  Even if it's half-baked.  I'll =
take
anything you have, at this point I just want a way to test the changes.
