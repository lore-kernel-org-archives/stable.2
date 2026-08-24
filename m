Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A626369D76;
	Mon, 24 Aug 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572063; cv=none; b=OsIgUJtAtQW5oMfi/DBUZ28AWztm0kkGMr2kUTFr19mSz7EHvyYrXm0mJ1zhJJLOBzMazKgN2PaeGZqYExAaspuAiD3u0f2pvuPHonw3tBFUPETomP6YSmhOSViWDy8PDu+TU1Wo9RpRxk/lhCqR6apu3MczwQyp1fEcZAYMxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572063; c=relaxed/simple;
	bh=d77stPA0N8qQ4K9cO4r84bkfGkokJmvyv9YthmJ+rQc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6hEMIB9IJ+08iQLCdarFsLiWZ1bWPuqD73mL0CsJmhOQtB8+dNKvdOI/TfM8wIEXYkv18lEczZTstUrEZJAGmTWZInM3LXweAIzWRrr32TdGY/zrZ3OyISr7Dt4Z5o3N7JvhUMP3WA/NaOHiciGjfDl7ZnfXaMl7X8dlIXmiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=gDnqLNPu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="gDnqLNPu"
Received: from DESKTOPU344HCH (unknown [IPV6:240e:399:4b0:1de0:70:261e:3739:fbbd])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b1a0b61a;
	Mon, 24 Aug 2026 19:47:34 +0800 (GMT+08:00)
From: <springbreeze@stu.pku.edu.cn>
To: "'Miguel Ojeda'" <miguel.ojeda.sandonis@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<fujita.tomonori@gmail.com>,
	<ojeda@kernel.org>,
	<boqun@kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<stable@vger.kernel.org>
References: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn> <CANiq72nArSN90SWmPiKxYvnQUxuebJ-W8OiYqXmq2SZEfJnGGg@mail.gmail.com>
In-Reply-To: <CANiq72nArSN90SWmPiKxYvnQUxuebJ-W8OiYqXmq2SZEfJnGGg@mail.gmail.com>
Subject: RE: [PATCH net v2] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Mon, 24 Aug 2026 19:47:33 +0800
Message-ID: <000101dd33be$59ca5ce0$0d5f16a0$@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDCHgjMGBmbYbG7ShyXfJcpGT9QNgHR8R5DuNSwwjA=
Content-Language: zh-cn
X-HM-Tid: 0aa03398e92603a1kunm2e0896b9226ea4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEtOVk8dGE4fS09CHh9DSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0seQUhCQkFPGUtBSh8eS0FMS0FJTUoeQUhMSEJBHRkZH1
	lXWRYaDxIVHRRZQVlPS0hVQkJJTktVSktLVUpCS0JZBg++
DKIM-Signature: a=rsa-sha256;
	b=gDnqLNPuGrkR2sYba9RB8wKQ0JYzoDjMNs3E7m7zdouHafcJA5w1qEKDNFVcH5ESCd0ANRNPypJDsvLqKCpRqNgf5Vc+amWZWi5mPIbGicQrEJ1Ep+X7srZAbnYDrQ1d29Egu4Qe6fW+mR3BijYvWzgSTKr6gN0AxhWsF9iL07E=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=d77stPA0N8qQ4K9cO4r84bkfGkokJmvyv9YthmJ+rQc=;
	h=date:mime-version:subject:message-id:from;

On Mon, Aug 24, 2026 ... Miguel Ojeda wrote:
> Not sure why the cover letter is linked (if there is a good reason,
> please keep it), but at least for the second line above: we don't
> usually link to previous versions within the commit message unless
> there is a good reason.

Agreed, thank you. The v8 cover letter link was meant to point at the =
origin of the hand-written approach, but there is no need for it now =
that the numbers are gone; I have dropped both links from the commit =
message and moved the version changelog after the `---` separator.

I'll send v3 once the 24-hour resend window has passed.

Cheers,
Chunfeng

