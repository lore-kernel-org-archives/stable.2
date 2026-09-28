Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F13CC334
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592457; cv=pass; b=eyO3TUpbDkla2x6TBe7CrIVqZwCGhb0AzuGgBKH4Jiya3opPsBz9+WQxCxhLHxYO+JhVMMCbbbhrt0rJ6mH9nykJuqBLOoAMO5Ju6WzHXw/pvKvsUC4RwgAPWqUsvtPNijgytA5t5xBc/fLQdsT926P2hNocN6QdhteRNQcGkS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592457; c=relaxed/simple;
	bh=Mm1M66WeTKQ1s57nxh5v2LYlxkK3pntIyqualKvqj5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy8sUmukk3ppyeUaiDnlurEyNaFV4zzXO4W6gk6dJC9c7nbgLyU6JY3WPZLrAfWQgGP4XJQX+W+fx2cFGeKI5c5OHXtF0GGOZ+t5QvWjOVcDvsMkTCyKQHlR8EamXixkcy2B0Sv9DPMpPAmvMa1b/5wrCulEfr/Wr2GVDEJE07Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/xpioFH; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/xpioFH"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34251480737so162201eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790592454; cv=none;
        d=google.com; s=arc-20260327;
        b=k+G0QcWQLRxDTVRlSgzMcCZcic3XBqubRsuj8OSTKIgrqY5idTQG/qtciCnd3Q7BIc
         kCGsWTP9QXvZkTt+u5SyIfSHbx+B2qq4SyX7au4D+nNwRNtKipV2YfJs/V+8uQ0RBtZH
         qBR4S2zA1pkDzV/jnza+iLGxSDEEa8uonJkFUPo2sLQLOZkZ7qImvR8TtiJ7qpAJ2KAY
         4WeuqQxe+LMoO3SpC/YOSOZcMkv2iGSM/8TUJmSAF/MTIQVLBSbDLS1V2fuHsPFHa4N6
         hE5mXv0h+iInTuDtNAmqA1lB3oF1t7TRZhyoBc6A1qKcDeAHT/cRPpJJCQBTBxPmbBbK
         byKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xoXvmyV23Je7Sf3lv6ued/rbPlsysef4zZiLSakVbJI=;
        fh=5GskS2k+AfKhiyekJRNMQqHHONfLs9jm8p9rrlzyVh0=;
        b=dPMYcA7qx9o8kUT0HutUrXlJdMmrUyiFVND/9TJ0QU6j7GiAnM1yoH9HSPoaZNCB3e
         odFLEUAy8EZ62ox6oBOEW9iETsjdZWi81gpRjVMvVcfiSyzRWBLkRl+lqO0J9UVg//mO
         mB+eKBag4xh4oKWRHIIx/hiMIz2KcnFYHxaoHqIRySg2N7p5O5Wmbze4EG/UCa4NLsQA
         GFt/9pZ8Y0VTgdwb6KVnsN6VV7ByiYHrhOVUsorxSXTbw3694jD7uX4eeiKJDAxcHaKN
         riGS8ZcIV9Bl9H5yJCmAcPxgOr/SMsvFx6b1qKM2MB0zmvVc6eciYLiv+JP+cp/WoEhQ
         1Nsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592454; x=1791197254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xoXvmyV23Je7Sf3lv6ued/rbPlsysef4zZiLSakVbJI=;
        b=b/xpioFHvm+BN9wArcZX4hIPNpQHX4cyrokroIQUjsc6bs/dAJ0kERegN6p214/Un0
         oNdI7fCV1GRV18cxjWmy8JdQry05oce8BAZnuF+Cs88ZW126mVckjoPmpWlgl33FtFzk
         9bICcHHLRwbLYFc0dp8UQ6XwXAq8LRnwm/6th6Cfjhm62stPoWFAtlURukmwKoSSGF4u
         txBMTLTBLML5ZXgVcG4QnQTC81mJafcq8rtXscHmIjHg4TAKUET0GP7NKr7sCrzm5UtV
         qrqJL88xIB55uiVGtmTbV9ULulOSjyOnBoL6oqDnbAi0ABmVUNVVWfzDtuRlVqQM4lJE
         dQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592454; x=1791197254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xoXvmyV23Je7Sf3lv6ued/rbPlsysef4zZiLSakVbJI=;
        b=a49neTBqCrtun4jRxHn0Rj2mERDHaa6ciH8J3sI5+Tl47bhcPtzJ+txLQZCHOy8u4w
         /PTdtckEa/DR8h6iNh/DBzImuhp8ork75m35PqyQpu8BRq8FqZe4ATH8FQbyR7IWbTP0
         xWMWm5Gr+IU99byYQNou6sNy4KTCFc4IMTo2kG5hcZMcU02wqAxnkqi8pMmlf29F8RSH
         kfxEPvrI3s9FcZShk/lc8/p74U685bt9I/vm9/qeoP610a1z87rgfB4R4EAaUiQhlvgq
         jFLI0bUtDFFUnD0lh1XVvQZrVZnqSoFGeU48bvoZRgy1uKxO02F6+LeJCcptaEhR7xIA
         5mkg==
