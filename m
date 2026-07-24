Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB5423784
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889500; cv=none; b=P2Ws+yB7pSnBmwlglF1qjIxk0Ad5QpMMUu3ZMeIMUIvfgeZIxjFDklC/9fOdsS6RrD5zE9H1hdtQRkfeAjKZruvTTyaHjumc9SuoB9ohq/uljYPdSs7xcOTX8HeigcuHsxIDIgGmpsXap2SA4SpQES2fe/6IglysHpHGMazos+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889500; c=relaxed/simple;
	bh=ldlUuMN1/VOgh62QEP+xI5k3bqj43QTRELW6114pOsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXKrMPzVGvkARTQKN5zsz3jjsn4ZF/aPMPhgNBNxkook20tvih5WgvSUMErL5XRwuDcJAwmMh3ibEJ0m6KxOKbd0bsxqeD7Xk2rjmHH+c9magzultfEJb86l4VJZjhUKQSDD4C0yHKT6uyrKMRSzvLUEKKpTCysL7srAyd9aXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=P5RMvBJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kn66g9+l; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="P5RMvBJi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kn66g9+l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C364EC0102;
	Fri, 24 Jul 2026 06:38:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 06:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784889495; x=1784975895; bh=oH386kb8Gj
	Ftxjb6rVHwWqUfizRM2mhrTXYpuZljCUg=; b=P5RMvBJijvsgQbdrWUTlpFZFi2
	RXeFIkCR7pIPOt3pM8YtrQFz70SNUfFCrJVjljgtqOA32ai+uEdcxKXMHY/W2O1R
	YMiKZFcUA00AYqEe2wjAFtxLUgDNEsu0oIqTc7VJLPEuSvBM0JcoCdm4opuTTlRj
	cslI5VYAFQMgsEukL41gbKtRHSZkj3ygNjxskuNxsSMCYxYfiP+FNZRCdqWor7Hh
	gWjf3FKuZzcVIjgmhMf5+YFDvqWXny0pCTFbkKle/A6/zh9+hzMBXY2tXZuO/CNa
	hC6U+A10ImGNKLld0ui4RJfi1kmqFQYtEZT0uEiXZpf5YYlcgiGjx6f4phNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784889495; x=1784975895; bh=oH386kb8GjFtxjb6rVHwWqUfizRM2mhrTXY
	puZljCUg=; b=kn66g9+loe0cBjmyJe8Dfcy6HMv/7W6Lf+wANswnX3kUEVh7kAV
	5ZkH60YPO30zey+wW/Ea7J5rC1a6dwjTdBo6tl+7N1kgzqH8X9CaH5hQDCiwjRo+
	dFK0Rmxgu9r5RUUtMohOpJOmoHerU7G6yjOxnQArAwW+OM94rQNziBtjqI5S0uM9
	rWuamIJnGKXY4HQor1YPuFFNxF0fa8TSh/ifpb9KS0AuNYjehe0ZRYbKOf8QLcW8
	1fD9inKPK4TfvzaHxVaGBj41RwiERswlnqcT+/IR+k+QaVyMmK+wM+LWqeGC3ZpI
	gYf2r2Gc2VrTADkVmTgAOKevaDP5i5gX89g==
X-ME-Sender: <xms:lkBjajKRGeblSF_KbcNBpXbD9NWWwrXkreynNvqU5gVv0eZ9TUFG4g>
    <xme:lkBjagcuWwuyfxTQ1TI48jBGGp_lfPrhXiLXlPckg8xeP-Tv7x2PO8e-TL9fg8PPI
    msVALWasrlftkjWyqeQhIZLHIKsKUTWBAXypli_y3GCil82>
X-ME-Received: <xmr:lkBjai-yFqhdeXtwlQWLhjNYlfjjgMkuC6ZDJ0XsZWg-JSakeKQO31O17LmwX5toAZ3bSxvcX5y6cbpkCTwPqyTpnA>
X-ME-Proxy-Cause: dmFkZTE0jdRMYxddZ8OzuIWBG0re43azGazaBLSl6YkaE6gbdoRJRNkcmQz16jshc/yKDo
    S1zeVdHKn5OCxN4gwPJlG6IeuM3vTXNS4WXVQl6VfP3ju82tOAjsRklWCFC0lLZyz/z6jn
    CY8w5HY1Wb8d3I6kClaetdbxt4jMIHef9I3GNcpg8HI3e5KWbivlwfx12RbzM5a+j7Piec
    v9n8uYAEf3KAC9Wwmv0ewjDKI6gBXhw7Y5nPJ3rLl1OomJqJ9xO61eUvG6gZtaYmnL/s86
    vOlb7SzMDJm+3GAKI4QoV3FcNGosw0zQXedK7YG3XqiTWXSntkTzeFNwWvkz4O5wJlsfZv
    tUatQpQwbH7KfJRTaD5k6PptYMNJmQsF+gMgIDD4fHQUXbLTSfDiCuuf03OTAb3wBoQXEf
    O24RGFKiwm2lZcRO3k6BfIalz9JIfN/XkCERGxGzv/3Z0PwC6sFKhvOkwrfhRKZaGA09pc
    Pr18BQO5Qas+ZRpp/O29CCCLYp0GWXfohVoS1U/BEFhpD0dIvZfGcp9loR96lTZBZ/1ZqA
    MwiORRKAy5rthXU+xo+tRipDp6uN6yns9vemLJ4Iu4EcAZOqFT/qGPhBthWH86AHmdJzr+
    Edy6QRftVzpHHRvetUO7IX62SKVA0RGVC2ow8aETeeyuIwFPZY8+uWJiuEBw
X-ME-Proxy: <xmx:lkBjato2RIp9Vu3sjDvkq6n6dxMDjP_l2xsRAjV2wCtwqWzIiDlGtA>
    <xmx:lkBjanCtU9PqBiQpTtkQWvDZnnLMatZcZMUwHgFLOVsXf9NJsfMzyA>
    <xmx:lkBjavx8gSrYZjyri_MmEdaA2LdcE6QYYi9NHoe_752p_n--g2hEIw>
    <xmx:lkBjak17ABtmr1_kgNLuCsuF_GX3Cqq-ZDpybVKO6TLBKy6EOVSaJA>
    <xmx:l0BjausxOXWfJfx7-V8U6lEmDYTdxYrexbpb4bFQRaM5fMiFqQCWiWzP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 06:38:14 -0400 (EDT)
Date: Fri, 24 Jul 2026 12:38:05 +0200
From: Greg KH <greg@kroah.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.10.y 1/9] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Message-ID: <2026072445-impaired-award-faa2@gregkh>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>

On Fri, Jul 24, 2026 at 12:13:34PM +0200, Oliver Hartkopp wrote:
> From: Lee Jones <lee@kernel.org>
> 
> commit 68973f9db76144825e4f35dfdc80fb8279eb2d57 upstream.

<snip>

Much nicer, thanks!  I'll process these after the next round of kernels
goes out.

greg k-h
