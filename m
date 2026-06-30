Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD763F2117
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817318; cv=pass; b=W4SJ6Jv4hzHw7Zz3hhgcM7IGTKGYB8EFyZ8pw/lKZRCqBITwAC7hp4Q1fPCRHY/KFDUuZ2UpkrOObjDQliWyxbXQZ+DG6iRmb60UdACNezv9wdOb1ZN2Q5fjVsY1VOwG8nXws/2cTkFA+YtWlmc4dUdyE+9P3Gw3fxuOX/KvfCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817318; c=relaxed/simple;
	bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f79FBm3oVFEpabHBh4IGj/0vgaTvySr23xGvykc+5bxP2XpqThlPmuEiRn4EvyZaNx2RIEXgtja2VpfYIQEyjzVS7McOFTEZYsLkrPEkhQO41KmHc+nXkchCwf5AWUzpi8v3HhvtxHU3GC5sKiT4foWOd/yS88rLu2YYCV5whv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/cOEk4; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/cOEk4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so7131636a12.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817315; cv=none;
        d=google.com; s=arc-20260327;
        b=MW2edXpg4L5BD4hnyAQRWPTUZbUnazn+77MNa5iyKynUq+erKJYaZEGR6exvWXxMUf
         dWP/jITLTLKoAHsqLHsgwrgk0za6WbepKzEUEuSjy6Y7K7lond8jpOA8OrXM1Xpbshwc
         wiAA36sNRJJikZGWzDp8KlkdlbTP3lMXRwFjSE5NOVt6mu118TNqTvDhz4tUIkq5yfxd
         4pC2rOydAR3kfscBbfbhblTsywNLNSA1fsa+EhfWBpmmN2aQDvUYz/LTLi3hWRjlzUUk
         kjgYaLDLu87E0iMKisnVag9ODDC2T6xva6Z3EQ9EU8ySXlJgojmO9l9H9CGaoCSCNtpD
         yFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        fh=+M5V36peYborbfJ/xg1BrBWDjC/9zbq4RZEjsjCgv2w=;
        b=J4r2xs9rm+kr2XHFyzSVXBdNDtT0xGSP0XGZ+6l25a48mSuauUPZeCcb3d9GSABPhq
         9ZZ5kqatxKFd9GyWkZRu29ChyaAW1FVVbeOSiMtZ27K3B38y7A6ii7ts3mOYRr/Hle7s
         LUD7laIe2NfgbfTjJTrnDuU76+48JqWrlm6vUHtcM2RWK4+7SBA+7R6w7njd55Ue7S2r
         B93spORJu071OpnmsJSGhFimhj6HlB083feE/7g5LT0xOVG1Bz3kc1K9+HaTdW0CGupC
         PuTvBIgSsjKYYtCt091xGa1wdRa+kS1PCXgCdDmvy2e0J+m6mC4zJ4c88uUthyDGHxnm
         4pDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817315; x=1783422115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=Vh/cOEk41rYPNWUDRzL9fV6pGiGys+jgYv56yyVM5YLQG+CQ6HAz8bjg+2yhOi6Z0R
         HX5dq5MjKkDCK0F0V42AmSr9XYvoGMwSY8++X6KpGHvfsB59EyMe/afP90eBPd6RVRuU
         L7n25ctS5VPtXZFXOSehyvn8hizxq6TuElNJX8Iqm3lyuU2vWeZaWZSlzFn+po0im++h
         6dXOnUDzBwgqXpKdQxQeR6rYoXT3d9Jo00Fe2t0MpjfrJ99DhicDwTRG2/Uz1zEh9e4R
         eR7AWSSH51CU2MO3xvGY9EF+7aN4NbA4bV/dCilNCPOg4BUfkwmVFQbMOtZGFMCByYKP
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817315; x=1783422115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=jkgZRoi1iK2fMlO+8bdNmNojDii9SV2LT4JSkNJjr0VdTovRFMty1e2hoAOVX7PQ/M
         CmsawRxnzU1wVW3ak2d9N6qU2Q+H7dTYNlvKX8gv5ohihLyBgyyq/05CCvfO+6JLlwlJ
         aQ2GS68EcxZw+W/csloRtkCPFGMMguhm3onxD5apkN7g8NIA0+tZbhp4M+X2oyMCylF9
         TlyChEU8t3I4E/DFjbIa6d8VTvGopjQmRssCsKh1tUbIZtd9KCD85Wv/PEgy97asXLoj
         zxieGbMlCXVtnWFZ3touP5wRRrC96WIfC2ULs2LNxcOmRWNGyUp3ips8/mHYRiNuw3eu
         8akA==
X-Forwarded-Encrypted: i=1; AHgh+Rqxwh48fAdbo0/nl0JEHt7PbdwBltXX60ggvXQvtSjXmFICkRd7vNcxmTPyuXpCsOkc97wYJEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIkRX8F4O8JdyO1JcNKl+F0tm+mGMLN4SzL5QuIuKdirpxA9B
	mZhDwKlryd9h1eGJa3IgbZbTuYixXsYjZH1Xq6I1bxjwJfzfIxxeH+olNb5Civ79Dg78nskuina
	lN5VukKhf2XXx1zxbYFJEocGriG2oJw8=
X-Gm-Gg: AfdE7cnmQABI3TxjBiRoJnORgMuRMTa4+bXVvPPiLqGhDNMz5dHGFBVlm313+GIi/7x
	rJanjy5MSOn1oMosKqumegI/ZXEkcp+lmcPts1T4QwtxoH0NXAiA1xwK/GD3maxsIk7YxY+T1Jg
	JMuBsvn/vRxpFDg8ul81Gdetb8ghZwHVfTfJhAfEY9inPvT+qUhwJGMBq2i0HgeXjmNUFI/iDrt
	aN2PXWJpCYhIUrDgGDwlqXS+L6WQngLO7WJugTOp7gtGk1ljmtyEi2DBmQqJeFV8zVNG/okJ4aJ
	16b5h88+o/29b4wfYtv2g/FpWK+Hv0g=
X-Received: by 2002:a05:6402:5248:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-6988789244bmr120235a12.19.1782817314715; Tue, 30 Jun 2026
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com> <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
In-Reply-To: <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 13:01:43 +0200
X-Gm-Features: AVVi8CeRSS7JXqOJC8_jFJY-F8O-_1zMcUusRfzqJnniatTSJdpzkrHWbWs8ruQ
Message-ID: <CAOQ4uxh4-LYt8VUW5o+0mMrHpnZm3t8k4WD6x2kRqEj=_ZpLOA@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:06=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> Thank you for your reply. Regarding the two points of feedback:
>
> First, 6.1 is still in the process of being adapted.

So do not propose for 5.10 please.

>
> Second, this patch set is primarily intended to fix CVE-2026-46054, but
> it seems that for lower versions to implement SELinux checks for overlay
> mmap/mprotect checks, some dependencies are unavoidable. In such cases,
> should we add more tests to reduce the risk and integrate the changes,
> or should we simply not fix this issue? If more tests are needed, are
> there any recommended test suites?

I have concerns.
The burdn of proof is on you.

Thanks,
Amir.
