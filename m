Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6623403FA
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821424; cv=pass; b=bhZZtqHBRW5vd7CSzer9Tgb2a1p6ESXnVrdHBgfWv0iSb0Ysb62xPn1u/dur4Pg4QOUWTkAAfRgnuI1fwmEOcB6gqZycVwL8T6C+0epj/9XKnEtbL2y9dnmXcV9y1AB4sbGG0dYhbTEvHDQUlCNc46BBJrGPJKg3sRojTGbvR98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821424; c=relaxed/simple;
	bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkjkZXI60yPXk74pBQxvnCU9ldj6DQLAoMPxBh1lecf5i4n48QxRszKC0AJu6mnkV9x9eQZeiIqnMFVzzSCLm7xw3bteZIIilTZT4Jf2XybKE3Kg3m9L7I94L5qSeoG7S3r2cnjwV0z1Z/lF+bTmq9wtB3QjeuiepwERP6JoR+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1uxibIf; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1uxibIf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so201173a12.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821414; cv=none;
        d=google.com; s=arc-20260327;
        b=EtD44vW9MhOo14bIQ52TXzz+3JWg99W6ZL0UxuHoCz9O1UCNjbkZO9DfEAL4pKG586
         XVpiSmtA3+owdKdH2PR1k78Jge1CJtjjRm09gxeKWYdxiNrwqDpFNiAnDeJhly2F84UG
         Lb48GfXdpf600+Ss1quGLlP3lSoW7g7PoDqU2hQAT8pxiQlEiQYgyUq7vPP5Cv1zF24X
         CC6OOTW7xyMT+UG44eWzNY9r6k5HYw7Te7RLZXoVgCfCfBzhenTdPjBFaseeq5Dl/5qd
         jaBWIJuybNDTVHLn2FlyM3b8jfjnhJ52/zOa0bDIsp5rAvNp8eOmi9DWwlhy/zynco/1
         uMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        fh=UDtof/A8UjAEaulMfQ6KiYZA+SjlarBCowtAGR5RfJ0=;
        b=CCfXqbGM7Kdl3JqByui+bmEXp59zqpakFD742Aak08jHKHSzmlC/XHbTBnXrC2SpoK
         nl5yPKd00Mt5FdfFRY0BVYMyBfLXunnuIYmdMSZpzvF9KrT2Y3O0XakieIYp6KFwcHkQ
         yb6qhK1ZdzKQvXKBxq2srAb//HPnNYlcQVN4PsNtpTgzu3wZoncmPomebEJeXWfmm4EP
         L1aBSnhY/LIQyycrL2VxIwbo52Axp95P/owL9XM4MeBGMoE/3BlVgtUVfX8ksGCjYNCK
         0MI/685GmgaSj5t22LkGQSUB/PEqGBuer9KHZSh6B8J0xquci/1kiJYinSep6zwCxa4H
         iPPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821414; x=1785426214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        b=o1uxibIfx7Xnt457MQzE8/zjN7I4enQ0vBFMSVS4sEQhfX+zBa1d8ux8WUaOBl+axI
         IJw8gTXzW1HBy7sSYFo7hYLIvFSX+ZcoHk9AVU5J+yFkEKlOIiGUa2/es0j335LH8/b7
         fxljIyjSXoABUvPypa+DO86FvoOdKOry8/wXlmrYNr4wq98wS2keB4uym/bKTW286eTQ
         YkfyiXtdFcbxqXwvyBbir/njLYuljlec1CXfs3w5cbuWYpSvQRn9gHiTeNx01yW6y9L4
         hilzRMFSfDZne4uNuE1odotcMzaBQFp+RY/LJPuxyrsUJOgNCnvWYuewc9J9Fk3zVLsM
         1ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821414; x=1785426214;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        b=jVe0hP5oN3fi/dfyMD4qOUn/Zzz5vwpqbxspLJZYGnT6RbFABC/9fC91I8yriFebyB
         zsCa6egAeHdSp9UYrIAR62grZlkkqcF/YZl2H75IN28s773qhzfmoFK4i52O/evcDpce
         R2QLDTc+eOL8SlmNCiRkk8aDHI26a4ttm1pTJBmTeUkVCeE2irkjPGgbwHL/7IOocDc4
         Qq8AfN51NoWxy6tqge3kqg3FoWc075JMAKSrJSJe1rVwG9+ic9omsCSLLsN8lJQFVFS7
         9McG1v1gKKX52jgQ+oxE2wDBlzNbF+kmMkkDcUQY0q3LVkE8YdsBq+G4U7NImfFSX7IC
         ZiZQ==
X-Forwarded-Encrypted: i=1; AHgh+RobLneXioWP3oYf4Py1Q8akpw7PGzG3gGw3sG2uOxkpAaw7pIqYxu26ynlo+oT/qmv79h4cNRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwsmpBjVHCZqRgERW3jMFPe0mWA62TU9IN6RjJ8vrZANKHrhE
	ioZuEQSglvdx3WS0Z6WFt5clbt2LRQwyszxmFBaKg56YdnC+CiLrKMvZOQSaEa0wNioNdcyRywG
	FOz/OdXXfpdgzGUb335/I7uClmbtxzvI=
X-Gm-Gg: AR+sD13rly6JWO96VU9E7Gysqkh2mRO/v4CTaNe2gfyeVmUWOJvWCwOAY8IRxHvieDv
	jHnr4DI1gdIdrQeHwqIlinEUgYrzmTkL/lD0q+agMOsTk7vpq5CPBgtUcA8zlFLMzWorFUewKUu
	ACFUetR07WnKM6wJ2j9zYEbxAS7+VzvTZrbNj6H/opq5ldHKX0iKOlcCyhjBJFX59qlT8TskI62
	/FhZRrzZBhGfesQn2KxC+QEupEHONXu0xxHsoyJxVjbMg5ZOedg2/AM2D00z1z9q/PMyWcqILcl
	FWJ7Mh1OPsq1BLs=
X-Received: by 2002:a05:6402:5290:b0:697:f633:47ca with SMTP id
 4fb4d7f45d1cf-69f6ab45963mr905098a12.6.1784821413483; Thu, 23 Jul 2026
 08:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com> <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 23 Jul 2026 23:43:21 +0800
X-Gm-Features: AUfX_mwwyaNw9z-1nV9cpcV4k46oEw0QUp3y91y5WUTGsxw741-07Wj9uXIfycM
Message-ID: <CAAo+4rWXA=zojvcZPM-WN2L1rPWNNYZRhnj70AgJ4mRvd=o9cw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No problem at all, a v2 patch has just been sent to address the
similar problem in
other functions.
