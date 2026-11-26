Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706459;
	b=zzFaMrHNeotR8pTK7WHcJ5A95/zwl+fgwd5hPzUQ313ZoowOWBPHFcD9vULIcKEBrgLk
	 iLrvFPMzBcRMzM/YXeELOUy6/tEmdkE3F5NTNsYTyQIQxT9bNYbUoLl1iij3DBN7Pvf3/
	 nln13DHJqQUVKo/fxT25dcWnVTFEMc2yfMHFzdxk2DjaQUHoZHpcaD1S9uvPIYJAkrkSJ
	 orC1F7QL7tKaIkQvE1WfN+O152sHx//7cxWvCuTZMU8+07r+KgAeli2cQdee2GEoM5ek3
	 g0+HU1oGoy7pbbko53lVeZCF+L3imfBVA5XhPCr9zH3QTweC5zY7dcJGUIVFMGCygBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ayq5vtzWS2oYbGLEO5dP5uVn44ubctqfKqYWVB0qSyE=;
	b=CKqQ135lHLMXhUzsppO4V+x7ToEYWAoXBmqrvaWXhPDvF9q5XdEI5OgA1Qd/+INKONBN
	 gMIKn6rLhYjTlshiMAvWj/fAYUDymwrQ5a1G/u7/zPYAi4uqxjiCJaXEQPfH+/Us1NwZN
	 t6DThPJX52Lp931Q8Lkh8TPqiGgvuxfK6i+FbtGr1pf2N12lJ4NSaCiecJCZH7IPAnDrw
	 oeNzhgbLnDoqn7Ga5CaLopq0YtDGrxPos1voX53eur8aG7GL2nqsXx3VeU62eWIFIEL6U
	 x/erdpl8KQqaiMsAfbwZdcPQ0/Eg7L0NcaSK44UoBKJ5Zm4LDhYl47wrgwTgT59ZwfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9ok+NFl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58069606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9ok+NFl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683451F000C4;
	Thu, 26 Nov 2026 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706458;
	bh=Ayq5vtzWS2oYbGLEO5dP5uVn44ubctqfKqYWVB0qSyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9ok+NFlebQ1h/AAs3gNs+65Yfu32sXIYGkEAbHaelJzKe5tjN1OROOGDKRkLoacX
	 2lDT3RXRHrKSE4o3QffhBw6crY4t4OBgFU11I0Pi0HblTbVAAeuSVaX2GvCuTvKRsD
	 w2oH2P2VFZI+YB9IfjJunR4VjzsOM3H3mLFHA8pPWWwuwIqY+xby3Kwn9xTa8BMclE
	 E2g/28BEeJso8HxLUl1+G9ONcJH5QQCoxX7Irz3R4y6Hge52nu7wbVzuS3yOn8S6M1
	 5lIaA9mlog+zgBDkgMGIT8jzzAFQDlDq5fMjSf2MCtvT5aBbDdVePkj3CU/MKwN8wz
	 +p0QI2bcetL0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: fix misapplied compat_ptr() in tty_compat_ioctl()
Date: Thu, 26 Nov 2026 10:20:57 -0500
Message-ID: <20261126151632.2370124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112515-cardigan-coke-3d3d@gregkh>
References: <2026112515-cardigan-coke-3d3d@gregkh>
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
[ sashal: adapted the ldisc ioctl calls to the older signature that takes an extra file argument, so compat_ptr() is applied to arg while file and cmd pass through unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index af8a45dcf1354..a05f1b44f79b3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2964,8 +2964,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
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

