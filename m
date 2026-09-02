Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3F38DC5A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329736; cv=none; b=LC+UxM09yguW1k4JntTGqu2d3TvE+zNZT5ZplYNwXwVmj8vJyuuppooEiCcSvLWGaJq7Z84e2zqplnijhaISIabiHNHA/pSq48tqyXxq0nHcTPYbxH4k4uDQfopf9Pkf5MsNpPwSt3QasHFSzxybe22YBZ8sqIbtjsw0OymT5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329736; c=relaxed/simple;
	bh=I4NIN1cDbHIY2Amq9fsZuXK8o5mLs0QZQnK6P88hugE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jU54ywXRfGpFakkKezSgcg3CnvrC1MbKe00EQtqratiCwUXI3I/OToUDGw30IbNNbwo96F3yJSjaILvlvaowY8Lw/9luBw3RVyIWCJ4JkFnzf1MADj5cmmYN9RIT4r/DJ4zwrX2ZJu0dSMObYye6TjPKmwH3bLAh0foMdWQzZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcnWvg4J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcnWvg4J"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so6933575e9.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788329733; x=1788934533; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4a44zZaAgVVmRptagp+HGPfT5MsPzTia9qZioPjp2gU=;
        b=lcnWvg4J/YVcYLipW9AFiWEgLPE/vkf1xL3oUvJsxEvQD+W2FFz/CrACix6WdPR32Q
         ZSNXbXluwgCflWXt/lNI1bSEL07FrXIlstqdw+8w+QjHQ5IK8EUC6sTHrHIw2B1hR1VZ
         95kM813+oXdScYXlc3OGhYvQ8ZfT8cdXEInVFuAn+Br7Llv53b1EFwvj3KVC6s9tyKul
         n4zWv4Ce+WpM3Pc7m/poH/p8GrwS44f7rr7+aYxGIcrEQvksMIg3EOYbvQ7a04yLQAx+
         mpS5tbMnDcMF9d8i4RWJj20WmImxOLRvtFAekQ/mkTkT+/4uK32JC+hWK1cy+4Mn9Qh3
         MOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788329733; x=1788934533;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4a44zZaAgVVmRptagp+HGPfT5MsPzTia9qZioPjp2gU=;
        b=ARvYargbKvbBL9w5cwmc+DyJpH3nfVc+7aN2y/12DtUy3zWVLSqBmBM4iw9o6lT/3p
         BiWAU60aGL0I/pvid9o9LKMN8W/x+IkX/kFVK+kHsmzf9NSfT8EqziftVcUqm1MpqVx/
         1LA/qBvv2ESbcJ3CsduMefQV66d2/p+oJJ6i5tTBNSapFi3R7uP8/Pt2ygWpS9Kal8vT
         ribeugrv9f1Xp4diaYy7pR0cbCad5+bJcOM7J4fzhdU9HoOJVAkhqS1tJx8rK/fUhoo+
         DJo+E+Is2OvD1uJw6CCb/4+WV0euphMU/AsMsP8jdFckUE+pKKLQ2YcgmUisZ+v7d9JE
         o7BA==
X-Forwarded-Encrypted: i=1; AHgh+RrUIWb+LYE2fMgj2EcNnzLKCMMTpYO8a4rzcVcJvSUR32zeIhBx3a4xLbvN0AhIkRonw9ZRdHw=@vger.kernel.org
X-Gm-Message-State: AFuF++kEivcrwvyYBCIGKtraKZ7ib1k9IuWLV0wfkDCXydi4UDR8Jhp7
	Rqv0+D1Z223EAkX/oA/T+PnLTWMlEZvFbQvMloiycnpuj+pIVRtPk5iI
