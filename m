Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D47140E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323826; cv=none; b=GVYkIyk4K9V662DyD8X3fkzRJAjrbd6uvj0BLeQsaaVUrSfO1JxxYZ0sMBB5V62+c59yDxW362cWBShE9KVgiHekK4kkR4tbl0PL/93AVw8IGmKX52JM993KxLRRFgB3XsNAz3Mc14R5FVlN2kAqvu4Q7Q/aoOl/2Ick6+doseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323826; c=relaxed/simple;
	bh=JyICfV0Q4JF/sz9++YjdeEkeYiBTpG4MllZeFPjsQSE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A3s8j4rJCcsodtW9jX5hqJaHPfWwDWybmhfIG17SyM7j38nu6p84+xnA324xUH2vw1x/u7q785+XOFEFDNvro03riyNofzp3DjBd192Mq3FzSBfbO9az8VfYfJnTsmaDqDMj9crpyCG1E6MSgsOfbUEkc28Jx4PK6npPKfpJutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Zrt5MiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Zrt5MiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C5E1F000E9;
	Wed, 29 Jul 2026 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323825;
	bh=UNwE43IuoCnhewaLHTJlSUKKnZAnkO+rK8OzhktaZDQ=;
	h=Subject:To:Cc:From:Date;
	b=0Zrt5MiVjKORaz8s8dfZvlT0ni2X2hjCdSnLJPVFkQEMJ0ofT9B1IfZwh81K7C1lV
	 Pukcg/H7/OEHlYlJk0fLAs+j8E7lPayTcF+0A1rcA3fiKkppm/f/35MFGnU6aQ3eRE
	 xj278aqiP+0dt5aWTzUpgUHDzow0MtLEntI61REU=
Subject: FAILED: patch "[PATCH] drm/virtio: bound EDID block reads to the response buffer" failed to apply to 5.10-stable tree
To: hexlabsecurity@proton.me,dmitry.osipenko@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:16:43 +0200
Message-ID: <2026072943-outpost-ladle-390c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e1a53892ba7f8a3e1da6bfc53c83ae7c812dccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072943-outpost-ladle-390c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e1a53892ba7f8a3e1da6bfc53c83ae7c812dccd Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Sat, 20 Jun 2026 21:43:34 -0500
Subject: [PATCH] drm/virtio: bound EDID block reads to the response buffer

virtio_get_edid_block() validates the read offset only against the
device-supplied resp->size field, never against the fixed-size resp->edid
array. The EDID block index is driven by the device-supplied extension
count, so a malicious virtio-gpu backend can advertise a large size
together with a high block count and read far past the array into adjacent
kernel memory, which is then surfaced in the parsed EDID (an out-of-bounds
read / info leak).

Also reject any read whose end exceeds the size of the edid array.
Conforming EDID responses stay within the array and are unaffected.

Fixes: b4b01b4995fb ("drm/virtio: add edid support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..c8b9475a7472 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -897,7 +897,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	struct virtio_gpu_resp_edid *resp = data;
 	size_t start = block * EDID_LENGTH;
 
-	if (start + len > le32_to_cpu(resp->size))
+	if (start + len > le32_to_cpu(resp->size) ||
+	    start + len > sizeof(resp->edid))
 		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;

