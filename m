Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784780;
	b=bkT+BOIyJGUwzCZUjX/qvkeXtCZ3Wh5HQwWkq9CQjk/0TpPf42pqMj7RDaM1T1DFulRK
	 KC+CzfwovNKJGiPG2Qgx2AgmqsRDWr7azdL3dBfiI4Pp/EBCro1XyHAjOTwYfBZOncJWm
	 /pnEZVxhqRgilithy7xkXbl1BFvdGH9gw2x4gjBQDQCvchtrTDbHY5O32ZEcZNq06WhGa
	 O3oqrTndZe3TUa+JCD7FotAHjGlTAm6ftY+NEjVg2agaqVIpGMvZlI80INBkzFRF5L44Y
	 eKGj5WcSrPfzUxbExVjEE7oYjNWQVY2c6xR9YcGYcKZkCbrW6rZRTcOnRM8Ca1yzToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784780;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=zW3WAwOIhD2940ok5Ysp8C9N1lcPwOPYgjTzBcC4E2g=;
	b=ZqynkdOSYlFlLBJ7ylX0agDddZm4l8TJ9NH7XkvS8Xfy2uzDe88oAJ4mZC6QuWPZbiBt
	 5f7OKEHhUoflmd3qfgzMzYh3AAcVUsfXT03Wj4UcLz9cycArpSwHcnYkrecSJ9S4y5s/1
	 SkbmrzT8eG9WgD6oVYEUr8Ug6JvV9Y9G2zGfbCvWIM+9URdOrqhxsqdj4SHayI8moqxdS
	 icwne0DvBSltHwGCbQPgrseP3i4XFjOrzBynV4ykzrNusoJKvenKUH+dGbMAAg8RNnP1y
	 595l2Gu+cG2WwBVWXvHua51yl0J9LLHCH+s+goT7kRAdPuVrGXZIc9UBZB8aLKk/8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q6vwdnwo;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA396606A31F;
	Sun, 15 Nov 2026 23:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA396606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q6vwdnwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zW
	3WAwOIhD2940ok5Ysp8C9N1lcPwOPYgjTzBcC4E2g=; b=Q6vwdnwo0i1zIwDlDq
	J7RNLcxl6SWskDC+f7SHrE7lTMwe+p4kiCHYKJE9UYpK5ZciKG1F7b/XG42hNQm/
	V26ycwV0fVPg38ArFJn0M4ZCc62iEATVsFviYPxsAkskEhcCpHzjn5Pt4RpoIh0e
	Is0Hbleipvw/hxhDq1ZqcUgbk=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBn8YfgPfpqh0u8GA--.59459S2;
	Mon, 16 Nov 2026 07:18:57 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7925: fix mt7925_reverse_frag0_hdr_trans() for MLO
Date: Mon, 16 Nov 2026 07:18:56 +0800
Message-ID: <20261115231856.965757-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115192725.8230-1-enderaoelyther@gmail.com>
References: <20261115080239.910402-1-zihengw03@163.com> <20261115192725.8230-1-enderaoelyther@gmail.com>
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
X-CM-TRANSID:PygvCgBn8YfgPfpqh0u8GA--.59459S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsBHqUUUUU
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7QHgMWr6PeFs7gAA3z

On Mon, Nov 16, 2026 at 03:27:25AM +0800, Zhao Li wrote:
> Not every entry is a station link. mt792x_init_wcid() reserves index 0
> for beacons and management frames and installs dev->mt76.global_wcid
> there, a bare struct mt76_wcid inside struct mt76_dev, immediately
> followed by the wcid[] table.

You're right, I missed that the unicast branch returns the entry unchecked.
Only station links set wcid->sta (mt7925_mac_link_sta_add() does, the
global wcid never does), so your check covers every entry. I'll send a
v2 with it and without the redundant !sta test.

Thanks for the review,
Ziheng