X-Gm-Message-State: AFq9FYLjtfUCLeYwEi067wdqST7W6IDoSKt4ASsj40eXAqkuxDNIwlXg
	lPMkGrywsv9MgnCQhCksU4RqN0U4zZVrIzih3OOs0h1VZ0Ew6Mo7WqQCNoWOoTfFWOS5DLScuwu
	qhsPoKAC8BxAHP/OdArhxLmcYsnNGCPA=
X-Gm-Gg: AYBFou1W0qQu2aDXJZzW9+y/g1ja7pUp7mPUaeSWcyXaWKeHAm7HENwQYWEBFfG6XzN
	cypLfAXa1T0tyvEnk6fSkFRYM/KnOjOIHEvoVUT/avx7vNkv7aWe0PihznGVuqwu47M4mJj7XEL
	apb8ewVRLUy7kVjZeGqAUaMGJJiPwZgF4a7STiiJMxzgP0Q6FDQgR0uCQ0iAM3KEDF8eF1J2F+d
	a5SHnDs5+xJwhvFkffazuEOsAiljctsDukA41j5Zx1JFBc7k46p5zV/kPJ24InDWKKBIqweCSgG
	cpFkRD5jmGtOJEoiU4c/Tq9aQioAQcOT6eijGdHKf8m30C0HuF3FZawdNavuuMixyHQY84hQKq3
	OfEajVd6e6SKx1SlUFUWYn4KXqdF0+baEbqDwBBV3cVtofFCytVfuJkRss1fvuutd3VbLDIVM1x
	3VNL9wTUroBksOCnIznqmi3M8t2Cf4O/7nX0u6iUSVqwj/RmoIscw=
X-Received: by 2002:a05:7301:dd97:b0:33e:6a79:5a81 with SMTP id
 5a478bee46e88-3427179721dmr13165594eec.1.1790592453928; Mon, 28 Sep 2026
 03:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928104313.204453-1-ojeda@kernel.org>
In-Reply-To: <20260928104313.204453-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 28 Sep 2026 12:47:19 +0200
X-Gm-Features: AclHuK9xFldCgY5wAGWi7hIMVMU4CRypu09HIdyr23r3ygqim1-2NeqH9nrub44
Message-ID: <CANiq72kFWBPfM3Kninya=tVcMgZr6OGFTNJMRQnY2tKXFGH++w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "rust: net: phy: fix off-by-one bit positions
 in device status accessors"
To: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org, Chunfeng Song <springbreeze@stu.pku.edu.cn>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This reverts commit 3267aea7cdd5d5c8851718b148cd25ff1a5374ac.
>
> It was not meant to be backported before 7.1.y -- its tag said:
>
>   Cc: stable@vger.kernel.org # Only 7.1.y and later (requires bindgen's r=
aw pointer accessors).
>
> Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/stable/SEWP216MB9770116738884C46F156A686FAF=
98D2@SEWP216MB977011.KORP216.PROD.OUTLOOK.COM/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Bah, sorry, I forgot to edit the title to tag the branch, let me
resend the series.

Cheers,
Miguel
