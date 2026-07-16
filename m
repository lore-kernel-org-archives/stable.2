Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600A175A89
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230269; cv=none; b=B5S/gBIPQwB86Dx8gWw9UFSqVYmMBMsL3vHm7IjHycgVa+C88jRGTPWdikjhNqqvc5+ZaD/v7eKdAIHLH7gTzMRup26/B9nvd6kz2lEfKbptS86QcSalxvuXG05t6dI+87FAEheH1RA58K/YY66R/nr8Do876QQkI7yMyCuM3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230269; c=relaxed/simple;
	bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7pAcEnHjbhTKBPY7h6mwcuLU0lhJzf21CanhHTaoK0UNlD/Cup4An/c8R81YHTTBcJEUE3W2oHBp/eMFPdTvQ62PjMvUH53QJY9i46H+voWvR/HxxObeoukZzx2Pp1h0xSNy1VbewBoAuGlQeDrZLNUu1npfiN4bb0YTyFqWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nUFVskNi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="nUFVskNi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b779003fso30332325e9.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784230266; x=1784835066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=nUFVskNi1dPSaAVgZsos6K5Gys/P/GX0tr99T3NHFzhcBRNNV7I8B3c79YxdZ34Uza
         FQKrDpPH+ZXbRQvanM18qTOBBeWcIcJxit/MVPtah5aUP7KORox8/F/WfaST1FYRxz1P
         zRT944s31yzRsaM7LBQ5lHaPOoIu19YhkhP5mcgwRVx8CjwnD8uDMyowYyUtCLNS6gqG
         01k5vVKx31C2ryY2C8qkpnhAFlbIQVgwVAItxAXDpURnu5FLYI+nn4vYfCoob6fI3mLP
         9knjAgJmXNJCTHe1Ol3b5CGTozun+g4TXSasAwhL4JexLMIiBGEhu3YE5THsd5zIMFWw
         +Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230266; x=1784835066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=I/MhmG2vVvW1/cHaNKh/EFrwyzDpAhwkvcI4BUt9my9vDR4j38J+eTDMcRyEonXuZj
         JTdj5rmaOVuDybBjf/xHhWghtx2m5jXXz55qpMFYDMdjym4U+HMCWLi+3PsmPtlVBD5z
         8doysKElpxR0G4ck8d+aFd+kAu1m9bUTwdsWo2ODwgI3jLp6UBHxrd6+7TS/UfBY3rU/
         eUM8OmoiqS6Na/dHfwrZ/+GyR2ufCuYskBpXfXwo3OaO6IPn6jak4baUxqjaeL+DfH8z
         mclurEKqdS34y/3krim1J2Hdd8QpYfTnak/WeEMDFctPazfvwmbtBdtAFkifdzylo7J3
         qfpA==
X-Forwarded-Encrypted: i=1; AHgh+RoaKIODBUqLzHDGhT03Zy1JUG5Ys0OrlDSSdAWWhDrZhPaq2vwuqSpp85g5Q3CqSKecsVl7Ay0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydlts8ZCsjHJL/4tTRMuwHrFAHn66TlD9sZdep/QMirsgKe4t1
	4uZaPW3At3C0TG9QTBS5LR6CkV9AeN/wSpfdpag60CRw90tqwdKwRUrbFMwRrykQ9w7o
X-Gm-Gg: AfdE7cmM4VPosStqZFhX02CKPXxePjwM81y38QxrDAlznsdOhh9tMMZz/EKUYiXVrOu
	NXX1snx7vuioH5nUz6L0MF19/ms5F0Eobn4tshxOIsdc2OPRo6YDxYkk0KX1FOgE+M7e7yXa7k5
	OV+B8xdFvrTCjyvCly2j0eQ5YHEnmQA+PIhzZMzp56HtQve8xg7G32B08Oi8xhsJRPKI1XkNmhu
	dC7CPa666Cid2qSXIn+DYYLed1LwhftrRhJKPdqyiJOW8BS+5Fu8aQwKPkuZtyCzfICdOwrCb4g
	xr6iUWbLI/9D61lMSfIm+6K8zyqG68cy9y9WZrLub+NPVVXcWbRu7IdifzOWUlqbGdsSh7S4B7l
	dfUDTYzSOTvbTdWp81cYbCkL+oZUbUSul9mkxJcBP3NbLxO524A7gRceGI3S/0JtRhFbmbBKZpr
	1xqEKUjx1B/pFqCevHScEux3avv+J4Zan19Km0BarOqDn1ZEocvV6YbZwaE8SLamL/VxwVYXvkP
	J/B9RxndOERz0AAcl+qkhNz
X-Received: by 2002:a05:600c:83c6:b0:495:3a61:b67e with SMTP id 5b1f17b1804b1-4953a61b766mr125503845e9.23.1784230266106;
        Thu, 16 Jul 2026 12:31:06 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7f7f7sm77535685e9.2.2026.07.16.12.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 12:31:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu, 16 Jul 2026 21:31:03 +0200
Message-ID: <20260716193103.30558-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>
References: <20260709131246.44517-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will do both in v2, thanks.

-Doruk
