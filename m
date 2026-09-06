Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD53D812A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701642; cv=none; b=tGRzOTYOyGQOlA6c3/cdJVGpMVWvDB6mf12uB9k0lK3Im56EovdtQoz7/1jxTOCW5trDgRUSt0DLV+bDKIH/s6lNKtWioYsNlAWLuDeZaxb3tsQFhazTQIQ404SngSEu8V+YpkpN9ZOJcjSPNFVCWY7Gez1b4uz5BV90u3xT1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701642; c=relaxed/simple;
	bh=dCsCajpFjeCJaP+49/8pXscl3UuGYpOK/JRau4ZSHHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3kfOCQO4a9NSVUbLVtZMWZAuKDGx1OhboBfAI/ibHDfMJrti0E0LAnSCwC/YqkmRjtBZ1yEGdpw64ExXcM6sbTeF4km0HzIPaBqYcAWHaAriwXcUvAXSu/T0HSdIARyNYV945oS6DZTsIhPuSAbqYsENGz+v/ep5ensHwFlhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0zLqV/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0zLqV/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC81F00ADB;
	Sun,  6 Sep 2026 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701638;
	bh=Qho38aOBhB5iZUE6YbSJ5UXRYZQcPfzz6Mw1So1QHL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0zLqV/goKwwHC0jjsHkp9EPImYKLpl+wTZjGB6cbR7Vp/QRLlZbm6OQbINd/BKaq
	 x/xN9Kh9Z4q4xwynWepZaP2R8i+e8UYvP6URc+AYGp//WptB2x1zTUjlFi5Xj9rizI
	 d3ZUdgBqheZB8BpRvyymjDVSjBC9eCIADEl8WQw19IscRjNJIecUek2zgx0U99LXN9
	 oZIcY9VRZEZ4H/ie4PQtDUT9r8ht7ywCcxj8PlLNcMXT79RWBKStRUMXe0rMQUwwvR
	 B2b0fW6WCbIRno+fCpIYS3c9oSc46V1LZ8JFGMVxnULoIgR2alLOm7o8aXUh9HgDtf
	 RXa559s3jpePg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 6.12.y] wifi: mt76: mt7996: validate default EEPROM firmware size
Date: Sun,  6 Sep 2026 09:33:04 -0400
Message-ID: <2026-09-05-daily-reply-0034-mt76-eeprom-size-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904052114.15758-1-acharyalaxman8848@gmail.com>
References: <20260904052114.15758-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The default EEPROM firmware is parsed and copied as a full EEPROM
> without checking its length. A truncated file can make the driver
> read beyond the firmware buffer during variant validation or the
> fallback copy.
>
> Reject files shorter than MT7996_EEPROM_SIZE before parsing or

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
