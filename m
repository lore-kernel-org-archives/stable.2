Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810724;
	b=rIt3AQ0cjSZsajS+W800EOCCzVJYYTxhPw8a3sceFBFe33QTjekHc6elKjZCckkfv+j0
	 SXERxWWRKp3UXY1hu/2zRsFHGO6Mc9J78RwXPZ7z+pyVUsJzxFtZsJXtkh4AZXy3qjGA4
	 36npTEDAEer7vjOnPKTGNDOnbk/Vo6se9JFH1w+LtLpr3iD6K0GnPZv2L2kIqtfzXljeV
	 Mb1ykqtMnyi9zMJtQrTk2tR5d6Nzlzhwp/olA/zmvRJJhA1/sqMq+3so+5Zt84tS34/GX
	 VY9+OP2ujG4RWx+m7KdeK96hozsCi1XETulvf0chsrs+sp2jHIJ/7s/egY5OmkK7SUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
	b=zT8dV0dodOveq8rl7WFugHVa+kwzCRN4NzTK0apctj5+ZDByQX86nXsTkBDL2s5fAGxz
	 MBrvkFSQsCrBqZ8n+zancSF2e8ACrWT3iPYsvWM5kP9UaRy9BFbmhR0oFy+e2zDIF17iJ
	 A87fMbvDBqkZ7bZiUY/9ds5GUnaVo1aZEJ5c9GK1Upe+O77OflbyNcYXjlOsKXq0yBVmH
	 bQeWiwkMGG1alafDul0fyqmg2sCcUZDOKMGaQTWLyd3gc9qvpLTZ1pC7+eKmBuW5UNgfJ
	 jVv22s3z12TO+fQkqoioFyUbCTgo4zKYrY2ieW5SNh03WIhPMVWl3FxGhPDJ4ZbSZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aCJZ4/Xo";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D0606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37D0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCJZ4/Xo
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so1575433eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810723; x=1794415523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
        b=aCJZ4/Xo9jKnaTImkPsBsYrn3ZiAHaVH5EYy0bf6wENa9Kq1tc6D6GlpvX5t0fkziK
         wiAUHhfbnFo/FFaTP7tTCp1b8oDIUKJNqcc31oM/cgw5UTvGs6A7zVMmehHfmeh/jSh+
         aDMBdXQ2XaaFhxuyQ0m4HZvj3Ao9VTgB4PbCAGxyOrHJNWc5imT1XVJXThXCSeckHrd8
         FzzYh+R/uLqI+X/n4CgmuKQVIF6q2obULzITNmNETkMsHpPdDbK4/aeIAPeBTPshpCmV
         JHCKzrf2gIhUIPftDnZYbaq7Q7rPcyllVwxNKOtUTIfy/Q3gqhTysqJh3PWEP0QYSyc+
         8r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810723; x=1794415523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
        b=TLGPWzJKnErjuZyo+aqjkaRTiEwRXZ862k29h1KIZ1KRdZB1Ibyk7/Q0BoeBV9IEZc
         19ny3RuRj+Bk2MWXtaJEmgvBGfu6nmXeav9IdnjsezhnNBCcW5W1O/tjVBAIR4Q9zepG
         udZXizn3Re1N08Jd3SxYW72I20m+1ckuMgxNls8i3m38TMcSGwDLeIpZ9CfH6QwwQ3T8
         FDOxTpBmxRsxeNRToXjagWGI4AtT3LOHBQBaZ6ZFZS8gxZ2Mcd04DN9bh3ar5iNoDKoe
         bL3vCzbTH2DJWTg/ROHtdoZtLlvG4XLRFaOOj30aM3KKpVDOVESauggWRBLWslkNXjkN
         ncow==
X-Forwarded-Encrypted: i=1; AKwUvBxOtb+9BC4N9TqvCG2Mxr/WgUfIMjJ16qgr3Pt0Ejsf7ldQIwQ+JtHZKRchlpkOV6bCWFH5v3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3Y++SS8w/J61j/jnvsJqtqti2nUeY7AmoQ3oBjgD0wOx74Sqy
	RXorNBAmNjjTVcIRgu5lTKcsYLwZoAhwhFYlnMRHJA6yeH8cuS/92HiQ
