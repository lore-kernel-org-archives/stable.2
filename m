Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704606;
	b=KagdMmtk4+YPWOriZrlldMPKE3VaeSIQGVJEMcfGyLiqfvpEeOeYmg1F5vfkSRberNd9
	 REEja3sBHvgyPvsdV0kYBprh28trBR4WU77oOZ3vDmPliEO8xodcDgLBqSxELP/OYxIVS
	 XRIrTuUuf3oDqlF+B7Q40CsPZjuwGUnWrynwAIjBwIASictMY7i8czHktzD8BM9vYJd6u
	 88n/xW+Jzar0lja6kNDHrBHHezEQXW3TWjtSGiBOrM5Lfg9+WDrc8bDm/qtqC8Pg6e5RW
	 OxCrZGnAJ3LqGOCIjnlJ8YAtpCzXqs7ayUO3SVR2KM9ziQDltEWSwmt/Nzk4yq94O2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mtHWqNxPJPVZUrb7Fs0RHoJ4I8hsfb3ljGGS+wNd7Ek=;
	b=cg16hlZOnrbYntyu69V9RmDYrvxOTh8TM1XCQXHrRTTHMJIUX1pPnPvU9ohkTTbYXGrk
	 X2uUDGWl5GNXBPpJubogx/ASBlAyT2SnVDbAbW4SSntVQvxE8AzckU5Vn+wb65u0+Yu97
	 eCZH8izOV266IyvGfIq+oavUOIr3LJsksb7mskyLhe3ys4BE8sxVELm9JvMy5c/ctwriT
	 JRR3KPVFMkc5mYATICvC2FjGwDg3pedk26d4urhhHNysq1JeL+6CPvG90cTflBji0F+6I
	 YPLj3lS/lmGMlNEvT9c0GuufaGnSIAKh30t0ZZa8cIJJuO2ryN9Mxmc46d6E4+14M2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEsRhxrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD5606C565;
	Tue,  3 Nov 2026 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEsRhxrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA801F00919;
	Tue,  3 Nov 2026 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704606;
	bh=mtHWqNxPJPVZUrb7Fs0RHoJ4I8hsfb3ljGGS+wNd7Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEsRhxrBujyB9VnTEig97sy/+DAfc+YgaVEgLorM1VZ+3wL9ktFtn6jV3aK8dsKAZ
	 2SE4vL/ZDO1mFVZtFdMlRcN6KwIjU+LnP0r6OdfQJgkK38wf+5r8cxKHHuKYy452Dv
	 0flxRngmkKLZEsyNdbA44AF8Ecb3ErTFc5gTgkkf5idPb1filJeEuqXPSBgZv5mvic
	 9R7QqlwtsXL9ZU8ZOnOUgfjDTRKRh/kMcvBloXJZVo31PQ7LjfmmPjfjvjDhMUhi70
	 NoVFCx6VwYd6Bhj5EKK4ER9t9Mr28kCzZDHJhDSFnV+Eg+3w2reDRP4mz3QbCF2V0t
	 ekGYa9SXbN7EQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] tty: fix misapplied compat_ptr() in tty_compat_ioctl()
Date: Tue,  3 Nov 2026 12:16:39 +0100
Message-ID: <63e9d84a1e8e23852423206cf3f8907aafc88f17.1793704520.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
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
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1a6c8a1bc764..150052f6d9db 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2969,8 +2969,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, cmd, arg);
 	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
-		retval = ld->ops->ioctl(tty, (unsigned long)compat_ptr(cmd),
-				arg);
+		retval = ld->ops->ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
 	tty_ldisc_deref(ld);
 
 	return retval;
-- 
2.56.0

