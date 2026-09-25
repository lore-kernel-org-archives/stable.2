Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C238F929;
	Fri, 25 Sep 2026 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362105; cv=none; b=b9dnOl2hnSgPYSagZvqKEbS4Trv2KR1kjaJzvXjO6XcTmkA8iycAyIM2oWgFZ0HY78KxwNnOmG9fvZqDemaGgcxDDZkeWy9w/nz4QFAr6ucHxIY8SQxaeSPnKzMUsi5jSIRrwZwVoh8cIgQYkU/HGPml0dLm1N8VH6SypYFuvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362105; c=relaxed/simple;
	bh=NnSPVYt5mf2j36ps64rwbyDd01WCqROCDqO8Lkv6XZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdooPPY3Z7BAUY5LfEyxzkdwh+2JgvrD6mDhqJlnZYO9S6si1bwE/2UPcoDEo+WaU8jTT1fvvIHj/y3QqUtIWXcUF4uAwdwlkpZBW0F3LVDEA6ve3sqdWsbOteyy1dbXM7KI3me0Neb/XLlMpKu9JwMAcChY1p4ZrRNY4kdw7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLX+bHhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLX+bHhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0501F000FF;
	Fri, 25 Sep 2026 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362104;
	bh=EUPlDC04Edy66hGqCEqyA7tazdBwMDQctXt4DIMuE0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLX+bHhvDnIISaKoaaMD0fh4oBzTtTawnKYI64IkP3JVUhfoKmOvvFt7aBdxogQm3
	 g9jXSf0fPRERk2imkLBrPFA1yV4bS3TeM5l1kg0yJr8F6qrSZzWKo63Aq7T8GtNPzI
	 Rl6YN20pnFwTKnStlEU9dNni4c764J2WRdv5mfj5LtyDQKK4xdMjCQigcAUA8ibH85
	 FZ75D6KrrhwK4xpHPHKlLn/g5TGMM77zx4OfXvHblpsQtKRKpB8WJjPXadMVZdh2YP
	 3y/o3qM09zxV4E+vTc6VJZLte4q100NXgyy9cBeerlBQSne9xSxjcA4SklODyDy18k
	 vY+2vz/Rtl0cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Daniel Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH 6.1.y] media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
Date: Fri, 25 Sep 2026 14:47:59 -0400
Message-ID: <2026-09-25-daily-reply-0007-re-ipu-bridge-null-deref-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924173315.87556-1-artem@trailofbits.com>
References: <20260924173315.87556-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: apply the sensor adev assignment in this tree's
>   older ipu3/cio2-bridge.c and cio2_bridge_connect_sensor(). ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
