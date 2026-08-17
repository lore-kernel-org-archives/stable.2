Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019E2C3261
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942304; cv=pass; b=ONW5biuoAsBptLOxuoIyaFPDcacOD2YKcqr0hYDpNAXudbiAZCCVtIh39KRAtl6su+NCeVxju8jN2zvPOSjEIcvhbuQxjgW8WTJjPrCxyKgcYgSV8v+4uEP2VG8S6AFJeDfwvoJXnPtXNcUwH2YBb3B3BGFevMooeiee8gmOtCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942304; c=relaxed/simple;
	bh=ZZJdG+OeC01Wr7mI7deZWIwr453xg2+VAmFfuU7xqPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6uJAuekylQNfi8z0vrqEzTYMAk1OAuUt9QKneDtuPmQ0/E5O6iYvlvM26I/p1SL1j9vuP7GnCpErYp9+VBNWLzb4ZlepqYwAQIkMgZQjmESpj0nLQbJaiVVmzyx9ybJhh34T/eIg9TQxd5y73WVz8G88w4WYdQAzbs7cTJ99h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=hIiGX+5h; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hIiGX+5h"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a1c7ce59dso519814a12.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 21:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786942299; cv=none;
        d=google.com; s=arc-20260327;
        b=Owliy63bYjjq+dd2K39qXRvJBeBMu59SsULR7TCefhQugPIakJUyXr5EfmnBdmesHV
         xZQPEk9izzuidT5R8kJW0qfqmVNBGWyGY4RsJjr1TbMx2gwFNNzD1Q8+yfiowsI+52YS
         tdyjiseB/sKKW3/c085VihkBKsz329cyMZhC4/JA7RXTHTzpGzPpQ1LvGJ1NjkyIE30+
         tgsw1TeD52t86ZLcmXYNxuHY4pG6fIm7QXD8pkuaGZlBTFPKd4k7bOIREsVGw3dva9qT
         P10yqrOw3NvIwqNypJ6yRIVAzXXKCyMRMB8U1Es1H+s/Ak7a6LifNXWWOtZX1oQG2yzA
         t17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZJdG+OeC01Wr7mI7deZWIwr453xg2+VAmFfuU7xqPQ=;
        fh=AP17nW2M1ITie9oCbdy8Fq85lqSnpiQMVEx4qP6mdm8=;
        b=jFR8uqtYW+ppJGkXoiYvYs9rGTgY4Eu7FgFOz/HCYcmDHB35LYst/H4SG6uPA+XTk4
         Df4dqQJoyTA1SyB0KWkFL4cNUcIM9G7hisbnOcgyZH0b53c5GemFcP/bCSJsZE7bidi9
         3iFhC+9JkTP5YXqap7wkMpPnTlW/dhVGozEOWY2VJdsL8eyiknY0KAE356K4v2XiOuiG
         BnBJHvdCHnfDleDzFEvCeLPhWf8uxga+lgVSjyB3wpGsmzHGzjVdjVvEW3gv5qr5KFoq
         fCPlVubeZR0VfCSIODefg8fQTnJ2LIqWy9SaWW9DEgeOFpBlcDkTgUxQh+Wk8J+QVyKQ
         la/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1786942299; x=1787547099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZJdG+OeC01Wr7mI7deZWIwr453xg2+VAmFfuU7xqPQ=;
        b=hIiGX+5hEucp+LwdvvRoKsxHQdH2UKunStkbbyt18tUoGmixJFA0iJmDTuMRZYaym4
         0MLIK09CUH+RfXPUtso1CLebySNud8Y0hdjBHXytxt9NV9F5vV1ROqMjwHo8zcwDFG9J
         URG8ABEQ+zlRApyxVOUOIGYrX8IRNuot+dSd/mMlEOlPIGWuwpVdkugyi/6v5foMFLAp
         SSvjjB3cdyG3Cr3vS+j1Rp9aU5Sb7cw67A3OpcGXvUB4+G9BGCMtDLTROOgTX9xvSDQB
         dOtwjQSFdc3MeMqjGEIf03EFAzAZlEWKAy7ybvvypjdIJTwVrIGsT8mf8lIcgwuwjpQq
         fQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942299; x=1787547099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZJdG+OeC01Wr7mI7deZWIwr453xg2+VAmFfuU7xqPQ=;
        b=rb4YQgutsHguKno2YxLd91PkCdYLrK+5PbjfxYzCFZJP72tAICVF9G5I8YQCWVp9dw
         3fNacsBbsPnIxN/qjUkfPDJp2uD8NtdV6cSmcqioT50iJy/fOIoJlD+5fTTZeU7Z8t2r
         TGJJwEKu91tHeIiCmgi5i0x4W+Nz7ulUA2QJR7aHkufihBXunrgHNrS2OVQkNVKjEPxX
         0TKnE4DV7IwgYxy11hyYl5qn9iwZ8H/omIJ8P7NQhAiCbeQ1AMcwgWoWWJMMIsz4PQW/
         XCIJ5pWyGgv8PJEsSfedkWobioHurLItH5bhf6e35EI9F0q4bilZCBJ/AB7+ooUpgZl0
         Lxgg==
