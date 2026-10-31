Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413838;
	b=QtdCEiSOWzJ0sPFn5QNSKw/9z4d7nx6D7qvGyurDYz0X3aGKzk3/ssBOQLXQ2FY2gI/T
	 UqG5JAKgs7iM5dmAlbK1gylKQv5gdE4bEXBgMzHfie1s3anWqFRphGJO/E8Y1IeLLQca0
	 61pr0VT0AyfKDwNR5jch3Zm+hN7BIv+Lcozn2IQwmZvVdsWIqtzMSWKABO7POVUHh7EQ2
	 88RNZBp0jsmXCCw1Dhz1AfG5OO9x7PVXroklLdeZo2YC35nID4yjXEbz++h2kIGUXVK3u
	 0lLT7OVM25vvm8sOdwjccEE7Xh/ubZTHq4ODrXa+uPXGyEnd8RW2FMCHQ2eCjlQwFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=OK+FiQSp/Guhzzc8Wz842xY0LyfEnU2n8YAlkYHkVNk=;
	b=Z/VT6M3/mp6ZjOyJzD7x1awy87HVVfnWGwDeKBrgGJqOWcE27c+Cneu5EmZGNmTkGkDe
	 1OO6KIUTkzRaBlkQm4EhqsahfqGg50Yi6Jdn0j8EyF5fHXL7DhA6w7h/QjqDXAANl+H9E
	 EGV7q3CGX/jdagIyMKEL4+oWfN9buGb4v9PHQy1KZSADfzOKEOFaCtAlIOIFI0gWJ848U
	 2ztWCebmx/e5ZV+AFjSAALIPWFnkWSEzONuzzc8usGZ5fVVmVXNbKg+iueC4MdVMeC+Ar
	 oyK8XkYgmKcAjaDkFCXgTTSZYg/5CQaakAudANK4LUWqJ4QdB+boPdZoBgiX3YgUc0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="YaM5aF8/";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C4606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YaM5aF8/
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1438d9363fbso1019537c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793413837; x=1794018637; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OK+FiQSp/Guhzzc8Wz842xY0LyfEnU2n8YAlkYHkVNk=;
        b=YaM5aF8/Xh1Ite5y2+Q3m9+H78EqUP3eI31uPRqIMsGZl5mBE51wo83ctkZbXh2cnV
         mCMO7Xzuv8h3KVJK6457004KpUFOHNlb5TVkBm0OrP7oZNTqWxgrAnahNjkLKz4JFeSa
         LLyRLqRYgHcJl9MZ1/ut63lqhAHYVZJkNa9P8bjTuSRCOK7i6g+54pkQumOBNEvu1dH5
         rVl8X6CbhEcAtwiJWWbU+IHamEzG3BTGE24dlJwd7+7+RwgYqg4uf8/XDd1USI3rMuDd
         CEGnHSgKVVoeyTFTvweoONsla71OlxvNb+jcbP2PPZ+zSydQFT2nC8hgDm0I/2KNlLKO
         LcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413837; x=1794018637;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OK+FiQSp/Guhzzc8Wz842xY0LyfEnU2n8YAlkYHkVNk=;
        b=EImh5BfaGLfqBB/o2u8sMMPfZAvQ9Z0OWBHGe/uTr3qwsF2BlX26c9kMAr2QMX3o94
         n6lwRtAJIthXVLQXaKSd+mL6HLsBxIKih2xgUs2H4drgMRCbUgsKSFCZE5vRoRBakQBi
         /T4caBRPQQtEujtn42t7FNAxFUWJ7ILb7M6pWTj4flbT9RLtfxaBquOEpjBG8BAuN9jc
         cB64c6JSG9hhKXaDNY5jeMKEoyeY3YZrOnlphXRSqNqQSJmJo5xEyaU4YIa83JhBPOkJ
         rPL8jK7cNafM2D4ouhNDEwCuR8WOrjF3DsBoKZ6evNH9DwsDx0DUt0CxP2/o8WLwuqvo
         IGmw==
X-Gm-Message-State: AFq9FYKtroSWVIwQovszDxXaLXWWNl3krn+opiAjTcM7hizwUVqjkRtQ
	wf9xSM69wHy5qYjYU6ASNiREtNH60eESWM02JxLbsP0mtti22eoHj19E7VR4pkkcEIq1NpBe1h+
	Y7ZPG
X-Gm-Gg: AYBFou2HgIPmFwtYm/G+7JZQsXABk/028giYVKQIMJmYn0gXbtuB/RUkikvLCnUF2iz
	iFlJcQHporPXrhnnEdLxiW/ehCvjLpm9IeqWCTZzk3HiWM8PW+8CLsl+RohabWUDDmaaYkaqeoz
	mCA0XdqOxy3MuVpmgKlZ+jGHVH9s9QzlGEEd0JQacUT2MHtutY1tfTN/UxbDLHgZSjMU3UQcdhk
	nDaELQ54EKJMsHU2ohR8RMG/9R0YwUxwzKYAGdgKMrpe+mxkYsGurW2W32YhpXZ+dUdWPpjhlFi
	BUzO9ws+Q38loiZWlYZUugUTUci7aierDb1IeiroRyWf7pYra99X/y+zRGx2Ub+V5kXNzciJgN4
	vgsHL4lAnm/ZjWXRy7NrKs5ILwHX/jaKdzzVr5xurW1Gous/eOLmAU2O/XU4T6pvei4x6U5MjZo
	fGZiYxwvJ/ouhW42ewF/hljpjUFwkYbFX2jNC68k5nuaPDWc9h0yr4dl1VImmfNdzi5mvPssyiv
	eCwce/UkIgtu+f5tf1IEnzyKMKMuBDmdQoP7MjkIDphuLcElKFbs3jiz3y8ycwaA1V2edja9hCX
	v1Fietqi086UW0WGi378ag==
X-Received: by 2002:a05:7022:ec2:b0:19f:cc98:f603 with SMTP id a92af1059eb24-1a9420e4a4emr11394852c88.1.1793413837427;
        Fri, 30 Oct 2026 19:30:37 -0700 (PDT)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm10516666c88.23.2026.10.30.19.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:30:36 -0700 (PDT)
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
 b5a1dc3ad4822c6edfb53429e9a3759c9b0ac2be
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Oct 2026 02:30:36 -0000
Message-ID: <179341383650.70610.16689247145559220718@34406640b1f4>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/b5a1dc3ad4822c6edfb53429e9a3759c9b0ac2be/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: b5a1dc3ad4822c6edfb53429e9a3759c9b0ac2be
origin: maestro
test start time: 2026-10-30 12:34:37.737000+00:00

Builds:	   55 ✅    1 ❌    0 ⚠️
Boots: 	   89 ✅    0 ❌    0 ⚠️
Tests: 	 5553 ✅  417 ❌  325 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ae4b5406eff83db85ccf6e2
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
