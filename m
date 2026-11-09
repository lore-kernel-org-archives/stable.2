Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239642;
	b=ivs3rcX5nzctWzxuRWWyD32lw5ZEWDHP31WnUsPZQxrU7t4Ff/CZsuGr9TLNy1NsnpTl
	 1UePyW/n2w7LntlTvuouSmE4yI4dNsxnotAB2pQgq/7oUzqiDvZ6paIfh3m/H7imolfBn
	 GvTipU+FQtOgJUgpbSjZXEvLwJ/XouO4LDGdyEJwWPxCd0W26yTz/2VbcsDSFm2/n6acP
	 5Vq/24y2zScCFsI9IuVPnWk5/yLeWOdnlsUxHd9Oq1Busmjji+7Oebb6ICOBVRnl9jgn0
	 +pyiLQ2ay6psgT2CaHcq/h+kXbVKYARRC4QPzUN2nEt21rD/H3qXw6/Ktk+124Yz1kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y3YB5YbiuQvlnYin5TA+CtmzFCgf+WRu3BBHRIcyilI=;
	b=SdKbXhoXLZJwQ+3cefQVOylP5Awq1MjlGFqdF7rUHXymY4mtjkpuVVyrpEKWnGpyA7WC
	 bKR0v8QA3JMNWi3JfN49cf7EP/nDNszjAYpz+ZVHe8yM1miSuw7AToOotJGjB6F3B9jj7
	 VMOOwD1gKBLWYKol5c38oliBvmNsSkUj2rMcY0TbVYS8PwN/aFZHCdHrtY2yH96mM+v8E
	 t+Z9Wu2dx3Zpu8/gl2TkfCUIfok2aKpR/zkkLw9XChqJldw8nEPhuSJw5N2XXfNfhgouj
	 55lfk4rzB5IhOe9J1viLV1SsWNN1MwydMMPzPZgkUnE+u6HBZ5ZBL+T5cWC7WTHwX+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QDlq/AXr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CE606EE87;
	Mon,  9 Nov 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDlq/AXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC7A1F008A2;
	Mon,  9 Nov 2026 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239642;
	bh=Y3YB5YbiuQvlnYin5TA+CtmzFCgf+WRu3BBHRIcyilI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDlq/AXr7a9CSt1y2VK+/xvLG4sET/srxI85cbvrnYhmh33iSRRs+Wb/LopWpY+nN
	 SlrT7Ctobrir8nb65sNxYXIn4/JcJyPcCY0pr6Hkq6JV+sMwSypVTb+Kq2bzJN2kWm
	 XcOpk4dIWsKWriNWCmpIVAxZv/wkaWQnBCoAvk7UXGRiqNVSvNVxuIt9JIlbHY3/H3
	 w6vidpazP+hznAYG3QqQVpndKv18ZVjbfZrbpd7NtpnI63H339eJlSRMVO/7OLynIU
	 xCK8kG7ncRNYEj/N/OgNlDdUH3IALgXJ9b7SOU9xfZMs9pHDg8l4daJECRNbtyt0hm
	 GzItDZohl04tQ==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Denis Pauk <pauk.denis@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Antonio Montenegro <antonio@montenegro.gl>
Subject: Re: [STABLE REQUEST] hwmon: (nct6775) ASUS X870 WMI board list for 6.18.y and 6.12.y
Date: Mon,  9 Nov 2026 10:53:17 -0500
Message-ID: <2026-11-09-1-daily-reply-0035-nct6775-x870@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <OocP7QvaznNsJNvvrIUTZiKro-kv7JbjucsOkkgAjvGbO7C_udRcQGssHVLfd9_Kvlw1ILWT2dCdB87IIu_5xVdg1bLvtRvsPvHH5OtlDXI=@montenegro.gl>
References: <OocP7QvaznNsJNvvrIUTZiKro-kv7JbjucsOkkgAjvGbO7C_udRcQGssHVLfd9_Kvlw1ILWT2dCdB87IIu_5xVdg1bLvtRvsPvHH5OtlDXI=@montenegro.gl>
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

> hwmon: (nct6775) ASUS X870 WMI board list for 6.18.y and 6.12.y

Queued both patches for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
