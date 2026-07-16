Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3B40A94A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199514; cv=none; b=cteI5uzdnEbUqlQBmioxYTXpR7k1QkG5EVPXUxO4PTmbej6gH65x7iDGgfbm52822je4JUHw+VqjMm/AKq3JseJXpU25FH28oTfajzBTmb4a3nZLYMhlgMeJrp5TLn6ho7wLKoHynRTKnH8ZvdXXzxRK7kUBrb3pNXUNBU+XLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199514; c=relaxed/simple;
	bh=SI9vuvCiLUNTqWd6WlsA3FjVND8EZeQ2hLnq1JM2ocY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMSiynIJ6nXGQpeuFvhpu+j1pOf5vjKQjpjmIkwB/YqU7H5UH24NSRclhQ6DQbkMorHE7tI6ZpEzaliiFGmV7eVTWiaQ+BbIng/1+6VbO7/63prKTvbFr05zmeDunYebaBJdTQEyW43zfUTWBhYYK7FOnir2f1U46IEkXJz0zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Aqj16/Ru; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Aqj16/Ru"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2794151f8f.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784199511; x=1784804311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SI9vuvCiLUNTqWd6WlsA3FjVND8EZeQ2hLnq1JM2ocY=;
        b=Aqj16/RuFpUYLYmVeVOiUJklihsP3GxlGe9NPbjaZxfLeU9eGyCAkKF0xxBb71Pmw4
         KTkYBvXpRiQdFBbKseWN2HQ7AgHpOW7mYghUnC5+Ykw/wDlgIRLr76usj6ATFjwxxqY8
         9XHp9kQZhwDk7GsJIE9IRYc9033TCT450GtO1kWDu3hc3QrpJXQ9gT4Cdx4c1ZzAKtBA
         L6uSKflmK3BakklsQC8eIKbfn5xdsV6d3Bt8FQSRRly+psltiYb9ypLhHEoXuOk0rU8K
         bYmqhId8UA0xMlkLfZG5R4OoB3WKaZUKcM+grB128FD/EKE+SDK/7hya4CX4E+oIpnX1
         EQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784199511; x=1784804311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SI9vuvCiLUNTqWd6WlsA3FjVND8EZeQ2hLnq1JM2ocY=;
        b=kJx3vcFV6UVdP4wW7XDGYHtbJQhp7w3o1I5YenwnyvSnogVqAyyqmu8uSosy49I4se
         kdeUIn9bwhNTMtzmu5LNY/abaWWhrEdT9gyfq0QUoXZE8mCxnosUjvOZ/gpcJ8etsVGf
         2SgkzchxwNCrI4KGqfcGbCxqGLd33Mf5kibY9Pbaf2uJoXcaOfhyur2yCMsfehd7qa7I
         jCrZdurMX1TnMxZ/j4qDtNZde2ZzoezGmT6lvPr3EDwA9hNJiNj9mrHcaX+hfpq26pQX
         O5a6GF0EM0AZDBOYrV7MyZgqV8yNGMZgm61nvScyQCmyQGFvYOXQscGpIeePJXoKEPBd
         xewg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+LhIpAR4bawI+CTRKOeL21R1wu5e3kC87mSatmcpjqz2vjFzw5ISuzILARcYELnPbQNEtKs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC++cwCBZG0zihFGEPnr4syMyw7+gXJLt3vx6PU6lrLL+S9HuZ
	sO8AgbSVPH8h6a1skWuuz03RlHvJAQAyGHmrad1PQhfl/iSXAUr2q+RH83s6E//56BnC
X-Gm-Gg: AfdE7clTLMxjzYi33DIOs7/7g6X+gOgInm/RVu6UH/o3Cj7UdNDUNXmkJ9KEvSD9udl
	qZ6GWIf7yY34b7wkFvm6oAjM8j9GG/GBsHDFk7jgPF0Q8uPtoIo1whYBaPFTQklhwx946BCYDgi
	mR+cIB90hEdZPnFhRM659gmq/dAmMZ38qa2b3x/syTN/xlxiHPCBv8VY0KCP9IRv0VMECzMUzZ+
	byUX0TJHt5lM6MnDkSeigy0JsNZ4yOzO31LKRLwtNWNiEVItvsjvYjnfGogMRUH6PbwPTCj3uAk
	q10vVwpq1zJ1GE+1a2HPPfT6DbVqD1ktmiZXtWkyWdM42sMwbq5BgaPu/RVQNi4rN2FMY6+/Ksq
	xBmftp2C+iZb1N90/L7awX6N0nQNpbUXNzrrdYE64K0CRmK263ktVFbXTOxiSOYenEV4FGfj3Ku
	mmwlOtQOHueAhJHiW4E6KOmGaY9GmwoCwxkQStniSpT+iI+XmPRBGmzB+m2Om3+I1oDPC4ePIYf
	xetRgbBrL4zl+PsNptWm8OP
X-Received: by 2002:a5d:5f02:0:b0:47d:fc20:f6f9 with SMTP id ffacd0b85a97d-47f2dd2f413mr23607562f8f.45.1784199510924;
        Thu, 16 Jul 2026 03:58:30 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm23653113f8f.34.2026.07.16.03.58.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 03:58:30 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: mediatek: vcodec: fix use-after-free in decoder release path
Date: Thu, 16 Jul 2026 12:58:27 +0200
Message-ID: <20260716105827.870-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d4676bc9095c2c1efcd2c0f5ff4559bac7d1e47b.camel@ndufresne.ca>
References: <d4676bc9095c2c1efcd2c0f5ff4559bac7d1e47b.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yup, just double-checked. Please drop this one, thanks.

-Doruk