X-Gm-Gg: AR+sD11hLLiCdjcqnyDUnMYmh07v6CGXFW8EDo/3ew1GKpemWWaYCX/tKvS0Ivx8FIo
	uFNW7xUUssuIfF19zrG7BVsoUyt8vcMyw3AOPL6WDIYRmcuGVXYwFj/bOilcYZtJ5SXZ3GLrLQ9
	ZHQU7V5QBfdcYaiYvBbNn57qyHqVdP4kX2g4BZeeMBrUlgS4auG3+XVLZY04R/lTRFXiwoAKeHT
	+wwmufodLcwKYi8h7/N0KLjJOAtwnILoTkG8zQ5g46qLHu5O2ooWK3Di/JnyUohfQVUZjfBKgTx
	fzSVKiGum/pspOPiaWsutxDFfUvEH5vKUDl/KMsqLLe8iUxRqD0eV6GvTrBeQ283U7YuBVMtsvu
	wjzQ3Z7kWZIwtjG0Qx5ZTn1meoicmiBv1PNzfBUjvwgBaJUDm+HHpSnFcU9hd7N7z+/v3oQzE+l
	nsNAHubusysmB74Bj/3sd/psXnUM2iREG22NfBkpQC8+yqbmhbdngoUpKQny/fR6WzGUdd1TJX2
	SSrywV7MptKmV2H0/J7ELkNeZYO2Pbi2w==
X-Received: by 2002:a05:600c:4e93:b0:499:cd34:100d with SMTP id 5b1f17b1804b1-49ce57f5235mr39841585e9.7.1788329732659;
        Tue, 01 Sep 2026 23:15:32 -0700 (PDT)
Received: from valmpani.valmpani ([2a02:587:f24:b00:967a:9200:4108:5b68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4642382sm45222275e9.3.2026.09.01.23.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] media: dw2102: fix OOB read on firmware size not a
 multiple of 64
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Igor M Liplianin <liplianin@me.by>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 syzbot+f408eac9faa61d5a1927@syzkaller.appspotmail.com
In-Reply-To: <20260806-dvb-v1-1-a750f8e5b2ea@gmail.com>
References: <20260806-dvb-v1-1-a750f8e5b2ea@gmail.com>
Date: Wed, 02 Sep 2026 08:15:25 +0200
Message-Id: <178832972564.754738.8009301300861192916.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788329730; l=1330;
 i=vasilisalmpanis@gmail.com; s=20260731; h=from:subject:message-id;
 bh=I4NIN1cDbHIY2Amq9fsZuXK8o5mLs0QZQnK6P88hugE=;
 b=rvF99dTX+DCaZpMaHpmUEq9OVveZjVKnOlfnvXU64qiu2UmkqRi5actjAMTg6y6Fjwk0BjGLI
 ye9LPzZOGMFAHox/Yrv2IR1HZSaVtUEqhFX55fGy9HPKKYAIGqz7GZF
X-Developer-Key: i=vasilisalmpanis@gmail.com; a=ed25519;
 pk=gn5Uo6yL8Tlpq5uATxA3nqoq+U8eWLRbjD+bOk0qSpU=

> dw2102_load_firmware() copies the firmware into a buffer of exactly
> fw->size bytes, then walks it in 0x40-byte steps while always passing
> 0x40 as the transfer length. When fw->size is not a multiple of 64 the
> last chunk reads past the end of the allocation producing the following
> splat:
> 
>   dvb-usb: downloading firmware from file 'dvb-usb-dw3101.fw'
>   dw2102: start downloading DW210X firmware
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in dw210x_op_rw+0xb6/0x180 drivers/media/usb/dvb-usb/dw2102.c:102
>   Read of size 64 at addr ffff88802bcf2ba0 by task kworker/1:2/803
>   Call Trace:
>    <TASK>
>    kasan_report+0x117/0x150 mm/kasan/report.c:595
>    check_region_inline mm/kasan/generic.c:-1 [inline]
>    kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
>    __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>    dw210x_op_rw+0xb6/0x180 drivers/media/usb/dvb-usb/dw2102.c:102
>    dw2102_load_firmware+0x2b4/0x970 drivers/media/usb/dvb-usb/dw2102.c:1906
> 
> Fix this by clamping the last chunk to the remaining bytes;
> 
Hello everyone!

A gentle ping on this patch. Is there something you would
like me to change or is the patch good to go?

Kind regards,

-- 
Vasileios Almpanis <vasilisalmpanis@gmail.com>
