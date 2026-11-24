Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551959;
	b=txuiVPsodM80fJ3GhTtklQjYXmOag1JQ7KEEM2jorVAOmfp/zymYlERtlDlwj5KCpoHV
	 MiFc+JmK93vF/dqqGmdTESU4ufHhqbEWYXdhUKMsb62PpphwXzjnMfMNgPl4QBn177Mzk
	 Q6TxhbYMCHCWtLdO41tSxsbqHixu+N/F4JBgzj8j0cMouvRZQQqs4JpSzEQbvojQ0hKxJ
	 TrEpFWtUxkgx0wEDES8dAq0l0rKOBcaTtBiZFhLUGQYL4d0Zab8J97jWvFgSNznyAYuVO
	 x+K1D7K48pckJSDowFs4IwCzNAoam6k75O60yYmg/qYHu0I0BzJQqjAS3v8/ZXIddbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0vmGYU81o8BUW+PFvlj0Jh8YYINSsIZoDFwQ+4K/uBY=;
	b=kshqbRVriKH9mcAHL1Tx93aok6lCuLPdYEUiN50cwAf3D3yscrlCqJM4ZHWN0PZ1zBPc
	 hHHA7e6GCrezWv+nUAU/W/O1nZUh1okm4cDy/XCGQP+xPGkB/4YLSz5bQuspsJJErVG74
	 sGYi61piKKnqmGQ9ubbSat0poC0W1zW19fy0yXQLA0jAjybLeMBGFkIqnqyNaX7mjrGww
	 Xgr/xAsC0hwfZr/i8iWyxuncKMgR28Jznr6tCVf66HpkAS0nVekylDCqxpvayKfZutm+c
	 DhXcDxIfwqOAFsyBFLC+knYetzUSldRjrTQGNfYAF8zXD4VCsj7TANPI/Ei/5uKvtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTpyTfXP;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF5606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87DF5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTpyTfXP
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49465892f7bso3614155f8f.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795551958; x=1796156758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0vmGYU81o8BUW+PFvlj0Jh8YYINSsIZoDFwQ+4K/uBY=;
        b=CTpyTfXPdC7C9HnwuyN6Ne+WgvDbpIoFikodQvfucLMnITY52nrw2XpqOvsAyXRq2Y
         QXPaOjDEkx1bTlM727iumbjEeuX84l9z8JmHadfk7K6XFLWQystooPtj3h9hZLBlKM6v
         ukToTBVTwY+2OCHMcdBcMuyW/TlsL+MRpr+AJ+EAR2q4EZvFY+pTD4/NEBqs61/USSda
         SXfpfK7xNxLg0dy3KSd6ZTGqwlFoj3vznqDfvmM7seh94yuYAkY3lCYd/Lc6r2B1bzNB
         PeAmWw+/T1xJNVBubvUujCYgtJS9SNdaPuGxJh/ne7vaV2g8gT2pTojeNcojgdLwnpfa
         u0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551958; x=1796156758;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vmGYU81o8BUW+PFvlj0Jh8YYINSsIZoDFwQ+4K/uBY=;
        b=MJlos0aOL6XaKeQPTFrK1MFTlYgTw/YONz0x3yyQOpx/D38fumSz3YiuBRRrHTs8xx
         KVt0CA4DBt+/XVjQrqjHU+cBdCTVV/qrSG34jrKDsF2Ej5snOHLNa99EoItsbSJ0nSOg
         uN1qUxpMTsy8ljUX/qmwmEoAAJ+Ew7BhAKvffhywwrfiF2j/wxPecFVeRm8/ZUiajdCB
         8NRTN5hrQDeh15swTwg72nQzkGP+eZ24iiusAcqbqDZjLYvTl7pqJcmgqmp2/5gnHQ2v
         4drH0XBbQQqhBri+C9hsZwf3PmL3h8/TqYom3k1kCo2XlOnyKYILWotjzeimqXwfqzDJ
         Mi9Q==
X-Forwarded-Encrypted: i=1; AL+hErGRVvc20RPKje1vHRszJTdbI9Loi/Zqa/OMrtAkrO1/pjgr2sBOc3fTCQy0RLkBvlbEb9lcms4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eIRqreR0dSToZ4LFXehzasSdd8q+7gdTphgkhQBcJfvFRamqq
	lsTEc3UzMN48RXMDtKsjZmFIa4ZJItY4Fk9Z4ykwQIu4O4BwixDWhME=
X-Gm-Gg: AZFdTZeNS4aCy/3hzBqKMLem5oUsEXOfyeJdZGqE1RxHjjvEgbsFhojhlJlAHXE2ahT
	vwzuqXWGuS5xHlUBstvvug4uF4WMa0WARpmPlj+BwWd0/XjjTjtqcyOMQG7XqIyMATY/2okm+pN
	aE7J5eSZipkdkC91jIGD/TwFFyEIyLVnGkoQz8Wc63MYblPfVC+v/Zj5AyqSsr9mnTJjPVSHNVF
	dEbC5N3RTF1WV0eqni11T0MB2KKSHKPddMPZyE08X1vTHRAiIuNin4GDYrTWqbdMuXLvYsA32Wz
	r0CQT94iW239U2/XRW7AYhkZDksjOoe5nOu3hk5Qu9YkbJ7MIGFOEPTlxEWzsuW2FIZYWbW0ui4
	Gh5hbkdxbxLAjc41J60C7EoP4qpkNL3NpPDOtfX+uLDuTBvVPdFsUWQByrws7DBB0lLuJwj9H9E
	AT5l6MnKLlQ53mS2zk22UoYU1XHZSF4iXZEvjW7c1wFTg2jmbgGwT34HUyfVz8fePbSOx0pO2T+
	gInN6xegl09LkLZD24Eh/ugg5DlqAoquyJknQvE4aNYy0o4C50yB3P09Wj4Hb1lrx0yDCXx/UiD
	JIVbM7rBkQWkpX1Y1rwo1x1jviZVaWnXvw7f
X-Received: by 2002:a05:600c:848d:b0:4bb:694e:496c with SMTP id 5b1f17b1804b1-4bb88810b39mr337481915e9.22.1795551957657;
        Tue, 24 Nov 2026 12:25:57 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm422589015e9.8.2026.11.24.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:25:57 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Tristan Madani <tristmd@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 wireless 0/3] wifi: mwifiex: fix three firmware-triggered validation issues
Date: Tue, 24 Nov 2026 20:25:48 +0000
Message-ID: <20261124202548.1421427-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awXQpeeRwME1kVFs@google.com>
References: <20261124174620.1572200-1-tristmd@gmail.com> <awXQpeeRwME1kVFs@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the broken Cc, and thanks for fixing the threading.

Build tested with the series applied on wireless/main (v7.4-rc4),
x86_64 defconfig, gcc 14.2, W=1:

  make W=1 drivers/net/wireless/marvell/mwifiex/
  all four modules (mwifiex, mwifiex_sdio, mwifiex_pcie, mwifiex_usb)
  build clean, 0 errors, 0 warnings.

I do not have mwifiex hardware for runtime testing.

Tristan
