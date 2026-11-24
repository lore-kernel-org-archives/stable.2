Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487424;
	b=G9wT3LVARZb9ld2X9fXPZ3Z2nF03XO/sqRKZPwE8hdQBOJgjexuLnsYct3ihXbTjEqxr
	 TVdQSfDTv6x6fZllJroDla3O9m6ZDuPsZVje1KdFxvD4D2YPyh1RfpsRGUNTRT4cUzCST
	 RgOFgsMkMBHN9p6ujQED/hiplYJ8vH493WnNBttG7zOiZB8X+P1IKKiVLO1bD87FWyhoo
	 qOQ5euNtZ7cp8LXq0aOMFqYlO4LQbibFlZHSyTWgcQi7nWlJhrJCKS5JWczoioJltleKo
	 Hu6dMu6MEKZbjB50/jFppRqs8qcLh6r0I0KIudxxQydqEEcB/LVkWNzu9Ly3CEFyBWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=aQf3ycWmOmQjDlewwgerkswN05EuVZQpU+9SDjk9ms4=;
	b=nlKcZ3+85aVeXz9zMFp77gWUjci5ffNlCA2et76sxb9lUjWPEunfRKyWVYOn1X/tA362
	 h8+f03ZHBkqPpJKGnnZKKbk1YBOlqk+agUCu5Q2F/ZrH69awWRcMXNebQFrsSw5Efg3Kq
	 fWP4BVWPgvxysdGdHSgHLzbSpCTCGafSpYJdvchvRq3fzlWtZa9VBdeJ8O3QOxujyaPuP
	 ntdz8WG5I3+mHmHb5FE+ZjirhYHwhGM4x20VrGVjW0pwXPpDNdKPW8S75r83gaPic7FPF
	 6tucl93oyJBDIZIwWHdqj5BKcMqqushtEgmxmKzbM1Dcer6og9ji9+j0IWRgFTeYyug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="XjF5p/FS";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BE606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829BE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=XjF5p/FS
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b5786e099cso1683641c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795487424; x=1796092224; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aQf3ycWmOmQjDlewwgerkswN05EuVZQpU+9SDjk9ms4=;
        b=XjF5p/FSCPlUkVyqEOd19NhRFiBK9kWoHba+MiY1G2Z3btZ75sERtlykqeKkFAmlWC
         JKVreGA4XvFh1yVXIOmfVEm90N1mU8i9J6IalFPyt2wXlCPSeu9DCFxd4Y1bsGYuYkaL
         SldGq38PHTpE2ufFx4EhJh6jt7sYrDoNqAH740N6UC5yKKZ0gy4pi1uAwV4iIV9SzxDb
         ZfrlckXRGumuOG332I9lR5Bs1NiHW23+w2zvOgIBFZg44H2scLn1YD/UTLCbsunf4/lM
         3sU/zTm8PqtSSYk/+xKLW5YZj2oUx25kCnGKA16oNw96r7iylmJacG7WDFP/u1b3Hg/5
         twPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487424; x=1796092224;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQf3ycWmOmQjDlewwgerkswN05EuVZQpU+9SDjk9ms4=;
        b=P95nWHfXo0vHkSzpeNcuscZhI59BlaJX3rQiOohsiqsXh6EE1iRD6hbcZkWczrSz0+
         tj7Jw+IZGG6kXw7S7tdIMPqoN4UxWIJ3qCHaW01wB1D7JINz5dnXr+er8lyuV9b/SjeZ
         0SXjxEZ2iWe32uWG6qBDPLJO9xls3ZOJld0E2ntRVCFG5UI+nZNY3tRBq+JS9B5d8j77
         Y110oCRyTrcEpadnIKg4rifEcU+UNN16YRib3h0cklBTlwF+a8GSodxK16Ngldl4upkd
         W28Jae2OSLBZA36MtvDtbZaOpkG2ckMnmj+MtQ4uIcaB5bzBcdU56MXXzD3IG7rfmvAv
         hsgQ==
X-Gm-Message-State: APuU4Z+rIGv+xcyCunB51uodzYMLDM8GpD6K3duUWf2sfiNRbGN8P3/d
	kGSeIfo7zg/FeoBQ6dX7nf2ge7PZTQuplPcnFFPtUHcWCxBy1YI2QrGWqxwLmMHyU+g=
X-Gm-Gg: AZFdTZeKSVgC95C7NweyB6sG2oTfbNm2ag2+Bj+uGEjaaPfdRoN52JfOkrYuLV4Sgoe
	BMMPKjhlAKltsit8fs4+JRcpUPP9LeS3AnT5IktU463mi833oF2tK7cqccRHVMrIp5fALcEY1Pv
	QN8/aobtHBIkzUNwiNVzcFREYHCwB/fHtRaP44GYllYSnXHvbZ4Fi79QUQ3Za5tFgYFjcTE5CVv
	z7rAnqKQbn6z7EbEV/25YFOPJ5pmp7NtAdV5nLNMstbH57nJa2bLM5p5uPruNqZkfXU8pM9jOid
	VGxXwZ/6cB6JzQCxYoUeUl3eEaOqyvixZmvrZZ6BhRScnKuxcYnSrniIMqh5VUZplRaqOkB32gd
	B6fAgZC9AacNxYCQkLreCGmTzQY0VEAhBzPo7aGjrFtj8f1PdhYQfyUy3DSgwqtAMd1bzzcld3k
	2Gg0+7qwvOq51YIX2OfhUKxc9OSbJozEwYAhIZKpYHxHqE29ve3sS655KPdN4BH6aQTOQRUijBI
	uqu/QtyvZkRGpHVgqRUokQX95FQI2/c6N33lW5MzgEy13tF3GUMW5oN8pUCFNc9PP9jCeAsFse1
	23YVDmznDRkplTkZo3iZR48/VjpmM8uFjvHnk2u3bRwz
X-Received: by 2002:a05:7022:7f19:b0:1b5:281e:1702 with SMTP id a92af1059eb24-1b556943e35mr12490207c88.41.1795487423694;
        Mon, 23 Nov 2026 18:30:23 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm18952321c88.4.2026.11.23.18.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:30:22 -0800 (PST)
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
 4f2df9a01754521fbba3493e8ad91ef65515e68c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Nov 2026 02:30:22 -0000
Message-ID: <179548742249.20463.6316607859379085499@52d83ede7c60>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/4f2df9a01754521fbba3493e8ad91ef65515e68c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 4f2df9a01754521fbba3493e8ad91ef65515e68c
origin: maestro
test start time: 2026-11-23 07:25:02.349000+00:00

Builds:	   52 ✅    0 ❌    0 ⚠️
Boots: 	   37 ✅    0 ❌    0 ⚠️
Tests: 	 5313 ✅  889 ❌ 1982 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp.msgstress01
      last run: https://d.kernelci.org/test/maestro:6b04f50399c74e1a99bac72c
      history:  > ❌  > ✅  
            
      - ltp.shmget03
      last run: https://d.kernelci.org/test/maestro:6b04f50399c74e1a99bac673
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b04cd4399c74e1a99ba491d
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b03f88699c74e1a99b203d9
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
