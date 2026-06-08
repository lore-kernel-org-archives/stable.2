Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228532BF5A
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893532; cv=pass; b=PFVjS/s4v/huw6UQySgmowj5fHUclHR8UgQoJ4NEPm0wCaa3xA5D77ayP/1NgmAWAtjdUW9Fc80PlLZFDwKDApctDzd8M/3x+DKf4jQAzjAuaM6EhyZm3tmkOuLRVqc4ySnEflKeClslcE2G/g7Cpl2wsk9epkm+FHveEX1W8/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893532; c=relaxed/simple;
	bh=MZy7yI2wj7sUs7TLGOXKJKT3vQxPgbX49v1A1fysaTQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gLFZegYntvWgMGWYgzQ9bNKEIRqCHKngLW5en6QmKGbKodmDYWvW28VjaNXvkyhK9J+l1Ri64uVOjujsNISOExHxxsO7wFxktQMXy3wv0XC+rIvc+iDtOMXpLI95+NUjiaqgoBWrK3UW9phhO2/bC2uGSpdX15TQiElGWILqIgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=at13je63; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="at13je63"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1761860f8f.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 21:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780893529; cv=none;
        d=google.com; s=arc-20240605;
        b=cYtyQHC4BPDYqRyIlTrYzilHrZs9MN+GGEJ7A77Luv3ORMx6uN3YOFBZ+400o9QLo8
         ZxHGJpWZiob6SoOMBTUiOIr4t4o6NoO8YCLjH72a9wFz/UVRCP5KP1HK45G2aRgIJDJv
         ZVFqirqTGf/J0QbpCJGr1q6WQx/u4vn59OZrJ73YngrfGcN0J0W+qtz3Ap4vzk7Q6Vkl
         TAFoW0wQJVfXAX2yYPjNbrNtnye336a87W5+hBhNU+bVLT1z/JBpSbOSwj8nCyzBATee
         XPXA/jtkVYr0qKvS1w9EAUCqi2uemDgdyGNMY6E8Tabp3U6620J1Yj7KlpUGM0rdzE/J
         NiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QQP/aPYxeZGsiZGNoWInSta83wgtFTiCz64TEWtNGuM=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=ERtyvtKICMBRBqj1vwhRmKTrcqGBMABC6ldqffEMrXZ0T7tw8AR2Ow5iK1VfSrpXzP
         7D1jDwFa0lamvd+htsfxAIf7SOFBNl0Es79fwAFjclazN4HeZ5TTzLjV2Yg3prESVU/e
         zXhZrzV6+MqMacTmX/sjkjBO4em1Cs+vvx04tBIiFNbuiInRD++SZ2tCaS+UGeDbP4Hq
         OrL3sgiF3U47gw01Pyb6m0Fzs0URO4iVa4mwYqx5iEDHwldt8JfVESSI3Y4/u+GakWPC
         7m67sua9RDqZHhErWIoGcVkkL5xDwMru0/B0dYck6tP1gjpjPA8i45BfRVk8A3ZCGNQ4
         3M5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1780893529; x=1781498329; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQP/aPYxeZGsiZGNoWInSta83wgtFTiCz64TEWtNGuM=;
        b=at13je63Gl1jJU46sTF/aIcB7+EUqXQ49S9HU4HuI44lQIH/fmYXOyPLb6JRlh3ka6
         tC7YI4Z8XXdHKjrSGg2eZc7l8KWHIvtNM+7GBgUfFFr0pBjn17NFx6y4/7xWMMrmoIjI
         y0XS+a4j5fgK7GrrctPyJdH07TnEu6GceHXBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780893529; x=1781498329;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQP/aPYxeZGsiZGNoWInSta83wgtFTiCz64TEWtNGuM=;
        b=Asvh949LkOyOum0Lm1ZEuC99T2OkC0UUZTTtUxyj1BbsQnwTxFS4QLHva+WHGZHjpE
         W2pnrSybIRjUwNDQarsXy+IquY9JF1iXHOKqYqJmFxpqcydFt/0F4IPysN6EmjalLC6e
         8xe1xvvdkh3QZGY9Fr+zk1Tny3DPTiZnE7lV6mscyL3tQ0N1JAehyTw2mrtMX4E8HAVH
         iem5gtCOenjX0Rm9rr7/PLH56hIistRlRoHflzf69Bvsd8GoCeRliDN6YK8z+Xg9bFa2
         mVPpK7w1D8tQcj9k70dB9ZZVuCrdJwPfjwLibOtGEAAaN6yQ0QoSb/OLAjkO0Dta4A4K
         T63Q==
X-Gm-Message-State: AOJu0YzJTQcnCRoY0bcrNRpFlPGE64A9XuFYmez3enQ6hYLeJklv1SVd
	26lyCl7CqEbVodWceX3eRrr7TyXhylllfDb9lD1fMmWljk89KjmEQc7woJ89ScSUqEkNXSPgO2M
	Pb41hiozhHYDahCgRvqTk0/7ZTOwojy8GrGUZfIdDRvnnwmro7YISa2SCBg==
X-Gm-Gg: Acq92OGPrZA6G/dpeCil1S9C7krYnivLH4DhgBvBUHcCo1lsYY2A9fxZ1lyTcOj0RQK
	kimg2uAkPCfHEIPrtVvLZZsNVlRarniv+fWTgINueWZfLU2NNxSCjQAasgpLNLHIvJB23Ok+S1u
	wV3gxO+nF4qZ5Katb0x4MVjr1HYJz1o7NGs0cFmb3y1hGG54JLGOoy9X/nFRIHP3mgHQPQ8AExh
	iagcXZ0AscAY/wR5NDl0BcWG4zY248SqCpUzTmraYM91fGHHeR3vOFJ/aMlyqULW5N+SM7uidEI
	RatHxqhp+5XcVUNXw7Ff7doBhhwF7Zcl/PQa4WL91k2xR3glGQ==
X-Received: by 2002:a05:6000:a91:b0:460:1755:160e with SMTP id
 ffacd0b85a97d-46030757dd4mr15461369f8f.33.1780893529059; Sun, 07 Jun 2026
 21:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taeyang Lee <0wn@theori.io>
Date: Mon, 8 Jun 2026 13:38:11 +0900
X-Gm-Features: AVVi8CesXCFQGpxqn-hazduOTZ03XNUK1nIXJGQb3wlZYFkDNzEL63N7sGsaLPc
Message-ID: <CAH-2Xv+d-xVfqEN1NRpKbGmDFX3JdVzLBF1MXWubhzhbisaoUg@mail.gmail.com>
Subject: [stable] Please apply 18fc650ccd7f: bpf: Free reuseport cBPF prog
 after RCU grace period
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linux kernel stable team,

Please apply the following upstream commit to the supported stable trees:

18fc650ccd7fe3376eca89203668cfb8268f60df
("bpf: Free reuseport cBPF prog after RCU grace period.")

It fixes an issue introduced by:

538950a1b752 ("soreuseport: setsockopt SO_ATTACH_REUSEPORT_[CE]BPF")

which appears to have been introduced in v4.5, so all currently supported
stable trees seem to be affected.

I checked that the upstream commit cherry-picks cleanly onto the following
stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y
linux-5.15.y
linux-5.10.y

Thanks,

-- 
___

Taeyang Lee, Security Researcher
Theori, Inc. / Xint Code
Website. www.theori.io / xint.io
Email. 0wn@theori.io
