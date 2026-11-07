Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018650;
	b=EFrx3v+Tq85kEDDV3gftquQDhW6L8yPgKaDnUiuRElmrg+KmcPsT86vkm7ktd2+x521o
	 rfRL8yZ0f36v+4uilWR8zASIMF3cWICbFTwwMtF4giCZ8HcKN3xz/8K3IEU/ubEL2nHL6
	 Himlw8oFIU9YWRUN1ROchwJjkgj1oVn0jPGQnMPJgGudiLm7czXKsCpXJ0ILzKbaPtMdz
	 IBeBKdDDM5paAxWDQz5XvFpYtvdztNGZ5L2mbsCkEqFywZugTxRo5NdAGeXPj+HJhYWaS
	 CvA+I+/InfFfEuAJrVVJ+NqfBubcKUoYLVcTDtsV5haoOsfyOqdR8wuj94D2ND+lfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=4VH+jNYKAK/KT2LNgkbeOuBdV+ReONmicyAINE41GII=;
	b=wyQz5bO08VdpBL1oGxltz7RMj8wNxT/O+dLTCCbeL7zbwJ6qpjMwS3Wgrw09oD++hRjs
	 nhmv37YHlrBXn3a2aNJOf21cawFjQh5M99XSRpmahexzjgUFYfTEnF4Ek+aKgxVuGUImK
	 gsdmZ+0/Ly1uOg0+e5KTR5PBzKUZnncdcQM6Nf2Eh3PZEkS9Q90vj9egU0p5MOl5poYdO
	 CRphQZ7007hTy351JGPOuZ5+BaUZZLkHoqlnOzCgspunTPIhL9b3SAEGhmdVEpDj1dXBR
	 MsE6PQKq/gMV9cJoNOB+w3c/u54ntyfhlxaI4We+VnHtZTRD/pof+nivbbx2ED8mI9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Ruk1IW8V;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03662606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03662606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Ruk1IW8V
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1adbf62dd31so1717576c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794018649; x=1794623449; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4VH+jNYKAK/KT2LNgkbeOuBdV+ReONmicyAINE41GII=;
        b=Ruk1IW8V4WrCf6g4icyhoHIs7NLr6j4CmjOQAX1qq269ZG3YQLEyhhEnkOsUgEGKu2
         5z7TuFnuZyvLlaJJu+mHguMboWPuTdX7AxaMjx/RdvFlzUhXuSXJzR8jNKT/JQi1cJOZ
         RzFhZd4Wzo/vNur8tP+GSMloRvChHWa2c3VEFuF7WSsKM9GcKxpxYOQ/qhzuWs8BxGOb
         udSwMW0/wGqUqvzQnGH2KAI5+TT3djeHsuVvmNDrhDj9IBa10fkrjEhMDU4rcvZ4rR0E
         iIK1afiiXnUfqcd8iMrahKOyI5HQ3jRXOMjKGDwQ0sCsX0MK+UIdRIyqgDVTCq7S6ER4
         SgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018649; x=1794623449;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4VH+jNYKAK/KT2LNgkbeOuBdV+ReONmicyAINE41GII=;
        b=lZpYm7EHOWwGgyGuTL2EDN8N2VAuyxDN7p+qsV4WFRYF4HwSlgs4Es4Wg3V6R8BMz7
         eSC9f4sMqZh9cB0x05eFPsZ0PpKma96+6NZ+RrvszXfyF25YIig4Kuv9zHfp+omGNkEg
         iHFQJaXZJI5NnyotTWpQeWiDRHjcE1znbb4/DZifd192I6gC7VPWXJuuiDIVy9B7BGfa
         f/qz4TzfWKIgOXGGywWZr5cYWPsEMtd5XZbYp1FQgMA/cN/vtGJS9aQMOIYqDChJU59o
         CARYHMLe8ktdK0UldLNVk5B1pxg5RlU1a9K0uXCnSNGXgnrCAY0p5hCV1aY7D+1PHL6r
         9ddw==
X-Gm-Message-State: APuU4Z8Lo7eRLYpQvbyRGdG6KRJXFvKbCs9KP4e8UJ6nfq3VYX0IFIHs
	PyUqu1FKgQvnH93xSr4BG7py4KfCcpnsaPzz9splOMjbR8pYIFEvD3DJ2r9X1PDLt8va/Lwy9of
	saTdP
X-Gm-Gg: AYBFou2ub2AfVs3xUaCJgq6w9U6720YEra0YKE2kDX/1c3Qkro9q4FsQrzhzRGSIe54
	Sastv888IP7yQjgKYlpssLuEHvnahrgNiVBttTPq7LHzSfawbVdT1Qk4FW+y4njLberrXfQ0Dq6
	5CPrIMRpRmEDJNZ1sugM9ibOxUWsDADUNV7fou7BBh9LYex4MIPof3l1BtdIpjsPp0AAnKeO5lW
	IPKdYVGTSCte37VnkXAYbJSWCNoGqbrUgSBLLrNC1UfiEseONzmY8aIYVloRIWVOiK8Jsx1ntwr
	BK2EFcpEckxH9L1DFllbXHz6AgNEaRZ3PgTIIpW8o3bsv1Nw4UeUvRpkrzkYfmxWAShBrBbNMpt
	yAGD3knGP1bMivF6rf9JZxrxmF4GT1a69i+TayXjGKx5bjX0dR097B1PMIuMMVVUtSIGFo9xzwQ
	jSdeaftI8/o665BBhduwtotdctiuCgMpfuz3FZJLS/cG3dLmUpdoH+dvzZ9BA53lBfhfbSNCi0F
	POejTZcDSCFmPWqm31MSXK9A0TaCT0PBspvJRltnLLo0ZDSWVRBFf66wjf/auSwi7X8o9BkMh3G
	TtUQ8o6QjU9gJtpqiy+mFg==
X-Received: by 2002:a05:701b:2050:20b0:1ae:59d6:91cd with SMTP id a92af1059eb24-1b25d392825mr5433882c88.38.1794018649038;
        Fri, 06 Nov 2026 18:30:49 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a63f6sm12536523c88.9.2026.11.06.18.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:30:48 -0800 (PST)
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
Subject: [STATUS] stable/linux-6.1.y -
 c75b0cf0982c00cddfd88d1acf3872f79b40980c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 02:30:48 -0000
Message-ID: <179401864817.449428.11590026533110787895@34406640b1f4>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/c75b0cf0982c00cddfd88d1acf3872f79b40980c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: c75b0cf0982c00cddfd88d1acf3872f79b40980c
origin: maestro
test start time: 2026-11-06 18:55:17.743000+00:00

Builds:	   51 ✅    0 ❌    0 ⚠️
Boots: 	   54 ✅    0 ❌    0 ⚠️
Tests: 	 3806 ✅  262 ❌  376 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6aee4fe55b429d354e0bf75b
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
