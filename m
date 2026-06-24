Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1D3A6F1B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288881; cv=none; b=PhNpDUyqni+LhiMUZnEZ0FslE2oS8q+VgbJ6uj1lmQw9r1huVPTZB9qvncJXhUUBJ5oek4/j8rBeO5vmnb31v6KHrft679YE80axt4AOAPp896hCIoNsbpKQgOAvXITsvRBwd3m68zH0G8UBHVjlqfBlMiEXwHlI4W6lYwFoJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288881; c=relaxed/simple;
	bh=SNghCK72DxaazYBg3LIzbKk7npcc3SWRM6RiCnpLKsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CG5ThdTgXPZdwa8aNvd59oMVAucdW1FsR/km2dtFaPz49VhX7JSDfuGFZ2Sa8no9YeQQy8XqxRowy5vw4JAThcO2//PYJLIEnCxygrnwe2Kj0h5bRjkx6D5RX5/XjQmfNuiWiWj4FlegLMvz3INhjn5rI8ZcpLlUWs5uYVUJbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORKPXT4P; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORKPXT4P"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453bcf7276so544220b3a.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782288880; x=1782893680; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCVBXI/svCRCwrJkBXjKTo/5hLmC+RUS/LaBmkHGSvo=;
        b=ORKPXT4PZmivv+u+YWJqxHv6KUf/KK6kbEJNJ9KIksswf9Z2mVQyihHL4H+aY5SKX/
         sl0yQeMC6qcSUiouwnNU6fzgwOnHcSrW/ZloL8uOjrFUqxWahSWfHur2BTPhjy5XPQ6e
         UWM9PLgfis2AKtF5ijLOer6UtYQYFo8BvlvKYUDxWebUDQZ05mjsLoMQSzg3zxTWotYm
         xsw1Mjv/rlhjoM/Ie1yzdX2+aqakzhksKqtDtpUDMeCM1kxHpcj68WUraOTQxook/nDZ
         PjytF3/8CciZJMDBV8JseqsZo2CoxLxlUCtpIx7B415LOUKsG7hwshPqgRlHiBsdhH4I
         dI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782288880; x=1782893680;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCVBXI/svCRCwrJkBXjKTo/5hLmC+RUS/LaBmkHGSvo=;
        b=bKDHquVWDRkhRe4X8RkCiYNGIQ1pBxtPWc6gY0EfJf+1DONR9QgBu9nAaOyK/r2izi
         +wIWlBSn8Dsy0jxXv5g3/VgFFYmeVKwc3xEPeLkPPjxBc68YvitquyJFspNQcIAjQXlz
         J8SS5d5iaxGV87Mt/bcOOB4fe+rmyMdEdndwgOTxs6hTLRe8S3q/BA4+A7AHcbPV0S3L
         fmsxhAMKjf5rP61itE9vF3T5b84jk6sH6s/uns65foWtrV+9KAHP+8/1wzq3y3j9EeJk
         ElNms2EV847+4+QnrvyCqAEJkNVT75u/fYr7+mC1X8TMYRPPJFD0u2Z6ua5w44sNv1QX
         rcqA==
X-Gm-Message-State: AOJu0Yw23njiJnl/BpKNrgnEBWSB+OAK3rbxPjrYbKaD1bHiGEREtcEQ
	B451FarlZyrAMG1OmhG1L9iZ6Q2eymdir/YJYozM0mJmxOh0rOp8nGnYC6nrNxr9tfg=
X-Gm-Gg: AfdE7ck8urYsfa0iJbqLU+43CmPRIWeYZC/aQnqdyGCvk7ISJF26Dd9ZOJk8oS7cTyJ
	6BhK8E7exJHEDRe+OmqiXCt/i2l1R53IeZcwb7J1WVIR4Yk+93TJ9HaT7XzYW2Nibud57asG7xt
	tMthb+DhOJew3+X4lDje8iG240EJO3Depe+pc38SeE6B7+TLzGXl0KLLX/Mt2GiNbMEoY/BADHB
	0UzrZs05klU69PRp8WPdBYgkqkNs0zxFZ1pie/lF7zROuEyT7tqm1WNx2GW20U/OI/T772535cq
	d57F//2gOmAEcD7NVJX98OFNE5ilbO3/9nFHq5NXAUMgXlQgOziNjEiE0f2A1Vh1Vhnz7g1q+6T
	0iKFet50TTOpjgNNKemwVjac7/hboksVsHdfqQAbh0qcC6aZtAbUgEIlElbeFktwX7LDT4ABUtI
	/uumRVOyVRJGcz7dSL18QZai1ZMMXypk01S/BTKiNDGHzo7dATpJkoJS1KNCD9l81dBA==
X-Received: by 2002:a05:6a00:a13:b0:845:363e:12d7 with SMTP id d2e1a72fcca58-845a2a96261mr2903123b3a.6.1782288879700;
        Wed, 24 Jun 2026 01:14:39 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a41474cfsm1426591b3a.61.2026.06.24.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:14:39 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:14:38 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Could the following upstream commits be queued for the active stable
trees?

  commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
  ("ipv6: account for fraggap on the paged allocation path")

  commit eca856950f7cb1a221e02b99d758409f2c5cec42
  ("ipv4: account for fraggap on the paged allocation path")

These fix incorrect fraggap accounting in the paged allocation path.
This can write past skb->end into skb_shared_info when MSG_MORE is 
used together with MSG_SPLICE_PAGES.

Please apply these to 6.1.y, 6.6.y, 6.12.y, 6.18.y, 7.0.y and 7.1.y.

I checked that the IPv6 upstream commit cherry-picks cleanly onto the
following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

I checked that the IPv4 upstream commit cherry-picks cleanly onto the
following stable branches:

linux-7.0.y
linux-6.18.y

The IPv4 commit needs a small context-only backport for:

linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Wongi
