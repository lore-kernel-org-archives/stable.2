Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487427;
	b=5aEYLWhEUf3glWKZ1iUkjay0fHvHnHxEhYYhNCj/GZ3Rrnn7HBs7PCeKn+5wMbSqhCPW
	 Sx6faqEO5wFoLkXDoi/zw1vDNjvW9xdkhXPIWxyc9rKBl8VbeWAW66FL8o9esgjTrhWqO
	 SY7H7G7Q6IDcourPbVH/ZYjfJMc8Lr4d7dPcY4Pu1nFQivuyp0BY/5vdrE6JnDiWcD7K5
	 g70B5GpVmG0PQKzMmG8B5IW+nMftPZlfvtIbxXczYDTYUe5yLiaXOiDCXnnExB0ivcL8H
	 fqSJerd62XULbmq48OisolnDfl51kKzRksYpRkwXS7t39H7Jwl8cdipBB309qYNE2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=GkUAofqZmn8wNSSsEtLxyZKwZT1gXaChR1kYkKCjTRU=;
	b=R8Sf/9jWIEp/76LXRuApq5YrQxrm02yY52q405PGLCvABSrftmCJDiFcVNuvtig+hMre
	 ORK+40HKBb6iDACHyEd14LGNBs111C1+kuWzbTb8bugN4EN3riUybElsvkmGVN4ayk0Uq
	 6jpcKx+EDSR56yXRSWMljCoL1bP/gTr85qSmqxQ4O3KXNNwj406XGQIstaDD2xoMfoWTA
	 La/64jfQoXJHeI6ucaQbkTcNiUiCzYxOXpwZ0M4rjFxbZyzbqZOzZhZAiFQpFV/FBqJaS
	 YEAnsQZv4g0SdYfW19kPNaTrZDjWDn9mbJ13XGSxkWnVHDe2mdInUhtblGPfVewLBJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=TIfJv9Pv;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F74606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F74606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=TIfJv9Pv
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so3511015c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795487426; x=1796092226; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GkUAofqZmn8wNSSsEtLxyZKwZT1gXaChR1kYkKCjTRU=;
        b=TIfJv9PvkErmO0E90nFzdIasbon86MZGz9r0ZwwcEXkX+iyvF0AXy+Q9EMpyXd2czr
         UZvvBQBuPTFv9qssfuTdOnLPZmsGv0CaLSvhyzSh013yDt0RNbpno1/WcscVxZgdo7Vl
         rJ8ZDAqOey14Fpb993j9HFCrZtIuNsKkiF9fyNVYrF0u5P/QwJrhi5iGPVvVEihaFFg+
         orGyxLYLKr7uTnEng3wm5LJQwd7V68vdGSJqF/mOzS/oNXo4flK8CtcGQmYHRSBKyy3u
         C7x+tu5tTge28xGZtkH0rUZulEJovpNdU/ZjW7I42Y5/PmLt61BReJ+2csgPK4T1mCuD
         HOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487426; x=1796092226;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GkUAofqZmn8wNSSsEtLxyZKwZT1gXaChR1kYkKCjTRU=;
        b=rIcyL2ufSqpJb57rL0KEq2RXiA3ozaASYBBEbMFBWORbtSbn45uwLFiWrBEKOwut61
         OmByKG1r3/ivXkxHRAFWWjcTG2miIDeHqV7EH9yXSTYGkCIyQBjZa9q6b/xJOyD8NPlY
         C7+A2gsBrgENIy2iqdvBjE3Jg42jAXpvHmquHRYFiI37MDbT/SI6einNIflet1WuZvCO
         H5TwQ0sLJEl+0O+JzVSnp7H+2vTNMw82RP9F1FYniNYOOE70jJI54lIAl+iAluoka8cY
         Mu3wH9Z5fC+gygcjMOv4yBLERS+YCqNROkYP53TYrQDGsCunxqY9yz1s/iec/y1ftnmL
         xyow==
X-Gm-Message-State: APuU4Z+gUJFXiaGqoP6d+92MQJFM1RinMR6YYdQ9ZSjB79JOLJPiF2Gd
	3QxZTiLvyElykb4xVQtOOStADxmA4uvyD+lT0WB01Q5KBwJS/Fz2PPiSNwreP2nFKzYwaQJ8CvF
	H/f+p
X-Gm-Gg: AZFdTZfMR8SW36X8N9evEh843z8p9GsFZ58gwvrA4VgfJJTe/lpav1a1JGEPp617dyO
	rCSlPg5tSqHdp+jJs9TH9S7/uO7kzW+y5dcT1oBwn/7yYgsyOGH3qurTAUoBxmuI1akFYokcgyi
	vnFzaRu/1adzh0hma9OGQkbkGCNUnLCEzY033KdgTcW4ZdU839V7W/C5VQNC0ZkLJrrhpG+C/3b
	837vpXInQqIqhJzthYEOTcnZmmjX8VjapCYyNQfVCo9+p7reKK4vrWnThHKfxjkZYGlB9+LCoBp
	jRdXyArV//h7H1SPR7riUhgRmSysoz6v/pJK3HiI4+sk5PL1mYY4tlj7m9wTy772GWmroCIAQU9
	LToUh/YuK8iYl/xS/U9rLa18GnhNSMsLv2fA7JljvqG85Wxuik/93i84YS9EdEIY3wIsvJI7x/+
	6bkKDMZnQXXw6WCxciNX31R4knb73ZhjUWq8Ss2kNKlzvuHFXc4FjMP/4OVktC9aCrnTAGA4xdP
	klSBVAVkd0wdaWr3ST8sHQPhixVP/5xqPEHwG/It7i1ydC8Yq32HqSytoh4dIkvTE2RJdJJwA6a
	J0rie8XalvqKktJ6CHyRMg==
X-Received: by 2002:a05:701b:2814:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b5568bcbb3mr15809113c88.12.1795487425834;
        Mon, 23 Nov 2026 18:30:25 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm18952481c88.4.2026.11.23.18.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:30:25 -0800 (PST)
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
 99112ea818e35b606397c84fbc05e6fadb6ea162
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Nov 2026 02:30:25 -0000
Message-ID: <179548742484.20463.3308432490314547709@52d83ede7c60>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/99112ea818e35b606397c84fbc05e6fadb6ea162/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 99112ea818e35b606397c84fbc05e6fadb6ea162
origin: maestro
test start time: 2026-11-23 07:25:01.931000+00:00

Builds:	   51 ✅    0 ❌    0 ⚠️
Boots: 	   39 ✅    0 ❌    0 ⚠️
Tests: 	 3494 ✅  764 ❌ 1579 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp.rwtest02
      last run: https://d.kernelci.org/test/maestro:6b04809399c74e1a99b6a4b6
      history:  > ✅  > ⚠️  
            
      - ltp.rwtest03
      last run: https://d.kernelci.org/test/maestro:6b04809399c74e1a99b6a4b5
      history:  > ✅  > ⚠️  
            
      - ltp.rwtest04
      last run: https://d.kernelci.org/test/maestro:6b04809399c74e1a99b6a4b4
      history:  > ✅  > ⚠️  
            
      - ltp.rwtest05
      last run: https://d.kernelci.org/test/maestro:6b04809399c74e1a99b6a4b3
      history:  > ✅  > ⚠️  
            
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b03f51d99c74e1a99b1fa3a
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
