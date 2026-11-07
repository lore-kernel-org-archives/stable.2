Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018614;
	b=gfXVjVKZ7jMPzKwUNRRPTOrmgD+GLXgyHbe3ce1N/7h1sxaF/hVuMKjGjXvuSn9lriVn
	 /YwmjiBpl41RxDZXVXu+z8GfzNTVZ3TJ1qz64C9kDSMtSIpx1pHEXCky17RsSErBq14Nc
	 sWgDkuXkSP1rZKTf/RiKGCWPKaQPvWj/lfjqBRWGIeFl/ssrPCsjZvy2W5Vy7ewm20EJf
	 zikV37zyysjwovP1EY1n7Sms4BOdaBUFHi+LB73xAyLu9+jVmMacQLrnaZngGumbho/yM
	 5PbSWuQvHCtEP/YVK/2BCHDxH4rIuHTT32z1lPdoWMWbUCFy+OiIhR0IBzSeS0DbVpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=IoIJhhaUsmSZjk5BdWPxFz0wpq5c42vOgx+Z71ENnS8=;
	b=u7/PLlLictVC5iKdEqzxWqUDRFEIJ0JXo/J7r63ZjyGgbRjlOZFO6zXeGPDYZucKST2T
	 eyciGSwWqF/bhmXfi4EvBvxni0snCrHIuc9fVhz58EionczpgAlM2RKgMu15KNXqRrJdr
	 4LzE2hjzxETEdvb1K3/4uphljHJE2JE6swoMzHc748215Y2UyQv+5OF99BcEJI2p9nUcZ
	 SYcWmWnDq8IzFtQZ4Z2HzYJ8/4Kq5DOc+IcW7byNaFkfevZQr4Q7XfeA3v9Btdc0z8ess
	 nD3TviQPDbPE1uI/fBLo9q0MzIdBLnbYRN/kh+qBzxn38e3V09yTMBPsu8/drl8Rhhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iohDbeQF;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F36606D803
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F36606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iohDbeQF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2036306eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794018613; x=1794623413; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IoIJhhaUsmSZjk5BdWPxFz0wpq5c42vOgx+Z71ENnS8=;
        b=iohDbeQFXRKUxDZZn8Xr9zzMkD+p1+th14748IHIuF4BjEaQpeu9lOQR7vFeW9MlaB
         XySDimSCF6cg8SEB0MDeogzxSwU5lgj9T3kpGciFNEUyJctCoHIombZql7yG1SgI5slN
         aezQGIXIqMKZbDEuo6Oi2FCnXEptrwU7FmZIfvTgmjIJ8FOmKhmrVE8GCMJk/BIqIes6
         GzXVElqqQ94UCx0u18UAEJm+7K7f/plYUWBeMGYXnNIWtfcXMoCaQDhzBcBL7b8tTG/F
         aiLR+Oj51njVMyPQOuOyge3f2FK/7JmneSjFwRTr4/uru9GUz0fQUgYh4m9SXrMldswv
         jPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018613; x=1794623413;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IoIJhhaUsmSZjk5BdWPxFz0wpq5c42vOgx+Z71ENnS8=;
        b=YW4PfDE+tTd8T9Lwq9iBLa/jpo7mZBotv9Jv+AAS0hLWOhOOClR3uYSXkqajPBqu4h
         1BgHhke5SYjjS1uJGNiJBV60W+J0PLVqUVwC/X+dTPEUXX5+pE5e5a3nJZC1hdVXBEsC
         gUV27fscih8S62327lpRjFqdLb34wkZ24gkNEIbEY/GccE+i2kYigqG/JjDJuPerNNXN
         Cazp3vvjB0IefpNwBFoEJf5oKARAvIAEjSoap6FAG2m5k+LhRojR2x8I3Jn4lFAcc89C
         W2VOgpPzFzDZ8yUSE3Do87vdNNbml9AGblQLXoplR17G4XzvvAHc7JtHUns1qmrsjAwg
         jVNA==
X-Gm-Message-State: APuU4Z+KVCLcY3lC/fNU47kCB/037VVE6EKTA5hhjEv4pHsD5rnC9H+W
	Ytw8UNVQb0qdDXY++bc3VpkFqje/7uDiekqp2TClaU8VFRCKXPWXpyKcuPzU9zr4akxyqCTsWTN
	BEoRr
X-Gm-Gg: AYBFou2Hd9j70fm+qJyrAQW+A3vu/cCW8DJGM5xewV/J8c8WH2BG1zFuLkRPjvLJ/nM
	1Uhx7tSlqbuTumEOeTZnJY+24WTR590KoUJ40+LXHPLDkUVEUl2n3zsdjpDd+hSPISDx9HMNXTA
	v4WY8CYh81PZlGXD09YTYkl8U5Cy9y53qiC1xvrJgNjegbm/UpN7y1l2f1qiV0CnlZkSQpHFWbE
	6g1wT8y67uSMe5l9Q7nVyBgVjiqM73xwI04LZWQFFJvGfqjgT8ScHoF5/eMyhYqgVBZQCxOHcaZ
	qGrAo98K4ox7g5ehEmWY3BnsJT4mId5M4LboRe8IsB1V7LyrEjQ8OgSnODF/EBNt5uZcMWh/6Ey
	TY7Ci6GX4W2h4qOV4TydgiYHGkDTjsfJc8xlY0iRsGmBZj9iNXg5k0LU1WnzmNkgDFw+O/T/hbp
	QD0xpvurHtADdhVSn5n/FBjAp8gK4HpZYMD6ZpjJtHZIYsRORRE7P4AMO9yyrTdihRodJ+H/tAZ
	Z6JMQ0koh7z0G9QmHzgoaImCfLg7TcSjMJioBBnL/VC+1Yr6Q4rBffcOIOqMEadENEMUsewdMWP
	9UMhEA4xpdd61SceOnsumw==
X-Received: by 2002:a05:693c:4006:b0:371:32bf:c633 with SMTP id 5a478bee46e88-37132bfc7bdmr551862eec.36.1794018612773;
        Fri, 06 Nov 2026 18:30:12 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm9511956eec.21.2026.11.06.18.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:30:12 -0800 (PST)
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
Subject: [STATUS] stable/linux-5.15.y -
 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 02:30:12 -0000
Message-ID: <179401861188.449428.15511723600524044129@34406640b1f4>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/29c6cdaac04a6989a7ed4ae4275ce4244e617f58/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
origin: maestro
test start time: 2026-11-06 18:55:17.328000+00:00

Builds:	   50 ✅    1 ❌    0 ⚠️
Boots: 	   35 ✅    0 ❌    0 ⚠️
Tests: 	 3107 ✅  320 ❌  320 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6aee57325b429d354e0c8cbb
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
