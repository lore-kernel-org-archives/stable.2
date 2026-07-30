Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF03421EF8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422940; cv=pass; b=mJ3l0cnuOlv4eiE1QbCxnadNGwb2hKH9vAhyjDdK2CqeoGrSo/NDx7khaeyY53EvoeM11zyKJo2jbxFbNGqZuovVndrx8nHjsJBeVeoTwU3c9nu7+KKevo30qAw1bfoaWmNeWIDcidmNBT5SOygK4/1BOSpntxNM4XTeKwEThh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422940; c=relaxed/simple;
	bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYx7xHqMQE/7jNugL/mur0BSgX9/tkEVr/FRXmMPVkvE6KcGsOrssXVUOVR5EVRGhQOKHgNsa8SGBGp0NGatrgIgqwbhACt4JQdRYkzVocpxBl9u8NlbX1fBj/AP2YNonzyRby2EqujpId/pxQK5bQ8a01Y9OJ9YTsa+SlAAJj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCTUrqX+; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCTUrqX+"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ee125ec926so1357943a34.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 07:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785422937; cv=none;
        d=google.com; s=arc-20260327;
        b=ljubAFYoBSSJZxsUIqN2MRSGjm1XCfXgVA1KawXNeGemfpd2SUVKqawgXzebcpelnR
         +ocdW6RFApO2oZhniXazhTDH07QVlV+OCokU251TSnL9WTka6TyQYPfdCMZEWALxXpvc
         Q1Iphjba2bhhqRnqUq370o2sjYVqjdFSO+jC3wH9tLy0SGl0SdKVStlMwz/DrsVaPYAi
         PU74CAmqbn4xEisN8k9O1D0PtQUQkL1yfxEyHHfbg5+N6Z6TYbkwGbcBFhqJQ97hTkFZ
         KwgZrpm/qcowE0nuS0bNsB24OoLofTuvAIzWHn8bnztmWd16XCCA1Hil5E/69UgnfVuZ
         YJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
        fh=43LSyM3IdD1Odo4INA2pXS1zQlU+QTFWMqSgBYF3K0M=;
        b=HxjylNNmpRKCORQzyN7McvNutMVqcFsYIvJ6CJFOj4JpU6jDtF81/w5A7KcZSxWSSA
         jmYwiJWP7zuMZNvopjk5rUVvLuQO7A1Ca/aumYllgDxHB0w66ObVHQFvtlD1cJ6KIACG
         HVVX3vY0hM0eS9QTjrhgkLdCmg5wv+PSf3maiwdQ4NZvIgU7K2bMzAi9cJ/t8zcyfO/K
         KQXMuN3KOlp9OUq01vUTJxoKoK7puXWvxpGP3HJFw+nryXqjZH5Gc7C4h5L+edNASTvI
         Jblrz30jTYJHJn0kGOJTMPaUEZXZmtkYLMm6TKHp0z36nfO0nfS5V9kg+5YgxN80yfRT
         WVSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785422937; x=1786027737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
        b=kCTUrqX+ZchT/3MVrYoJ9R9kfcSxEk1lezzSK/0e/92l4Gshw4uiyNv3ApJW9raHVf
         G8XwAABD67gTNWZCQMgjogQngQlG6pOSw1N5rOVQ422vA5i9DGEjOpJrmTo2BY9Ugbpy
         w08mDC2uQSJBlAlaFjMJhHK9fDeJD1cdscSRcJQTck+YI2mdMFSrX9c9JW7xbA3KgCCp
         NTFTEI2fx9kET6Nt0itUtWsufNTD3BB7mw2eYR9trjWpWLUvJCBU34Wb3F7KBJayTp7d
         WlJ6+uXQbG9Hq/FoiC/CL91eQcySZqyPmtfO2PfXUv2lHN4iWVi4AjU/5nWW4XOpuQKv
         sGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422937; x=1786027737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
        b=I+csHAPE8KThWAWkccxigmRIEIgg5qiwZaCjWITGgfRGiM6Snm6kcmqy+Gc2aaOW09
         nbUVYNXXy+QRUqqNUAdsrTd47CGm5wty1/nUBlk+Tk9aYUOa/2/A7Mq3ioWm+bUegzJ+
         iM32kTA4AlDLrzCnHPstjO7sXaj6HMj9RZnkR50IT26AMqUXiUM/QFmegm06OHOndYGX
         VEMTETokIHz/L5+4bsz5Sd/7/MjCEwA6JglmGxmdaMypYRkNysPg6g7xI/xCZOSqx7ZL
         HBbTfPPcHCVqBQ77BzCVdbtFDkPhlrsIzdUt8Zcz49SXi/5TTf7eeXm19CH9Mvo4UlyJ
         O4EQ==