X-Gm-Gg: AYBFou2v7305qF2fxX2EslKfDvRY9btWIyCAU7o6LIpo04N4Pdd5IAVRh8ZDbkMI+w+
	q+Q91EyDRJr0CsRqGoRthgF8AV8n8wkcYje7zNDRyezJ9P0aMp9luNmmbXGI61iu1Hg2WdFWWxt
	wcK+KLmpgmh4F/Qx6Tjr7S1DN1s5DWrGRZ7m3EKqVIQGV6glaDCwuDh4uAdnb3wtXCXdbzUlsBi
	EBG/z6M5rykXucCqF8geXJYwWrVvTOz3fsM9aA3FFlVGzLJUnl5SuHAaPmYXj7LD9/M1ZUTKlva
	4QJXGieUYrWVZdZe7k2olXap2Z6UinNvkeEMTS9gOf88258SD4NQmz3lXTjBQZYQ2w9SPFadEj3
	US2dDWUTbDYYdIOUcl9iejsLmZoojWI5EdlmkABt+3jJTNkNBMlsC28g1QP39xueJ8TVnApTYWn
	C0KdcRSOmtKjv+SpUNJX9PZSYpsXsjndTst/8pz8K9/gNbh2pYXxwtz3vmFUVhesDsnk0+4fBV4
	3HjF/YFCmTYUQ7tjQz0p4CowthEblzPBQzmzAo3S4//sgNbdH7gLb8B4nDnjLN0Ccu9ZqcGyWWz
	LD6bkQeQHN19UUORywVPw/rdWA0DJBTPN8Jef+hAnd/ytFaarJNocE6qIMmRONYFD0O7wNlogCZ
	OYoRRx6dgtCDFhFeutNFKeTH33Ebt6re/mzLwlEBYjstucXBqK6C+jXhsBxfWAh3JGAzLTLHev9
	l1JKmWUo6MaTkXUdIQ82NFD1/7IDKPzw1RHC7+ZaijAlR2JUZD1QNe/D0wimLEQ10=
X-Received: by 2002:a05:7300:a8f:b0:368:4c93:544e with SMTP id 5a478bee46e88-36a422084d2mr25419815eec.1.1793810722385;
        Wed, 04 Nov 2026 08:45:22 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm10368825eec.12.2026.11.04.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:45:21 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Wed,  4 Nov 2026 22:14:59 +0530
Message-ID: <20261104164510.105359-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The driver sizes its channel array for 10 fixed and 21 external PL
channels, but accepts external channel nodes numbered 20 to 50, and it
never checks the remaining room while filling the array. Channels 20 to
29 are the fixed ones, so listing them adds duplicates and overflows
the array.

Patch 1 limits the external channels in the binding to 30-50, as Sai
pointed out. Patch 2 does the same in the driver and adds the bounds
checks from v2.

Changes in v3:
- New patch 1: limit the binding to channels 30-50 (Sai)
- Patch 2: only accept channels 30-50, so a channel node can no longer
  duplicate a fixed channel (Sai), and add a static_assert() that
  ams_pl_channels[] holds the fixed plus the external channels
- Patch 2: rework the commit message around the duplicate channels
- Rebase on fixes-togreg (now on 7.4-rc1)

v2: https://lore.kernel.org/all/20261023185652.195025-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have ZynqMP hardware. dt_binding_check
passes, and rejects a channel@25 node in the example.

Arnav Kapoor (2):
  dt-bindings: iio: adc: xlnx,zynqmp-ams: limit external channels to
    30-50
  iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  7 ++-
 drivers/iio/adc/xilinx-ams.c                  | 57 +++++++++++++++----
 2 files changed, 50 insertions(+), 14 deletions(-)


base-commit: c293f0db308fe76a0a9b0f6674cd2dea149b03aa
-- 
2.53.0

