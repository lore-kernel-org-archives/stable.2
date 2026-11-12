Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449130;
	b=WBGIcc6blYNRzqhTFEd13DBdQVcBwWufnE7DcZdv9gbGru0S88pITq63PJj4ekZklZYj
	 CoMlOEjQ8vTbyv693f6qVUdDXVuOIZ6PAkAbtd7fVB1CNEFtzTSHNxYGc0M6rfI6ZvDWs
	 tGzmzHzos1pfnr3ZudDfdXG8F3Vf26C5xoB35xzclKnAAu7vOMlQF7KwIHeJS1+1JUfDV
	 JhluXR0PlHXVQ9ZLHyk0U91iBIXmyHNP6RVixHd3PACDrxZ0+L/WKEuSbDYFrxkNP+oQO
	 QCMWLyAeOUqogwQEeq4fRYBxd3IAlxr61xbJps4RyMnqUsdjTEYVA28T17Tz4AYmSxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449130;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=8yb4cPOPQe3+WHkLjqF+ltlf4hBUNAwILg4flb1tCzE=;
	b=J46DSgbW/eJoeD3jUUlvFhSiJ2oKy1+kdIurHhtaTGMVpE3YuMxIeugLn7NdtII0Il+3
	 zqCRvKfowMl+/o6DlZDednnpoRRg6S6WTUtDb8WK8PC19LLsHQqAuUez3pana6U+rSLRS
	 YNRAA7+jsNOy2bwzQuMCGdzPnCNA2zwh3nYHfr9GcbSyNuXyJED0WwnWE/drAYkSA8vYx
	 6ikA4uTtkapVi6+VPUMfITEiprOy0VHC+yqo68RJ0MtlyKa7D1IX4HnFP+e+9+6VJZ0Lb
	 dCSUYMde9wXowEq+FNOyWIVyeV0NPwNJx8VxE+p3j2GAJfztSC36URo1IIXPFNqp9sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AC606A327;
	Thu, 12 Nov 2026 02:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jQ3d033tlz35BR;
	Thu, 12 Nov 2026 10:05:24 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Antti Palosaari <crope@iki.fi>,
	Valery Borovsky <vebohr@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: Re: [PATCH] media: msi2500: return buffers as QUEUED in buf_queue() before start_streaming()
Date: Thu, 12 Nov 2026 10:05:24 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1794400162.6AF45FA1.000.4jPjWQ0vwVz4SJ0Ls@fangwg02>
References: <1793954471.6AED92A4.003.4jLXhN6Cksz4Dr7@fangwg01> <1794400162.6AF45FA1.000.4jPjWQ0vwVz4SJ0Ls@fangwg02>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Thu, 12 Nov 2026 10:05:24 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF51EE4.002 by FangMail milter!
X-FangMail-Envelope: 1794449124/4jQ3d033tlz35BR/6AF51EE4.002/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794449124.6AF51EE4.002
X-FangMail-Outinfo: 1794449124/6AF51EE4.002/4jQ3d033tlz35BR/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794449124.6AF51EE4.002.4jQ3d033tlz35BR@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF51EE4.002/4jQ3d033tlz35BR

On 11/11/2026 20:29, Hans Verkuil wrote:
> On 06/11/2026 09:41, zhangdaolong wrote:
>> diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
>> index 282256ab812a..d89db57f924f 100644
>> --- a/drivers/media/usb/msi2500/msi2500.c
>> +++ b/drivers/media/usb/msi2500/msi2500.c
>> @@ -625,7 +625,9 @@ static void msi2500_buf_queue(struct vb2_buffer *vb)
>>  
>>  	/* Check the device has not disconnected between prep and queuing */
>>  	if (unlikely(!dev->udev)) {
>> -		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
>> +		vb2_buffer_done(&buf->vb.vb2_buf,
>> +				vb2_start_streaming_called(vb->vb2_queue) ?
>> +				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_QUEUED);
>>  		return;
>>  	}
> 
> I think the real problem is that msi2500_buf_queue is calling vb2_buffer_done
> at all.
> 
> What happens if you just remove this 'if' completely?
> 
> I don't think I have seen vb2_buffer_done being called from buf_queue before.
> It's very dubious code.

Hi Hans,

You are right. Removing this 'if' from msi2500_buf_queue() completely works
cleanly and is a much better fix.

This check was originally copied from the pwc driver (commit c20d78cde370
("[media] pwc: Rework locking")), where vb2 operations were briefly called
without holding a queue lock. Once vb_queue_lock was added, the check became
obsolete, and msi2500 doesn't even implement buf_prepare().

With this 'if' removed:
- Normal ioctls (e.g. VIDIOC_QBUF, VIDIOC_STREAMON) check
  video_is_registered() under vb_queue_lock in __video_do_ioctl(), while
  msi2500_disconnect() sets dev->udev = NULL and unregisters the video
  device under the same vb_queue_lock, so they cannot reach buf_queue()
  after disconnect.
- When v4l2_read() races with msi2500_disconnect() before vb2_fop_read()
  acquires vb_queue_lock, msi2500_buf_queue() simply adds the buffers to
  dev->queued_bufs, and msi2500_start_streaming() immediately catches
  !dev->udev, returns all buffers on dev->queued_bufs with
  VB2_BUF_STATE_QUEUED via msi2500_cleanup_queued_bufs(), and fails with
  -ENODEV.

I will send a v2 patch that removes this check from msi2500_buf_queue().

Thanks,
Daolong
