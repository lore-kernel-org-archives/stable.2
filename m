Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018619;
	b=FKf45p5zq01mILhNalSV8ulzmTk0e+vC+D7y6fZyzj4Axpp5/90qbKPfslw8UFQQEQ0Y
	 rw+qQmnei+RgcFmUSK3jdL4guFTr/X3EKA2VQTfugAcdwYP2g7oHZnEj6zGU6plLqFcoj
	 vvqUnSrz3hbNrFBl3zns+2ev4MgZ73q2WhezI9x6/l794NsDcgM233V9Q/kEjuIKd6Vx0
	 Ui1ZEikhwwt91a0duzm0EGbDdzomhQdpphbELwh6Vij7LNWbofElCj1upRnfUKNPsFI7l
	 qr1NsLWXqJvpYFg/8DXVLoFfG6vGfMIk31kPFuxopMQRXTX1692bDhLiQfQbO6wO+2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=nkEGHivME6CszY0Ky5TX7nnoI97YXSUiRaGdAVuRKTc=;
	b=NLctNB/8mO+MVFkfPKHO2w3Tb9IgXABhPt3a/C3W72sf6t4FKVJH18Lr0/zN7UN8fO6K
	 T7bsPvuGkj0maq8aqaVy+8WqHL/OUVBGcE9WCM6AwFihfPDiBu80gLZ6Ow6t2568rVuNd
	 HltCVxakmUQKLuZIp+VYLqLhudGPqnrSLeSgIcxBETHqT0y8h8PBnaffeJDq2kE4Aqeb+
	 DEL3eqRbSoSY16KVxBHrRswOf/sw4fDU3zWCPbZ69Ee1WzlNhP00sbpm6JDTaIr7UymYO
	 wOCTiSG+Ju2JPYkY2EuuusS8sJUNCQRpDWiaDen+McT0g55zfLLQzT5ordHWFr7PQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QDqxwFho;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CD606A335
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01CD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QDqxwFho
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a3c08d6928so2283810c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794018618; x=1794623418; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nkEGHivME6CszY0Ky5TX7nnoI97YXSUiRaGdAVuRKTc=;
        b=QDqxwFhoeT4XFwy7J+eF8wylnHzkG+S4ZCaCkj6zi/rUY8wrWpxWTIAw/fcJ1T0saS
         QV6L+UdjulEhSX8yfoG+KBkiS56ItXggJdhPJTC3FQCsJ43dOlAdIyuLiaZgHP4pqEvj
         PkoCsYoEjg0sQVAzaMf/mwp4Gtar+ukahDq0bJdjRkcAOJYyKvxYYg6c6xwb0tYXI0xP
         oDkLrXbyNKQ61XcCifXWyyl3AATZM5ts1Pbg/udvDh4C0ukUprPTFgzNSuoQ1Z+daulA
         H5v/IaQXgrMFJUFRuxr+MF8aL2YFFVM0jtUT/OymNhBDFA1NnQ2zAkvqivOsRmORHETD
         NwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018618; x=1794623418;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkEGHivME6CszY0Ky5TX7nnoI97YXSUiRaGdAVuRKTc=;
        b=gAmVhekHTN0GVZBRIGmwl8rzJ0AD9+V3NqhgLxPK5HdHpyhdqmUuShj/0eNfMUIogd
         bHunabqddfIsOrnLroxS+R5php9RBJEtVpK+0ACaWIUuxyOf8mpq9uocD2BGo2kqeAgx
         XIEvR30hwqINhHFhcLUBRXTOCW5eCFqhyAcTWWUFp4I8DWx/1F2S8K2Cs2HeUdne1dYt
         xueiAYujyIvna/9YtxXWP3S90srK7Xaqs17FKVKP9/1vXNjowWwS92fIDgIQJsRuMf2O
         PmyaguKop95/IXiEwxv6taHNTa5iqWhmmksqppuksjFnFppH3teCEtj28ASYycaTziQG
         Ze3w==
X-Gm-Message-State: APuU4Z8n59b7L+3jq3l8wlo4MbIzyl1TObsbGgIyGxcCzNGUlt7YqNcS
	f1YfvHLCcBu/kKasSrcngnBVuHpQfDDZqER83b1IeiIs5NdlO0UG8XY/YbiTMKCRMO2leQwjHPG
	m6pQV
X-Gm-Gg: AYBFou2YCoqhWKAqM+6vM9/OpbzzeM4o1h4Y+3qq9LQXfcKk71w0XKNgzhecTB7IF3h
	6km6PYUeWI40VL4ImkrdgXX7rm8r+rUIOqFn2/uuGt90I2wUckLYKmfxZts8BCpmz4DlYdviJN1
	tIfmN27pUhGrIv5Q2241PPZCeBXm2CpQ2ChrpXE2s8mTowN5UI77LSpw8hXw6ZHyqn4eHXekVKj
	PZnaZ/WhpPkeQeC0BZZY3gdx8GHN7ZyjMkdwgh1zJecd2XRNiGigqGxYBSYioJVjXXnZcE2wmG1
	jTXyvSl6aDK07SnUAzTieppH783tHXCQTeHiLenNzhy6TdPHbT/OQvtoFs+Qj64rGC4jD0VzgqD
	BhDsJJsWbPfvMJQUSqWfRZQmG53RxV/x4Ip9KC2G2cDI7lBzH2kbs6ls7s0VezXeNRQH5LvUcE1
	mWtZ4XefEtIiS9Vk/27pXEVOJLLMIyQJTDg9M1jllrvuPOyS1cnn0+rertkfYUmzIHyJl2vKJA4
	46YwzzZgE4btdfc9YNumKnjcdCbkiZa6iWyXyst3qD9pOmNZNJUsTloE33E1ehzhd2C0gLqZOl4
	dbUX7d0booXB4fuak5ZIUg==
X-Received: by 2002:a05:701a:c907:b0:14d:3c0c:79e9 with SMTP id a92af1059eb24-1b25d31e4d3mr5453478c88.11.1794018617713;
        Fri, 06 Nov 2026 18:30:17 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4879adsm11021876c88.6.2026.11.06.18.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:30:17 -0800 (PST)
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
Subject: [STATUS] stable/linux-6.12.y -
 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 02:30:17 -0000
Message-ID: <179401861693.449428.15231679910186613537@34406640b1f4>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/5c40a1750f44dd6c7292d8c8d0b4ffff1734576e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
origin: maestro
test start time: 2026-11-06 18:55:18.587000+00:00

Builds:	   56 ✅    2 ❌    0 ⚠️
Boots: 	  113 ✅    0 ❌    0 ⚠️
Tests: 	11855 ✅  748 ❌ 1312 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6aee4a3d5b429d354e0bbb5a
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
