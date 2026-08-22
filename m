Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F324DCF9
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411800; cv=pass; b=pxe+8L2R/nP29ppGj/JE2yD06dnjlfTMTFuOHD5jMZsdyQQV5t/m5avQ/3YY82a22xUaTKH8RyJGyTnpTZwEFDFz8NDjkYo/sNpH1YaIxjR1QBsR5SoSNmkss0rvNTPhPA+lLHYtXv68bTLPVkNsKfb7TrC/qvL9HdCeoy38TSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411800; c=relaxed/simple;
	bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPDNRQRuZFvoaAp7piKJdonm+OoWjiB3qO5ebJA4c6M2yag3HeJcYcSNXI/8CcBLgk+SCoEWRbYevMrIfJM8Nv747QojIegxWwW8rkW1ogjfLc/Dl0wNVGFrK96lYl4hZ5NqXZf7A+YCp8BIHTfxElH6VmQLluuiZnZHCjaPAcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVAm84wZ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVAm84wZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so345226a12.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 08:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787411797; cv=none;
        d=google.com; s=arc-20260327;
        b=hZFblVpIiYtoOR6fCicYZppDG3G0HFsSshOyIA3cGDvkdtOhI5XnwCmeIlpy3Nd9tu
         AZ8q45tZygXYXVazeCHA4eC9fdsi8z4j6oiX/p/2ePlr0cBGXzUGnY1RC5lBkqOK1k8I
         i5bbXqIOzeK86YhVw0+yVljxuiLUh6k4kQZGZVyM4eaQSrYmJPrOtx9Pvu7rOomp+rqj
         GbaQPrUPWF+JJXE/1z63ZAqe7j5i9Hvlwaf6Nw6Mys0FiR6lpeRARqT50BGMxJn2ZCSH
         Z2fG/exiUXpPTkP38+bbPlfakwk3Fbd5xMnSWTxAHgHSnXResXfHKX65NqJr10n+vTo8
         95Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        fh=8JoaHba4BmbSn8yMtG02FfJwHNPrpwAv4+71Ja5ayHE=;
        b=AB9h5Q4qOKGFWXMZGScS706m52nhCVfMHt/hK8yU3c0kqgdRfnCBzStO4WVoOg95R0
         xVcY+Fxq0iP/JlmsyB2e1hp/eh/h5tNVggn1ufbHbYSeOB4Ya7bQqzTK5Rg0u+hJ41sy
         wVVNs0XzqYmmn63YWfXV6DCYBn4lsNajWTNlpS/hSianEYxnXh0yXjgFr6UL4lI5lHMH
         1ium48oJ1frLa7wa7BgnFEGC5sGcrBGNWC8rN+ViBNq6LJwSlI/lwKURGUUGLlvjeii3
         L0ipfKdI9c64hQk9XqzGwVcKevkZfk0qxNpCkZvvdz5JBAky0O5womgd66hiUCGL03Dt
         RvHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411797; x=1788016597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        b=pVAm84wZmrJwlyiX8tS5hiV+64Xg3VQ+RalyggtWA2yMrbTJhBD2lGZfiLIcb4qRJq
         QQwyHS9vVIz2aR1ZzWjug8swTtKGLWt/dloN8uMJ+vT9G5pSkstB2+aKGpcWM6CCMVVH
         sxERNyIpxxyB76VQqEMIzpU0B3peFOScatQUwU7qsYa04BB5DS8Mw3jK/G0By2sj33Lk
         rja5id5rJnlkl8ANFuOkBtDNVifpvtgM46JGBx3sGfduOwbe0Ji7takJGa4AcffTrNWg
         6mbn6/aHKexxgSk2nRjKc9KqyGftB1kcsEj4dI3wHp9R3lTeOhJ6IMM7FdRAVnaXdrTg
         txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411797; x=1788016597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        b=TSgL+4UyyFvkdwOAnT4utaFiFo3QS33sxLfcpV0cXWFVcn2YBSYt4fg5ixuYGHPj73
         MPRWeCwqkY4ob6YWjDKt2rZBAU34Z8jmLch1cXXW2NAIOqlmDGDcZX9/XhYydxV9kqDx
         TqjbeUfr+QspQMwxMKvj8Wq+bCPWogb2syDA27wBj0xEfJOhKmAsDKMYjIgfkDI/fxgC
         YdRaQIe52g8LfIIJ8dMfIHJG4rNsJAXp0fQak5RhfB+gC9AwkF8dOX5FCjdaMhobF4d2
         vo7Etny8MSaAoxTm0A6NQuvLnP2t1kaqtT5nJwSY+blaMy3XsI+Zves1RM3kj9OQEBCF
         SaXA==
