Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207056;
	b=PNAQ7/23TBPEy8u+7n4ZhiXcgTzqTwoXZ+KfTgWvNxmvG05Tfvv0T9W2jmHX+M4gTeD+
	 HdvI+kjCx7rYX80SbSlktrDEWzrOnBh6CLm4A+kdkPFPepztfDqhYolmIliE/FokxbP1u
	 IQgRxw/YQAwMS22U/M3kETkiTzp3EVzD5DbDeJMJ71ZBK3FfXCp7OeY2zDttEZsovJsBO
	 ZoMXrgVBh6VLm+m08NHoVtA+ae8JSBwqSG1uT0FgB5fink4HOfLyyuv68M5nd+qmImdue
	 brhVrGa2FQHpfQXXqsHkXFMGhRslO4kie04cmysVBpeCRBkNehctQ9FYkEQXOgPX10A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207056;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iLGRjfY6BfcIUbofMHig3TRcPa8NXGbtmdnMh0iGJco=;
	b=fbduerRK49VKms64o6rI4Dcb0wJlZ1N4GsxH45Wy5qJvrExJlpF0XbY57KEHlNbbg08g
	 i4JYnikD/S4YcjR+ln3ny8dgYGoJLcC5/Cdxz25rWcRpSEkMPd9qXU+GtJa7uup95FlBt
	 DiIH9pqOSpMsPVDZohTidDcwIc9AjfkDZcUOHHp7RqVxwZ1eXZN8fqGPfQdRiGWMBQIXT
	 /jk325VlhdFDfmKKbNh/SwL+9LdxB/ILiFW7huLsLaIy5ST49Q3lPLWQWG54b8puGqzRF
	 N/6FkfFq8WU3EPq8vyVo+NorBdlr5XenBuD+dOsRIV1BgGradDHVhIwqDarQnBdpgKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Aj5ti/K3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDA606A31C;
	Mon,  9 Nov 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj5ti/K3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794207055;
	b=0CCvVtnJEV3LO7xludzEpIxOQDUeGW7FfH6GDG8uxzmAR+qHg79HVrCIigyOCJkq9p29
	 MhxmRxpgFylRfBwQarL45qeyAomz3z9SJFBypTEQFdW1UQW9MSPHofr96m/78XKDQYNOV
	 A6OC1ghkQLIuKBPUcIlObYWaBXkKXi9rl9QNnp5e6X3IclFitqGeq4iveYrNfM4fNf4cv
	 +0O96Ei38QK9lX+5bmebWHOoMyp1jU5A/E5f/+DROYQrUxLMj3z14DUKOb0/EUts5y4kQ
	 Z3GhtMbx1r43V9sl/9FNL2Kyrfu76thtH5bplonSVs72YKJsFlTsqitv0onKMtZNcPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794207055;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iLGRjfY6BfcIUbofMHig3TRcPa8NXGbtmdnMh0iGJco=;
	b=ecwK6m8t+Xl+wFmq8RqvaKBZ6VMFaoLDMGfHAVjk8Dgux9OQ5ZMQ11ArMl5WBKjJZPlg
	 +ZqyGqKn5t3P371U8j+BcFiOZHmcozxv4obvGlYdcj4ykiIPP5AeV75KKxamLCeleAnP1
	 i4k9jo0e+E8M90zNtVq4COnCxuNy0JP23UInffJGI4zVlJswT+yU7NUMYh1F99mTY4Edd
	 GHQIVRwT1YU6eIKaZQK13PwXre3GWrVMNOl3EhssJ0o2GyfxfmzNmGZySa9DIp3Plb+/r
	 UYjwp729fd+FF5N2k6904fPY3qpmYmhI3DsC6o3Y+5GC3RMMZDpKSoOFo2VNHUfL8zQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 038981F0089F;
	Mon,  9 Nov 2026 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794207055;
	bh=iLGRjfY6BfcIUbofMHig3TRcPa8NXGbtmdnMh0iGJco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Aj5ti/K3XBJHf3H4cWnZaGiGtVl31e5ORIn79iTG7j15ZkeNwDC6AVCqn/QT2jy+z
	 0YqcfwR2PnLW+TU/0vNy6RLj7sJmtG6d7PO1hMZ4Pol+E28rwVQS/H/+h8qwp9y27h
	 9tgPcIpAn3+zVy7FRBCIyDcIiOj1rySbfWlk2Y0ulwf6wf2f3qEbcfzTeeKuP9Q6zh
	 fjYESoUphboUbxEyc/0YHXs2It5kWYfBsAj/057TVFitffwjdOqO/BM+2D2celp7/b
	 g7dycl1V6YRIZrzTJ2ZXKRNq7XJZqukhvBgpfDeXmBhxa5iR/6laIyrHoFp90E3i+X
	 vuEBFrVBijOtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 869414830A;
	Mon,  9 Nov 2026 06:50:54 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 14:50:52 +0800
Subject: [PATCH v6 2/3] usb: gadget: gadgetfs: prevent ep0 event counter
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
Message-Id: <20261109-b4-gadgetfs-ep0-v6-2-b410e3dced89@gmail.com>
References: <20261109-b4-gadgetfs-ep0-v6-0-b410e3dced89@gmail.com>
In-Reply-To: <20261109-b4-gadgetfs-ep0-v6-0-b410e3dced89@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794207052; l=2063;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=qJqyRAvVJu+nflKNzM3pQLellrP4zWiqHlZjBdga29A=;
 b=HiI/GdoLs3Lzx5sZwk9gEEz4/PvlASCWwFEiZbtoFFIRN+SIpzf92ZMPz2OJbD0BXNyAdLVg2
 lnkwWZmV/2DCMTKN5vWknj+aO4ACBghIlkWnMoLj1Ioff2vbU9g9fiE
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
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
index 1277982f1..d8dfc1897 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1227,25 +1227,19 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
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


