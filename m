Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749919;
	b=A1HmIuJhsWh2uOPY5rsDUb+aE7ZjQZb56Wgfv+NJfECD8kKvG9HRewN4RVmbJRgPvtbR
	 LuMr41H3nWSYAgGNl4f3Zh/Oru6IEz87hq011ZuWbYJZVI5yK0C1OhfM/rdkv1ASGCS+U
	 WkCMuHYSs8F7Zhd9XVQISv5RD4y6WYCPlKabh8w2Ql0DWQbONMML9vprQpfb2YnE2VjoW
	 YvCHoTQ95oOlAW4YT+IEQtYjDdzjyU8Gyqie+uF014xxESvZeJORj5Q6r2T0NgjVcfXuV
	 rS5n8mHhlY0mjoWrF8EM7eZ9nrvlY8s2MCUWevwtcaQCX++vicUI5IMoA/kZj5ZkOfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749919;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=PeNZzg3oK75/b0ly5y0MeZF2YmpGhG/qY/Asr9C+wmU=;
	b=OwAxE6HfsBoBCUUpqvgD9P/7RFL2MjBvMWACEyVZGpuPUcy8mYrVz/4KoOYtjv1UoW9V
	 NFUhByfkbbXWnbOnGB7lopZC9xZ247ViOdEtY7arOQDHYFf8GVI7X+xvCqTO4EO0k4HAH
	 UPCF3IB1wA8QmhRCqlGHee1/mqGvGjIiuFAJfuLjv4YWsycDylmyDqYSexprd+YutUtR9
	 PM0qKUP20KePL3If+5PeJdGkbB2TACL9UwhishQMIAXNnXRYT+3gc8c2024EHBO8gv6Nw
	 t5IoXx2ki8PqMQcEP/EvF0kY7IabNHQilFDBOZuevyXo7Ks5qFlZQeZB9KBNrcdWcsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=jaxrtMs9;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93E606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A93E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=jaxrtMs9
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id SaFJxtaWHAR1iSaRLxS9EN; Sun, 15 Nov 2026 13:38:39 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SaRKx8VLddRrRSaRKxFdtV; Sun, 15 Nov 2026 13:38:38 +0000
X-Authority-Analysis: v=2.4 cv=LOhmQIW9 c=1 sm=1 tr=0 ts=6af9b5de
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=p5UCd2gWKyfE8sLfB1wA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PeNZzg3oK75/b0ly5y0MeZF2YmpGhG/qY/Asr9C+wmU=; b=jaxrtMs9y5BthYT+TG31FZCnkH
	1OydYFXnDUVdepNvMva0wQ8mn6nli6Z09ocUs+5HmUxPPxolY2vL3bq0NwuWAAe5XJMm2FRNCrZew
	l1uffQvr6WavSMAyyjZO63lHuReAwX3Mr3UX+op7M27Tvkbu9WO8Um21QNS9xPHQQBrW+ncMOEDfM
	pQsovE1uoTy1UKOjnX20r7fX7CVFVXeHj2aX8nidA8hqMb8JO5WVH2bx5RE/lnA4A97fMYkLqEnVT
	Ockz3GyeH8r0rMsVfEsdi48PVqJr/d+x8Ym9GcYdSjYtEZWn3RYsr+aomNz2q+gpZbBqwMDiRnK6o
	SATN2Wqg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39426 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSaRK-000000013mU-0Wu0;
	Sun, 15 Nov 2026 19:08:38 +0530
Date: Sun, 15 Nov 2026 05:38:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ziheng Wei <zihengw03@163.com>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (w83792d) Fix incorrect struct cast in
 show_temp1() and store_temp1()
Message-ID: <b54bc0c0-1357-46a9-85e8-2fd38bb41b17@roeck-us.net>
References: <20261115080203.910033-1-zihengw03@163.com>
 <20261115080203.910033-4-zihengw03@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115080203.910033-4-zihengw03@163.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSaRK-000000013mU-0Wu0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:39426
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 14
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEKKpH0lrIQSfRWbsS0RvEo4mqA7tK3ZUwr2zmdI0yspc69lkWiigWYaLOEWJDP6H4fBuiLJ+Idsbca1IddWk5izheAGk5b9/y/MUYYsrqcX2POhZ6zX
 49bnKX8mpxNx2BqQJboX1qTYTA+I/kx1VZ2MUPdcg/5o8LM01RZVvxJUMkwsnyjqQgtguGMwFKFZiEiJpVsECjVqEPSFzh2O/GRESzZC0Cmf+YvPXAVHHUpY

On Sun, Nov 15, 2026 at 04:02:03PM +0800, Ziheng Wei wrote:
> On big-endian architectures, accessing the temp1_max and temp1_max_hyst
> sysfs attributes in the w83792d hardware monitoring driver uses a huge
> out-of-bounds index, because show_temp1() and store_temp1() downcast the
> attribute to the wrong struct.
> 
> The driver defines the temp1_* attributes with SENSOR_DEVICE_ATTR_2(),
> which initializes them as struct sensor_device_attribute_2 (where the
> index is an 8-bit u8). The temp1_input attribute has index 0, temp1_max
> has index 1 and temp1_max_hyst has index 2. However, show_temp1() and
> store_temp1() downcast the attribute to struct sensor_device_attribute
> (where the index is a 32-bit int) and use it to index data->temp1[].
> 
> Because both structs start with struct device_attribute, container_of()
> resolves to the same base address, but the field widths differ. On
> big-endian architectures, reading the 32-bit int from the memory layout
> of the two u8 fields yields index << 24: 0x01000000 for temp1_max and
> 0x02000000 for temp1_max_hyst, instead of 1 and 2. data->temp1[] has
> only 3 elements, so the access runs off the end of the array by up to
> 32 MiB.
> 
> Fix the type casts in show_temp1() and store_temp1().
> 
> Confirmed on a big-endian s390x QEMU guest with the driver bound to an
> emulated chip: temp1_max and temp1_max_hyst read 0 instead of the
> register values. Not tested on real hardware.
> 
> Fixes: 1f8dae31fe8d ("[PATCH] hwmon: w83792d use arrays of attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziheng Wei <zihengw03@163.com>

Applied.

Thanks,
Guenter
