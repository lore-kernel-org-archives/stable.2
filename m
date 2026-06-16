Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAA466B70;
	Tue, 16 Jun 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631786; cv=none; b=OyvZEfe9iWCLhsG7Mu8HqKqkgiuHYWJW/0XhZFvF36F+WXIC+zsiX8l8IFn55GSytj2V9nPiDNMN+c31QM4Rm49ydgq5PiiBFRZfwQ7M/Rtnv7SRxkaBeWzXfSTdsxM3tWGAF5ISv5XYvnZAVN0Oxy1B+h3gM9LBzHO0RAt9bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631786; c=relaxed/simple;
	bh=dQNRbLWCeK75DjPAA4SvrLHVQCql+QnUjpBh/EtC2qQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Tp42j5yowTTwXvGAIhTtMq6kKPnptSVod12FHN3UBplV3XVLVbALfegJUPH0LN8vQ968d6ZT5ff5cBgnssF8/s2+ICjc/ge3hlDkcW+dMnC/Or7nYoWNzpknwDPax8oj+AhVd5aYeH5IUvP9X4RAtYeoP9l8T6D1kI18L8CtwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+t9wQPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+t9wQPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2083C1F00A3E;
	Tue, 16 Jun 2026 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631784;
	bh=4ptMQMr4KtIeVMZTDIlvLJCuEPLicT91TQkRWriqoEE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=P+t9wQPyQyqHiag8CbUw0ZigdC8hTZsq/2wgmwhFlK59NOxzh1lKOBeaBjpc2M8Fy
	 EOHLRlcYOSHJysFmbzMpffOh9TpMUa50PIOhARH/JCb4sENkcflwL+7ZfVC1QSncfG
	 4DKWlyAHdIQiCKa24840Gc3vUvJaDjOZyc/v2IN9s4SSygxuL4KwJgGGcM4BC9gcxB
	 Y33cf9TJnuuE1wOGSyQbklajqObybF44Ifji/4VF3mAjAvgg/7Xa0IFLPEenOXPq1f
	 vuK7XN7db2yF2IJyxCWFtfYYoqE4U/Eee3i9rwwiPlr4AHf88EXptjXvhDXLovaGY4
	 yxUoVuvJMvgUw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5818AF4007D;
	Tue, 16 Jun 2026 13:43:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 13:43:03 -0400
X-ME-Sender: <xms:J4sxamlMnIor37gD6NzqrYdokrGSs4AezDPgHSQ1fLPFIpa7-AvXVQ>
    <xme:J4sxauSUoAF4aol9z6hhtHc8XcM8ff53S4ahMYHPqZWDScWOgj27jqT4D_LhAsOTd
    BQlOJ18ZwRgDSK9xc--1ARP68OoGsuFWQoK60kJkA2kPeErLjoN5A>
X-ME-Received: <xmr:J4sxalU5W7ohEcEvZ2zJG4ScrdXAQ2dLQO0v8D76Q25e2kvd5sb7lVIFgb4UK9BqnZiewoflb00ZLwb2DCrMqUafUbPAFcLxhxs>
X-ME-Proxy-Cause: dmFkZTFVmzI+6hvKUTzx/JJFF1J1hmHi57aeWtjxdAhQTt67E/BIs2S3ubLUOQPYWL0PZ9
    JopxHLy26hoDd1Ef72pRzPs6xxpU8+i0esED/uHXQBBPKOtTeSsm4HXj/Kteumc0tlBu8G
    aN4BRRk8pL+bqSUe6jTcAsnZjY/URusYaGyM+NaUQB2KtYpD/bWB1/PHkdDSVYFr+v6WYj
    11EcVVMTPEJU5IaIFt6QVlFm3v4xKGXYdmE0BK2215qX9zi/knfoVlYhi3UZLSnX7bPJS0
    shYv+fqn4facIQ97taWfSJQ5j2p37f6/crK+YmIfI9VeOwA7jF4KCN6OJinBO2rAN5Vpe5
    iRN7x7NNAiihdpPLXEZrAc6pZ7nSeQWDYby7ARMaIm1ogCWplt9VhSREioSUHwlJxnKpZN
    vydB/l32kdrsuZbKdJ29fB4iNPgbhB0ayHv2zGvAVXZmz4g//IIJuiDu4RcYjrZvCV/dig
    H2TMglhvVQHb0Co4Lu/Aqoxa2428QmUv3FHdrCR0vLOnqapTI3IIhsUA06ibu6+GwT9EKS
    8m4PBLKEx9cCQq6BXTC9AyEdyGbXRanKo/p5d2OpDBB10sHlZ68BGl0FAqn/8PjZ0njurT
    S+K8rcVM1MROdLcXowrWGpjXuKE9pQtvldwnEmXZu+r5rtuO+xBnYi6HM2KA
X-ME-Proxy: <xmx:J4sxaiKugVYqGOzfbTA_z70ll-xW7HZ8Qcfi58LimSBwKxfUXreYAw>
    <xmx:J4sxal3pp86vrtNL8sIBk4dGtkJNzYKfRj3Cc0XhTyhsrYjzTlPF6g>
    <xmx:J4sxavLrWNEYck1ROjIFxp077WfTVSSl9BpfXNwnD3_OWKXWOyxPxg>
    <xmx:J4sxagi6DcIX-6S7o3ZUcwgggeOutsEfOCQpar_Zvok4zX_ZJIKrPg>
    <xmx:J4sxavDcXT2HDUnQOV6LXoXLncJjIA37TMaUoqJsoNsWYjaTo6Pcu58d>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:43:02 -0400 (EDT)
Date: Tue, 16 Jun 2026 10:43:01 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, 
 dave@stgolabs.net, 
 jic23@kernel.org, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 flavien@nus.edu.sg, 
 stable@vger.kernel.org
Message-ID: <6a318b25443ad_199fc4100b5@djbw-dev.notmuch>
In-Reply-To: <20260616004007.4186004-2-dave.jiang@intel.com>
References: <20260616004007.4186004-1-dave.jiang@intel.com>
 <20260616004007.4186004-2-dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] cxl/mce: Validate memdev and endpoint before
 dereference in cxl_handle_mce()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Jiang wrote:
> cxlmd and endpoint are both used in cxl_handle_mce() without proper
> validation, which can lead to NULL pointer dereference or invalid pointer
> dereference. The notifier is registered in cxl_memdev_state_create()
> when the CXL PCI driver first binds, before the memdev is published and
> before it is attached to a CXL topology.
> 
> Add checks to cxlmd and endpoint to ensure they are valid before usage.

This looks to be trying to band-aid the original mistake of having
cxl_memdev_state_create() register a region-relative callback.

Move the mce notifier registration to be per-region and all the lookup
lifetime problems disappear.
