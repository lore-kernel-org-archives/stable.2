Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706056;
	b=ba55XFjl4U2YQ44nzHsmrlNR8oiHQyXb0HByWBYt0V0EFHbSpwnW/MwW+DEAQjjd7eOH
	 WWU30OoO45d/yZvP5KNZn+emcHMEumrIuZNH+aK3tfYDcO0jzv6mX7fOiOsi/ZG+A9zqc
	 dsZo//d6aN06L8Vi/oBV1USOTqfUTYw6k6jlUZ3TQ+IRODiBtzUvQSGsJbUvSkotqLDdC
	 hkgyNPrFJUP5S01TXvuUJwcLt46UCaF+Q0LAhkDyn1SKmk5dbbGf2bNYP3zPMdLF1B5ua
	 AE2D0CPFKxg5qpAhy9Yi3lSPkQ0fuypuxwv/WU97NAwz0EguQ+2JsR3nwiA6BKgQtHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vXVjH6AbTflBf54a6iU1m9EXjHHc203s45emm/kuOhg=;
	b=RGA4vY0Z+BWHykkA2Q/8Tp33xUOAy4H4UCpwFqouqs/jLDM7h2xa/msll+JdCEMkLmrC
	 3K3RBGuFOI6kjTCYmEJcUTOSK7C7Ttyt3GmRNKu+IU4ykXcoXpzjN5C/00vuQ7aCKI+q8
	 aCsWRaCfboABGr/HdJXxT3NLObcc/fWSNftcqbrbd0L/CnpyxoxSmpCWq6cejyxw//4Mw
	 RVCWVJPvyCRMCRLzJyPfHvDsYZtpsN6A09FDaxdhjQOAjlrMfEGAo4ieRWowvBKh0CAL0
	 eS0pGkUwnxQ4s4gBWc25eM1/SicmmUkOwyjyBGWk3diqFb4uBeQ3uq+0cC0Fy0PAjVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXZVJqf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD0606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXZVJqf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8442F1F000CF;
	Thu, 26 Nov 2026 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706056;
	bh=vXVjH6AbTflBf54a6iU1m9EXjHHc203s45emm/kuOhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dXZVJqf6yz/GO+psCZfeLcA9qRQV+Hok3Cz6cOTWESMwA2zJ4taLb1HWIOysBJdKa
	 /4GJKPccmQ0Ob5kQ4yn9Y9VaoLLPSFeJKbOJgZ53q4svzu58KoYmiuhgynAHK6MXBP
	 EKVMFyRKSBnYxSXNlhiq5+CI0jFaH/xRL4drbrYV70j9hZQWjcxUEaZNn2qcws3C0d
	 kjumuDaHHIUyCKINt7gnY73TkmBBcgo9OUbGfpYSv2nJU0cImkRVr4J5bROPeZUlAA
	 E6Nfh52aF+VJ3YVYcAwJr/kjrhdbbhEYJWFYhupHcoILdGXJfngQNhXCh4O7GR2Aen
	 WUjdmCzy8gY+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tty: fix misapplied compat_ptr() in tty_compat_ioctl()
Date: Thu, 26 Nov 2026 10:14:14 -0500
Message-ID: <20261126151358.2348156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112515-sinuous-decaf-4d71@gregkh>
References: <2026112515-sinuous-decaf-4d71@gregkh>
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

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 895dc0eaa2779ff46a0b2a20b5ce9eb0b1125cb2 ]

Since commit f0193d3ea73b below, `cmd` was converted with compat_ptr(),
while `arg` was passed to ld->ops->ioctl() unmodified. Fix it so `cmd`
stays `cmd` and `arg` gets converted through compat_ptr() as intended.

Notes:
2) compat_ptr() did nothing to `cmd`, provided it is uint,
1) compat_ptr() is no-op everywhere (was different on s390 before
   8e0b986c59c6 ("s390: Remove compat support")),
3) `arg` might not have been chopped correctly until 8e0b986c59c6. But I
   am not sure why noone noticed all those (7) years (from f0193d3ea73b
   to 8e0b986c59c6)?

Fixes: f0193d3ea73b ("change semantics of ldisc ->compat_ioctl()")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: stable@vger.kernel.org # applicable from 4.20 to 6.18 incl
Assisted-by: LLM
Link: https://patch.msgid.link/63e9d84a1e8e23852423206cf3f8907aafc88f17.1793704520.git.jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Kept the file argument in the ldisc ioctl call, since this tree's hook takes (tty, file, cmd, arg), and applied compat_ptr() to arg instead of cmd. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ce15f9232195b..1f14ca619dee7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2982,8 +2982,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
 	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
-		retval = ld->ops->ioctl(tty, file,
-				(unsigned long)compat_ptr(cmd), arg);
+		retval = ld->ops->ioctl(tty, file, cmd,
+				(unsigned long)compat_ptr(arg));
 	tty_ldisc_deref(ld);
 
 	return retval;
-- 
2.53.0

