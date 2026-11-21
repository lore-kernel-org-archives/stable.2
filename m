Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294799;
	b=j5WqeZca81OtnY39/NXsScUK9OAQtNYBemjJXz5WkrUTxdm32J4NhAxa362KvsoC+fGU
	 V+naB1UfYpEBiVDnMTnEuOQb8adfoBNoYMNp9d+UQFgEni9PoDVnWfj9AigpBDFLbYG/1
	 X4lUHR3oJGswoP+DPBIZSaMzV3BpeREVwBZ667HKU7KSCfhab9+fjSb/SJsoEJzyEN02+
	 f6ZVhMuRTrvN2NPTEIr2oSkizpggFC87gHngJIEIB75IaUomCWTcJSDRE+XyBZnnl8OzF
	 nBq/5qGCvjc/nzkry36QUjKl/QTubsNbEkUR87pECZk8tNJxMXiTup68mLPzAW1Vjfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
	b=SYBw69m8ZHHgHKTnmsn3tbC+yTl+VW/RIw7g76DdN3N38E9hdojYIDyupqBdDsz9bD11
	 EMhwiMmRLHHNghzlC2wOOq8d3vlY1z+cQVMQoARFAgxXU/FeLBBnTpH8U9PcKTwVe+mSM
	 UHI9QnJXHT2vaK7dsNe5qeKmWw48nKaBajFVTK2LNzUYPbo/EZTI+bJKLColjbqaEbjls
	 uWq+eCHRXLHWXHP6SJI4bCrqXg3n0Nf9x2XC37rp1F53iUHStO6Z7XTS+tBMLDMUSJCUA
	 Az1UtFgwMxUMahfmAEVBfKgtaYxL9s08Wl1NV6Bw3VVIGtfmTlmXLikx+fLxsAeaYEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=lvjj7xOd;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08318606A333
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08318606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=lvjj7xOd
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so3220349c88.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795294797; x=1795899597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
        b=lvjj7xOdw3xTA4GkmGztyREs3+ozvUTHWhnvNJgZ+DxBrXYHSARYgIVqE0UJyKYRJq
         dm74/jbZ4y1n1sd270cLncz7f9DBhoAY/Mp9/Gn3QmQNW8Bais8ObIngA4JAHKprOgvQ
         Gwng0HJDwDlfNxVJ942VYOyzl9eRWgTBJDgWm3QahlFJh9C2oLG4U9PKC+V12BS6yRWv
         zCQQZu+JszG9I4DyzAXIxv+3suJ6jXc8mA4sQoy2yZv+oOJPYsld2bxYfmdxhTy1JylS
         vMTHUUXnUaDZVf6mJi8j8hEZp35f39V4wUcQ6K/fivTDUCBGDyBOPzrh0K/eipCO3ArQ
         WB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294797; x=1795899597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
        b=XKnMDM2NoktcWSmDQVwyPphSy8xB3nvYaC1eatOoB00iVcsacA6xtAlMO8eD+lFXWi
         LSalJgkNXrT9CaiMqDOVU+53s3LUgwaATS+gCvYxbwvvAOh8X7dExsdECDcaGMaZrKFG
         R5oPGG89+smU1+rsvZmjmhcYlTVEQnvuKUgPItrSF6PW3HH18guu2lwbi2x6kmjYKgyp
         2lols2I05rF3+esJ2mwttmYBjvem7+ni6ZTxiH/FFprcarmMx8I1vDHvO//7cX1a0UYk
         2IoxDIWZ1Cz6u5KK3Q4hO1XEGtP6jpqn9jE0XwHqB3SgHNWGzRAg+BpCRluuEh5WmmQo
         23Qw==
X-Forwarded-Encrypted: i=1; AL+hErHqMYQhXZBXyhkwvxC0w3ZZL84Nw5PDWnwz+HnAKDl3noa6kH2MPoZD4Rr9jHtR3p5JKgD5XY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HAl2xfFFEP74FqOodmmkmFxaMVd09HUrrdhp7riGcP9e3vLMG
	08AGyelVVkO/+4zgZocl+S+MtoU8QVV6yrohVCvSfO9e73HYpAib5M77CNPzVG0d7lw=
X-Gm-Gg: AZFdTZc34G8ZIxRaUkOI78rxmkqATY+dIIalLxTEvcJOBl0Pzs2wRO/zkQPYuO+f61W
	jf7LR84U+MzQsSIPC/pIT2MGzIUT5Hq48bzBf1bGK41v6Kg9zfXzl5JI3dAtEwEY4znZJFcKQps
	2HE3aYMK2BPDgMMxq3JEdh/WAntVyQXwuTDhc6fdz5jjWlCtcWDOYeAhZLLsgTb+RFy4Jw9grlX
	UTjDAPl+TpKYS8e6C3Qc2aQyVrtj+Kyuf+saG4L23F8v9U1qAXUKHQaBUt1ywHs6z//VueVomaw
	EB1mEhc43hLQ6z870hKNgKL47MibAE325KltWTt4VZB9zlZ87W97gHm6DfKrektZCv6fI6NF/9M
	PVrsdWa5mJ/dym+kWdBmw6YmpueNlEYKUajUzYHL5YEYO/hFSAcR6MAzwSeGJMgEoG883WoLr11
	yO18Edi2XllD/N/sWm/d1HpXsyt24gJeFiz0p5Imqtv71OION0KhJ1zu9z7I3C6tufiFS+MilNO
	tlYa1LCY3/kCHyqjBc/j/AoFCm79oUWthuuX22ZB6GBXM6meCrKItedoFTkTc9FRP9h0TUPp2yw
	/93lg6ooKlaog6jCiU/6lmIyqaxKG7EBLQ8Rv9o4RsJxWi+VQF/TyaI6zpXfhO5ZdPOg9WpTUhW
	oyVjbRuPPIggPBeJIpzc2txtMj/UPLjQh4Ds4CIUuKhNIh+DU
X-Received: by 2002:a05:7022:b051:20b0:1b4:e533:ff50 with SMTP id a92af1059eb24-1b556912ca9mr7773791c88.40.1795294797090;
        Sat, 21 Nov 2026 12:59:57 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm16445888c88.1.2026.11.21.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 12:59:56 -0800 (PST)
Message-ID: <c4da472a-1f3f-4676-95ac-89a4a3ce4a4a@kernel.dk>
Date: Sat, 21 Nov 2026 13:59:55 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Luciano Lo Giudice <lmlogiudice@gmail.com>,
 Ming Lei <tom.leiming@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
 <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
 <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com>
 <CACVXFVPEaJ6oPOaoZZo_XMpywHCzFWSYCrKG=srEDpCqPRp=Dw@mail.gmail.com>
 <CAFS5DSEp13YPLwRut2OiQfQqO70s6whbLWmEQ14mt8_JjBfBRw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFS5DSEp13YPLwRut2OiQfQqO70s6whbLWmEQ14mt8_JjBfBRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 10:52 AM, Luciano Lo Giudice wrote:
> Hello Ming,
> 
> Thank you for confirming the apparent fix in 7.4 as well. Do I
> understand correctly that no fixes to address this problem will be
> backported to 7.0?

As Ming said, 7.0 is not a maintained stable release. That means
no further 7.0.x releases will be done, and nothing will change
that. Also means that if you're running 7.0.x you've been missing
out on a lot of fixes that have gone into all stable releases and
upstream kernels since then.

Just get on 7.3-stable.

-- 
Jens Axboe

