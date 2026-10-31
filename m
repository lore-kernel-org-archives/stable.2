Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439754;
	b=VQf0mayuDGU8QMMZrSInOhZySv7KXtjdR7VAl3YZ2TCBgeu49e3Wg3eKmfHrLV9PDnM/
	 OvAYYKJZWMPBC14LUlRmN+5/GUScIBbiV7eyUFzQtRnJ3soPfkCd50Lj1nkejFD7aX76C
	 oCfkyY5OLflyFPamBsOGCj+OLkw2yX08K6qXceBWzQ6wLUrBF2vbLh5714QhjD3LsqTDD
	 Ij93nJcuBz0HV2UKCZej7Evvf8WfGp+1YIakPPp2yK3YGZVt100mWzv4i2wV2IGwclpRE
	 bkikzIDYg1TjyanPuKDVwIulADCGyVO1wnkyrA7c9wCvGtqzV+uAzsbs9HjLOU3N2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
	b=sckYDwS1Q8B87tlCex0QiWwWPjADg5DHrCahva27NN5REIe8WcxwC8eeREGGk5nATVgj
	 T0puP9EsslottSa47YoT3rjKDQEvMyqHZOCHIJL/b1XwG9Q9/U3yvDWmhu5P/vDTV1EZy
	 7z4gBAxKObSAMJXC/mwZkdeOv3IOxJ80oDoHX/zn/3O6swOzqBzkODh+TH2J/Ac/KNxRq
	 QFVLiUx0ZQY7ia9MZC51arMB1Pj1aPktwrR8A0momYC30JDV1wUxXWBRhVEwztWkHtS5Z
	 2rJ9HIPdPQsrdrI+Z2VYPyNCZUZUR7W5i9BDZJL7R5QGB2Y5Y/9t+bGuxUaktZ3ifgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWgLEKxR;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D6606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWgLEKxR
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35b2c599f43so1111659eec.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793439753; x=1794044553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
        b=VWgLEKxRcfS/9ljvof9oZChkCGzRlROs//Et3cMkFIm/CL80NTVURSo3AWRyZekSuR
         D3yY3CoxtuzzGJA1U2ViHKXlkLmHTv4SeI64mNZZfkoueIDd103ePYKLV89IHTdXJvn+
         0LAs8aMhALUyyvcp/YZkwtMm8X1nGSVFnPSYmQK5v8aYskVlOIj0tuOVgaUAodzL4UPz
         NUA8j3UAj1LfgrgBj2MJygQcHAWW6a0VpkM1wNqKjm7iY4rMvODMi1MwuS0vqOrKNazX
         63P8YBW5C/FAfpytwd9eI0cPMHg6irpyJ1Jpdj35CS+xDza99M+gWz3Q2SfXM06vqJYY
         or7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793439753; x=1794044553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
        b=XTxK2djSiXjKdMDAyL+rBzmopmp8EITGqHxow9dRNSvYzPADZ9kBgeKMnGKSmd9p7O
         XRAlhcCSHumb/1t1Lyj2pK/n+YsRcBm5UfCmM39YRNYp3hczXfCYbMHa/QpIJ/ABzZAz
         wCpIPQ8JVsMwBZhvcwpzYFI5cDp18YhxiRrA2ycyIGETvFMAgT5B6rrEOaD2c2rTlPFW
         WblMs/AbIIxmiRHee1gzAPtMKrOgTErQwAZpIFUttUFdw82LfU2YJq9NF9LA/+fZq/VK
         SHojxqnsuqnY2mpTp8h+YLJUEfpdPNRQmYB2bjhfRp59BOLQFzQUPvwD/TgcDBljOEfc
         Rsww==
X-Forwarded-Encrypted: i=1; AKwUvByWs2aIz8EWaBVEddJvgMUwTVWxqgvcj0jjO66wTutMhp1dCWzMwaw4gULQ7GxAp7J0LD1iWlk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqFd1863BuuJwPHz51KrcCL1Bk2sqNr6F4jOIuVx9KiF1kFDgw
	XZUniz0ul77D51Ffhl4Nmr3eUtIjhbE2IvKFHP2Itu67ox/06p2GZ+gN
X-Gm-Gg: AYBFou2MBGt389z0WcTWF4xW1B1iCU5x5RxQKk+WT3Joxfld2oPgdcxAWfLqLmc+uXH
	nF900ZLgKm+64b2akw4xyzRTUrUjA/urMRsepxotEhNv9fE7d2lRRvOP26dgula8Y9JAYeov6uB
	Yg4WMWBO2wLbnHeEFsLx6T9oYFO4bTzkUOv2gmqqkf5x1la1Jh+os2nKSlpy1MADd/pu6gLAQU6
	3rTCf3seOZmZcm6oZGM8e6uvqoSO8hTtM+3qKiorrGuYpVuGJ15SteGHztqGYgPnF1KPeSv2ZV4
	oGvhLQhqSpTWVyDEk439aBfovQ0XsRMmop4ZcvbhbWBWV+p8zmkgEjtqoR4yfb8I7rSFSq4//2q
	+CzlqSSY7UIxJ4VQ0msMLm0VBv5kOuRabW1kmEswSlzWGbeq7Emi27yN6VVxcLJb0UShyV6+x3P
	tG6rXofjPxeDFKVENbD0MzTbPX5CWO63nD21MJVCb4Fsbq2ZdtpAw6UXqyjXyFvnOrvHrIWuvR3
	VIcXyTJ0gTGEORDvgbXXOtKy1xn1q8MnZ/LaEQ4JuFnWYTw9QJW2uy/Ed8eYXsSTiVtfPfkAalx
	mBBDoOAP5IZ+V/DjLLHbiGzHaQWxmyNOOlmoOZnh7BtZAiBNYDCfaWRIhDdJEzK6N0lWqwfaKYP
	eJzflVvrQSOGHmhnQ2WyKAod36Torz6mGVIvhEjWN
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr8382142eec.27.1793439753023;
        Sat, 31 Oct 2026 02:42:33 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm15758617eec.7.2026.10.31.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:42:32 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: HyeongJun An <sammiee5311@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	bpf@vger.kernel.org,
	Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
Date: Sat, 31 Oct 2026 18:42:12 +0900
Message-ID: <20261031094212.2303487-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
References: <20260822225444.2774461-2-simon@swine.de> <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com> <apC6-9YqBpOjFLGr@krava> <20261030012258.3005240-1-sammiee5311@gmail.com> <auUhrnOOUWY3Mb9y@krava> <20261031011900.1355507-1-sammiee5311@gmail.com> <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
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

Sorry, and thank you for the correction. You're right that this was
already nacked on the list, and I should have found it first. I'll
be more careful to check lore before sending next time. Sorry for
the noise.

Thanks,
HyeongJun
