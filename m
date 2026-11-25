Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608367;
	b=s4i4M32OsWw3eJYM0V6sIlZ3pZ+lq/bMHXlOdIO7IpE2D8sUgF1wRJfMvMPPH0Ax38Kl
	 UYpPsbCt/D/YnIIDA8aKmn/2MlwFzIa4RyGPQCLRxeBToaYt3rsHjVX/qHnf5kOEhIABx
	 m6zMp+Q2RVMqhmC0V/7tyoU9799Ac/y6zrddVZcLxElTFqvvH6q6j23d5ou1xAOt0vXXm
	 6rJDS7O4V1LecFySDwITaKg3NTky8b0qD9eTlT+UtipEi2BoUXHWc5/np9ipZcBKtGzQW
	 pBHcVCI4a0o5miiIBtZJf6KL/jExvW/eJstv62Evj64hfv99uFsn5NSZoE9OXciUQwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608367;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fEX37cjduUOQou8diWqFv5xzvrR8itjuoWgVoDagOIs=;
	b=noUs+3ctj2uTQvrpYpv/fPKuhKNu5npRS+C7BxhtciLmU6pVnyTT5wzqJSgzApMPT7xd
	 qxlyf/LvqyBxNy3NNMFpUfUVnMQze/9DqCqNRZ66RyGC0bfUu9+8aL6onBRiIWqrqXU4q
	 oSKksIiIczMI+TADCKZ5/yqGfwI7JE1G3IKfp1eXS4OGwbofoKL8ng+84XU11HvZ7zDDz
	 Nx+dJty790/xG2MYcQtbJ5aICKBZCAjSmPsxWk6v+dFSMCDkf3g5SzH3TJFxCBp58x6bd
	 g/0gNAI7iLvqdBTHFjirkM2m06laSIibsVCdPC6JvLXCxSN2x/6kKAveyonlp3dI/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FrrL2GQd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70D606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FrrL2GQd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A771F000E0;
	Wed, 25 Nov 2026 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608367;
	bh=fEX37cjduUOQou8diWqFv5xzvrR8itjuoWgVoDagOIs=;
	h=Subject:To:Cc:From:Date;
	b=FrrL2GQdOS/ILw7SxA0vasBzFx/Hv9mwNhdifbDsuR8MKYwa0jixvR+hpiQNey4Q0
	 ptLRgueqjA2LjZyhXDeweo+To1oDu8TYyKGHR2aNKiEDhAMULIH/dVoi4rReWn5DbE
	 Hy8psUiGFct5QqvWZtAtaQ/68xFpF38YKtWDCYOg=
Subject: FAILED: patch "[PATCH] tty: fix misapplied compat_ptr() in tty_compat_ioctl()" failed to apply to 5.15-stable tree
To: jirislaby@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:33:15 +0100
Message-ID: <2026112515-sinuous-decaf-4d71@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 895dc0eaa2779ff46a0b2a20b5ce9eb0b1125cb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112515-sinuous-decaf-4d71@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 895dc0eaa2779ff46a0b2a20b5ce9eb0b1125cb2 Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Tue, 3 Nov 2026 12:16:39 +0100
Subject: [PATCH] tty: fix misapplied compat_ptr() in tty_compat_ioctl()

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

