Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557188;
	b=UUz8rbDvZey62HqxMvOFUqnvsX0MjO7dRNLGwepuwlvpQbKg0ptEc5ZqYncsq/+OJgbT
	 AmhLspkVHD18fMXFi61sUO9q+qoexcc6hJVbgU4FrsschQTLeBjkRgxqdB0ne4EOg4u5T
	 AwQjxubUk9hIhasYOnGa77p79I67b5Xw5xAmgEwjj6uMo3Mh+E3yU0Fs3ikPzfxhVQUiN
	 AqE7e4l8Jybry/IKBsTX6s/uOslQL3ySgOz4xOaGEWYtw1p4AheHWlU5y3FDrdTEtt9Mi
	 Q85XjXM9Nog63S/wLP+9m4yF5O4iIJZuxajTVw5Do+B5hlJJjR/JYhXGXd/zUly9lWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vn3URFnRIWVoIF0NpOGs1A1tfVNX7pqnXS/S+sLc+LA=;
	b=x32eIyjN7HQQ0KfCFshHA8FP4RR8VeuD2ct5SAuqqo/j8wae68/wXAfp5u7R9iFyc884
	 fUo2HQAfs8QjEP+T+XRZyQEF/g4jdOz6yCiq5p5raqZoBP/fa4sp738l3dkKT3YLDBGdr
	 wZyueH2NNOQz7ITStaGPHAomMMgF2gcdJdbrI62ZyhWZcd5QjPfTaPREpxni50NUI6p0Y
	 G+Wd6igqopPo6nEoutzSFXLtw40CKiOfc0HuylwugXkQCos8zDsLYCyBL9wZ0Xn8FnNXQ
	 YJ8Io+xL4YDvTPGNsVhxQh6MJQCx2Y/Rv93t4BfV4m5S8J0LiSQVRWbSQfFA92gJisQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=CWKarD3k;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B811606A33E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B811606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=CWKarD3k
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385d8a00598so7378442eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795557187; x=1796161987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vn3URFnRIWVoIF0NpOGs1A1tfVNX7pqnXS/S+sLc+LA=;
        b=CWKarD3kiJXkKxEVd0tigM0ZY6z0A2tw5zJ8V8bwvVHj6FtfhbWw9v5UN2Y5mzQ9/C
         Iyicn81hc/fUymVTOxJb8hsaNthuTd/Z/yflzONLHT7O2c58OtlZizs6ntWrWePaFPH1
         EI4TJwKHh2vs1F6q1/vx4iMAlFXpHFQrzU0c6LTVr5A83iLq9f3gEUAQnmeZVJQzUHWN
         4LywJnA0UKEBS6uxEgKPSkxT1SWG3FRjaJPc5pKfTMDRpCYTk19MfWFitD/4+OUIO3Ij
         fmdNSy1nS6W9tQi4644QdJdxx+O35xscL3XZXsFE8Wm064MiQX8NQyNfNZSf51vapf7A
         6Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557187; x=1796161987;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vn3URFnRIWVoIF0NpOGs1A1tfVNX7pqnXS/S+sLc+LA=;
        b=Q5GLGtrY7TWU5l5tfY95blhMVxEPC744C8iSThHPjXQ3xZFeI+XNGRD7id0QbYfuH8
         KhVNduLZYtd4XTENSIhEwv7vkxs9IWNft5X2fxjJi7TWbXGfEjTVpVAlfv29UPDgFYdq
         JNvDuwqkABId8ik+3kS1zorHjEtPYTX9vq78+Zsgav7BefwD8MsVg8B3Gll2Peax4asX
         SONnHJxcvs/t/HNolcQQz/Qh3qXD6HDt3PS/cRYjL4GoU1lHI9W90Si4UjkkGx/9/SdJ
         HPYKuBoZCKshB53P5uh+WBrofFwxSAF0rrFukhnjVXB69/pdX+Z9sFbEg1ZkIdbnOK6Q
         tilw==
X-Gm-Message-State: APuU4Z8Hj2DHMSPyV8nITQuJd41/BFQz2wvLbygWjrUeZVRxh/+1neMU
	mzRu/V6zdG6xMqB2f+IKEb8iZ0kA8DbhRa5Usn8qFSkZm3wbVeSmqRG5yAyOyoXJ1PBDuDcrrIU
	gBkHR
X-Gm-Gg: AZFdTZfwpqmeGDaT/ifR2KFqjzjvMYlWKGlmY9SEt9NB88PRINuH+yDViPoj+D+CCyd
	fOGtJ1fy0BLXqYEUTTuojjVmkgvBVHsjryPZuckeRVWhwciJj0XQD+rfDYWJwFBZFRjJE5dzDeq
	Crg2vAK2/hsEv40Mcj/7cVcinO8gv6gsAxkPQqi2qwhgApCAXxDMZa8HD2UcBorqRnnTTm8NwYZ
	zgyH9mis0BgIMcpqMqDh3EyqqaWHLzDTl+JvlGmV3m4j+oklt/zveRuLZgrA95ssjqkti1zz5L2
	dNFbYHn1qwE3s6DrzVcGaJ/7rp+IQ+djAfjImc+W6I7ZaRbA2GdHbP0LHCF6VyDDQYf86nDcWTV
	T6xbSlCj7WkQYihXPPB/UVOO3odLa2jTceFAshRbcVow4ILGyUyWqr1n+SDKvwckHFI0qc9weTt
	UkgrMJ19GjyWYSkEU5cyhHahPZMxj0l+fX1Yo3USM65uYhMJbYtOQCvcD0uDbRNO/sabTiFMzNX
	1+kPhwtAu8WI+C9nSkLrR62BsKYqcrNXVz/BPDbk0Mg1dgE6nGcq4DLCZx+bRmxLi6KjKxe3jv5
	m0ArPZ6uBNAMV4ctW4KTG3wSvAPpbcUROxMg129xDphzb3ttjLE8wFiQeMDy/jWiubEu31KrPn+
	6qaqp0XAwIALgkjCn94JTpfzUhqzN4KHC3svrbpAnhNMqlWc=
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr4406242eec.32.1795557187272;
        Tue, 24 Nov 2026 13:53:07 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm84442424eec.3.2026.11.24.13.53.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 13:53:06 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: kmehltretter@gmail.com,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Subject: [6.18.y] Please pick MTD OTP NVMEM double-free fix
Date: Tue, 24 Nov 2026 16:53:04 -0500
Message-ID: <20261124215304.40737-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please pick commit 26300879cd8e4612dce66bb8f6ff7cd35fcf3e59 ("mtd: core:
avoid double-free of OTP NVMEM device") for 6.18.y. It fixes
CVE-2026-98834.

If user OTP registration succeeds but factory OTP setup fails,
mtd_otp_nvmem_add() unregisters the user NVMEM device but leaves
mtd->otp_user_nvmem set, so later cleanup unregisters it a second time.
The fix clears the pointer after unregistering it.

The fix is in 7.2.10 and in mainline since 7.3. It carries no stable tag
and so far has been backported only to 7.2.y. 6.18.65 has the same error
path, and the patch applies to it unchanged (one-line offset). Older
stable series are affected as well; this request covers only 6.18.y.

Compiled drivers/mtd/mtdcore.o on 6.18.64 from a cumulative x86_64 tree
using allmodconfig. No kernel boot or runtime test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
