Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487407;
	b=4Q7vQP/QKQl0r3GSGrgI/7jiymKTTzTA+M5wsYheFl/4w5gAYeItJyUXUN40NVfDOjvm
	 Yw0P85OeKXbIwfOTFIntbJOKFjle8MvSnLfWA3bt/2iphfVLigmga2HKatzp243jNpf2V
	 KEit0+kAARYnNe28n+d883N98xP4dPBgTV4tPpGGazwwQsZuLgMYRqW3e79MFwR7nZ0ZH
	 3+bgTzs0Mx05I6bK9avHaBykiBPSkrzP2thb3T4fIHxxEOw1mokTWSAi7r+sPCb3C7jwD
	 1q+Nd504slhbI6jcFRx9l9eTXljf45D05iuaOdyW21BQR/0rQ3cZIYw/qyE9uK0cd2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=VhKdVXiajAlzsAly3rQoFVUJppk1lFp4QS+MaISRu18=;
	b=CgLYGk+9ksKF4hPWZwHJ5A/s9wsNNaaFyPCvu9zaNzPNx+/PzADGhTUrn/Lip9wiX/6F
	 D9MmYnHuDYctPGqIZDkF7NUBeytUjA2c6ZMeNDobRapXSmZTF+Z2lLmhgJ3xjjgALsSCa
	 fN/Y8LlmMNn2ml9pCcPxZuJFb/AGJuIqZJnBcEYxWgigq5QX/A6EYjhxHGw9fskL8jvLc
	 Rycnc5PK/VWxl/Uo1CJIX9xTvtisSVOepJaNVHqrFDrC/S7CAjch/hgCyy5YVjAodqiGW
	 q8ADEv+pL3O2F+5hb156HFRSq5oc6IanDOjjNqfzTIQnlWqc4NOwzRw/sEMGjR2P81Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=J6scqJdu;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E97606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E97606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=J6scqJdu
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38431138772so5120021eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795487405; x=1796092205; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VhKdVXiajAlzsAly3rQoFVUJppk1lFp4QS+MaISRu18=;
        b=J6scqJdukchMi/qYD4XUCBvD38iRGJTJAMTDOyUz7N78Eap/3Vm1Q1V3klfYZlleN8
         KMe9QlMwJgcibGlMR6+VwxRIRLKdwhmljOnl/NYXKQ2UnvONq9XJ8/EX0hQwuL6d+zVs
         SGLP6d7GTRPVHp54XtRjtHvLQY8FtlCtrx7dsSBQIOvZJNxNpwot0RVoQKS5JwD1jzpm
         /4hLunU0RveX23/9IijAy/RPhBv3C1q6+cFAOv0nJwqAHoRFY/mHozQLmS9zCR+pQftY
         3cHTVHkk06mZxf+SiTRVkp5WzPb9AgQWC/LoBygZG5LkfixFWctoFtkXgZMeYEDKfFjN
         trxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487405; x=1796092205;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhKdVXiajAlzsAly3rQoFVUJppk1lFp4QS+MaISRu18=;
        b=fOUxy2z/hhnSeMXh2V9GHq1qUMSPfAZ/OiMIwnL2t73CBoA+NlXBOHdcrmjBndevGb
         /GE9qIQwoMvxyDlkansh7ni1ju1WJT1WAogHrhf1rkymuuixJpBzVmCH1Bya0iCDGDIs
         RxhwT9tDnITOENsEZU3s21KsB/QbZwjvhjnJU+ZuG0XtqVwSWE/OulAGtIWRnBvv9jev
         oAxHcivUwyXeLm41/TJLVU+CoCOwxYMt/IXOM9sFJV+qu1piW6u/do+S5LN/gl9gtmxM
         7MIvkebL91DHMnUy+g0DfK560NZjiZE8XAXaL528I2JV6AVHKTlN1142uDs7YIqJRitI
         F65Q==
X-Gm-Message-State: APuU4Z+wXYiR5uDDMYVYqa9E1KpxCoI3Edz2f3blLmxJHeaLJpdWHKgR
	cQ7mir9sOlRaddRyJK3IjKh7nRhH9VRe37ugjMECF+bqMVVFURRN8Erz8ZiVz9M9o2kc/w476tE
	FWwzY
X-Gm-Gg: AZFdTZc2fVK1xThTdx6tFoOTPUWNoHjG6cJHIIuBaDy3ruWi35znIWuuhOZfAlpBSn2
	7WODvAuFDpB7hzDCOLyqfFvH9SJ1+fUHuzkNtIjBGr1Y4LsZLpTjNaDleIuxBzmJ271fTp2qdGz
	Re1QjWjsghtAc3KiSLiCmBtYj/HvWOTYBT8aXJRtnBHT6pgg7LRQnA/F/6TcIN/WFgHhwHhLvhL
	E+kKH5ZRTO0AkyIUEhRnQldWCK7NLxl14bhTWtWEycgEzEYCsU/U+ahvfCTGRXW9wbSYyXSpOxV
	oVgctt+sHep1/awoT9uPX7ANN1cosXcJAsSoKkXJe1UanvKYd/SFPLG6w328LfSCVP8N66i3kQ+
	/hpIKIAOblx1NAMg6IBfUeZ9bMgG2thFw3Usn3g9EjY4lDwnXisYD9erA+Ok6ASwG5M2IiBbNL0
	ZjU0MgM2t7s5zJ0bViqLhRJXqbYoQKmFf+6rImQXBEq2+N7GD9nD7LV0nTFKzPF5ZljyjM1kQKS
	rNeTq+axoBCZYAdDJ/SuDEbDJLat3zyq66yvt7bdMRM17eJspgYq4F1caFRelmb2GJ/vY3n5rYi
	Dzny4iL6BL+XavJHwshO+w==
X-Received: by 2002:a05:7300:8816:b0:385:5b47:8aad with SMTP id 5a478bee46e88-38570451daemr14755533eec.19.1795487405201;
        Mon, 23 Nov 2026 18:30:05 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm33549000eec.25.2026.11.23.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:30:04 -0800 (PST)
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
 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Nov 2026 02:30:04 -0000
Message-ID: <179548740405.20463.16988540763358442848@52d83ede7c60>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/1ca1436ccc68275d0b43b6a730b3940fcc46b7c2/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
origin: maestro
test start time: 2026-11-23 08:27:19.253000+00:00

Builds:	   53 ✅    0 ❌    0 ⚠️
Boots: 	   58 ✅    0 ❌    0 ⚠️
Tests: 	 4823 ✅  357 ❌  564 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b04088c99c74e1a99b29ee3
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
