Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792736213;
	b=dAZAcgHzEbOdQXa+DenhohDv9m1+CxvhZ7lNnZyLCxcT5JqzrAXe2PELzIi0hgiqBoN7
	 78ajDo7qZKb1t1hZ7YBtoLA36b2E0gt6YZ7aFTRhzF+QhJ0BwtRTotiqkwmjWGMYm9fhp
	 K50eha/zwUiNxg+Lc2sL/rP2ReJsEYOn8hSDtkA0qVmBaouz7mso6Vu62UHc+Mh9KRvCx
	 bzA6KXHUEW2fEtfwNX8hfMZOy9Kj+KcX9Ww1eG7ZMBU8m9QIcBx8B7VoVK86WkGU+hzX3
	 m5+ZzVHkZg94IgdM4G76UQhjZMmmCaTL+fHMHe0e9myvv01A+dmqOXRt/V3jriJtGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792736213;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dWUb9dhf1AJLnKh5FNSJXMuqATo2Wd6CCcngSiSICjw=;
	b=lBAQUOYQ+AT70/jPKx79OKNRWKJd4crkoPiH6bz4mBW/+h2ef41cWR0IDePN4bD4dy2i
	 AWFsUJn6zltjlFar6vPfl9oOXaM/iirtqfeyaqv/9Zd/RFAJtkbHw71dPdTia/+xsjzqV
	 rPquT4fMOEgEZdicPr3nrb4QXUPQEiTD1mAIDXeXF4FBVIlxWVQ7vpHJwJNVyKo283n7T
	 nikxuBCnjiZN5tBTENK4AVx0JvfBeHtMOHE1U4aFpViXTKvHFmBDBSZ1OWE6Isfheb4+I
	 Wc4nYcuCvIq3rbuKEQHxrhv88H7dKw4Ty/ig8bTbtbJAi0mrN+l+ren7TppSKkS73zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HdjoLYDL;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1766606A31A;
	Fri, 23 Oct 2026 06:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1766606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HdjoLYDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HdjoLYDLLcGZSzPkwX8+vcRumyyt0whQanIi/1MAmKJHxTEWIBoLHkMvX+V9M71xs9ABkuwVlwJxJ
	 nc/dSgWylSRTiRaUudPVH9vA8HVCZb5doX7B2cuz3/khlqtvpVll1SS1QVr8uUvvZd+A4TFBO8ZeK/
	 tHBgTrIkhX56LT0w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66adafbc9f0b-02dd9;
	Fri, 23 Oct 2026 14:16:41 +0800 (CST)
X-RM-TRANSID:2ee66adafbc9f0b-02dd9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16adafbc8802-37f99;
	Fri, 23 Oct 2026 14:16:41 +0800 (CST)
X-RM-TRANSID:2ee16adafbc8802-37f99
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: hangbin.liu@linux.dev
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] macvlan: fix passthru promiscuity accounting while down
Date: Fri, 23 Oct 2026 14:16:30 +0800
Message-ID: <20261023061630.350083-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atrKdb1atGzCYka4@fedora>
References: <20261022090809.12019-1-yanxia@cmss.chinamobile.com> <atrKdb1atGzCYka4@fedora>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

> If we discard the MACVLAN_FLAG_NOPROMISC change, should we remove the bit
> before calling WRITE_ONCE(vlan->flags, flags)?

WRITE_ONCE() still saves the new flags. The patch only skips the
lower device's promiscuity count update while the macvlan is down.

If NOPROMISC is cleared while down, macvlan_open() takes the
reference on the next open and macvlan_stop() releases it. If it is
set while down, the next open leaves the lower device's count alone.

I'd keep saving the requested flags. Clearing the bit would lose
the user's setting. Rejecting the update would require bringing the
interface up before changing this option.

Thanks,
Xia Yan


