Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733233;
	b=kt4tOG2xo6L2UHIIxlDRTVI81XXIQqPOE8lduMFxo+dZ8sN1dJlTFOcEyMo1VWW4UhQ9
	 sWrmrJWD8cwaf1vuH+xTe6n5W47vED0ImFR33AbhY6A/kt5rJIn61ufUCCC7mTCQqL6zt
	 ecvHhlglVdUXeJ25WULtBgbaLdAkBxVLIsc6QxWNkW4ZRRgYNglc+RrZJGQC/vIder+YP
	 CH0O8yzdQJZT/q05FarQxu3A9ay6Q1CeM85SJneIUvX6BupW+wFfLTEbWX4JsRiuZqK40
	 mPACYi44Al3nEha8epieF260WtCxNvlamJpdRt+lROf5Zo8ItuL5Oz08TsvQkh3nqVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733233;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=FFUTR/JA6nAa1DpBBH0pFXJ+C6Keo/R5QzSW57SkZMk=;
	b=r7gNdCoJOxgfzwlfSa4LZprCzQoV4ZRzDtC/Q8Cpm3KRNAzidNQ2uuWu4L338i9RvZ6a
	 hoaDUSEgF85jHrAUHZdNyy24BHFEaajRg1ncsrG12UJnqs1/250sgK8hhPlbmjMgRxRPn
	 mbkbXTd2vloKR8I2PMRcqms/pYGfAIBREBrRakVG/yvuVHtSxN/3Z6sF0rg6rijnnFpb1
	 ZVOfppuK4rTy5tIrapy3Ty22ltxsFkUhD1vd3JeCPOEbplirwxhCYCXuSGgUVN7EPNCLi
	 /6hI44U7lYoUZujwvJdir2uRwf7P8tz/Jvum6fqHKjTE0dTxFHUu3JyATjr4JEcIMEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=MuqsX4PF;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF1606A31A;
	Fri, 23 Oct 2026 05:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAAF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=MuqsX4PF
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j9s2v58DXz6cd5;
	Fri, 23 Oct 2026 07:27:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792733223;
	bh=FFUTR/JA6nAa1DpBBH0pFXJ+C6Keo/R5QzSW57SkZMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuqsX4PFwQXqBG0Wk9Mz828hFF6X/uvZeErrus+KJkzXQ/YvmoraBiozCTH9BwoS7
	 F32MI5t860bAQgt57h99lhzRNE+fPm/l7/qDZbKwC4ebxjT9R8VkCQ5Ho22IDq+glx
	 X1+SafED5Cxvp50rdXYxxla2qXDNoVNOWq1v/b1is/EaS5mAMp8+ELJ1VYYLyhMdKE
	 ZaJUs3/UMKgPrfAreaMUmnHGrHK2HHgPW+0ejWQf6yGZjHBFcnTY4lvhv0uXp+OykX
	 LsWUqzYvKBSPMTZ4Znd29MtfSUCdv0YfU9svZoyiTy4P2fnc20wjjvHzXgFOksRVxK
	 s7BMWM5iKbmkQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j9s2v4QHdz50Y9;
	Fri, 23 Oct 2026 07:27:03 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j9s2v1SGnz8svH;
	Fri, 23 Oct 2026 07:27:02 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 40E305F878;
	Fri, 23 Oct 2026 07:26:54 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <31e74b63-54d2-45db-87f3-9a08bfce268e@leemhuis.info>
Date: Fri, 23 Oct 2026 07:26:53 +0200
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
Subject: Re: [REGRESSION] 6.18.57: ACPI fixed power button no longer bound,
 ACPI power-off ignored
To: Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
 stable@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
 "Rafael J . Wysocki" <rafael@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261022162655.231431-1-fredericmariejoseph@protonmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261022162655.231431-1-fredericmariejoseph@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179273321459.850766.16824659496419507410@mxe9fb.netcup.net>
X-NC-CID: BLHMncqpqSLzrB7TkDKTD6DdXRXx6yiU8+tfw8iYBmy67w7Jqfc=

On 10/22/26 18:26, Frederic MARIE-JOSEPH wrote:
>
> Since 6.18.57, a machine whose FADT describes a fixed-hardware power
> button (QEMU's q35 machine, so Incus and other QEMU virtual machines)
> ignores an ACPI power-off request.
> [...]
> #regzbot introduced: 38c79dacc8063ff8a0d75ce2a900fbaff82ad94c

