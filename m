Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83631A55B;
	Sun,  4 Oct 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106336; cv=none; b=Cz8RU+m9W7mliDRazP+hrLfHwjltw0ZAJiy4MhCUcyvRYZBf21HcNF9CtAnXoCDn2Hx1eKs/ottwj0LgeDHohb1dViHGu4e/01YdR63QGuh21Rb7bYfd3/s7pKqqPikLmxtzeveQkkX37ecUF+qO/e4pOA9MmUcX87S6IQ9GIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106336; c=relaxed/simple;
	bh=bJqunWKjCIs03aC2xgQfhIza1vw9F9flqNLZ6zKsi7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcF3XFPPMPssmROU4vw2AE04M+r1tldlcOU496wYKHkiZwnUt6l7ZI3O20msf+NqHGB1AwyVBOYLyjE4Yx1A3CaYKw2gS64XzGPWn6jiPVbp45nbwl30tEmw1MDkgEak57tY4U7X+GKDNZ3u3OmTO9MaWtfrDkRid+Kw/u4Ln6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ba9e13Bw; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ba9e13Bw"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4feacba8c;
	Sun, 4 Oct 2026 17:32:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: ssp: Serialize watchdog timer state changes
Date: Sun,  4 Oct 2026 17:31:57 +0800
Message-Id: <20261004093157.1188299-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <asIQZ7no-0OrOGn0@ashevche-desk.local>
References: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn> <arzdLtzXQ4cvObrL@ashevche-desk.local> <20261004053915.1138888-1-runyu.xiao@seu.edu.cn> <asIQZ7no-0OrOGn0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa10641ab1603a1kunm4ba7b26b336b73
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQksdVk4YSxhMQh1ISBgaGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=ba9e13Bw2ybZt5asDirFmJ3ovZweI3SNMg6fmPocb17sMdiHbxjSDBfpppSa0XmSgExkLnftI4kDPYRBywSte0uR2qCx7Es62UBXVTxyrmRpqeFrWqBv78C/vIIQOhUUyT7Y8dNnM9KcLXA3keKiAcm0jsXf+xDu+P6h8Pa7HMI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bJqunWKjCIs03aC2xgQfhIza1vw9F9flqNLZ6zKsi7s=;
	h=date:mime-version:subject:message-id:from;

On Sun, Oct 04, 2026 at 11:37:59AM +0300, Andriy Shevchenko wrote:
> General rule of thumb is to defer a new version until the discussion is settled
> down in the previous round(s).
>
> Same Q here, can you reduce the gap by 4 bytes by rearranging the new members?

Yes. I checked both layouts with pahole on x86_64. In v2, wdt_enabled and
wdt_suspended are at offsets 80 and 81, and work_wdt starts at 88, leaving a
six-byte hole; sizeof(struct ssp_data) is 816 bytes.

Moving the two flags after time_syncing and before timestamp puts work_wdt at
offset 80 and the flags at offsets 203 and 204. There are then three bytes of
padding before timestamp at offset 208, and sizeof(struct ssp_data) is 808
bytes. This reduces the structure size by eight bytes, exceeding the four-byte
reduction requested. I will include this layout change with the other agreed
review changes in the next revision.

Thanks,
Runyu
