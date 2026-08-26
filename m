Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05E3B71B7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731505; cv=pass; b=qVC4KcJb0/YExt8RvBpasm1Lf/i7bal1WVrKLQ9HjsbeJjhM8Apbbn8auSh6m8ECwPAPHRAg06FJCIKZgGxOlx3JGCxeaT/E+1APIMm2GY3Wvpl5gaA14rcK/Q/6kc3Dk+lij5qT8BzAd6oiCO5WBGkca8+xTQwRh15yN1FhI+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731505; c=relaxed/simple;
	bh=q1ptEiUS27cJ8PNXiFVfigkQBm1gnQDUPUh9u8WMA1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEqL8pT7HHSbI+u1AJjBS0hKCDrOzsqSv6l2E8d7uqh8YloX20MoA6AsRk95VZBfMzonwJBNym6pxkZBBlykzAd8JU2oa0nyMqXgBwu+hi9nLIarANX6/29Q/cobkZjm37qDWIhBatlcyop9f7fEEWUEQ3CF8/hpeV9021ooYds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmutVuZJ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmutVuZJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d0743503aso1076420d50.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731503; cv=none;
        d=google.com; s=arc-20260327;
        b=Tx+0JXr0J1XhMfrz2OrlS8BV4eeZnynJNJDqw6ThnwttjyIG3HJjgsNnpe4Q4Jft+w
         skMIFt5joof+8buW5FAZH9fljQof86B2zUCD9L6YB7LbhfZfTsiRjjgxmDcVDy2ze9mC
         HaQe/yJPeZVork5sC6ohtl6N6jLzzxpqLDzIzFwNMq17Byql3Xs4belxnU1gwQ7GWb0O
         l+kiEKVLYKHFmjLb6bATG36hbRmlLOIacj4PPmhNDt6EWLEzRjlDrEQi0VVn2YpnEPhL
         JYEYC42PtpGGbxvS2Ld5MJVKE4PLVjqHcbWaJzh0EsLcsp05WWFWHKPfF7Kl7MkYH/4P
         T4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q1ptEiUS27cJ8PNXiFVfigkQBm1gnQDUPUh9u8WMA1Y=;
        fh=xq7oBjKYoCOW+QOwFfFy+RbryIbx0QN7mP6ONLs4ENc=;
        b=kyTJGPUQusmijqlad3rwCD+r5uH5ppFBYyHu1H/IDObgjuoIc6XCzudWzcFGn6XXUp
         RFdBkUhf7j7qAqN6mYW1QLXzsS2+92bwcXkmwGc0FvhJ6139UrW8og5LdwslHLlDiCNB
         cU8PY0vB78nenDoGvOMAWKoDlDj9cQdRF16NCUTX/R0EE8EMMIx7DP56UgiCYYq8o1ww
         vqpI/Cs3POmXGZWxX9TgPy3EAb8p++UwSkynWI5Zcn48uU6wXUep+lp01zgQ2WEQnkOJ
         nZnC51peB6WAOaWozXiSPKV5pAAiUuUVkpXPAiMD5WFm5k4G0TABe0cywvkKQixigrBP
         vbTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731503; x=1788336303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1ptEiUS27cJ8PNXiFVfigkQBm1gnQDUPUh9u8WMA1Y=;
        b=rmutVuZJrhUkQ0WIN/iG8Jc+ObgT4mV+6DQ5NqJ/Iftbnyzqqg0y5oR7m2mUPUkC3g
         xBLQlmKoASwUVqcTwGqePoZCG49AePkUiXwC/qiFMTOkkzuL1mIXmf9acDo1NZaIsyAM
         IH6hzpsZPKYx5krW3l4ogmyTB9oW49yAIGKiSdTCnMjD7TDx1xjlWeZkFfkVCMq8Oy9R
         Se051HYJrJyrQ8HuOoA7q7ohjlrwbu+NONUal53B5vJDZNBvqxzF/6vDJEpu05CYs7pf
         EFliOComyWRxwBWNcmIomhPmZmzYV8BiIppKZDx8PdEUkJn2Ygv4FR6LiJPjKyjQxzcQ
         MCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731503; x=1788336303;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q1ptEiUS27cJ8PNXiFVfigkQBm1gnQDUPUh9u8WMA1Y=;
        b=UQyfV5BVBLbKQuVues24jARq8UQDigI9g+8We8t7BatZx58JsVrqi080mV0ET2Ap51
         sAJCRVjC/dUSyL38qfjkb4+xBNUOf3414pFp2xzpDPo+qeAoGQgCwiWhX49/pWm6Kpqw
         8ZAsSU3uzsPUqnsOceX+Z+jl94M0T//P/Em/vv8zujrmKk8EH47nUoEJU+2GKTWF36Zp
         Mru6NyLhKQ1pSc5AqowurDwcuSLcqszIwzONKHPenvbPAuOjnRVPaXpCIfn8cxuvfv4H
         Yb0YSSGZxKOzziHzGQsKcPPjtUB8zQnP9C7bfmfiZT9lcQmc5ljilWIqdh9bykd9hhKZ
         qaXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcRyk3DaTxDPXQC1ovgUOGMUBhI68lnsR3VhFwJYOG/vo51GW3+5z7VRGDV8QmPuNO/yr9f9g=@vger.kernel.org
X-Gm-Message-State: AFuF++mI2qEyGLB2Q91HoX0tmfNfe9dXR0qmh/DKCoyxiGtlm9+SdXye
	3hs6L3oZlFpTmMV2anaWekKZYmOsToQ3bjfphYWT53dnzUmnWavf7DaAnG4BuhtLJPiOAOkcBue
	c5YF1durfEtTVaLI8iUB2R6dkvAch6rA=
X-Gm-Gg: AR+sD12vF6QI5YhO9p+kdDAyw/AacEsN0LciDzP+6Am26T4po0e0SBuRIlfovSsQt8V
	K8NyrtE4pf3juFWq9bmwR9iGRkuahDJ9FNZ96nWNleX1tGmCRfDnO2PJJaL0YxDBEYxrDAqC4kQ
	l7vUfffUmL3YNbgFk6QD7izvTP3z7JgYCCKu2I+Rkz9of8SiqQ63mVqzIIOIhrTRR4xTXJhTkvw
	5jrQvHtF8nRGgA5FXyd3Eqbv6PxKp07GTUBWVvc+eE21ZrVC4iL1R+JsILfysXcsphFkniHe123
	qJULEZMUzjb+W2RMn3rFhR60eyeyzhNl9Gr0AcxFCefFSW8=
X-Received: by 2002:a05:690e:b49:b0:667:dc6d:736b with SMTP id
 956f58d0204a3-66d257bd67fmr1671369d50.32.1787731502731; Wed, 26 Aug 2026
 01:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808084212.2704516-1-lgs201920130244@gmail.com> <cee7a7fa-25a7-4210-893b-2adeede359cc@kernel.org>
In-Reply-To: <cee7a7fa-25a7-4210-893b-2adeede359cc@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:04:49 +0800
X-Gm-Features: AcwNN1VfY5pxYmdULwYtIxZ9KlhPIA1W0T9QQaUiBasP1BWhplGLoNCUt8lqaWk
Message-ID: <CANUHTR_icbJKGJGdnPAm=nrKoRnjC1_dM0oxiTNKnDzrJ-LoyQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: omap-des: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Tero Kristo <t-kristo@ti.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 10:42, Guangshuo Li wrote:
> > omap_des_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe failure path nor omap_des_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and remove paths before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 418f2a8cf2eb ("crypto: omap-des - use runtime_pm autosuspend for clock handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
