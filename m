Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144951;
	b=XSgdx08X2tDjJ85M+hdmpwuPgJd+i0wJeXolB33a83CFCnHjFN2udbu4zizsODAD7Cbr
	 QcyGPvziB+jSS+AF97kAvbPaTzAj5oLWuqUBa7ZpnEjeWzBsjlB1dv8GXsVUkwEDqDf2W
	 i59JPcIVw7D5c5q5gYtxihaX+j97wR6RW9sfg8ntUiljNOIq7VrKPeUw2P6cRy1CpG2GO
	 0Q6T/Ddw2xMgki2cw055TAL/bCDJsigzwzKGH1iek+f3JydIddm16VX8gQCQOq4X47OWW
	 pnCFJV/m3VhP4bhbiHEeJ8sfRmnfn4quvCfHmQnocG/FL3Gbtzd6/Qm2WPRky90evHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144951;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lj800CrS6xgIALrmGK5YjkIsRh+/Mj8maNuJko9hCY8=;
	b=iDZ6T1e1lpRRmRIVfqCdjPTOkalwTSGGcEL7Noz2PbJhYI9zeJvma6fSgRnOsLmHxcTo
	 RE3HY9mqDt7rtMOBnh4TlDq6hDfDMKlVYf2/oYPaVjjihB4eZ/KmlY2f778JxCpfBCKLZ
	 z4kLmhr/Xk08m2/YuZTLQdLbO/D1XJI1WTCmWlfQ4FqcEiQ8Io/8oaewBld9AsP1txOBu
	 tpNclF+r4kdy/bXN0r1ll8ALJ7R4E92nvduLetn6+P5WFfnusJT1qcSHIfdD3BdK/st+B
	 H5gwq2gXYkbP5vddYzNfiO9GCNnsbyaF4tQEE0GHkD8QH0Yt9JautYn08KY3CUrynEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=OUniGQQ4;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C7606A332;
	Fri, 20 Nov 2026 03:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 309C7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=OUniGQQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795144935;
	bh=Lj800CrS6xgIALrmGK5YjkIsRh+/Mj8maNuJko9hCY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUniGQQ4hDbLAPaoHV85YFCxkU9wzohfSo1e860pREMTlMWzDB+CgtNdA+D8xRKDa
	 r4adRxpGhDnkwMJ6Q+BESI7LcODNO3hEIUxUanzROj1X8WGBhIISVI6mdDCKl4jqxa
	 tExLkT1onepEMx8MYUYC7IVOdeMhxkAK0DsOhOsU=
Received: from localhost.localdomain ([107.173.101.132])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 58AB2488; Fri, 20 Nov 2026 11:22:10 +0800
X-QQ-mid: xmsmtpt1795144930t5ryoowne
Message-ID: <tencent_BA4D887B4358C473171507488D60E3F66205@qq.com>
X-QQ-XMAILINFO: N84LmEYa7WqonnJNjkkgz9yKuNHP3ZR0Rw2GoawiKUaAw3URlx9zl7I6xFbpb+
	 9+AiEbEl4Ccg/YEbRQtCrmUdlGOCFpzxwrCQOc5LNnTOM+oJqumpXTLXZsAsY+XEprYxZN06Tcz5
	 jip4x8vusfwW8VKmrflMQgi9Ezi6f04C8RtW/YMk7bqPUFOmO6vNMmPg5/teoiyzc+YrIaR/0zCJ
	 dXAXvoi9bHglMzC4S2OaXHGnqPnFWXhf3XTIvUVnmYytrt6Sy4Sa5OkA+hhy+VnX4AC6qfp3CiD5
	 H/hcAUPsqv3hc7AUaPLJfxgRSmXviaOyUhKuQdkVhvUq6RGC6bRLMwtynJtlVC3Vgf40c1rYZHrW
	 mo5TF8zo2dagNd4/Wgbo7gC4bG8MyB9eKaPX+q9ASkb/X7JhVXrTqsrESg0PMxcXHCHYXHwqRwh+
	 43qGpt+dU3rSB1O+/U5YCx79c4UkK4r3QNuFdbJtDerVukK0Lzx7G4O+RapMnwARQ6ky548aY7Iy
	 LdIY3pmxOh8eG6gWIXrNkOP7nwP1TqrXVFusQRsipnZp93lC4tWHuBO35RnnfmD/bIU715Vf0IWZ
	 FPcXBBEkG8NEaejHhd2mR2/CqbRDgn/nfcByZz6QH+b38GLVbxpSimF0QHnoIgiufQV+B4XA/vtU
	 GIawsAJDAl+ZmTEcFThZp8bvrb+krdiSHbF2hycY+H8v+44ABjTYVPMplgNWjN08lykN63CMBeNn
	 +zoghbDtMkKbRMrj34Ttpit4kxgi+iIzku1lN3mnlKckXA1vD681HQInq4J9sL6g7MG3oFQ4i8wz
	 xX9bPPYqWCPCsWPm+fKdNMbBpofJcZVZLJ6Waode2TEVn4OiwodLPzKPWUv0y3hcWVcFuPNfU3OI
	 AKBRvepsb5QIZHlrbXWedAHlF7uiwajJM8qlnMpAKSKgqUMMamGnPyJhLrU/SQENZqEVdborlC+U
	 Hy/jYwQySbeBiHM5QJwVqgESNI9M0iEDdw5f6TuAwuvXChY2lbCeQAavTZXQbUJ2YwjJkvcGc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
To: lukas@wunner.de
Cc: helgaas@kernel.org,
	bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Date: Fri, 20 Nov 2026 11:22:09 +0800
X-OQ-MSGID: <20261120032209.2061155-1-ziyou.dev@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <av666Q38S0q5HqYS@wunner.de>
References: <av666Q38S0q5HqYS@wunner.de>
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

Hi Lukas,

The ACS Violation in that log is not organic, it is injected on purpose.
The platform is AMD and we use AMD's RAS Error Injection Test tool to
inject an "ACS fatal" error at the Root Port.  The test steps are:

  1. Shorten the machine check polling interval:

       echo 1 > /sys/devices/system/machinecheck/machinecheck0/check_interval

  2. List the PCIe slot info to find the socket/die/NBIO, PCIe core and
     port that the NVMe drive is attached to:

       ./cmdline_amdraserrorinjectiontest --listpcieslotinfo

  3. Start I/O traffic on the NVMe drive:

       dd if=/dev/nvmeXnY of=/dev/null bs=64k status=progress conv=noerror,sync

  4. Inject the ACS fatal error at that Root Port:

       ./cmdline_amdraserrorinjectiontest --pcieerror \
         --sockdienbio <socket:die:nbio> --errortype 4 \
         --pciecore <core> --pcieport <port> --enablestatusregisterpolling 1

This raises ACSViol in the Root Port's AER Uncorrectable Error Status.
The BIOS has AER and ACS enabled and AER reporting is set to firmware
first, so firmware signals the EDR event and DPC containment follows.

The TLP you decoded is a regular in-flight DMA write from the NVMe drive
that happened to be captured in the AER Header Log (there was read
traffic on the drive at injection time).  Its Requester ID is valid and
Source Validation is enabled, so nothing in it violates any ACS rule.
The ACSViol comes from the injector, not from real ACS logic.

The ACS settings on the Root Port (same platform, 1022:1108):

  ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
  ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

The goal of the test was to produce a DPC containment event on an NVMe
device that needs about 4 seconds to become config-ready again, in order
to exercise the recovery path.

Thanks,

Ziyou

