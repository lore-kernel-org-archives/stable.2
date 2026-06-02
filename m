Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FF3624BC
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392344; cv=none; b=lwucmaPcPHo1CYEd4sMSSkA8Clsm7I9Z5xfFbgsAdUr3PbGwcIW+us2+HB2j2aOffwunxnVN7KjHLeoQWeAGFlavsIykI003Gf1Srhz2EpB58E253u67ffyJ6emyNhaQ/pmb+/1H4ZySextFFs0uFSQ0Qic+QPulUYm9FOPFnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392344; c=relaxed/simple;
	bh=9T0dBdjKmtpuSBlZJADZ1e/C7LfQuy/aeaKDkRDtpk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQEp7wYqpTTaj3sza3bzVV5l17No1rcxkMfbFtLergH4W5KDnpsgxvhG8x8IVMTkYEPaZsI/thS97s2zZrUfoFi9ZA0Lt9/mTD4z+4Wb6e+SoyT2qqk+a8sGQx4TD4hV6TNtiwBk9naafFlm/24nt0E8xaY4i0cZxIrolKfOXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBioeMKz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBioeMKz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1474340f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392341; x=1780997141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zekd0wCuq43OHwA3CF1X5oLlOYbGs1agYSly9jzdzX4=;
        b=EBioeMKzT7HOH05euYxaIwYZYEhnRBilNKovVRRT4Oh1Xt/q5VpwjG6JOmtllZ5uqL
         N2rgV/gJ9GuC3n9vnMuidXMQCDjIwqykqiy/cR3ebUGmh1lr8hocpidN1+dznvMoJKCu
         cn2ncyhAqtRT9AlFMXJ7UwHETzEF7u8vLjqGm5KrFgW6Lo3Kw3dw63/6Lh1Z9KZuJ3y5
         sntYa0UqZrKWTX/trVAgvSpIdv8eLZNwSOMzbxxIlHePWnknCiQbgzHTGy6P+cCZAPsB
         FW0CbwcjicbxTHiao2mp8hOforIhSYnNCunIwOiPevvDZt9KD7hyWLruERGD0fJnRSRv
         1cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392341; x=1780997141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zekd0wCuq43OHwA3CF1X5oLlOYbGs1agYSly9jzdzX4=;
        b=cSBBvVXjnDHT8aC0Gwc00MtN5hY5P56n6iKVIjMcLpuLJBpixwDzkhOnzgiS7Rd7Mp
         QyvAtb5HM0qGubxYaluCoVO5LKylpfdTieaA85ETxMS5zYfxKyuOy1HZe56YTPWZccyi
         FrZ5toBvIX1u2En8CxwrJ3T07Vz7SVvwq60J1X+D3dhkM+uNRxtChV0xZ8WuFKgJNNIk
         UUAOjkKegSf3/UF7sKBgoD078R6X6wEnwzCS7kkNCF6Blo/DCudLV91XkizAa+mzlyr1
         1ENILUMA6AKxtobukHSfVN+f7RRD+6Gbwo7t3bWovqmmP+A4OPsK3yipKLQWMZlprxed
         ysFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WyjPtZTobiwmKva9w/8FYinOc7CfEZPRibXUn08yyM8XhtEkNMGbKpRFJi7h1aMcgtT99u6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YTiuFK21cgMQ42FkSoEboL+JFywSLxkip088ZCVQopoc3miz
	SrErIDgGqce+E47fcQYFpl7rJMitzfbdAWUf5r4rLMn2jXxDAnNCcrqC
X-Gm-Gg: Acq92OE/MZiNbvhgMNIt3b1B7J/SDNzbNJPFLo4PKcREPySPcV9QZ8gyTYzEb8GaTlN
	1if5+bxS8ymrw/eg5wRkXWP9YALH3rHQXbZPqfGPhH4xiTRWr9YLPdXWoTSiPVWFW2UwXoPzHQQ
	4snS3cv/6UOWgnAFYmW7BADlZKgfrCySsu9SDwwBhEa5IZo/MsHNCPDCXAr9QS52aU+6WmMVvwq
	QrzcQU3aBBwI/e+YK3dm6QHuFYY8poGkFvLB/kb7D4Cr02MA8AexFbfilo/gPCdDgEft7y6iAjv
	NnYIvaKj3yhCQzPP2XAbMRnAhiBm2CbInNBJW+r1ocY6sN5qOimevX58uAS92RAQe0cLdXMTxC1
	wv5M2u1GK4yw0y2zObQmb27ZR1/Y5MwLvGykwVD4NTxtlkiRfvbicev6o5jpgSkTOjs0IRA2W4h
	+z/mOvE4q9ShnPKoaaRg3fmArYenVnxkZdilSwWzWH8ehE7ArToA4ZUBsl/TZCS0thPztSfJE=
X-Received: by 2002:a05:600c:4755:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490a29335camr246690315e9.22.1780392341077;
        Tue, 02 Jun 2026 02:25:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b29f49b8sm25092905e9.15.2026.06.02.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:25:40 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:25:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Aiden Bowling <aidenlbowling56@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: fix prctl_set_auxv to use sizeof instead
 of user-supplied len
Message-ID: <20260602102539.07f8d1fe@pumpkin>
In-Reply-To: <20260602024001.14119-2-aidenlbowling56@gmail.com>
References: <20260602024001.14119-2-aidenlbowling56@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 22:40:02 -0400
Aiden Bowling <aidenlbowling56@gmail.com> wrote:

> prctl_set_auxv() passed the user-supplied 'len' to memcpy() when copying
> into mm->saved_auxv, instead of sizeof(user_auxv). Since user_auxv is
> already sized to the full auxv buffer, using 'len' risks a partial write
> if the caller supplies a smaller value. Use sizeof(user_auxv) to always
> copy the full buffer after validation.

Is it possibly that the caller only wants to write the first few values?

-- David

> 
> Signed-off-by: Aiden Bowling <aidenlbowling56@gmail.com>
> ---
>  kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 62e842055cc9..d3f5229649e3 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2189,7 +2189,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>  	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
>  
>  	task_lock(current);
> -	memcpy(mm->saved_auxv, user_auxv, len);
> +	memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>  	task_unlock(current);
>  
>  	return 0;
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