X-Forwarded-Encrypted: i=1; AHgh+RrAqhPhC5TIOb7/wJJNsEq5v7CBNULT59dI7mWXSIYtNlnbIusv4jMi8gOqE1qwHfP31U+q4vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVbhPfH1qMwFzochiBrRuIr4yTo/2ORG1umwk7luJM/i9s8+Z
	9ldsVI3fQ1v6yBMjhrjiePlQzHZZfCHzGl56hONuiPtzCocZU1L2KWejYHZdV6967MtUIOlk/lE
	peGAJU1PpjP5fe5IGL2EVUJsOIT/uFVwVVk/JujU8NA==
X-Gm-Gg: AR+sD11v/DtdxPrgLs3RgOqnxaGIpv3DOFznb9WUrYfjdEzlAkbs3ljodbevrv/x6hu
	EgRednLPbPuMIf6rnKe7fLVuToWeKzwYWO307vh982DbCccA0fTUKXgBl9lj8c8XsiqUo5VZ/sx
	YXGGOYXav9oVhvl864dwfoErXO0PRZm7uKBcnS9kfxN1cxuyycu/tV1tNmhHsQSFV62cRBe5HhB
	tOhc15sNxH062qBSUSiiJlkfSIkNxyDfb44zISvL/VeqVulmHMKD2DnqCw0j7LaXfjXB/pp9ztW
	xIKZ6G8CdIPisLeHGDMGGT3UePva1u7xBDlR/EcDJHXHV2aQ0NtHtKeJeO7CY2dVQHLlipQWNNc
	6mxs/12Pi58ZjNg==
X-Received: by 2002:a17:907:7b9e:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c212a309036mr502756866b.4.1786942299588; Sun, 16 Aug 2026
 21:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814100652.225499-1-jinpu.wang@ionos.com> <20260814193000.15@kernel.org>
In-Reply-To: <20260814193000.15@kernel.org>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 17 Aug 2026 06:51:27 +0200
X-Gm-Features: AcwNN1XyIGL-uE6EPwQFBbRHf0EenJ_HR-hnqXSyl9cmFMctnH4Zn-lZqPDF51Y
Message-ID: <CAMGffEk4a8cF4utrMYpNvbcxBvuEhPnTY33_3GGs3RU4uy52vw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP
 platform-init dependency + 2 bugfixes
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	dmitrii.omelchenko@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 4:33=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
> > ("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), already
> > queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
> > dropped SEV/SNP platform init from the CCP driver's probe path,
> > expecting KVM to take over, but the counterpart commits that give KVM
> > that responsibility were never queued alongside it.
>
> Queued the series for 6.12, thanks.
>
> --
> Thanks,
> Sasha
Hi Sasha,

Thanks for queueing the series.

It might be worth adding a rule for the stable-kernel scripts to
ensure they don't pick a single patch from the middle of an upstream
patchset. This could help prevent future regressions like this one,
where a commit dropped functionality in anticipation of a counterpart
commit that was left behind.

Thanks,
J
