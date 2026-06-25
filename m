Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6932E121;
	Thu, 25 Jun 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347726; cv=none; b=BGuu1Qw6pNOl21I1qgTmjThIyL0JQSL9SdjKjQJXmD+6gfeZ/p0ZyrPEWfCalf2S4JScXo5UpaedLFb/mifKTGGCCoefBWpqyLy/yw72oJHxSJiw6xgPudPs2bEhiKr/ST8ZJiXLphtCeDCx6Q7HFjQo6iHVpnqeqlsd+tzOOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347726; c=relaxed/simple;
	bh=4Y0lKEGeBVRVySdCzZchCGFehJY7/Eo30fxGpdo9EIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TENGG06UQcthhkJylmo61QpcNexPlpDSCYuCqAZ+DBXUeE/JshGoc5HL1LA/BlkHPkom5dAVh8wzOBFFh9MGVpLkdFW/ezmlaDkAHc+u9HTfPJaGHMeDZI+/0bd3YEiPQxYj1jQt7GUR+71gzejfLDqWJleDSY3KSWDgkQ08BA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cNiDGkBo; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cNiDGkBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4Y0lKEGeBVRVySdCzZchCGFehJY7/Eo30fxGpdo9EIc=; b=c
	NiDGkBofgiyOPUdVEt72LEIoNgz948Hrg/YDr6VapprQmL9LiEyRVVd6dHxIOp57
	hcHGy+35dw+YfHr+w5xzJOfE8F+v3AokBmJqKsX8Quuf1TYsUX4D8DEQHC+nsJya
	IzYMUe/Ru1bp7cdtCVZheOBsLlT2YA7hUq6XEMgNR8=
Received: from haoxiang_li2024$163.com ( [36.112.3.223] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Thu, 25 Jun 2026 08:34:31 +0800
 (CST)
Date: Thu, 25 Jun 2026 08:34:31 +0800 (CST)
From: haoxiang_li2024  <haoxiang_li2024@163.com>
To: "Simon Horman" <horms@kernel.org>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260624170930.GB1131256@horms.kernel.org>
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
 <20260624170930.GB1131256@horms.kernel.org>
X-NTES-SC: AL_Qu2TAP+fuE4s5yCYY+kfmUwSj+s8WsO0vf4i245fO5B+jB/o4Q4tRFhsE0Xk4MWRNDqAryW1XBl/2v17bIpVcY8WJvu48EKje2TKIfFRmLTlDw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <78397a8d.5bc.19efc3325e6.Coremail.haoxiang_li2024@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgD3T4mXdzxqhfoPAA--.155W
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxhesG2o8d5dByQAA3Y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTA2LTI1IDAxOjA5OjMwLCAiU2ltb24gSG9ybWFuIiA8aG9ybXNAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBUdWUsIEp1biAyMywgMjAyNiBhdCAwNzo0MzoxNlBNICswODAwLCBIYW94
aWFuZyBMaSB3cm90ZToKPj4gbml4X3NldHVwX2JwaWRzKCkgYWxsb2NhdGVzIGJwLT5icGlkcyB3
aXRoIHJ2dV9hbGxvY19iaXRtYXAoKSwgd2hpY2ggdXNlcwo+PiBhIHBsYWluIGtjYWxsb2MoKS4g
SWYgYW55IG9mIHRoZSBmb2xsb3dpbmcgZGV2bV9rY2FsbG9jKCkgYWxsb2NhdGlvbnMgZm9yCj4+
IHRoZSBCUElEIG1hcHBpbmcgYXJyYXlzIGZhaWxzLCB0aGUgZnVuY3Rpb24gcmV0dXJucyB3aXRo
b3V0IGZyZWVpbmcgdGhlCj4+IGJpdG1hcC4gRnJlZSB0aGUgQlBJRCBiaXRtYXAgYmVmb3JlIHJl
dHVybmluZyBmcm9tIHRob3NlIGVycm9yIHBhdGhzLgo+PiAKPj4gRml4ZXM6IGQ2MjEyZDJlNDFh
MCAoIm9jdGVvbnR4Mi1hZjogQ3JlYXRlIEJQSURzIGZyZWUgcG9vbCIpCj4+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnCj4+IFNpZ25lZC1vZmYtYnk6IEhhb3hpYW5nIExpIDxoYW94aWFuZ19s
aTIwMjRAMTYzLmNvbT4KPgo+UmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz4KPgo+SSBhbSB3b25kZXJpbmcgaWYgeW91IGRpZCBhIHBhc3MgZm9yIGFueSBvdGhlciBz
aW1pbGFyIHByb2JsZW1zCj53aXRoIHVzZXJzIG9mIHJ2dV9hbGxvY19iaXRtYXAuCgpUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3ISBZZXMsIEkgZGlkLiBJIGZvdW5kIHNpbWlsYXIgaXNzdWVzIGluCm5p
eF9zZXR1cF9pcG9saWNlcnMoKSBhbmQgcnZ1X3NldHVwX21zaXhfcmVzb3VyY2VzKCksIGFuZApJ
IHdpbGwgYWRkcmVzcyB0aGVtIGluIGZvbGxvdy11cCBwYXRjaGVzLgoKVGhhbmtzLApIYW94aWFu
ZwoK
