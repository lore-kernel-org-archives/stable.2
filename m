Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212361;
	b=QN5cJYJE1L687iv4of1BMbGnR/k53WH5IUU1YlEYLeVKiv8UX7huv5+TFomLpvcgyGtu
	 LHOJJusVMjQWwOvoCbUDXBipahx4q8dH2uovCZiw0eX7I2OD4JmChJjq4bIJ/8KOiRzkV
	 BQHVKjE3+x44j/fR52V4w253d0cKwkBZAITcil032G+u0dR0pPXpj7L81UswFeaSjjjcN
	 eeyGWqfYw3oc+bfpIc04aXOHuwIkc5RpXLOi92IGqRde0XrgWCdh6MiTUkAPq/i+Lajd2
	 VfHwawQjEpSBw8eTne/vK8xn67Vx+4e3+fzwp0jKS09cJ3TPgcctkT7M5SpMDXPLkfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212361;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MQjTDUAdqsB2ZwXwkKil2fvmlh9qXAID1s9cwaNjR/c=;
	b=Okr5NPzjfBDHydmUf0t8v598Zs4AR1FCcv4k6+2KZzuRv7z6W54Ws/BCosTc+W5ODSIW
	 +B+mZwOB7dwL68B/N2i7WQSW8c1xL7GmyRNDy5lEVM/ved+RpRPwTbY3eOepTYw9O0bBA
	 zToaceM2BpgmmqtBC43aEx+XwSORzNuh6q9c9MaTx4U4Fz5juUfJG7l6KuShsQI/gFet6
	 w6vReFNwM4o9p6fGIt02rvvO7EV4MpjNb+kuQJSPUU7fMbz+m6Wsml1QamLFJdKPvrQ1J
	 dtj4/1M4O5W2gk8wvXgmmIKm1m4uet2+hQzrOU0Cg2B808DUcR29G91YxbapmBJhHRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=mapjKNFB;
	arc=none smtp.remote-ip=185.70.43.17
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE7606A321;
	Mon,  9 Nov 2026 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30BE7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=mapjKNFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794212357; x=1794471557;
	bh=MQjTDUAdqsB2ZwXwkKil2fvmlh9qXAID1s9cwaNjR/c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mapjKNFB8/mI6loYYHM/TPdto5Vgx5ZEoPXNA6b05pVO7WkJpWc9UkNa1trt9XeR/
	 Brkjty74tw9h9vUNJWIdhqZZH9yLw6vqpYfnhGoFkFbm/edyEux9XQ5iAgyJjytF0O
	 pAGPIrYKdL25ZWLN3MeQJhQhC0JRR7NCXHuKCaivzJVJ9JO+d533P7kwRM+EedKYd1
	 Rba7mxcKfJEaP9tNTAjCBjQOEPX1wA5rzb0rEXdjVJanbp16dztrS01uoV+ZlP8CuI
	 fPIlLwaauZ26jpuL0y1eCYupffpnBmookUwyphfP2AqARyQeH9jAAK0l9wjOHcBpCq
	 Z33p0kUBgvZsA==
Date: Mon, 09 Nov 2026 08:19:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: pfr_telemetry: keep the state until the last file is closed
Message-ID: <20261109081906.275540-2-ca@modelmiser.com>
In-Reply-To: <20261108233900.4043941-3-ca@modelmiser.com>
References: <20261108233900.4043941-3-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 24dd41a28a074e215659b3aaa058a3b6fb022404
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuangpeng Bai reported this bug in June, with a reproducer, and I missed
the report when I sent this patch. It is the same use-after-free after an
unbind with the file still open.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.3508974301899957212@=
gmail.com/

Chad

