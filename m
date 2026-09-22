Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB13BE652
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061717; cv=none; b=k60j9AvUZCxKwZFemunVXHtMrSmoP+KBgFwS8VK/Wk5yXVO+938wV0DBsMAp2qyCaRqAGvL0/jx8z5OqAc9WjHf5IpMLcDab7n67GrlX3ZwDOzvt1fJnNlrriaLNpBSdCP0TZYXHMCK9xPLO+sA0BKKhFXOg2va2v8qnCoqMoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061717; c=relaxed/simple;
	bh=i6+9O7L6qCQ5h69lNzkhEL6SI6PUQRg+/hzlVyYHi4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6P0fPwY4n8SLry9WRHKw9YXRTpFmUjwuYf3Ao3x3TbaSd5/6+ajpVYk6Ych+Y43iLKREA8fK1wUqpTfNSegoBN3FdSUsd0fr14PTq1iLCxPw0IoCEAH2X14FKL6iAGV1I6R+gGg+AjZ5pW+ya6xk8vCOLGdJtbWLpdmbCKmwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXxezq7D; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXxezq7D"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06a25so26455605ad.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061715; x=1790666515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6+9O7L6qCQ5h69lNzkhEL6SI6PUQRg+/hzlVyYHi4k=;
        b=nXxezq7DlHXVb5KoZzi0tmIHwo2Bf+Y8ato0VOz8qy9skDMmiEecwOgQmPhp+Im29D
         +doTYCFM4rV6asR7nxqIr8EEheKPTYdUymlzx2J4ye+eZ8WzIEMAY99ukOIYTsyGADp0
         52w2+DbM3CRDBBtve0msIj6u8oVGpE7/T5hKbOqbf9LVOReHQwbuiG48EU4AEMAUxHnX
         2bS4tnWbcCPy0l48adNKF+U8ceM91ihZD/fa+Oj45ZkVC6Jsp6o6KlnkPCvVrw9aLamE
         YZBjhflONVdJR7lQ2DQx+PI6cbqgTuP1LEeEgYwE3aGW5FoJbKLMOUj7dQZEsUsYcvY5
         80AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061715; x=1790666515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6+9O7L6qCQ5h69lNzkhEL6SI6PUQRg+/hzlVyYHi4k=;
        b=szSbCKk77VOF6PASBYmpjsZi/8zoDhdvu6ofTzFN57B+CYMf4UMvqeNX/KcHxLAq49
         NPR4C8CUfTwb+ezVwgaIVrX5fG2VSrTabIjuvez21AJbq4caEjURJVEubCkwQ2U+4z8D
         H9RF63MOAkFbcuGGUbFYu9fZOYkOd9h5SwYntwByDyJDD+rrZaKbkUn+c/cBf+vdSjRI
         dMWiWhwoZ82BcdGD5pNccr7ru3Uis57FHD3PdurBQF+T6ruGHOQRSTK6T5qjPHma7rmI
         Y5cRMLMxTx3heQWWup8vlnvDGu9tdT1/yarrLr30z8oiBfYxADSQmEg4Y7GQ+ztc0pXC
         3p1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKWXc3+QT6EBWK8fwvKwd7lvdN+zKayZGl+M3ZBOKLxoYs3e1cqxcfnq1swG3dKFzRQlVSR3I=@vger.kernel.org
X-Gm-Message-State: AFuF++lavDnglSdqBGLiFKA6SKqbAt8Qe3oPMY8ARsxmtS/a8WEiVd2q
	QynYB5NFJuvHtC7oPLHb7YyPQRL4pcjNYSIT6xGMh48Ahh3LEixbGTv0LhoJoh5Kssg=
X-Gm-Gg: AYBFou23ghcdOMt/Lqkq+gDfksuLtSMQFDIdU7Q42XwHtk3p31X6vVAt/B9eo+vJWD1
	8gqD/MRO78b0nHv7/hoU1WFlGBO5uj8EX8LyjiRq3qQyKvvbyvWuD/guMDlXgCy3B8ah80AB2v3
	CrNLR2exEILm/p0nuVBMgWGdci1TWhRRVWd26Sb0UfwklARGU7me79Vfa5++mvQMRZSDOUS5eh9
	XwmUoqaTjTFFkqTXZkhcPWJ30QfmobO0DcdqHY3ik1fWRKG2Zc+ksVp0uEcuApEdRiYfYkMkrfX
	7o2hoiDYsBkrMebpxDUXkqQ1z877rGzv/DYxMv02COhejFh7RDEO4djreXkI22Hh3CLalLoRz16
	uem6LcsrZBHkw0EiSFiVTZs9piVidphPCgE/oW59/m3FELL6aXqemFDlPlhI17xB/q9MGmCajZd
	BAf2ODo/cJmEZfWuLTw+C2xdGF8gts1SSyMrnnoeDpse8AUooW2IjwPjFRyw2Qa2/WLMLV7r8xf
	/tI8fvPeOdM0gNPg64hjvf6f4S6DjsHTOW5jYA=
X-Received: by 2002:a17:902:ec81:b0:2dd:c100:80b2 with SMTP id d9443c01a7336-2df60b61d54mr3177535ad.45.1790061715434;
        Tue, 22 Sep 2026 00:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:b94b:d1b8:4cbd:b7e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d057f55sm4912055ad.73.2026.09.22.00.21.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 00:21:54 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH 1/1] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Tue, 22 Sep 2026 15:21:46 +0800
Message-ID: <20260922072146.34611-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <arD7FHmbqJlLHmyE@macbook.local>
References: <arD7FHmbqJlLHmyE@macbook.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Roger,

Thanks for the review and catching the right origin commit.

You are completely right: commit 11659569f720 ("xen/blkfront: split per device
io_lock") removed the lock protection from the interrupt handler and introduced
the race window.

I have updated the Fixes tag to point to 11659569f720 and added the requested
comment before unbind_from_irqhandler() explaining that interrupt teardown must
precede queue data cleanup.

v2 patch has been sent as reply to this thread.

Thanks,
Yuchao
