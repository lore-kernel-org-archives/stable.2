Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792642085;
	b=07yNYgShCuBMdNLUiVPSgSk4MN9kkzuNm+b4XgIN357b/yPdVzuNAR5V++8HXabpmdrc
	 x1yTykm9xJM3a8U0q5+B6hCQc2mxzsjvbk7z8cSakImgeNjorynBF6EN8inSnUoT+qSMX
	 PR8Qii3pIQJHgLd+INFVWXH3NyWz4dfvEz4K5i8Bbol3tKDBJ8YgX2VY+YuB3ghVCrZEV
	 CAfsUI+zjjpoYj+JtnUntsFvCOsbEQq5R2S+sdeukmiyFki/kjJS4iXKQJSxW42Qb141j
	 qXGsmWbOIjOFd2g6gy9P4+Vz0aRlogAjdWEWRPmSuxTNOuosJ1w8GY79AsqmxdpQOag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d7ZmiZYP2dbsn+AwXoo6pLxe8j6QIbtXdMPkJjGuZvI=;
	b=EJ+oj0e2aLCf8PPuiuYgdl9G5n4N5ewoU/24bgN+F2Z3wIOywRteJ7ldW/hVbUMFoUXy
	 TTmaeHCam3iazXLER3QSKfF0ekbCSTBUjiYNAfFMuzumtQIx2WCEboBuM85IwnHINzHo4
	 4QotUiNa6xsQ/YDuO3FLCfh4XucD0ciPTAEl6FEkhazS+loVvT07m50JR9JNt+pE9AXWk
	 TNo5C2/E5NW1aIVzTzF3Nx116isyjd9uRubtDX6IBZeXDYu44LooNtil4snvhWyufvVwL
	 9pG2dRJ6o0uWwL/gr5l5e8Nr5ubFoOsywdEVU8nEN7y11lML3c1+lDQye2zTgCY5blA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=De61s8He;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A314606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A314606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=De61s8He
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so11495605e9.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792642084; x=1793246884; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d7ZmiZYP2dbsn+AwXoo6pLxe8j6QIbtXdMPkJjGuZvI=;
        b=De61s8Heo9S1XYhRqmxSjzY7gAsNhPTq2vgOcgBb/WwuTyIzis7k+hVLSARONYzeuf
         8LoqQldhOABJf1af+nXE2PaSyg/jJZCPtfSI1O8D5PDD7ZJPxZmLqAoG9HEnDGnuGF9x
         3Xhhwlp+2Vo1W5dflcIoalFG488mARf91SFEOO+NQxYhl5iARl0pE52BGiIUEfcohs2X
         Q9MSL13ourqsNAhd7o2GYAwa+r2vU4C+r2sUvyMDP7K3DsreYMV5WhYnkjqz5eT39RBO
         QNaKrGmPB36NWVkpGgAmJm17noGhNbEoBsgw26l0iqedXa4jjuYB3RynjieDMRFndUk4
         F/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642084; x=1793246884;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7ZmiZYP2dbsn+AwXoo6pLxe8j6QIbtXdMPkJjGuZvI=;
        b=LDbd2uraRXdGDVCi8sd5ZH6VQijX85SvzDP3ziFuviAUKNg8wIGmSaLLwJA2UtrqKA
         MQ5TufTwPs1B7N7OqgH1ms66GqrnM7QOlZkmrYUAik4fnY5Rnj+8tW4KMfw60F9aWmEn
         A6VYn7NbZYgTsogIwKYRFYNY4m2TAShi7IfsTxiSdAZrYIJbStmO+bqmuxrvWVr/YvUf
         eHyJGm98PqwlPrMg6lA6vppivpamRCThH/ghVUyXBwBm2rGDF6E/82uCPljWX01fJh3V
         CRHP2ke255khLPWm4AnsoS+SDeIXMaoALZde4ayZ78mT9BuNVFC6vVn5/WU2uNZAkCFP
         pgKw==
X-Gm-Message-State: AFq9FYLCwM5DGJG260ZCtPx5IeHhM4+CeIAkVK/adzt598FSXf7I/+lR
	RdjNS+Bi8g5tzjljvot1227D+Jsm6I2LqtriAwdK43+jXYPJqKKmkF7++Rt7rg==
X-Gm-Gg: AYBFou07dLFt/5rKr0HQlQsH5CDSi4Lg0Ty4pxq0T4qxHN/Pd/bQmoSP0eb+f5KslEs
	ZuyvWNA0WPDBTwxMJucV9Z8TsUmh+ohKpF9XGE+FwSx8S+w0PVYHs/W67vlPku3NtA4dEGt2aaA
	LOlNi2WUpy1CaNY8025z7zLdH59A4apF7LBGbViKnRaUMVkukxBhhIScrpPA7GcC081hMcT/som
	fKcCUbR8Gz/Ie9VIfxSDQoZxEVeeOxbkw+FoIU52echOV6vEst++piAzWa7xgrI6TNsvETjw98i
	9qibO99EtcdZuWj1VkZKVDa7Ppnd4hXhz9PVnxvB9vvvS3McE85A57hoBa8aAyyEfIUIGERYa9k
	vjT1mSyT7J5t8yeDHQ+MSeeBDaWIY54u5z+tcsQhrq6hNQBStujK3kz3k9uV1Ok+tMi1Yqyi+0n
	aQQ/rFpWSVHoDstILZElsCjDEY/hIwXocSyU2sFBsk35YSA8FSB26F2B82CYkD2UNYbwiV7M7Mf
	9Gx8wTAbi8vNR7erUqnc2afl1+ZMI0Bq1KTyB+HjGaQdN/GGQPW/P5A+vxVmutCH5pr8K1uQUC8
	vCM6ATBb50O9ujisORCIylwUtuzGQvI=
X-Received: by 2002:a05:600d:6413:20b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4a1fdd20c95mr59036485e9.6.1792642083757;
        Wed, 21 Oct 2026 21:08:03 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.69.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm91457025e9.4.2026.10.21.21.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 21:08:02 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 security@kernel.org, Willy Tarreau <w@1wt.eu>,
 Sasha Levin <sashal@kernel.org>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Thu, 22 Oct 2026 07:07:58 +0300
Message-ID: <179264207807.19673.10894070663262050870@gmail.com>
In-Reply-To: <atXZxmkU9Yrv4h_b@chamomile>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu> <179236182769.4914.3317139682579833845@gmail.com>
 <atWvQFXJzJ434qGd@strlen.de>
 <179239012164.14465.16534329674629579851@gmail.com>
 <atXZxmkU9Yrv4h_b@chamomile>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Pablo,

Yes.  The CVE would cover the vulnerability in released stable kernels, not
the upstream change itself.  bb061d3de4170741 is the upstream fix, but it was
not backported, and 6.12.y still leaks uninitialised stack words under
CONFIG_INIT_STACK_NONE; SUSE Leap 16 ships that configuration.

Sasha has now queued the full backport for both 6.12 and 6.18 (queue commits
d9a6f49f787e and 1eed0466672b).  I'll send the CVE request to cve@kernel.org
once it appears in a stable release, per the documented process.  Happy to
adjust if you'd prefer a different sequence.

Thanks,
Abdifatah Suruur
suruurism@gmail.com
