Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADB39CD1C;
	Thu,  8 Oct 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471537; cv=none; b=HDW7t+HlL8dTQPgJm/RNWryBRz7yyjLpb1hFXbUqQGzypnCfKi7w8eIz2pv9Ve/Hc2iudaDDiUajZW7UHse27+z8xH5/pZdBE7LAxooIZeJqpsTAzz4e8vAUYWyWtV/f/i863PomnY+fjgRSpMopSyRJFXjn0KoPUpvCGzEdFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471537; c=relaxed/simple;
	bh=hJ2I5vYzdbSxVTVsdXaLzetNMTQBd4ITGn8MLEysKyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oq47gB4Xm22EyzoC6/bhpemVMs802/fwpL9ltk2X3KFI6B8O/vpwXF1IPxLfbE2shsipYecntBMeTgCI0WnHWMsfJCfcv6R+tO42Dxo1Kcuw+NDVHaCgbBPIXuOn31aC/j6rpPrIPOj95EiidZg4qRJavynUnt/1R6F9QlRjKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=VITYrUzm; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="VITYrUzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=797; q=dns/txt;
  s=iport01; t=1791471530; x=1792681130;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wdpHghFpagSQYRq4D0vjJG/cXP4Qz9M5eYw+X20gVi4=;
  b=VITYrUzmMTUAdavvnN8HUztnSErqgqdFvm0cyQvPt5ep1PbkLY31vTSz
   QT6ySX/0JoeSNuL9SNs4OdLQ82CP4WOcLkYIOhttMDEEoTCvdxfD5C87b
   dHCOb9mP4ih/+PiT8+y2BnHYX1SW84630ftYBgu+8kT/JEnrkNc+lERu4
   DKzcqY0uatjWnF6vBbhkSIP1AuJd2q7QtSMjCse6m2zKSAywkW7ORFZIu
   eAzb/sGmcvS5ya+4qWQ/QfWs+c/XboRkFuLINdfXP4AOPec50Y24UQ9pl
   gJ2Jox0a7xDg4O+RJj09cx1FXfzIw2sU9oLAnP9v7N/FTu4BeFQh83l1o
   A==;
X-CSE-ConnectionGUID: sjNnxS0jTn2KCxFGGwYmUA==
X-CSE-MsgGUID: +UaxRFFAR6aFngd5HyqvhQ==
X-IPAS-Result: =?us-ascii?q?A0AiEQDurcdq/81K/pBaHAEBATwBAQQEAQECAQEHAQGBZ?=
 =?us-ascii?q?QKDSmBDSQSEU4NPrj8PAQEBDxQCLg0EAQGBUQGDM44OAiY3Bg4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZPDZAVJ1Y1AiYCSCmDA4J0AxG6c?=
 =?us-ascii?q?nqBMoEBhH7ZSoFuBoEfLgGIXgGBcYQIG4RhJxuBSUSBFTKIR4MOgmoEgiKBD?=
 =?us-ascii?q?JVpCYFBHANZLAFVExcLBwVhgQUDgQZuMh2BIz4XL1gbBgWBHYEJBBOCFiMZN?=
 =?us-ascii?q?nqBCV6BKylgARAXgQmCBwKCVIIAAgFJQQ4HRVMJJUMSRyYiCBIJARMaMAuBG?=
 =?us-ascii?q?zg8CShBFwxRbT03FRkEPZFmHoQagRgCKZgVjV+heoQojCKVVDOEBI0UhkeTE?=
 =?us-ascii?q?C6YWo4KmzmBfiYrgS4zGggbFXgFBlaBShJAGQ+XN8cIRTQBOgEBBwIHDgMLg?=
 =?us-ascii?q?WiRfgEB?=
IronPort-Data: A9a23:N6+Rkq5tuUperoAzFVrk1AxRtEHGchMFZxGqfqrLsTDasY5as4F+v
 mMbWzvXOvmCNGvxL41zbIri/BlQsMPcnNJgHVZv/ntjZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqazpMu/rawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eJo8+/PZMWWNy8
 6Y7AyAjQT+ctueL6efuIgVsrpxLwMjDNY4F/3UlxjbDALN+HdbIQr7B4plT2zJYasJmRKqCI
 ZBENXwwMFKaO0An1lQ/UPrSmM+qmn77dzBEgFmUvqEwpWPUyWSd1ZCzaYqKIYfXGq25mG7bm
 2vWxUrXKytEPfKZxjbY0mO1mO/2yHaTtIU6UefQGuRRqF6OzGU7CxAMU1a/5/6jhSaWV85WN
 1EQ9yMGq7Yz+E2iCNL6WnWQpnOYshMCc8RfHvd86wyXzKfQpQGDCQAsVSJIYtgrnNE5SCZs1
 VKTmd7tQzt1v9WopWm1/7qO6Df3Mi8PICpaOWkPTBAO5J/op4RbYg/zc+uP2ZWd1rXdcQwcC
 RjTxMTir93/VfI26pg=
IronPort-HdrOrdr: A9a23:N9D5GK3E6hGeSz463GUYpQqjBIYkLtp133Aq2lEZdPWaSKClfq
 eV7ZcmPH7P6Ar5N0tPpTntAsO9qBDnhPxICOsqXItKNTOO0ACVxepZgrcKrQeMJwTOsshAyK
 xnb69yTPf0DVR8kILGxTPQKadE/DFCm5rY4ts3CBxWPGVXV50=
X-Talos-CUID: 9a23:Z+BHy2M/avqAm+5DQytB8l4vQsIZdCf+52f+DGCnOGNUYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AIIFx8wwd/L/IGvmXQUei+ARYiaqaqOeTAVA3v7s?=
 =?us-ascii?q?vgZeNGyp/N2q9nS2pQrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,146,1787011200"; 
   d="scan'208";a="61873357"
Received: from aer-l-core-04.cisco.com ([144.254.74.205])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Oct 2026 14:57:38 +0000
Received: from localhost (unknown [10.190.0.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-04.cisco.com (Postfix) with ESMTPS id 0AF7D180001C2;
	Thu,  8 Oct 2026 14:57:37 +0000 (GMT)
From: Jerome Tollet <jtollet@cisco.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, dtatulea@nvidia.com
Subject: [stable] Please consider two mlx5e AF_XDP refill fixes
Date: Thu, 08 Oct 2026 16:56:54 +0200
Message-ID: <179147141500.99533.12861786180147681790@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.190.0.162];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.190.0.162, [10.190.0.162]
X-Outbound-Node: aer-l-core-04.cisco.com

Hi,

Could you please pick up these two upstream fixes for the affected
stable trees, including 7.2.y, 6.18.y and 6.12.y?

  e01620844c5c88b6fcf819d171df8e3976a0e76f
  net/mlx5e: Prevent stale XSK buffer release on refill retry

  63811edf512584c946e5e96b100e9e280703bbb5
  net/mlx5e: Prevent stale XSK buffer release on MPWQE refill retry

Both are in mainline since 7.3-rc2 and carry Fixes and Cc: stable tags.
They prevent repeated release of stale AF_XDP buffers after RX refill
failures, causing silent UMEM ownership errors.

I checked 7.2.9, 6.18.55, 6.12.112 and their stable queues: neither fix
is present. Please let me know if backport adjustments are needed.

Original series:
https://lore.kernel.org/netdev/20260824141645.23700-1-jtollet@cisco.com/

Thanks,
Jerome
