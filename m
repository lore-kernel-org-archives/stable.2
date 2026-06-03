Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6539DBFD;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=Yoao5KJMLaOek2mp+EF7Js6qpvk9GDY/rdjiUaG/5rWlzbOMHZmd34SEoniNS++nvbR0MCw+zjSh+VmQrIPY9OCdlqRdUgtELVYi/AneJYBFuEWGCfTEoFlWTczkiS2boSfEJK/+6k3ahgdDkebv+qPmYR5JCyefF5iUjLirfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=3ldfLlzV7SiXkElP3s/RDvLIp+kEC+gqbQUC+4m+ucY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PCL+h9x/qUxKwBV57aPB7d8PyV6bVNh1sUMtVS9ibqiiScCYDzFG+oBMhkAUuAC+2f/KUZzKjXUiQOVnojYQjozvChINQhtnBwFm6f5HavlaUMbSMnt8X+bxzyfVbmXILwG4UQWb4cpxTWURCsncccxGD7auY52Ypt3UFhYozc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FDB1F00898;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DF561183854; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, philipp@uvos.xyz, Ma Ke <make24@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20260424011013.879639-1-make24@iscas.ac.cn>
References: <20260424011013.879639-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: cpcap-battery: Fix missing
 nvmem_device_put() causing reference leak
Message-Id: <178051961989.2666348.3637459049042630916.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 24 Apr 2026 09:10:13 +0800, Ma Ke wrote:
> In cpcap_battery_detect_battery_type(), the reference to an nvmem
> device obtained via nvmem_device_find() is not released with
> nvmem_device_put() on the success or read-failure paths, causing a
> permanent reference leak. The driver’s retry logic on subsequent
> battery property reads can compound this leak, preventing the nvmem
> device from ever being freed.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cpcap-battery: Fix missing nvmem_device_put() causing reference leak
      commit: a2c14ff63e0e02e3c832385e523e9cc81301171c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