X-Forwarded-Encrypted: i=1; AHgh+RrBaV9EcskDh0YuzkdSblAfErWkN+eFPizumTB+bpB5WgGY3QT2ZFQxe4zm4Rex6B0ej0xSGxo=@vger.kernel.org
X-Gm-Message-State: AFuF++kE0gBBoQBxIMJzeBDXtCoVypWCHrnQpecw0Yr/hmO+AZ8Mxlgl
	kBKLR9XeLMWs43bh/be85VRO7tZwjcoyfIheFSdDt6xs7+k4seRDtM3RRoXT+Gs4MgDsniBOEoM
	FDAvTIHyQ0y+ye8pja1yAUBbE7EM1zN4=
X-Gm-Gg: AR+sD10tyiR8oAUNiZtAMROlLGWWNMJvDFK+4P6VKcIew3VQ2K2u6jfPUuN3Mra3DTq
	EoB6NtRg+o0sGVoaH7M/AwdU9uhwkF0Gz8ZvlsGt1UFSth/Em9twyJ9LbUI4F6dw0+2Y+yCWlJV
	WC+oo1NHsRAIeXrIIjCR8TycOJ8FsqeM7SNEX8n4OGHLbq+74LFhaSz7tAPpYo/vJaYzRQqk4dd
	aZWO+kYeE36EvLhGPRONlOcAk2TYRAsEMLn2udFgm3SSvbQ/nlnohU4cqzyqZaZX0puXJ14GwmU
	4Zrgle8gwZTglSINjE3rFUG+D9CkPA4ifLHZwZY5/QI5eMsYRVCdOgGVy6VAnXe1RojZbvPNag=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr8149275a12.2.1787411797281; Sat, 22 Aug 2026
 08:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
 <CAAo+4rUJomK9jJ6nHC6LU0AHiR0LhO_Wwp4-Z8iJOo=Za1JR2g@mail.gmail.com> <20260822083054.913656-1-ali@iusegentoo.com>
In-Reply-To: <20260822083054.913656-1-ali@iusegentoo.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 22 Aug 2026 23:16:25 +0800
X-Gm-Features: AcwNN1WNrizOShYdt95GyUZ5UOsmbuiQCjNYS5AmdMYaJmyfyAXxqJ-2vGOXJh4
Message-ID: <CAAo+4rUi3o=sTx_ZjD32qYWoYm_EcFv9UZsSeCFaL=oQM6vBTQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Jiale Yao <yaojiale02@163.com>, 
	SeungJu Cheon <suunj1331@gmail.com>, Tim Bird <tim.bird@sony.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for your review and feedback, the v2 is just sent:
https://lore.kernel.org/linux-bluetooth/20260822150619.3684599-1-nicoyip.de=
v@gmail.com/T/#u

On Sat, Aug 22, 2026 at 4:31=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
> rfcomm_security_cfm() -> rfcomm_session_get() is the one I'd worry about.
> It runs from the hci_cb callback with only hci_cb_list_lock held, while
> krfcommd can free the same session under rfcomm_mutex. I haven't tried to
> reproduce that one.

You are right on that, actually I have a reproducer for that UAF and
just have not yet been able to send a patch for it as I am afraid
sending too many patches in a short period will introduce a high
review workload. That one is a real security issue as it can be
reachable from unprivileged users, as it is now raised in the public
maillist, I will send a patch for it soon.

Best regards,
Chengfeng
