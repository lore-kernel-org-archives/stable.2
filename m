Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2E244692
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022133; cv=pass; b=NwZAORoBmRzBjD1KX56Ctbu1MbQ1u2CpAjugUQADegl1eUt+URfOgTCDF6XYpRtZ948Fa6SLWHK9/QHwZWazPbAt9qHFYmAjSIxpFffvojx2mOClUWaTP8gONtqdSlLSrAFeFp2Oq/zPyqTvCk/UK4V2Iy7WuUOrxMNKp473wbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022133; c=relaxed/simple;
	bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ano5L5bqqvCzZcQbWTqhHW2jtWfJeObmfaY6qCXfI1XEeSsWiwwQAgOkkV27/eKIoU11fEke2zDGnmfjoa/CFXY2D9yp4EGhHXRjqsvgVq3zY+3xATCBH6x/LIgIQrahSLfDgrROQMomzGk+8JYF0kBtGEhhbxizpXsAxjn9cSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LR51s+h8; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LR51s+h8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab97c86bdso115845ad.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022130; cv=none;
        d=google.com; s=arc-20260327;
        b=XSnewcQoe2DEBXwWEp+td7inVlYSdXhIRd9xkSeLY6yltsVvY3nkzt51g46m3ZAveh
         Di6qulfHX91RPjDAe2CXuARcK5ACsN0YNkVMXBLYDjnZ/ft/BflGp76yl65b526cr1nx
         fAGkD+FfSdOOdvLKfBotaJvENAR97UwXe7LvgywDkkcUvW0cBJQWDwI80q7WPCnJ35o2
         UUkYKG8B+aATqzEvkIbd9egyM2zm7FrkaWxw8pjsZTmcK0FMR/uy1qt3qthzpGwQmli1
         3bha5RAcrnIXL/ZJLYKEaXSIQBJ6VDrfDVKA2CzFsv8t2H9bRJilyvKFwU3Ndmunq7HO
         qFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        fh=f9+MTxoD91HDfQEl0I0cxiOmbLq25u8NMXKtt7Ek0NI=;
        b=GnIwk7ya2oPxN4DFd4WRjNy0VNwc30JoPibfvpNjr1Wyf+/xWufrszkPt895sghG61
         b6W9z9J6geup3CZxYvE1igKEBCm7fKaUVQ4kLISU7Tw6uMWIA0eAip+85EBs4+LlwIhW
         dP5ROMnb+Wfzlm6xmekz1t9lEopQepFjwNeG+esHi/Cxz5LW0/k7v2fXBFoe65l7xqVH
         88Cq8dHmeCPJMHm9MeV58sO64EcilNdIU5PSznUcZCkrHuSdm0qeE/Nxj2NOcM/cHGoJ
         PwB7etwFi+U45JmsPXsEPV0zKaTywZr+x/W9RJDWh7qeEGyPs0LL7bZO6PRtYUZdLgdt
         JBIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786022130; x=1786626930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        b=LR51s+h8/FKsUNHG6QycNXv/ZSVzMYJlkD37XrMoI9dTsZ5A6Nl2oHCDwWFPxNPCVN
         N0pC/AwK05TJuep8iiXpMLaB3cFQgXQ/EY5oaaNgyZBVOcg5xwGTlbhcHQ3QkhoMiVVq
         LZLJG/HbXFwdNZE/TEwZJaDtMQmxqTZiVgyswBkUZJgvCgqP3miAmfvZuXQRjA4R3LzL
         KHXkF7TWoRJcNa/CtIGF1lVBTBYfRlGbRvUmim0cnyLZqdxUOnahae53iXwt+bR0zyyL
         VlfUjhOMTl5pUn7cLAldctM6YqGqcCdwBE/yxaFUZiTS8LOUijByFpblAKapZYfMBkht
         tOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022130; x=1786626930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        b=prNpKeJz3/ffqAo2qy4lrO4N2lQUQh8xEX8fU8M1l9VkXUdQMIgQo17keJMWpSOIuh
         ppem/wsovgtgcecBCto1R3zUxZIeNlfuo74n9Xk9YRl2UyI8MKG1sKa7gVxusYqQbVPx
         s/D2jxNh1DztAGvnU2cNGoQK/rI3PLERLPpgR87BCw7zpLfPucfCgkRsHPGzB5o5TpRF
         MhnTMZI0a50oQEQQ8I5GRARos7bTU7SxizINlk0Rx05hEMewxi/V42Y9VtdyEEyMXV3Y
         R1YCG0Y0b3oGS6+homeDOKIJ99eVFeqLM0DVwor+Etji/VfGqw/bXQNHSuuy//v1KXtg
         TGTw==
X-Forwarded-Encrypted: i=1; AHgh+RpXl8sSbSBfQtSRCcgoHNn07jv/u04gDsgw5ZQZ1P85TVVFQEtQQX/GBATeLzpEozd5TN7cY5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9y9JMkgoWwEUp8Ya4iwjh35yZuAgZysXA58IcRAeJmZ7v1qp
	340NwH3HDlNoLEzZzBf/dUtVQbALfCtoZ8a+4DDXTtEelmwD1F5oUqANJgYMaOt858DM522MaJS
	KEIhCZji9X8ofJEZSrjTgD7ykYsB33xgCVltZpMDY
X-Gm-Gg: AR+sD10dLLs6lurAWzFEvYrL6KKhH7NnpwTnTRQ/b9IFJlhq4JME3plviiTqCZJyPHU
	OEMnei6cc8pfxuzkNLwjzHYaHrDzdQpVK3iPJvJgGKGRqXiHbLUVC5fvU/pXx4/uNJWmt8AHWNd
	l7lk95FCjAKOW6hHfFC8R+/sufF9jGpKPNWIQIOwfJsoIdluXi8y9luAcIS/G5nAQhNlBWb3tEB
	nZ+MRdLnSsaRcEipZDj4jwdhdLk8kNmONmku/s9tfjYBBZj7aE005ZMVPcH86L8KRRWooY6Hr5b
	n9GB92S0SuI2QiP74DR6F2YIORhZ3dG6+VOk6kHByMq9AG/zwXAKUp+oDlM6W3e0HqzvpCQ8Q47
	fA20ozunD+u6Ah6zZmXvahy1D5ATmX+uItL0gHwc4/w==
X-Received: by 2002:a17:903:1a0d:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2d0f55cf869mr6202385ad.5.1786022129037; Thu, 06 Aug 2026
 06:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com> <f13d94b4-2bd3-4737-b25f-bd5371189e62@canonical.com>
In-Reply-To: <f13d94b4-2bd3-4737-b25f-bd5371189e62@canonical.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 6 Aug 2026 15:14:52 +0200
X-Gm-Features: AUfX_mxjHccwhlBK-ZEwcRdt09EaFA_3UXxZXnpQMajQPSs8iZsc_fBXfIGTlTg
Message-ID: <CAG48ez3QfBZAQNG6K-rVmbkEtfJ9HtRs7MTrmNsKaoJLDVbnxg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>, Georgia Garcia <georgia.garcia@canonical.com>, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:02=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> Q. What do you think about making the callback_head part of the apparmor
> security task blob. It would increase its size, but allow us to drop
> the alloc/free. Generally profile is generally something that is relative=
ly
> rare, but when it does happen, its is quite common to have all the profil=
es
> being updated, so a thunder herd type problem.

It would waste a little bit of memory, and I'm not convinced that the
thundering herd would be an issue since allocation would only happen
when a task is running, and the allocation would go away at the end of
the syscall...

But yeah, I think that would make things simpler and avoid touching
task_work infrastructure, so I'll rework this.
