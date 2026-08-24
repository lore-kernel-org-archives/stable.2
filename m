Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04433D4F0
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584838; cv=none; b=MiRPABDvyBhM/hKQcrS67PKinZ2wfyiujdwkjtDjnBrLd7dKQXcvogZfcKe+fWtaK2lHK6NlG4x+Lj20+fQUDChi5sGS7QDPdNebIeAzDNMns1+hqvsXu8fNGZzUvyy/em+5KhKNdjpiEwjwKHf97fG/RPQZCf/DmPcX+xJ3mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584838; c=relaxed/simple;
	bh=C+TelH3AlZcX47ivj645rZ84HzDP94p8X5F+vZbw0ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsgMoQq3PJGQrxHweReEwHR6ttZWNJHUkz79eSFIFD2dDIQijZhsODswPr1WqNgmG6bOUOU0mCd1H0Px0hAw6S8BqtmYN8EZS2JTV7ktQd8cqLA/f7m/A5SkefoSqJL+k970epSw2G74f/Y0bRbIa+rvwzc1nYZAWrIt1Bg5DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdMsfuZq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdMsfuZq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4141522a91.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584836; x=1788189636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frPrxefuhESfKlbGZEYzZ+IYOc/LSZSpcmZ15xxxNFY=;
        b=HdMsfuZqpKAPUG8LpEs7kUs6fPzkOhaV2Wo6TAEpoL1SieyEm1o4wSgdtNDnZh3TNC
         0mEW1XyXl4OAWDpe62niabGEq3jQYczHwB3g//N3uYVln7BKTWAsx2fYi3neTOsfeu9I
         0/lBaNvXdiloHuTfiLNpiTINsmpLR55zAkagcpBD7/nAgf1rFryNGtyFR0kS+/GcpyjG
         eTb83dEHWzcj3RO8BTXpflv2SvJJSzShkTqnC907OFDsjBsLLLFz8jj8WThqJKgMYNRv
         BS5LEHTSrn6XQ5xuONwhj0PD0y0nEYIv0FmOXCHYQkv1Yym0g9bw++kiB7Kdnjc6mcME
         pP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584836; x=1788189636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=frPrxefuhESfKlbGZEYzZ+IYOc/LSZSpcmZ15xxxNFY=;
        b=Y7P3o58M1PFZqfSFX1owPWu487a0Zp87+Jwuy+69A2/V/26O4dpIJOzREzuFjbw7uE
         t06cHV53bXMIfVM1ekSyNZcq3XCHwDRT1yAfB4dThfh3EPoFYW9GhKn+zLzAhr/LJrjX
         nfGOaGBPbJDIHTzSvIWhGAH+tBIWf0+5cAaSn3CO4P1GnNkHM6B1ux1OwKL4Ie4Zbqk2
         AXHIfZr9wxhVtGgBw9/V1pxzRpOvB633/SRblrk2PDUA9liLI4iX+1tC5aP9uHm98oes
         m08ugjkFAYPej2q8UKU2KWM16It64D/Hm91KoXoFFKjuo7O1Adxroh+S2qmJYhxA4THK
         Ciew==
X-Forwarded-Encrypted: i=1; AHgh+RoJ0E7a3qjFTGLTY4DQDljzsXzHuNUpzKNH+Bsju5Ug6Y++aAWd0sIKdWZEGOEx24rpyETZe1o=@vger.kernel.org
X-Gm-Message-State: AFuF++mMwEhNu8OldHbN0FrgL250ga6DfTzcHj5Rn0j255W4qoe92QOP
	QtU3naNNvUz4FoSPzRZ86KbfWBFCUR3iaOM96lBzbC7kIDrHbuS7Zi9+
X-Gm-Gg: AR+sD10nwO7dj1pRdmiE3I/wLSkpGUmtPjiC5We0G4G/KDz45p0TmgaLZumZpMa5CPw
	j/tl1S2/cddB5qBIzL+AqnVIuP8hq6NnVqNR+HFcIwEc0iba+XkesgSB7Sg/QgWb7UyrI/McEy6
	3ZIxj+x+HXtNwQA2KqU6n2cXSUP+AQbpgyi9kHS/Jmq9OZiC72ob4/aRmQsAx4k/1NjAK+IQfgk
	25iqdUserDm2+Tor/v+1BD9b1vJDoVUSLkZAaZAYah/sz0RmwO3dHMQuHTuNZTfsaiJDW2ioSjc
	7dCxwndNy7p/2/y7n0whwsV8m1wTImQxAuLdQ7Yl0I6d+JEkcRsCnWq9s8fwd5csh4qHbh6sNJZ
	ogpiPDQwWLgHRRBbAUQebK8osyug4U0Z7yCXUTnj4oWmqV2+rLRaKXt0KUHoCFTRBxqRJy9EHZj
	twmyoiwTy3MQ75hlVzPTuBNasnpyW5eLqGdsdkgYzb/fBJ7Z2wwbwvY/K/ZZPve4GsXk20dAG0X
	hr1d0DQG0gAEXTMirqzyPDpvqznPdlPilnsx1YX1tnoYx7FtCfzL5TlOMN9MDfhoZz5HmRt3beX
	wvvo/4RnFUYrHG/4/eTWKUz+PZTpolGC/foqY9TBE60ttAmfuY6H4S1VXjHzGFnRZ7lry2Joe1i
	KCvxDzzBCSYRHCWvaiL5NppPaiTxFIgWraG2XzEbPVOHNavlPU3XLu5I2Dm8=
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr46004122a91.2.1787584836296;
        Mon, 24 Aug 2026 08:20:36 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32814a06261sm11384329eec.21.2026.08.24.08.20.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 08:20:35 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
Date: Mon, 24 Aug 2026 21:05:29 +0545
Message-ID: <20260824152029.51492-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com> <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com> <20260824144051.50010-1-acharyalaxman8848@gmail.com> <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks for looking at this.  Sorry that my earlier wording was unclear.
I agree that the uses of p inside sizeof() and __must_be_array() are
unevaluated, and that sizeof(vnd_codecs->num) is a compile-time value of
one.

The runtime access comes from the third macro argument, count.  Here that
argument is the expression vnd_codecs->num.  Since it is not a constant
expression, __builtin_choose_expr() selects the size_mul() branch, which
effectively evaluates:

	size_mul(vnd_codecs->num, sizeof(*vnd_codecs->codec))

Evaluating the first argument reads vnd_codecs->num before the result is
compared with skb->len.  Therefore, if no byte remains after the standard
codec array, the read is already out of bounds.  The issue is this count
load, rather than any evaluation of the sizeof() operands.

I also verified this with a minimal reproducer using the same macro
expansion: the compiler emits a byte load from vnd_codecs, and ASan
reports a one-byte out-of-bounds read when the pointer is at the end of
the buffer.

Changing the trailing sizeof(vnd_codecs->num) to sizeof(*vnd_codecs)
would give the same size, but it would not prevent the earlier count
load.  The added check ensures that the count byte is present before
flex_array_size() uses it.

Thanks,
Laxman
