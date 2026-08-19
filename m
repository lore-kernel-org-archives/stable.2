Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695F3932F0
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787175700; cv=pass; b=E6Z6ME2oJsWQkjztnfFk7snNMQnGxhB5AytQERgFt/B25/X2/omMzYijFmmRZFlKKkIKfLEmDJvRCW7AWkaqll2UTRSAQ+anVlrQJyp9KYos3Na7ytn83lOSxUjeN7Pl2NBBn1BLMh7idxpTMqJZMXAHoGdGGAaI28mSKNPaxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787175700; c=relaxed/simple;
	bh=zRF25KctlM4Q5WNhaaIrw/jFuHsFhpQlaOY6X8ea/hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPQv0VNBOaGUkkd5FbsG1BbGqp0LxaGJ3RbIVmjS1DrHT/o1KstP753+HmqHCaLaALxZ3FTL62Dv5pIMRTY/CZkzIOunfo6/Y9wmiAzgGwTbXFZn+Qi2ZWl1Mja7WecfYNRjphgT/yyCdCVZCVfX+k9KzZ/vBG8hOdviPK+h12w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwOpF3JL; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwOpF3JL"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b128dd0cb1so1156957eaf.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787175698; cv=none;
        d=google.com; s=arc-20260327;
        b=NQqi7MVQCIrDcRKMEvY/cw9S4FdLJSNQFbYrIA6ierL6CD0YygsZajRkaiosKjpsaR
         KZZi2AGtyT+IwEIPa4tWQ7jCfFw7LlLjc6ltaNHcCCPNIBQwHme0LxKdo2xjtjbRAtkF
         DVi7iDcM4LYaYMnjMBt5AnupJyrGnMFFdZfYO4aPCREUyp63ra4nPZ5QHfMY+R1pW/TE
         ikbqKodV5Tw3QRI+rNuH+ZhtvkemJH83Vbv8gNO3ST0NXQPSfYtQO1RDBhE0hKGLIC9X
         6w+UYWUo5FexmCsurQMzQFJrHfr3hiiuSsAXxGDt6GsM5lAxPg7/KiFI3Leo/4I0VuMc
         vYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NWdT9YXI866qrHvFdokypp7DEip4bgEco40i0RkpFDI=;
        fh=c05Kz4CbpyIV9Im0rwuc3qphOuPlOJsMNHM4+ywwmBs=;
        b=iKwoiL3NS3jogyEZ4rxunxEnrUpNF+iiWWdQ24dNVeFunAVXTckQ/j+fcSuzvnrmR+
         sXxK9pD1evl+w2U8jFJXpRXHOZozs4pkMXaTB7fK3Vo488nw8LBaQVICFQt8n2ZlfHMt
         /i3m9q+CexP1tj56q5BvXHg68pQ22m8pEL4vnZHol6LXOlz6kv2UEBx5V58xJuA7K+Uk
         Xb17zDlKkXE/B3T8sf94SO72WKU6CkPlykom68KidwXQewiK360ZZwfJdqsPtGjt9ZFD
         BJpD5JcyHp7NErAMawaSfNhkDqIGBGGz59tpBVBMvEOWmAoCthcgJlaQ51ctahDJEFAz
         hY4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787175698; x=1787780498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWdT9YXI866qrHvFdokypp7DEip4bgEco40i0RkpFDI=;
        b=cwOpF3JLxyFmvpgWMb50wLZ3A+Gu/4QRBbTx3LQi6gu6DPksHc1/R6xNTDv1MQgmbu
         HReuSQTBqCp+qRED5Pc7nDDNF1nJVba6wlBtTi0FQ25JPE4RYJb1CKH2uoEcCXRSJ+k2
         CxEZssAedwaFv5iuP3oTKVL/y37oYjEkJ57qGGgmIBdb7GSQuPo6WhPiJCB3LiJMchob
         qbFX2e6hEoKFzbFOpil8Kq59y9A3SxfeRnoKnii7/AhwGYVtG1rdTP2p9VksVT2fPGZ7
         tnzUj0MwZODLAdbyKAltbDRhNc5EPzDqx4k4wktMpd+xZ7NpPx+EICsN6Rc/ItCWVkOQ
         Y8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787175698; x=1787780498;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NWdT9YXI866qrHvFdokypp7DEip4bgEco40i0RkpFDI=;
        b=JWF5qW/r+TcsbaBPAvTBP+kkv4jckXqAJYfvaWrwcEY6vDzLe1ZtoQKDVymQnLsOQ4
         +3im5KlZIZtUKCORaBdr+fbUBvSn5r99E8H/vEBQ2CSQv6vmunxxhZlIVOCHZ9S8D2ny
         /3GQXYgTml2Za+eqqf5RMjSUGMpR7LrWAtbaDDKN6Yr1dC/ezj1GqXhvv01xx72BFiWd
         hMMviKN3kgKZGKvIpY4WJnx8XN2wdf3CCSOHMSy52pJM0gJorrLAv7GEFQTy+QayNqjS
         VJsfeENaNgbbWnzbcOEFwZOCjMZu3M0NSAMmKmUdZ26Au01rut1fFmw0G5fA0CtUFvNm
         RMmA==
