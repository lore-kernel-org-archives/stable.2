Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018616;
	b=D3zkhjfdY0aKjl62DyLRMWDFPULCTDkOZHY6SRVJmuL22WSOTWxQx+/g8uEoTuTGetQO
	 0PwjZ93Y9wIZVQ06ZmseHevyMcFQp193uDvfijUVOmpHJfIBPDdDSTSuCrWrBhGYuTzm0
	 DD+Fx8hdw1LhOc+zVRwr/eJph6IumyICzM9A2htpoYGvUI+GGBOWJvZpL0Pa6ROC5MpdY
	 IsgqGnBcBp+ctEbidZi8fClX3oMjtXwb0b4n7YtHkK1eJ7kyngBsxQ5NTBX02HDKF18yl
	 0GvkzaxcXvO05697lY87zOEqSUC1WgEW8OCpjnSlebzmT46IUnVQeLJpS7ZMNjgWcng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=plJrce6rOwxbLI9mb56pzdcEe+/bFNFOWhYLzNRCOAc=;
	b=W6lJRSfSYmi5fy7PCjLoa/JBmhywZFwPPHdd4vnv30ZJfCsiVvyUfz74uR9KsVSsJtnC
	 piEld1D1no04qnRaMyNJt8z6Bxaa6NZ5VIAh8gg4VUiz/4aAjJT63faQHfgfY0G2FBx0V
	 tI51s/oCvom9xBp/ekG9GBk1/nR5QspqWExe4UlOUlF8khqqKl3J4WsKZxoqy1agv8NhL
	 +f3kEy8SXr/FOpcNs4NTtJlC3iBsBGnSBhP3YgHj/jLAvu1cwldppgRbJClVvQ/+PLCOc
	 nYrmVVwdtcNFvROVV6Juz4nrVgmk6oacsV1X40zJNwrd1h9JCAXkraenKN0+BVP/uWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mf1pBrlO;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E33606A33A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E33606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mf1pBrlO
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36ff9c9da34so1637624eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794018615; x=1794623415; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plJrce6rOwxbLI9mb56pzdcEe+/bFNFOWhYLzNRCOAc=;
        b=Mf1pBrlOFAxAvkWjAjHWrA1wZH1nlQklMupOT5YoXOx65PM/T6eD5H5TKzL/2KkCos
         i/b9+D21ZInUOL84bZ+O0kqXuOQlsZcR/yyJlavf1ZP1vgPZeFZZnX6dxJahMzxLuVAi
         gLaKsbT906EV5Ll2HJ/R/5Vhi0wvizLTPLOovyT3lAjo56Bw7gHH+EutA/M6502uqC5/
         chdigChjOmgnBnruVVImQ4A8tgzTncxaIXpxMMRRg4OjQx8m4PEPvvgxiQuVlKDbArPT
         U0Gfqp7PP0l+WdGY9kVA0iyvrUQZSFO30Mevouuk3lMYruS0u0RJYgK4HTcXG7ReyAVR
         qzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018615; x=1794623415;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plJrce6rOwxbLI9mb56pzdcEe+/bFNFOWhYLzNRCOAc=;
        b=y1v5bBlVC0UmOoKMaPJHRpNTMXeK2MIedcKvVdvbqXPbDTRAesc35PIj21YXYCh5zY
         u0kmF1SMOYd3j+1G0UmQEQcCivd2xZLARGZ+D8GgAtZkblzMPnen3ZEfaJxyOXAT1YLl
         P2feRK2iA6qyy/dqNmOcpxpKqAifZJUNKJiEVj6tN7ld0V1Kv+OpZ+KjZ1vkfKgZYlkj
         T+QOjpIpWtU1b/okE56nsIaQBmaGNlsPthUnFOK/Y60ZFD2MQr2gw3b2AZYAF49UdBU4
         dflNQPcWEeBpV1yun75Im95fyiZeY5gH99ugtMLEuCUHwz+Q/TgA+KHmR7pMdJQUkCdb
         Kwcw==
X-Gm-Message-State: APuU4Z8RkkHdrf+JEZKsEizxgqeJEg8+20q2Q184b66gmgBLNcIJE4Wq
	kKycoYkiulKS3M5PVW0w7AAlA/Rn4kCbMoIbwZMAeaHuG8BDYaqL3/VjdMLI/HpZw0c=
X-Gm-Gg: AYBFou0g7lPBhWGLZM7crGPoILQQO+h04axETM+HMcTQSm4sBh6Mg5gE3RjNFhzB46O
	e8YyKuuQKnEmeRHsyvWydL5yJ/nFQcMCQLL2/Ui3lI2c2TeVYcRnGyUlRTJFylhDO4VR19HbYzh
	w9weCdUdhComAjTuTWkcCi/+pd7/jG1GAF4dSnFd0o0mygMnPutqCJd+b30aNdStFRfiHsINCtr
	Ldkkjd2AuWMUd1eqRqcCC+JCKBAAHAtSN8UomT1TeehOn0MN9+10eYtPe19a7zxTBifa5csbPag
	HTmruZaeL+LDFgvw3Aig4u9cM5ADgRHQXNGTulYkf8EW6Zif0lCIQxJjCBGdTpfN4Z7boO+k593
	0agQhoVf0qmWqX7Ali/jFCxhD4ZhN7nayON/gpQpoRL3TrZ/onKkcQWFck3b6cNjnR23wCT0AYJ
	0iP7rUrWbkX1yS+FDfMJs+FmxAiZg+SKt/P6ut/QX1yIwSnvfXzcI8OXskfzj+jKINJRou5RWg/
	OeaZ5lNCr2aIAUUVHo5mW9KZaD9xBq1JOJDed428jRiw31O/5Ele0IhFAPDc3urnrk4aOsrE8Lr
	1YjzSSui/ix6rruac17WfGKmiAIIYD7l+pN+2z1KrBY=
X-Received: by 2002:a05:693c:6096:b0:368:d0b6:b231 with SMTP id 5a478bee46e88-36f752511a5mr7212622eec.10.1794018614603;
        Fri, 06 Nov 2026 18:30:14 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm18495870eec.15.2026.11.06.18.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:30:14 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 3a323bc22b881a5bdc1646080f93f5ecb22850bf
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 02:30:14 -0000
Message-ID: <179401861383.449428.12035625351794878596@34406640b1f4>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/3a323bc22b881a5bdc1646080f93f5ecb22850bf/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
origin: maestro
test start time: 2026-11-06 18:55:16.889000+00:00

Builds:	   52 ✅    0 ❌    0 ⚠️
Boots: 	   37 ✅    0 ❌    0 ⚠️
Tests: 	 2794 ✅  336 ❌  469 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6aee33d95b429d354e09dcd9
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
