Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192593;
	b=TG2GF1gshG6gnMDcSeZaxuJidQ9mKO07Fyu+IGdN/MfatM3/9Q9K8cIYRRZXPIdC8vom
	 Njbgk2TVYgaSmUfJrmopWNS4DnEnm5E51GB4adrfbnGU61z0/p/OSlI6J+oLq2sr2vzz5
	 qCgC9yMlwq8FyHar353m8dXr44CuOaGuNUQK7scHsuUw1q7ubipcASIMJQykCjE2gplDw
	 DY/f3o2kEBCGJkFGqTN64AK+5rU250fSI+Fhj4zhyLqPHgBLSXKPwwV42yIpyCNj6uYsS
	 GSyOQDgecqQrsst4NlTQ3jxDWBdyJhOVuu0T94tykpTjZZrELTf26oNvU7NF6yedzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192593;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TCHJhQ2/VbpYPCu0wGNcmFTWOl0tkhhd7T5k+lzPoW8=;
	b=pOHGTIsntcR0Xx9le14e72wUyOJ/XPeASLn201TTWS3MpNdYGe6r57+LrfL8tg/JKQcx
	 0gRFcmYA/9vd7xVvAYCQWdpleCvApF8jo5CF2EPPUltR7yO/Iyz0o7ekeCldiEEhFzqCh
	 xVJa9K2aK2ALS8DNTcuSbMiyveCM3Bne+EjbQsPwoT49vSjh/YmWCnaoUvB6k1mzZ9RDa
	 Bhskav8g8UxlouJtHZEfCd0tvdjmYrHvmtdpdFOIFszLoFoPHhk0PZPZWHcAJ9+Vse5yo
	 XFvyXOj09p18sDC/QKD1y2wg5VnUxoes8sS3vzSzOKN3y306rY1wwWwh1Z8uFE8ZTfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=nJ1+7KYb;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923D606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6923D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=nJ1+7KYb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795192590; x=1795451790;
	bh=TCHJhQ2/VbpYPCu0wGNcmFTWOl0tkhhd7T5k+lzPoW8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nJ1+7KYbcB5jo+Am/FeHvLEgIATqMLXvamsY3DQL10+N9Ooy+Y7exXi7FGkc/in15
	 iaTFqTYL9/+7o4vyh1Dldn89O+oRKdmiT54r7cKgtaAyfEezFCp1XcdyR1dwfjDH7J
	 eVnFy27M8oQTD77X2zgpSqSIoqe2J5D+KsWVZdlQEX5JOiRTn/8lV1Jj5p0bVFzgnE
	 N2JZjGymPfsdbeoVEwKU77WTO+APwc2F483xiwYcCbkrth36nlPsPPQitFnmMI6VY6
	 6MQLjPPVAocSPVBBolQYyvA4tCSt+xrJj49m69Kp9X805F8ech8k+YdkIEykUGnlmJ
	 B5Lk2GCn3NgiA==
Date: Fri, 20 Nov 2026 16:36:23 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
Message-ID: <20261120163615.21429-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 96ca51afebb2f71b026ceb62afe24bde01959978
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

Built with Ubuntu's config (Rust off) and booted on a Surface Pro 11
(Lunar Lake, Intel BE201 Bluetooth over btintel_pcie). Ten s2idle
cycles: no suspend failures, no alive-interrupt timeouts, and Bluetooth
up and scanning after each resume.

The debugfs_create_str() warnings I reported on rc1 are gone: no
WARNING at boot, and the SoundWire firmware_file entries are created.

Tested-by: Sergey Lebedev <lsa.uz@pm.me> # Surface Pro 11, btintel_pcie s2i=
dle