X-Forwarded-Encrypted: i=1; AHgh+RoW37qVt4zZGimvTVjm13dV3SOLVp1RxfFp9d8kKSmvzg4otKx1+OhZslvH7CQqvDTSauEsWQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lwlgI/crG+DIWNBkOVzL3lc98kLM5+CdqTcb1bytRGj9H9Ly
	M4wFPnIzYd2C9t3pH9q92tTyxYN2dMJU4JOknh38w9zQXUgXzWHsqmDEDXIMi27P6HGhemiBFIE
	OI7Ady+QRrJS2DGaGVnVpAPsfo80Qvps=
X-Gm-Gg: AR+sD133BaRJndnz5LL2QyyDRwHJgflTpw3CLLTzHWj7CrAixVqsS8hiF/9GRrtXUI2
	Y9TCjqAWPU/aeclP3SbE4aoSXcKrTZ0XCUjX8mVwv/6Qb8aUIOLT2Eesr7Nv2gmgd85v7Naip9B
	VQoYacfVXqPTNw938mgVr7IBnU1Sp4XrhDVP1F7G5h09OEY08xYKCGvtmP/akEnvyJ/UYx8ftpf
	C/hMB1E5Pz3iJGhvn6GEr9LtsuEAFf687CRNgeiGH9tFnSHdfxFWDfV7R84Pdpayyd0xO/qxKfK
	Tg2rd6Pl6LSSRsCj8mdDIqziU4Umn0eFJ4TObgGdqxE+qw==
X-Received: by 2002:a05:6830:4983:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-7f03925069cmr647058a34.1.1785422937495; Thu, 30 Jul 2026
 07:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
 <20260723221910.85822-3-vitaly.prosyak@amd.com> <69043022-b215-43f4-87ff-71c52d999021@amd.com>
In-Reply-To: <69043022-b215-43f4-87ff-71c52d999021@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 30 Jul 2026 19:48:46 +0500
X-Gm-Features: AUfX_mwtO2881UT71vQP47iS7hve9V6LOCsE0Uggw8r4-1ND3LkHP3IzqD8kFhU
Message-ID: <CABXGCsPXb9zZA3U8XmPsx_Es8E_6M4w8SBNUC1_oQ_Qig1hYpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:35=E2=80=AFPM Arunpravin Paneer Selvam
<arunpravin.paneerselvam@amd.com> wrote:
>
> The fs_reclaim class is already registered by the core kernel on the
> first GFP_KERNEL allocation,
> well before amdgpu_lockdep_init() runs. Is it kept on purpose, or can it
> be dropped?.
>
> Otherwise:
> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

You are right, and it goes a bit further: the class is registered before an=
y
module init runs. Every GFP_KERNEL allocation goes through might_alloc(), w=
hich
does exactly this fs_reclaim_acquire()/fs_reclaim_release() pair, so the cl=
ass
is registered on the first such allocation in early boot. Registration is
idempotent and its order carries no meaning for lockdep (only edges do), so=
 the
pair here adds nothing.

So it is a no-op and dropping it is functionally identical. Data point: my
original patch did exactly that, and with the pair removed the reproducer n=
o
longer triggers the splat and lockdep stays active for the whole boot.

Keeping it does look deliberate rather than accidental, though: in the v1
thread Christian asked for the annotation to be moved outside the notifier =
lock
rather than removed, and mentioned pending work on the VM eviction lock whi=
ch
has a similar fs_reclaim ordering problem. So whether to drop it is a call =
for
Christian and Vitaly rather than a technical question.

--=20
Best Regards,
Mike Gavrilov.
