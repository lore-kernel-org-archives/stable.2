Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225978;
	b=S3L1EPNcthRTfTr8Opz6kSxKqI2FfU4tJDo+Pd+FQXDQI9Pu9xnZIhXEULTjzLnz62y7
	 VIpKJWXIankPoaC8MDQU08HJyiGeoFg8kRn1gyeZuuHSi23AGpWUl7fIFRyGM3cqojkbp
	 MN5GCrwsrHfeFsyRZZ7DcoQfU2i+f4VXetgeH2GVoXAfXUpqW2Pu5wMVptgblnnhdgUMf
	 TrzYDcBfNmx2tfGewcKa91wOi7yKw5lOXydz35rS731L8UpXSe6v3fLCW5NabRCHRf+sU
	 o83IONUEtkKC/i6x2pursoprsoYiIdBsEXz9vUDhhY8t6ePRsp8i/JvA+fBXZaYaxyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225978;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=xuADIREcpTjAmSdpyV84ULGmI5stUYhEIJNUDA7M3j0=;
	b=RE+taONhs4gh1J+fsojYXnF7mYWoYd1Efnd88wj808Off7W0Lu6L23NhRaNMv4vC9kv7
	 xkhWLujKVDjxDwGX3DipXbDurVlWOgWalkWqKWFPM8YVwOKrOCYwCx15y8tMiVYnZxs4C
	 b2T9bIH/cGVUB+vWvqXhlkM3lcpWl6T1Oi6Y8/N7RQ3wcdqorNuMH1pXhJTy4kuZBwWGS
	 cHnFbwJXRKw/d0uptt86m88JMl8GoMTJSf5zeWVnc4AM4lcsGaxOmT6jPy42mhWlUUQTV
	 oM9NhJhZiN/d4sEFGKVqSdp3RGwG4tPl4oWjNndohC6mbGrsqN+ZYgX5TFHEwm3YOsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b="eiP8bu/v";
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC2606A335
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFEC2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=eiP8bu/v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794225977; x=1825761977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuADIREcpTjAmSdpyV84ULGmI5stUYhEIJNUDA7M3j0=;
  b=eiP8bu/vqthNQo65UDC7bfHykb/OdgXLrDIgJC+MSuIYn/DfxWAGdMye
   x0xWq50jqAPMW7+hKQvZy7jjrZEWaTEvD1tABbsUSa8Avj14gVTcwskrS
   tJgUEKPSNZ0hs2fzvGUZjtl/xbjvMCtC5XHOpIPcr7E0NHRGtBwPXyN96
   1PccXDW3FZxngyf4ubg/zASrPntbm285fogfZbBZxe3moF6JJV684mv5D
   v0ZQQhQBO62ENNqTWwlnuqDvc788HGff7CPmJBbxIiCGYr7q3aphpctT2
   JVuNN5paO6xjylUaokUsqI+9yn8VCRsLW22jk73Jw/rYHdIdg/AW6pQUr
   A==;
X-CSE-ConnectionGUID: oEQxhPCQRa24Mmnvgmsy/Q==
X-CSE-MsgGUID: AgafQzhlTV+o8lU61RPoMw==
X-IronPort-AV: E=Sophos;i="6.27,203,1787011200"; 
   d="scan'208";a="33019840"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:06:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:24761]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id cb9b8b8a-720b-47a2-8099-d89e07e241f5; Mon, 9 Nov 2026 12:06:15 +0000 (UTC)
X-Farcaster-Flow-ID: cb9b8b8a-720b-47a2-8099-d89e07e241f5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 9 Nov 2026 12:06:15 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 9 Nov 2026
 12:06:14 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <stable@vger.kernel.org>
CC: Ben Dooks <ben.dooks@codethink.co.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.18.y 1/2] devtmpfs: make 'devtmpfs_context_ops' static
Date: Mon, 9 Nov 2026 12:05:49 +0000
Message-ID: <20261109120550.1776888-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261107050610-failed-6.18-1c7df6fa838a@kernel.org>
References: <20261107050610-failed-6.18-1c7df6fa838a@kernel.org>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit 99aa03f98ce56804f2e8936f9dabf8c4f117a661 ]

The 'devtmpfs_context_ops' object is not exported outside the
devtmpfs.c file nor defined anywhere for use outside. Make this
static to remove the following sparse warning:

drivers/base/devtmpfs.c:88:30: warning: symbol 'devtmpfs_context_ops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Link: https://patch.msgid.link/20260116150745.1330145-1-ben.dooks@codethink.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c7df6fa838a ("devtmpfs: restore mount option reconfiguration on get_tree")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 9d4e46ad83522..0bf3232b3ec14 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -85,7 +85,7 @@ static int devtmpfs_get_tree(struct fs_context *fc)
 }
 
 /* Ops are filled in during init depending on underlying shmem or ramfs type */
-struct fs_context_operations devtmpfs_context_ops = {};
+static struct fs_context_operations devtmpfs_context_ops = {};
 
 /* Call the underlying initialization and set to our ops */
 static int devtmpfs_init_fs_context(struct fs_context *fc)

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.50.1

