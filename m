Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097526;
	b=f9M9fH145/YA+qXHB6bUy2yAhq0fjgmcAqfVrVqwlK545OKkcEyRywqd83QrUkIcDI+4
	 KcYC6lPzYZnQ1DFYSfWmFObItuiu0+npTkP7IjfwL8b4DQCAfl1VnxJVR7Q1hFToFIpPR
	 akrbJr5GDcyi/hXokPY4wUs9/yYfZHlGO9E3nSEpKpzV8CX3VeH0OPZYn+kGIp8w39gC9
	 LNWPMX7LUpZzIVaCSo3fCl7ngYivGy/18XUyeaNvWoa3Ym5gi+ccxtQpIwFgaPbwtk/7b
	 OHGlGNaWUznfHPAGrvi2jZe+mWHZ8vCj65B6YOqnlTPalak4EJDN2Fz5tyAD9xUHeTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097526;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K2eaO5KthBm6xqXpWKBCvrCFiONFqgpc2DtBPnCprW8=;
	b=kVIoeVSKkYOJ8amcf0xOTmmy4t3leEgA9OTKxlEqceWsbVL4ib6FmYXK29IHa7xwnRYN
	 c6F6Qh3vthEQ9kU3nLK+DirHSMt9nrUNXSIikF7VwuunO6Eo/bePg3PkvacVP3EJlAA6n
	 NSK7g86zkqSoiELU+Tkw0ljYc7rmmcptgKLoNWCDP/pk7GWeAw//qEm0U/fyBRxccdsRF
	 fNHepf4aBtVPZwifrVc/GGc9opHjvbll9M2COiFvroeHV16lVfEvbgy9mFvZUs2+++Scx
	 aSq+jq2bcebgXrme40hWTJm59ZMQ3vELdv+ptVYXRxbyCdlbURhO+MgLVB6JL74RFSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fTwcoXXD;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E3606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7E3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fTwcoXXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795097526; x=1826633526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/iBxPET2SIFQ0ptF5C2r+HLozj9+RShh/zl8NhljwU=;
  b=fTwcoXXDvFs/AcgD0nD/8AfLuQhe+d4uSgQL/ZIW0ccEza6cg99DFpnf
   btjuwUtAEz2WaKrcAu9P738HMa170Yq0hTt5lyDEmRI2HbF5pWfch7Sdi
   Bx2rZBvxb7idwYg8/iSqV7+BTNEKLnz2uEEvylVGV+LBHtMMSawaTF3Ip
   FVJfSJSgulW9T6PyoF+KJJNOdFEcg8TcqbPc5rzDU1bmjvKKZcS+KgZNX
   yQYpSGW5t42DUAwfJyEuzTtIJxPgf80f6hKljQFho75gzZGaNezCKxldL
   0JqM1QsLrEYm2sh+htPq1DZ5glzwHNJKH3kXcGd34RRc54SDMQ4ozSBTS
   g==;
X-CSE-ConnectionGUID: aB45UH2bQJq8DBUMhTFCEg==
X-CSE-MsgGUID: q/ckWXlOQASgg9f+0+qgXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835626"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:12:05 -0800
X-CSE-ConnectionGUID: A1pAg2sNQf2v8YOtHncBqQ==
X-CSE-MsgGUID: tsS8m9EKTmq2ttgkO+wf+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10476150"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:04 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-next v3 1/3] idpf: always reserve one empty descriptor on XDPSQs
Date: Thu, 19 Nov 2026 15:09:36 +0100
Message-ID: <20261119140938.1363722-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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

idpf-powered HW requires at least one Tx descriptor to be always
free, so that head and tail are never equal, otherwise the HW will
deadlock. This is already taken into account in the XSk xmit code,
however, not in regular XDP Tx, xmit, and XSk Tx -- these are much
slower and are in fact almost unable to trigger that.

Either way, be better safe than sorry and always reserve one empty
Tx descriptor by passing `free - 1` (this can't underflow since
`free` is always at least 1 due to this reservation).

Found by Sashiko.

Fixes: cba102cd7190 ("idpf: add support for XDP on Rx")
Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 2 +-
 drivers/net/ethernet/intel/idpf/xsk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..1d8ed7ac3e17 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -351,7 +351,7 @@ static u32 idpf_xdp_tx_prep(void *_xdpsq, struct libeth_xdpsq *sq)
 		.xdp_tx		= &xdpsq->xdp_tx,
 	};
 
-	return free;
+	return free - 1;
 }
 
 LIBETH_XDP_DEFINE_START();
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index 5a0a1d8a7a86..ef079d2cfaa5 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -294,7 +294,7 @@ static u32 idpf_xsk_tx_prep(void *_xdpsq, struct libeth_xdpsq *sq)
 		.xdp_tx		= &xdpsq->xdp_tx,
 	};
 
-	return free;
+	return free - 1;
 }
 
 static u32 idpf_xsk_xmit_prep(void *_xdpsq, struct libeth_xdpsq *sq)
-- 
2.56.1

