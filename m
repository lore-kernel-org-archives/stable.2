Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794055576;
	b=PyERNLUo26b4O520fqjK0QNGt80uuaA4KJqnOWwphUSCROEK0XURz3EEaGsPl2NGvUHN
	 FfeqUXF1WrvdEXAyDeRFzF7T/7dm/X0jMPp0g+awOz3ki514qHCv/5xmigWsflfynnGyT
	 zd8sp25Hi4yLmj+xVVkPueKe/VlP5cEdzvZtQeeBcjZbrF3sr1LWXPd//+RC4kNDshur8
	 FeBIIcp0ULYTkWPcOhSwYV7GqRTirQd37NMjXSl0eLUbEh+HdL/soeuRLFR8D36sVqG7o
	 tdjAYYADyUBUfwW+cnRwshVJqMrNI2nVchKpklfOzRJyJ7IvMBpKh3Dsr8/uagoIh6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055576;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L/XKvbpkpGR7sQpSznUFm+MLdPpPXZZjDnN1QBpaAGs=;
	b=GK8CUFZYVhFhmoUZFeQ9cdXTN7v+/MlHeJwjiAZ2BmRSjt/sWc+PBwHX9APswD9Ol6UU
	 dow6uTMgzBi+8U3+cAvTXE80rwzBmitabPVpRNl3yNz9nly8cOfD/b4AO8z0vLXh+mMZb
	 4rg4YsP76hmuWqwNLFkI6TGav1A9HrMPVZC5+ebcX+U8rlgOEyu8TmTY6PbANmlv17Fxg
	 iOgEBnooiEbGd5U07PS2fJ401iTv12fmfV2CHVCovea8x2iPsJ7HXUrUnBHgalcTFeUpC
	 dwdLU13TIP9aRp4ZbAkNZZcLtzMvAewvpA100uaG0JuicZg/7NccFisdAXR2XYDFXtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBWvby4l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED2606A32F;
	Sat,  7 Nov 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBWvby4l
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794055575;
	b=UYhb86Ku8g46M/Z25atNF/rsszIuanu0eHLTXyXgAbJZ+32DhvtfZYdVi/qrTJEtq9xj
	 BepHtvXMIGQeDKXUhB/qkDy9Yk7I9mWYx2+XdQv9UbmiMe50l+SA9HKbtjzeQxJx888uF
	 nfF+y1XX/Gh/+VZU3DkF0VmnQd2+YTKNt0HuUTKlOaPtYdl/qQ905NNXAIHLZLQxXO58G
	 3G4FxRVTiAead2qtEv7IcSX1ccqzikkc39y9my/mUXtp17MYW9A4slhb9AKz8isFETdcW
	 47JklR/Z5aYJxin6lwamRpX/GUEJOdShyTm/XnzkNi3REzvUzLTWOwzI6gaWRxcWEXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055575;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L/XKvbpkpGR7sQpSznUFm+MLdPpPXZZjDnN1QBpaAGs=;
	b=BquxZ4E57ZydWfQzAmSGnevVLpx4QLRjmCPid25zAMXB569IEs+iNXNy2hHo8+JKb0Bh
	 FbtYF6n+RvsKqlB4zS0k85fkw7Wiwi6XDhnJP2WBWOiqMZ3tsyp8sVlCktzApHRKakSsW
	 ljm2mVslTIyH19wUCcesNgwSb24luzBHCua4uaQ8yocLRG5UffWh7upYv2uM9P/ilGL4z
	 1von2VxgjxvoHozhU7SClZZcX5pilIVLFAg8u3fztX/xPtxJna49a48wEZ1fZE5byM4qi
	 bw8Y8WTPoF9phAg2otd2sjMe3MDXEZWF26bOL2SSLuIVK8scJEjE63J9qpCYiCL9p8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B58A1F008AB;
	Sat,  7 Nov 2026 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055575;
	bh=L/XKvbpkpGR7sQpSznUFm+MLdPpPXZZjDnN1QBpaAGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kBWvby4lx8q1tVxb+zo5Bz4CkGcwmezdHhPZDfUZdCCufgYt4TRM47SKC2dvnokgW
	 vqmSavuZC3xT6P7/pXw3SuBb5TpiH7kzSmbkH8DZeqohgUT/xgu8g03WD9DG1VnJ0E
	 0EkCbtdFLgrZNIEFDha2T/o6makC+PyIe3Sq8Q2SlwjyaOVFypoOUcgEhNzH6eE6aT
	 xiwetYZa77VAj9JPxmubCnMhn0ePy+3lyuwH8Wv6Y6/JLqYIYFvScZkLqs5NnS0YkT
	 +Yy7gEGQv6D+aIG3dTlhL/7N6cHq/iqWAP6R4y4I3nrP86NZOD7Qq27Wsm4FYNfHfL
	 eCCsqzxiG/28A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B7D3747BFD;
	Sat,  7 Nov 2026 12:46:14 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:46:14 +0900
Subject: [PATCH v4 2/2] usb: gadget: gadgetfs: prevent ep0 event counter
 underflow
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-b4-gadgetfs-ep0-v4-2-86bdfd684b54@gmail.com>
References: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
In-Reply-To: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794055573; l=2063;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=+R7pwpyKyDxCnPPRXlB7jkosHuS85iniDgK+4vJNesc=;
 b=cxgeirjdlgzE84VOAhhRCp5hr9kj/9l0wpJfacTv7/maoIoMeAIj5GwuFvSPolOg4V30HCKEc
 MXg0P+MHtx5D38SpEP+EI9bUH7p5XLC4opAFZzMt0ZN9Q721gBAQsAl
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
runs directly from dev->event[], and subtracts the snapshot afterwards.
A concurrent disconnect, connect, setup, or another reader can reset,
deduplicate, or consume the queue in that window. This races on
dev->event[], can drop newly arrived GADGETFS_SETUP events, and wraps
dev->ev_next if the queue shrinks below the snapshot.

Dequeue the events into the local buffer and update dev->ev_next before
dropping dev->lock for copy_to_user().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 31fc83427..7e05d5b8c 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1195,25 +1195,19 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 				break;
 			}
 		}
-		spin_unlock_irq (&dev->lock);
-		len = n * sizeof (struct usb_gadgetfs_event);
-		if (copy_to_user (buf, &dev->event, len))
+		len = n * sizeof(struct usb_gadgetfs_event);
+		memcpy(tmp, &dev->event, len);
+		if (dev->ev_next > n) {
+			memmove(&dev->event[0], &dev->event[n],
+				sizeof(struct usb_gadgetfs_event)
+					* (dev->ev_next - n));
+		}
+		dev->ev_next -= n;
+		spin_unlock_irq(&dev->lock);
+		if (copy_to_user(buf, tmp, len))
 			retval = -EFAULT;
 		else
 			retval = len;
-		if (len > 0) {
-			/* NOTE this doesn't guard against broken drivers;
-			 * concurrent ep0 readers may lose events.
-			 */
-			spin_lock_irq (&dev->lock);
-			if (dev->ev_next > n) {
-				memmove(&dev->event[0], &dev->event[n],
-					sizeof (struct usb_gadgetfs_event)
-						* (dev->ev_next - n));
-			}
-			dev->ev_next -= n;
-			spin_unlock_irq (&dev->lock);
-		}
 		return retval;
 	}
 	if (fd->f_flags & O_NONBLOCK) {

-- 
Git-155)


