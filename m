Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1C56C63B;
	Thu, 15 Oct 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093011; cv=none; b=vBsaUycaGwqOkRz66ZEOBOzALjrnzlrE/hpRnqv2RvIEXNWIb1r17XLUQRSd0gOzEDtnuqBKXQfv7O6c9zsIrdWIv6XVyTmPKj2rfTHrvaK/To7PPLlhOjSgd4ydUzvIJ+VfR7ryURuH+id8OvXSdtD+H49/+Rfr5t0Q5+NC+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093011; c=relaxed/simple;
	bh=4ENjj2bYjHj7sFuyE9//jVMeZKc0UUmrYtdZ+5RVlEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpDg7R3nvoKKHmLN4qsCMP2DPw8WPDHEvCkqU06Z62daXtfYrT0YKbV7L1PV2RRewlB3gL20XuWSrzbqIbG8pJg3pE/VzGWNzmr97Y8aL163ZlP9LrwZJYQrrLwFf2CatXeqwn33K7CuM6Z8qXhADFmRoOwm7z2tjD1i/wIbwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VouZ6BoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VouZ6BoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D221F000CD;
	Thu, 15 Oct 2026 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093010;
	bh=W1Y2degSRNAyhIkkt7NeJKf9SNBwC9k9gvH+7XOqk5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VouZ6BoKYA2CNoL8QFA7VYi/Rr+nDsk0DC6T/W4RqkkP7/ZRfqrpGiYQ7Fd5aMIVA
	 mQHJkFB5xT8coQLY85jqlESCoC0OFoTf3yN25Yqh/zYOSnCCshbpPdLm3oLphdjOpB
	 acv8ZTd31A+42ueH2FAJ/NLRwsPsRP0sE7NJBoPKy3YeVGkwba5MqdCSjwbu0J34gc
	 2zjQzlQlIXmhP5/iP9WwCh3ZgGLDIlSdWQK0a4paQRXio0O8aw5DjbtppQ0X8aJtiA
	 Y/TQA+TPg8U2+3EfpEUVVkZDmVZw6wSskw8881xpbv1Yy1zd7uLaCpQTWQKKAe1ptm
	 vSHv+PE212kzA==
From: Sasha Levin <sashal@kernel.org>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Artem Dinaburg <artem@trailofbits.com>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y 2/2] wifi: ath12k: copy M3 firmware when reusing the buffer
Date: Thu, 15 Oct 2026 15:36:04 -0400
Message-ID: <2026-10-15-1-daily-reply-0021-ath12k-m3-copy-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bc760367-4896-4626-8f5b-1bc3ef6cba22@oss.qualcomm.com>
References: <20261012165925.32575-1-artem@trailofbits.com> <20261012165925.32575-3-artem@trailofbits.com> <bc760367-4896-4626-8f5b-1bc3ef6cba22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
