Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833150;
	b=bxY/kIbge2qPv3InzR9cHqdT4WaqtJ5Kaz9Ctme/C8Jx6MbHcDKsNIUsCY5AsEMK8GRC
	 H4l1GrYAlFOtilSjzLkB4q7GTlrKDxcXnHy4LuMWr8VSPsBl84bkkFJ7U8nK5lq1/yjyI
	 Bh7y84rnJ6bonAWHrGDHJ6PLDrZI1txBfsNjWeHQxCF/RVn8u8qCoC07BV85/zDUD9f7h
	 vJkWMOF1Nq/XX13DkCeiPsbwU+tium9nkMkun51XGvTXpTmtUlftJW/omA6aAgrZzQgRo
	 m7iSwv2U+N+a/23DSd8vY9FDlhKy2SabiYH+dLgzBp9OS/pXLcKu1D/YWPQB6st4aRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=MW+9n8c7auSM2p6+1zvDR7XrKDVuzHPZwvskQby7Yjg=;
	b=CR5roA0lyDfmHD6cp6buH/nTnTBXXmQQvKKw/YvF36w/PHLtlXyqOR9OHzAS/42UDAdJ
	 RcSVWBN/I9xOe2/acXJJi+JE16Ze0tPh+fL9hwrHg+s9VJYkfEIonijpt7NFaXbFaw7Xu
	 sslH5H1W/wX03Z63CHXSyxVqG5u1KhwqjJv47cEz5hlOEaKJrqD8cuW6XQA4AS5loiI96
	 0RRhDcw9ZA3vFCXY3Zr4A5b/brjd8pkpsyPlLDjl4zEGTNJUFqZhhImOSjQL4vRbhDG3u
	 HT4eOWnTAzP99KaZnfEkRMvYkpzQhixANpAZG+IpYBckGwj5jZeoJkQgtFOCljYMNNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=HVtwiJXE;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74076606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74076606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=HVtwiJXE
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2142620eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793833148; x=1794437948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MW+9n8c7auSM2p6+1zvDR7XrKDVuzHPZwvskQby7Yjg=;
        b=HVtwiJXEcrcrf2Bl3KqF4pf3O/SfcIzYOgKSOnYXQv3JgnZ9B9dCSoW6SoTn7huOlF
         9TNHpwSbGYBdZ577Cl9SzMcKneqqXim4bd/QIoA6Ola/dU/CWi4j/HZxNT3PC+YKD/Me
         b5FedQdAU8wV1weFogW57cObSyuwrO2l1faE+aYo1NQVeYk9WOB87CeiamE/6Xin//2x
         mVRZGcb41e5FQ2BiRe8AYmV0WCulH20VmkNDj4jNp+UwCURfJxIIRqtuH9dEBu/u4aY7
         nbWWgj5iSpIIbiEQhz2zl50Guv98qFydsZq3qaprB+p5U/oNhC5r5cLQQ0bA1zLL6Jn/
         lRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833148; x=1794437948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW+9n8c7auSM2p6+1zvDR7XrKDVuzHPZwvskQby7Yjg=;
        b=DU5fG/VZZJQq95ug1uqR4T1sZj3lKkDVtYEfyPLIXvxkt4XNjHsXwgf+gcKSRZjLmk
         wA1cMISz1i8zyL/oG5wB6LlKT8YcIpgBoco3M8+9CV7+SKZNgbKXGjQ8S9oPwPG8G2iA
         uZMvQEF+IX28ZhtFc8knWzszeEeVmojbqT9ewOPEG1K/dFOVPULa9LPvVx4nf8WY6y0c
         12j+AweTrtDu1jHO95/oTfX59WgY7Plv9DRWDPYQamQGE4m609i2uDQ8bbyjrUUbMKFK
         zIKR4gsiTDJGe7xnJH2d5Z58F28UlkLn1dzbBcoUnlZe6zTQbqaipMoyS/yyKDHGZi+y
         4x0Q==
X-Gm-Message-State: APuU4Z+kkJ5QqtALhV9eUBKFuyEHg7Im9UXy8MPn7UMpHWR6R/AcCzRa
	6RJvYVrplbP35A+/u9scmthcfSoijqzU8YzC8lVuu475Ao+/I5IeteiL0CK3D8AF2TZryIdjpy2
	eoEJ1
X-Gm-Gg: AYBFou1hxVxT1qlEw5CEbfDpActQXH/YV0OajdcnyKTK1pZmzElgyTsEj9jOJ4Wkmix
	JAX/d/O6d/OoSkTMTm/UtQXo0jDiTm/ydPVhUZ3sSNkAL59nh/wdWPrtwj6IeQ6EXgI6pqXu9XR
	R7YowgYb798kaQxH241FRFsv7fCF98uZKTXyQYECIZfaMs5rL5Ss8Ze/gxK280HGIYKWgZs8u4D
	Tl3GlxEFJPwhFzhI3f9rrN5D9/uEYML80p+e829/RiH4YEtU3TveBSrAgEDZKat0pqrtFofvQX1
	byF1ArcDkXN8X/rav2J8HFRZVGprOvxYTa9iL+z8lagFNh13fKrxRiy7+RuF66w/I0tEMX2Zvkf
	RRUc5ujChf0pn4NtK7W1tnj967kgSa897/7Fb9G0DBlVNBkorW3rGy22sD1rn2G9Ght+p1jW+l2
	8X8iT9RfP1LOqdX48Rb1os4OaSqq0Z2NSxth8rMhqrDS17tVN8eoIQAQXcLO9ymYxEvWgk2kdoq
	25ydgJBbm4OxCDVWMAuo+vmekAxxBuudUYcm8H4R2FRHlIy0n8pHZEgoYh+gnc6IO7aQI8cW7Hz
	n3RPCPHSVx8T6rgU/yI5Ng==
X-Received: by 2002:a05:7301:6184:10b0:369:fdae:c9fd with SMTP id 5a478bee46e88-36a423935d2mr25204983eec.13.1793833148500;
        Wed, 04 Nov 2026 14:59:08 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca394c2a3sm11020695eec.20.2026.11.04.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in
 /tmp/kci/linux/tools/bpf/resolve_btfids/libbpf/staticobjs/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 22:59:07 -0000
Message-ID: <179383314739.333747.15461988752939138807@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in /tmp/kci/linux/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o (/tmp/kci/linux/tools/build/Makefile.build:98) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:72f4e4737ea433fa6b74528d8afe97dd3d9632d0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7bb6899c97e42d33cd49ada817664841dc972f3d

# Builds where the incident occurred:

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6aebb1715b429d354eef1c20/.config
- dashboard: https://d.kernelci.org/build/maestro:6aebb1715b429d354eef1c20

#kernelci issue maestro:72f4e4737ea433fa6b74528d8afe97dd3d9632d0

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
