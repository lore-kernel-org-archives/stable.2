Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D737F339
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683255; cv=pass; b=bZDSg7h4rY4bXcK+xWwKZAI1s1uPTAxqzkSxol6G7kzGCgOPwqEb5LUjd0GNDGirqBLpxuHTWuQCLp07FS/N8VaZqqayy3F6yIGOWrv6eZJw8kXp2WxbCjZHie4nZ+NHPkldn1SrCkcYhYnyEuCQk09eH1MG/C2THW84wIll2oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683255; c=relaxed/simple;
	bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJaPDZ6Gvv2xDzxr0fQWPpQza3S8JBSEofZGTMs3TBjlGbWs9GWobGoUJ7bwr9PT1dfw2bgO9XxP5JyDLf3cC4/dTLRqX8XPk13CnLWNYs4rn4g+Ra0ocGE51YWDzvzapD05JEUHZBEN6M5wBeKSR8bZtByeHm/daUprtuTDpoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMHPjQwg; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMHPjQwg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a3ec9ef8d4so12176a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683251; cv=none;
        d=google.com; s=arc-20260327;
        b=jH/EF2PHhKxNwMOS7/YEQum+P6rkDEWyjoBSJRMf72aNHDW8kNSlhSot9XiV6ZbAXH
         j2AqapkNRRmsx4V8X6iWwK4+6r/RC8oTqcU3rupUda6uZWwgPVOB7ocwM3XrxKIeGukd
         vo80K/CYf/Jep/uOyBVynYf3jELcwqDBwlFqlHep4qaJDlbPp4ye/o3Dh2Mujzmo47D0
         IVQAZgj11Lv3MGj82a0ABHa9clTQ4OmZr0BqBFJnLIL1cm3hl4C85eOmnDhKcTQNKYDu
         hp/+LtFs6/fOIIHd0g+1gcDwdQ7r2dxXXrvsu2X4pW8BzUgXe20SRQqwHrfOh2Tu8bmU
         XooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        fh=lbF2RBie1l0o7bb0K95456yIjBpnX0xWzZitGi5bwXA=;
        b=MXWBeGfSbRdXDqZmJATvhL1w2HJAzOhNhS6wQzs0P3z+r4pqAiOLqEnFNU0l71ic3A
         FmPsZf5v5mF3IZeMXKZ8dT59OZZIZvDJnAAuMaborwMtZVC1k5s4AoRVn8lR3Lx3SR3f
         OGKbiZzPsQF08P2890Jq/6hCAjUeVIrc7aSnbF2nlp2lV37AA1sRJa1tJS3+gFedLhWf
         6vu9Bcfq2sjSvf4r0d5nlK8x2JSoe8dC2f6gTDlH5HOvACZteMr5VJ1dE45eUu3Fx2hB
         swRUiT1POoXmHpzIHzeehI5hf772koAfU3T/lqlH8Qbcgk9+EZSeoWW/ngXubnl8wa97
         N/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683251; x=1788288051; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        b=nMHPjQwg/Tc9TM1gAtXgxZ9idgVppuae/D++jetwnwuTayc5pTHXuEs3FMkDI3adOF
         gBvuQnxHTJmBmoGGjB0L1M+6isvZdU5fDAFjOw0Wn4cFMX6meotMP4IaZQreIsn6yfx/
         6cc2Kf+dRFMTzZ8ZcvUYmP/ZOD2I4BD2sqs9U7WxPWY7U0WEaW9hX6l89clzjjEf+4hP
         jdkwctf6yYmZhkrPRJtOe/Cg7uijNCNfyxpkvjHVyujwSzuiPjfFbAwj6www2JGccO/4
         eGF62KRn+pLaFXm+BXRwPjvBXQkWxCCqeh18gWs3cUsCJ1IonNCK3n2+h+DKZ86F2MhZ
         VJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683251; x=1788288051;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        b=XMtWfL3OhH05o14uREUUZHl3RVk8CbopyY3rh3BarNRS8RJQd8+ObqxpGWLtNjoNJW
         qDBlEYPKRwtwjh7FghJcmy/AgVQBmZWHUvMyrKmoFVqBXvahVzj8dRKXIRfAcV2w9kRg
         cxr+G7re/Py/wc9citZXZaW1Cp3WnaWnEQPS/J5bWRZtN6V+eHACtnZzMkRMwrcc2VKZ
         XuGeTIJUB+RLf+vIhIbNjX4KCkp1He5hLqlkaXbyzUBTXvWrX51QFihHfWYhuqfYONmq
         N1AM9Xkkf1ogxKTsdM1pUPD5TqC8myWZ56qBytkWa6bnuDWsXOtWueHr9xeVld7PjLWa
         lEsA==
X-Forwarded-Encrypted: i=1; AHgh+RqDjwNM2Z4AH1lUDMynUWRW1vzGbX/t5PehDyLxmJftRR6oKmV3qQ+8lbJqImaV3SN9TCd0Y/4=@vger.kernel.org
X-Gm-Message-State: AFuF++m6kc5rAxq0jsOTlh/eVPmYS//Ojc2hhOJCKA58zIz/+XiuiYKu
	pyaRSx2ARDnV8/mROV6o160LQLgJBw9UkDpEIjRArxyTf1tZHfTcM001h3/DA1Ky49xB8ge9YMT
	HndEYbHQ6huCps5FdE6CQqXu7LxpQJ9BBpl65LWLoCVct
X-Gm-Gg: AR+sD11cyP/DJUwzKbXW6MXxanbEtowkyg7raOO4a9UjIBopTNDQcCdrS4RGssx8+7G
	b/wZHYzv37zRLXFxfLVt8H8TCsy0jGu/KPNWhfv25HdwXx37jnm3aR4ob91oGvjbNOWfebwAK9v
	nKi76TNGoTjjGVJHopoDbcot9hjYkmUNUlZkQrn10s8JdFmZEVkiWaOv9KcRMDxrxQTWu+5F/OC
	HQpeMXTGTnJhpkynnH+CZzfzMIkmQRcqwyDIKtRlJyzAqKxnJksJhIFwf4/NZBXX8QU+brzjaLO
	Z2ClLe0rpkN6+ELLvbOEw2x7h8OafgpAjvJLhvVHPkpLDyTkEP1v4M81/ZLWDq3QQ6WsUOYBMlI
	=
X-Received: by 2002:a05:6402:254f:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a5df324b31mr685775a12.0.1787683251228; Tue, 25 Aug 2026
 11:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
 <aoyEMBz-SYLigbGp@google.com> <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
 <aoy8Y19RV_Dgm7Te@google.com> <78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com>
In-Reply-To: <78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:40:39 +0800
X-Gm-Features: AcwNN1VFyaoINwHFhJ9pgQfZFVn3Nk9TtsIN2dFauboqEZrJ71ScNpYuf0vLE4k
Message-ID: <CAAo+4rUbag3g+w3yK0OzLKPWDttQ_3KzsxAcxhPy7FsGqo+1Og@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for your review! I have just sent a v2 to fix as the way
suggested: https://lore.kernel.org/kvm/78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com/T/#t

Best regards,
Chengfeng