X-Forwarded-Encrypted: i=1; AHgh+RrzCrsjxGwCEw8yu7Vl+Sivi6TF50QaWJ+6yjzSkePXNzW3PRIZhxCicdNVzPOJDSnhEmXmQfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnbG2hwbIHe7PKaf5VLYqlmcSDPWcTbq59xD9/tlSr4DK/O+d
	Tn2hNZNQjd187V+CDYLvUwG/SP1MI1ipYc15mzmcg4llX97RSIyxy13gkrC9Jzkn4rH8bkFXFNT
	4BwCOiktzvI80SsmKiHJup6sFdcG42Os=
X-Gm-Gg: AR+sD10KW3HrkLVUE2M34lZwyGUdpU9zgwJ8IawTJm7+KzsBanYFwpwznAhakvz2g6t
	c6IpJKbfbqCHMzRmkhUklL8NGrxiEKyEiBf8vMxttoS0ZRJ+wRoByiuMIuEP7tnzHOz1yzOUJkj
	oUTjnzzFvSy3xbjBV3r8TBwX39e0Mzx60vGPTBuyXR+eexhggXQTDT6voA9t74VBP/FUIaCvtN9
	TaOnReHIT3/VvQaxkFfIfgM2LRMkA0sFCJZhczEwHp7SvFNm5is/ZDlnrQ9JKLPAKGZt1IsJcZF
	9lqzX7bXwEZGNXKN0fUOGwDyMsy9009Ln4dM+MSOxsnbWWEJXYEZI1zMCfJQOM39t0pNDqgs9rw
	=
X-Received: by 2002:a05:6820:1905:b0:6b0:1b82:89a3 with SMTP id
 006d021491bc7-6b13c32f2e9mr7702709eaf.9.1787175698158; Wed, 19 Aug 2026
 14:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818105642.65381-1-devnexen@gmail.com> <20260819213459.1220894-1-devnexen@gmail.com>
In-Reply-To: <20260819213459.1220894-1-devnexen@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 19 Aug 2026 22:41:27 +0100
X-Gm-Features: AcwNN1X54-kyQszxPzaYAfqWAMflXp4uxKVi2hFHrZMHrZpGhpoti64uoQ3Oowk
Message-ID: <CA+XhMqwXp4VVHJuY3dmBDLjJTyzwY=B9TEvZ9mVk=1Z5fqEogw@mail.gmail.com>
Subject: Re: [PATCH v3] media: v4l2-isp: reject zero-sized parameter blocks
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oupsie, sent with the wrong subject prefix and without its
changelog. It has:

v3:
- reject a block whose type info entry is empty instead of skipping it,
  so an unimplemented type does not become unconstrained uAPI

Let me know if you want it resent properly labelled.

Cheers.
