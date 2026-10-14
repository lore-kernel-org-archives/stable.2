Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9973417BD9
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004902; cv=none; b=XnPqBnZiJ84npEXP6Y0NX9WF78GHOtMJnUQMcnw5OQ0NAjT4GcQOnx0AladC7CQzrGRnjjfhnc/Kr2S4hwC7HBpGrmJor7dIrrixbcIJD1ELugPiR21rQT2KUOvv5EGjDBI4XWoWEtu4vRu2+K1i6FxnkzwhEPqXqV6irU7FKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004902; c=relaxed/simple;
	bh=RUtgd1IDUTb+Lnsw9nLInOzXrLSRgTi7g3GMx/iOGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxnVVdqOVxyOejwTJZS8lzoPLaot72dncYA1WbBiKFlQCF2z30OJC/r0WWZ9AOYDRwwGz/OW3nNP4Vt730hGQStQSL8tc6Yxpt+uFu0mMY1U+qojUgpnUxUjYgnnpS+5qbz8Yncbuj0clpbwG/OxCPQavI+reDynW9iY51/BSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kHuXVkcX; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kHuXVkcX"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35829219da8so1331313eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792004901; x=1792609701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoT00FAkkQX2pY61Nw8OJCiUbTKBvWhFM3ATJilN3vI=;
        b=kHuXVkcXZqmRLOUbiHxxkv4sKARfN9agAWKpRAQSVDKMmRMT36MUxha0dbTJg06bbR
         pwtGkzLzdujo3XuHyJDNVomRJ3ZBvCSOKVmZmsogdRp8Mu9LZCAp3NzwXKmSgThQ8FCG
         1cFJ/VFDmJT9DVcAWKJYXpcCw4dhHeGc001TpnFdsIZVVqGf4YCyJprWNA46fSigFV2q
         MwWC+SEkrbaYRIxUReCRiA8mCNPctGQR3Rffp6OtYOjPpDEwqKAJM3WActOKTEKcor0O
         HGhVHri9L0a4Ez7B6a8Ql50ryow9mw6DeJu5prtlo/+2XvVof+NGKpYiHsB2gWALtCmx
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004901; x=1792609701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoT00FAkkQX2pY61Nw8OJCiUbTKBvWhFM3ATJilN3vI=;
        b=Ufm3cZuprq6J6bGGv0twhMOr0LeZpitxrrqgfvpBxRgTxaFGeB2br9/nI2863lhs9g
         EQk7v+Nrwlo18t7SbiDp+uCRl3hYwRTFGiFvb79SlgMlHuPrkiLhGzQ69uVNkuTTsYh2
         llScrr8Vg+Bq5aD8IM83nXnlky4uGnEUm2Tpe/P83SNu7Z3MbKM9BRShOz+9dEbrOkPN
         RrbvZCbPqOk3N3GcMNSxC74o+Uq+Bhe0D6zyMLBocwXhafMSdDcA8dekytwyvoumWDJz
         q9mc2/8ajT/K1vB/6HHrje2li5DWWTy1nq6IdjphNEPD2IWyF8IFMkTy1PEA438tyVvO
         gZbQ==
X-Gm-Message-State: AFq9FYJw0GSaJzRpmg88kw+5G1zD2ym1MzFNlrqguwfWfV6xHniBW8CZ
	pRk++pBApKXKIYHjSrqTOwx7WnLBNjoxTga0TA12FtIIsqSNSGznrvca2l78yce9nKunhDZKlHt
	90YrSWHzVVA==
X-Gm-Gg: AYBFou1NAlH8BQmKi6B6v45bb8jCz1lQpSbvQOPs35UceZ8o7T35TSodaRAoePnijfV
	C+1KTJBSkCexNmZ0ZpmOyA2TQGYbadWYrdhsIDtPCbSrTtvvX361YIKQNrMUIJcVh9/6E8efkP4
	GNzR32kVWpaLOyfV+iEr1A2f87i/nktrrNZa79cDECUUd0eLk8sjZTliXKD7o3ysVOV/3TBF5wK
	uvzlCX2LdvVT+Fr5TOL4VXENzSrJe4KPGTPs/JttyEAmthK6MUji6dpiVPHzWPtVUu6FxnEjUDn
	j2HXSKsdDJoHg5GHP4sF4uYn3Y8cyFemjJjfy2AaoK1NPAXP32/ni2v4Iq8nG0uWPf1uLJ2AYzy
	zD2oMqTsu4Y3npsHzl8p+M6eGzBTK8lAxqlnscrTVXfMDzw2SQoIMMn60sTZAZKeCejOcYbGF0f
	YmUTdYCDzSzO9lNMZ2u1UTN2asowD7Hnfzi0PpScj9np3cP7H6E3Jssw9NA8snIPEXn62Fd8MOW
	OzlFc2o+CAT+k53Gv6tKzKlylw1ZObqLsOVaV8cXBGL2uw04tmspTrhdxsCyEs6MwNcp5U=
X-Received: by 2002:a05:7023:a4b:20b0:143:3769:c680 with SMTP id a92af1059eb24-16a1555df9dmr21612292c88.25.1792004900520;
        Wed, 14 Oct 2026 12:08:20 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567bd18sm48064953c88.21.2026.10.14.12.08.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:08:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: dlemoal@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	kishon@kernel.org,
	frank.li@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [6.12.y] Please apply one upstream fix
Date: Wed, 14 Oct 2026 15:08:15 -0400
Message-ID: <20261014190815.23455-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider applying the following upstream commit to 6.12.y. It
applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.

97110d42680e692020154f9aa89298c038196055
  PCI: endpoint: test: Synchronously cancel command handler work
  pci_epf_test_epc_deinit() and pci_epf_test_link_down() use the
  asynchronous cancel_delayed_work(), so the command handler can still
  run while DMA channels and BARs are released. The fix waits for it.

Build-tested on 6.12.y (CONFIG_PCI_EPF_TEST=m, CONFIG_WERROR=y); no
runtime testing.

Prepared with LLM assistance.

Thanks,
Artem Dinaburg
