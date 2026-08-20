Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565E44470A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229893; cv=pass; b=oLD8Oun767VLmoaf1L7EL0ZwBQ4e5FlipB2opEr+PutVCXhQOF9Fs4I3kMpwpGrKCwryMoac1NebZ0iPqEnPlOHE5SuzFl5IhP3vl3Dnhev/zC4hdZDwbxvnov5L6FbqJRaLGpNxtQ3cQoytsw4fBW20GjZNbls8XvNzZ4Wn/es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229893; c=relaxed/simple;
	bh=jyI+Vm3mGeNC+CYypb2gorBot+HaAXIcwYJlcWBJM88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaV6ofhn8mHxxywPJesttNp3/2SqQm8UAgLTsR1s1cFdbof6RC5OT6FYBtwUKMnrcwCGvaMvcKlGX/fw2Y90BgZvWOcGWy8IytCzXa+spLC5wtYiVAAoi/hPnYnWfOGOsVbIHShU/VwHBEBAUQgaaTD5ic1o//6MoWVDhVxQOBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAxyWhTW; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAxyWhTW"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b145a9623fso696341eaf.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229891; cv=none;
        d=google.com; s=arc-20260327;
        b=as5moqy3ieo0KrVWYrZJkkEFyI1vzimnCRTQzuUHoSShtZQEq9tSTxPobTIKaXnKlW
         yFHGbGZgJTGkw8gXzNmhiFZGqgVSVtdhDRIHxFnpJ36uEEGgVjqgSo96tKq2duR7keaN
         0slqQU7z/d3Fgy2PkT8DQ7QH61i1CNU0hBDuMXtmYJHcyr9TZuVxjPtR+2BFXmRlMlZp
         sKmRbTmbn6jcBC0qswvdB1HRXrphm7a8zW/1kIqQkdb3qmHt9+ScCXAdIpbKeqcmEKYP
         8PRiDWNioveGIaoZBnMn4XN6DPS/qgCeTopPnUFYovGF69Oc7q7ydCxe0JKDZYz5uQbz
         c46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        fh=S13mXS6o0RdSRB6nPHjwlZiBjqt9FRQPX0uyT2b3+l8=;
        b=T2BIFgxtSpVVfs5BDMJONggrQbNwaUesRKbslE6Zc8Te5v3sizqrP6RR7Kqgi4dZt9
         CNB29GyzUTMWk6MO8LUsntNCyN4tq5TFKSer+2Ug2KDl0PzkXUzMfFuEyhQg/1OaEgfK
         9RmAk2rwxUubJPxudwRbG7e0DbVdWCIqgcZwgdDvoOVyxtxbTwlC49FU9D0NtRxbHIDC
         oj6eVFMg5RdoEJ+Qv2/JMroOCsTBIYJdjyeBUE2Lr5PSW+95RTw0UQJrg4UruomDBP9o
         a038zdhU/Nnro62+xbxqsLDinNub6rlnNcxrEkyoF09l1A1lK1V/C1RM18bBKeo/ROYd
         Io5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229891; x=1787834691; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        b=MAxyWhTWaK/Or5g1GbgjRdGn0s3+0ii7LnNjyIU8frtugWY/3VKtMVebgMVzEDerpq
         7EJ/Qj91cr+c7sJR9gpJtatdTeicAshfV+fWmKH8dp8dTarm6bjWXDIctUuuD1UyiiBs
         JeM+aJ9Xi+aQ5cK8RhNdp+v6PRSDqIDYuGBfJZBwL08U7Rb4wSCNddOIal+DDM1HzB+/
         h3ljUkBPNhGL5o8NBLQyK/aHfSIiO9qZup9v3R8ZdsZMUWcb+h2WjhV6gkd374l7mmyM
         qLmkO/lDetA82B1NA/JiVEZ3K6Jo87kv/JDgi6FB+07e3bcp4BzVZ1NRcWpAafbGpeEV
         Vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229891; x=1787834691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        b=W/dyn2C4+ihygrtRQ1eKoL1kJtq46L2oh+zhy2Qvu16gy4GZtmUHVtC4YG2r0zbe20
         sqaPZHLq9mFTcRLe8WSWX/LBVrJgL4/DckSJRmxff8lcTDmiRJVbxTXaBIPSSp2sRpDX
         7g9c/Uvsx1Rupi9Znv2k25ErYhrjA2vx3GqlHIk4NfsFURleDfeXWk9KorpL/Trpnlrs
         9hr9qTwc23M+zK5drk6Mi0RGawBiu9e/WvR1lYUgG+Nydzzp69cWT9NxjvWEJ7EoXTKc
         gEblGhSwXkreJGMfAHqPA4pi/zyS6xhhl94p9yxsZuzIz5qcJ9NY3TFvJV9U4Q2bgqLW
         oq0w==
X-Forwarded-Encrypted: i=1; AHgh+RrubPZQDKE06RB/7m39F9pVern/8c6K7wMmRhxim7JDiUyBgY9pTSM1EeD/MTpHrHTmsJjNA7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxqfKe6ong//zi2PZEMVhEZycFS5z9l1BS62uW2iXBFr9scb6
	YaFVuUuFLOxHrO3RcD/Gezpgw2GsxdjTl61OhxZWYiFuPmisPVyV54InN8v0VA8SWjvHN9Fhhdi
	L6ENyG35Mb5zPy/SByk7Sw8JilohXV78=
X-Gm-Gg: AR+sD13e5UGjOf1cd8/NurMOE7x8GYks/0dmw05kfu8caMlhwX0foIonyyppYFWOy+f
	yd7VrfXTAa/ao9U3/g6nRyK1jfo7i+vZEc60JkCX944UOlBOTzDeYRl5gdCYa47F4ykZud78+kO
	LngY11f1uHdIolQC+6zfvEp65tFZgR6iOqEEMDCAH1pSKjZUGRXYmQCYoV49nyXrQVo9cY4cTO+
	dUWA3FOpSX9fWWM4yUeVnPowImf4intR/x0F4oib5VsB3Cn1q8Nem4cHDNvPzO9CZ8qCuUljzcF
	NKfVuRxZ4qghoecdr6smq47qB2mrsKrXaqXXfFV4Wp1+PRPCkrdTx35xme/harwUWs0=
X-Received: by 2002:a05:6820:826:b0:6ae:4131:98c6 with SMTP id
 006d021491bc7-6b13c2b6003mr9891957eaf.2.1787229890930; Thu, 20 Aug 2026
 05:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Thu, 20 Aug 2026 20:44:38 +0800
X-Gm-Features: AcwNN1Wteh1s9B-jT-2PK7E4lRkFjXUss76ZtEM0zUoP7x-mJc2sfkp-dbD64ng
Message-ID: <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: seanjc@google.com
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"

+Cc Chao Gao

Sorry for the missed Cc.  The patch is at

https://lore.kernel.org/kvm/20260820123512.87236-1-duankeqiangcym@gmail.com/
