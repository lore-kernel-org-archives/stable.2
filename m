Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B9215F42;
	Mon, 20 Jul 2026 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511127; cv=none; b=aETw9zG0vMOJMOR86QEO1D4Zfd6C1ZxQE78p5VUDifhNQqokpYwAdcRjiBnjB+SVMYcCDeku/Ff6TzcsnVPnSBY2J3rZGsNbgPY0YsW1tnZGaIszsSqTae8Dy89qr7ydIkChCQHOEN7qARdhAlFxbQvfAZBD1p2Escq1shIDbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511127; c=relaxed/simple;
	bh=ciJQBWuCMpJskoyx4oYlEgHxNuUgYQUOHXsJ4wkxxqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkotulOWRyEoPx0KmJn2/AbX2fKJ2msibuBbEugn5QNtMdcTjicIZPDkbNqPTrFwCnYm3nqPibelKeKKV+SWKzj2S5X3PFlC4/n+A3wIS5R8zjpvsyCNTvSGILgHV2MMTVNWf5wxHqO+NUH3YzZp8amEsFp3I47ehAtjnVvNW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qHfRhOpw; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qHfRhOpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784511101;
	bh=ciJQBWuCMpJskoyx4oYlEgHxNuUgYQUOHXsJ4wkxxqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qHfRhOpwnpcHBBC4QuS1jVlufNYMTcpwd81Ph5JJ2vGQPX3ytQ/0Y0meQ1VTCmu4k
	 27DG+y5oo+zF7Ob1GXltUX1g/jVz9Qo/J3cmjNntPm5gSsKbZ2WzEI7bq8zEUgJU3b
	 4AKXsVIS6UZsj5NoMVpuVoa61AAXd9kpGYDx549M=
X-QQ-mid: zesmtpgz7t1784511096td8712445
X-QQ-Originating-IP: AJLZnUFlOfh7pRGjJrJL8dNwXx0DmU/vU2VhHu10oOY=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 09:31:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15458653347865684926
EX-QQ-RecipientCnt: 4
From: raoxu <raoxu@uniontech.com>
To: phil@philpotter.co.uk
Cc: linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
Date: Mon, 20 Jul 2026 09:31:34 +0800
Message-ID: <3A90485FDBC7ECB8+20260720013134.3300995-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <al0aFtSXRNqVpbAw@equinox>
References: <al0aFtSXRNqVpbAw@equinox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MhFOcXkG57gmloEfndGmTnrywFPNriKMIoKyNojxpupOwE7YbqF5siwP
	hs9wcFaN3MuFsgMBoulqM+6n8hXcMmhL9a+W8ADch7PJ31yLch7XhFkI5Us1dszA19uwUz4
	BdHPtaEnraEN9E57D6pLUg70lgc6Cnfb3OnMPzrARsQ6SKbAkfgton9pk3egmcWBfCPkxp5
	vK573mFOLLud0t8L+hZcJh5wV9a4+lZbMZXMvJE13G3ez9cC5GdZ3oFfRb3N+h7DuZofikw
	6wy63b8srDKYFfX0VjYj+SFkNnoJECwWIJ1TkUvtwzaCPIilFmXHvzlRI/c+8zHeMJYCv4q
	QZgM10w0S+3c7yVRwTfEfBWyaz/opdkr2zIOklibai9VVeqBSBi93842seb+VcwDu7o45i+
	d/5heJeBUJ3qhO8M2PRb1I8OQPU0tqInuBOdaZRv5MrU5X4ZzG8iBeDm9K1KHaiisysndkm
	5ZhKNbgVJeceWgW1pRUlROZuCY3T78+9jRH008epJB6YOzWFkQq4BpZBEvJmaE+j48hw0oI
	naC3xnEXfTzHeP4eZo3ba81JSfssisZx+juzWCWrQi0rsout22Ff4Hlk4PDw5Zp/QyZTAYB
	vDtjtkOMGjZX4i7hytrnefFzD/VVz6tF8TMuB+suTfwVqejMQcFYxYgWB/Eq3NzDk/8yLyT
	G4vqtQQrA4NoZ3rCXJfbSv8ymelvXCdvkGl2ekByG2Uvr1kGoZwbInmJeq7VPLfWQVkmEHo
	zTVMOO55aOIKlmP2J59U3/mDWMl928dreWvi2s/dRVoyeDx8uCfciJL9PY9HHTLztZsT0ue
	vjnTDspSh+Jamu/xV3vZu3XMZJOjolzPXY4fX+eF4Q9URzjfxzaEwyLWyJayN/PuV2buvan
	ngPagkmnSOU09v9ftR6gTPECspzVT5Q2Ka5e1c7Md+9L8qLwH53p6bg8cbTlHhqNWxOSxaM
	rbF/EhdQaYJFIEBlylue2lJ6o1eayoZerHYylUCxjAP9Z6YbLmWjTGXpW0amuFv7CXgpXFY
	f6ZCpRIQF2IbTCGugxT9CazVaudlQ=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hi Phil,

> One thing however - I don't think your Fixes tag is correct. I went back
> and looked at this commit (3147c531b6b5), and the problem is still
> technically present even prior to this refactor, all the way back to the
> initial Linux git commit (1da177e4c3f4).
>
> Are you happy for me to adjust this therefore? Assuming you are, I'll
> pass this up for inclusion with the adjusted Fixes tag. Let me know.

Yes, please go ahead and adjust the Fixes tag to point to the initial
Linux Git commit.

Thank you for the detailed review, build and boot testing, and for
passing the patch on for inclusion.

Regards,
Xu Rao

