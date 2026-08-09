Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F40287510
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292594; cv=none; b=lkbyikfzZ9/ulY60KAI/7fPxCEbghFeobHapGGnEbeyh9g6sMsXLC2Y5FxaX2RCJdJUGAI3ANttpwCYJuebTnDYgE7fhL5LpOSzzr8dBTEPKcpNWyRuG1u+rtls7/v9bGJJdLec1vZP2Y5bu84dNL2sfbFNxfEpIYX2DDagPvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292594; c=relaxed/simple;
	bh=rq+bFQgGz/Hi526ZnDjBsv7YI5XI+jsEFX6tzNLMhA4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bPmEnW5iiy5IDrlcocrOEhXbWhDgwvIKyDZ5o6wx1cyJYD1Tqf3hwOZ3fT9BZbupOZ7xOPi5prHNhgFS/lG+DnoJSpQ4z17Vknvg7P23thHCx/CN8nhD5L/ZlwSVMjHIiWhYBcW9S7NI3TJskbPKE9FwxNz3zL05MEn2Bl7SNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/L0yvBt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/L0yvBt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so13306655e9.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786292591; x=1786897391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ziwloAUX5tf3TB9W7Xw04jSVTkYmBKOdb+f/tuo2ucE=;
        b=G/L0yvBtXnQ/sHhWh/vzmASgA2q1V8aQaZ+unVHAo7sME2FRgCbgdUN6oH2YTQg7gH
         b5xx0scB2MHoDQUb8LQYGft1fnrNw3g1m30erlgJp9WErvQfLdwetIZKd/lPzfCn0TtD
         YFKYj9Y6V0+DBkV1/PN42BQmbBB/MSt4p75QXhEUZyQ69G4NfearKGnUQlxBiRDD94mi
         R+/qjXlTwLC+GRoseJXfVB1DsWpOXZM5fsHGo374cVuLFik6zhMtQkaRTp85NvR5dB5G
         SkXTsC95P30ih2/1npf3FuxBo/Jji1uawCklMs0tePOFmhJ3wwFANRdT179oNwWOJTGm
         1Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786292591; x=1786897391;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziwloAUX5tf3TB9W7Xw04jSVTkYmBKOdb+f/tuo2ucE=;
        b=iZWutRnOElsVltwwL7EZrv+tWj+TWJ2K0ffC39NktZ7esZLuUKqzHK50ERpZ+XO30t
         Jxx4TurVCKRJbQ1GcHpz63GDTJGwtWE+ytf9Ar9UIau8w6twF44nIB8bTJRAM1Mq4+ZR
         LhFxKJo1sJVccZfgdPCcMG/6pE8euhS1Rs1dvH8HuNy8V/OFtbwcE6jFt2iwTIDIKCR9
         dDD5ic3/Yl3F7+FFkkkNfVQZjsFx1FgjweUV0P/3o1zKjzUUOiZXg3gw0KTR3E7pmeKT
         GEy2Gg/QS1XFsXjU8Qsi7IZQu7hJtLJlqak3w097DovLWD4mqUIBEjJRWVci8Oo7GR7f
         Z2tQ==
X-Gm-Message-State: AOJu0YwYVbqNxYLd1ZxNceJo81nR4TwtyCHoZr7RRy6W+PUJtQK+irjh
	GgEIfbOqOgIBkdmZVWIAs+X+lnAsGhJcj3HE8ugolzIbQRCZbI4ykdIEJowbiw==
X-Gm-Gg: AR+sD127iGKyEqDJg6iNBV+2s8FgSKv3d1cnDvJEiXlcmePlvtdqCfV7IKcJrgZvcoD
	A1bjkilN0ASmyPhESlAi9r8ra7E5KFADpiA6Q7UY3tSUt/wuxFD5L5R8fQRsYdARqmrzdSEEMq0
	1GFRoErYgK1+6mZxLO6s+LF0xvKI/1bGhGRDXlDP9MzirYqgAuYhWpVhPyMgJUmPkRmUP0cnQJD
	M5MGUQJ+BInKESDbOomyrvxEmieMPKQU8T8CV6rUXU9O0NMNfVwcQlFTIUfccMWfWKXnDJmtp6/
	DqUNJc5DXwFlD97m072KXZf4yrGNu/r0Fn5Jr7hXlIGGTD9Aw8dGd5JisDL+LegNNhF208clO+f
	vs1d1EVzSicMqzDeg8qURRpt79k7NhWUzLBgCfJG2U7NZ7+HC/HchG23z8Pyn/NzqsqeNO3CwLf
	VYXazWqAuESk+PYSByuaS66K1U2gb3scntiYex4QOC2v4ouPrE4YOkILatwq5GrOLdgwxJM9kT0
	kk=
X-Received: by 2002:a7b:c44d:0:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-4994e7cc5d0mr402552805e9.14.1786292591280;
        Sun, 09 Aug 2026 09:23:11 -0700 (PDT)
Received: from [10.86.162.46] ([193.207.119.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542851d6sm362640525e9.12.2026.08.09.09.23.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 09:23:10 -0700 (PDT)
Message-ID: <d614b8e6-7f95-4e0e-a4ee-436fb418d883@gmail.com>
Date: Sun, 9 Aug 2026 18:23:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it, en-US-large
To: stable@vger.kernel.org
From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: [REGRESSION] incorrect backlight brightness on AMD in 7.1.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Control of backlight brightness regressed with 7.1.6, possibly due to 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1191285ecb4233e5bf907da7e9394d7999055566 
that may be incorrect.

On this kernel when you try to rise the brightness, it does so up to 
~95% then it suddenly falls to the minimum brightness. Conversely 0% 
gives you one step above the minimum brightness.

A possibly related discussion is at 
https://discuss.cachyos.org/t/brightness-lower-at-100-than-98-on-plasma-asus-g14/33957

Best regards,

Sergio
