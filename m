Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C0378D71;
	Mon, 22 Jun 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127415; cv=none; b=B+ydv2eH0nLpoq9PYT0+E5YbwLzOSw9SMUSySs3Dmdrrwznmy+Ct8rZmsc5sXNBn4GSA4MNPy18kNYNVpX15A7D0XL2Q1zUBdSoJFnwA/DyWEObiem3hXbtjBvIH0Bww+vgHXjDdMnOIFM58ql+44UQkcWhLPp4NKItpBtAqmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127415; c=relaxed/simple;
	bh=kfrgoYA8vhUAFgVVdVpI8lU4f8LOT6aoW8gJoDeO8J4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iMqnExy07ttLvZJMtgLM3DMYvQUzBGqMfxc/cgFTNfZaLoDe+FhKYEg6+0FbGYTQDA1rajtxtBrecbnEalrm3QhpQzDsx21941lAsq7/opf1HTqg1M4gcc2WgJNllVNsxj+1ExSKSrRAOvSZ38JLEU1Mjr0UuXel0zO3zymPAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oBxYTymp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aoULjYDn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oBxYTymp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoULjYDn"
Date: Mon, 22 Jun 2026 11:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782127412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlP+jMQVozUKD3zjK7X1dmHHpOrH+w8Efb9zbbkyI4w=;
	b=oBxYTymp/dru4otfD03g/gnWK+0NgZdQjysYvknev5zkp0OOhoagPNraxXHVfdBKBpinBf
	ZHyCBGNdN6Fms/Ltb9Tgmv7+re66qv6ikHibYt9p53QpnwvVosQjXrS+qQ3XhmHxXrZtdq
	2VmMOFv4mSocXu24kyp704Jgx14MVMbfA0uFnXNYctKd9vTHX1tnB++5CvrFUB6OuKHMD9
	7FzXLEpdEdmeztrDom4ZyswrPDFYMhtvqtw2Nc1xIPweoypj5Ho3SDifyI1EW4zZUO/lPE
	SBqFpHPUtW8x5EMw6LZTAuoy9pw5VYRXlSUXFYp2HvbkcgUrG9LKbng6LOQQYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782127412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlP+jMQVozUKD3zjK7X1dmHHpOrH+w8Efb9zbbkyI4w=;
	b=aoULjYDnOsqCB9vAS1lLtDn7VkUXA856pRsMqidqEohm6CnypFPdVOfsZHKWQud/H0bcqf
	YRW7UjABLYamUeDw==
From: "tip-bot2 for Wang Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time: Fix off-by-one in compat settimeofday()
 usec validation
Cc: Wang Yan <wangyan01@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260622103348.120255-1-wangyan01@kylinos.cn>
References: <20260622103348.120255-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178212741118.2745857.5093449622899775946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     269f2b43fae692d1f3988c9f888a6301aa537b82
Gitweb:        https://git.kernel.org/tip/269f2b43fae692d1f3988c9f888a6301aa5=
37b82
Author:        Wang Yan <wangyan01@kylinos.cn>
AuthorDate:    Mon, 22 Jun 2026 18:33:48 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 22 Jun 2026 13:20:20 +02:00

time: Fix off-by-one in compat settimeofday() usec validation

The compat version of settimeofday() uses '>' instead of '>=3D' when
validating tv_usec against USEC_PER_SEC, allowing the value 1000000 to pass
the check. After the subsequent conversion to nanoseconds (tv_nsec *=3D
NSEC_PER_USEC), this results in tv_nsec =3D=3D NSEC_PER_SEC, which violates t=
he
timespec invariant that tv_nsec must be strictly less than NSEC_PER_SEC.

The native settimeofday() was already fixed in commit ce4abda5e126 ("time:
Fix off-by-one in settimeofday() usec validation"), but the compat
counterpart was missed.

Fix it by using '>=3D' to reject tv_usec values outside the valid range [0,
USEC_PER_SEC - 1].

Fixes: 5e0fb1b57bea ("y2038: time: avoid timespec usage in settimeofday()")
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260622103348.120255-1-wangyan01@kylinos.cn
---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 771cef8..0dd63a9 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -251,7 +251,7 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32=
 __user *, tv,
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
=20
-		if (new_ts.tv_nsec > USEC_PER_SEC || new_ts.tv_nsec < 0)
+		if (new_ts.tv_nsec >=3D USEC_PER_SEC || new_ts.tv_nsec < 0)
 			return -EINVAL;
=20
 		new_ts.tv_nsec *=3D NSEC_PER_USEC;
