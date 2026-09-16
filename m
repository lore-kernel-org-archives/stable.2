Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02166442B08
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550198; cv=none; b=BMxH5y5vqv/SRzKhRn6EFHChzXRFL08n9YtktGI9FaKufLKuq9KsT93wTE056SxngH1sMLrSOsf5GsUbzGt+uORuJwcDlL0uate1VrCgRxiLL6DEXCBc54jylhZx2WqMVqLxBtc7lt6oD4ErUiHXBq7GuG69ocmqe70fYFfWgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550198; c=relaxed/simple;
	bh=SuQuRV8SA+qdplXnA6FL2App+wi4dI4LMd+qA79Mo3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EVuvnufkrFRwjYK8CZc+UAiwF6Da8S7cDyr9ZFWtbdWj4mdW5Os2/ACLIqqnmETXva59Wn3Pn+Zx6D7FxjJjUZ8y1E3x9lPMCtCg0m1sSK2NawdtlbM0wnPMGvjfPiClnQFIXyw8mKmzzZB3qwbgg5J3xygv7BZqOACA8XkFW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yH1eWGuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yH1eWGuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DBA1F00898;
	Wed, 16 Sep 2026 09:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550182;
	bh=POG/Qf9YxsWtmeerf9MstgkxzKCYSLOxhjB1amTE74M=;
	h=Subject:To:Cc:From:Date;
	b=yH1eWGuTxqEy9g/rDlbA+RrFVCKN1oT5MM7EwAsGsv3Cvvme7jTeC/qNw2G1is3l+
	 n5dMN5dIiL0nATTK73GIiw4odX7RJwVF6THFIUZPHFT1P1i8U3ba5vB0z4Ng2pRJhg
	 NhuTAey4TE9wa36QXiln7hE1ujU2pihMuLwamCUI=
Subject: FAILED: patch "[PATCH] ALSA: us122l: Prevent write upgrades for read mappings" failed to apply to 5.15-stable tree
To: hnkz.64@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:14:18 +0100
Message-ID: <2026091618-varmint-crusader-6acb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 71c610aeb1770302ac9c9e0b9a4ecd37f1311928
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091618-varmint-crusader-6acb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71c610aeb1770302ac9c9e0b9a4ecd37f1311928 Mon Sep 17 00:00:00 2001
From: Kazuki Hanai <hnkz.64@gmail.com>
Date: Tue, 8 Sep 2026 20:00:53 +0900
Subject: [PATCH] ALSA: us122l: Prevent write upgrades for read mappings

The hwdep mmap callback rejects read-buffer mappings that are initially
writable, but leaves VM_MAYWRITE set on mappings created with PROT_READ.
A process that can open the hwdep node O_RDWR can later use mprotect() to
make the mapping writable.

The read allocation begins with struct usb_stream. Its read_size member is
used by the fault handler to decide which pages belong to the read buffer.
The read VMA intentionally remains expandable because pcm_usb_stream uses
mremap() after reading that size. Changing read_size first can therefore
map and access pages beyond the allocation. The same member is also
consumed by usb_stream_free(), where changing it can make
free_pages_exact() release pages outside the allocation.

Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
writable VMA. This keeps the separate output-buffer mapping writable while
preventing later permission upgrades.

Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Link: https://patch.msgid.link/20260908110053.2950767-1-hnkz.64@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index f00b53346abd..a5db0d044ef9 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -180,8 +180,11 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	guard(mutex)(&us122l->mutex);
 	s = us122l->sk.s;
 	read = offset < s->read_size;
-	if (read && area->vm_flags & VM_WRITE)
-		return -EPERM;
+	if (read) {
+		if (area->vm_flags & VM_WRITE)
+			return -EPERM;
+		vm_flags_clear(area, VM_MAYWRITE);
+	}
 	/* if userspace tries to mmap beyond end of our buffer, fail */
 	if (size > PAGE_ALIGN(read ? s->read_size : s->write_size)) {
 		dev_warn(hw->card->dev, "%s: size %lu > %u\n", __func__,

