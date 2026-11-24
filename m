Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487453;
	b=1mkYp/pVHcZNCzshySHHzCR4YKmUS9E4QT1CLO+12zg12GKu2hfTV2u6G24ZSlqKXMo5
	 NfhtS7RXalf4YADNIYdOdRoVXzvEnf0i3bcML9onzT/EYOdMJCfWO1DKQN6ii1q3mIva9
	 6wUGU7MajOKKQGriBwbcnNc9KpkM89VK11ynrUVLiZ8HFWBRzC15J009H1wp1qvNc1aio
	 tA+vqpXDuoc/qb85O4gXbF1U0vXsGmPGUdz3Wrld8ekesuE1YBEp955bTjasQ4Hq/W+HR
	 hKLOowMU6dU32yrTc15QgPwjfTRKf22tG8+H6ejBZuc3J1U2qZ7b/c4GJ2m8sNl1Ktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=JjwAOTrj+keNSvre1xa1Aid1QvPQP2oC9RVDK0aaJrI=;
	b=mwT3ntgpuZxiY7CRj2p3CuVheBJRi3+3jM/9G/pu15BMpJu6RrJZxy26yqP17dTFRRXZ
	 INnusTkoBLn5/7ofwPm/3Xb3Gi9x3YI9ao2hAlZKl33d6Ob0xrdmdOE39VGJsKkFbStfA
	 7RxK5vjJ7D7crpSTwNQl9U1DL07qvx6TMT0KPC/Gb8fNK9e4EDVChMB0UhGtq9XsKbptG
	 3e87QmG9tQ47BSeZQzFeE/op2hmQKZkkUMPKeT1GDrNGjdIeYZS71GxGG6JQkVufhUeJt
	 BwBqolLL8lzKp8U1HDFsFFYUnABQ7Dq9iSulm3xWF4EZ5DiN8bq7kKKaVTtrJvFIJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=L14MAEZ5;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F3606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C0F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=L14MAEZ5
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38587f3de36so4846530eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795487452; x=1796092252; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JjwAOTrj+keNSvre1xa1Aid1QvPQP2oC9RVDK0aaJrI=;
        b=L14MAEZ5+6+VlppybBAOUG9Bw5C8eb9TehhzLd6/DAJi1f83EjHtRohInjBqhXhiXa
         CRKZMNwo1vhUojq64rbXAGY/E7vPywCzYPRJudi1J3C9/4JzcHf+iCaxQdozw6bU1T56
         E7bWxuP+x2CdzVhgqLpmFe3HwboFqRsynK58XlhsxSxEK4D91gmc/G1UiapAbew60Yja
         YX/mephI7U17Hyl6OD8zeTbTGXbk9oSuw3No5TuxQbCvKLfJ/kyRNqzy3LSMBQgQiQm7
         6WKpkk4OAZ4E5yfd9EuLgfowMARKrT7ugs8AckHWvmgZ3hbaO9dJc+Fc3CB8Q354wZBK
         5XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487452; x=1796092252;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjwAOTrj+keNSvre1xa1Aid1QvPQP2oC9RVDK0aaJrI=;
        b=2M4HXj3xXNGWks6EwFe0D8BMC5abSIKFDXlAZpxWoNC+UJ+B9QjtElJO91GpWsrEy6
         3wsgO1dyds1koMZ8xRW6wcP2wOe9kDcM0Ix8PKE2AZDRegeJKhRbXIEf/cirv4anf77a
         y0n7y3bgJ/kM3wwV78dbV0+WM1Hvrxa77IcafYw9YhcvKUEYQlsUtUS3LXwAnwiDVFbg
         ki6jUrnYDfB3GQuELbtEsi3vRExqsenVIP3zxEAnw25L5usEyW3i6vwPk0/3ndX8mMJD
         MeoF56ue1oDB8Z8nXWzDAIqzE8OvLFq9VYJBDUsxqpo+IltH3d04osMqKAt4/hTaOR5j
         m91g==
X-Gm-Message-State: APuU4Z/fVAYZ6m/5qE323uJKIKrEst2XVJfrZGPjSL+YP9w0NAJOij6p
	fA0MiCwLuAZWuOF8PS5+yAbGq/6s8KZe9363l0ms4McT3Igekyneg9dX12TuOfg+Gl8=
X-Gm-Gg: AZFdTZfo6ztHlKY9b+mB4qHzYN3xGciy6Lnt82XWzgQVP+hXfttMNhp3MbNNbNnvIVT
	sZLjBSa0Ik43XR5Wf0BaZOOs6ZP7YqDubOOAgZ12AEEjmDrPaOPmtsy4k2BPmJL6guyvaiW1ugL
	TZ/Kkj9/8yKUWMjTIphyB+38h+BcKnGqe2BofzA5iQhWe/CqWK/DpH7WkO3DVejPek7rnsE5e9D
	wMUCy/+/CcNvZ50KTPeXyu2V7ufkGdJMfDf6horsUxB5agMI576otJTk7SNjmkxbUfIOeafqsai
	Yg+do9kaW9un5YnoH0zoD28A/+loAGcFbjhuBnig/8ZCKAPf33EYRR4Ge78xJjRQkD3hrzZhtF/
	8VN7Yo8st4Z9eJhFr2REc6t4/PqPPHgbZyT/OdtC3FSWaVQ+YcCMQzRdq1KcH4CMwcpXNC3he3J
	ULDSsZPNf/QxaaRrjxHYSN0Ion7ZuqD/ugTqJ1tUcGAlQU7QVIaXFWw4pdG2aLNqDIcjCD9NV6/
	KwFEL1wZOiy5qPHZFieLlwI1eDre1d0bH431NaW+5BNi7MQm77iy023Q3eHl4X1JkFuDAbTCAeC
	ltmyO/JJkv6NUogq/pgqBw==
X-Received: by 2002:a05:693c:60cd:b0:386:98d9:d5cd with SMTP id 5a478bee46e88-38698d9d928mr11804149eec.39.1795487452228;
        Mon, 23 Nov 2026 18:30:52 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm16134922eec.18.2026.11.23.18.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:30:51 -0800 (PST)
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
Subject: [STATUS] stable/linux-6.6.y -
 e2bb30811e063ce0db964484357973b855b06572
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Nov 2026 02:30:51 -0000
Message-ID: <179548745136.20463.14502429277629612992@52d83ede7c60>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/e2bb30811e063ce0db964484357973b855b06572/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: e2bb30811e063ce0db964484357973b855b06572
origin: maestro
test start time: 2026-11-23 08:27:19.674000+00:00

Builds:	   58 ✅    1 ❌    0 ⚠️
Boots: 	   90 ✅    0 ❌    0 ⚠️
Tests: 	 8177 ✅  539 ❌  960 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b04095c99c74e1a99b2a4f2
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
