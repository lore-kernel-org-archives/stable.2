Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877389;
	b=e0Ve4lYZk+CwQSJt0mGdTHpDLO1+Q42T/Adz/hf6yjMvD1G5yBmqZJNtoPB5Kfp1Kowc
	 ucL0NdiP72ryoteSOAOAbcVoSSyEbcAgiEMOTNRa8p8fImaaqrnTjpSGJgJh0U0RDOYCB
	 lu9V2eHb9urDFR54Hn3jx/eg063xajUUahrwR0kw2zeC4pNvpO+iYLMeIQ5rEAQb6A2aK
	 dt7qRuiirOH8vVyEeAtX9vMJ81zb+zKbRjQBmYmwKBRb2Kpv3DDNy223zLohB3UiptGRn
	 D/+PRYPwaZtjXJd/RKJAeldIf6yINAzdPqUyjF7sWwloT0WWHIcgT6FzGYftQLg5iZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n6N6VMIgzs3P0+VKf0hrP9QN5eTT/WmDhVzml23XD/Y=;
	b=UIAdr0McdTju8KvzLIg/pupztaTEfCjsaZo89agzl5b0nleBI7yoDU6FL6YGMVi9Jtfx
	 spo3CRO/v6qAmTuXn38TRQiPN3P664mQHJX5ZqdENu6EIAl2iqVHhmZpRyPhZmYy2i3aT
	 7IcPQvvaZhJE0G9M3P5GFeL5z9ZFr6Nt7nDxM00uOYuEmUbkr5i3hOTsKmHGCnQyetl3y
	 1buRSe4eqZC8YzhxMQeEo7Lid5AGzptr9XbhIQYD2Z43chltXXgWw/vN/eAHnZJux6OcQ
	 847vwQVtdMeGiuW+J1sQqFd2ppR7KdxOUPldbG79aN67x7p/1MfjK4YgTR8GQBKb+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpGAiFcE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66107606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpGAiFcE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FEF1F000C4;
	Tue, 17 Nov 2026 01:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877389;
	bh=n6N6VMIgzs3P0+VKf0hrP9QN5eTT/WmDhVzml23XD/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpGAiFcEq79ErJz7zEMz3a/XqPiKDgzLKJV3mbqYQJ3WDQDvLVlD0eudjY5byN5GZ
	 0h/HaILWRcCRCUcx56yzcwhkv+1Db8JDkaaGdGAn8Mk1Lj9o5iBh5jfcp2SYVdIE8T
	 zk/FAOwYh/tm29TuF4hsQ8AMcyquZyvRTG9oz8By6y7XGsDNN5Er1Bul0ns5V5Ck9Z
	 NCnqXwEnnK/NO1/1whX2TCGyKyLfWA1Nr4LprLDIZkpy3Zn/1qYZCf8jdTuDHCfmG+
	 A37++JC9DdzM7vduRS7mPVzIlg2v8Umfx6WzLgQnzQA9Z/tf18LxaSPWsamK58Bou5
	 W902CnQYaGdVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 20:02:59 -0500
Message-ID: <2026-11-16-2-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116143254.115307-1-abbotti@mev.co.uk>
References: <20261116143254.115307-1-abbotti@mev.co.uk>
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

> The IRQ number passed via comedi_devconfig->options[1] is a signed int
> that comes from userspace.  The check `it->options[1] <= 7` does not
> reject negative values.

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
