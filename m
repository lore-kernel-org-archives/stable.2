Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000344;
	b=EX9m82MAt9Uunn4Mrdc4tSmu1/bgcuLi5HYl/ebA3ybGLuHMIymI/NHl8FLKdirLNIaO
	 mjRHs7Itkbtgcir/+lFnZwDTgevhbBNkDoTtZ5Q78g15OgBjaq/v6A+yE4pPkgWiMG+u8
	 gptBIhqF/phzFckGUPUwZZKCR6Ez4QFC2QCHo9dHii8CeMeH0L6O9KpQDuLXnFCH/LfGn
	 nx9GF1FtdF0aUfsxbn23y2p77xZ1GgAzKeRQszTfKcu05eGrjFeob1XhPHCZDZcf3Y2QV
	 P/BypDbj8C7JBuORr3SMx3XvwamIm5xzufl/78GPggkwbt2+wh6BtQds5qxh6c2dsFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=53IUSq9d/hk1iaXQ1eoTJWrnyEolczWzJhhgu4AKlpo=;
	b=3sB9tvxVNBhcMvzITNW7LkCiVrfaXy7JN90k3crN9AuPEgARssZemQ7WKN5obiXthRBm
	 j8iXOlr+mR8JMyWDbhkEDhs65a7JvNJD3UZ/ecaVqwsDiyP8nERpvrmERBKbtCDz4KIQL
	 OsB1LB013ad8aEc599qclZxPsM1+5Xp6Fp+ldu54sCVTAQnrZaLelQAOrA6wlvQ5lHhz/
	 8jwi8DaHNd8z3NWxrGs9JTDjATflmHcGoTRQCUE5N63N50yjgcNudu38P+fjga9CJlRu/
	 7HUlN4XZ3BpItyqN0j9t7U3SY7x/C2QiQl15/wVT1GNukLHHpb/dyH9SXzD8irIw9Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fn4EEAIe;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF71606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF71606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fn4EEAIe
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so2352624eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000343; x=1795605143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53IUSq9d/hk1iaXQ1eoTJWrnyEolczWzJhhgu4AKlpo=;
        b=fn4EEAIeEpRx+AnRh0wkedAQ7ceRd9Ww8JOclttNSiiYHTkONMmyWWsQYQ0i1hSI76
         3BIFIuXOvpYWPfmXMMPlO9ZyggeGqvwQVrTvfhR1OJuxEM+5Gua2f3eUV5kShdtoemLO
         kRa1DB6bKUfyS+HeB7lcwSGUMg+6VxmV7TFcelRgzLe006d64bZSuLh0rvmc8A2prAJ0
         YEGgL1SM8EL5pU6rkU7B9ky5N8F8tRZRlvbAqAvLtsPhmy11spnC8mbKcj+ExEWd9Csh
         NRvsIJyROWyyXsYdWRC6wW7k/DF4Py1QgcRovGoHhwhlaBQoOLTTrJRySpOVpHoaUazM
         i4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000343; x=1795605143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=53IUSq9d/hk1iaXQ1eoTJWrnyEolczWzJhhgu4AKlpo=;
        b=bgmDWzz4rCoggc3GBGTpFIENzvTaS5TbccmMjw1XcsAj0rx+xoMiXW9YXZDa2EZEyc
         iLN8wpBZfnGG1H2hBNjxvyzzy8X5J+6ZAlRA4U5ZH3+Rh0qvZoKk8K9/0LZIN3m7DUzr
         kiTudMtU/wYFyoT09izlbQ9yY7HA1jHzNKo9egRBy1gNjJZgYEMWCed/ZBMFtyrj392+
         QutzLZVA06o5HSGw1+zpTJlhDKT52UZisfcfyW+N2webCHDn3Z/wqA2xBfk1ORT9Y+YN
         L3yCJMOmKEb3xy2683WTXb8MhraVlr4mBkDepyjQVSah4L1qdg06D7w0fAEu0Dc15l0r
         VyPQ==
X-Forwarded-Encrypted: i=1; AL+hErG2jRhwc/GMhgiB48ikFB4Wq7dLu2+wz+7hYk3vIHVUJATd5hSC/FNAx74QV3dTSgxVDV1bPhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aKJifSDDHmzce+U5/Rdkxtz7XMTORNN0INWdfldlm0m0K4lQO
	dg6uwWn4KOUGxyMatU597vVzo+G8YrFXoDtmK+MjLetsGvO/MtQuF1j/
X-Gm-Gg: AZFdTZccjxZM8H27ROFJwyXxhwZnCeZQel6sh4TpRl7EcM+cHs7nCt8/aGIO9s7DB1G
	z57O84bJj9Sh3l5Ufnovg6kdQ2lQbT6US626ZyrPnjRprkRRacJcX/J0JZw714ynmRgmmPJrUar
	cC+Ri0HdwTaKbW6OBYV0RHGwArs2SAtY8y9gQJZK1X6b+E5+w0IAmSwlS1EaVCzoiqx4N+lOafx
	GJzZfNMryYRMAfzWuOnz6Pks8wHztJutXXNks6JUqzFrfguJdEal6WVEOXX3z+RDoNmFbMg+M9x
	8Lk4SGvW3eWpgDhsL1emFdZ8o8BrUQpUqE9VxLC2Uq7Z0b3UWZDPuDN4EdEfJ5vjPbwZ+sLG03u
	kqMUf/r9UFLh77T7PZtVgqWoPPR1HLeh+TnX9j4UtK9+iIfpoF0CfqDOglgrA/smXgrSE5pmPxc
	V3SZzIhl12hGyRodd0Jw74nn5buubb2mEO6Uaz7g9VX8Zi8n4qBrt6aH+ax0Fsi5ubNH0h1TCOS
	KawBx8F3LY32a1h7YsW+STZDDB5pbhzJ6jWxRN4Fh/xvy8t3nYlNlEYlW2retZ2ZDKiz0SWO0UT
	fJy+AqflSaFLinU/zPzOTcda
X-Received: by 2002:a05:7300:271e:b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-3827fe755c8mr2374157eec.14.1795000343264;
        Wed, 18 Nov 2026 03:12:23 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304efbsm12327831eec.7.2026.11.18.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:12:22 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] selftests/net/openvswitch: check that a failed set keeps the features
Date: Wed, 18 Nov 2026 06:12:05 -0500
Message-ID: <20261118111205.1381184-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <119b21d2-31de-4416-aeed-d1f04ffcfd82@kernel.org>
References: <119b21d2-31de-4416-aeed-d1f04ffcfd82@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Both make sense, and I will do both.

I will put a changelog per patch in the notes under --- next time, and
mention the CI error there as context instead of a Reported-by tag. You
reported the hang, not the ordering bug behind it, and the trailer claimed
otherwise.

The CI link was how I found the hang at all, so thanks for that.

No new version for this one, as you said.

Minxi
