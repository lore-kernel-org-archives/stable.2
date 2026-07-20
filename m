Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D33C584D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539714; cv=none; b=Dkyr9Vmu6+zARs3dxS8Hu+dtysWnql+a3tmLFfG+AwDC1wmyklpVtNOyGKKz781dHdSyj917vIyH5dH+0g9JRE7xWmrGbpcpXluh0Q8BGaeglq4JQxEifHVAHBGMNLWmyMDEbkr/v4TV8J8LhsoFI1+DmFOYbCXFtWzMuzmeAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539714; c=relaxed/simple;
	bh=UEnqq/IcJ7KWoGd3IYZbyXw2xQsiPgQOOyS66Sq16SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8ghgZ7zAEnLpn/Xw6H9+sNzdt3rT68T2d94CzI2Dly5+3RcuL2oE6rJTsxlSrt49ElVuw5YhumBpaJaJJekIFPY0Z/f0qgP3GYCd1WjFMYouX0gVePzsKZlC6jDTOi9Q6dRUXqRk9w5ixvZCFSJIAJIvViOTBBhg3lcVfc8JzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDFxjhfJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDFxjhfJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cca0c5799eso74707005ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784539712; x=1785144512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9976wkN1/Tu5fWCdl90mWuGnVgsRZTUQaVYQ6iMh+U=;
        b=lDFxjhfJmIezuEPKhVWG2E2TJoOl1DnF39bJ/2IhRzDqJnUS+0G9yCJYI9Skw9O6HB
         nLTjAo9x9M+O+D6cmHbnm2kw5/EnFaNPqKZvNA4hc1ZiNIp+oVzeyqcH0Ui+XGl0JMTN
         QloC41LvFRVEOSaF7teyYiqpQUDDbtBUrArvCrxl02OOji+ljx2ueO/1WQPeWWQ2E00Y
         TO+8SL2zrJmFOp154mjNuKEqtGMM5IS0gpBDIXpBFR8BZhEc9Wnla6DP5kQtrQMMHCXC
         Bvy1h6y+xh9FuhIjmv9PTlw08ySEz63hgpYMJlzuKcK/iAWyx5nX2QH15q55Ft5YskUX
         EIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539712; x=1785144512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9976wkN1/Tu5fWCdl90mWuGnVgsRZTUQaVYQ6iMh+U=;
        b=EHNXVVGekfvN3Ui6SXewRqfVGU0C3JbSltfTOr5CQ3XO9j2dPbFTcXmMLO5Y5WXSPI
         SU1P0azV9VRFXBbapC79bwngvvcAt4ViVtEENGlzqNa60LgoD4iT4pC5N2rJpTnxDNfH
         qErhzJN/0JawmZuOHCs3ZZt4k538WVclKigxLJGrKmsgSXOikVb20a3GLJ3tDlCnXMF0
         y7ZLzhLrfyMQr7RNTBsl5cVjr0NhA/Oem7gA8rJlL8d5TiWaoaEMyoqOAOyNqERhPO6G
         4ziSwfemFzH6XMDHV95hEqnUKK2W5y2XfcwQxRNf1/zluslFSCQGQVp72CMpB46IeAaB
         GQPA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4cW1WF0odbLLBRcQ/od28AMwxLXMQs55shhGrXxTRlOHUOPnhFdhXHuiudwNXNWoZxG8FdSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILdQ60CaJ9JfoBtTVVEeNtbqiM+nyNpnw8k/sWHKzq/5ZJI8d
	yOkDgD+ov0LcdTIi21yCFspWBOeoRo4huL6pfv7BcSY4hlF0OU0AMxjP
X-Gm-Gg: AfdE7cntOCAKFbsqSz7NeoF48hpPtugx1U+cnma5Vq5JOaZOiet476BVgnVrKrEMnP0
	yzygOr5ZPT7IO6OYVDSPYXUq+YZCtEid9Rk5KNAr6FbNEZlwW+bsOH6oEB74lXS+1zEnSCbmWYO
	+T8W5IZt1+W5wA6BdDF+xqzxv4CqVNIhjqMNAGj5Sny0paFa1WPqNOMrkFjA+bC5AQMWlb9Zgm7
	JL7z4GtbJpoOuJYBxOzT+uvgehzb0/oME6aFN/rxNUw7j6jsxJsv0W2Bcdboq4XpkMdjUMLobM/
	U08ABEBDh83je3BbzRz/VO4xU5ntyAKKZdqqsPdFjJ+zrRIdT3ZRuWk1/na0ymlAMl0kCkXQQX9
	KHAwo+FrOZrfBD9qQzFRdfvidfU7sTut1PhL7+b6VNu+t62cyufeMZAnq939OQeJAE928uZZS4F
	mp2G5sFh1gxztLUpJmUZewEps+g3+czQ==
X-Received: by 2002:a17:902:ebcb:b0:2c9:b48c:fdde with SMTP id d9443c01a7336-2cf3496cb62mr145186635ad.26.1784539712341;
        Mon, 20 Jul 2026 02:28:32 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8d9:11d7:8597:c44b:bbf0:2c09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm53254885ad.64.2026.07.20.02.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:28:31 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: yikai@z1k.dev
Cc: aethernet65535@gmail.com,
	sj@kernel.org,
	stable@vger.kernel.org
Subject: Re: [6.1.176 regression] damon_reclaim.enabled broken
Date: Mon, 20 Jul 2026 17:28:40 +0800
Message-ID: <20260720092840.238806-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANMyjpgq5n0Ekt4dgyLRHGb89_Ew0aOMZ3j32V_w0GjHkqH1FQ@mail.gmail.com>
References: <CANMyjpgq5n0Ekt4dgyLRHGb89_Ew0aOMZ3j32V_w0GjHkqH1FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yikai,

Thank you for reporting this issue :>

I just investigated the problem and found the root cause. It looks like
a typo in damon_reclaim_timer_fn(), where '!=' was used instead of '=='
(unlike damon_lru_sort), which caused the delayed work to return early
and fail to enable during early boot.

Comparison
==========

    /* DAMON_RECLAIM */
    static void damon_reclaim_timer_fn(struct work_struct *work)
    {
        bool now_enabled;

        now_enabled = enabled;
        if (damon_reclaim_enabled() != now_enabled)
            return;
        damon_reclaim_turn(now_enabled);
    }

    /* DAMON_LRU_SORT */
    static void damon_lru_sort_timer_fn(struct work_struct *work)
    {
        bool now_enabled;

        now_enabled = enabled;
        if (damon_lru_sort_enabled() == now_enabled)
            return;
        damon_lru_sort_turn(now_enabled);
    }

This appears to affect only version .176 and .177 (introduced by
2f54908fae211).

I will send out the fix patch as soon as possible!

Best regards,
Rui Yan
